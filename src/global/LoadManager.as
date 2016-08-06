package global 
{
	import event.LoadEvent;
	import event.LoadEventDispatcher;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import scene.SceneBase;

	public class LoadManager
	{
		private var _loadList:Vector.<String> = new Vector.<String>();//加载队列
		private var _callbackList:Vector.<Function> = new Vector.<Function>();//回调函数队列
	    private var i:int = 0;//已经加载的数量
		private var _scene:SceneBase;
		
		public function LoadManager(scene:SceneBase)
		{	
			_scene = scene;
		}
		
		
		public function addToloadingQueues(url:String, loadedCallback:Function = null):void
		{
			_loadList.push(url);
			_callbackList.push(loadedCallback);
		}
		
		public function load():void
		{
			for each(var url:String in _loadList)
			{
				loadImg(url);
			}
		}
		
		
		private function loadImg(url:String):void
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(url);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);
		}
		
		private function loaded(evt:Event):void
		{
		  if(null != _callbackList[i])
		  {
			  _callbackList[i](evt.target.content as Bitmap);
		  }
		  i++;
		  if(i == _loadList.length)
		  {
			  LoadEventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.AllLoad_Complete, _scene));
		  }
		}
		
		
		
	}
}