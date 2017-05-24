package objects
{
	import events.GameNotifier;
	
	import managers.SoundManager;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import util.GameUtility;
	
	public class RoundExitButton extends Button
	{
		private var _gameNotifier:GameNotifier;
		
		public function RoundExitButton(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.addEventListener(Event.TRIGGERED, exitGame);
			
		}

		public function get gameNotifier():GameNotifier
		{
			return _gameNotifier;
		}

		public function set gameNotifier(value:GameNotifier):void
		{
			_gameNotifier = value;
		}

		private function exitGame(event:Event):void
		{
			if(gameNotifier.promptOpened == true) return;
			gameNotifier.update(GameNotifier.REQUESTED_OPEN_EXIT_MSG);
		}
		
		public function clean():void
		{
			this.removeEventListener(Event.TRIGGERED, exitGame);
			gameNotifier = null;
		}
	}
}