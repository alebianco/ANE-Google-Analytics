package eu.alebianco.air.extensions.utils;

import android.util.Log;

import com.adobe.fre.FREContext;

public class FREUtils {

    public static final String LOGTAG = "ANE";

    public static void logEvent(FREContext context, LogLevel level, String format, Object... args) {

        String message = String.format(format, args);

        Log.println(level.getPriority(), LOGTAG, message);
        context.dispatchStatusEventAsync(message, level.getName());
    }

    public static String getMethodName()
    {
        StackTraceElement info = new Exception().getStackTrace()[1];
        return info.getMethodName();
    }

    public static String getClassName()
    {
        StackTraceElement info = new Exception().getStackTrace()[1];
        return info.getClassName().substring(info.getClassName().lastIndexOf(".") + 1);
    }
}
