//
//  GATypeConverter.m
//  NativeGATracker
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GATypeConverter.h"

@implementation GATypeConverter

NSDictionary *messages;

+(void) initialize {
    messages = @{
                 @"error.from.string.InvalidArgument" : @"The object or value parameter is NULL.",
                 @"error.from.string.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.from.number.InvalidArgument" : @"The object or value parameter is NULL.",
                 @"error.from.number.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.from.int.InvalidArgument" : @"The object or value parameter is NULL.",
                 @"error.from.int.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.from.uint.InvalidArgument" : @"The object or value parameter is NULL.",
                 @"error.from.uint.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.from.boolean.InvalidArgument" : @"The object or value parameter is NULL.",
                 @"error.from.boolean.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.to.string.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.to.string.TypeMismatch" : @"The FREObject parameter does not contain contain a String ActionScript value.",
                 @"error.to.string.InvalidArgument" : @"The value or length parameter is NULL.",
                 @"error.to.string.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.to.number.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.to.number.TypeMismatch" : @"The FREObject parameter does not contain a Boolean, int, or Number ActionScript value.",
                 @"error.to.number.InvalidArgument" : @"The value parameter is NULL.",
                 @"error.to.number.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.to.int.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.to.int.TypeMismatch" : @"The FREObject parameter does not contain a Boolean or int ActionScript value.",
                 @"error.to.int.InvalidArgument" : @"The value parameter is NULL.",
                 @"error.to.int.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.to.uint.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.to.uint.TypeMismatch" : @"The FREObject parameter does not contain a Boolean or int ActionScript value. An int ActionScript value that is negative also results in this return value.",
                 @"error.to.uint.InvalidArgument" : @"The value parameter is NULL.",
                 @"error.to.uint.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.to.boolean.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.to.boolean.TypeMismatch" : @"The FREObject parameter does not contain a Boolean ActionScript value.",
                 @"error.to.boolean.InvalidArgument" : @"The value parameter is NULL.",
                 @"error.to.boolean.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 
                 @"error.get.property.NoSuchName" : @"The propertyName parameter does not match a property of the ActionScript class object that the object parameter represents. Another, less likely, reason for this return value exists. Specifically, consider the unusual case when an ActionScript class has two properties with the same name but the names are in different ActionScript namespaces.",
                 @"error.get.property.InvalidObject" : @"The FREObject parameter is invalid.",
                 @"error.get.property.TypeMismatch" : @"The FREObject parameter does not represent an ActionScript class object.",
                 @"error.get.property.ActionscriptError" : @"An ActionScript error occurred. The runtime sets the thrownException parameter to represent the ActionScript Error class or subclass object.",
                 @"error.get.property.InvalidArgument" : @"The propertyName or propertyValue parameter is NULL.",
                 @"error.get.property.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 @"error.get.property.IllegalState" : @"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object.",
                 
                 @"error.get.arraylength.InvalidObject" : @"The arrayOrVector FREObject parameter is invalid.",
                 @"error.get.arraylength.TypeMismatch" : @"The arrayOrVector FREObject parameter does not represent an ActionScript Array or Vector class object.",
                 @"error.get.arraylength.InvalidArgument" : @"The length parameter is NULL.",
                 @"error.get.arraylength.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 @"error.get.arraylength.IllegalState" : @"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object.",
                 
                 @"error.get.arrayitem.InvalidObject" : @"The arrayOrVector FREObject parameter is invalid.",
                 @"error.get.arrayitem.TypeMismatch" : @"The arrayOrVector FREObject parameter does not represent an ActionScript Array or Vector class object.",
                 @"error.get.arrayitem.InvalidArgument" : @"The arrayOrVector parameter corresponds to an ActionScript Vector object but the index is greater than the index of the final element. Another reason for this return value is if the value parameter is NULL.",
                 @"error.get.arrayitem.WrongThread" : @"The method was called from a thread other than the one on which the runtime has an outstanding call to a native extension function.",
                 @"error.get.arrayitem.IllegalState" : @"The extension context has acquired an ActionScript BitmapData or ByteArray object. The context cannot call this method until it releases the BitmapData or ByteArray object.",
      };
}

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
    NSString *error;
    switch (result) {
        case FRE_NO_SUCH_NAME:
            error = @"NoSuchName";
            break;
        case FRE_INVALID_OBJECT:
            error = @"InvalidObject";
            break;
        case FRE_TYPE_MISMATCH:
            error = @"TypeMismatch";
            break;
        case FRE_ACTIONSCRIPT_ERROR:
            error = @"ActionscriptError";
            break;
        case FRE_INVALID_ARGUMENT:
            error = @"InvalidArgument";
            break;
        case FRE_READ_ONLY:
            error = @"ReadOnly";
            break;
        case FRE_WRONG_THREAD:
            error = @"WrongThread";
            break;
        case FRE_ILLEGAL_STATE:
            error = @"IllegalState";
            break;
        case FRE_INSUFFICIENT_MEMORY:
            error = @"InsufficientMemory";
            break;
        default:
            error = NULL;
            break;
    }
    if (error != NULL) {
        NSString *message = [messages objectForKey:[NSString stringWithFormat:@"error.%@.%@", action, error]];
        @throw [NSException exceptionWithName:error reason:message userInfo:nil];
    }
}

@end
