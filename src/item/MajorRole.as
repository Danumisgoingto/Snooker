package item
{
	import global.UIFactory;

	public class MajorRole extends DynamicItemBase
	{
		//常量
		private static var _instance:MajorRole;
		
		//显示对象
		private var _ballWhite:Ball;
		
		public function MajorRole()
		{
			super(295+20, 20);
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
			
			_ballWhite = UIFactory.createBall("", 10, 
			
		}
		

	}
}