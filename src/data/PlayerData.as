package data
{
	import flash.utils.Dictionary;
	
	import util.GameUtility;

	public class PlayerData
	{
	
		private var avatarInfoData:Dictionary;
		
		private var _avatars:Array;
		
		public function PlayerData()
		{
			init();
		}


		public function get avatars():Array
		{
			return _avatars;
		}

		public function set avatars(value:Array):void
		{
			_avatars = value;
		}

		private function init():void
		{
			if(!avatarInfoData)
			{
				avatarInfoData = new Dictionary();
				avatarInfoData[GameUtility.AVATAR_1] = 1;
				avatarInfoData[GameUtility.AVATAR_2] = 2;
				avatarInfoData[GameUtility.AVATAR_3] = 3;
				avatarInfoData[GameUtility.AVATAR_99] = 99;//device avatar
			}
		}
		public function getAvatarIdByName(name:String):int
		{
			return avatarInfoData[name];
		}

	}
}