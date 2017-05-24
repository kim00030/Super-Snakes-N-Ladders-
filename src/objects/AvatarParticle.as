package objects
{
	import managers.SoundManager;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	
	import util.GameUtility;

	public class AvatarParticle extends PDParticleSystem
	{
		private static const SKIN:String = "avatarparticle";
		//------------------------------------------------------------------------------------------
		public function AvatarParticle()
		{
			super(XML(new Assets.AvatarParticleXML()),
				Assets.getAtlas2().getTexture(SKIN));
			Starling.juggler.add(this);
			
		}
		//------------------------------------------------------------------------------------------
		
		public function startAnimation():void
		{
			this.start();
			playSFX();
		}
		//------------------------------------------------------------------------------------------

		public function stopAnimation():void
		{
			this.stop();
		}
		//------------------------------------------------------------------------------------------
		
		public function disposeAnimation():void
		{
			this.dispose();
		}
		//------------------------------------------------------------------------------------------
		
		private function playSFX():void
		{
			//start playing sounds
			SoundManager.getInstance().playSound(GameUtility.POWER_SOUND_1);
			SoundManager.getInstance().playSound(GameUtility.POWER_SOUND_2);
			SoundManager.getInstance().playSound(GameUtility.POWER_SOUND_3);
			SoundManager.getInstance().playSound(GameUtility.POWER_SOUND_4);
			SoundManager.getInstance().playSound(GameUtility.POWER_SOUND_5);

		}
		//------------------------------------------------------------------------------------------

	}
}