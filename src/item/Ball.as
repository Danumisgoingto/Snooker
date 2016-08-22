package item
{
	import flash.display.Shape;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		public function Ball(url:String = null, r:int = 10)
		{
			//这里必须先初始化_radius,因为_sprite的创建在super里
			_radius = r;
			super(url, 2*r, 2*r);
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
			super.setSprite();
			(_sprite as Shape).graphics.beginFill(0xFFFFFF);
			(_sprite as Shape).graphics.drawCircle(_radius, _radius, _radius);
			(_sprite as Shape).graphics.endFill();

		}
	}
}