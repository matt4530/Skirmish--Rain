package units 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Hero extends HeroGraphic
	{
		public var isSelected:Boolean = false;
		public var targetX:int = 0;
		public var speed:Number = 5;
		public var isAlly:Boolean = false;
		
		public var health:Number = 1000;
		public var maxHealth:Number = 1000;
		public var action:String = "idle";
		public var attackCoolDown:int = 10;
		public var attackCoolDownMax:int = 10;
		
		public var respawnCount:int = 0;
		public var respawnCountMax:int = 30 * 15; //15 seconds
		public var difficulty:int = 1; //higher = more difficult
		
		public function Hero(ally:Boolean) 
		{
			isAlly = ally;	
			if (!isAlly)
			{
				filters = [new GlowFilter()];
				scaleX = -1;
			}
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if(isAlly)
				addEventListener(MouseEvent.CLICK, selectUnit);
			targetX = x;
		}
		
		private function selectUnit(e:MouseEvent):void 
		{
			if (action == "dead") return;
			
			trace("hero clicked");
			isSelected = true;
			targetX = x;
			e.stopImmediatePropagation();
			action = "move";
			
			if (isAlly)
			{
				filters = [new GlowFilter(0xFFFFFF)];
			}
		}
		
		public function frame():void
		{
			if (action == "move")
			{
				move();
			}
			else if (action == "attack")
			{
				//do nothing
				attackCoolDown--;
				if (attackCoolDown <= 0)
				{
					attackCoolDown = attackCoolDownMax;
					action = "idle";
				}
			}
			else if (action == "idle")
			{
			}
			else if (action == "dead")
			{
				respawnCount++;
				if (respawnCount > respawnCountMax)
				{
					respawnCount = 0;
					action = "idle";
					health = maxHealth;
					alpha = 1;
					trace("Hero respawned");
					if (isAlly)
					{
						x = -1400;
					}
					else
					{
						x = 1400;
					}
				}
			}
		}
		
		public function attack(o:Minion):void
		{
			if (attackCoolDown == attackCoolDownMax)
			{
				o.health -= 150;
			}
			action = "attack";
		}
		
		public function move():void
		{
			if (targetX > x + speed) x += speed;
			else if (targetX < x - speed) x -= speed;
			else
			{
				x = targetX;
				action = "idle";
			}
		}
		
	}

}