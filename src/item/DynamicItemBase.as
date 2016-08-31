package item
{
	import data.GameCache;
	import data.Speed;
	
	import flash.geom.Point;
	
	public class DynamicItemBase extends ItemBase
	{
		protected var _speed:Speed;
		
		//是否受摩擦力，默认是true
		protected var _isHasFriction:Boolean;
		//是否唤醒，唤醒才参与更新
		private var _isAwake:Boolean;
		
		public function DynamicItemBase(url:String = null, width:int = 0, height:int = 0)
		{
			super(url, width, height);
		}
		
		/** init*/
		override protected function initData():void
		{
			super.initData();
			_speed = new Speed();
			_isHasFriction = true;
		}
		
		public function setSpeed(xSpeed:int, ySpeed:int):void
		{
			_speed.xSpeed = xSpeed;
			_speed.ySpeed = ySpeed;
		}
		
		public function get speed():Speed
		{
			return _speed;
		}
		
		public function set isAwake(value:Boolean):void
		{
			_isAwake = value;
		}
		
		public function get isAwake():Boolean
		{
			return _isAwake;
		}
		
		
		public function move():void
		{
			
			if(_isHasFriction)
			{
				_speed.xSpeed = _speed.xSpeed - GameCache.FRICTION < 0 ?
					0 : _speed.xSpeed - GameCache.FRICTION;
				_speed.ySpeed = _speed.ySpeed - GameCache.FRICTION < 0 ?
					0 : _speed.ySpeed - GameCache.FRICTION;
				
				if(0 == _speed.xSpeed && 0 == _speed.ySpeed)
				{
					this.isAwake = false;
				}
			}
				
			//调试
			if(GameCache.fps)
			{
				/*这里完成不受fps影响的速率*/
				this.x = x + _speed.xSpeed/GameCache.fps;
				this.y = y + _speed.ySpeed/GameCache.fps;
			}
			
		}
		
		/**
		 *  碰撞检测
		 **/
		public function crashCheck(aItem:ItemBase):void
		{
			if(aItem is DynamicItemBase)
			{
//				aItem.sprite.hi
			}
		}
		
	}
}