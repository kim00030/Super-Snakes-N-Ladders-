package managers
{
	import events.GameNotifier;
	
	import interfaces.IState;
	
	import screens.PlayGame;
	
	import starling.display.Image;
	import starling.events.Event;
	
	import util.GameUtility;

	public class MessageDisplayManager
	{
		private var state:IState;
		private var game:Game;
		private var gameNotifier:GameNotifier;
		private var gameUtility:GameUtility;
		
		//-------------------------------------------------------------------------------------------		
		public function MessageDisplayManager(game:Game)
		{
			//this.state = state;
			this.gameNotifier = game.gameNotifier;
			this.gameUtility = game.gameUtility;
			
			this.gameNotifier.addEventListener(GameNotifier.GAME_COMPLETED, onGameCompleted);
			this.gameNotifier.addEventListener(GameNotifier.REQUESTED_END_GAME, onRequestedEndGame);
			this.gameNotifier.addEventListener(GameNotifier.REQUESTED_OPEN_EXIT_MSG, openExitGamePrompt);
			this.gameNotifier.addEventListener(GameNotifier.REQUESTED_DESTROY_EXIT_MSG, destroyExitGamePrompt);
			
		}
		//-------------------------------------------------------------------------------------------
		//function to track current state
		public function setCurrentState(state:IState):void
		{
			this.state = state;
		}
		//-------------------------------------------------------------------------------------------
		/**
		 * 
		 * @param event
		 * call to destroy exitgame prompt
		 */		
		private function destroyExitGamePrompt(event:Event):void
		{
			this.state.destroyExitGamePrompt();
		} 
		//-------------------------------------------------------------------------------------------
		//gameNotifier informs we need to open Exit game prompt
		private function openExitGamePrompt(event:Event):void
		{
			this.state.openExitGamePrompt();
		}
		//-------------------------------------------------------------------------------------------
		/**
		 * 
		 * @param event
		 *call to exit app 
		 */		
		private function onRequestedEndGame(event:Event):void
		{
			this.state.endGame();
			
		}
		//-------------------------------------------------------------------------------------------
		/**
		 * 
		 * @param event
		 * call to show win message when game completes 
		 */		
		private function onGameCompleted(event:Event):void
		{
			(this.state as PlayGame).showWinMesage();
			
		}
		//-------------------------------------------------------------------------------------------
		/**
		 * clean all listeners used in this class
		 * 
		 */		
		public function clean():void
		{
			if(this.gameNotifier)
			{
				this.gameNotifier.removeEventListener(GameNotifier.GAME_COMPLETED, onGameCompleted);
				this.gameNotifier.removeEventListener(GameNotifier.REQUESTED_END_GAME, onRequestedEndGame);
				this.gameNotifier.removeEventListener(GameNotifier.REQUESTED_OPEN_EXIT_MSG, openExitGamePrompt);
				this.gameNotifier.removeEventListener(GameNotifier.REQUESTED_DESTROY_EXIT_MSG, destroyExitGamePrompt);
				this.gameNotifier = null;
			}
		}
		//-------------------------------------------------------------------------------------------
	}
}

