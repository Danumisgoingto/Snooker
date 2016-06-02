package controller
{
	import event.LoadEvent;
	import event.LoadEventDispatcher;

	public class LoadManagerController
	{
		public function LoadManagerController()
		{
			var gameController:LoadEventDispatcher = new LoadEventDispatcher();
			
			gameController.addEventListener(LoadEvent.Load_Complete, loadCompleteHandler);
		}
		
		private function loadCompleteHandler(evt:*):void
		{
			
		}
	}
}