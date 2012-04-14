package  
{
	import units.Minion;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Castle extends CastleGraphic 
	{
		public var isAlly:Boolean = false;
		private var spawnCount:int = 5999;
		private var spawnCountMax:int = 100;
		public var health:Number = 10000;
		public function Castle(ally:Boolean) 
		{
			isAlly = ally;
			
			if (isAlly)
				spawnCountMax = 20;
		}
		
		public function frame():void
		{
			spawnCount++;
			if (spawnCount > spawnCountMax)
			{
				spawnCount = 0;
				
				var min:Minion = new Minion(isAlly);
				min.x = x;
				min.y = y;
				parent.addChild(min);
				PlayState.minionList.push(min);
			}
		}
		
	}

}