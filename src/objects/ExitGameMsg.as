package objects
{
	import events.GameNotifier;
	
	import flash.data.SQLStatement;
	
	import interfaces.IPrompt;
	import interfaces.IState;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	import util.GameUtility;
	
	public class ExitGameMsg extends GenericGameMsg implements IPrompt
	{
		private static const YES_BUTTON:String ="yesbutton";
		private static const NO_BUTTON:String ="nobutton";
		private static const ARE_YOU_SURE:String ="areyousure";
		
		private var textArt:Image;
		private var yesButton:Button;
		private var noButton:Button;

		
		public function ExitGameMsg(state:IState)
		{
			super(state.gameNotifier, state.gameUtility,this);
			
		}
		
		public function initializeComponent():void
		{
			
			//added win text
			this.textArt = new Image(Assets.getAtlas2().getTexture(ARE_YOU_SURE));
			this.textArt.scaleX = this.textArt.scaleY = scale;
			this.textArt.x = panel.width *.5 - 	this.textArt.width * .5;
			this.textArt.y = panel.height * .2;
			addChild(this.textArt);
			
			
			this.yesButton = new Button(Assets.getAtlas().getTexture(YES_BUTTON));
			this.yesButton.scaleX = yesButton.scaleY = scale;
			this.yesButton.x = panel.width *.5 - this.yesButton.width;
			this.yesButton.y = panel.height - this.yesButton.height - 5;
			addChild(this.yesButton);
			
			this.noButton = new Button(Assets.getAtlas().getTexture(NO_BUTTON));
			this.noButton.scaleX = noButton.scaleY = scale;
			this.noButton.x = panel.width *.5 + 5;
			this.noButton.y = this.yesButton.y;
			addChild(noButton);
			
			tween();
		}
		
		public function addButtonListner():void
		{
			this.addEventListener(Event.TRIGGERED, onClickButton);
		}
		private function onClickButton(event:Event):void
		{
			
			this.removeEventListener(Event.TRIGGERED, onClickButton);
			var buttonClicked:Button = event.target as Button; 
			
			switch(buttonClicked)
			{
				case this.yesButton:
					gameNotifier.update(GameNotifier.REQUESTED_END_GAME);
					
					break;
				
				case this.noButton:
					gameNotifier.promptOpened = false;
				//	soundVolumeUpdate(GameUtility.DEFULT_BG_SOUND_VOLUME);
					gameNotifier.update(GameNotifier.REQUESTED_DESTROY_EXIT_MSG);
					break;				
			}
		}
		
		
		public function clean():void
		{
			if(this.textArt && this.contains(this.textArt))
			{
				removeChild(this.textArt);
				this.textArt = null;
			}
			if(this.yesButton && this.contains(this.yesButton))
			{
				removeChild(this.yesButton);
				this.yesButton = null;
			}
			if(this.noButton && this.contains(this.noButton))
			{
				removeChild(this.noButton);
				this.noButton = null;
			}
			
			destroy();
		}

	}
}