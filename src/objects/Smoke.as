package objects
{
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.extensions.ColorArgb;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	import util.GameUtility;
	
	public class Smoke extends PDParticleSystem 
	{
		private var _avatarId:int;
		private var avatarImageX:Number;
		private var avatarImageY:Number;
		private var avatarImageW:Number;
		private var avatarImageH:Number;
		
		//-----------------------------------------------------------------------------------------------------------------------
		public function Smoke( config:XML,textures:Texture,avatarImageX:Number,avatarImageY:Number,
							   avatarImageW:Number,avatarImageH:Number,avatarId:int = -1)
		{
			super(config,textures);
			
			this.avatarImageX = avatarImageX;
			this.avatarImageY = avatarImageY;
			this.avatarImageW = avatarImageW;
			this.avatarImageH = avatarImageH;
			this.avatarId = avatarId;
			
			Starling.juggler.add(this);
			
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function get avatarId():int
		{
			return _avatarId;
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function set avatarId(value:int):void
		{
			_avatarId = value;
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function setColorOnSmoke():void
		{
			//smoke color
			
			if(this.avatarId > 0)
			{
				var startColor:ColorArgb;
				switch(this.avatarId)
				{
					case 1://brown
						startColor = new ColorArgb(1,.6,.4);//.5,.7,.5
						break;
					
					case 2://red
						startColor = new ColorArgb(1,0,.5);//.7,.5,.5
						break;
					
					case 3://purple
						startColor = new ColorArgb(.8,.4,1);//.7,.5,.5
						break;
					case 99:	//grey
						startColor = new ColorArgb(.4,.4,.4);
						break;
				}
				this.startColor = startColor;
			}
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function setPosition():void
		{
			this.emitterX = this.avatarImageX + this.avatarImageW/2;
			this.emitterY = this.avatarImageY + this.avatarImageH;
		
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function startAnimation():void
		{
			this.start();
		}
		//-----------------------------------------------------------------------------------------------------------------------
		public function stopAnimation():void
		{
			this.stop();
		}	
		//-----------------------------------------------------------------------------------------------------------------------
		public function disposeAnimation():void
		{
			this.dispose();
		}
	}
}