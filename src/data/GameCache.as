package data
{
	import flash.display.Stage;
	import flash.geom.Point;

	public class GameCache
	{
		//======常量
		public static const GAME_WIN_X:int = 141;
		
		public static const GAME_WIN_Y:int = 24;
		
		/** 摩擦力 **/
		public static const FRICTION:int = 0;
		
		/** 球半径 **/
		public static const BALL_RADIUS:int = 10;
		
		/** 原点 **/
		public static const ORIGIN_POINT:Point = new Point(0, 0);
		
		//======非常量
		public static var fps:int;
		
		/** 是否在调试模式 **/
		public static var isDebug:Boolean;
		
		/** 是否开启双缓冲 **/
		public static var isOpenDoubleBuff:Boolean;
		
		public function GameCache()
		{
		}
	}
}