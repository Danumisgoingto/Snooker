package global 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LoadManager
	{
		private var _loadedCallback:Function;
		
		public function LoadManager()
		{	
		}
		
		public function loadImg(url:String, loadedCallback:Function):void
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(url);
			
			_loadedCallback = loadedCallback;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);
		}
		
		private function loaded(evt:Event):void
		{
			if(null != _loadedCallback)
			{
				 _loadedCallback(evt.target.content as Bitmap);
			} 
		}
		
		
		
	}
}