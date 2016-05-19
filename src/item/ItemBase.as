package item
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import global.LoadManager;
	import global.UIFactory;

	public class ItemBase extends Sprite implements Iitem
	{
		protected var _sprite:DisplayObject;
		
		public function ItemBase(url:String, parent:DisplayObjectContainer, x:int = 0, y:int = 0)
		{
			UIFactory.image(url, this, 0, loadedCallback);	
			this.x = x;
			this.y = y;
			parent.addChild(this);
		}
		
		
		private function loadedCallback():void
		{
			this.setSprite();
			_sprite.cacheAsBitmap = true;
			(this.getChildAt(0) as Bitmap).mask = _sprite;
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
			 this.addChild(_sprite);
		 }
		
		 public function get sprite():DisplayObject
		 {
			 return _sprite;
		 }
		 
	}
}