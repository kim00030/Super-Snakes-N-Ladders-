package objects
{
	import events.GameNotifier;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import util.GameUtility;
	
	public class Tile extends Sprite
	{
		private var tileWithBombSkin:Image;
		private var tileWithDistortedSkin:Image;
		private var tileWithShieldSkin:Image;
		
		private var tileNoTextField:TextField;
		
		public var verticalY:int;
		public var horizontalX:int;
		
		//////////
		public var subPath:Array; 
		/////////
		
		private var gameNotifier:GameNotifier;
		
		private var _type:String;
		//---------------------------------------------------------------------------------------------
		public function Tile(horizontalX:int,verticalY:int,type:String,gameNotifier:GameNotifier,subPath:Array = null)
		{
			super();
			
			this.horizontalX  = horizontalX;
			this.verticalY = verticalY;
			this.subPath = subPath;
			this.type = type;
			this.gameNotifier = gameNotifier;
			init();
		}
		//---------------------------------------------------------------------------------------------
		public function get type():String
		{
			return _type;
		}
		//---------------------------------------------------------------------------------------------
		public function set type(value:String):void
		{
			_type = value;
		}
		//---------------------------------------------------------------------------------------------
		private function init():void
		{
			if(!tileWithBombSkin)
			{	
				tileWithBombSkin = new Image(Assets.getAtlas2().getTexture(GameUtility.TILE_WITH_BOMB));
				addChild(tileWithBombSkin);
				
			}
			if(!tileWithShieldSkin)
			{
				tileWithShieldSkin = new Image(Assets.getAtlas2().getTexture(GameUtility.TILE_WITH_SHIELD));
				addChild(tileWithShieldSkin);
				
			}
			if(!tileWithDistortedSkin)
			{
				tileWithDistortedSkin = new Image(Assets.getAtlas2().getTexture(GameUtility.TILE_WITH_DISTORTED_BOMB));
				addChild(tileWithDistortedSkin);
				
			}
			tileWithBombSkin.visible = false;
			tileWithShieldSkin.visible = false;
			tileWithDistortedSkin.visible = false;
			
			this.gameNotifier.addEventListener(GameNotifier.GAME_COMPLETED,showTileWithDistortedBombSkin);
			/*
			//*******create textfield(starling)
			var str:String = this.horizontalX.toString() + ","+this.verticalY.toString();
			tileNoTextField = new TextField(tileWithBombSkin.width,tileWithBombSkin.height,str,"KomikaAxis",15,0xFFFFFF);
			tileNoTextField.hAlign = "center";
			
			addChild(tileNoTextField);*/
		}
		//---------------------------------------------------------------------------------------------
		public function showTileWithBombSkin():void
		{
			tileWithBombSkin.visible = true;
			tileWithShieldSkin.visible = false;
			tileWithDistortedSkin.visible = false;
		}
		//---------------------------------------------------------------------------------------------
		public function showTileWithShieldSkin():void
		{
			tileWithShieldSkin.visible = true;
			tileWithBombSkin.visible = false;
			tileWithDistortedSkin.visible = false;
			
		}
		//---------------------------------------------------------------------------------------------
		public function showTileWithDistortedBombSkin(event:Event):void
		{
			if(showTileWithBomb())
			{	
				tileWithDistortedSkin.visible = true;
				tileWithShieldSkin.visible = false;
				tileWithBombSkin.visible = false;
			}
			
		}
		//---------------------------------------------------------------------------------------------
		private function showTileWithBomb():Boolean
		{
			return this.tileWithBombSkin.visible;
		}
		//---------------------------------------------------------------------------------------------
		public function reset():void
		{
			tileWithBombSkin.visible = false;
			tileWithShieldSkin.visible = false;
			tileWithDistortedSkin.visible = false;
		}
	}
}