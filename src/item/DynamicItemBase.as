package item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	
	import global.LoadManager;
	
	public class DynamicItemBase extends ItemBase
	{
		protected var _speed:Object;
		
		public function DynamicItemBase(url:String, loader:LoadManager, x:int=0, y:int=0)
		{
			super(url, loader);
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
			this.x = x + _speed.xSpeed;
			this.y = y + _speed.ySpeed;
		}
	}
}