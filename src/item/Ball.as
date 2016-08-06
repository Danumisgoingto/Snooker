package item
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	
	import global.ImagesConst;
	import global.LoadManager;
	import global.UIFactory;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		public function Ball(url:String, loader:LoadManager, r:int = 10)
		{
			this._radius = r;
			super(url, loader);
		}
		
		public function get radius():int
		{
			return _radius;
		}

		public function set radius(value:int):void
		{
			_radius = value;
			this.setSprite();
		}

		override public function setSprite():void
		{
//			_sprite = new Shape();
//			(_sprite as Shape).graphics.beginFill(0x000000);
//			(_sprite as Shape).graphics.drawCircle(_radius, _radius, _radius);
//			(_sprite as Shape).graphics.endFill();

			this._loader.addToloadingQueues(ImagesConst._Sprite1,loadedCallback);
			function loadedCallback(bitmap:Bitmap):void
			{
				_sprite = bitmap;
				_sprite.cacheAsBitmap = true;
			}
			

//			var boarder:Shape = new Shape();
//			boarder.graphics.lineStyle(1, 0x000000);
//			boarder.graphics.drawCircle(_radius, _radius, _radius);
//			this.addChild(boarder);
		
			super.setSprite();
		}
	}
}