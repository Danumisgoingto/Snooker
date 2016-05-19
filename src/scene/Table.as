package scene
{
	import director.Director;
	
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import global.ImagesConst;
	import global.PoolManager;
	import global.UIFactory;
	
	import item.Ball;
	import item.DynamicItemBase;
	import item.Iitem;
	
	import org.osmf.elements.BeaconElement;

	public class Table extends SceneBase
	{
		private var ball_white:DynamicItemBase;
		private var backText:TextField;
		
		public function Table()
		{
			super(ImagesConst.TableBg);
		}
		
		override protected function init():void
		{
			ball_white = new Ball(ImagesConst.BallWhite, this, 15, 0, 100);
			ball_white.speed = {xSpeed:5, ySpeed:0};
			this.addEventListener(MouseEvent.CLICK, clicktable);
//			backText = UIFactory.TextFeild("返回", 0, 300, this);
//			backText.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clicktable(evt:MouseEvent):void
		{ 
			if(ball_white.speed.xSpeed == 5)
			   ball_white.speed.xSpeed = -5;
			else
				ball_white.speed.xSpeed = 5;
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			Director.instance.curScene = 
				PoolManager.instance.getScene(BeginScene);
		}
		
	}
}