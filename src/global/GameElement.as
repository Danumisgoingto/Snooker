package global
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class GameElement extends Sprite
	{
		protected var _bg:Bitmap;
		
		public function GameElement(url:String, loader:LoadManager)
		{
			super();
			loader.addToloadingQueues(url, loadedCallback);
		}
		
		private function loadedCallback(bitmap:Bitmap):void
		{
			_bg = bitmap;
			_bg.cacheAsBitmap = true;
		}
		
		public function allLoaded():void
		{
			this.addChild(_bg);
			this.setChildIndex(_bg, 0);
		}
		
	}
}