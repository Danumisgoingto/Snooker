package event
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const Game_Start:String = "Game_Start";
		public static const Game_Pause:String = "Game_Pause";
		
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}