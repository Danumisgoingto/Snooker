package scene
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import global.UIFactory;
	
	import item.Ball;
	import item.DynamicItemBase;
	import item.Edge;
	import item.ItemBase;
	import item.MajorRole;

	public class GameSceneBase extends SceneBase
	{
		
		//=====数据
		private var _isMouseDown:Boolean;
		private var _pointMouseDown:Point;
		
		
		//=====调试
		private var _mousePos:TextField;
		private var _ballPos:TextField;
		private var _kTxt:TextField;
		
		public function GameSceneBase(url:String=null, width:int=0, height:int=0)
		{
			super(url, width, height);
		}
		
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			
//			addItem(MajorRole.instance, 100, 100);
			
			_mousePos = UIFactory.TextFeild("", 0, 100, this, 10);
			_mousePos.width = 200;
			_ballPos = UIFactory.TextFeild("", 0, 180, this, 10);
			_ballPos.width = 200;
			_kTxt = UIFactory.TextFeild("", 0, 200, this, 10);
			
			canvas.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			canvas.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			canvas.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		/**
		 *  按下鼠标
		 **/
		private function mouseDownHandler(evt:MouseEvent):void
		{
			_pointMouseDown = new Point(evt.localX, evt.localY);
			_isMouseDown = true;
			
		}
		
		/**
		 *  松下鼠标
		 **/
		private function mouseUpHandler(evt:MouseEvent):void
		{
			_isMouseDown = false;
			MajorRole.instance.stickOut(new Point(evt.localX, evt.localY));
		}
		
		/**
		 *  移动鼠标
		 **/
		private function mouseMoveHandler(evt:MouseEvent):void
		{
			_mousePos.text = "(localX, localY): " + evt.localX + ", " + evt.localY;
			_kTxt.text = "_k: " + MajorRole.instance.k;
			
			if(!_isMouseDown)
			{
				MajorRole.instance.adjustAngle(new Point(evt.localX, evt.localY));
			}
			else
			{
				_ballPos.text = "(DownX, DownY): " + _pointMouseDown.x + ", " + _pointMouseDown.y;
				MajorRole.instance.gatherStrength(new Point(evt.localX, evt.localY), _pointMouseDown);
			}
		}
		
		override protected function repaint():void
		{
			for(var i:uint = 0; i < this.numChildren; i++ )
			{	
				if(this.getChildAt(i) is ItemBase)
				{
					if(this.getChildAt(i) is Edge)
					{
						for(var j:uint = i+1; j< this.numChildren; j++)
						{
							if(this.getChildAt(j) is Ball)
							{
								(this.getChildAt(i) as Edge).crashCheck(this.getChildAt(j) as Ball);
							}
						}
					}
					
					
					if(this.getChildAt(i) is DynamicItemBase
						&& (this.getChildAt(i) as DynamicItemBase).isAwake)
					{
						(this.getChildAt(i) as DynamicItemBase).move();
					}
				}
			}
		}
		
	}
}