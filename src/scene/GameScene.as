package scene
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import global.UIFactory;
	
	import item.DynamicItemBase;
	import item.MajorRole;

	public class GameScene extends SceneBase
	{
		private var mousePos:TextField;
		private var ballPos:TextField;
		
		public function GameScene(url:String=null, width:int=0, height:int=0)
		{
			super(url, width, height);
		}
		
		
		/** load*/
		override protected function createElement():void
		{
			super.createElement();
			
			addItem(MajorRole.instance, 100, 100);
			
			mousePos = UIFactory.TextFeild("", 0, 100, this, 10);
			ballPos = UIFactory.TextFeild("", 0, 120, this, 10);
			
			canvas.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(evt:MouseEvent):void
		{
			MajorRole.instance.moveStick(new Point(evt.stageX, evt.stageY));
			mousePos.text = "" + evt.stageX + ", " + evt.stageY;
			ballPos.text = "" + MajorRole.instance.rotation;
		}
		
		override protected function repaint():void
		{
			
			for(var i:uint = 0; i < this.numChildren; i++ )
			{	
				if(this.getChildAt(i) is DynamicItemBase)
				{
					(this.getChildAt(i) as DynamicItemBase).move();
				}
				
			}
		}
		
	}
}