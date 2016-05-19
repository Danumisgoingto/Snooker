package scene
{
	import director.Director;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import global.ImagesConst;
	import global.PoolManager;
	import global.UIFactory;

	public class BeginScene extends SceneBase
	{
		private var _beginText:TextField;
		
		public function BeginScene()
		{
			super(ImagesConst.BeginSceneBg);
		}
		
		override protected function init():void
		{
			_beginText = UIFactory.TextFeild("开始游戏", 300, 300, this);
			_beginText.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(evt:Event):void
		{
			Director.instance.curScene = 
				PoolManager.instance.getScene(Table);
		}
		
	}
}