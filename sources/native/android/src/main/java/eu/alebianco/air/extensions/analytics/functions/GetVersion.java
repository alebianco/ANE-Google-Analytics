/**
 * Project: ANELytics
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
import eu.alebianco.air.extensions.analytics.GAContext;
import eu.alebianco.air.extensions.analytics.R;

public class GetVersion implements FREFunction {

    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        GAContext context = (GAContext) ctx;
        FREObject result = null;

        try {
            final String name = context.getString(R.string.name);
            final String version = context.getString(R.string.version);
            result = FREObject.newObject(String.format("%s v%s", name, version));
        } catch(Exception e) {
            //TODO handle exceptions
        }

        return result;
    }
}