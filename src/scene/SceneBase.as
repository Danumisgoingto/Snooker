package scene
{
	
	import director.Director;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
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
		private var _sprite:Sprite;
		private var _sceneBuff:Bitmap;
		private var _sceneBuffData:BitmapData;
		
		public function SceneBase(url:String = null)
		{
			_loader = new LoadManager(this);
			if(url && url != "")
			{
				_loader.addToLoadingQueues(url, loadedCallback);
			}
			super(url);
		}
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			_sceneBuff = new Bitmap();
			_sprite = new Sprite();
		}
		
		
		public function load():void
		{
			_loader.load();
		}
		
		public function addItem(gameItem:ItemBase):void
		{
			if(gameItem.url && gameItem.url != "")
			{
				_loader.addToLoadingQueues(gameItem, gameItem.callback);
			}
		}
		
		/**
		 *  获取画布的容器，用于侦听
		 **/
		public function get sprite():Sprite
		{
			return _sprite;
		}
		
	 	public function allLoaded():void
		{
			var arr:Array = _loader.loadList;
			for(var i:int; i < arr.length; i++)
			{
				if(arr[i] is String)
				{
					continue;
				}
				this.addChild(arr[i]);
			}
			
			_sceneBuffData = new BitmapData(_bg.width, _bg.height);
			_sceneBuffData.draw(this);
			_sceneBuff.bitmapData = _sceneBuffData;
			_sprite.addChild(_sceneBuff);
			
			Director.instance.addChildAt(_sprite, 0);
			/*到完全加载完才添加心跳侦听*/
			Director.instance.addEventListener(Event.ENTER_FRAME, Director.instance.repaint);
		}
		
		public function update():void
		{
			//清除上一帧
			_sceneBuffData = new BitmapData(_bg.width, _bg.height);
			
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