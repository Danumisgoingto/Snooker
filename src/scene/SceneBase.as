package scene
{
	
	import director.Director;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import global.GameElement;
	import global.LoadManager;
	
	import item.DynamicItemBase;
	import item.ItemBase;

	public class SceneBase extends GameElement implements IScene
	{	
		protected var _loader:LoadManager;
		
		//双缓冲技术
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
			_sceneBuff = new Bitmap();
			_canvas = new Sprite();
		}
		
		
		public function load():void
		{
			_loader.load();
		}
		
		public function addItem(gameItem:ItemBase):void
		{
			if(gameItem.url && "" != gameItem.url)
			{
				_loader.addToLoadingQueues(gameItem, gameItem.callback);
			}
			else
			{
				if(gameItem.sprite)//如果没有bg单有sprite就放到这个列表显示出来
				{
					_loader.addToSpriteList(gameItem);
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
			var loadArr:Array = _loader.loadList;
			var spriteArr:Array = _loader.spriteList;
			for(var i:int; i < loadArr.length; i++)
			{
				if(loadArr[i] is String)
				{
					continue;
				}
				this.addChild(loadArr[i]);
			}
			
			for(i = 0; i < spriteArr.length; i++)
			{
				this.addChild(spriteArr[i]);
			}
			
			_sceneBuffData = new BitmapData(getWidth(), getHeight());
			_sceneBuffData.draw(this);
			_sceneBuff.bitmapData = _sceneBuffData;
			_canvas.addChild(_sceneBuff);
			
			Director.instance.addChildAt(_canvas, 0);
			/*到完全加载完才添加心跳侦听*/
			Director.instance.addEventListener(Event.ENTER_FRAME, Director.instance.repaint);
		}
		
		public function update():void
		{
			//清除上一帧
			_sceneBuffData = new BitmapData(getWidth(), getHeight());
			
			for(var i:uint = 0; i < _loader.loadList.length; i++ )
			{	
				if(_loader.loadList[i] is DynamicItemBase)
				{
					(_loader.loadList[i] as DynamicItemBase).move();
				}
			 
			}
			
			_sceneBuffData.draw(this);
			//画完了再显示到屏幕上
			_sceneBuff.bitmapData = _sceneBuffData;
			
		}
		
		
	}
}