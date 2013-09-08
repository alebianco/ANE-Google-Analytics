/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 15.11
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.analytics.GAContext;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class GetVersion implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result;

        try {
            result = FREObject.newObject(GAContext.PRODUCT + " v" + GAContext.VERSION);
        } catch(Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to create the return value. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to create the return value on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        return result;
    }
}