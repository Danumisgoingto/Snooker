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
		 *  提供复写
		 *  通过碰撞点获取法线
		 **/
		 protected function getNormalLine(crashPoint:Point):String
		 {
			 return null;
		 }
		 
		 
		 /**
		  *  碰撞检测
		  **/
		 protected var kTemp2:Number;
		 protected var itemSpeed:int;
		 protected var isCrash:Boolean;
		 public function crashCheck(aItem:ItemBase):void
		 {
			 var k1:String;
			 var k2:String;
			 var kTemp1:Number;
			 
			 if(aItem is DynamicItemBase)
			 {
				 for each(var point:Point in (aItem as DynamicItemBase).crashPointList)
				 {
					 if(this.sprite.hitTestPoint(point.x, point.y))
					 {
						 isCrash = true;
						 k1 = getNormalLine(point);
						 k2 = (aItem as DynamicItemBase).speed.k;
						 if(k2)
						 {
							 itemSpeed = (aItem as DynamicItemBase).speed.xSpeed;
						 }
						 else
						 {
							 itemSpeed = (aItem as DynamicItemBase).speed.ySpeed;
						 }
						 
						 if(null == k1)
						 {
							 (aItem as DynamicItemBase).setSpeed(-itemSpeed, k2, -1);
							 return;
						 }
						 else if(null == k2)
						 {
							 kTemp1  = Number(k1);
							 if(kTemp1)
							 {
								 k2 = "" + ((kTemp1*kTemp1 - 1) / 2*kTemp1);
							 }
							 (aItem as DynamicItemBase).setSpeed(-itemSpeed, k2);
							 return;
						 }
						 else
						 {
							 kTemp1 = Number(k1);
							 kTemp2 = Number(k2);
							 //如果垂直
							 if(-1 == kTemp1 * kTemp2)
							 {
								 (aItem as DynamicItemBase).setSpeed(-itemSpeed, k2);
								 return;
							 }
							 else
							 {
								 k2 = "" + ((2*kTemp1 - kTemp2*(1-kTemp1*kTemp1))
								 			/ ((1-kTemp1*kTemp1) + 2*kTemp1*kTemp2));
								 (aItem as DynamicItemBase).setSpeed(itemSpeed, k2);
								 return;
							 }
						 }
					 }
				 }
			 }
		 }
		 
	}
}