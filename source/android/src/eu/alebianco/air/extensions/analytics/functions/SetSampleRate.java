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
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.Tracker;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class SetSampleRate implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        String trackingId;
        try {
            trackingId = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'trackingId' parameter. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'trackingId' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        Tracker tracker = GoogleAnalytics.getInstance(context.getActivity()).getTracker(trackingId);

        Double rate;
        try {
            rate = args[1].getAsDouble();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'rate' parameter. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'rate' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        tracker.setSampleRate(rate);

        return result;
    }
}