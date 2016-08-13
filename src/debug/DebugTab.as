package debug
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.flash_proxy;
	import flash.utils.getTimer;
	
	import global.UIFactory;
	
	public class DebugTab extends Sprite
	{
		//显示对象
		private var _fpsText:TextField;
		
		//数据
		private var _now:int;
		private var _frameLast:int;//上一帧的时间
		private var _frameCount:int;
		private var _fps:Number;
		
		public function DebugTab(parent:Sprite, x:Number = 0 , y:Number = 0)
		{
			super();
			
			initData();
			initView();
			this.x = x;
			this.y = y;
			parent.addChild(this);
		}
		
		private function initData():void
		{
		}
		
		private function initView():void
		{
			_fpsText = UIFactory.TextFeild("", 0, 0, this);
		}
		
		public function updateFps():void
		{
			_now = getTimer();
			var pass:int = _now - _frameLast;//已经过了多少时间
			_frameCount++;
			
			if(pass > 1000)
			{
				_fps = _frameCount / pass * 1000;
				_frameLast = _now;
				_frameCount = 0;
				_fpsText.text = "FPS:" + _fps.toFixed(2);
			}
		}
		
	}
}