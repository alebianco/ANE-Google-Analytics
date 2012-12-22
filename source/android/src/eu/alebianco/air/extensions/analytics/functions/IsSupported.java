/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 15.02
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class IsSupported implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        try {
            result = FREObject.newObject(true);
        } catch(Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to create the return value. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to create the return value on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        return result;
    }
}