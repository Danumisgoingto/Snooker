package director
{
	
	import data.GameCache;
	
	import controller.GameController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import global.PoolManager;
	import global.UIFactory;
	
	import scene.BeginScene;
	import scene.SceneBase;
	import scene.Table;

	public class Director extends Sprite
	{
		//常量
		private static var _instance:Director = new Director();
		
		//显示对象
		private var _debugTab:TextField;
		private var _curScene:SceneBase = null;
		
		
		//数据
		private var _now:int;
		private var _frameLast:int;//上一帧的时间
		private var _frameCount:int;
		
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
			
			initGame();
		}
		
		private function initGame():void
		{
			this.y = GameCache.GAME_WIN_Y;
			this.x = GameCache.GAME_WIN_X;
			new GameController();
			this.curScene = Table.instance;//BeginScene.instance;
			_debugTab = UIFactory.TextFeild("", 10, 10, this);
		}
		
		
		public function set curScene(value:SceneBase):void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, updateFrame);
			}
			if(_curScene)
			{
				this.removeChild(_curScene);
//				_curScene.dispose();
			}
			_curScene = value;
			_curScene.load();
		}
		
		public function pause():void
		{
			if(hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, updateFrame);
			}
		}
		
		public function start():void
		{
			if(!hasEventListener(Event.ENTER_FRAME))
			{
				this.addEventListener(Event.ENTER_FRAME, updateFrame);
			}
		}
		
		private function updateFrame(evt:Event):void
		{
			updateFps();
			_curScene.update();
		}
		
		private function updateFps():void
		{
			_now = getTimer();
			var pass:int = _now - _frameLast;//已经过了多少时间
			_frameCount++;
			
			if(pass > 1000)
			{
				GameCache.fps = _frameCount / pass * 1000;
				var fps:int = GameCache.fps;
				_frameLast = _now;
				_frameCount = 0;
				_debugTab.text = "FPS:" + GameCache.fps.toFixed(2);
			}
		}
		
	}
}