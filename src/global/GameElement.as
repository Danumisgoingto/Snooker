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
		
		/**
		 *  为什么要再写自己的宽高，而不从sprite那里继承
		 *  原因是因为sprite在没有内容时，
		 * 无论怎么设置宽高，宽高都为0
		 * */
		private var _width:int;
		private var _height:int;
		
		private var _url:String;
		
		public function GameElement(url:String, width:int, height:int)
		{
			super();
			_url = url;
			_width = width;
			_height = height;
			if((!url || "" == url) && (0 == width || 0 == height))
			{
				throw Error("你的url和宽高必须设置其中一个");
			}
			
			initData();
			createElement();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get callback():Function
		{
			return loadedCallback;
		}
		
		public function setWAndH(width:int, height:int):void
		{
			_width = width;
			_height = height;
		}
		
		public function getWidth():int
		{
			return _width;
		}
		
		public function getHeight():int
		{
			return _height;
		}
		
		/**
		 *  提供复写
		 *  这里用来初始化一些要在createElement前就要初始化的数值
		 **/
		protected function initData():void
		{
			
		}
		
		/**
		 * 提供复写
		 *  这里用来创建显示对象
		 **/
		protected function createElement():void
		{
			
		}
		
		
		protected function loadedCallback(bitmap:Bitmap):void
		{
			_bg = bitmap;
			_bg.cacheAsBitmap = true;
			if(0 == _width || 0 == _height)
			{
				_width = _bg.width;
				_height = _bg.height;
			}
			
			if(_scaleMod)
			{
				var bitmapDataTemp:BitmapData = new BitmapData(_width, _height);
				var rectangle:Rectangle = new Rectangle(0, 0, _bg.width, _bg.height);
				for(var w:int; w <= _width; w += _bg.width)
				{
					for(var h:int; h <= _height; h += _bg.height)
					{
						bitmapDataTemp.copyPixels(_bg.bitmapData, rectangle, new Point(w, h));
					}
					h = 0;
				}
				_bg.bitmapData = bitmapDataTemp;
			}
			this.addChildAt(_bg, 0);
			
			this.width = _width;
			this.height = _height;
		}
		
	}
}