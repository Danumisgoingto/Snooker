package data
{
	public class Speed
	{
		private var _xSpeed:int;
		private var _ySpeed:int;
		private var _k:String;
		
		public function Speed(xSpeed:int = 0, ySpeed:int = 0)
		{
			_xSpeed = xSpeed;
			_ySpeed = ySpeed;
			if(xSpeed)
			{
				_k = "" + ySpeed/xSpeed;
			}
			else
			{
				_k = null;
			}
		}

		public function get k():String
		{
			return _k;
		}

//		public function set k(value:String):void
//		{
//			_k = value;
//		}

		public function get ySpeed():int
		{
			return _ySpeed;
		}

		public function set ySpeed(value:int):void
		{
			_ySpeed = value;
			if(xSpeed)
			{
				_k = "" + ySpeed/xSpeed;
			}
			else
			{
				_k = null;
			}
		}

		public function get xSpeed():int
		{
			return _xSpeed;
		}

		public function set xSpeed(value:int):void
		{
			_xSpeed = value;
			if(xSpeed)
			{
				_k = "" + ySpeed/xSpeed;
			}
			else
			{
				_k = null;
			}
		}

	}
}