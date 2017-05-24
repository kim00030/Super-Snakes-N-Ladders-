package objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import events.GameNotifier;
	
	import flash.data.SQLConnection;
	
	import interfaces.IPrompt;
	
	import managers.SoundManager;
	
	import screens.WelcomeScreen;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import util.GameUtility;
	
	public class GenericGameMsg extends Sprite
	{
		//linkage of components from spritesheet Xml
		//private static const PANEL:String ="panel2";
		
		protected var gameNotifier:GameNotifier;
		protected var gameUtility:GameUtility;
		protected var panel:Image;
		protected var isTweenCompleted:Boolean = false;
		protected var scale:Number;
		private var prompt:IPrompt;
	
	
		public function GenericGameMsg(gameNotifier:GameNotifier,gameUtility:GameUtility, prompt:IPrompt)
		{
			super();
			this.gameNotifier = gameNotifier;
			this.gameUtility = gameUtility;
			this.prompt = prompt;
			scale = this.gameUtility.scaleRatioWithScreenSize();
			initialize();			
			
		}
		
		protected function initialize():void
		{
			
			panel = new Image(Assets.getAtlas2().getTexture(GameUtility.PANEL));
			this.scaleX = this.scaleY = 0;
			panel.scaleX = panel.scaleY = scale;
			//registration pt set to center
			pivotX = panel.width * .5;
			pivotY = panel.height * .5;
			addChild(panel);
			
			this.prompt.initializeComponent();
			
		}
		
		protected function tween():void
		{
		
			
			this.gameNotifier.promptOpened = true;
			TweenLite.to(this, 1, {scaleX:1,scaleY:1, ease:Elastic.easeOut,onStart:startPopUpSFX,onComplete:onTweenComplted});
		}
		private function onTweenComplted():void
		{
			isTweenCompleted = true;
			TweenLite.killTweensOf(this)
			this.prompt.addButtonListner();
			//soundVolumeUpdate(.1);
		}
		private function startPopUpSFX():void
		{
			SoundManager.getInstance().playSound(GameUtility.POPPING_SOUND);
		}
/*		protected function soundVolumeUpdate(volumeValue:Number):void
		{
			if((this.gameNotifier.currentState != GameNotifier.WELCOME_STATE) && (SoundManager.getInstance().soundIsPlaying(GameUtility.BG_SOUND)))
			{
				SoundManager.getInstance().tweenVolume(GameUtility.BG_SOUND,volumeValue);
			}
		}*/

		protected function destroy():void
		{
			if(panel && this.contains(panel))
			{
				this.removeChild(panel);
				panel = null;
			}
			
			this.gameNotifier = null;
			this.gameUtility = null;
			this.prompt = null;
		
		}
	}
}