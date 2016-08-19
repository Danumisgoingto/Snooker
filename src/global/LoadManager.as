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
		
		private var _scene:SceneBase;
		
		public function LoadManager(scene:SceneBase)
		{	
			_scene = scene;
		}
		
		public function get loadList():Array
		{
			return _loadList;
		}

		public function addToLoadingQueues(url:*, loadedCallback:Function = null):void
		{
			_loadList.push(url);
			_callbackList.push(loadedCallback);
		}
		
		public function load():void
		{
			for each(var url:* in _loadList)
			{
				loadImg(url);
			}
		    //如果加载列表为空，要发送加载完成的信息
			if(0 == _loadList.length)
			{
				LoadEventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.ALLLOAD_COMPLETE, _scene));
			}
		}
		
		private function loadImg(url:*):void
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			if(url is String)
			{
				request = new URLRequest(url);
			}
			else if(url is ItemBase)
			{
				request = new URLRequest(url.url);
			}
			
			
			_callbackDic[loader] = _callbackList[_loadList.indexOf(url)];
			
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