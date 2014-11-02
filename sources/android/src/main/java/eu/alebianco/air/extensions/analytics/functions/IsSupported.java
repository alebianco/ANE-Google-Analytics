/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.28
 */
package eu.alebianco.air.extensions.analytics.functions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class IsSupported implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        Activity activity = context.getActivity();
        PackageManager pm = activity.getPackageManager();

        int hasInternet = pm.checkPermission(Manifest.permission.INTERNET, activity.getPackageName());
        int hasNetworkState = pm.checkPermission(Manifest.permission.ACCESS_NETWORK_STATE, activity.getPackageName());

        Boolean hasPermissions = hasInternet == PackageManager.PERMISSION_GRANTED &&
                hasNetworkState == PackageManager.PERMISSION_GRANTED;

        try {
            result = FREObject.newObject(hasPermissions);
        } catch(Exception e) {
            // TODO handle exceptions
        }

        return result;
    }
}