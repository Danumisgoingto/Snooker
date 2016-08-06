package global
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class UIFactory
	{
		public function UIFactory()
		{
		}
		
		
		public static function addToLoadQueue():void
		{
			
		}
		
		
		public static function TextFeild(text:String, x:int, y:int, parent:DisplayObjectContainer,
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
	}
}