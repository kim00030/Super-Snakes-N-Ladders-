package managers
{
	import com.greensock.TweenLite;
	
	import data.BombData;
	
	import events.GameNotifier;
	
	import interfaces.IState;
	
	import objects.Avatar;
	import objects.Tile;
	
	import screens.GameBoard;
	import screens.PlayGame;
	
	import starling.display.Image;
	import starling.events.Event;
	
	import util.GameUtility;

	public class PlayManager
	{
		private var gameBoard:GameBoard;
		private var avatars:Array;
		
		private var gameNotifier:GameNotifier;
		
		private var gameUtility:GameUtility;
		
		private var avartarInitialSpotRow:int = 7;
		private var avartarInitialSpotCol:int = 0;
		
		private var currentAvatarIndex:int;
		
		private var state:IState;
		
		private var explosionManager:ExplosionManager;
		private var bombData:BombData;
		private var levelManager:LevelManager;

		//-------------------------------------------------------------------------------------------
		public function PlayManager(PState:IState,pAvatars:Array,pGameBoard:GameBoard)
		{
			state = PState;
			gameBoard = pGameBoard;
			avatars = pAvatars;
			gameUtility = state.gameUtility;
			gameNotifier = state.gameNotifier;
			gameNotifier.addEventListener(GameNotifier.READY_TO_ROLL_DICE,rollDice);
			gameNotifier.addEventListener(GameNotifier.FLY_A_WAY_DICE,flyAWayDice);
			gameNotifier.addEventListener(GameNotifier.FINISH_DESTROY_DICE,moveAvatar);
			gameNotifier.addEventListener(GameNotifier.DISPLAY_CURRENT_AVATAR_ICON,updateDisplayIcon);
			gameNotifier.addEventListener(GameNotifier.REQUESTED_CONTINUE_PLAYING,replay);
			gameNotifier.addEventListener(GameNotifier.REQUESTED_BACK_TO_HOME_SCREEN,backToHomeScreen);
			gameNotifier.addEventListener(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR,showExpressionOnOpponentAvatar);
			gameNotifier.addEventListener(GameNotifier.SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR,showExpressionOnOpponentAvatar);
			
			levelManager = new LevelManager(gameNotifier);
			bombData = new BombData();
			explosionManager = new ExplosionManager(gameBoard,gameNotifier);
			initGame();
		
		}
		//-------------------------------------------------------------------------------------------
		private var targetAvatarToBeExpressed:Avatar;
		private function showExpressionOnOpponentAvatar():void
		{
			var animatingCurrentAvatar:Avatar = gameNotifier.animatingCurrentAvatar;
			if(!animatingCurrentAvatar) return;
			
			
			for(var i:int = 0; i<avatars.length;i++)
			{
				if(avatars[i] != animatingCurrentAvatar)
				{
					targetAvatarToBeExpressed = avatars[i];
					break;
				}
				
			}
			
			if(targetAvatarToBeExpressed) targetAvatarToBeExpressed.showExpression(gameNotifier.avatarExpression);
		}
		//-------------------------------------------------------------------------------------------
		private function backToHomeScreen():void
		{
			(state as PlayGame).removeWinGamePanel();
			(state as PlayGame).backToHomeScreen();
			
		}
		//-------------------------------------------------------------------------------------------
		private function replay(event:Event):void
		{
			(state as PlayGame).removeWinGamePanel();
			gameNotifier.promptOpened = false;
			for(var i:int = 0;i < avatars.length;i++)
			{
				(avatars[i] as Avatar).reset();
			}
			initGame();
		}
		
		//-------------------------------------------------------------------------------------------
		/**
		 * -initialize avatars position in gameboard
		 * - notify to roll dice
		 */		
		private function initGame():void
		{
			
			setBombs();
			
			
			for(var i:int = 0;i < avatars.length;i++)
			{
				avatars[i].x = gameBoard.getAvatarCoordinates(avartarInitialSpotRow,avartarInitialSpotCol).x - gameBoard.tileWidth;
				avatars[i].y = gameBoard.getAvatarCoordinates(avartarInitialSpotRow,avartarInitialSpotCol).y;//gameBoard.getAvatarCoordinates(avartarInitialSpotRow,avartarInitialSpotCol).y +(i*5);
				(avatars[i] as Avatar).currentRow = avartarInitialSpotRow;
				(avatars[i] as Avatar).currentCol = avartarInitialSpotCol;
				//gameBoard.addChild(avatars[i]);
				avatars[i].visible = false;
				gameBoard.avartarsContainer.addChild(avatars[i]);

			}
			gameNotifier.avatarNo = avatars.length;
			gameNotifier.update(GameNotifier.READY_TO_ROLL_DICE);
			
		}
		//-------------------------------------------------------------------------------------------
		/**set bombs on tiles if need*/
		private function setBombs():void
		{
			//get tiles
			var tiles:Array = gameBoard.tiles;
			//initialize tiles
			for(var horizontalX:int = 0; horizontalX < GameUtility.MAX_TILES_IN_HORIZONTAL;horizontalX++)
			{
				for(var verticalY:int = 0; verticalY<GameUtility.MAX_TILES_IN_VERTICAL;verticalY++)
				{
					(tiles[horizontalX][verticalY].tile as Tile).reset();
					tiles[horizontalX][verticalY].tile.visible = false;
					(tiles[horizontalX][verticalY].tile as Tile).type = GameUtility.NORMAL_TILE;
					
				}
			}
			//update level increment on every time you come here
			levelManager.updateLevel();
			//get number of bombs
			var bombNum:int =levelManager.generateNumberofBombsByLebel();
			
			var row:int;
			var col:int;
			//get possible bomb positions
			var bombPositions:Array = BombData.getInstance().getRandomBombPositions(bombNum);
			//show bombs
			for(var i:int = 0; i< bombPositions.length;i++)
			{	
				row = bombPositions[i].row;
				col = bombPositions[i].col;
				tiles[row][col].tile.visible = true;
				(tiles[row][col].tile as Tile).type = GameUtility.BOMB_TILE;
				(tiles[row][col].tile as Tile).showTileWithBombSkin();
				
			}
			//show shields
			var numshield:int = levelManager.shieldNum;
			var shieldPosition:Array = BombData.getInstance().avaialableShieldPositions(numshield);
			for(var k:int = 0; k<shieldPosition.length;k++)
			{
			
				row = shieldPosition[k].row;
				col = shieldPosition[k].col;	
		
				tiles[row][col].tile.visible = true;
				(tiles[row][col].tile as Tile).type = GameUtility.SHIELD_TILE;
				(tiles[row][col].tile as Tile).showTileWithShieldSkin();
			}
			
			
		}
		//-------------------------------------------------------------------------------------------
		/**
		 * 
		 * Being call after finishing rolloing dice and destroy it
		 */		
		private function moveAvatar():void
		{
			//move avatar
			var index:int = currentAvatarIndex;//gameNotifier.getCurrentAvatarIndex();
			var steps:int = gameNotifier.avatarNextStep;

			(avatars[index] as Avatar).moveTo(steps,gameBoard.tiles,gameNotifier);
			
		}
		//-------------------------------------------------------------------------------------------
		private function flyAWayDice(event:Event):void
		{
			gameBoard.flyAWayDice();
			
		}
		//-------------------------------------------------------------------------------------------
		private function rollDice(event:Event):void
		{
			currentAvatarIndex = gameNotifier.getCurrentAvatarIndex();
			//	pass the avatar type
			gameBoard.loadAndAnimateDice((avatars[currentAvatarIndex] as Avatar).type);
		}
		
		
		
		//-------------------------------------------------------------------------------------------
		/**function to display current avatar icon with word "TURN' and roll dice button */
		private function updateDisplayIcon(event:Event):void
		{
			//showing avatar
			if((avatars[gameNotifier.avatarCurrentIndex] as Avatar).visible == false)
			{
				(avatars[gameNotifier.avatarCurrentIndex] as Avatar).visible = true;
				startShowingAvatar((avatars[gameNotifier.avatarCurrentIndex] as Avatar));
				
			}
			//show current avatar icon at bottom
			var smallAvatarIcon:Image = (avatars[gameNotifier.avatarCurrentIndex] as Avatar).smallAvatar;
			gameBoard.updateDisplayIcon(smallAvatarIcon);
			
		}
		//-------------------------------------------------------------------------------------------
		private function startShowingAvatar(avatar:Avatar):void
		{
			var startX:Number = gameBoard.getAvatarCoordinates(avartarInitialSpotRow,avartarInitialSpotCol).x;
			var startY:Number = gameBoard.getAvatarCoordinates(avartarInitialSpotRow,avartarInitialSpotCol).y;;
			TweenLite.to(avatar,.1,{x:startX,y:startY});

		}
		
		//-------------------------------------------------------------------------------------------
		public function clean():void
		{
			if(gameBoard) gameBoard = null;
			if(avatars) 
			{	
				for(var i:int = 0; i<avatars.length;i++)
				{
					(avatars[i] as Avatar).destroy();
				}
				avatars = null;
			}
			if(gameNotifier)
			{	
				gameNotifier.removeEventListener(GameNotifier.READY_TO_ROLL_DICE,rollDice);
				gameNotifier.removeEventListener(GameNotifier.FLY_A_WAY_DICE,flyAWayDice);
				gameNotifier.removeEventListener(GameNotifier.FINISH_DESTROY_DICE,moveAvatar);
				gameNotifier.removeEventListener(GameNotifier.DISPLAY_CURRENT_AVATAR_ICON,updateDisplayIcon);
				gameNotifier.removeEventListener(GameNotifier.REQUESTED_CONTINUE_PLAYING,replay);
				gameNotifier.removeEventListener(GameNotifier.REQUESTED_BACK_TO_HOME_SCREEN,backToHomeScreen);
				gameNotifier.removeEventListener(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR,showExpressionOnOpponentAvatar);
				gameNotifier.removeEventListener(GameNotifier.SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR,showExpressionOnOpponentAvatar);

				gameNotifier = null;
			}
			gameUtility = null;
			if(bombData) bombData = null;
			if(explosionManager) explosionManager.destroyExplosionParticle();
			levelManager = null;
			bombData = null;
		}
	}
}