package units 
{
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Minion extends MinionGraphic
	{
		public var isAlly:Boolean = false;
		public var speed:Number = 4;
		public var health:Number = 100;
		
		public var action:String = "move";
		public var attackCoolDown:int = 10;
		public var attackCoolDownMax:int = 10;
		public var ID:int;
		public function Minion(ally:Boolean) 
		{
			isAlly = ally;	
			if (!isAlly)
			{
				filters = [new GlowFilter()];
				scaleX = -1;
			}
			ID = int(Math.random() * 999);
		}
		
		public function frame():void
		{
			if (action == "move")
			{
				if (isAlly)
					x += speed;
				else
					x -= speed;
			}
			else if (action == "attack")
			{
				//do nothing
				attackCoolDown--;
				if (attackCoolDown <= 0)
				{
					attackCoolDown = attackCoolDownMax;
					action = "move";
					trace(ID, "attack cooled");
				}
			}
		}
		
		public function attack(o:Minion):void
		{
			if (attackCoolDown == attackCoolDownMax)
			{
				o.health -= 5;
				//trace(ID, "attacked for 5 points");
			}
			action = "attack";
		}
		public function attackHero(o:Hero):void
		{
			if (attackCoolDown == attackCoolDownMax)
			{
				o.health -= 5;
				//trace(ID, "attacked for 5 points");
			}
			action = "attack";
		}
		public function attackCastle(o:Castle):void
		{
			if (attackCoolDown == attackCoolDownMax)
			{
				o.health -= 5;
				//trace(ID, "attacked for 5 points");
			}
			action = "attack";
		}
		
	}

}