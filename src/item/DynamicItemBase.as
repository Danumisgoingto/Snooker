package item
{
	import data.GameCache;
	import data.Speed;
	
	import flash.geom.Point;
	
	import global.GameElement;
	import global.UIFactory;
	
	public class DynamicItemBase extends ItemBase
	{
		protected var _speed:Speed;
		
		//是否受摩擦力，默认是true
		protected var _isHasFriction:Boolean;
		//是否唤醒，唤醒才参与更新
		private var _isAwake:Boolean;
		
		private var _positionGlobal:Point;
		private var _positionLocal:Point;
		
		//碰撞检测点，点越多，碰撞检测越精确
		protected var _crashPointList:Array;
		
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
		
		public function setSpeed(speed:int, k:String, multi:int = 1):void
		{
			if(k)
			{
				_speed.xSpeed = speed;
				k = "" + (multi*Number(k));
				_speed.ySpeed = Number(k)*speed;
			}
			else
			{
				_speed.xSpeed = 0;
				_speed.ySpeed = speed;
			}
			if(speed)
			{
				this.isAwake = true;
			}
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
		
		/**
		 *  提供复写
		 *  设置检测点
		 **/
		protected function setCrashPoint():void
		{
			_crashPointList = [];
		}
		
		public function get crashPointList():Array
		{
			return _crashPointList;
		}
		
		/**
		 *  进行复写
		 *  碰撞检测
		 **/
		override public function crashCheck(aItem:ItemBase):void
		{
			super.crashCheck(aItem);
			
			if(isCrash)
			{
				if(kTemp2)
				{
					this.setSpeed(-itemSpeed, "" + 1/kTemp2, -1);
				}
				else
				{
					this.setSpeed(-itemSpeed, null);
				}
				isCrash = false;
				kTemp2 = 0;
				itemSpeed = 0;
			}
		}
		
		
		public function move():void
		{
			
			if(_isHasFriction)
			{
				_speed.xSpeed = Math.abs(_speed.xSpeed) - GameCache.FRICTION < 0 ?
					0 : (_speed.xSpeed/Math.abs(_speed.xSpeed)) * (Math.abs(_speed.xSpeed) - GameCache.FRICTION);
				_speed.ySpeed = Math.abs(_speed.ySpeed) - GameCache.FRICTION < 0 ?
					0 : (_speed.ySpeed/Math.abs(_speed.ySpeed)) * (Math.abs(_speed.ySpeed) - GameCache.FRICTION);
				
				if(0 == _speed.xSpeed && 0 == _speed.ySpeed)
				{
					this.isAwake = false;
				}
			}
				
			//调试
			if(GameCache.fps)
			{
				/*这里完成不受fps影响的速率*/
				_positionGlobal = UIFactory.getGlobalPos(this, GameCache.ORIGIN_POINT);
				_positionGlobal.x += _speed.xSpeed/GameCache.fps;
				_positionGlobal.y += _speed.ySpeed/GameCache.fps;
				_positionLocal = UIFactory.getLocalPos((this.parent as GameElement), _positionGlobal);
				this.x = _positionLocal.x;
				this.y = _positionLocal.y;
//				this.x = x + _speed.xSpeed/GameCache.fps;
//				this.y = y + _speed.ySpeed/GameCache.fps;
				
				setCrashPoint();
			}
			
		}
		
		
		
	}
}