package item
{
	import cache.GameCache;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	
	import global.GameElement;
	import global.LoadManager;
	
	public class DynamicItemBase extends ItemBase
	{
		protected var _speed:Object;
		
		public function DynamicItemBase(url:String = null)
		{
			super(url);
			_speed = {xSpeed:0, ySpeed:0};
		}
		
		public function set speed(value:Object):void
		{
			this._speed = value;
		}
		
		public function get speed():Object
		{
			return _speed;
		}
		
		public function move():void
		{
			var fps:int = GameCache.fps;
			_speed.xSpeed = _speed.xSpeed - GameCache.FRICTION;
			_speed.ySpeed = _speed.ySpeed - GameCache.FRICTION;
			if(fps)
			{
				/*这里完成不受fps影响的速率*/
				if(_speed.xSpeed > 0)
				{
					this.x = x + _speed.xSpeed/GameCache.fps;
				}
				if(_speed.ySpeed > 0)
				{
					this.y = y + _speed.ySpeed/GameCache.fps;
				}
			}
			
		}
	}
}