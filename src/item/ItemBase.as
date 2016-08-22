package item
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	
	import global.GameElement;
	import global.LoadManager;

	public class ItemBase extends GameElement implements Iitem
	{
		protected var _sprite:Shape;
		
		public function ItemBase(url:String = null, width:int = 0, height:int = 0)
		{
			super(url, width, height);
		}
		
		/**load**/
		override protected function createElement():void
		{
			super.createElement();
			_sprite = new Shape();
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
		 * 设置用来碰撞检测的实体
		 */		
         protected function setSprite():void
		 {
         	this.addChild(_sprite);
		 }
		
		 public function get sprite():Shape
		 {
			 return _sprite;
		 }
		 
	}
}