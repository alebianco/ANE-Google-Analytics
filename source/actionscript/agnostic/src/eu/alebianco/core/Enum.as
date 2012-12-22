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

import eu.alebianco.errors.EnumError;

import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

/**
 * Provide means to build typesafe enumerations in <code>ActionScript</code>.
 *
 * <p>
 * This class works as an <i>abstract</i> and should be used only to extend the concrete
 * enumerations in which the <code>static constants</code> will be used as the enumeration elements.
 * </p>
 * <p>
 * Enumeration built this way are:
 * <ul>
 * <li><b>closed</b>: elements can't be added or removed at runtime.</li>
 * <li><b>iterable</b>: elements can be retrieved as a list, with the same order in which they were declared.</li>
 * </ul>
 * </p>
 *
 * @internal Goals still to achieve: make them *comparable*, *generic* and *extensible*
 * @interal would be possible to use a metatag instead of a static initializer to register the enum class?
 *
 * @see https://github.com/nodename/Ultimate-Enum
 *
 * @langversion     ActionScript 3.0
 * @playerversion     Flash 10.0
 * @author             Alessandro Bianco - cyberpunk
 * @version         0.9.0
 * @date            12.09.2011
 * @tiptext
 */
public /*abstract*/ class Enum {
	private var _name:String = null;
	private var _index:int = -1;

	private static var _pendingDb:Dictionary = new Dictionary(); // typename -> [constants]
	private static var _enumDb:Dictionary = new Dictionary(); // typename -> EnumConstants

	/**
	 * Enumeration constructor.
	 *
	 * <p>
	 * Can't be used directly, this class acts as an <i>abstract</i>.<br/>
	 * You should create a concrete class that extends this one and define
	 * your enumeration elements there.<br/>
	 * Concrete enumerations can be instantiated only as static constants
	 * inside their own class.
	 * </p>
	 *
	 * @throws eu.alebianco.errors.EnumError An instance of the abstract
	 * class has been created or a concrete class has been created outside
	 * of it's own class.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function Enum() {
		var typeName:String = getQualifiedClassName(this);

		// discourage people new'ing up constants on their own
		// instead of using the class constants
		if (_enumDb[typeName] != null) {
			throw new EnumError("Enum constants can only be constructed as static consts in their own enum class " + "(type: '" + typeName + "')", 1001);
		}
		else if (typeName == getQualifiedClassName(Enum)) {
			throw new EnumError("Enum is an abstract class, you can instantiate it. Subclass it and create your own enumerations.", 1000);
		}

		// if opening up a new type, alloc an array for its constants
		var constants:Vector.<Enum> = _pendingDb[typeName];
		if (constants == null) {
			_pendingDb[typeName] = constants = new Vector.<Enum>();
		}

		// store element
		_index = constants.length;
		constants.push(this);
	}

	/**
	 * The name of the current element.
	 *
	 * <p>
	 * The name is inferred from the constant name defined in the concrete
	 * class definition.
	 * </p>
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function get name():String {
		return _name;
	}

	/**
	 * The ordinal index of the current element.
	 *
	 * <p>
	 * The index is inferred from constants declaration order in the
	 * concrete class definition.
	 * </p>
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function get index():int {
		return _index;
	}

	/**
	 * Output the enumeration element as a <code>String</code> rapresenting
	 * it's basic informations.
	 *
	 * @return The enumeration element informations.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	public function toString():String {
		var className:String = getQualifiedClassName(this).match("[^:]*$")[0];
		return "[" + className + " (index:" + index + ", name:" + name + ")]";
	}

	/**
	 * Initialize the concrete enumeration class.
	 *
	 * <p>
	 * Register the enumeration type and parse the class constants to
	 * build the list of elements.
	 * </p>
	 * <p>
	 * This method <b>must</b> be called from the static initializer in
	 * the concrete class.
	 * </p>
	 *
	 * @param type A reference to che concrete enumeration class to be
	 * registered.
	 *
	 * @throws eu.alebianco.errors.EnumError The initialization has been
	 * called twice or there're no constants defined or constants doesn't
	 * match their enumeration class.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	protected static function initEnum(type:Class):void {
		var typeName:String = getQualifiedClassName(type);

		// can't call initEnum twice on same type, likely copy-paste bug
		if (_enumDb[typeName] != null) {
			throw new EnumError("Can't initialize enum twice (type: '" + typeName + "')", 1010);
		}

		// no constant is technically ok but it's probably a copy-paste bug
		var constants:Vector.<Enum> = _pendingDb[typeName];
		if (constants == null) {
			throw new EnumError("Can't have an enum without any constants (type: '" + typeName + "')", 1011);
		}

		// process constants
		var desc:XML = describeType(type);
		for each (var constant:XML in desc.constant) {
			var enumConstant:Enum = type[constant.@name];

			// if the types don't match probably it's a copy-paste error.
			// this is really common so it's good to catch it here.
			var enumConstantType:* = Object(enumConstant).constructor;
			if (enumConstantType != type) {
				throw new EnumError("Constant type '" + enumConstantType + "' does not match its enum class '" + type + "'", 1012);
			}

			enumConstant._name = constant.@name;
		}

		// now seal it
		_pendingDb[typeName] = null;
		_enumDb[typeName] = new EnumConstants(constants);
	}

	/**
	 * Search for elements of a specific enumeration type and returns them.
	 *
	 * <p>
	 * The list of elements is ordered following the index of the elements.
	 * </p>
	 *
	 * @param type Reference to a concrete enumeration class for which
	 * retrieve the elements.
	 *
	 * @return The list of elements belonging to the enumeration.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	protected static function getConstants(type:Class):Vector.<Enum> {
		var constants:EnumConstants = _enumDb[getQualifiedClassName(type)];
		if (constants == null) {
			return null;
		}

		return constants.indexMap;
	}

	/**
	 * Search for a element with a specific name belonging to a specific
	 * enumeration type.
	 *
	 * @param type Reference to a concrete enumeration class to search into.
	 * @param name The name of the element to retrieve.
	 * @param strict Whether to compare elements name in a case sensitive way or not.
	 *
	 * @return The enumeration element with the corresponding name or <code>null</code> if not found.
	 *
	 * @langversion     ActionScript 3.0
	 * @playerversion     Flash 10.0
	 * @tiptext
	 */
	protected static function parseConstant(type:Class, name:String, strict:Boolean = false):Enum {
		var constants:EnumConstants = _enumDb[getQualifiedClassName(type)];
		if (constants == null) {
			return null;
		}

		var constant:Enum = constants.nameMap[name.toLowerCase()];
		if (strict && (constant != null) && (name != constant.name)) {
			return null;
		}

		return constant;
	}
}
}