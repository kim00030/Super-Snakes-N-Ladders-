package managers
{
	import events.GameNotifier;
	
	import screens.GameBoard;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	
	import util.GameUtility;

	public class ExplosionManager
	{
		private var explosion:PDParticleSystem;
		private var gameBoard:GameBoard;
		private var tiles:Array;
		private var gameNotifier:GameNotifier;
		
		
		//-------------------------------------------------------------------------------------------
		public function ExplosionManager(pGameBoard:GameBoard,pGameNotifier:GameNotifier)
		{
			gameBoard = pGameBoard;
			tiles = gameBoard.tiles;
			this.gameNotifier = pGameNotifier;
			init();
		}
		//-------------------------------------------------------------------------------------------
	
		private function init():void
		{
			explosion = new PDParticleSystem(XML(new Assets.ExplosionXML()),
				Assets.getAtlas2().getTexture("explosion"));
			
			Starling.juggler.add(explosion);
			gameBoard.addChild(explosion);
			this.gameNotifier.addEventListener(GameNotifier.REQUIRED_EXPLOSION_ANIMATION,start);
			
		}
		//-------------------------------------------------------------------------------------------
		/**explosion start*/
		public function start(event:Event):void
		{
			var row:int = this.gameNotifier.explosionTileRow;
			var col:int = this.gameNotifier.explosionTileCol;
			
			explosion.x = tiles[row][col].tile.x + tiles[row][col].tile.width* .5;;
			explosion.y = tiles[row][col].tile.y + tiles[row][col].tile.height * .5;	
			
			if(explosion)
			{
				SoundManager.getInstance().playSound(GameUtility.EXPLOSION_SOUND);
				SoundManager.getInstance().playSound(GameUtility.ZAP_BLAST_SOUND);
				explosion.start();
			}
			var delayedCall:DelayedCall = new DelayedCall(method, 2.0);
			
			Starling.juggler.add(delayedCall);
			
			function method():void
			{
				Starling.juggler.remove(delayedCall);
				delayedCall = null;
				explosion.stop();
				if(this.explosion)this.explosion.dispose();
				
				//this.gameNotifier.update(GameNotifier.READY_TO_ROLL_DICE);
			}
		}
		//-------------------------------------------------------------------------------------------
		public function destroyExplosionParticle():void
		{
			if(gameBoard && gameBoard.contains(this.explosion))
			{
				gameBoard.removeChild(explosion);
			}
			
			if(this.explosion && Starling.juggler.contains(this.explosion))
			{
				Starling.juggler.remove(this.explosion);
				this.explosion.stop();
				this.explosion.dispose();
				this.explosion = null;
			}
			if(this.gameNotifier  && this.gameNotifier.hasEventListener(GameNotifier.REQUIRED_EXPLOSION_ANIMATION))
			{
				this.gameNotifier.removeEventListener(GameNotifier.REQUIRED_EXPLOSION_ANIMATION,start);
			}
		}
	}
}

