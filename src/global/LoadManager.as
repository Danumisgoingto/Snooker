package global 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LoadManager
	{
		private var _myBitmap:Bitmap = null;
		private var _parent:DisplayObjectContainer;
		private var _z:int;
		private var _loadedCallback:Function;
		
		public function LoadManager()
		{	
		}
		
		
		public function loadImg(url:String, parent:DisplayObjectContainer, 
								z:int, loadedCallback:Function):void
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(url);
			
			_parent = parent;
			_z = z;
			_loadedCallback = loadedCallback;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(request);
		}
		
		private function loaded(evt:Event):void
		{
			_myBitmap = evt.target.content as Bitmap;
			this._parent.addChild(_myBitmap);
			this._parent.setChildIndex(_myBitmap, this._z);
			if(null != _loadedCallback)
			{
				 _loadedCallback();
			} 
		}
		
		public function get myBitmap():Bitmap
		{
			return _myBitmap;
		}
	
		
	}
}