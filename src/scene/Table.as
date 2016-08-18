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
		//常量
		private static var _instance:Table = new Table();
		
		//
		private var ball_white:DynamicItemBase;
		private var backText:TextField;
		
		public function Table()
		{
			super(ImagesConst.TableBg);
			if(_instance)
			{
				throw Error("Table不是单例");
			}
		}
		
		public static function get instance():Table
		{
			return _instance;
		}

		override protected function createElement():void
		{
			super.createElement();
			
			ball_white = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 20, 20);
//			ball_white.speed["xSpeed"] = 800;
			
			UIFactory.createStick(ImagesConst.WoodSkin, this, 100, 100);
//			
//			var ball_white1:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 30, 30);
//			var ball_white2:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 40, 40);
//			var ball_white3:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 50, 50);
//			var ball_white4:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 60, 60);
//			var ball_white5:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 70, 70);
//			var ball_white6:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 80, 80);
//			var ball_white7:Ball = UIFactory.createBall(ImagesConst.BallWhite, 10, this, 90, 90);
			
			
			
			
			sprite.addEventListener(MouseEvent.CLICK, clicktable);
//			backText = UIFactory.TextFeild("返回", 0, 300, this);
//			backText.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clicktable(evt:MouseEvent):void
		{ 
			if(ball_white.speed.xSpeed == 800)
			   ball_white.speed.xSpeed = -800;
			else
				ball_white.speed.xSpeed = 800;
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			Director.instance.curScene = BeginScene.instance;
		}
		
	}
}