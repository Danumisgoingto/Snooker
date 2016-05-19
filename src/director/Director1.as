package director
{
	import event.GameEvent;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import global.PoolManager;
	
	import scene.SceneBase;
	import scene.Table;

	public class Director1 extends Sprite
	{
		private static var _instance:Director1;
		private var _fps:int;
		private var _curScene:SceneBase;
		private var _state:String;
		
		public function Director1()
		{
			init();
		}

		public static function get instance():Director1
		{
			if(!_instance)
			{
				_instance = new Director1();
			}
			return _instance;
		}
		
		private function init():void
		{
			_fps = 60; //默认为60
			this.curScene = PoolManager.instance.getScene(Table);
			this.run();
		}
		
		public function run():void
		{
			var skip_tick:Number;
			var sleep_time:Number;
			var time:Date = new Date();
			var next_tick:Number = time.milliseconds;
			while(_state == GameEvent.Game_Start)
			{
				this.repaint();
				skip_tick = 1000 / _fps;
				next_tick += skip_tick;
				sleep_time = next_tick - time.milliseconds;
				if(sleep_time >= 0)
				{
//				  Sleep(sleep_time);
				}
				else
				{
					trace("shit, we are running behind");
				}
			}	
		}
		
		
		public function set state(value:String):void
		{
			_state = value;
		}
		
		public function set curScene(value:SceneBase):void
		{
			_curScene = value;
			this.addChild(_curScene);
		}
		
		
		
		public function repaint():void
		{
			_curScene.update();
			trace("dddddf");
		}
	}
}