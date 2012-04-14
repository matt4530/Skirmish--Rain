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
		
		public function Hero(ally:Boolean) 
		{
			isAlly = ally;	
			if (!isAlly)
			{
				filters = [new GlowFilter()];
			}
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.CLICK, selectUnit);
			targetX = x;
		}
		
		private function selectUnit(e:MouseEvent):void 
		{
			trace("hero clicked");
			isSelected = true;
			targetX = x;
			e.stopImmediatePropagation();
		}
		
		public function move():void
		{
			if (targetX > x + speed) x += speed;
			else if (targetX < x - speed) x -= speed;
			else x = targetX;
		}
		
	}

}