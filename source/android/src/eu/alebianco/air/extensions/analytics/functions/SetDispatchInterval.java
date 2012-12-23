/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 23/12/12 10.42
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.GAServiceManager;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class SetDispatchInterval implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        Integer interval;
        try {
            interval = args[0].getAsInt();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'interval' parameter. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'interval' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        GAServiceManager.getInstance().setDispatchPeriod(interval);

        return result;
    }
}