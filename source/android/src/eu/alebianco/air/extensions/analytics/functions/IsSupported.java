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

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class IsSupported implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result;

        Activity activity = context.getActivity();
        PackageManager pm = activity.getPackageManager();
        int hasInternet = pm.checkPermission(Manifest.permission.INTERNET, activity.getPackageName());
        int hasNetworkState = pm.checkPermission(Manifest.permission.ACCESS_NETWORK_STATE, activity.getPackageName());
        Boolean hasPermissions = hasInternet == PackageManager.PERMISSION_GRANTED &&
                                 hasNetworkState == PackageManager.PERMISSION_GRANTED;

        try {
            result = FREObject.newObject(hasPermissions);
        } catch(Exception e) {
            FREUtils.logEvent(context, LogLevel.ERROR,
                    "Unable to create the return value. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to create the return value on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        if (!hasPermissions) {
            FREUtils.logEvent(context, LogLevel.WARN, "Application must have INTERNET and ACCESS_NETWORK_STATE permissions set in its Manifest.");
        }

        return result;
    }
}