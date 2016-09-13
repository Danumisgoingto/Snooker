package scene
{
	
	import director.Director;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import global.GameElement;
	import global.LoadManager;
	
	import item.ItemBase;

	public class SceneBase extends GameElement implements IScene
	{	
		protected var _loader:LoadManager;
		
		//======双缓冲技术
		private var _canvas:Sprite;//画板
		private var _canvasRect:Rectangle;
        private var _canvasBuff:BitmapData;//缓冲画板
		
		public function SceneBase(url:String = null, width:int = 0, height:int = 0)
		{
			super(url, width, height);
		}
		
		/** init*/
		override protected function initData():void
		{
			super.initData();
			_loader = new LoadManager(this);
			if(url && "" != url)
			{
				_loader.addToLoadingQueues(url, loadedCallback);
			}
			
		}
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			_canvas = new Sprite();
		}
		
		
		public function load():void
		{
			_loader.load();
		}
		
		override public function addItem(gameItem:ItemBase, x:int = 0, y:int = 0):void
		{
			super.addItem(gameItem, x, y);
			addToLoadingQueues(gameItem);
		}
		
	    private function addToLoadingQueues(gameItem:ItemBase):void
		{
			if(gameItem.itemList.length)
			{
				for each(var aItem:ItemBase in gameItem.itemList)
				{
					if(aItem.itemList.length)
					{
						addToLoadingQueues(aItem);
					}
					else
					{
						addSingleItem(aItem);
					}
				}
			}
			else
			{
				addSingleItem(gameItem);
			}
			
			function addSingleItem(aItem:ItemBase):void
			{
				if(aItem.url && "" != aItem.url)
				{
					_loader.addToLoadingQueues(aItem, aItem.callback);
				}
			}
		}
		
		/**
		 *  获取画板，用于侦听
		 **/
		public function get canvas():Sprite
		{
			return _canvas;
		}
		
	 	public function allLoaded():void
		{
			_canvasRect = new Rectangle(0, 0, getWidth(), getHeight());
			_canvasBuff = new BitmapData(getWidth(), getHeight());
			_canvasBuff.draw(this, null, null, null, null, true);
			
			_canvas.graphics.beginBitmapFill(_canvasBuff, null, true, true);
			_canvas.graphics.drawRect(0, 0, getWidth(), getHeight());
			_canvas.graphics.endFill();
			
			Director.instance.addChildAt(_canvas, 0);
			/*到完全加载完才添加心跳侦听*/
			Director.instance.start();
		}
		
		public function update():void
		{
			//清除上一帧
			_canvasBuff.fillRect(_canvasRect, 0x00000000);//擦除缓冲画板
			_canvas.graphics.clear();//擦除画板

			repaint();
			
			_canvasBuff.draw(this, null, null, null, null, true);
			//画完了再显示到屏幕上
			_canvas.graphics.beginBitmapFill(_canvasBuff, null, true, true);
			_canvas.graphics.drawRect(0, 0, getWidth(), getHeight());
			_canvas.graphics.endFill();
			
		}
		
		
		/**
		 *  提供复写
		 *  重画场景类
		 **/
		protected function repaint():void
		{
			
		}
		
		
	}
}