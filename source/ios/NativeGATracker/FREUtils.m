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

#import "FREUtils.h"
#import "FREConversionUtil.h"

@implementation FREUtils

void logEvent(FREContext ctx, enum LogLevel lvl, NSString *format, ...) {
    va_list ap = NULL;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);

    NSString *level = NULL;
    switch (lvl) {
        case kInfo:
            level = @"INFO";
            break;
        case kDebug:
            level = @"DEBUG";
            break;
        case kWarn:
            level = @"WARN";
            break;
        case kError:
            level = @"ERROR";
            break;
        case kFatal:
            level = @"FATAL";
            break;

        default:
            level = @"INFO";
            break;
    }

    NSLog(@"%@: %@", level, message);
    DISPATCH_EVENT(ctx, (uint8_t *) [[@"INTERNAL_" stringByAppendingString:level] UTF8String], (uint8_t *) [message UTF8String]);
}
FREObject createRuntimeException(NSString *type, NSInteger id, NSString *format, ...) {
    FREObject object;

    va_list ap = NULL;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);

    uint32_t argc = 2;

    FREObject argv[argc];
    argv[0] = [FREConversionUtil fromString:message];
    argv[1] = [FREConversionUtil fromInt:id];

    FREResult result = FRENewObject((uint8_t *) [type UTF8String], argc, argv, &object, NULL);

    if (result == FRE_OK) {
        return object;
    } else {
        NSLog(@"Inception Error: Unable to create the runtime exception to notify the application about the previous error.");
    }

    return NULL;
}

@end
