package global
{
	import event.GameEvent;
	import event.GameEventDispatcher;

	public class GameController
	{
		public function GameController()
		{
			var gameController:GameEventDispatcher = new GameEventDispatcher();
			
			gameController.addEventListener(GameEvent.Game_Pause, gamePause);
			
		}
		
		private function gamePause():void
		{
			
		}
	}
}