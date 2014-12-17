//
//  GAMacros.h
//  NativeGATracker
//
//  Created by Alessandro Bianco on 15/12/2014.
//  Copyright (c) 2014 Alessandro Bianco. All rights reserved.
//

#define MAP_FUNCTION(fn, data) { (const uint8_t *)#fn, data, ga_ ## fn }

#define DEFINE_FUNCTION(fn) FREObject ga_ ## fn(FREContext ctx, void* data, uint32_t argc, FREObject argv[])

#define HANDLE_CONVERSION_RESULT(ACTION, ERROR) [NSException exceptionWithName:ERROR reason:NSLocalizedString(([NSString stringWithFormat:@"error.%@.%@", ACTION, ERROR]), nil) userInfo:nil]
