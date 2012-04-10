package hud 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Display extends DisplayGraphic
	{
		private var currentOver:Object;
		private var scrollSpeed:Number = 2;
		private var overCount:Number = 0;
		public function Display() 
		{
			scrollTriggerLeft.addEventListener(MouseEvent.ROLL_OVER, rOver);
			scrollTriggerLeft.addEventListener(MouseEvent.ROLL_OUT, rOut);
			scrollTriggerRight.addEventListener(MouseEvent.ROLL_OVER, rOver);
			scrollTriggerRight.addEventListener(MouseEvent.ROLL_OUT, rOut);
		}
		
		private function rOut(e:MouseEvent):void 
		{
			e.currentTarget.blendMode = 'normal';
			removeEventListener(Event.ENTER_FRAME, frame);
			currentOver = null;
			
			overCount = 0;
		}
		
		private function frame(e:Event):void 
		{
			overCount++;
			scrollSpeed = overCount/30 + 2
			if (currentOver == scrollTriggerLeft)
			{
				PlayState.world.x += scrollSpeed;
				if (PlayState.world.x > PlayState.world.width / 2)
				{
					PlayState.world.x = PlayState.world.width / 2;
				}
				
			}
			else if (currentOver == scrollTriggerRight)
			{
				PlayState.world.x -= scrollSpeed;
				if (PlayState.world.x < -PlayState.world.width / 2 + 650)
				{
					PlayState.world.x = -PlayState.world.width / 2 + 650;
				}
			}
		}
		
		private function rOver(e:MouseEvent):void 
		{
			e.currentTarget.blendMode = 'overlay';
			addEventListener(Event.ENTER_FRAME, frame);
			currentOver = e.currentTarget;
		}
		
	}

}