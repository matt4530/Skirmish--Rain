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
		private var _enemyHero:Hero = new Hero(true);
		public static var minionList:Vector.<Minion> = new Vector.<Minion>();
		
		public function PlayState() 
		{
			addChild(world);
			world.y = 480;
			world.x = world.width / 2;
			
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
			trace(e.currentTarget, "clicked");
			if (e.currentTarget is Display)
			{
				_hero.isSelected = false;
			}
			if (_hero.isSelected)
			{
				_hero.targetX = world.mouseX;
			}
			
		}
		
		private function frame(e:Event):void 
		{
			_hero.move();
			world.castleAlly.frame();
			world.castleEnemy.frame();
			
			var i:int = 0;
			for (i = 0; i < minionList.length; i++)
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
						if(minionList[i].hitTestObject(_hero))
						{
							minionList[i].attackHero(_hero);
							hasAttacked = true;
							if (_hero.health <= 0)
							{
								//hero is dead
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
						if(minionList[i].hitTestObject(_enemyHero))
						{
							minionList[i].attackHero(_enemyHero);
							hasAttacked = true;
							if (_enemyHero.health <= 0)
							{
								//enemyhero is dead
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
		}
		
	}

}