package item
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import global.GameElement;

	public class ItemBase extends GameElement implements Iitem
	{
		protected var _sprite:DisplayObject;
		
		public function ItemBase(url:String)
		{
			super(url);
		}
		
		/**load**/
		override protected function createElement():void
		{
			super.createElement();
			this.setSprite();
		}
		
		override protected function loadedCallback(bitmap:Bitmap):void
		{
			super.loadedCallback(bitmap);
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
         	this.addChild(_sprite);
		 }
		
		 public function get sprite():DisplayObject
		 {
			 return _sprite;
		 }
		 
	}
}