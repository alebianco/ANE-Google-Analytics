/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 12/02/14 20.05
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class GetCampaignData implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        Activity activity = context.getActivity();
        Intent intent = activity.getIntent();
        Uri uri = intent.getData();

        if (uri != null && uri.getQueryParameter("utm_source") != null) {
            try {
                result = FREObject.newObject(uri.getQuery());
            } catch(Exception e) {
                FREUtils.logEvent(context, LogLevel.ERROR,
                        "Unable to create the return value. [Exception:(type:%s, method:%s)].",
                        FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
                return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to create the return value on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            }
        }

        return result;
    }
}