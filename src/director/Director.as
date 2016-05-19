package director
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import global.PoolManager;
	
	import scene.BeginScene;
	import scene.SceneBase;

	public class Director extends Sprite
	{
		
		private static var _instance:Director;
		private var _curScene:SceneBase = null;
		private var _fps:int;
		private var _timer:Timer;
		
		public function Director()
		{
			init();
		}
		

		public static function get instance():Director
		{
			if(!_instance)
			{
				_instance = new Director();
			}
			return _instance;
		}
		
		private function init():void
		{
			_fps = 30; //默认fps为60
			_timer = new Timer(1000/_fps);
			_timer.addEventListener(TimerEvent.TIMER, repaint);
			this.curScene = PoolManager.instance.getScene(BeginScene);
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
				_curScene.dispose();
			}
			_curScene = value;
			this.addChild(_curScene);
			_timer.start();
		}
		
		public function get fps():int
		{
			return _fps;
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