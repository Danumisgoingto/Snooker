package item
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import global.GameElement;

	public class ItemBase extends GameElement implements Iitem
	{
		protected var _sprite:Shape;
		
		protected var _itemList:Array;
		
		public function ItemBase(url:String = null, width:int = 0, height:int = 0)
		{
			super(url, width, height);
		}
		
		public function get itemList():Array
		{
			return _itemList;
		}

		/** init*/
		override protected function initData():void
		{
			super.initData();
			_itemList = [];
		}
		
		/**load**/
		override protected function createElement():void
		{
			super.createElement();
			_sprite = new Shape();
			this.setSprite();
		}
		
		override public function addItem(gameItem:ItemBase, x:int = 0, y:int = 0):void
		{
			super.addItem(gameItem, x, y);
			_itemList.push(gameItem);
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
		
		public function getPosition():Point
		{
			return new Point(x, y);
		}
		
		/**
		 * 提供复写 
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
		 
		 
		 /**
		  *  碰撞检测
		  **/
		 public function crashCheck(aItem:ItemBase):void
		 {
			 
			 
			 
			 
		 }
		 
	}
}