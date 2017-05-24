package objects
{
	import events.GameNotifier;
	
	import flash.system.Capabilities;
	
	import interfaces.IDice;
	
	import managers.SoundManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import util.GameUtility;
	
	public class Dice extends MovieClip implements IDice
	{
		private var whichNo:int;
		private var gameNotifier:GameNotifier;
		private var rollDiceBtn:Button;
		
		public function Dice( pGameNotifier:GameNotifier,pWhichNo:int,textures:Vector.<Texture>, fps:Number=12)
		{
			super(textures, fps);
			gameNotifier = pGameNotifier;
			whichNo = pWhichNo;
			this.loop = false;

		}
		
		public function rollDice():void
		{
			
			SoundManager.getInstance().playSound(GameUtility.ROLL_DICE_SOUND);
			//animate this
			Starling.juggler.add(this);
			this.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(event:Event):void
		{
			Starling.juggler.remove(this);
			gameNotifier.update(GameNotifier.FLY_A_WAY_DICE);
			
		}
	}
}

