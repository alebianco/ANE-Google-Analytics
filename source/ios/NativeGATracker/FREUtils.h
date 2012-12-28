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

#define DISPATCH_EVENT(extensionContext, type, message) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)(type), (uint8_t*)(message))

@interface FREUtils : NSObject

enum LogLevel {
    kInfo = 0,
    kDebug,
    kWarn,
    kError,
    kFatal
};

void logEvent(FREContext ctx, enum LogLevel lvl, NSString *format, ...);

FREObject createRuntimeException(NSString *type, NSInteger id, NSString *message, ...);

@end


