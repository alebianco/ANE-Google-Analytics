package eu.alebianco.air.extensions.analytics {

import eu.alebianco.core.Enum;

public class HitType extends Enum {
	{
		initEnum(HitType);
	}

	public static const EVENT:HitType = new HitType("event");
	public static const VIEW:HitType = new HitType("appView");
	public static const TRANSACTION:HitType = new HitType("tran");
	public static const EXCEPTION:HitType = new HitType("exception");
	public static const SOCIAL:HitType = new HitType("social");
	public static const TIMING:HitType = new HitType("timing");

	public static function getConstants():Vector.<HitType> {
		return Vector.<HitType>(Enum.getConstants(HitType));
	}
	public static function parseConstant(constantName:String, caseSensitive:Boolean = false):HitType {
		return HitType(Enum.parseConstant(HitType, constantName, caseSensitive));
	}
	public static function parseValue(value:String, caseSensitive:Boolean = false):HitType {
		for each (var type:HitType in getConstants()) {
			if (value === type.value)
				return type;
		}
		return null;
	}

	private var _value:String;

	public function get value():String {
		return _value;
	}

	public function HitType(value:String) {
		super();
		_value = value;
	}

	override public function toString():String {
		return "[HitType (name: " + name + ")]";
	}
}
}