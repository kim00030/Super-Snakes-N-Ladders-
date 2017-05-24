package managers
{
	import events.GameNotifier;

	public class LevelManager
	{
		private var _currentLevel:int;
		private var gameNotifier:GameNotifier;
		private var bombNum:int;
		private var _shieldNum:int;
		
		//-------------------------------------------------------------------------------------------
		public function LevelManager(PGameNotifier:GameNotifier)
		{
			gameNotifier = PGameNotifier;
			currentLevel =0;
			
		}
		
		//-------------------------------------------------------------------------------------------
		public function get shieldNum():int
		{
			return _shieldNum;
		}
		//-------------------------------------------------------------------------------------------
		public function set shieldNum(value:int):void
		{
			_shieldNum = value;
		}
		//-------------------------------------------------------------------------------------------
		public function get currentLevel():int
		{
			return _currentLevel;
		}
		//-------------------------------------------------------------------------------------------
		public function set currentLevel(value:int):void
		{
			_currentLevel = value;
		}
		//-------------------------------------------------------------------------------------------
		public function updateLevel():void
		{
			if(gameNotifier.winnerAvatarId != GameNotifier.DEVICE_AVATAR_ID)
			{
				currentLevel++;
			}
		}
		//-------------------------------------------------------------------------------------------		
		public function generateNumberofBombsByLebel():int
		{
			switch(currentLevel)
			{
				case 0:
				case 1:
					bombNum = 5;
					shieldNum = 5;
				break;
				
				case 2:
					bombNum = 10;
					shieldNum = 5;
				break;
				
				case 3:
					bombNum = 12;
					shieldNum = 4;
				break;	
				
				case 4:
					bombNum = 14;
					shieldNum = 4;
					break;	
				case 5:
					bombNum = 14;
					shieldNum = 3;
					break;	
				default:
					bombNum = 15;
					shieldNum = 2;
					break;	
			}
			
			return bombNum;
		}
	}
}