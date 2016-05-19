package
{
	import director.Director;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	public class Snooker extends Sprite
	{
	
		public function Snooker()
		{
			stage.frameRate = 60; //这是舞台的帧率，默认是60，如果Director的fps
								 //发生改变，则这里也要跟随改变
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.addChild(Director.instance);
//			this.addChild(Director1.instance);
			
//			this.graphics.lineStyle(3, 0x000000);
//			this.graphics.drawCircle(100,100,30);
//			this.graphics.drawCircle(100,100, 25);
//			this.graphics.endFill();
			

		}
	
	
		
	}
}