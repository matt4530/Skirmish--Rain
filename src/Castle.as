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
		private var spawnCount:int = 100;
		private var spawnCountMax:int = 100;
		public var health:Number = 10000;
		
		
		public var rainCount:int = 0;
		public var maxRainStorage:int = 1000;
		public var difficulty:int = 1;
		public var priceOfMinion:int = 10;
		public function Castle(ally:Boolean) 
		{
			isAlly = ally;
				
			priceOfMinion = difficulty * 10;
		}
		
		public function frame():void
		{
			spawnCount++;
			if (spawnCount > spawnCountMax && rainCount >= priceOfMinion)
			{
				spawnCount = 0;
				rainCount -= priceOfMinion;
				
				var min:Minion = new Minion(isAlly);
				min.x = x;
				min.y = y;
				parent.addChild(min);
				PlayState.minionList.push(min);
			}
		}
		
		public function collectedRain():void
		{
			rainCount++;
			if (rainCount > maxRainStorage) rainCount = maxRainStorage;
		}
		
	}

}