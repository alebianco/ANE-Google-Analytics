/**
 * Project: ANELytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.27
 */
package eu.alebianco.air.extensions.analytics;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GAExtension implements FREExtension {

    public static GAContext context;

    @Override
    public FREContext createContext(String id) {
        context = new GAContext();
        return context;
    }

    @Override
    public void dispose() {
        context.dispose();
        context = null;
    }

    @Override
    public void initialize() {
    }
}