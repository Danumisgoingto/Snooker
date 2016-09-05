package item
{
	import data.GameCache;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import global.UIFactory;
	
	public class MajorRole extends DynamicItemBase
	{
		//=====常量
		private static const STICK_WIDTH:int = Stick.instance.getWidth();
		private static const STICK_HEIGHT:int = Stick.instance.getHeight();
		private static const BALL_WHITE_R:int = GameCache.BALL_RADIUS;
		//木棍弹出的速度
		private static const STICK_OUT_SPEED:int = 60;
		
		private static var _instance:MajorRole;
		
		//=====显示对象
		private var _ballWhite:Ball;
		//棍子的容器，用于旋转
		private var _stickSprite:ItemBase;
		
		private var _guildLine:Shape;
//		private var _guildLine:Bitmap;
		
		//=====数据
		private var _circlePosGlobal:Point;
		private var _circlePosLocal:Point;
		private var _stickPosGlobal:Point;
		private var _stickXGlobal:int;
		private var _stickYGlobal:int;
		private var _stickPosLocal:Point;
		
		private var _angle:Number;
		//斜率
		private var _k:Number;
		//球的位置是否已经记录
		private var _ballPosRecorded:Boolean;
		
		public function MajorRole()
		{
			super(null, STICK_WIDTH + BALL_WHITE_R, BALL_WHITE_R);
			if(_instance)
			{
				throw Error("主角类不是单例");
			}
		}
		
		public function get ballWhite():Ball
		{
			return _ballWhite;
		}

		public static function get instance():MajorRole
		{
			if(!_instance)
			{
				_instance = new MajorRole();
			}
			return _instance;
		}
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			
			_ballWhite = UIFactory.createBall("", this, STICK_WIDTH, 0);
			
			_stickSprite = new ItemBase("", STICK_WIDTH, STICK_HEIGHT);
			_stickSprite.addItem(Stick.instance);
			this.addItem(_stickSprite, 0, 0);
			
			_guildLine = new Shape();
			this.addChild(_guildLine);
//			_guildLine = new Bitmap(null, "auto", true);
//			this.addChild(_guildLine);
		}
		
		/**
		 *  调整角度瞄准
		 **/
		public function adjustAngle(point:Point):void
		{
			if(!_ballPosRecorded)
			{
				_stickSprite.x += (STICK_WIDTH + BALL_WHITE_R);
				_stickSprite.y += BALL_WHITE_R;
				
				Stick.instance.x -= (STICK_WIDTH + BALL_WHITE_R);
				Stick.instance.y -= BALL_WHITE_R;
				
				_circlePosLocal = _ballWhite.getCirclePoint();
				
//				_circlePosGlobal = this.localToGlobal(_circlePosLocal);
				_circlePosGlobal = UIFactory.getGlobalPos(_ballWhite, _circlePosLocal);
				_ballPosRecorded = true;
			}
			
			_guildLine.graphics.clear();
			_guildLine.graphics.lineStyle(2,0,1,true);
			_guildLine.graphics.moveTo(_circlePosLocal.x, _circlePosLocal.y);
			//斜率不存在
			if(point.x == _circlePosGlobal.x) 
			{
				if(point.y > _circlePosGlobal.y)
				{
					_angle = -90;
					_guildLine.graphics.lineTo(_circlePosLocal.x, _circlePosLocal.y - 50);
				}
				else
				{
					_angle = 90;
					_guildLine.graphics.lineTo(_circlePosLocal.x, _circlePosLocal.y + 50);
				}
			}
			else
			{
				if(point.x < _circlePosGlobal.x)
				{
					_k = (point.y - _circlePosGlobal.y) / (point.x - _circlePosGlobal.x);
					_angle = Math.atan(_k) / Math.PI * 180;
					_guildLine.graphics.lineTo(450, _k*450 + _circlePosLocal.y - _k*_circlePosLocal.x);
//					_guildLine.bitmapData = UIFactory.drawLine(_circlePosLocal.x, _circlePosLocal.y,
//						450, _k*450 + _circlePosLocal.y - _k*_circlePosLocal.x, 2);
				}
				else
				{
					_k = (_circlePosGlobal.y - point.y) / (point.x - _circlePosGlobal.x);
					_angle = 180 - Math.atan(_k) / Math.PI * 180;
					_guildLine.graphics.lineTo(100, -_k*100 + _circlePosLocal.y + _k*_circlePosLocal.x);
//					_guildLine.bitmapData = UIFactory.drawLine(_circlePosLocal.x, _circlePosLocal.y,
//						100, -_k*100 + _circlePosLocal.y + _k*_circlePosLocal.x, 2);
				}
			}
			
			_stickSprite.rotation = _angle;
			
//			_stickPosGlobal = this.localToGlobal(_stickSprite.localToGlobal(
//				new Point(Stick.instance.x, Stick.instance.y)));
			_stickPosGlobal = UIFactory.getGlobalPos(Stick.instance, 
				new Point(Stick.instance.x, Stick.instance.y));
		}
		
		/**
		 *  聚力
		 **/
		public function gatherStrength(mousePoint:Point, downPoint:Point):void
		{
			_stickXGlobal = _stickPosGlobal.x + mousePoint.x - downPoint.x;
			if(downPoint.x < _circlePosGlobal.x)
			{
				_stickYGlobal = _k*_stickXGlobal + _stickPosGlobal.y - _k*_stickPosGlobal.x;
			}
			else
			{
				_stickYGlobal = -_k*_stickXGlobal + _stickPosGlobal.y + _k*_stickPosGlobal.x;
			}
//			_stickPosLocal = _stickSprite.globalToLocal(this.globalToLocal(new Point(_stickXGlobal, _stickYGlobal)));
			_stickPosLocal = UIFactory.getLocalPos(Stick.instance, new Point(_stickXGlobal, _stickYGlobal));
			Stick.instance.x = _stickPosLocal.x;
			Stick.instance.y = _stickPosLocal.y;
		}
		
		/**
		 *  弹出
		 **/
		public function stickOut():void
		{
//			Stick.instance.setSpeed(STICK_OUT_SPEED, _k*STICK_OUT_SPEED);
//			this.isAwake = true;
		}
		
		
		
		/**
		 *  重写move方法，实现独特的移动
		 **/
		override public function move():void
		{
			if(Stick.instance.speed.xSpeed || Stick.instance.speed.ySpeed)
			{
				Stick.instance.move();
			}
		}

	}
}