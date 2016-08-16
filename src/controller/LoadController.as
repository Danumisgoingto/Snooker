package controller
{
	import event.LoadEvent;
	import event.LoadEventDispatcher;

	public class LoadController
	{
		public function LoadController()
		{	
			LoadEventDispatcher.addEventListener(LoadEvent.ALLLOAD_COMPLETE, loadCompleteHandler);
		}
		
		private function loadCompleteHandler(evt:LoadEvent):void
		{
			if(evt.scene)
			{
				evt.scene.allLoaded();
				
			}
			
		}
	}
}