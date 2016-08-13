package director
{
	
	import controller.GameController;
	
	import debug.DebugTab;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import global.PoolManager;
	
	import scene.BeginScene;
	import scene.SceneBase;

	public class Director extends Sprite
	{
		//常量
		private static var _instance:Director = new Director();
		
		//显示对象
		private var _debugTab:DebugTab;
		private var _curScene:SceneBase = null;
		
		
		public function Director()
		{
			if(_instance)
			{
				throw Error("Director不是单例");
			}
			if(null != stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		

		public static function get instance():Director
		{
			return _instance;
		}
		
		private function init(evt:Event = null):void
		{
			if(hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
				
			this.y = 24;
			this.x = 141;
			new GameController();
			this.curScene = BeginScene.instance;
			_debugTab = new DebugTab(this, 10, 10);
			this.addEventListener(Event.ENTER_FRAME, repaint);
		}
		
		
		public function set curScene(value:SceneBase):void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, repaint);
			}
			if(_curScene)
			{
				this.removeChild(_curScene);
//				_curScene.dispose();
			}
			_curScene = value;
			this.addChildAt(_curScene, 0);
			this.addEventListener(Event.ENTER_FRAME, repaint);
		}
		
		public function pause():void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, repaint);
			}
		}
		
		public function start():void
		{
			if(!hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, repaint);
			}
		}
		
		private function repaint(evt:Event):void
		{
			_debugTab.updateFps();
			_curScene.update();
		}
	}
}