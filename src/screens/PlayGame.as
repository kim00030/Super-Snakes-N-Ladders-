package screens
{
	import events.GameNotifier;
	
	import interfaces.IState;
	
	import managers.PlayManager;
	
	import objects.Avatar;
	import objects.ExitGameMsg;
	import objects.WinGameMsg;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.GameUtility;
	
	
	public class PlayGame extends Sprite implements IState
	{
		public var game:Game;
		private var _gameUtility:GameUtility;
		private var _gameBoard:GameBoard;
		//private var avatar:Avatar;
		private var playManager:PlayManager;
		private var _gameNotifier:GameNotifier;
		private var winGameMsg:WinGameMsg;
		private var exitGamePromptMsg:ExitGameMsg;
		
		public function PlayGame(pGame:Game)
		{
			super();
			game = pGame;
			_gameUtility = pGame.gameUtility;
			_gameNotifier = pGame.gameNotifier;
			_gameBoard = new GameBoard(_gameUtility,_gameNotifier,readyToPlayGame);
			this.addChild(gameBoard);

		}
		public function set gameBoard(value:GameBoard):void
		{
			_gameBoard = value;
		}
		
		public function get gameBoard():GameBoard
		{
			return _gameBoard;
		}


		public function get gameUtility():GameUtility
		{
			return _gameUtility;
		}

		public function get gameNotifier():GameNotifier
		{
			return _gameNotifier;
		}

	
		public function readyToPlayGame():void
		{
			var arr:Array  = game.playerData.avatars;
			var id:int;	
			var avatarts:Array = new Array();
			
			for(var i:int = 0; i< game.playerData.avatars.length; i++)
			{
				id = game.playerData.getAvatarIdByName(	game.playerData.avatars[i]);
				avatarts.push( new Avatar(gameUtility,gameBoard.tileWidth,gameBoard.tileHeight,id));
			}
			
			playManager = new PlayManager(this,avatarts,gameBoard);
		}
		public function showWinMesage():void
		{
			// create win msg
			winGameMsg = new WinGameMsg(this.gameNotifier,this.gameUtility);
			addChild(winGameMsg);
			winGameMsg.x = gameUtility.currentScreenWidth * .5;
			winGameMsg.y = gameUtility.currentScreenHeight * .5;
			
		}
		public function removeWinGamePanel():void
		{
			if(winGameMsg && this.contains(winGameMsg))
			{
				winGameMsg.destroy();
				removeChild(winGameMsg);
				winGameMsg = null;
			}
			
		}
		
		public function endGame():void
		{
			removeWinGamePanel();
			destroy();
			game.exitGame();
		}
	
		//MessageDisplayManager asks to open exit game prompt
		public function openExitGamePrompt():void
		{
			
			//if exitGamePromptMsg was created previousely and still existed. user can keep clicking back button on device so.. 
			if(exitGamePromptMsg) return;
			
			exitGamePromptMsg = new ExitGameMsg(this);
			addChild(exitGamePromptMsg);
			exitGamePromptMsg.x = gameUtility.currentScreenWidth * .5;
			exitGamePromptMsg.y = gameUtility.currentScreenHeight * .5;
		}
		
		public function destroyExitGamePrompt():void
		{
			if(exitGamePromptMsg && this.contains(exitGamePromptMsg))
			{
				exitGamePromptMsg.clean();
				this.removeChild(exitGamePromptMsg);
				exitGamePromptMsg = null;
			}
		}
		public function backToHomeScreen():void
		{
			game.changeState(GameNotifier.WELCOME_STATE);
		}
		
		public function destroy():void
		{
			if(gameBoard && this.contains(gameBoard))
			{	
				gameBoard.destroy();
				gameBoard.removeFromParent(true);
				gameBoard = null;
			}
			if(playManager)
			{
				playManager.clean();
				playManager = null;
			}
			destroyExitGamePrompt();
			//if(avatar) avatar = null;
			
		
		}
	}
}