package global
{
	import item.ItemBase;
	
	import scene.SceneBase;
	
	public class PoolManager
	{
		//常量
		private static var _instance:PoolManager = new PoolManager();
		
		//数组
		private var _sceneList:Array = new Array();//场景列表
		private var _itemList:Array = new Array();//物品列表
		
		public function PoolManager()
		{
			if(_instance)
			{
				throw Error("PoolManager不是单例");
			}
		}
		
		public static function get instance():PoolManager
		{
			return _instance;
		}
		
		public function addGameElement(aGameElement:GameElement):void
		{
			//如果池中没有该对象就加入池
			if(aGameElement is ItemBase)
			{
				for each(var item:ItemBase in _itemList)
				{
					if(aGameElement == item)
					{
						return;
					}
				}
				this.addGameElement(aGameElement as ItemBase);
			}
			else if(aGameElement is SceneBase)
			{
				for each(var scene:SceneBase in _sceneList)
				{
					if(aGameElement == scene)
					{
						return;
					}
				}
				this.addScene(aGameElement as SceneBase);
			}
		}
		
		private function addItem(aItem:ItemBase):void
		{
			_itemList.push(aItem);
		}
		
		public function getItem(c:Class):ItemBase
		{
			return (this.getGameElement(c, _itemList) as ItemBase);
		}
		
		private function addScene(aScene:SceneBase):void
		{
			_sceneList.push(aScene);
		}
		
		public function getScene(scene:SceneBase):SceneBase
		{
//			return (this.getGameElement(c, _sceneList) as SceneBase);
			for(var i:int = 0; i < _sceneList.length; i++)
			{
				if(scene == _sceneList[i])
				{
					_sceneList.splice(i, 1);
					return scene;
				}
			}
			this.addScene(scene);
			return scene;
		}
		
		//这里是取出第一个加入池的对象
		private function getGameElement(c:Class, list:Array):GameElement
		{
			for(var i:int = 0; i < list.length; i++)
			{
				if(list[i] is c)
				{
					var obj:* = list[i];
					list.splice(i, 1);
					return obj;
				}
			}
			
			return new c();
		}
		
	}
}