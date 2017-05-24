package avatarchoosers
{
	import events.GameNotifier;
	
	import flash.events.Event;
	
	import interfaces.IAvatarChooser;
	
	import screens.WelcomeScreen;
	
	import starling.display.Sprite;

	public class AvatarChooseManager
	{
		private var welcomeScreen:WelcomeScreen;
		private var avatarChooserNotifier:AvatarChooserNotifier;
		
		private var avatarChooser:IAvatarChooser;
		
		public function AvatarChooseManager(pWelcomeScreen:WelcomeScreen,pAvatarChooserNotifier:AvatarChooserNotifier)
		{
			welcomeScreen = pWelcomeScreen;
			avatarChooserNotifier = pAvatarChooserNotifier;
			
			this.avatarChooserNotifier.addEventListener(AvatarChooserNotifier.CHANGE, onChange);
			this.avatarChooserNotifier.addEventListener(AvatarChooserNotifier.REQUESTED_DESTROY_ALL_PAGES,destroyAllPages);
			this.avatarChooserNotifier.addEventListener(AvatarChooserNotifier.REQUETED_DONE_SELECTED_AVATARS_PROCES,doneProcess);
		}
		
		private function doneProcess():void
		{
			destroyAllPages();
			var selectedAvatars:Array = this.avatarChooserNotifier.selectedAvatars;
			welcomeScreen.game.playerData.avatars = selectedAvatars;
			welcomeScreen.game.changeState(GameNotifier.PLAY_GAME);
			
		
		}		

		
		private function destroyAllPages():void
		{
			if(welcomeScreen.avatarChooserContainer && welcomeScreen.avatarChooserContainer.contains(Sprite(avatarChooser)))
			{
				(avatarChooser as IAvatarChooser).destroy();
				welcomeScreen.avatarChooserContainer.removeChild(Sprite(avatarChooser));
				avatarChooserNotifier.promptOpened = false;
				avatarChooser = null;
			}
			
		}
		/**
		 * listen from dispatch event fired by AvatarChhserNotifier
		 * 
		 */		
		private function onChange():void
		{
			
			switch(avatarChooserNotifier.typeOfPlay)
			{
				case AvatarChooserNotifier.PLAY_WITH_DEVICE:
					avatarChooser = new AvatarChooserOptionOne(welcomeScreen.gameUtility,avatarChooserNotifier);
				break;
				
				case AvatarChooserNotifier.PLAY_WITH_TWO_PLAYERS:
					avatarChooser = new AvatarChooserOptionTwo(welcomeScreen.gameUtility,avatarChooserNotifier);

				break;	
			}
			//show it on welcomeScreen
			welcomeScreen.avatarChooserContainer.addChild(Sprite(avatarChooser));
			Sprite(avatarChooser).x = welcomeScreen.gameUtility.currentScreenWidth * .5;
			Sprite(avatarChooser).y = welcomeScreen.gameUtility.currentScreenHeight * .5;

		}		
		
	}
}