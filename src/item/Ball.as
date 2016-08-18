package item
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	
	import global.GameElement;
	import global.ImagesConst;
	import global.LoadManager;
	import global.UIFactory;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		public function Ball(url:String, r:int = 10)
		{
			this._radius = r;
			super(url);
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

		override protected function setSprite():void
		{
			_sprite = new Shape();
			(_sprite as Shape).graphics.beginFill(0x000000);
			(_sprite as Shape).graphics.drawCircle(_radius, _radius, _radius);
			(_sprite as Shape).graphics.endFill();

			super.setSprite();
		}
	}
}