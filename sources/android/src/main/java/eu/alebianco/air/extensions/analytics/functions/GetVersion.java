/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.28
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.android.gms.analytics.GoogleAnalytics;
import eu.alebianco.air.extensions.analytics.R;

public class GetVersion implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        GoogleAnalytics.getInstance(context.getActivity());

        try {
            result = FREObject.newObject(R.string.name + " v" + R.string.version);
        } catch(Exception e) {
            //TODO handle exceptions
        }

        return result;
    }
}