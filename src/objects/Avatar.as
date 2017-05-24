package objects
{

	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import data.AvatarPathData;
	import data.BombData;
	
	import events.GameNotifier;
	
	import managers.SoundManager;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ColorArgb;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	
	import util.GameUtility;
	
	public class Avatar extends Sprite
	{
		private var smoke:Smoke;
		private var _smokeType:String
	
		private var tiles:Array;
		private static const AVATAR:String = "avatar";
		
		private var eggSkin:Image;
	
		private var avatarParticle:AvatarParticle;
		//private var avatarParticle:PDParticleSystem;
		
		private var path:Array;
		private var avatarImage:Image;
		private var angryAvatarImage:Image;
		private var happyAvatarImage:Image;
		private var grinAvatarImage:Image;
		private var cryAvatarImage:Image;
		
		private var _smallAvatar:Image;
		
		//track current tile stepCountes where this avatar is
		private var _currentRow:Number;
		private var _currentCol:Number;
		private var steps:int;
		private var currentPath:Array;
		private var currentStep:int =0;
		private var id:int = 0;
		private var gameNofifier:GameNotifier;
		private var gameUtility:GameUtility;
		private var avatarIdleLinkage:String;
		
		private var _type:String;

		// -------------------------------------------------------------------------------------------------------------------------		
		public function Avatar(gameUtility:GameUtility,w:Number = 0, h:Number = 0,id:int = 1)
		{
			
			path = AvatarPathData.getInstance().path;
			
			this.gameUtility = gameUtility;
			this.id = id;
			//avatar id is 99, must be device avatar 
			this.type = id == GameNotifier.DEVICE_AVATAR_ID? GameNotifier.DEVICE_AVATAR:GameNotifier.UER_AVATAR;
			
			//normal image
			avatarIdleLinkage = "avatar"+id.toString();
			avatarImage = new Image(Assets.getAtlas().getTexture(avatarIdleLinkage));
			addChild(avatarImage);	
	
			//happy face			
			happyAvatarImage = new Image(Assets.getAtlas().getTexture(AVATAR+id.toString()+"_"+GameUtility.HAPPY));
			addChild(happyAvatarImage);
			happyAvatarImage.visible = false;
			//angry images 
			angryAvatarImage = new Image(Assets.getAtlas().getTexture(AVATAR+id.toString()+"_"+GameUtility.ANGRY));
			angryAvatarImage.visible = false;
			addChild(angryAvatarImage);
			
			grinAvatarImage = new Image(Assets.getAtlas2().getTexture(AVATAR+id.toString()+"_"+GameUtility.GRIN));
			grinAvatarImage.visible = false;
			addChild(grinAvatarImage);

			cryAvatarImage = new Image(Assets.getAtlas2().getTexture(AVATAR+id.toString()+"_"+GameUtility.CRY));
			cryAvatarImage.visible = false;
			addChild(cryAvatarImage);
			
			this.width = w;
			this.height = h;
			
			//image for its iocn displaying with word 'TURN'
			_smallAvatar = new Image(Assets.getAtlas().getTexture(AVATAR+id.toString()));
			
			this.createSmokeParticle(GameUtility.SMOKE);
			TweenPlugin.activate([BezierPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.
			
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function get smokeType():String
		{
			return _smokeType;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public function set smokeType(value:String):void
		{
			_smokeType = value;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		/**
		 * Function to start shield PD Particle animation 
		 * 
		 */		
		private function startAddingShiledAnimation():void
		{
			avatarParticle = new AvatarParticle();
			avatarParticle.x = this.width *.5 - avatarParticle.width * .5;
			avatarParticle.y = this.height *.5 - avatarParticle.height * .5;
			this.addChild(avatarParticle);
			avatarParticle.startAnimation();
			
			//delay call			
			var delayedCall:DelayedCall = new DelayedCall(method, 2.0);
			Starling.juggler.add(delayedCall);
			function method():void
			{
				addShield();
				Starling.juggler.remove(delayedCall);
				delayedCall = null;
				avatarParticle.stopAnimation();
				
				if(this.avatarParticle && this.contains(this.avatarParticle)){
					this.removeChild(avatarParticle);
					this.avatarParticle.disposeAnimation();
					this.avatarParticle = null;
				}
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function get type():String
		{
			return _type;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function set type(value:String):void
		{
			_type = value;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function get smallAvatar():Image
		{
			return _smallAvatar;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function set smallAvatar(value:Image):void
		{
			_smallAvatar = value;
		}

		// -------------------------------------------------------------------------------------------------------------------------		

		public function get currentCol():Number
		{
			return _currentCol;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function set currentCol(value:Number):void
		{
			_currentCol = value;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function get currentRow():Number
		{
			return _currentRow;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function set currentRow(value:Number):void
		{
			_currentRow = value;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		/**
		 * 
		 * @param steps => steps to be moved, generated by dice rolling
		 * @param tiles => reference of array contains tiles created
		 * @param gameNofifier
		 * 
		 * Call from PlayManager, moveAvatar()
		 */	
		
		public function moveTo(steps:int,tiles:Array,gameNofifier:GameNotifier):void
		{
			this.steps = steps;
			this.tiles = tiles;
			this.gameNofifier = gameNofifier;
			
			if(!currentPath)
			{
				currentPath = new Array();
			}
			
			//assign pathes in currentpath
			for(var i:int = this.currentStep; i < (this.currentStep + this.steps); i++)
			{
				currentPath.push(path[i]);
			}
			
			//if eggshiled added, change smoke
			if(this.eggShieldAdded())
			{
				this.createSmokeParticle(GameUtility.FRAME);
			}
			else
			{
				this.createSmokeParticle(GameUtility.SMOKE);
				
			}
			
		
			this.addChild(smoke);
			smoke.startAnimation();
			smoke.setPosition();
			animate();
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function animate():void
		{
			if(currentPath.length > 0)
			{
				var o:Object = currentPath.shift();
				var tile:Tile = this.tiles[o.row][o.col].tile;
				currentCol = o.col;
				currentRow = o.row;
						
				if(o.row == 0 && o.col == 0)
				{
					SoundManager.getInstance().playSound(GameUtility.ZIPUP_SOUND);
					//****************GAME WIN********************* 
					TweenLite.to(this,.1,{x:tile.x,y:tile.y,onComplete:onGameCompleted});
				}
				else
				{	
					SoundManager.getInstance().playSound(GameUtility.ZIPUP_SOUND);
					//speed = .1 ,test speed =1
					TweenLite.to(this,.1,{x:tile.x,y:tile.y,onComplete:completeAvatarMove,onCompleteParams:[o,tile]});
				}
			}

		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function onGameCompleted():void
		{
			this.gameNofifier.winnerAvatarId = this.id;
			this.gameNofifier.winAvatarImage = new Image(Assets.getAtlas().getTexture(avatarIdleLinkage));
			this.gameNofifier.update(GameNotifier.GAME_COMPLETED);
			this.gameNofifier.animatingCurrentAvatar = this;
			this.gameNofifier.avatarExpression = GameUtility.CRY;
			gameNofifier.update(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR);

			
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		/**
		 * function to decide if animation needs to be continued 
		 * o=> 
		 * tile => var tile:Tile = this.tiles[o.row][o.col].tile;
		 */		
		private function completeAvatarMove(o:Object,tile:Tile):void
		{
			
			var step:int = o.step;
			var tile:Tile = tile;
			if(currentPath.length > 0)
			{
				animate();
			}
			else
			{
/*				//below is for execution of move if there is sub path
				trace("this.currentRow: "+this.currentRow);
				trace("this.currentCol: "+this.currentCol);
				trace("step at this point: " + step);*/
				
				if(o.subPath){
					var subPaths:Array = new Array();
					 
					for(var i:int = 0; i<o.subPath.length;i++){
						
						var x:Number = this.tiles[o.subPath[i].row][o.subPath[i].col].x;
						var y:Number = this.tiles[o.subPath[i].row][o.subPath[i].col].y;
						subPaths[i] = {x:x,y:y};
						
					}
					
					if(o.type == GameUtility.SNAKE)
					{ 
						SoundManager.getInstance().playSound(GameUtility.SNAKE_MOVE_SOUND);
						showAngryFace();
						gameNofifier.animatingCurrentAvatar = this;
						gameNofifier.avatarExpression = GameUtility.GRIN;
						gameNofifier.update(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR);
						
					}
					else if(o.type == GameUtility.LADDER)
					{
						SoundManager.getInstance().playSound(GameUtility.LADDER_MOVE_SOUND);
						showHappyFace();
						gameNofifier.animatingCurrentAvatar = this;
						gameNofifier.avatarExpression = GameUtility.ANGRY;
						gameNofifier.update(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR);
					}
					//speed =.5
					TweenLite.to(this,2, {bezier:subPaths,onComplete:onSubPathAnimationComplete,onCompleteParams:[o]}); //makes my_mc travel through 250,50 and end up at 500,0. 

				}else{
					smoke.stopAnimation();
					TweenLite.killTweensOf(this)
					currentPath = null;
					this.currentStep = this.currentStep + steps;
				
					var startTile:Object = avatarInSpecialTile(o);
					
					if(startTile.type == GameUtility.BOMB_TILE)
					{
						this.gameNofifier.update(GameNotifier.REQUIRED_EXPLOSION_ANIMATION);
						SoundManager.getInstance().playSound(GameUtility.SNAKE_MOVE_SOUND);
						if(!eggShieldAdded()){
							TweenLite.to(this, 5, {x:tiles[startTile.row][startTile.col].x, y:tiles[startTile.row][startTile.col].y,ease:Elastic.easeOut,onStart:showCryingFace,onCompleteParams:[startTile],onComplete:backToBegin});
						}else{
							this.gameNofifier.update(GameNotifier.READY_TO_ROLL_DICE);
						}
						
					}
					else if(startTile.type == GameUtility.SHIELD_TILE)
					{
						if(!eggShieldAdded())
						{
							startAddingShiledAnimation();
						}
						this.gameNofifier.update(GameNotifier.READY_TO_ROLL_DICE);
					}
					else
					{	
						//let dice roll again	
						this.gameNofifier.update(GameNotifier.READY_TO_ROLL_DICE);
					}
					
				}
				
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		/**
		 * 
		 * @param startTile start tile
		 * 
		 */		
		private function backToBegin(startTile:Object):void
		{
			TweenLite.killTweensOf(this);
			this.currentStep = startTile.STEP;
			
			showNormalFace();
			this.gameNofifier.update(GameNotifier.READY_TO_ROLL_DICE);

		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function avatarInSpecialTile(o:Object):Object
		{
			//var tiles:Array = BombData.getInstance().deliveredArray;//[{row:7,col:8}];
			var tiles:Array = BombData.getInstance().getSpecialTiles();
			
			var startTile:Object = {row:o.row,col:o.row,STEP:o.STEP,type:type};
			var type:String;
			for(var i:int = 0; i< tiles.length; i++)
			{
				type = this.tiles[o.row][o.col].tile.type;
				//if((o.row == bombTile[i].row) && (o.col == bombTile[i].col))
				if(type == GameUtility.BOMB_TILE)
				{
					this.gameNofifier.explosionTileRow = o.row//bombTile[i].row;
					this.gameNofifier.explosionTileCol = o.col//bombTile[i].col;
					startTile = {row:7,col:0,STEP:0,type:type};//STEP should be always destination tile's STEP -1 
					break;
				}
				else if(type == GameUtility.SHIELD_TILE)
				{
					startTile = {row:o.row,col:o.row,STEP:o.STEP,type:type};
					break;
					
				}
			
			}
			return startTile;
			
		}		
		// -------------------------------------------------------------------------------------------------------------------------		

		private function onSubPathAnimationComplete(o:Object):void
		{
		
			showNormalFace();
			smoke.stopAnimation();
			TweenLite.killTweensOf(this);
			
			//Let GameNotifier knows what to do with this opponent avatar's expression
			gameNofifier.animatingCurrentAvatar = this;
			gameNofifier.avatarExpression = GameUtility.NORMAL;
			gameNofifier.update(GameNotifier.SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR);
			
			this.currentStep = path[o.destIndex].STEP;
			
			//after animation in subpath, then if there's subpath 
			if(path[this.currentStep - 1].subPath)
			{
				var o:Object = path[this.currentStep - 1];
				if(o.subPath){
					
					var subPaths:Array = new Array();
					
					for(var i:int = 0; i<o.subPath.length;i++){
						
						var x:Number = this.tiles[o.subPath[i].row][o.subPath[i].col].x;
						var y:Number = this.tiles[o.subPath[i].row][o.subPath[i].col].y;
						subPaths[i] = {x:x,y:y};
						
					}
					
					if(o.type == GameUtility.SNAKE)
					{ 
						
						showAngryFace();
						//Let GameNotifier knows what to do with this opponent avatar's expression
						gameNofifier.animatingCurrentAvatar = this;
						gameNofifier.avatarExpression = GameUtility.GRIN;
						gameNofifier.update(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR);
						
					}
					else if(o.type == GameUtility.LADDER)
					{
						showHappyFace();
						//Let GameNotifier knows what to do with this opponent avatar's expression
						gameNofifier.animatingCurrentAvatar = this;
						gameNofifier.avatarExpression = GameUtility.ANGRY;
						gameNofifier.update(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR);
					}
					
					//speed =.5
					TweenLite.to(this,2, {bezier:subPaths,onStart:showAngryFace,onComplete:onSubPathAnimationComplete,onCompleteParams:[o]}); //makes my_mc travel through 250,50 and end up at 500,0.
				}

			}
			else
			{
			
				this.gameNofifier.update(GameNotifier.READY_TO_ROLL_DICE);
				
			
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		
		private function showAngryFace():void
		{
			grinAvatarImage.visible = avatarImage.visible = happyAvatarImage.visible = cryAvatarImage.visible = false;
			angryAvatarImage.visible = true;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function showHappyFace():void
		{
			grinAvatarImage.visible = angryAvatarImage.visible = avatarImage.visible = cryAvatarImage.visible = false;
			happyAvatarImage.visible = true;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		
		private function showNormalFace():void
		{
			grinAvatarImage.visible =angryAvatarImage.visible = happyAvatarImage.visible = cryAvatarImage.visible = false;
			avatarImage.visible = true;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function showGrinFace():void
		{
			avatarImage.visible = angryAvatarImage.visible = happyAvatarImage.visible = cryAvatarImage.visible = false;
			grinAvatarImage.visible = true;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		private function showCryingFace():void
		{
			avatarImage.visible = angryAvatarImage.visible = happyAvatarImage.visible = grinAvatarImage.visible = false;
			cryAvatarImage.visible = true;
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function showExpression(expression:String):void
		{
			switch(expression)
			{
				case GameUtility.GRIN:
					showGrinFace();
				break;
				
				case GameUtility.NORMAL:
					
					showNormalFace();
				break;	
				
				case GameUtility.ANGRY:
					
					showAngryFace();
				break;	
					
				case GameUtility.CRY:
					
					showCryingFace();
					break;		
			}
			
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function destroy():void
		{
			if(avatarImage && this.contains(avatarImage))
			{
				avatarImage.removeFromParent(true);
				avatarImage = null;
			}
			if(happyAvatarImage && this.contains(happyAvatarImage))
			{
				happyAvatarImage.removeFromParent(true);
				happyAvatarImage = null;
			}
			if(angryAvatarImage && this.contains(angryAvatarImage))
			{
				angryAvatarImage.removeFromParent(true);
				angryAvatarImage = null;
			}
			if(grinAvatarImage && this.contains(grinAvatarImage))
			{
				grinAvatarImage.removeFromParent(true);
				grinAvatarImage = null;
			}
			if(cryAvatarImage && this.contains(cryAvatarImage))
			{
				cryAvatarImage.removeFromParent(true);
				cryAvatarImage = null;
			}
			removeShield();
			
			this.currentPath = null;
			this.tiles = null;
			// we must destroy smoke..
			if(this.smoke)this.smoke.disposeAnimation();
			
			this.path = [];
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function reset():void
		{
			removeShield();
			showNormalFace();
			this.currentStep = 0;
			//this.id = 0;
			if(this.currentPath) this.currentPath = null;
			smoke.stopAnimation();
			this.createSmokeParticle(GameUtility.SMOKE);
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function addShield():void
		{
			if(!eggShieldAdded())
			{
				eggSkin = new Image(Assets.getAtlas2().getTexture(GameUtility.EGG));
				addChild(eggSkin);
			}
		
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function eggShieldAdded():Boolean
		{
			return (eggSkin && this.addChild(eggSkin))? true:false;
		}
		public function removeShield():void
		{
			if(eggSkin && this.contains(eggSkin))
			{
				this.removeChild(eggSkin);
				eggSkin = null;
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		private function createSmokeParticle(which:String):void
		{
			if(smoke && this.contains(smoke))
			{
				this.removeChild(smoke);
				smoke.dispose();
				smoke = null;
			}
			switch(which)
			{
				case GameUtility.SMOKE:
					this.smokeType = GameUtility.SMOKE;
					smoke = new Smoke(XML(new Assets.smokeXML()),
						Assets.getAtlas().getTexture(GameUtility.SMOKE),this.avatarImage.x,this.avatarImage.y,
						this.avatarImage.width,this.avatarImage.height,this.id);
					smoke.setColorOnSmoke();
				break;	
					
				case GameUtility.FRAME:
					this.smokeType = GameUtility.FRAME;
					smoke = new Smoke(XML(new Assets.FrameXML()),
						Assets.getAtlas2().getTexture(GameUtility.FRAME),this.avatarImage.x,this.avatarImage.y,
						this.avatarImage.width,this.avatarImage.height,this.id);
					
				break;	
					
			}
			
		}
		
		// -------------------------------------------------------------------------------------------------------------------------		
		
		//public function testEffect():void
		//{
			// the ColorMatrixFilter contains some handy helper methods
		//	var colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter();
		//	colorMatrixFilter.invert();                // invert image
		//	colorMatrixFilter.adjustSaturation(-1);    // make image Grayscale
		//	colorMatrixFilter.adjustContrast(0.75);    // raise contrast
		//	colorMatrixFilter.adjustHue(1);            // change hue
		//colorMatrixFilter.adjustBrightness(-0.25); // darken image
			
			// to use a filter, just set it to the "filter" property
			//this.filter = colorMatrixFilter;
		//}
	}
}
