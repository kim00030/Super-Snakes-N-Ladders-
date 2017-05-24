package events
{
	import flash.utils.Dictionary;
	
	import interfaces.IState;
	
	import objects.Avatar;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class GameNotifier extends EventDispatcher
	{
		public static const UER_AVATAR:String = "USER_AVATAR";
		public static const DEVICE_AVATAR:String = "DEVICE_AVATAR";
		public static const DEVICE_AVATAR_ID:int = 99;
		
		public static const READY_TO_ROLL_DICE:String = 'ready_to_roll_dice';
		public static const FLY_A_WAY_DICE:String = 'fly_a_way_dice';
		public static const FINISH_DESTROY_DICE:String = 'finish_destroy_dice';
		public static const AVARTAR_MOVE:String = 'avartar_move';
		public static const DISPLAY_CURRENT_AVATAR_ICON:String = "display_current_avatar_icon";
		public static const GAME_COMPLETED:String = "game_completed";
		public static const REQUESTED_END_GAME:String = "requested_end_game";
		public static const REQUESTED_OPEN_EXIT_MSG:String = "requested_open_exit_msg";
		public static const REQUESTED_DESTROY_EXIT_MSG:String = "requested_destroy_exit_msg";
		public static const REQUESTED_CONTINUE_PLAYING:String = "requetsed_continue_playing";
		public static const REQUESTED_BACK_TO_HOME_SCREEN:String = "requested_back_to_home_screen";
		public static const SHOW_EXPRESSION_ON_OPPONENT_AVATAR:String = "show_expression_on_opponent_avatar";
		public static const SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR:String ="show_normal_expression_on_opponent_avatar";
		public static const REQUIRED_EXPLOSION_ANIMATION:String = "required_explosion_animation";

		
		public static const WELCOME_STATE:int = 0;
		public static const PLAY_GAME:int = 1;
		private var _avatarNextStep:int;
		
		private var _avatarNo:int;
		private var avatarIndexArray:Array;
		 
		private var _avatarCurrentIndex:int;
		
		private var _winAvatarImage:Image;
		
		private var _promptOpened:Boolean = false;
		
		private var _currentState:int;
		
		private var _animatingCurrentAvatar:Avatar;
		private var _avatarExpression:String ="normal";
		
		private var _explosionTileRow:int;
		private var _explosionTileCol:int;
		
		private var _winnerAvatarId:int;
		//----------------------------------------------------------------------------------------
		public function GameNotifier()
		{
			super();
			avatarCurrentIndex = 0;
			
		}
		//----------------------------------------------------------------------------------------

		public function get winnerAvatarId():int
		{
			return _winnerAvatarId;
		}

		public function set winnerAvatarId(value:int):void
		{
			_winnerAvatarId = value;
		}

		public function get explosionTileCol():int
		{
			return _explosionTileCol;
		}
		//----------------------------------------------------------------------------------------

		public function set explosionTileCol(value:int):void
		{
			_explosionTileCol = value;
		}
		//----------------------------------------------------------------------------------------

		public function get explosionTileRow():int
		{
			return _explosionTileRow;
		}
		//----------------------------------------------------------------------------------------

		public function set explosionTileRow(value:int):void
		{
			_explosionTileRow = value;
		}
		//----------------------------------------------------------------------------------------

		public function get avatarExpression():String
		{
			return _avatarExpression;
		}
		//----------------------------------------------------------------------------------------

		public function set avatarExpression(value:String):void
		{
			_avatarExpression = value;
		}
		//----------------------------------------------------------------------------------------

		public function get animatingCurrentAvatar():Avatar
		{
			return _animatingCurrentAvatar;
		}
		//----------------------------------------------------------------------------------------

		public function set animatingCurrentAvatar(value:Avatar):void
		{
			_animatingCurrentAvatar = value;
		}
		//----------------------------------------------------------------------------------------

		public function get currentState():int
		{
			return _currentState;
		}
		//----------------------------------------------------------------------------------------

		public function set currentState(value:int):void
		{
			_currentState = value;
		}
		//----------------------------------------------------------------------------------------

		public function get promptOpened():Boolean
		{
			return _promptOpened;
		}
		//----------------------------------------------------------------------------------------

		public function set promptOpened(value:Boolean):void
		{
			_promptOpened = value;
		}
		//----------------------------------------------------------------------------------------

		public function get winAvatarImage():Image
		{
			return _winAvatarImage;
		}
		//----------------------------------------------------------------------------------------

		public function set winAvatarImage(value:Image):void
		{
			_winAvatarImage = value;
		}
		//----------------------------------------------------------------------------------------

		public function get avatarCurrentIndex():int
		{
			return _avatarCurrentIndex;
		}
		//----------------------------------------------------------------------------------------

		public function set avatarCurrentIndex(value:int):void
		{
			_avatarCurrentIndex = value;
		}
		//----------------------------------------------------------------------------------------
		
		//get number of avatars in game
		public function get avatarNo():int
		{
			return _avatarNo;
		}
		//----------------------------------------------------------------------------------------
		
		//set number of avatars in game
		public function set avatarNo(value:int):void
		{
			_avatarNo = value;
		}
		//----------------------------------------------------------------------------------------

		//get avatar next step would be
		public function get avatarNextStep():int
		{
			return _avatarNextStep;
		}
		//----------------------------------------------------------------------------------------

		//set avatar next step would be
		public function set avatarNextStep(value:int):void
		{
			_avatarNextStep = value;
		}
		//----------------------------------------------------------------------------------------

		public function getCurrentAvatarIndex():int
		{
			if(avatarIndexArray == null)
			{
				avatarIndexArray = new Array();

			}
			if(avatarIndexArray.length <=0)
			{
				for(var i:int = 0; i<avatarNo; i++)
				{
					avatarIndexArray.push(i);
				}
			}
			avatarCurrentIndex = avatarIndexArray.shift();
			
			return avatarCurrentIndex;
		}
		//----------------------------------------------------------------------------------------

		public function update(state:String):void
		{
			switch(state)
			{
				case READY_TO_ROLL_DICE:
					
					dispatchEvent(new Event(GameNotifier.READY_TO_ROLL_DICE));
				break;
				
				case FLY_A_WAY_DICE:
					
					dispatchEvent(new Event(GameNotifier.FLY_A_WAY_DICE));
					break;
				
				
				case FINISH_DESTROY_DICE:
					
					dispatchEvent(new Event(GameNotifier.FINISH_DESTROY_DICE));
					break;
				
				case AVARTAR_MOVE:
					
					dispatchEvent(new Event(GameNotifier.AVARTAR_MOVE));
					break;
				case DISPLAY_CURRENT_AVATAR_ICON:
					
					dispatchEvent(new Event(GameNotifier.DISPLAY_CURRENT_AVATAR_ICON));
					break;
				
				case GAME_COMPLETED:
					
					dispatchEvent(new Event(GameNotifier.GAME_COMPLETED));
					break;
				
				case REQUESTED_END_GAME:
					
					dispatchEvent(new Event(GameNotifier.REQUESTED_END_GAME));
					break;
				
				case REQUESTED_OPEN_EXIT_MSG:
					
					dispatchEvent(new Event(GameNotifier.REQUESTED_OPEN_EXIT_MSG));
					break;
				
				case REQUESTED_DESTROY_EXIT_MSG:
					
					dispatchEvent(new Event(GameNotifier.REQUESTED_DESTROY_EXIT_MSG));
					break;
				
				case REQUESTED_CONTINUE_PLAYING:
					
					dispatchEvent(new Event(GameNotifier.REQUESTED_CONTINUE_PLAYING));
					break;
				case REQUESTED_BACK_TO_HOME_SCREEN:
					
					dispatchEvent(new Event(GameNotifier.REQUESTED_BACK_TO_HOME_SCREEN));
					break;
				case SHOW_EXPRESSION_ON_OPPONENT_AVATAR:
					
					dispatchEvent(new Event(GameNotifier.SHOW_EXPRESSION_ON_OPPONENT_AVATAR));
					break;
				case SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR:
					
					dispatchEvent(new Event(GameNotifier.SHOW_NORMAL_EXPRESSION_ON_OPPONENT_AVATAR));
					break;
				case REQUIRED_EXPLOSION_ANIMATION:
					
					dispatchEvent(new Event(GameNotifier.REQUIRED_EXPLOSION_ANIMATION));
					break;
				
			}
		}
		//----------------------------------------------------------------------------------------
		
		public function reset():void
		{
			avatarCurrentIndex = 0;
			avatarIndexArray = null;
			_animatingCurrentAvatar = null;
			
		}
		//----------------------------------------------------------------------------------------

	}
}