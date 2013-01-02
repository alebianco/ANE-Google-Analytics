/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 14.12
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.core.Enum;

internal class HitType extends Enum {
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