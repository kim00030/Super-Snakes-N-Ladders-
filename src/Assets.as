package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import managers.SoundManager;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import util.GameUtility;

	public class Assets
	{
		[Embed("../media/bgWelcome.png")]
		public static var BgWelcome:Class;
		
		[Embed("../media/gameboard.png")]
		public static var GameBoardClass:Class;
		
		//for smoke effect
		[Embed(source = "../media/smoke.pex",mimeType="application/octet-stream")]
		public static var smokeXML:Class;
		
		//for frame effect
		[Embed(source = "../media/frame.pex",mimeType="application/octet-stream")]
		public static var FrameXML:Class;
		
		[Embed(source = "../media/avatarparticle.pex",mimeType="application/octet-stream")]
		public static var AvatarParticleXML:Class;
		
		
		[Embed(source = "../media/explosion.pex",mimeType="application/octet-stream")]
		public static var ExplosionXML:Class;
		
		[Embed(source = "../media/star.pex",mimeType="application/octet-stream")]
		public static var StarXML:Class;
		
		//sprite sheet
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source = "../media/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;

		[Embed(source = "../media/mySpritesheet.xml",mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;

		//sprite sheet2
		private static var gameTextureAtlas2:TextureAtlas;
		
		[Embed(source = "../media/mySpritesheet2.png")]
		public static const AtlasTextureGame2:Class;
		
		[Embed(source = "../media/mySpritesheet2.xml",mimeType="application/octet-stream")]
		public static const AtlasXmlGame2:Class;
		
		//For Text map
		[Embed(source="../media/komika.png")]
		private static var komika:Class;
		
		[Embed(source="../media/komika.fnt", mimeType="application/octet-stream")]
		private static var komikaXML:Class;
		//END for Text map
		
		
		////sounds////////////////////
		[Embed(source = "../media/sounds/poping.mp3")]
		private static var PopingSound:Class;
		
		[Embed(source = "../media/sounds/zipup.mp3")]
		private static var ZipupSound:Class;
		
		[Embed(source = "../media/sounds/click.mp3")]
		private static var ClickSound:Class;
		
		[Embed(source = "../media/sounds/laddermove.mp3")]
		private static var LadderMoveSound:Class;
		
		[Embed(source = "../media/sounds/snakemove.mp3")]
		private static var SnakeMoveSound:Class;

		[Embed(source = "../media/sounds/bg.mp3")]
		private static var BgSound:Class;
		
		[Embed(source = "../media/sounds/rolldice.mp3")]
		private static var RollDiceSound:Class;
		
		[Embed(source = "../media/sounds/gamewin.mp3")]
		private static var GameWinSound:Class;
		
		[Embed(source = "../media/sounds/explosion.mp3")]
		private static var ExplosionSound:Class;
		
		[Embed(source = "../media/sounds/zapblast.mp3")]
		private static var ZapBlastSound:Class;
		
		[Embed(source = "../media/sounds/powerup1.mp3")]
		private static var PowerUpSound1:Class;
		[Embed(source = "../media/sounds/powerup2.mp3")]
		private static var PowerUpSound2:Class;
		[Embed(source = "../media/sounds/powerup3.mp3")]
		private static var PowerUpSound3:Class;
		[Embed(source = "../media/sounds/powerup4.mp3")]
		private static var PowerUpSound4:Class;
		[Embed(source = "../media/sounds/powerup5.mp3")]
		private static var PowerUpSound5:Class;
		
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var soundManager:SoundManager;
		
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		public static function init():void
		{
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new komika()),
				XML(new komikaXML())));
			
			initSounds();

		}
		
		private static function initSounds():void
		{
			soundManager = SoundManager.getInstance();
			soundManager.addSound(GameUtility.POPPING_SOUND,new PopingSound());
			soundManager.addSound(GameUtility.ZIPUP_SOUND,new ZipupSound());
			soundManager.addSound(GameUtility.CLICK_SOUND,new ClickSound());
			soundManager.addSound(GameUtility.LADDER_MOVE_SOUND, new LadderMoveSound());
			soundManager.addSound(GameUtility.SNAKE_MOVE_SOUND, new SnakeMoveSound());
		//	soundManager.addSound(GameUtility.BG_SOUND, new BgSound());
			soundManager.addSound(GameUtility.ROLL_DICE_SOUND, new RollDiceSound());
			soundManager.addSound(GameUtility.GAME_WIN_SOUND, new GameWinSound());
			soundManager.addSound(GameUtility.EXPLOSION_SOUND,new ExplosionSound());
			soundManager.addSound(GameUtility.ZAP_BLAST_SOUND,new ZapBlastSound());
			soundManager.addSound(GameUtility.POWER_SOUND_1,new PowerUpSound1());
			soundManager.addSound(GameUtility.POWER_SOUND_2,new PowerUpSound2());
			soundManager.addSound(GameUtility.POWER_SOUND_3,new PowerUpSound3());
			soundManager.addSound(GameUtility.POWER_SOUND_4,new PowerUpSound4());
			soundManager.addSound(GameUtility.POWER_SOUND_5,new PowerUpSound5());
			

		}
		//for spritesheet1
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame"); 
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture,xml);
			}
			return gameTextureAtlas;
		}
		
		//for spritesheet2
		public static function getAtlas2():TextureAtlas
		{
			if(gameTextureAtlas2 == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame2"); 
				var xml:XML = XML(new AtlasXmlGame2());
				gameTextureAtlas2 = new TextureAtlas(texture,xml);
			}
			return gameTextureAtlas2;
		}
		
	}
}