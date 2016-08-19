package item
{
	import flash.display.Shape;
	
	import global.ImagesConst;
	
	public class Stick extends ItemBase
	{
		public function Stick(url:String)
		{
			super(url);
		}
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			_scaleMod = true;
			setWAndH(295, 15);
		}
		
		override protected function setSprite():void
		{
			var command:Vector.<int> = Vector.<int>([1, 2, 2, 2, 2]);
			var point:Vector.<Number> = Vector.<Number>([295, 5, 0, 0, 0, 15, 295, 10, 295, 5]);
			
			_sprite = new Shape();
			(_sprite as Shape).graphics.beginFill(0x000000);
			(_sprite as Shape).graphics.drawPath(command, point);
			(_sprite as Shape).graphics.endFill();
			
			super.setSprite();
		}
		
	}
}