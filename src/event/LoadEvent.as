package event
{
	import flash.events.Event;
	
	import scene.SceneBase;
	
	
	public class LoadEvent extends Event
	{
		//常量
		public static const ALLLOAD_COMPLETE:String = "ALLLOAD_COMPLETE";
		
		//
		private var _scene:SceneBase;
		
		public function LoadEvent(type:String, scene:SceneBase=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_scene = scene;
			super(type, bubbles, cancelable);
		}

		public function get scene():SceneBase
		{
			return _scene;
		}

	}
}