package objects
{
	
	import events.GameNotifier;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	

	
	public class SmallAvatar extends Sprite
	{
		private var iconContainer:Sprite;
		private var textField:TextField;
		private var icon:Image;
		private var gameNotifier:GameNotifier;
		private static const ISTURN:String = "IS TURN";		
		private static const ISWIN:String = "IS WIN";	
		private static const WINNER:String = "WINNER";	
		private static const KOMIKA_AXIS:String = "KomikaAxis";	
		
		
		//----------------------------------------------------------------------------------------
		
		public function SmallAvatar(gameNotifier:GameNotifier)
		{
			super();
			this.gameNotifier = gameNotifier;
			this.iconContainer = new Sprite();
			addChild(iconContainer);
			this.textField = new TextField(200,100,ISTURN,KOMIKA_AXIS,30,0xFFFFFF);//200,100
			this.textField.hAlign = "left";
			this.addChild(this.textField);
			this.gameNotifier.addEventListener(GameNotifier.GAME_COMPLETED, onGameCompleted);
			this.gameNotifier.addEventListener(GameNotifier.REQUESTED_CONTINUE_PLAYING, onContinueGame);
		}
		//----------------------------------------------------------------------------------------
		
		private function onContinueGame():void
		{
			this.textField.text = " "+ISTURN;
		}
		//----------------------------------------------------------------------------------------
		
		private function onGameCompleted():void
		{
			this.textField.text = WINNER;
			
		}
		//----------------------------------------------------------------------------------------
		
		public function get textFieldHeight():Number
		{
			return this.textField.height;
		}
		//----------------------------------------------------------------------------------------

		public function get textFieldWidth():Number
		{
			return this.textField.width;
		}
		//----------------------------------------------------------------------------------------
		public function update(pIcon:Image):void
		{
			icon = pIcon;
			if(this.iconContainer.contains(icon))
			{
				this.iconContainer.removeChild(icon)
			}
			this.iconContainer.addChild(icon);
			this.textField.x = icon.x + icon.width;
		}
		//----------------------------------------------------------------------------------------

		public function clean():void
		{
			if(this.iconContainer && icon && this.iconContainer.contains(icon))
			{
				this.iconContainer.removeChild(icon);
				this.icon = null;
			
				
			}
			
			if(this.iconContainer && textField && this.iconContainer.contains(textField))
			{
				this.iconContainer.removeChild(textField);
				this.textField = null;
			}
			
			this.iconContainer = null;
		}
		//----------------------------------------------------------------------------------------

	}
}
