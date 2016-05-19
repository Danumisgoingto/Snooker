package item
{
	import flash.display.DisplayObjectContainer;
	
	public class StaticItemBase extends ItemBase
	{
		public function StaticItemBase(url:String, parent:DisplayObjectContainer, x:int=0, y:int=0)
		{
			super(url, parent, x, y);
		}
	}
}