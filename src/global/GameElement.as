package global
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class GameElement extends Sprite
	{
		protected var _bg:Bitmap;
		
		protected var _url:String;
		
		protected var _callback:Function;
		
		public function GameElement(url:String)
		{
			super();
			_url = url;
			_callback = loadedCallback;
			createElement();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get callback():Function
		{
			return _callback;
		}
		
		/**
		 * 提供复写
		 **/
		protected function createElement():void
		{
			
		}
		
		
		protected function loadedCallback(bitmap:Bitmap):void
		{
			_bg = bitmap;
			_bg.cacheAsBitmap = true;
			this.addChildAt(_bg, 0);
		}
		
	}
}