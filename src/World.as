package  
{
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class World extends WorldGraphic 
	{
		public var castleAlly:Castle;
		public var castleEnemy:Castle;
		
		public function World() 
		{
			castleAlly = new Castle(true);
			castleAlly.x = -1400;
			castleAlly.y = -24;
			castleEnemy = new Castle(false);
			castleEnemy.x = 1400;
			castleEnemy.y = -24;
			
			addChild(castleAlly);
			addChild(castleEnemy);
		}		
	}

}