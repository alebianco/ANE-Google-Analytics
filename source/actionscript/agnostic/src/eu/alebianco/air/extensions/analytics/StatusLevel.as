package eu.alebianco.air.extensions.analytics {

import eu.alebianco.core.Enum;

internal class StatusLevel extends Enum {
	{
		initEnum(StatusLevel);
	}

	public static const INFO:StatusLevel = new StatusLevel(logStatusLevel);
	public static const DEBUG:StatusLevel = new StatusLevel(logStatusLevel);
	public static const WARN:StatusLevel = new StatusLevel(logStatusLevel);
	public static const ERROR:StatusLevel = new StatusLevel(logStatusLevel);
	public static const FATAL:StatusLevel = new StatusLevel(logStatusLevel);

	public static function getConstants():Vector.<StatusLevel> {
		return Vector.<StatusLevel>(Enum.getConstants(StatusLevel));
	}
	public static function parseConstant(constantName:String, caseSensitive:Boolean = false):StatusLevel {
		return StatusLevel(Enum.parseConstant(StatusLevel, constantName, caseSensitive));
	}

	private var _ns:Namespace;

	public function StatusLevel(ns:Namespace) {
		super();
		_ns = ns;
	}

	public function get ns():Namespace {
		return _ns;
	}

	override public function toString():String {
		return "[Status level (name: " + name + ")]";
	}
}
}