package item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	
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
//			var command:Vector.<int> = [1, 2, 2, 2, 2];
			var command:Vector.<int> = new Vector.<int>();
			command[0] = 1;
			command[1] = 2;
			command[2] = 2;
			command[3] = 2;
			command[4] = 2;
//			var point:Vector.<int> = [295, 5, 0, 0, 0, 15, 295, 10, 295, 5];
			var point:Vector.<Number> = new Vector.<Number>();
			point[0] = 295;
			point[1] = 5;
			point[2] = 0;
			point[3] = 0;
			point[4] = 0;
			point[5] = 15;
			point[6] = 295;
			point[7] = 10;
			point[8] = 295;
			point[9] = 5;
			
			_sprite = new Shape();
			(_sprite as Shape).graphics.beginFill(0x000000);
			(_sprite as Shape).graphics.drawPath(command, point);
			(_sprite as Shape).graphics.endFill();
			
			super.setSprite();
		}
		
	}
}