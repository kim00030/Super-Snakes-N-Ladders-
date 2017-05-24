package avatarchoosers
{
	import interfaces.IPage;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DeviceAvatarPage extends Sprite implements IPage
	{
		private static const DEVICE_AVATAR:String ="avatar99";
		
		private static const TEXT_COPY_1:String ="textcopy1";
		private static const BACK_BUTTON:String ="backbutton";
		private static const NEXT_BUTTON:String ="nextbutton";
		
		private var deviceAvatar:Image;
		private var textCopy1:Image;
		private var panelW:Number;
		private var panelH:Number;
		private var backButton:Button;
		private var nextButton:Button;
		
		
		private var scale:Number;
		private var avatarChooserNotifier:AvatarChooserNotifier;
		
		public function DeviceAvatarPage(avatarChooserNotifier:AvatarChooserNotifier,scale:Number,panelW:Number,panelH:Number)
		{
			super();
			this.avatarChooserNotifier = avatarChooserNotifier;
			this.scale = scale;
			this.panelW = panelW;
			this.panelH = panelH;
			
			//device avatar
			this.deviceAvatar = new Image(Assets.getAtlas().getTexture(DEVICE_AVATAR));
			this.deviceAvatar.scaleX = this.deviceAvatar.scaleY = scale;
			this.deviceAvatar.x = this.panelW /2 - deviceAvatar.width/2;
			this.deviceAvatar.y = this.panelH * .05;
			addChild(this.deviceAvatar);
			//"Hi I am your device avatar..."
			this.textCopy1 = new Image(Assets.getAtlas2().getTexture(TEXT_COPY_1));
			this.textCopy1.scaleX = this.textCopy1.scaleY = scale;
			this.textCopy1.x = this.panelW /2 - textCopy1.width/2;
			this.textCopy1.y = this.deviceAvatar.y + this.deviceAvatar.height +10;
			addChild(this.textCopy1);
			
			this.backButton = new Button(Assets.getAtlas2().getTexture(BACK_BUTTON));
			this.backButton.scaleX = this.backButton.scaleY = scale;
			this.backButton.x = this.panelW *.5 - this.backButton.width;
			this.backButton.y = this.panelH  - this.backButton.height - 5;
			addChild(this.backButton);
			
			this.nextButton = new Button(Assets.getAtlas2().getTexture(NEXT_BUTTON));
			this.nextButton.scaleX = this.nextButton.scaleY = scale;
			this.nextButton.x = this.panelW  *.5 + 5;
			this.nextButton.y = this.backButton.y
			addChild(this.nextButton);
			
			this.addEventListener(Event.TRIGGERED,onClick);
			
		}
		private function onClick(event:Event):void
		{
		
			var buttonClicked:Button = event.target as Button;
			
			switch(buttonClicked)
			{
				case this.backButton:
					
					this.avatarChooserNotifier.typeOfRequest = AvatarChooserNotifier.REQUESTED_DESTROY_ALL_PAGES;
				break;
					
				case this.nextButton:
					
					this.avatarChooserNotifier.listSelectedAvatars(DEVICE_AVATAR,1);
					this.avatarChooserNotifier.playerNo = 1;
					this.avatarChooserNotifier.typeOfRequest = AvatarChooserNotifier.REQUESTED_OPEN_TO_CHOOSE_AVATAR;
				break;
				
			}
			
		}
		public function show():void
		{
			this.visible = true;
			
		}
		public function hide():void
		{
			this.visible = false;
			
		}
		public function destroy():void
		{
			if(this.deviceAvatar && this.contains(this.deviceAvatar))
			{
				this.removeChild(this.deviceAvatar);
				this.deviceAvatar = null;
			}
			if(this.textCopy1 && this.contains(this.textCopy1))
			{
				this.removeChild(this.textCopy1);
				this.textCopy1 = null;
			}
			
			if(this.backButton && this.contains(this.backButton))
			{
				this.removeChild(this.backButton);
				this.backButton = null;
			}
			if(this.nextButton && this.contains(this.nextButton))
			{
				this.removeChild(this.nextButton);
				this.nextButton = null;
			}
			
			this.removeEventListener(Event.TRIGGERED,onClick);
		}
	}
}