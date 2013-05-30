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

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(fn, data) { (const uint8_t *)(#fn), (data), &(fn) }

@interface FREConversionUtil : NSObject

+ (NSString *)toString:(FREObject)object;
+ (NSNumber *)toNumber:(FREObject)object;
+ (NSInteger)toInt:(FREObject)object;
+ (NSUInteger)toUInt:(FREObject)object;
+ (BOOL)toBoolean:(FREObject)object;

+ (FREObject)fromString:(NSString *)value;
+ (FREObject)fromNumber:(NSNumber *)value;
+ (FREObject)fromInt:(NSInteger)value;
+ (FREObject)fromUInt:(NSUInteger)value;
+ (FREObject)fromBoolean:(BOOL)value;

+ (FREObject)getProperty:(NSString *)name fromObject:(FREObject)object;
+ (NSUInteger)getArrayLength:(FREObject *)array;
+ (FREObject *)getArrayItemAt:(NSUInteger)index on:(FREObject)array;

@end
