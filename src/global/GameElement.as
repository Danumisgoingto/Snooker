package global
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class GameElement extends Sprite
	{
		protected var _loader:LoadManager;
		
		protected var _bg:Bitmap;
		
		public function GameElement(url:String)
		{
			super();
			_loader = new LoadManager(this);
			_loader.addToloadingQueues(url, loadedCallback);
		}
		
		public function get loader():LoadManager
		{
			return _loader;
		}
		
		private function loadedCallback(bitmap:Bitmap):void
		{
			_bg = bitmap;
			_bg.cacheAsBitmap = true;
		}
		
		public function allLoaded():void
		{
			this.addChildAt(_bg, 0);
		}
		
	}
}