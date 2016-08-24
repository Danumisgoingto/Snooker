package item
{
	import cache.GameCache;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import global.UIFactory;
	
	public class MajorRole extends DynamicItemBase
	{
		//常量
		private static const STICK_WIDTH:int = Stick.instance.getWidth();
		private static const STICK_HEIGHT:int = Stick.instance.getHeight();
		private static const BALL_WHITE_R:int = GameCache.BALL_RADIUS;
		
		private static var _instance:MajorRole;
		
		//显示对象
		private var _ballWhite:Ball;
		private var _stickSprite:ItemBase;//棍子的容器，用于旋转
		
		private var _guildLine:Shape;
		private var _guildLineData:BitmapData;//抗锯齿
		
		//数据
		private var _circlePosGlobal:Point;
		private var _circlePosLocal:Point;
		private var _angle:Number;
		private var _k:Number;//斜率
		private var _isRegister:Boolean;
		
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
//			_guildLineBuff = new Bitmap();
//			_guildLineBuff.smoothing = true;
			this.addChild(_guildLine);
		}
		
		/**
		 *  调整角度瞄准
		 **/
		public function adjustAngle(point:Point):void
		{
			if(!_isRegister)
			{
				_stickSprite.x += (STICK_WIDTH + BALL_WHITE_R);
				_stickSprite.y += BALL_WHITE_R;
				
				Stick.instance.x -= (STICK_WIDTH + BALL_WHITE_R);
				Stick.instance.y -= BALL_WHITE_R;
				
				_circlePosLocal = _ballWhite.getCirclePoint();
				//转换到调用者父容器的坐标
				_circlePosGlobal = this.localToGlobal(_circlePosLocal);
				_isRegister = true;
			}
			
			_guildLine.graphics.clear();
			_guildLine.graphics.lineStyle(1);
			_guildLine.graphics.moveTo(_circlePosLocal.x, _circlePosLocal.y)
			if(point.x == _circlePosGlobal.x) //斜率不存在
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
				}
				else
				{
					_k = (_circlePosGlobal.y - point.y) / (point.x - _circlePosGlobal.x);
					_angle = 180 - Math.atan(_k) / Math.PI * 180;
					_guildLine.graphics.lineTo(100, -_k*100 + _circlePosLocal.y + _k*_circlePosLocal.x);
				}
			}
			
			_stickSprite.rotation = _angle;
			
			_guildLineData = new BitmapData(_guildLine.width, _guildLine.height);
			_guildLineData.drawWithQuality(_guildLine);
			_guildLine.graphics.beginBitmapFill(_guildLineData);
			
		}
		
		public function gatherStrength():void
		{
			
		}
		

	}
}