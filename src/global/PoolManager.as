package global
{
	import flash.display.Sprite;
	
	import scene.SceneBase;
	
	public class PoolManager
	{
		private var _sceneList:Array = new Array();
		private static var _instance:PoolManager;
		
		public function PoolManager()
		{
		}
		
		public static function get instance():PoolManager
		{
			if(!_instance)
			{
				_instance = new PoolManager();
			}
			return _instance;
		}
		
		public function addScene(aScene:SceneBase):void
		{
			_sceneList.push(aScene);
		}
		
		public function getScene(c:Class):SceneBase
		{
			return this.get(c, _sceneList);
		}
		
		private function get(c:Class, list:Array):*
		{
			for(var i:int = 0; i < list.length; i++)
			{
				if(list[i] is c)
				{
					var obj:* = list[i];
					_sceneList.splice(i, 1);
					return obj;
				}
			}
			
			return new c();
		}
		
	}
}