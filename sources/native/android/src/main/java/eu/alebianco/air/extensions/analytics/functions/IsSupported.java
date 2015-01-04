/**
 * Project: ANELytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.28
 */
package eu.alebianco.air.extensions.analytics.functions;

import android.Manifest;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import eu.alebianco.air.extensions.analytics.GAContext;

public class IsSupported implements FREFunction {

    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        GAContext context = (GAContext) ctx;
        FREObject result = null;

        try {
            Boolean hasInternet = context.hasPermission(Manifest.permission.INTERNET);
            Boolean hasNetworkState = context.hasPermission(Manifest.permission.ACCESS_NETWORK_STATE);
            result = FREObject.newObject(hasInternet && hasNetworkState);
        } catch(Exception e) {
            // TODO handle exceptions
        }

        return result;
    }
}