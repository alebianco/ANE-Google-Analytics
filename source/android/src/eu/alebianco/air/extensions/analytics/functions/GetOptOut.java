/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 15.22
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

import java.util.HashMap;

public class GetOptOut implements FREFunction {

    HashMap<String, Boolean> mutex = new HashMap<String, Boolean>();

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        GoogleAnalytics.getInstance(context.getActivity()).requestAppOptOut(new GoogleAnalytics.AppOptOutCallback() {
            @Override
            public void reportAppOptOut(boolean value) {
                synchronized (mutex) {
                    mutex.put("done", true);
                    mutex.put("result", value);
                    mutex.notifyAll();
                }
            }
        });

        synchronized (mutex) {
             while (!mutex.containsKey("done") || mutex.get("done") != true) {
                try {
                    mutex.wait();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
             }
        }

        try {
            result = FREObject.newObject(mutex.get("result"));
        } catch(Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to create the return value. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to create the return value on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        return result;
    }
}