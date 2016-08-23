package item
{
	import flash.geom.Point;
	import flash.text.TextField;
	
	import global.UIFactory;
	
	public class MajorRole extends DynamicItemBase
	{
		//常量
		private static var _instance:MajorRole;
		
		//显示对象
		private var _ballWhite:Ball;
		
		//数据
		private var _isRegister:Boolean;
		
		public function MajorRole()
		{
			super(null, 295+20, 20);
			if(_instance)
			{
				throw Error("主角类不是单例");
			}
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
			
			_ballWhite = UIFactory.createBall("", 10, this, 295, 0);
			
			this.addItem(Stick.instance, 0, 0);
		}
		
		public function moveStick(point:Point):void
		{
			var ballWhitePos:Point = localToGlobal(_ballWhite.getCirclePoint());
			var angle:Number;
			//斜率
			var k:Number;
			
			if(!_isRegister)
			{
//				ballWhitePos = 
				
				this.x += 305;
				this.y += 10;
				
				Stick.instance.x -= 305;
				Stick.instance.y -= 10;
				
				_ballWhite.x -= 305;
				_ballWhite.y -= 10;
				
				ballWhitePos = localToGlobal(_ballWhite.getCirclePoint());
				_isRegister = true;
			}
			
			if(point.x == ballWhitePos.x) //斜率不存在
			{
				if(point.y > ballWhitePos.y)
				{
					angle = 90;
				}
				else
				{
					angle = -90;
				}
			}
			else
			{
				k = (point.y - ballWhitePos.y) / (point.x - ballWhitePos.x);
				angle = Math.atan(k) / Math.PI * 180;
				if(point.x > ballWhitePos.x)
				{
					angle = 180 - angle;
				}
			}
			
			this.rotation = angle;
		}
		
		
		override public function move():void
		{
			
		}

	}
}