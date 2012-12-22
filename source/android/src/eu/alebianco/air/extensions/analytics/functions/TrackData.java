/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 17.33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.GoogleTracker;
import com.google.analytics.tracking.android.ModelFields;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

import java.util.Map;

public class TrackData implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        String accountID;
        try {
            accountID = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'accountID' parameter. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'accountID' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        String type;
        try {
            type = args[1].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'type' parameter. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'type' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        GoogleTracker tracker = (GoogleTracker) GoogleAnalytics.getInstance(context.getActivity()).getTracker(accountID);

        FREArray arguments = (FREArray) args[2];

        if (ModelFields.APP_VIEW.equals(type)) {
            return trackView(context, tracker, arguments);
        } else if (ModelFields.EVENT.equals(type)) {
            return trackEvent(context, tracker, arguments);
        } else {
            FREUtils.logEvent(context, LogLevel.WARN, "Hit type not recognized: {0}", type);
        }

        return result;
    }

    private FREObject trackView(FREContext context, GoogleTracker tracker, FREArray arguments) {

        String screen;
        try {
            screen = arguments.getObjectAt(0).getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read an argument. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read an argument on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        tracker.trackView(screen);
        return null;
    }

    private FREObject trackEvent(FREContext context, GoogleTracker tracker, FREArray arguments) {

        String category;
        String action;
        String label;
        Long value;

        try {
            category = arguments.getObjectAt(0).getAsString();
            action = arguments.getObjectAt(1).getAsString();
            label = arguments.getObjectAt(2) != null ? arguments.getObjectAt(2).getAsString() : null;
            value = arguments.getObjectAt(3) != null ? Long.valueOf(arguments.getObjectAt(3).getAsInt()) : null;
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read an argument. (Exception:[name:%s, reason:%s, method:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), e.getMessage(), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read an  parameter on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        Map hit = tracker.constructEvent(category, action, label, value);
        tracker.send(ModelFields.EVENT, hit);

        return null;
    }
}