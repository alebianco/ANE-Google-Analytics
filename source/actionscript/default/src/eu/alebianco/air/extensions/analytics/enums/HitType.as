package eu.alebianco.air.extensions.analytics.enums {

import eu.alebianco.core.Enum;

public class HitType extends Enum {
	{
		initEnum(HitType);
	}

	public static const EVENT:HitType = new HitType();
	public static const VIEW:HitType = new HitType();
	public static const TRANSACTION:HitType = new HitType();
	public static const EXCEPTION:HitType = new HitType();
	public static const SOCIAL:HitType = new HitType();
	public static const TIMING:HitType = new HitType();

	public static function getConstants():Vector.<HitType> {
		return Vector.<HitType>(Enum.getConstants(HitType));
	}
	public static function parseConstant(constantName:String, caseSensitive:Boolean = false):HitType {
		return HitType(Enum.parseConstant(HitType, constantName, caseSensitive));
	}

	public function HitType() {
		super();
	}

	override public function toString():String {
		return "[HitType (name: " + name + ")]";
	}
}
}