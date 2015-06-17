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

    public static final String VERSION = "2.0.7rc2";
    public static final String PRODUCT = "ANE-Google-Analytics";

    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();

        // Extension

        functions.put("isSupported", new IsSupported());
        functions.put("GA_getVersion", new GetVersion());

        // Analytics

        functions.put("createTracker", new CreateTracker());
        functions.put("closeTracker", new CloseTracker());
        functions.put("getDebug", new GetDebug());
        functions.put("setDebug", new SetDebug());
        functions.put("getOptOut", new GetOptOut());
        functions.put("setOptOut", new SetOptOut());
        functions.put("setDispatchInterval", new SetDispatchInterval());
        functions.put("dispatch", new Dispatch());

        // Tracker

        functions.put("setAppName", new SetAppName());
        functions.put("GA_setAppVersion", new SetAppVersion());
        functions.put("getAppID", new GetAppID());
        functions.put("setAppID", new SetAppID());
        functions.put("getAnonymous", new GetAnonymous());
        functions.put("setAnonymous", new SetAnonymous());
        functions.put("getSecure", new GetSecure());
        functions.put("setSecure", new SetSecure());
        functions.put("getSampleRate", new GetSampleRate());
        functions.put("setSampleRate", new SetSampleRate());
        functions.put("startNewSession", new StartNewSession());
        functions.put("trackData", new TrackData());
        functions.put("setCustomDimension", new SetCustomDimension());
        functions.put("setCustomMetric", new SetCustomMetric());

        functions.put("getCampaignData", new GetCampaignData());
        functions.put("setCampaignData", new SetCampaignData());
        functions.put("getReferrer", new GetReferrer());
        functions.put("setReferrer", new SetReferrer());

        return functions;
    }
}
