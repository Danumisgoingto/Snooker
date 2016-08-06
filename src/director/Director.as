package director
{
	
	import controller.GameController;
	
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
		
		//
		private var _curScene:SceneBase = null;
		private var _fps:int;
		private var _timer:Timer;
		
		public function Director()
		{
			if(_instance)
			{
				throw Error("Director不是单例");
			}
			init();
		}
		

		public static function get instance():Director
		{
			return _instance;
		}
		
		private function init():void
		{
			_fps = 60; //默认fps为60
			_timer = new Timer(1000/_fps);
			_timer.addEventListener(TimerEvent.TIMER, repaint);
			new GameController();
			this.curScene = BeginScene.instance;
//			this.addEventListener(Event.ENTER_FRAME, repaint);
//			TweenMax.to(_curScene, 5, {"x":400});
		}
		
		
		public function set curScene(value:SceneBase):void
		{
			if(_timer.running)
			{
				_timer.stop();
			}
			if(_curScene)
			{
				this.removeChild(_curScene);
//				_curScene.dispose();
			}
			_curScene = value;
			this.addChild(_curScene);
			_timer.start();
		}
		
		public function set fps(fps:int):void
		{
			if(fps > 60)
			{	
				trace("fps等于60已经是极限");
				this._fps = 60;
			}
			this._fps = fps;
			_timer.delay = 1000/this._fps;
		}
		
		public function pause():void
		{
			_timer.stop();
		}
		
		public function start():void
		{
			_timer.start();
		}
		
		public function isRunning():Boolean
		{
			return _timer.running;
		}
		
		private function repaint(evt:Event):void
		{
			_curScene.update();
		}
	}
}