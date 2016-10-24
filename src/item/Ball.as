package item
{
	import data.GameCache;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import global.UIFactory;

	public class Ball extends DynamicItemBase
	{
		private var _radius:int;
		private var _circlePoint:Point;
		
		private var _posGlobal:Point;
		private var _angle:Number;
		
		public function Ball(url:String = null, r:int = GameCache.BALL_RADIUS)
		{
			//这里必须先初始化_radius,因为_sprite的创建在super里
			_radius = r;
			_circlePoint = new Point(_radius, _radius);
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
		
		public function getCirclePoint():Point
		{
			return new Point(getPosition().x + _radius, getPosition().y + _radius);
		}
		
		/**
		 *  进行复写
		 *  设置检测点
		 **/
		override protected function setCrashPoint():void
		{
			super.setCrashPoint();
			
			_posGlobal = UIFactory.getGlobalPos(this, _circlePoint);
			
			//先设置精度为10
			for(var i:uint; i < 10; i++)
			{
				_angle=2*Math.PI/10*i;
				_crashPointList.push(new Point(_posGlobal.x + _radius*Math.sin(_angle), _posGlobal.y - _radius*Math.cos(_angle)));
			}
		}
		
		/**
		 *  进行复写
		 *  设置法线
		 **/
		override protected function getNormalLine(crashPoint:Point):String
		{
			var k:Number;
			_posGlobal = UIFactory.getGlobalPos(this, _circlePoint);
			if(crashPoint.x - _posGlobal.x)
			{
				k = (crashPoint.y - _posGlobal.y) / (crashPoint.x - _posGlobal.x);
				if(k > 0)
				{
					return "" + (-1/k);
				}
				else if(k < 0)
				{
					return "" + (1/k);
				}
				else
				{
					return null;
				}
			}
			return "0"
		}

		/**
		 *  进行复写
		 *  设置sprite
		 **/
		override protected function setSprite():void
		{
			super.setSprite();
			_sprite.graphics.beginFill(0x000000);
			_sprite.graphics.drawCircle(_radius, _radius, _radius);
			_sprite.graphics.endFill();

		}
	}
}