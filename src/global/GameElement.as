package global
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class GameElement extends Sprite
	{
		protected var _bg:Bitmap;
		
		protected var _scaleMod:Boolean;//是否开启scale模式
		
		private var _width:int;
		private var _height:int;
		
		private var _url:String;
		
		private var _callback:Function;
		
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
		
		protected function setWAndH(width:int, height:int):void
		{
			if(!_scaleMod)
			{
				throw Error("你尚未开启scaleMod");
			}
			this._width = width;
			this._height = height;
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
			if(_scaleMod)
			{
				if(!this._width || !this._height)
				{
					throw Error("你尚未调用setWAndH方法设置宽高");
				}
				var bitmapDataTemp:BitmapData = new BitmapData(this._width, this._height);
				var rectangle:Rectangle = new Rectangle(0, 0, _bg.width, _bg.height);
				for(var w:int; w <= this._width; w += _bg.width)
				{
					for(var h:int; h <= this._height; h += _bg.height)
					{
						bitmapDataTemp.copyPixels(_bg.bitmapData, rectangle, new Point(w, h));
					}
					h = 0;
				}
				_bg.bitmapData = bitmapDataTemp;
			}
			this.addChildAt(_bg, 0);
		}
		
	}
}