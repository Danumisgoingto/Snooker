package controller
{
	import director.Director;
	
	import event.LoadEvent;
	import event.LoadEventDispatcher;
	
	import scene.SceneBase;

	public class LoadController
	{
		public function LoadController()
		{	
			LoadEventDispatcher.addEventListener(LoadEvent.AllLoad_Complete, loadCompleteHandler);
		}
		
		private function loadCompleteHandler(evt:LoadEvent):void
		{
			if(evt.scene)
			{
				(evt.scene as SceneBase).allLoaded();
			}
			
		}
	}
}