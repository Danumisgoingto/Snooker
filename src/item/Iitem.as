package item
{
	import flash.display.Shape;
	import flash.geom.Point;

	public interface Iitem
	{
		function setPosition( x:int, y:int ):void;
		
		function getPosition():Point;
		
//		function setSprite():void;
		
		function get sprite():Shape;
		
	}
}