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
import eu.alebianco.air.extensions.analytics.GAContext;

public class Initialise implements FREFunction {

    @Override
    public FREObject call(FREContext ctx, FREObject[] args) {
        GAContext context = (GAContext) ctx;
        FREObject result = null;

        try {
            context.initialise();
        } catch(Exception e) {
            //TODO handle exceptions
        }

        return result;
    }
}