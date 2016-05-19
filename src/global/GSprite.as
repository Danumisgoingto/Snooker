package global
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class GSprite extends Sprite
	{
		private var _childList:Array;
		private var _bitMapList:Array;
		
		public function GSprite()
		{
			super();
		}
		


		public function addChild(child:GSprite):void
		{
			_childList.push(child);	
		}
		
		
		public function get childList():Array
		{
			return _childList;
		}

		public function draw():void
		{
			for each(var child:GSprite in _childList)
			{
				child.draw();
			}
			
		}
		
	}
}