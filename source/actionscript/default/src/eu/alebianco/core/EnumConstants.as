/**
 * Copyright © 2011 Alessandro Bianco. All rights reserved.
 * http://alessandrobianco.eu | @alebianco
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
 *
 */
package eu.alebianco.core {

import flash.utils.Dictionary;

/**
 * Utility class used only by the Enum abstract class to store the elements
 * of the registered enumeration classes.
 *
 * @langversion     ActionScript 3.0
 * @playerversion     Flash 10.0
 * @author             Alessandro Bianco - cyberpunk
 * @version         0.9.0
 * @date            12.09.2011
 * @tiptext
 */
internal final class EnumConstants {
	private var _indexMap:Vector.<Enum>;

	/**
	 * The map of elements names used for search capabilities.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public var nameMap:Dictionary = new Dictionary(true);

	/**
	 * Constructor.
	 *
	 * <p>
	 * Store the list of constants for a single enumeration type and build
	 * a map of their names to conveniently search them.
	 * </p>
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function EnumConstants(constants:Vector.<Enum>) {
		_indexMap = constants;

		for (var i:int = 0; i < indexMap.length; ++i) {
			var enumConstant:Enum = indexMap[i];
			nameMap[enumConstant.name.toLowerCase()] = enumConstant;
		}
	}

	/**
	 * The list of elements belonging to an enumeration type.
	 *
	 * <p>
	 * It returns a copy of the list to prevent the consumer to change it at runtime.
	 * </p>
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function get indexMap():Vector.<Enum> {
		return _indexMap.slice();
	}

}
}