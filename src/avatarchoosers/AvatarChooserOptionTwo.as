/*
this is for case of playing with device
*/

package avatarchoosers
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import interfaces.IAvatarChooser;
	import interfaces.IPage;
	
	import managers.SoundManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import util.GameUtility;
	
	public class AvatarChooserOptionTwo extends Sprite implements IAvatarChooser
	{
		//linkage of components from spritesheet Xml
		private static const PANEL:String ="panel2";
		protected var panel:Image;
		protected var scale:Number;
		private var gameUtility:GameUtility;
		protected var isTweenCompleted:Boolean = false;
		private var avatarChooserNotifier:AvatarChooserNotifier;
		
		private var pages:Array;
		
		
		
		public function AvatarChooserOptionTwo(pGameUtility:GameUtility,pAvatarChooserNotifier:AvatarChooserNotifier)
		{
			super();
			this.gameUtility = pGameUtility;
			avatarChooserNotifier = pAvatarChooserNotifier;
			scale = this.gameUtility.scaleRatioWithScreenSize();
			
			initialize();
			this.avatarChooserNotifier.addEventListener(AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_TWO_PAGE,openChooseAvatarTwoPage);
			this.avatarChooserNotifier.addEventListener(AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_ONE_PAGE,openChooseAvatarOnePage);
		}
		
		
		private function initialize():void
		{
			
			panel = new Image(Assets.getAtlas2().getTexture(PANEL));
			this.scaleX = this.scaleY = 0;
			panel.scaleX = panel.scaleY = scale;
			//registration pt set to center
			pivotX = panel.width * .5;
			pivotY = panel.height * .5;
			addChild(panel);
			
			if(pages)pages = [];
			//create page 1 and 2
			pages = new Array;
			pages.push(new UserAvatarOneInOptionTwoPage(avatarChooserNotifier,scale,panel.width,panel.height));
			pages.push(new UserAvatarTwoInOptionTwoPage(avatarChooserNotifier,scale,panel.width,panel.height));
			(pages[0] as UserAvatarOneInOptionTwoPage).page2 = pages[1];
			(pages[1] as UserAvatarTwoInOptionTwoPage).page1 = pages[0];
			
			
			//initially hide pages as soon as they are created
			for(var i:int = 0 ; i<pages.length;i++)
			{
				addChild(Sprite(pages[i]));
				(pages[i] as IPage).hide();
				
			}
			//show 1st page
			(pages[0] as IPage).show();
			
			isTweenCompleted = false;
			//set size of array that will be hold selected avatar's linkages
			this.avatarChooserNotifier.initialSelectedAvatars(AvatarChooserNotifier.TWO_AVATARS);
			tween();
			
		}
		
		protected function tween():void
		{
			this.avatarChooserNotifier.promptOpened = true;
			TweenLite.to(this, 1, {scaleX:1,scaleY:1, ease:Elastic.easeOut,onStart:startPopUpSFX,onComplete:onTweenComplted});
		}
		private function onTweenComplted():void
		{
			isTweenCompleted = true;
			TweenLite.killTweensOf(this)
			
		}
		
		private function startPopUpSFX():void
		{
			SoundManager.getInstance().playSound(GameUtility.POPPING_SOUND);
		}
		/*
		
		calls when next btn clicks in UserAvatarOneInOptionTwo Class
		*/
		private function openChooseAvatarTwoPage():void
		{
			(pages[0] as IPage).hide();
			(pages[1] as IPage).show()	
			
		}	
		
		private function openChooseAvatarOnePage():void
		{
			(pages[0] as IPage).show();
			(pages[1] as IPage).hide()	
			
		}

		
		public function destroy():void
		{
			destroyAllPages();
			if(panel && this.contains(panel))
			{
				this.removeChild(panel);
			}
		}
		
		private function destroyAllPages():void
		{
			if(pages)
			{
				for(var i:int = 0; i < pages.length;i++)
				{
					if(pages[i]!=null && this.contains(pages[i]))
					{
						(pages[i] as IPage).destroy();
						this.removeChild(pages[i]);
						
					}
				}
				
			}
		}

	}
}