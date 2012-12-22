/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/12/12 14.10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GAExtension implements FREExtension {

    public static final String TAG = "GAExtension";
    public static GAContext context;

    @Override
    public FREContext createContext(String id) {
        context = new GAContext();
        context.initialize();
        return context;
    }

    @Override
    public void dispose() {
        context.dispose();
        context = null;
    }

    @Override
    public void initialize() {
        // TODO auto generated stub method	
    }
}