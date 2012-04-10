package units 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Hero extends HeroGraphic implements ISelectable
	{
		
		public function Hero() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}		
	}

}