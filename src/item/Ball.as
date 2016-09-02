package item
{
	import data.GameCache;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Point;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		public function Ball(url:String = null, r:int = GameCache.BALL_RADIUS)
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
		
		override protected function loadedCallback(bitmap:Bitmap):void
		{
			super.loadedCallback(bitmap);
			this.x += 
			
		}
		
		public function getCirclePoint():Point
		{
			return new Point(getPosition().x + _radius, getPosition().y + _radius);
		}

		override protected function setSprite():void
		{
			super.setSprite();
			_sprite.graphics.beginFill(0xFFFFFF);
			_sprite.graphics.drawCircle(_radius, _radius, _radius);
			_sprite.graphics.endFill();

		}
	}
}