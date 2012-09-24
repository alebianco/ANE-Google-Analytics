/*
 * Air Native Extension for Google Analytics on iOS and Android
 * 
 * Author: Alessandro Bianco
 * http://alessandrobianco.eu
 *
 * Copyright (c) 2012 Alessandro Bianco
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package eu.alebianco.air.extensions.analytics.enum
{
	import eu.alebianco.core.Enum;
	
	public class VariableScope extends Enum
	{
		{ initEnum(VariableScope); }
		
		// Constants.
		
		public static const VISITOR:VariableScope = new VariableScope(1);
		public static const SESSION:VariableScope = new VariableScope(2);
		public static const PAGE:VariableScope = new VariableScope(3);
		
		// Constant query.
		
		public static function getConstants():Vector.<VariableScope>
		{
			return Vector.<VariableScope>(Enum.getConstants(VariableScope));
		}
		public static function parseConstant(constantName:String, caseSensitive:Boolean = false):VariableScope
		{
			return VariableScope(Enum.parseConstant(VariableScope, constantName, caseSensitive));
		}
        public static function parseValue(value:int):VariableScope
        {
            var list:Vector.<VariableScope> = getConstants();
            for each (var constant:VariableScope in list)
            {
                if (constant.value == value)
                {
                    return constant;
                }
            }
            return null;
        }

		// Properties.
		private var _value:uint;
		
		// Constructor.
		
		public function VariableScope(value:uint)
		{
			super();
			
			_value = value;
		}
		
		// Accessors.
		
		public function get value():uint {
			
			return _value;
		}
		
		override public function toString():String
		{
			return "[Custom Variable Scope (value: " + value + ")]";
		}
	}
}