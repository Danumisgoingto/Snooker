package controller
{
	import event.GameEvent;
	import event.GameEventDispatcher;

	public class GameController
	{
		public function GameController()
		{	
			GameEventDispatcher.addEventListener(GameEvent.Game_Pause, gamePause);
			
			
			initController();
		}
		
		private function initController():void
		{
			new LoadController();
		}
		
		private function gamePause():void
		{
			
		}
	}
}