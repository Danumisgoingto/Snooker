package item
{
	import flash.display.DisplayObject;
	
	import global.GameElement;
	import global.LoadManager;
	import global.PoolManager;

	public class ItemBase extends GameElement implements Iitem
	{
		protected var _sprite:DisplayObject;
		protected var _loader:LoadManager;
		
		public function ItemBase(url:String, loader:LoadManager)
		{
//		    UIFactory.image(url, this, 0, loadedCallback);	
//			this.x = x;
//			this.y = y;
//			parent.addChild(this);
			super(url, loader);
			_loader = loader;
			this.setSprite();
		}
		
		override public function allLoaded():void
		{
//			_sprite.cacheAsBitmap = true;
			_bg.mask = _sprite;
		}
		
		public function setPosition(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function getPosition():Vector.<int, int>
		{
			return new Vector.<int, int>(x, y);
		}
		
		/**
		 *提供复写 
		 */		
         public function setSprite():void
		 {
//			 this.addChild(_sprite);
		 }
		
		 public function get sprite():DisplayObject
		 {
			 return _sprite;
		 }
		 
		 public function dispose():void
		 {
			 PoolManager.instance.addGameElement(this);
		 }
		 
	}
}