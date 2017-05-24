package screens
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import events.GameNotifier;
	
	import managers.SoundManager;
	
	import objects.Dice;
	import objects.RoundExitButton;
	import objects.SmallAvatar;
	import objects.SoundButton;
	import objects.Tile;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.GameUtility;
	
	public class GameBoard extends Sprite
	{
	
		private var gameUtility:GameUtility;
		private var gameBoardClass:Image;
		
		private var dice:Dice;
		private var rollDiceBtn:Button;
		
		public var avartarsContainer:Sprite;
		
		private var smallAvatar:SmallAvatar;
		
		private var callback:Function;
		public var tiles:Array;
		
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		
		private var gameNotifier:GameNotifier;
		
		private var diceContainer:Sprite;
		public var smallAvatarIconContainer:Sprite;
		
		private var roundExitBtn:RoundExitButton;
		
		private var soundBtn:SoundButton;
		//---------------------------------------------------------------------------------------------
		public function get tileHeight():Number
		{
			return _tileHeight;
		}
		//---------------------------------------------------------------------------------------------
		public function set tileHeight(value:Number):void
		{
			_tileHeight = value;
		}
		//---------------------------------------------------------------------------------------------
		public function get tileWidth():Number
		{
			return _tileWidth;
		}
		//---------------------------------------------------------------------------------------------
		public function set tileWidth(value:Number):void
		{
			_tileWidth = value;
		}
		//---------------------------------------------------------------------------------------------
		public function GameBoard(pGameUtility:GameUtility,pGameNotifier:GameNotifier,pCallback:Function)
		{
		
			gameUtility = pGameUtility;
			gameNotifier = pGameNotifier;
			callback = pCallback;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedStage);
		}
		//---------------------------------------------------------------------------------------------
		private function onAddedStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedStage);
			init();
			
		}
		//---------------------------------------------------------------------------------------------
		private function init():void
		{
		//	SoundManager.getInstance().playSound(GameUtility.BG_SOUND,GameUtility.DEFULT_BG_SOUND_VOLUME,999999);	
			
			gameBoardClass = new Image(Assets.getTexture(GameUtility.GAMEBOARD));
			gameBoardClass.width = stage.stageWidth;
			gameBoardClass.height = stage.stageHeight;
			addChild(gameBoardClass);
			
			var scale:Number = gameUtility.scaleRatioWithScreenSize(stage.stageWidth,stage.stageHeight);
		
			tiles = new Array();
			var startX:Number = 0;
			var startY:Number = 0;
			
			var isTileSizeSet:Boolean = false;
			var tile:Tile;
			
			for(var horizontalX:int = 0; horizontalX < GameUtility.MAX_TILES_IN_HORIZONTAL;horizontalX++)//was 9
			{
				tiles[horizontalX] = new Array();
				for(var verticalY:int = 0; verticalY<GameUtility.MAX_TILES_IN_VERTICAL;verticalY++)
				{
					tile = new Tile(horizontalX,verticalY,GameUtility.NORMAL_TILE,gameNotifier);
					tile.width = stage.stageWidth/10;
					tile.height = stage.stageHeight/10;
					
					if(!isTileSizeSet)
					{
						this.tileWidth = tile.width;
						this.tileHeight = tile.height;
					}
					
					tile.x = startX +(verticalY *tile.width);
					tile.y = startY +(horizontalX *tile.height);
					addChild(tile);	
					tiles[horizontalX][verticalY] = {tile:tile,x:tile.x,y:tile.y,horizontalX:horizontalX,verticalY:verticalY};
					
					tile.visible = false;
					
					//tile.alpha = .4			
				}
				
			}
			//create container to hold small avatar icon
			if(smallAvatarIconContainer == null)
			{
				smallAvatarIconContainer = new Sprite();
				this.addChild(smallAvatarIconContainer);
			}		
			if(avartarsContainer == null)
			{
				avartarsContainer = new Sprite();
				this.addChild(avartarsContainer);
			}
			//create container to hold dice object
			if(diceContainer == null)
			{
				diceContainer = new Sprite();
				this.addChild(diceContainer);
				
			}
			
			if(roundExitBtn == null)
			{
				roundExitBtn = new RoundExitButton(Assets.getAtlas().getTexture(GameUtility.ROUND_EXIT_BUTTON));
				roundExitBtn.gameNotifier = gameNotifier;
				roundExitBtn.scaleX = roundExitBtn.scaleY = scale;
				roundExitBtn.y = gameBoardClass.height - roundExitBtn.height * 1.6;
				this.addChild(roundExitBtn);
				//rollDiceBtn.y = stage.stageHeight - rollDiceBtn.height*1.8;
			}
			if(soundBtn == null)
			{
				soundBtn = new SoundButton(Assets.getAtlas().getTexture(GameUtility.SOUND_ON_BUTTON));
				soundBtn.gameNotifier = gameNotifier;
				soundBtn.scaleX = soundBtn.scaleY = scale;
				soundBtn.x = roundExitBtn.x + roundExitBtn.width + roundExitBtn.width * .2;
				soundBtn.y = roundExitBtn.y;
				this.addChild(soundBtn);
			}
			
			callback();// call back to PlayWithDevice class, readyToplayGame()
		}
		//---------------------------------------------------------------------------------------------
		public function getAvatarCoordinates(verticalY:uint,horizontalX:uint):Object
		{
			return tiles[verticalY][horizontalX] ? tiles[verticalY][horizontalX] : null;
		}
		//---------------------------------------------------------------------------------------------
		public function flyAWayDice():void
		{
			if(dice)
			{
				TweenLite.to(dice, 2, {y:gameBoardClass.y - dice.height,delay:1,onStart:removeRollBtn,onComplete:removeDice});
			}
		}
		//---------------------------------------------------------------------------------------------
		private function removeDice():void
		{
			if(dice && this.diceContainer.contains(dice))
			{
				this.diceContainer.removeChild(dice);
				dice = null;
				gameNotifier.update(GameNotifier.FINISH_DESTROY_DICE);
			}
		}
		//---------------------------------------------------------------------------------------------
		private function removeRollBtn():void
		{
			if(rollDiceBtn && this.diceContainer.contains(rollDiceBtn))
			{
				this.diceContainer.removeChild(rollDiceBtn);
				rollDiceBtn = null;
			}
		}
		//---------------------------------------------------------------------------------------------
		private var avatarType:String;
		public function loadAndAnimateDice(avatarType:String):void
		{
			removeDice();
			this.avatarType = avatarType;
			//get predefined number from dice's animation
			var whichNo:String = gameUtility.getRandomNumber();
			//set avatar next step would be
			gameNotifier.avatarNextStep = parseInt(whichNo);
			//create dice(myDiceAnimation_ends_xxxx)
			dice = new Dice(gameNotifier,parseInt(whichNo),Assets.getAtlas().getTextures(GameUtility.DICE_ANIMATION_TEXTURE_NAME+whichNo),12);
			var scale:Number = gameUtility.scaleRatioWithScreenSize(stage.stageWidth,stage.stageHeight);
			dice.scaleX = dice.scaleY = scale;
			dice.pivotX = dice.width/2
			dice.pivotY = dice.height/2	
			dice.x = gameBoardClass.width/2
			dice.y = -dice.height;
			
			this.diceContainer.addChild(dice);
				
			TweenLite.to(dice, 2, {y:gameBoardClass.height/2 , ease:Bounce.easeOut,onComplete:completeDiceSlideIn});
		}
		//---------------------------------------------------------------------------------------------
		private function completeDiceSlideIn():void
		{
			//To display which avatar's turn
			gameNotifier.update(GameNotifier.DISPLAY_CURRENT_AVATAR_ICON);
			
		}
		//---------------------------------------------------------------------------------------------
		public function updateDisplayIcon(avatarIcon:Image):void
		{

			if(smallAvatar == null)
			{
				var scale:Number = gameUtility.scaleRatioWithScreenSize(stage.stageWidth,stage.stageHeight);
				smallAvatar = new SmallAvatar(gameNotifier);
				smallAvatar.update(avatarIcon);
				this.smallAvatarIconContainer.addChild(smallAvatar);
				smallAvatar.scaleX = smallAvatar.scaleY = scale;
				smallAvatar.x = stage.stageWidth * .5 - smallAvatar.width * .5;
				smallAvatar.y = stage.stageHeight * .78;
				
				
			}
			else
			{
				smallAvatar.update(avatarIcon);
			}

			
			
			//check current avatar 	type and if it's user's avatar animate buton, otherwise roll dice automatically
			switch(this.avatarType)
			{
				case GameNotifier.UER_AVATAR:
					animateBtn();
				break;
				
				case GameNotifier.DEVICE_AVATAR:
					dice.rollDice();
					break;
					
			}
		}
		//---------------------------------------------------------------------------------------------
		private function animateBtn():void
		{
			var scale:Number = gameUtility.scaleRatioWithScreenSize(stage.stageWidth,stage.stageHeight);
			removeRollBtn();
			//button for Playing with device
			rollDiceBtn = new Button(Assets.getAtlas().getTexture(GameUtility.ROLL_DICE_BUTTON));
			rollDiceBtn.scaleX = rollDiceBtn.scaleY = scale;
			rollDiceBtn.x = (smallAvatar.x +smallAvatar.width) - smallAvatar.width * .2;
			rollDiceBtn.y = stage.stageHeight - rollDiceBtn.height*1.8;
			this.diceContainer.addChild(rollDiceBtn);
			rollDiceBtn.addEventListener(Event.TRIGGERED, rollDice);
			 
		}
		//---------------------------------------------------------------------------------------------
		/*
			function to call roll dice
		*/
		private function rollDice(event:Event):void
		{
			//if any prompt opened i don't want to roll dice
			if(this.gameNotifier.promptOpened == true) return;

			rollDiceBtn.removeEventListener(Event.TRIGGERED, rollDice);
			SoundManager.getInstance().playSound(GameUtility.CLICK_SOUND);
			dice.rollDice();
			
		}
		//---------------------------------------------------------------------------------------------
		public function destroy():void
		{
			//destroy gameborder
			if(gameBoardClass && this.contains(gameBoardClass))
			{
				this.removeFromParent(true);
			}
			//destroy tiles
			for(var horizontalX:int = 0; horizontalX < GameUtility.MAX_TILES_IN_HORIZONTAL;horizontalX++)
			{
				for(var verticalY:int = 0; verticalY<GameUtility.MAX_TILES_IN_VERTICAL;verticalY++)
				{
					if(tiles[horizontalX][verticalY].tile && this.contains(tiles[horizontalX][verticalY].tile))
					{
						this.removeChild(tiles[horizontalX][verticalY].tile);
						tiles[horizontalX][verticalY] = null;
					}
					
				}
			}
			tiles = null;
			
			if(avartarsContainer && this.contains(avartarsContainer))
			{
				this.removeChild(avartarsContainer);
				avartarsContainer = null;
			}
			
			if(dice && this.diceContainer.contains(dice))
			{
				this.diceContainer.removeChild(dice);
				dice = null;
			}
			
			if(rollDiceBtn && this.diceContainer.contains(rollDiceBtn))
			{
				this.diceContainer.removeChild(rollDiceBtn);
				rollDiceBtn = null;
			}
			
			if(this.diceContainer && this.contains(this.diceContainer))
			{
				this.removeChild(this.diceContainer);
				this.diceContainer = null;
			}
			
			if(smallAvatar &&  this.smallAvatarIconContainer.contains(smallAvatar))
			{
				smallAvatar.clean();
				this.smallAvatarIconContainer.removeChild(smallAvatar);
				smallAvatar = null;
			}
			
			gameUtility = null;
			callback = null;

			if(this.smallAvatarIconContainer && this.contains(this.smallAvatarIconContainer))
			{
				this.removeChild(smallAvatarIconContainer);
				smallAvatarIconContainer = null;
			}
			
			if(roundExitBtn && this.contains(roundExitBtn))
			{
				this.removeChild(roundExitBtn);
				roundExitBtn.clean();
				roundExitBtn = null;
			}
			if(soundBtn && this.contains(soundBtn))
			{
				this.removeChild(soundBtn);
				soundBtn.clean();
				soundBtn = null;
			}
		}
		//---------------------------------------------------------------------------------------------
	}
}