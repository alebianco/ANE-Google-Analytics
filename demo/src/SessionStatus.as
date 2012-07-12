package 
{
	import eu.alebianco.core.Enum;
	
	public class SessionStatus extends Enum
	{
		{ initEnum(SessionStatus); }
		
		public static const IDLE:SessionStatus = new SessionStatus();
		public static const ACTIVE:SessionStatus = new SessionStatus();
		
		public static function getConstants():Vector.<SessionStatus>
		{
			return Vector.<SessionStatus>(Enum.getConstants(SessionStatus));
		}
		public static function parseConstant(constantName:String, caseSensitive:Boolean = false):SessionStatus
		{
			return SessionStatus(Enum.parseConstant(SessionStatus, constantName, caseSensitive));
		}
		
		public function SessionStatus()
		{
			super();
		}
		
		override public function toString():String
		{
			return "[Session Status (name: " + name + ")]";
		}
	}
}