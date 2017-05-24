package
{
	import data.PlayerData;
	
	import events.GameNotifier;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import interfaces.IState;
	
	import managers.MessageDisplayManager;
	import managers.SoundManager;
	
	import screens.PlayGame;
	import screens.WelcomeScreen;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	
	import util.GameUtility;
	
	public class Game extends Sprite
	{
		public var gameUtility:GameUtility;
		public var gameNotifier:GameNotifier;		
		private var welcomeScreen:WelcomeScreen;
		
		private var current_state:IState;
		private var messageDisplayManager:MessageDisplayManager;
		private var _playerData:PlayerData;
		
		//-------------------------------------------------------------------------------------------
		public function Game()
		{
			super();
			Assets.init();
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
		}
		//-------------------------------------------------------------------------------------------
		public function get playerData():PlayerData
		{
			return _playerData;
		}
		//-------------------------------------------------------------------------------------------
		private function onAddedStage(event:Event):void
		{
			trace("Starling initialzied");
			// to dectect button on device
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			
			gameNotifier = new GameNotifier();
			gameUtility = new GameUtility(stage.stageWidth,stage.stageHeight);
			messageDisplayManager = new MessageDisplayManager(this);
			_playerData = new PlayerData();
		
			//first screen , by default
			changeState(GameNotifier.WELCOME_STATE);

		}
		
		//-------------------------------------------------------------------------------------------
		public function changeState(state:int):void
		{
			if(current_state != null)
			{
				current_state.destroy();
				current_state = null;
				
				if(gameNotifier)
				{
					gameNotifier = null;
					gameNotifier = new GameNotifier();
				}
				
				if(messageDisplayManager)
				{
					messageDisplayManager.clean();
					messageDisplayManager = null;
					messageDisplayManager = new MessageDisplayManager(this);
				}
			}
			switch(state)
			{
				case GameNotifier.WELCOME_STATE:
					current_state = new WelcomeScreen(this);
					//gameNotifier.currentState = GameNotifier.WELCOME_STATE;
					break;
				
				case GameNotifier.PLAY_GAME:
					current_state = new PlayGame(this);
					//gameNotifier.currentState = GameNotifier.PLAY_GAME;
					break;
				
			}
			//set current state in messageDisplayManager to handle message in any screen
			messageDisplayManager.setCurrentState(current_state);
			gameNotifier.currentState = state;
			addChild(Sprite(current_state));
		}
		//-------------------------------------------------------------------------------------------
		//To exit game
		public function exitGame():void
		{
			SoundManager.getInstance().stopAllSounds();
			SoundManager.getInstance().dispose();
			NativeApplication.nativeApplication.exit();
			
		}
		//-------------------------------------------------------------------------------------------
		//Handler to exit app 
		private function handleKeys(event:KeyboardEvent):void
		{
			//prevent to exit the app immedietely. we need  to display prompt
			event.preventDefault();
			event.stopImmediatePropagation();
			//update game notifier to ask open exit message
			gameNotifier.update(GameNotifier.REQUESTED_OPEN_EXIT_MSG);
			
		}
		//-------------------------------------------------------------------------------------------
	}
}