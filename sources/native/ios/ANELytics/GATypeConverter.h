//
//  GATypeConverter.h
//  ANELytics
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#import "GAMacros.h"

@interface GATypeConverter : NSObject

+(NSString *) toString:(FREObject) object;
+(NSNumber *) toNumber:(FREObject) object;
+(NSInteger) toInt:(FREObject) object;
+(NSUInteger) toUInt:(FREObject) object;
+(BOOL) toBoolean:(FREObject) object;

+(FREObject) fromString:(NSString *) value;
+(FREObject) fromNumber:(NSNumber *) value;
+(FREObject) fromInt:(NSInteger) value;
+(FREObject) fromUInt:(NSUInteger) value;
+(FREObject) fromBoolean:(BOOL) value;

+(FREObject) getProperty:(NSString *) name fromObject:(FREObject) object;
+(NSUInteger) getArrayLength:(FREObject *) array;
+(FREObject *) getArrayItemAt:(NSUInteger) index on:(FREObject) array;

@end
