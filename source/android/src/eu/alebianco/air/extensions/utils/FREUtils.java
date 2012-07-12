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
		return new Exception().getStackTrace()[0].getMethodName();
	}
	
	public static String getClassName()
	{
		return new Exception().getStackTrace()[0].getClassName();
	}
}
