package global
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import item.Ball;
	
	import scene.SceneBase;

	public class UIFactory
	{
		public function UIFactory()
		{
		}
		
		
		public static function addToLoadQueue():void
		{
			
		}
		
		
		public static function TextFeild(text:String, x:int, y:int, parent:Sprite,
										 size:int = 25, selectable:Boolean = false):TextField
		{
			var textField:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat();
			
			textFormat.size = size;
			
			textField.selectable = selectable;
			textField.text = text;
			textField.x = x;
			textField.y = y;
			textField.setTextFormat(textFormat);
			parent.addChild(textField);
			return textField;
		}
		
		public static function createBall(url:String , r:int, aScene:SceneBase, x:int, y:int):Ball
		{
			var ball:Ball = new Ball(url, r);
			ball.x = x;
			ball.y = y;
			aScene.addItem(ball);
			return ball;
		}
		
//		public static function createStick(url:String, aScene:SceneBase, x:int, y:int):Stick
//		{
//			var stick:Stick = new Stick(url);
//			stick.x = x;
//			stick.y = y;
//			aScene.addItem(stick);
//			return stick;
//		}
		
	}
}