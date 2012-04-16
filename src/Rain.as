package  
{
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Rain extends RainGraphic
	{
		public var speed:Number = 2;
		public function Rain() 
		{
			reset();
		}
		
		public function frame():void
		{
			y += speed;
			speed += 0.05;
		}
		
		public function reset():void
		{
			y = -500;
			
			//var r:Number = (Math.random()*500+Math.random()*500+Math.random()*500);
			//if(r > 1500) {
			//	r = r-3000;
			//}
			
			
			//x = r;//Math.random() * 3000 - 1500;
			x = Math.random() * 3000 - 1500;
			speed = 2;
		}
	}

}