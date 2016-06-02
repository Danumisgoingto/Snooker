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
		
		
		public static function image(url:String, parent:DisplayObjectContainer, 
									 z_index:int = 0, loadedCallback:Function = null):void
		{
			new LoadManager().loadImg(url, callBack);
			function callBack(bitmap:Bitmap):void
			{
				if(null != loadedCallback)
				{
					loadedCallback(bitmap);
				}
				parent.addChild(bitmap);
				parent.setChildIndex(bitmap, z_index);
			}
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