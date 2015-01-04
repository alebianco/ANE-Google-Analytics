/**
 * Project: ANELytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 26/10/14 15.25
 */
package eu.alebianco.air.extensions.analytics;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import eu.alebianco.air.extensions.analytics.functions.GetVersion;
import eu.alebianco.air.extensions.analytics.functions.Initialise;
import eu.alebianco.air.extensions.analytics.functions.IsSupported;

import java.util.Map;

public class GAContext extends FREContext {

    Activity activity;
    Resources resources;
    PackageManager packageManager;
    String packageName;

    public GAContext() {
        super();
    }

    public void initialise() {
        activity = getActivity();
        resources = activity.getResources();
        packageManager = activity.getPackageManager();
        packageName = activity.getPackageName();
    }

    @Override
    public void dispose() {
        activity = null;
        resources = null;
        packageManager = null;
        packageName = null;
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();

        // Extension

        functions.put("initialise", new Initialise());
        functions.put("isSupported", new IsSupported());
        functions.put("getVersion", new GetVersion());

        return functions;
    }

    public Boolean hasPermission(String permission) {
        final int state = packageManager.checkPermission(permission, packageName);
        return state == PackageManager.PERMISSION_GRANTED;
    }

    public String getString(int id) {
        return resources.getString(id);
    }
}