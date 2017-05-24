package util
{
	import flash.data.SQLConnection;

	public class GameUtility
	{
		private static const ORIGINAL_SCRREN_WIDTH:int = 800;
		private static const ORIGINAL_SCRREN_HEIGHT:int = 600;
		//sounds
		public static const POPPING_SOUND:String = "poping_sound";
		public static const ZIPUP_SOUND:String = "zipup_sound";
		public static const CLICK_SOUND:String = "click_sound";
		public static const LADDER_MOVE_SOUND:String = "ladder_move_sound";
		public static const SNAKE_MOVE_SOUND:String = "snake_move_sound";
		public static const BG_SOUND:String = "bg_sound";
		public static const ROLL_DICE_SOUND:String = "roll_dice_sound";
		public static const GAME_WIN_SOUND:String = "game_win_sound";
		public static const EXPLOSION_SOUND:String = "explosion_sound";
		public static const ZAP_BLAST_SOUND:String = "zap_blast_sound";
		
		public static const POWER_SOUND_1:String = "power_sound_1";
		public static const POWER_SOUND_2:String = "power_sound_2";
		public static const POWER_SOUND_3:String = "power_sound_3";
		public static const POWER_SOUND_4:String = "power_sound_4";
		public static const POWER_SOUND_5:String = "power_sound_5";
		
		
		//avatar image linkage in sprite sheet
		public static const AVATAR_1:String = "avatar1";
		public static const AVATAR_2:String = "avatar2";
		public static const AVATAR_3:String = "avatar3";
		public static const AVATAR_99:String = "avatar99";
		//linkage of components from spritesheet Xml
		public static const PANEL:String ="panel2";
		
		//Obstacle types that Avatar deal with
		public static const SNAKE:String = "snake";
		public static const LADDER:String = "ladder";
		
		//Avatar expressions
		public static const NORMAL:String = "normal";
		public static const HAPPY:String = "happy";
		public static const ANGRY:String = "angry";
		public static const GRIN:String = "grin";
		public static const CRY:String = "cry";
		
		//smoke
		public static const SMOKE:String = "smoke";
		
		//frame
		public static const FRAME:String = "frame";
		
		//GameBoard
		public static const GAMEBOARD:String = "GameBoardClass";
		
		//roundexitbutton
		public static const ROUND_EXIT_BUTTON:String = "roundexitbutton";
		//soundonbutton
		public static const SOUND_ON_BUTTON:String = "soundonbutton";
		
		//rollDiceBtn
		public static const ROLL_DICE_BUTTON:String = "rollDiceBtn";
		
		//"myDiceAnimation_ends_"
		public static const DICE_ANIMATION_TEXTURE_NAME:String = "myDiceAnimation_ends_";
		
		public static const DEFULT_BG_SOUND_VOLUME:Number = 1;//.7
		
		public static const MAX_TILES_IN_HORIZONTAL:int = 8;
		public static const MAX_TILES_IN_VERTICAL:int = 10;
		//for type
		public static const NORMAL_TILE:String = "normal_tile";
		public static const SHIELD_TILE:String = "shield_tile";
		public static const BOMB_TILE:String = "bomb_tile";
		//weird egg skin
		public static const EGG:String = "egg";
		//special tile skins
		public static const TILE_WITH_BOMB:String = "tilewithbomb";
		public static const TILE_WITH_SHIELD:String = "tilewithshield";
		public static const TILE_WITH_DISTORTED_BOMB:String = "tilewithdistortedbomb";
		
		private var _currentScreenWidth:Number;
		private var _currentScreenHeight:Number;
		
		public var finalScaleRatio:Number;
		
	
		public function GameUtility(pCurrentScreenWidth:Number,pCurrentScreenHeight:Number)
		{
			_currentScreenWidth = pCurrentScreenWidth;
			_currentScreenHeight = pCurrentScreenHeight;
		}
		
		public function get currentScreenHeight():Number
		{
			return _currentScreenHeight;
		}

		public function get currentScreenWidth():Number
		{
			return _currentScreenWidth;
		}

		public function scaleRatio(w:Number,h:Number):Number
		{
			var scaleW:Number = w/ORIGINAL_SCRREN_WIDTH;
			var scaleH:Number = h/ORIGINAL_SCRREN_HEIGHT;
			var finalScaleRatio:Number = Math.max(scaleW,scaleH);
			return finalScaleRatio;
			
		}
		
		public function scaleRatioWithScreenSize(w:Number = -1,h:Number = -1):Number
		{
			//my phone size 
			var myPhoneW:Number = 1184;
			var myPhoneH:Number = 720;
			
			if(w <0) w = _currentScreenWidth;
			if(h<0) h = _currentScreenHeight;
			
			var scaleW:Number = w/myPhoneW;
			var scaleH:Number = h/myPhoneH;
			finalScaleRatio = Math.max(scaleW,scaleH);
			return finalScaleRatio;
			
		}
		
		public function getRandomNumber(min:int = 1,max:int = 6):String
		{
			var minNum:int = min;
			var maxNum:int = max;
			return (minNum + Math.floor(Math.random()*(maxNum +1 - minNum))).toString();
		}
		
	}
}