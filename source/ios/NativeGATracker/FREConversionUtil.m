/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/12/12 16.06
 *
 * Copyright © 2013 Alessandro Bianco
 */

#import "FREConversionUtil.h"

@implementation FREConversionUtil

+ (FREObject)fromString:(NSString *)value {
    FREObject object;

    FREResult result = FRENewObjectFromUTF8((uint32_t) [value length], (uint8_t *) [value UTF8String], &object);

    if (result != FRE_OK) {
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

        if (exception != NULL) @throw exception;
    }

    return object;
}
+ (FREObject)fromNumber:(NSNumber *)value {
    FREObject object;

    FREResult result = FRENewObjectFromDouble([value doubleValue], &object);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return object;

}
+ (FREObject)fromInt:(NSInteger)value {
    FREObject object;

    FREResult result = FRENewObjectFromInt32((int32_t) value, &object);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return object;
}
+ (FREObject)fromUInt:(NSUInteger)value {
    FREObject object;

    FREResult result = FRENewObjectFromInt32((uint32_t) value, &object);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return object;
}
+ (FREObject)fromBoolean:(BOOL)value {
    FREObject object;

    FREResult result = FRENewObjectFromBool((uint32_t) value, &object);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"TThe object or value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return object;
}
+ (NSString *)toString:(FREObject)object {
    uint32_t length;
    const uint8_t *value;

    FREResult result = FREGetObjectAsUTF8(object, &length, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain contain a String ActionScript value." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value or length parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return [NSString stringWithUTF8String:(char *) value];
}
+ (NSNumber *)toNumber:(FREObject)object {
    double value = 0;

    FREResult result = FREGetObjectAsDouble(object, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean, int, or Number ActionScript value." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return [NSNumber numberWithDouble:value];
}
+ (NSInteger)toInt:(FREObject)object {
    int32_t value = 0;

    FREResult result = FREGetObjectAsInt32(object, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain contain a Boolean or int ActionScript value." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return [[NSNumber numberWithInt:(int) value] integerValue];
}
+ (NSUInteger)toUInt:(FREObject)object {
    uint32_t value = 0;

    FREResult result = FREGetObjectAsUint32(object, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean or int ActionScript value. An int ActionScript value that is negative also results in this return value." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return [[NSNumber numberWithInt:(int) value] unsignedIntegerValue];;
}
+ (BOOL)toBoolean:(FREObject)object {
    uint32_t value = 0;

    FREResult result = FREGetObjectAsBool(object, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not contain a Boolean ActionScript value." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The value parameter is NULL." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
                break;
        }

        if (exception != NULL) @throw exception;
    }

    return (value) ? YES : NO;
}
+ (FREObject)getProperty:(NSString *)name fromObject:(FREObject)object {
    FREObject value;
    FREResult result = FREGetObjectProperty(object, (uint8_t *) [name UTF8String], &value, NULL);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_ACTIONSCRIPT_ERROR:
                exception = [NSException exceptionWithName:@"ActionscriptError" reason:@"An ActionScript error occurred. The runtime sets the thrownException parameter to represent the ActionScript Error class or subclass object." userInfo:NULL];
                break;
            case FRE_ILLEGAL_STATE:
                exception = [NSException exceptionWithName:@"IllegalState" reason:@"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The propertyName or propertyValue parameter is NULL." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_NO_SUCH_NAME:
                exception = [NSException exceptionWithName:@"NoSuchName" reason:@"The propertyName parameter does not match a property of the ActionScript class object that the object parameter represents. Another, less likely, reason for this return value exists. Specifically, consider the unusual case when an ActionScript class has two properties with the same name but the names are in different ActionScript namespaces." userInfo:NULL];
                break;
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not represent an ActionScript class object." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
        }

        if (exception != NULL) @throw exception;
    }

    return value;
}
+ (NSUInteger)getArrayLength:(FREObject *)array {
    uint32_t length;
    FREResult result = FREGetArrayLength(array, &length);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_ILLEGAL_STATE:
                exception = [NSException exceptionWithName:@"IllegalState" reason:@"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The propertyName or propertyValue parameter is NULL." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not represent an ActionScript class object." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
        }

        if (exception != NULL) @throw exception;
    }

    return [[NSNumber numberWithInteger:length] unsignedIntegerValue];
}
+ (FREObject *)getArrayItemAt:(NSUInteger)index on:(FREObject)array {
    FREObject value;
    FREResult result = FREGetArrayElementAt(array, (uint32_t) index, &value);

    if (result != FRE_OK) {
        NSException *exception;

        switch (result) {
            case FRE_ILLEGAL_STATE:
                exception = [NSException exceptionWithName:@"IllegalState" reason:@"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object." userInfo:NULL];
                break;
            case FRE_INVALID_ARGUMENT:
                exception = [NSException exceptionWithName:@"InvalidArgument" reason:@"The propertyName or propertyValue parameter is NULL." userInfo:NULL];
                break;
            case FRE_INVALID_OBJECT:
                exception = [NSException exceptionWithName:@"InvalidObject" reason:@"The FREObject parameter is invalid." userInfo:NULL];
                break;
            case FRE_TYPE_MISMATCH:
                exception = [NSException exceptionWithName:@"TypeMismatch" reason:@"The FREObject parameter does not represent an ActionScript class object." userInfo:NULL];
                break;
            case FRE_WRONG_THREAD:
                exception = [NSException exceptionWithName:@"WrongThread" reason:@"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function." userInfo:NULL];
                break;
            default:
                exception = NULL;
        }

        if (exception != NULL) @throw exception;
    }

    return value;
}

@end
