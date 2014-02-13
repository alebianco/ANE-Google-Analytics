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
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class GetCampaignData implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        Activity activity = context.getActivity();
        Intent intent = activity.getIntent();
        Uri uri = intent.getData();

        if (uri != null) {
            Log.i("ANE", uri.toString());
        } else {
            Log.i("ANE", "uri is null");
        }

        return result;
    }
}