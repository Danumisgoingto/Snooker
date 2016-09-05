package global
{
	import data.GameCache;
	
	import director.Director;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
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
		
		public static function createBall(url:String, aElement:GameElement, 
										  x:int = 0, y:int = 0, r:int = GameCache.BALL_RADIUS):Ball
		{
			var ball:Ball = new Ball(url, r);
			aElement.addItem(ball, x, y);
			return ball;
		}
		
		
		/**
		 *  将颜色转化为ARGB
		 **/
		public static function colorToARGB(color:uint):Array
		{
			var a:Number = color >> 24
			var r:Number = (color >> 16) & 0xff;
			var g:Number = (color >> 8) & 0xff;
			var b:Number = color & 0xff;
			
			return [a, r, g, b];  
		}
		
		/**
		 *  将ARGB转化回颜色
		 **/
		public static function ARGBToColor(rgb:Array):uint
		{
			return rgb[0] << 24 | rgb[1] << 16 | rgb[2] << 8 | rgb[3];
		}


		/**
		 *  各种反走样算法，实现的效果都不好啊，而且严重拖低fps
		 *  尝试失败
		 **/
		public static function drawLine(x0:int, y0:int, x1:int, y1:int, multiple:uint):BitmapData
		{
			
			var dx:int = x0 - x1;
			var dy:int = y0 - y1;
			var xStart:int = dx > 0 ? x1 : x0;
			var xEnd:int = dx > 0 ? x0 : x1;
			//斜率
			var k:Number = dy / dx;
			
			var buff:BitmapData = new BitmapData(Math.abs(dx)?Math.abs(dx):50,
				Math.abs(dy)?Math.abs(dy):50, true , 0x00000000);
			
			//n倍的
			var buffN:BitmapData = new BitmapData(Math.abs(dx)?Math.abs(dx)*multiple:50*multiple, 
				Math.abs(dy)?Math.abs(dy)*multiple:50*multiple, true, 0x00000000);
			var blackPixelNum:uint;
			
			
			for(var i:uint; i < Math.abs(dx); i++)
			{
				buffN.setPixel32(xStart + i, k*(xStart + i) + y0 - k*x0, 0xFF000000);
			}
			
			for(var w:uint; w < buff.width; w++)
			{
				for(var h:uint; h < buff.height; h++)
				{
					for(var smallW:uint; smallW < multiple; smallW++)
					{
						for(var smallH:uint; smallH < multiple; smallH++)
						{
							if(0xFF000000 == buffN.getPixel32(w + smallW, h + smallH))
							{
								blackPixelNum++;
							}
						}
						smallH = 0;
					}
					smallW = 0;
					buff.setPixel32(w, h, ARGBToColor( [0xFF * blackPixelNum/multiple*multiple, 0, 0, 0] ));
					blackPixelNum = 0;
				}
				h = 0;
			}
			
			return buff;
		}
		
		
		/**
		 *  将坐标转化为舞台的全局坐标
		 **/
		public static function getGlobalPos(aitem:DisplayObject, localPoint:Point):Point
		{
			while(!(aitem is Director))
			{
				if(aitem is SceneBase)
				{
					aitem = (aitem as SceneBase).canvas;
				}
				aitem = aitem.parent;
				/*转换到调用者父容器的坐标*/
				localPoint = aitem.localToGlobal(localPoint);
			}
			
			return localPoint;
		}
		
		/**
		 *  将全局的舞台坐标转化为特定容器内的坐标
		 **/
		public static function getLocalPos(aitem:DisplayObject, globalPoint:Point):Point
		{
			//父容器栈
			var parentList:Array = [];
			
			while(!(aitem is Director))
			{
				if(aitem is SceneBase)
				{
					aitem = (aitem as SceneBase).canvas;
				}
				aitem = aitem.parent;
				//入栈
				parentList.push(aitem);
			}
			
			while(parentList.length)
			{
				//出栈
				globalPoint = (parentList.pop() as DisplayObject).globalToLocal(globalPoint);
			}
			
			return globalPoint;
		}
		
	}
}