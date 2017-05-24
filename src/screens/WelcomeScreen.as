package screens
{
	import avatarchoosers.AvatarChooseManager;
	import avatarchoosers.AvatarChooserNotifier;
	
	import events.GameNotifier;
	
	import interfaces.IState;
	
	import managers.SoundManager;
	
	import objects.ExitGameMsg;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.GameUtility;
	

	public class WelcomeScreen extends Sprite implements IState
	{
		private var bg:Image;
		private var _gameUtility:GameUtility;
		private var _gameNotifier:GameNotifier;
		private var _game:Game;
		
		private var playBtnWithDevice:Button;
		private var twoPlayersButton:Button;
		private var exitButton:Button;
		
		private var avatarChooserNotifier:AvatarChooserNotifier;
		private var avatarChooserManager:AvatarChooseManager;
		public var avatarChooserContainer:Sprite;
		
		private var exitGamePromptMsg:ExitGameMsg;
		
		public function WelcomeScreen(pGame:Game)
		{
			super();
			_game = pGame;
			_gameUtility = pGame.gameUtility;
			_gameNotifier = pGame.gameNotifier;
			
			//to handle avatar choosing process
			avatarChooserNotifier = new AvatarChooserNotifier();
			avatarChooserManager = new AvatarChooseManager(this,avatarChooserNotifier);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedStage);
		}
		
		public function get game():Game
		{
			return _game;
		}

		public function set game(value:Game):void
		{
			_game = value;
		}

		private function onAddedStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedStage);
			
			// I don't want to play bg sound in welcomescreen
/*			if(SoundManager.getInstance().soundIsPlaying(GameUtility.BG_SOUND))
			{
				SoundManager.getInstance().stopSound(GameUtility.BG_SOUND);
			}*/
			
			//BG
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			this.addChild(bg);
			//get scale ratio
			var scale:Number = _gameUtility.scaleRatioWithScreenSize(stage.stageWidth,stage.stageHeight);
			
			playBtnWithDevice = new Button(Assets.getAtlas2().getTexture("playwithdevicebutton"));
			playBtnWithDevice.scaleX = playBtnWithDevice.scaleY = scale;
			playBtnWithDevice.x = this.bg.width * .66;
			playBtnWithDevice.y = this.bg.height * .4;
			this.addChild(playBtnWithDevice);
			
			twoPlayersButton = new Button(Assets.getAtlas2().getTexture("twoplayersbutton"));
			twoPlayersButton.scaleX = twoPlayersButton.scaleY = scale;
			twoPlayersButton.x = playBtnWithDevice.x;
			twoPlayersButton.y = playBtnWithDevice.y +playBtnWithDevice.height*1.5;
			this.addChild(twoPlayersButton);
				
			exitButton = new Button(Assets.getAtlas2().getTexture("exitbutton"));
			exitButton.scaleX = exitButton.scaleY = scale;
			exitButton.x = playBtnWithDevice.x;
			exitButton.y = twoPlayersButton.y + twoPlayersButton.height *1.5;
			this.addChild(exitButton);
			
			this.addEventListener(Event.TRIGGERED, playGame);
			
			//create container to hold avatar chooser process objects
			if(!avatarChooserContainer)
			{
				avatarChooserContainer = new Sprite();
				this.addChild(avatarChooserContainer);
			}
			
		}
		/**
		 *Button trigger 
		 * @param event
		 * 
		 */		
		private function playGame(event:Event):void
		{
			//if avatarChooserNotifier or gameNotifier notifies any prompt opens,
			//i don't want to execute
			if(avatarChooserNotifier.promptOpened == true||gameNotifier.promptOpened == true) return;
			
			SoundManager.getInstance().playSound(GameUtility.CLICK_SOUND);
			var buttonClicked:Button = event.target as Button;  
			switch(buttonClicked)
			{
				
				case playBtnWithDevice:
					//To start process for choosing avatar
					avatarChooserNotifier.typeOfPlay = AvatarChooserNotifier.PLAY_WITH_DEVICE;
				break;
				
				case twoPlayersButton:
					avatarChooserNotifier.typeOfPlay = AvatarChooserNotifier.PLAY_WITH_TWO_PLAYERS;
					break;
				
				case exitButton:
					openExitGamePrompt();
					break;
					
			}

		}
		public function get gameUtility():GameUtility
		{
			return _gameUtility;
		}
		
		public function get gameNotifier():GameNotifier
		{
			return _gameNotifier;
		}
	
	
		public function endGame():void
		{
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
		/**
		 *Destroy exit game prompt 
		 * 
		 */		
		public function destroyExitGamePrompt():void
		{
			if(exitGamePromptMsg && this.contains(exitGamePromptMsg))
			{
				exitGamePromptMsg.clean();
				this.removeChild(exitGamePromptMsg);
				exitGamePromptMsg = null;
			}
		}
		public function destroy():void
		{
			bg.removeFromParent(true);
			bg = null;
			
			playBtnWithDevice.removeFromParent(true);
			playBtnWithDevice = null;
			
			twoPlayersButton.removeFromParent(true);
			twoPlayersButton = null;
			
			exitButton.removeFromParent(true);
			exitButton = null;
			
			if(this.hasEventListener(Event.TRIGGERED))
				this.removeEventListener(Event.TRIGGERED, playGame);
			
			if(avatarChooserContainer && this.contains(avatarChooserContainer))
			{
				this.removeChild(avatarChooserContainer);
				avatarChooserContainer = null;
			}
			
			destroyExitGamePrompt();
		}
		
	}
}