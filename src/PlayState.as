package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import hud.Display;
	import units.Hero;
	import units.ISelectable;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PlayState extends Sprite 
	{
		/*private var _selectionRectangle:Rectangle = new Rectangle();
		private var _selectionOverlay:Sprite = new Sprite();
		private var _mouseDown:Boolean = false;*/
		
		public static var world:World = new World();
		public static var display:Display = new Display();
		private var _hero:Hero = new Hero();
		public static var selectableUnits:Vector.<ISelectable> = new Vector.<ISelectable>();
		
		public function PlayState() 
		{
			addChild(world);
			world.y = 480;
			world.x = world.width / 2;
			
			addChild(display);
			
			
			world.addChild(_hero);
			selectableUnits.push(_hero);
			
			/*addChild(_selectionOverlay);*/
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			/*stage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mUp);
			stage.addEventListener(Event.ENTER_FRAME, frame);*/
		}
		
		private function frame(e:Event):void 
		{
			/*_selectionOverlay.graphics.clear();
			if (_mouseDown)
			{
				_selectionRectangle.width = stage.mouseX - _selectionRectangle.x;
				_selectionRectangle.height = stage.mouseY - _selectionRectangle.y;
				_selectionOverlay.graphics.lineStyle(1, 0xFFFFFF);
				_selectionOverlay.graphics.beginFill(0xFFFFFF, 0.4);
				_selectionOverlay.graphics.drawRect(_selectionRectangle.x, _selectionRectangle.y, _selectionRectangle.width, _selectionRectangle.height);
				_selectionOverlay.graphics.endFill();
			}*/
		}
		
		/*private function mUp(e:MouseEvent):void 
		{
			_mouseDown = false;
		}*/
		
		/*private function mDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			_selectionRectangle.x = stage.mouseX;
			_selectionRectangle.y = stage.mouseY;
		}*/
		
	}

}