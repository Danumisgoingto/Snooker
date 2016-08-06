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
		//常量
		private static var _instance:BeginScene = new BeginScene();
		
		//
		private var _beginText:TextField;
		
		public function BeginScene()
		{
			super(ImagesConst.BeginSceneBg);
			if(_instance)
			{
				throw Error("BeginScene不是单例");
			}
		}
		
		public static function get instance():BeginScene
		{
			return _instance;
		}
		
		override protected function init():void
		{
			_beginText = UIFactory.TextFeild("开始游戏", 300, 300, this);
			_beginText.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		
		private function clickHandler(evt:Event):void
		{
			Director.instance.curScene = Table.instance;
//				PoolManager.instance.getScene(Table);
		}
		
	}
}