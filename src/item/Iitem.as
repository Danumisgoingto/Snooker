package item
{
	import flash.display.Shape;

	public interface Iitem
	{
		function setPosition( x:int, y:int ):void;
		
		function getPosition():Vector.<int, int>;
		
//		function setSprite():void;
		
		function get sprite():Shape;
		
	}
}