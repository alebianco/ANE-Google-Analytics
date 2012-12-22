/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 14.08
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import eu.alebianco.air.extensions.analytics.functions.*;

import java.util.Map;

public class GAContext extends FREContext {

    public static final String VERSION = "0.2.03";
    public static final String PRODUCT = "ANE-Google-Analytics";

    public void initialize() {
        // TODO auto generated stub method
    }

    @Override
    public void dispose() {
        // TODO auto generated stub method
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();

        functions.put("isSupported", new IsSupported());
        functions.put("getVersion", new GetVersion());

        // Analytics

        functions.put("getTracker", new GetTracker());
        functions.put("hasTracker", new HasTracker());
        functions.put("closeTracker", new CloseTracker());

        functions.put("getDebug", new GetDebug());
        functions.put("setDebug", new SetDebug());

        functions.put("getOptOut", new GetOptOut());
        functions.put("setOptOut", new SetOptOut());

        functions.put("setDispatchInterval", new NotImplemented());
        functions.put("dispatch", new NotImplemented());

        // Tracker

        functions.put("getAppID", new GetAppID());
        functions.put("setAppID", new NotImplemented());
        functions.put("getInstallerID", new GetInstallerID());
        functions.put("setInstallerID", new NotImplemented());
        functions.put("setAppName", new NotImplemented());
        functions.put("setAppVersion", new NotImplemented());
        functions.put("getAnonymous", new NotImplemented());
        functions.put("setAnonymous", new NotImplemented());
        functions.put("setSecure", new NotImplemented());
        functions.put("getSecure", new NotImplemented());
        functions.put("setSampleRate", new NotImplemented());
        functions.put("getSampleRate", new NotImplemented());
        functions.put("startSession", new NotImplemented());
        functions.put("stopSession", new NotImplemented());
        functions.put("trackData", new TrackData());

        return functions;
    }
}
