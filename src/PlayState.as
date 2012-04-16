package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import hud.Display;
	import units.Hero;
	import units.Minion;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PlayState extends Sprite 
	{
		public static var world:World = new World();
		public static var display:Display = new Display();
		private var _hero:Hero = new Hero(true);
		private var _enemyHero:Hero = new Hero(false);
		private var rainList:Vector.<Rain> = new Vector.<Rain>();
		public static var minionList:Vector.<Minion> = new Vector.<Minion>();
		
		public function PlayState() 
		{
			addChild(world);
			world.y = 480;
			world.x = 1500;
			
			addChild(display);
			
			world.addChild(_hero);
			_hero.x = -world.width / 2 + 200;
			_hero.y = -20;
			
			world.addChild(_enemyHero)
			_enemyHero.x = -_hero.x;
			_enemyHero.y = _hero.y;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, frame);
			stage.addEventListener(MouseEvent.CLICK, moveSelectedUnit, false, 999);
			display.addEventListener(MouseEvent.CLICK, moveSelectedUnit, false, 999);
		}
		
		private function moveSelectedUnit(e:MouseEvent):void 
		{
			trace(e.currentTarget, "clicked", e.stageY);
			if (e.currentTarget is Display || e.stageY < 180 )
			{
				_hero.isSelected = false;
				_hero.filters = [];
			}
			if (_hero.isSelected)
			{
				_hero.targetX = world.mouseX;
				_hero.action = "move";
			}
			
		}
		
		private function frame(e:Event):void 
		{
			_hero.frame();
			_enemyHero.frame();
			world.castleAlly.frame();
			world.castleEnemy.frame();
			
			var allyHeroHasAttacked:Boolean = false;
			var enemyHeroHasAttacked:Boolean = false;
			
			var i:int = 0;
			outminion: for (i = 0; i < minionList.length; i++)
			{
				minionList[i].frame();
				var hasAttacked:Boolean = false;
				inminion: for (var q:int = 0; q < minionList.length; q++)
				{
					if (minionList[q].isAlly != minionList[i].isAlly && minionList[q].hitTestObject(minionList[i]))
					{
						minionList[i].attack(minionList[q]);
						hasAttacked = true;
						if (minionList[q].health <= 0)
						{
							/* 
							 * ALERT: This code incorrectly handles minion removal, skipping minionlist[length-1] after swapping if q < i
							 */
							minionList[q].parent.removeChild(minionList[q]);
							minionList[q] = minionList[minionList.length -1];
							minionList.length--;
						}
						break inminion;
					}
				}
				
				if (!hasAttacked)
				{
					if (!minionList[i].isAlly)
					{
						//touches hero
						if (_hero.action != "dead" &&  minionList[i].hitTestObject(_hero))
						{
							if (!allyHeroHasAttacked)
							{
								_hero.attack(minionList[i]);
								if (minionList[i].health <= 0)
								{
									minionList[i].parent.removeChild(minionList[i]);
									minionList[i] = minionList[minionList.length -1];
									minionList.length--;
									i--;
									continue outminion;
								}
								allyHeroHasAttacked = true;
							}
							
							minionList[i].attackHero(_hero);
							hasAttacked = true;
							if (_hero.health <= 0)
							{
								//hero is dead
								_hero.action = "dead";
								_hero.alpha = 0.54;
							}
						}
						//touches castle
						else if (minionList[i].hitTestObject(world.castleAlly))
						{
							minionList[i].attackCastle(world.castleAlly);
							if (world.castleAlly.health <= 0)
							{
								//castle is dead
							}
						}
					}
					else if (minionList[i].isAlly)
					{
						//touches enemyhero
						if(_enemyHero.action != "dead" && minionList[i].hitTestObject(_enemyHero))
						{
							if (!enemyHeroHasAttacked)
							{
								_enemyHero.attack(minionList[i]);
								if (minionList[i].health <= 0)
								{
									minionList[i].parent.removeChild(minionList[i]);
									minionList[i] = minionList[minionList.length -1];
									minionList.length--;
									i--;
									continue outminion;
								}
								enemyHeroHasAttacked = true;
							}
							
							minionList[i].attackHero(_enemyHero);
							hasAttacked = true;
							if (_enemyHero.health <= 0)
							{
								//enemyhero is dead
								_enemyHero.action = "dead";
								_enemyHero.alpha = 0.4;
							}
						}
						//touches enemy castle
						else if (minionList[i].hitTestObject(world.castleEnemy))
						{
							minionList[i].attackCastle(world.castleEnemy);
							if (world.castleEnemy.health <= 0)
							{
								//castle is dead
							}
						}
					}
				}
			}
			
			//hero automatically seeks nearest enemy within 85 pixels if idle
			var closest:Number = 10000;
			var closestIndex:int = 0;
			var temp:Number = -1;
			if (_hero.action == "idle")
			{
				for (i = 0; i < minionList.length; i++)
				{
					if (!minionList[i].isAlly)
					{
						temp=  Math.abs(minionList[i].x - _hero.x);
						if (temp < closest)
						{
							closest = temp;
							closestIndex = i;
						}
					}
				}
				temp = Math.abs(_hero.x - _enemyHero.x);
				if (temp < closest)
				{
					closest = temp;
					closestIndex = -2;
				}
				if (closest < 300)
				{
					if(closestIndex > -1)
						_hero.targetX = minionList[closestIndex].x;
					else if (closestIndex == -2)
						_hero.targetX = _enemyHero.x;
					
					if(closestIndex != -1)
						_hero.action = "move";
				}
			}
			
			
			closest = 100000;
			closestIndex = 0;
			temp = -1;
			if (_enemyHero.action == "idle")
			{
				//enemy hero just waits for nearest enemy within 300 pixels if idle on level 1. Will not directly attack castle
				if (_enemyHero.difficulty == 1)
				{
					for (i = 0; i < minionList.length; i++)
					{
						if (minionList[i].isAlly)
						{
							temp =  Math.abs(minionList[i].x - _enemyHero.x);
							if (temp < closest)
							{
								closest = temp;
								closestIndex = i;
							}
						}
					}
					temp = Math.abs(_enemyHero.x - _hero.x);
					if (temp < closest)
					{
						closest = temp;
						closestIndex = -2;
					}
					if (closest < 300)
					{
						if(closestIndex > -1)
							_enemyHero.targetX = minionList[closestIndex].x;
						else if (closestIndex == -2)
							_enemyHero.targetX = _hero.x;
						
						if(closestIndex != -1)
							_enemyHero.action = "move";
					}
				}
			}
			
			
			
			
			
			makeItRain();
		}
		
		private function makeItRain():void 
		{
			for (var i:int = 0; i < rainList.length; i++)
			{
				rainList[i].frame();
				if (rainList[i].y > 5)
				{
					rainList[i].reset();
				}
				else if (rainList[i].hitTestObject(world.castleAlly))
				{
					world.castleAlly.collectedRain();
					rainList[i].reset();
				}
				else if (rainList[i].hitTestObject(world.castleEnemy))
				{
					world.castleEnemy.collectedRain();
					rainList[i].reset();
				}
			}
			if (rainList.length < 500)
			{
				var r:Rain = new Rain();
				world.addChild(r);
				rainList.push(r);
			}
		}
		
	}

}