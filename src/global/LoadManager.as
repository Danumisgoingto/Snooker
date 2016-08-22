package global 
{
	import event.LoadEvent;
	import event.LoadEventDispatcher;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import item.ItemBase;
	
	import scene.SceneBase;

	public class LoadManager
	{
		private var _loadList:Array = [];//加载队列
		private var _callbackList:Vector.<Function> = new Vector.<Function>();//回调函数队列
		private var _callbackDic:Dictionary = new Dictionary();
	    private var i:int = 0;//已经加载的数量
		
		private var _spriteList:Array = [];//仅有sprite没有bg的ItemBase的列表
		
		private var _scene:SceneBase;
		
		public function LoadManager(scene:SceneBase)
		{	
			_scene = scene;
		}
		
		public function get spriteList():Array
		{
			return _spriteList;
		}

		public function get loadList():Array
		{
			return _loadList;
		}

		public function addToLoadingQueues(param:*, loadedCallback:Function = null):void
		{
			_loadList.push(param);
			_callbackList.push(loadedCallback);
		}
		
		/**
		 *  仅有sprite的itemBase就会放到这个列表显示出来
		 **/
		public function addToSpriteList(element:ItemBase):void
		{
			_spriteList.push(element);
		}
		
		public function load():void
		{
			for each(var param:* in _loadList)
			{
				loadParam(param);
			}
		    //如果加载列表为空，要发送加载完成的信息
			if(0 == _loadList.length)
			{
				LoadEventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.ALLLOAD_COMPLETE, _scene));
			}
		}
		
		private function loadParam(param:*):void
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			if(param is String)
			{
				request = new URLRequest(param);
			}
			else if(param is ItemBase)
			{
				request = new URLRequest(param.url);
			}
			
			
			_callbackDic[loader] = _callbackList[_loadList.indexOf(param)];
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);
		}
		
		public function loaded(evt:Event):void
		{
		  if(null != _callbackDic[evt.target.loader])
		  {
			  _callbackDic[evt.target.loader](evt.target.content as Bitmap);
		  }
		  i++;
		  if(i == _loadList.length)
		  {
			  LoadEventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.ALLLOAD_COMPLETE, _scene));
		  }
		}
		
//		public function dispose():void
//		{
//			for(var i:int; i < _loadList.length; i++)
//			{
//				if(_loadList[i] is GameElement)
//				{
//					_loadList[i].dispose();
//				}
//			}
//		}
		
	}
}