package scene
{
	
	import director.Director;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flashx.textLayout.formats.Direction;
	
	import global.GameElement;
	import global.LoadManager;
	import global.PoolManager;
	import global.UIFactory;
	
	import item.DynamicItemBase;

	public class SceneBase extends GameElement implements IScene
	{	
		protected var _myLoader:LoadManager;
		
		public function SceneBase(url:String)
		{
		    _myLoader = new LoadManager(this);
			super(url, _myLoader);
			init();
			_myLoader.load();
		}
		
		
		public function get myLoader():LoadManager
		{
			return _myLoader;
		}

		protected function init():void
		{
		}
		
		
		public function update():void
		{
			for(var i:uint = 0; i<this.numChildren; i++ )
			{
				var child:DisplayObject = this.getChildAt(i);
			 	if(child is DynamicItemBase)	
				{
					(child as DynamicItemBase).move();
				}
			}
		}
		
		
	}
}