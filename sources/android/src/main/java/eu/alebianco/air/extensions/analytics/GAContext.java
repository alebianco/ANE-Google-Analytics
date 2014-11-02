/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.25
 */
package eu.alebianco.air.extensions.analytics;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import eu.alebianco.air.extensions.analytics.functions.GetVersion;
import eu.alebianco.air.extensions.analytics.functions.IsSupported;

import java.util.Map;

public class GAContext extends FREContext {

    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();

        // Extension

        functions.put("isSupported", new IsSupported());
        functions.put("getVersion", new GetVersion());

        return functions;
    }
}