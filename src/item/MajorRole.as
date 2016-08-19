package item
{
	public class MajorRole extends DynamicItemBase
	{
		//常量
		private static var _instance:MajorRole;
		
		public function MajorRole()
		{
			super();
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

	}
}