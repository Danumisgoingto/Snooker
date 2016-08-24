package item
{
	import flash.display.Shape;
	
	import global.ImagesConst;
	
	public class Stick extends ItemBase
	{
		//常量
		private static var _instance:Stick;
		
		public function Stick()
		{
			super(ImagesConst.WoodSkin);
			if(_instance)
			{
				throw Error("Stick类不是单例");
			}
		}
		
		public static function get instance():Stick
		{
			if(!_instance)
			{
				_instance = new Stick();
			}
			return _instance;
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
			super.setSprite();
			var command:Vector.<int> = Vector.<int>([1, 2, 2, 2, 2]);
			var point:Vector.<Number> = Vector.<Number>([295, 5, 0, 0, 0, 15, 295, 10, 295, 5]);
			
			_sprite.graphics.beginFill(0x000000);
			_sprite.graphics.drawPath(command, point);
			_sprite.graphics.endFill();
			
			
		}
		
	}
}