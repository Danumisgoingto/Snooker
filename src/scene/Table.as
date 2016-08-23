package scene
{
	import director.Director;
	
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	import global.ImagesConst;
	import global.PoolManager;
	import global.UIFactory;
	
	import item.Ball;
	import item.DynamicItemBase;
	import item.Iitem;
	import item.MajorRole;
	import item.Stick;
	
	import org.osmf.elements.BeaconElement;

	public class Table extends GameScene
	{
		//常量
		private static var _instance:Table = new Table();
		
		//
		private var backText:TextField;
		
		public function Table()
		{
			super(ImagesConst.TableBg);//
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
			
		}
		
		
		
	}
}