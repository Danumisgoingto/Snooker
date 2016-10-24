package scene
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import global.UIFactory;
	
	import item.Ball;
	import item.Edge;

	public class Table extends GameSceneBase
	{
		//======静态变量
		private static var _instance:Table;
		
		//======调试
		private var _backText:TextField;
		
		//======显示对象
		private var _edgeLeft:Edge;
		private var _edgeTop:Edge;
		private var _edgeRight:Edge;
		private var _edgeBottom:Edge;
		
		private var _b:Ball;
		private var _c:Ball;
		
		public function Table()
		{
			super("",800,505);//ImagesConst.TableBg
			if(_instance)
			{
				throw Error("Table不是单例");
			}
		}
		
		public static function get instance():Table
		{
			if(!_instance)
			{
				_instance = new Table();
			}
			return _instance;
		}

		override protected function createElement():void
		{
			super.createElement();
			
			_backText = UIFactory.TextFeild("", 0, 140, this, 10);
			_backText.width = 200;
			
			_edgeLeft = new Edge("", 10, 505-20);
			this.addItem(_edgeLeft, 0, 10);
			_edgeTop = new Edge("", 800, 10);
			this.addItem(_edgeTop, 0, 0);
			_edgeRight = new Edge("", 10, 505-20);
			this.addItem(_edgeRight, 790, 10);
			_edgeBottom = new Edge("", 800, 10);
			this.addItem(_edgeBottom, 0, 495);
			
//			_c = UIFactory.createBall("", this, 340, 400);
			
			_b = UIFactory.createBall("", this, 200, 200);
			_b.setSpeed(120, "-1");
			
			
		}
		
		override protected function repaint():void
		{
			super.repaint();
			_backText.text = "(mouseX, mouseY): " + mouseX + ", " + mouseY;
		}
		
	}
}