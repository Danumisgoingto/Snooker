package data
{
	public class GameCache
	{
		public static var fps:int;
		
		/** 是否在调试模式 **/
		public static var isDebug:Boolean;
		
		/** 摩擦力 **/
		public static const FRICTION:int = 1;
		
		/** 球半径 **/
		public static const BALL_RADIUS:int = 10;
		
		/** 是否开启双缓冲 **/
		public static var isOpenDoubleBuff:Boolean;
		
		public function GameCache()
		{
		}
	}
}