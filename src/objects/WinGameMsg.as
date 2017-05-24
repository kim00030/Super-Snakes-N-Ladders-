package objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import events.GameNotifier;
	
	import managers.SoundManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	
	import util.GameUtility;
	
	
	public class WinGameMsg extends Sprite
	{
		private var gameNotifier:GameNotifier;
		private var gameUtility:GameUtility;
		private var panel:Image;
		private var winAvatarImage:Image
		private var continueButton:Button;
		private var endGameButton:Button;
		private var winTextArt:Image;
		private var star:PDParticleSystem;
		
		//linkage of components from spritesheet Xml
		private static const CONTINUE_BUTTON:String = "continuebutton";
		private static const END_GAME_BUTTON:String = "endgamebutton";
		private static const PANEL:String = "panel";
		private static const WINTEXT_ART:String = "wintext";
		private static const STAR:String = "star";
		
		//-----------------------------------------------------------------------------------------------		
		public function WinGameMsg(gameNotifier:GameNotifier,gameUtility:GameUtility)
		{
			var scale:Number = gameUtility.scaleRatioWithScreenSize();
			
			this.gameNotifier = gameNotifier;
			//prompt is opened
			this.gameNotifier.promptOpened = true;
			this.winAvatarImage = this.gameNotifier.winAvatarImage;

			panel = new Image(Assets.getAtlas2().getTexture(PANEL));
			this.scaleX = this.scaleY = 0;
			panel.scaleX = panel.scaleY = scale;
			//registration pt set to center
			pivotX = panel.width * .5;
			pivotY = panel.height * .5;
			addChild(panel);
			
			//add win avatar image
			winAvatarImage.scaleX = winAvatarImage.scaleY = scale;
			this.winAvatarImage.x = panel.width *.5 - this.winAvatarImage.width *.5;
			this.winAvatarImage.y = panel.height * .1;
			this.addChild(this.winAvatarImage); 
			
			//added win text
			this.winTextArt = new Image(Assets.getAtlas().getTexture(WINTEXT_ART));
			this.winTextArt.scaleX = winTextArt.scaleY = scale;
			this.winTextArt.x = panel.width *.5 - winTextArt.width * .5;
			this.winTextArt.y = this.winAvatarImage.y + this.winAvatarImage.height;
			addChild(this.winTextArt);
			
			this.continueButton = new Button(Assets.getAtlas().getTexture(CONTINUE_BUTTON));
			this.continueButton.scaleX = continueButton.scaleY = scale;
			this.continueButton.x = panel.width *.5 - this.continueButton.width;
			this.continueButton.y = panel.height - this.continueButton.height - 5;
			addChild(continueButton);
			
			this.endGameButton = new Button(Assets.getAtlas().getTexture(END_GAME_BUTTON));
			this.endGameButton.scaleX = endGameButton.scaleY = scale;
			this.endGameButton.x = panel.width *.5 + 5;
			this.endGameButton.y = this.continueButton.y;
			addChild(endGameButton);
			
			TweenLite.to(this, 1, {delay:1,scaleX:1,scaleY:1, ease:Elastic.easeOut,onComplete:onTweenComplted});
		}
		//-----------------------------------------------------------------------------------------------		
		private function onTweenComplted():void
		{
			//SoundManager.getInstance().tweenVolume(GameUtility.BG_SOUND,.1);
			SoundManager.getInstance().playSound(GameUtility.GAME_WIN_SOUND);
			this.addEventListener(Event.TRIGGERED, onClickButton);
			
			startStarAnimation();
		}
		//-----------------------------------------------------------------------------------------------		
		
		private function startStarAnimation():void
		{
			star = new PDParticleSystem(XML(new Assets.StarXML),
				Assets.getAtlas2().getTexture(STAR));
			
			Starling.juggler.add(star);
			star.x = this.winAvatarImage.x;
			star.y = this.winAvatarImage.y;
			this.addChild(star);
			star.start(2.0);
		}
		//-----------------------------------------------------------------------------------------------		
		
		private function onClickButton(event:Event):void
		{
			var buttonClicked:Button = event.target as Button; 
			SoundManager.getInstance().playSound(GameUtility.CLICK_SOUND);
			switch(buttonClicked)
			{
				
				case this.continueButton:

					//SoundManager.getInstance().tweenVolume(GameUtility.BG_SOUND,GameUtility.DEFULT_BG_SOUND_VOLUME);
					this.gameNotifier.update(GameNotifier.REQUESTED_CONTINUE_PLAYING);
					this.gameNotifier.promptOpened = false;
					
				break;
				
				case this.endGameButton:
					
					//this.gameNotifier.update(GameNotifier.REQUESTED_END_GAME);
					this.gameNotifier.update(GameNotifier.REQUESTED_BACK_TO_HOME_SCREEN);
					this.gameNotifier.promptOpened = false;
				break;
			}
			
		}
		//-----------------------------------------------------------------------------------------------		
		
		public function destroy():void
		{
			
			this.removeEventListener(Event.TRIGGERED, onClickButton);
			
			if(panel && this.contains(panel))
			{
				removeChild(panel);
				panel = null;
			}
			
			if(winAvatarImage && this.contains(winAvatarImage))
			{
				removeChild(winAvatarImage);
				winAvatarImage = null;
			}
			
			if(winTextArt && this.contains(winTextArt))
			{
				removeChild(winTextArt);
				winTextArt = null;
			}
			
			if(continueButton && this.contains(continueButton))
			{
				removeChild(continueButton);
				continueButton = null;
			}
			
			if(endGameButton && this.contains(endGameButton))
			{
				removeChild(endGameButton);
				endGameButton = null;
			}
			
			TweenLite.killTweensOf(this);	
		}
		//-----------------------------------------------------------------------------------------------		
		
	}
}
