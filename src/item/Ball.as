package item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		public function Ball(url:String, parent:DisplayObjectContainer, r:int = 10, x:int = 0, y:int = 0)
		{
			this._radius = r;
			super(url, parent, x, y );
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
			_sprite = new Shape();
			(_sprite as Shape).graphics.beginFill(0x000000);
			(_sprite as Shape).graphics.drawCircle(_radius, _radius, _radius);
			(_sprite as Shape).graphics.endFill();
			super.setSprite();
		}
	}
}