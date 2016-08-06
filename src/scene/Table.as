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

		override protected function init():void
		{
//			ball_white = new Ball(ImagesConst.BallWhite, this._myLoader, 15);
//			this.addEventListener(MouseEvent.CLICK, clicktable);
//			backText = UIFactory.TextFeild("返回", 0, 300, this);
//			backText.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		override public function allLoaded():void
		{
			super.allLoaded();
//			ball_white.allLoaded();
			
//			ball_white.speed = {xSpeed:0, ySpeed:0};
//			ball_white.setPosition(100, 100);
//			this.addChild(ball_white);
			
			
		}
		
//		private function clicktable(evt:MouseEvent):void
//		{ 
//			if(ball_white.speed.xSpeed == 5)
//			   ball_white.speed.xSpeed = -5;
//			else
//				ball_white.speed.xSpeed = 5;
//		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			Director.instance.curScene = BeginScene.instance;
		}
		
	}
}