package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	
	[SWF(backgroundColor=0x50594F,frameRate="60")]
	public class warmShooterMain extends Sprite
	{
		private var myStarling:Starling;

		public function warmShooterMain()
		{
			super();
		
			// support autoOrients
/*			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;*/
			
			
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.fullScreenWidth
			viewPortRectangle.height = stage.fullScreenHeight
			Starling.handleLostContext = true;
			myStarling = new Starling(Game,stage,viewPortRectangle);
			myStarling.start();
			
			stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
		}
		/**
		 * You'll get occasional progress updates here. event.bytesLoaded / event.bytesTotal
		 * will give you a value between 0 and 1. Multiply by 100 to get a value
		 * between 0 and 100.
		 */
		private function loaderInfo_progressHandler(event:ProgressEvent):void
		{
			
		}
		
		private function resizeStage(e:Event):void
		{
			
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.fullScreenWidth;
			viewPortRectangle.height =  stage.fullScreenHeight;
			Starling.current.viewPort = viewPortRectangle;
			
		}
	}
}