package eu.alebianco.air.extensions.utils;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;

public class FREUtils {

    public static final String LOGTAG = "ANE";

    public static void logEvent(FREContext context, LogLevel level, String format, Object... args) {

        String message = String.format(format, args);

        Log.println(level.getPriority(), LOGTAG, message);
        context.dispatchStatusEventAsync(message, level.getName());
    }

    public static String getMethodName()
    {
        return getStackInfo().getMethodName();
    }

    public static String getClassName()
    {
        return stripPackageFromClassName(getStackInfo().getClassName());
    }
    
    public static String stripPackageFromClassName(String className)
    {
    	return className.substring(className.lastIndexOf(".") + 1);
    }
    
    private static StackTraceElement getStackInfo(int i)
    {
    	return new Exception().getStackTrace()[i];
    }
    private static StackTraceElement getStackInfo()
    {
    	return getStackInfo(1);
    }

	public static FREObject createRuntimeException(String className, int id, String message, Object... data) {
        
		FREObject error = null;
        FREObject[] args = new FREObject[2] ;
        try {
        	args[2] = FREObject.newObject(id);
        	args[1] = FREObject.newObject(String.format(message, data));
            error = FREObject.newObject(className, args);
		} catch (Exception e1) {
			Log.println(LogLevel.ERROR.getPriority(), LOGTAG, String.format("Inception Error: Unable to create the runtime exception to notify the application about the previous error.\n[Error:(type:%s, message:%s]", stripPackageFromClassName(className), String.format(message, data)));
		}
        return error;
	}
}
