package objects
{
	import events.GameNotifier;
	
	import flash.media.Sound;
	
	import managers.SoundManager;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SoundButton extends Button
	{
		private var _gameNotifier:GameNotifier;
		private var soundOffImg:Image;
		private var _state:String = "on";
		
		public function SoundButton(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			if(!soundOffImg)
			{
				soundOffImg = new Image(Assets.getAtlas().getTexture("soundoffbutton"));
				this.addChild(soundOffImg);
				soundOffImg.visible = false;
			}
			
		
			//Assets.getAtlas().getTexture("roundexitbutton")
			this.addEventListener(Event.TRIGGERED, onClick);
		}
		
		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		private function onClick():void
		{
			if(gameNotifier.promptOpened == true) return;
			
			if(this.state == "on")
			{
				this.state = "off";
				soundOffImg.visible = true;
				
			}
			else
			{
				this.state = "on";
				soundOffImg.visible = false;
				
			}
			
			SoundManager.getInstance().muteAll(soundOffImg.visible);
		}
		
	
		
		public function get gameNotifier():GameNotifier
		{
			return _gameNotifier;
		}

		public function set gameNotifier(value:GameNotifier):void
		{
			_gameNotifier = value;
		}
		
		public function clean():void
		{
			this.removeEventListener(Event.TRIGGERED, onClick);
			if(soundOffImg && this.contains(soundOffImg))
			{
				this.removeChild(soundOffImg);
				soundOffImg = null;
			}
			gameNotifier = null;
		}
		
	}
}