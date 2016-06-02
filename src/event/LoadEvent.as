package event
{
	import flash.events.Event;
	
	public class LoadEvent extends Event
	{
		public static const Load_Begin = "Load_Begin";
		public static const Load_Complete = "Load_Complete";
		
		public function LoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}