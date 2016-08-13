package event
{
	import flash.events.Event;
	
	import global.GameElement;
	
	public class LoadEvent extends Event
	{
		//常量
		public static const AllLoad_Complete:String = "AllLoad_Complete";
		
		//
		private var _scene:GameElement;
		
		public function LoadEvent(type:String, scene:GameElement=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_scene = scene;
			super(type, bubbles, cancelable);
		}

		public function get scene():GameElement
		{
			return _scene;
		}

	}
}