//
//  GATypeConverter.m
//  NativeGATracker
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GATypeConverter.h"

@implementation GATypeConverter

+(FREObject) fromString:(NSString *) value {
    FREObject object;
    FREResult result = FRENewObjectFromUTF8((uint32_t) [value length], (uint8_t *) [value UTF8String], &object);
    [GATypeConverter handleConversionResult: result forAction:@"from.string"];
    return object;
}
+(FREObject) fromNumber:(NSNumber *) value {
    FREObject object;
    FREResult result = FRENewObjectFromDouble([value doubleValue], &object);
    [GATypeConverter handleConversionResult: result forAction:@"from.number"];
    return object;
    
}
+(FREObject) fromInt:(NSInteger) value {
    FREObject object;
    FREResult result = FRENewObjectFromInt32((int32_t) value, &object);
    [GATypeConverter handleConversionResult: result forAction:@"from.int"];
    return object;
}
+(FREObject) fromUInt:(NSUInteger) value {
    FREObject object;
    FREResult result = FRENewObjectFromInt32((uint32_t) value, &object);
    [GATypeConverter handleConversionResult: result forAction:@"from.uint"];
    return object;
}
+(FREObject) fromBoolean:(BOOL) value {
    FREObject object;
    FREResult result = FRENewObjectFromBool((uint32_t) value, &object);
    [GATypeConverter handleConversionResult: result forAction:@"from.bool"];
    return object;
}

+(NSString *) toString:(FREObject) object {
    uint32_t length;
    const uint8_t *value;
    FREResult result = FREGetObjectAsUTF8(object, &length, &value);
    [GATypeConverter handleConversionResult: result forAction:@"to.string"];
    return [NSString stringWithUTF8String:(char *) value];
}
+(NSNumber *) toNumber:(FREObject) object {
    double value = 0;
    FREResult result = FREGetObjectAsDouble(object, &value);
    [GATypeConverter handleConversionResult: result forAction:@"to.number"];
    return [NSNumber numberWithDouble:value];
}
+(NSInteger) toInt:(FREObject) object {
    int32_t value = 0;
    FREResult result = FREGetObjectAsInt32(object, &value);
    [GATypeConverter handleConversionResult: result forAction:@"to.int"];
    return [[NSNumber numberWithInt:(int) value] integerValue];
}
+(NSUInteger) toUInt:(FREObject) object {
    uint32_t value = 0;
    FREResult result = FREGetObjectAsUint32(object, &value);
    [GATypeConverter handleConversionResult: result forAction:@"to.uint"];
    return [[NSNumber numberWithInt:(int) value] unsignedIntegerValue];;
}
+(BOOL) toBoolean:(FREObject) object {
    uint32_t value = 0;
    FREResult result = FREGetObjectAsBool(object, &value);
    [GATypeConverter handleConversionResult: result forAction:@"to.boolean"];
    return (value) ? YES : NO;
}

+(FREObject) getProperty:(NSString *) name fromObject:(FREObject) object {
    FREObject value;
    FREResult result = FREGetObjectProperty(object, (uint8_t *) [name UTF8String], &value, NULL);
    [GATypeConverter handleConversionResult: result forAction:@"get.property"];
    return value;
}
+(NSUInteger) getArrayLength:(FREObject *) array {
    uint32_t length;
    FREResult result = FREGetArrayLength(array, &length);
    [GATypeConverter handleConversionResult: result forAction:@"get.arraylength"];
    return [[NSNumber numberWithInteger:length] unsignedIntegerValue];
}
+(FREObject *) getArrayItemAt:(NSUInteger) index on:(FREObject) array {
    FREObject value;
    FREResult result = FREGetArrayElementAt(array, (uint32_t) index, &value);
    [GATypeConverter handleConversionResult: result forAction:@"get.arrayitem"];
    return value;
}

+(void) handleConversionResult:(FREResult) result forAction:(NSString *) action {
    NSException *exception;
    switch (result) {
        case FRE_NO_SUCH_NAME:
            exception = HANDLE_CONVERSION_RESULT(action, @"NoSuchName");
            break;
        case FRE_INVALID_OBJECT:
            exception = HANDLE_CONVERSION_RESULT(action, @"InvalidObject");
            break;
        case FRE_TYPE_MISMATCH:
            exception = HANDLE_CONVERSION_RESULT(action, @"TypeMismatch");
            break;
        case FRE_ACTIONSCRIPT_ERROR:
            exception = HANDLE_CONVERSION_RESULT(action, @"ActionscriptError");
            break;
        case FRE_INVALID_ARGUMENT:
            exception = HANDLE_CONVERSION_RESULT(action, @"InvalidArgument");
            break;
        case FRE_READ_ONLY:
            exception = HANDLE_CONVERSION_RESULT(action, @"ReadOnly");
            break;
        case FRE_WRONG_THREAD:
            exception = HANDLE_CONVERSION_RESULT(action, @"WrongThread");
            break;
        case FRE_ILLEGAL_STATE:
            exception = HANDLE_CONVERSION_RESULT(action, @"IllegalState");
            break;
        case FRE_INSUFFICIENT_MEMORY:
            exception = HANDLE_CONVERSION_RESULT(action, @"InsufficientMemory");
            break;
        default:
            exception = NULL;
            break;
    }
    if (exception != NULL) {
        @throw exception;
    }
}

@end
