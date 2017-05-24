package avatarchoosers
{
	import flash.utils.Dictionary;
	
	import interfaces.IPage;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.GameUtility;
	
	public class UserAvatarOneInOptionTwoPage extends Sprite implements IPage
	{
		private static const BACK_BUTTON:String ="backbutton";
		private static const NEXT_BUTTON:String ="nextbutton";
		private static const DONE_BUTTON:String ="donebutton";
		private static const PLAYER_1:String ="player_1";
		private static const PLAYER_2:String ="player_2";
		private static const QUESTION_ICON:String ="questionicon";
		private static const TEXT_COPY_2:String ="textcopy2";
		private static const TEXT_COPY_3:String ="textcopy3";
		
		private var scale:Number;
		private var panelW:Number;
		private var panelH:Number;
		private var playerNo:String;
		private var backButton:Button;
		private var nextButton:Button;
		private var doneButton:Button;
		private var questionIcon:Image;
		private var textCopy:Image;
		
		public var avatar1Button:Button;
		public var avatar2Button:Button;
		public var avatar3Button:Button;
		private var selectedAvatarHolder:Sprite;
		private var avatarInSelectedAvatarHolder:Image;
		
		private var avatarChooserNotifier:AvatarChooserNotifier;
		
		private var _page2:UserAvatarTwoInOptionTwoPage;
		
		
		public function UserAvatarOneInOptionTwoPage(avatarChooserNotifier:AvatarChooserNotifier,scale:Number,
													   panelW:Number,panelH:Number)
		{
			super();
			this.avatarChooserNotifier = avatarChooserNotifier;
			this.scale = scale;
			this.panelW = panelW;
			this.panelH = panelH;
			//this.playerNo = playerNo;
			
			this.questionIcon = new Image(Assets.getAtlas2().getTexture(QUESTION_ICON));
			this.questionIcon.scaleX = this.questionIcon.scaleY = scale;
			this.questionIcon.x = this.panelW /2 - questionIcon.width/2;
			this.questionIcon.y = this.panelH * .05;
			addChild(this.questionIcon);
			
			if(selectedAvatarHolder) selectedAvatarHolder = null;
			selectedAvatarHolder = new Sprite();
			selectedAvatarHolder.x = this.questionIcon.x;
			selectedAvatarHolder.y = this.questionIcon.y;
			addChild(selectedAvatarHolder);
			
			
			this.backButton = new Button(Assets.getAtlas2().getTexture(BACK_BUTTON));
			this.backButton.scaleX = this.backButton.scaleY = scale;
			this.backButton.x = this.panelW *.5 - this.backButton.width;
			this.backButton.y = this.panelH  - this.backButton.height - 5;
			addChild(this.backButton);
			
			this.nextButton = new Button(Assets.getAtlas2().getTexture(NEXT_BUTTON));
			this.nextButton.scaleX = this.nextButton.scaleY = scale;
			this.nextButton.x = this.panelW  *.5 + 5;
			this.nextButton.y = this.backButton.y;
			this.nextButton.alpha = .4;
			this.nextButton.enabled = false;
			addChild(this.nextButton);
			
			
			//add text copy "Choose player 1"
			var textCopyLinkage:String; 
			textCopyLinkage = TEXT_COPY_2;
			
			textCopy = new Image(Assets.getAtlas2().getTexture(textCopyLinkage));
			textCopy.scaleX = textCopy.scaleY = scale;
			textCopy.x = this.panelW /2 - textCopy.width/2;
			textCopy.y = this.questionIcon.y + this.questionIcon.height; 
			addChild(textCopy);
			
			avatar1Button = new Button(Assets.getAtlas().getTexture(GameUtility.AVATAR_1));
			avatar1Button.name = GameUtility.AVATAR_1;
			avatar1Button.scaleX = avatar1Button.scaleY = scale;
			avatar1Button.x = this.backButton.x;
			avatar1Button.y = (this.textCopy.y + this.textCopy.height) - (this.textCopy.y + this.textCopy.height)*.04 ;
			addChild(avatar1Button);
			
			avatar2Button = new Button(Assets.getAtlas().getTexture(GameUtility.AVATAR_2));
			avatar2Button.name = GameUtility.AVATAR_2;
			avatar2Button.scaleX = avatar2Button.scaleY = scale;
			avatar2Button.x = this.panelW /2 - questionIcon.width/2;
			avatar2Button.y = avatar1Button.y;
			addChild(avatar2Button);
			
			avatar3Button = new Button(Assets.getAtlas().getTexture(GameUtility.AVATAR_3));
			avatar3Button.name = GameUtility.AVATAR_3;
			avatar3Button.scaleX = avatar3Button.scaleY = scale;
			avatar3Button.x = avatar2Button.x + avatar2Button.width +5;
			avatar3Button.y = avatar1Button.y;
			addChild(avatar3Button);
			
			this.addEventListener(Event.TRIGGERED,onClick);
		}

		public function get page2():UserAvatarTwoInOptionTwoPage
		{
			return _page2;
		}

		public function set page2(value:UserAvatarTwoInOptionTwoPage):void
		{
			_page2 = value;
		}

		private function onClick(event:Event):void
		{
			
			var buttonClicked:Button = event.target as Button;
			var index:int=0;
			
			switch(buttonClicked)
			{
				case this.backButton:
					this.avatarChooserNotifier.typeOfRequest = AvatarChooserNotifier.REQUESTED_DESTROY_ALL_PAGES;

					break;
				
				case this.nextButton:
					this.avatarChooserNotifier.typeOfRequest = AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_TWO_PAGE;

					
					break;	
				
				case this.avatar1Button:
					//add avatar image into question icon area
					addSelectedAvatar(buttonClicked.name);
					
					this.avatarChooserNotifier.listSelectedAvatars(buttonClicked.name,index);
					availiability(this.avatar1Button,false);
					availiability(this.avatar2Button,true);
					availiability(this.avatar3Button,true);
					
					break;	
				
				case this.avatar2Button:
					addSelectedAvatar(buttonClicked.name);
					
					this.avatarChooserNotifier.listSelectedAvatars(buttonClicked.name,index);
					availiability(this.avatar1Button,true);
					availiability(this.avatar2Button,false);
					availiability(this.avatar3Button,true);
					break;	
				
				case this.avatar3Button:
					addSelectedAvatar(buttonClicked.name);
					this.avatarChooserNotifier.listSelectedAvatars(buttonClicked.name,index);
					availiability(this.avatar1Button,true);
					availiability(this.avatar2Button,true);
					availiability(this.avatar3Button,false);
					break;	
				
				
			}
			page2.update();
		}
		private function addSelectedAvatar(avatarLinkage:String):void
		{
			if(avatarInSelectedAvatarHolder && selectedAvatarHolder.contains(avatarInSelectedAvatarHolder))
			{
				selectedAvatarHolder.removeChild(avatarInSelectedAvatarHolder);
				avatarInSelectedAvatarHolder = null;
			}
			
			if(this.questionIcon.visible)this.questionIcon.visible = false;
			avatarInSelectedAvatarHolder =  new Image(Assets.getAtlas().getTexture(avatarLinkage));
			avatarInSelectedAvatarHolder.scaleX = avatarInSelectedAvatarHolder.scaleY = scale;
			selectedAvatarHolder.addChild(avatarInSelectedAvatarHolder);
			if(nextButton.enabled == false)
			{
				nextButton.enabled = true;
				nextButton.alpha = 1;
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
		
		private function availiability(button:Button, enable:Boolean = true):void
		{

			button.alpha = enable == true ? 1:.4;
			button.enabled = enable;
			
		}
		public function destroy():void
		{
			
			if(this.questionIcon && this.contains(this.questionIcon))
			{
				this.removeChild(this.questionIcon);
				this.questionIcon = null;
			}
			if(this.textCopy && this.contains(this.textCopy))
			{
				this.removeChild(this.textCopy);
				this.textCopy = null;
			}
			if(this.avatar1Button && this.contains(this.avatar1Button))
			{
				this.removeChild(this.avatar1Button);
				this.avatar1Button = null;
			}
			if(this.avatar2Button && this.contains(this.avatar2Button))
			{
				this.removeChild(this.avatar2Button);
				this.avatar2Button = null;
			}
			if(this.avatar3Button && this.contains(this.avatar3Button))
			{
				this.removeChild(this.avatar3Button);
				this.avatar3Button = null;
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
			
			if(avatarInSelectedAvatarHolder && selectedAvatarHolder.contains(avatarInSelectedAvatarHolder))
			{
				selectedAvatarHolder.removeChild(avatarInSelectedAvatarHolder);
				avatarInSelectedAvatarHolder = null;
				
			}
			
			if(selectedAvatarHolder && this.contains(selectedAvatarHolder))
			{
				this.removeChild(selectedAvatarHolder);
				selectedAvatarHolder = null;
			}
			
			this.removeEventListener(Event.TRIGGERED,onClick);
		}
	}
}