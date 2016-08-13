package
{
	import director.Director;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	[SWF(width = "1430", height = "770")]
	public class Snooker extends Sprite
	{
	
		public function Snooker()
		{
			stage.frameRate = 60; //这是舞台的帧率，默认是60
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.addChild(Director.instance);

		}
	
	
		
	}
}