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
    }

    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();

        // Extension

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
        functions.put("setDispatchInterval", new SetDispatchInterval());
        functions.put("dispatch", new Dispatch());

        // Tracker

        functions.put("setAppName", new SetAppName());
        functions.put("setAppVersion", new SetAppVersion());
        functions.put("getAppID", new GetAppID());
        functions.put("setAppID", new SetAppID());
        functions.put("getAppInstallerID", new GetInstallerID());
        functions.put("setAppInstallerID", new SetInstallerID());
        functions.put("getAnonymous", new GetAnonymous());
        functions.put("setAnonymous", new SetAnonymous());
        functions.put("getSecure", new GetSecure());
        functions.put("setSecure", new SetSecure());
        functions.put("getSampleRate", new GetSampleRate());
        functions.put("setSampleRate", new SetSampleRate());
        functions.put("startSession", new StartNewSession());
        functions.put("closeSession", new CloseSession());
        functions.put("trackData", new TrackData());

        return functions;
    }
}
