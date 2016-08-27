package scene
{
	
	import director.Director;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import global.GameElement;
	import global.LoadManager;
	import global.UIFactory;
	
	import item.DynamicItemBase;
	import item.ItemBase;

	public class SceneBase extends GameElement implements IScene
	{	
		protected var _loader:LoadManager;
		
		//======双缓冲技术
		private var _canvas:Sprite;
		private var _sceneBuff:Bitmap;
		private var _sceneBuffData:BitmapData;
		
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
			_sceneBuff = new Bitmap(null, "auto", true);
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
		 *  获取画布的容器，用于侦听
		 **/
		public function get canvas():Sprite
		{
			return _canvas;
		}
		
	 	public function allLoaded():void
		{
			_sceneBuffData = new BitmapData(getWidth(), getHeight());
			_sceneBuffData.draw(this);
			_sceneBuff.bitmapData = _sceneBuffData;
			_canvas.addChild(_sceneBuff);
			
			Director.instance.addChildAt(_canvas, 0);
			/*到完全加载完才添加心跳侦听*/
			Director.instance.addEventListener(Event.ENTER_FRAME, Director.instance.updateFrame);
		}
		
		public function update():void
		{
			//清除上一帧
			_sceneBuffData = new BitmapData(getWidth(), getHeight());

			repaint();
			
			_sceneBuffData.draw(this);
			//画完了再显示到屏幕上
			_sceneBuff.bitmapData = _sceneBuffData;
			
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