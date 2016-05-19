package
{
	import director.Director;
	import director.Director1;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	public class Snooker extends Sprite
	{
	
		public function Snooker()
		{
			stage.frameRate = 60;
//			stage.scaleMode = StageScaleMode.EXACT_FIT;
			this.addChild(Director.instance);
//			this.addChild(Director1.instance);
		}
		
	
		
	}
}