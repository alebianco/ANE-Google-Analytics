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

#import "FREConversionUtil.h"

@implementation FREConversionUtil

// Cocoa types to FREObject

+(FREObject) convertString:(NSString *)value
{
    FREObject object;
    
    FREResult result = FRENewObjectFromUTF8((uint32_t) [value length], (uint8_t*) [value UTF8String], &object);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return object;
}

+(FREObject) convertNumber:(NSNumber *)value
{
    FREObject object;
    
    FREResult result = FRENewObjectFromDouble([value doubleValue], &object);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return object;

}

+(FREObject) convertInt:(NSInteger)value
{
    FREObject object;
    
    FREResult result = FRENewObjectFromInt32((int32_t) value, &object);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return object;
}

+(FREObject) convertUInt:(NSUInteger)value
{
    FREObject object;
    
    FREResult result = FRENewObjectFromInt32((uint32_t) value, &object);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return object;
}

+(FREObject) convertBoolean:(BOOL)value
{
    FREObject object;
    
    FREResult result = FRENewObjectFromBool((uint32_t) value, &object);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return object;
}

// FREObject to Cocoa types

+(NSString *) extractString:(FREObject)object
{
    uint32_t length;
    const uint8_t *value;
    
    FREResult result = FREGetObjectAsUTF8(object, &length, &value);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain contain a String ActionScript value." userInfo:nil];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:nil];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value or length parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return [NSString stringWithUTF8String:(char *) value];
}

+(NSNumber *) extractNumber:(FREObject)object
{
    double value = 0;
    
    FREResult result = FREGetObjectAsDouble(object, &value);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean, int, or Number ActionScript value." userInfo:nil];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:nil];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return [NSNumber numberWithDouble:value];
}

+(NSInteger) extractInt:(FREObject)object
{
    int32_t value = 0;
    
    FREResult result = FREGetObjectAsInt32(object, &value);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain contain a Boolean or int ActionScript value." userInfo:nil];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:nil];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return [[NSNumber numberWithInt:(int) value] integerValue];
}

+(NSUInteger) extractUInt:(FREObject)object
{
    uint32_t value = 0;
    
    FREResult result = FREGetObjectAsUint32(object, &value);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean or int ActionScript value. An int ActionScript value that is negative also results in this return value." userInfo:nil];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:nil];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return [[NSNumber numberWithInt:(int) value] unsignedIntegerValue];;
}

+(BOOL) extractBoolean:(FREObject)object
{
    uint32_t value = 0;
    
    FREResult result = FREGetObjectAsBool(object, &value);
    
    if (result != FRE_OK)
    {
        NSException *exception;
        
        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean ActionScript value." userInfo:nil];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:nil];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:nil];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:nil];
                break;
            default:
                exception = nil;
                break;
        }
        
        if (exception != nil) @throw exception;
    }
    
    return (value) ? YES : NO;
}

@end
