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

/**
 * The IDisposable interface define a generic method tha will make sure that
 * the instance is ready for garbage collection.
 *
 * @langversion     ActionScript 3.0
 * @playerversion     Flash 9.0
 * @author             Alessandro Bianco - cyberpunk
 * @version         0.1.0
 * @date            25.02.2011
 * @tiptext
 */
public interface IDisposable {
	/**
	 * Stop any code execution and cleans up every stored reference.
	 *
	 * <p>
	 * After calling this method the instance is be ready for garbage
	 * collection without leaving behind any reference or running code that
	 * could bog the memory of the application.
	 * </p>
	 *
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * @tiptext
	 */
	function dispose():void;
}
}