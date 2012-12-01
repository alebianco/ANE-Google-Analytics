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

#import "FREUtils.h"

@implementation FREUtils

void logEvent( FREContext ctx, enum LogLevel lvl, NSString *format, ... )
{
    va_list ap = NULL;
    va_start(ap, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    
    NSString *level = nil;
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
    DISPATCH_EVENT(ctx, (uint8_t*) [[@"INTERNAL_" stringByAppendingString:level] UTF8String], (uint8_t*) [message UTF8String]);
}


@end
