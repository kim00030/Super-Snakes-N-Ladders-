package avatarchoosers
{
	import events.GameNotifier;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class AvatarChooserNotifier extends EventDispatcher
	{
		public static const TWO_AVATARS:int = 2;
		//public static const THREE_AVATARS:int = 3;
		
		public static const PLAY_WITH_DEVICE:String = "play_with_device";
		public static const PLAY_WITH_TWO_PLAYERS:String = "play_with_two_players";
		public static const CHANGE:String = "change";
		public static const REQUESTED_DESTROY_ALL_PAGES:String = "requested_destroy_all_pages";
		public static const REQUESTED_OPEN_TO_CHOOSE_AVATAR:String = "requested_open_to_choose_avatar";
		public static const REQUESTED_OPEN_TO_SHOW_DEVICE_AVATAR:String = "requested_open_to_show_device_avatar";
		public static const REQUETED_DONE_SELECTED_AVATARS_PROCES:String = "requested_done_selected_avatars_process";
		public static const REQUESTED_OPEN_TO_SHOW_AVATAR_ONE_PAGE:String = "requested_open_to_show_avatar_one_page";
		public static const REQUESTED_OPEN_TO_SHOW_AVATAR_TWO_PAGE:String = "requested_open_to_show_avatar_two_page";

		
		private var _typeOfPlay:String;
		private var _typeOfRequest:String;
		private var _playerNo:int;
		private var _promptOpened:Boolean = false;
		private var _selectedAvatars:Array;
	
		
		public function AvatarChooserNotifier()
		{
		}
		
		public function get selectedAvatars():Array
		{
			return _selectedAvatars;
		}

		public function initialSelectedAvatars(arrayLength:int):void
		{
			if(_selectedAvatars)
			{
				_selectedAvatars = [];
			}
			_selectedAvatars = new Array(arrayLength);
			
		}
		
		/*
		makse sure
		
		when user chooses play with device
		selectedAvatars[0] = player1
		selectedAvatars[1] = Device default avatar
		
		when user chooses play with 2 people
		selectedAvatars[0] = player1
		selectedAvatars[1] = player2
		
		*/
		public function listSelectedAvatars(avatarLinkage:String,index:int):void
		{
			
			_selectedAvatars[index] = avatarLinkage;
		
		}
		public function get playerNo():int
		{
			return _playerNo;
		}

		public function set playerNo(value:int):void
		{
			_playerNo = value;
		}

		public function get typeOfRequest():String
		{
			return _typeOfRequest;
		}

		public function set typeOfRequest(value:String):void
		{
			_typeOfRequest = value;
			notifyTypeOfRequest();
			
		}
		
		private function notifyTypeOfRequest():void
		{
			switch(typeOfRequest)
			{
				
				case AvatarChooserNotifier.REQUESTED_DESTROY_ALL_PAGES:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUESTED_DESTROY_ALL_PAGES));
					
				break;	
				
				//request to go to page 2 in case when user takes play with device
				//clicks on NEXT btn on DeviceAvatarPage
				case AvatarChooserNotifier.REQUESTED_OPEN_TO_CHOOSE_AVATAR:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUESTED_OPEN_TO_CHOOSE_AVATAR));
					
					break;	
				
				//request to go back to page 1 (DeviceAvatarPage)in case when user takes play with device
				//clicks on Back btn on PageShowsUserAvatar class
				case AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_DEVICE_AVATAR:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_DEVICE_AVATAR));
					
					break;	
				
				//request to show avatar ones page in option2 (player 2)
				case AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_ONE_PAGE:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_ONE_PAGE));
					
					break;	

				//request to show avatar two page in option2 (player 2)
				case AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_TWO_PAGE:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUESTED_OPEN_TO_SHOW_AVATAR_TWO_PAGE));
					
					break;	
				
				
				case AvatarChooserNotifier.REQUETED_DONE_SELECTED_AVATARS_PROCES:
					dispatchEvent(new Event(AvatarChooserNotifier.REQUETED_DONE_SELECTED_AVATARS_PROCES));
					
					break;	

			}
			
			
		}
		
		public function get promptOpened():Boolean
		{
			return _promptOpened;
		}

		public function set promptOpened(value:Boolean):void
		{
			_promptOpened = value;
		}

		public function get typeOfPlay():String
		{
			return _typeOfPlay;
		}

		public function set typeOfPlay(value:String):void
		{
			_typeOfPlay = value;
			
			notifyTypeOfPlay();
			
		}
		
		/**
		 * - asked by WelcomeScreen
		 * -tell AvatarChooserManager
		 */		
		private function notifyTypeOfPlay():void
		{
		
			dispatchEvent(new Event(AvatarChooserNotifier.CHANGE));
			
		}
		
	}
}