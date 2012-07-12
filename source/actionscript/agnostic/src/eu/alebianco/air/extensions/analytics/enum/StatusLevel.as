package eu.alebianco.air.extensions.analytics.enum
{
	import eu.alebianco.air.extensions.analytics.ns.logStatusLevel;
	import eu.alebianco.core.Enum;
	
	public class StatusLevel extends Enum
	{
		{ initEnum(StatusLevel); }
		
		// Constants.
		public static const INFO:StatusLevel = new StatusLevel(logStatusLevel);
		public static const DEBUG:StatusLevel = new StatusLevel(logStatusLevel);
		public static const WARN:StatusLevel = new StatusLevel(logStatusLevel);
		public static const ERROR:StatusLevel = new StatusLevel(logStatusLevel);
		public static const FATAL:StatusLevel = new StatusLevel(logStatusLevel);
		
		// Constant query.
		
		public static function getConstants():Vector.<StatusLevel>
		{
			return Vector.<StatusLevel>(Enum.getConstants(StatusLevel));
		}
		public static function parseConstant(constantName:String, caseSensitive:Boolean = false):StatusLevel
		{
			return StatusLevel(Enum.parseConstant(StatusLevel, constantName, caseSensitive));
		}
		
		// Properties.
		private var _ns:Namespace;
		
		// Constructor.
		
		public function StatusLevel(ns:Namespace)
		{
			super();
			_ns = ns;
		}
		
		// Accessors.
		public function get ns():Namespace
		{
			return _ns;
		}
		
		// Utilities.
		override public function toString():String
		{
			return "[Expansion Type (name: " + name + ")]";
		}
	}
}