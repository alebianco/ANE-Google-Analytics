/* Utility class: Getting the name of the current executing method
 * http://stackoverflow.com/questions/442747/getting-the-name-of-the-current-executing-method
 *
 * Provides:
 *
 *      getCurrentClassName()
 *      getCurrentMethodName()
 *      getCurrentFileName()
 *
 *      getInvokingClassName()
 *      getInvokingMethodName()
 *      getInvokingFileName()
 *
 * Nb. Using StackTrace's to get this info is expensive. There are more optimised ways to obtain
 * method names. See other stackoverflow posts eg. http://stackoverflow.com/questions/421280/in-java-how-do-i-find-the-caller-of-a-method-using-stacktrace-or-reflection/2924426#2924426
 *
 * 29/09/2012 (lem) - added methods to return (1) fully qualified names and (2) invoking class/method names
 */
package com.stackoverflow.util;

public class StackTraceInfo
{
    /* (Lifted from virgo47's stackoverflow answer) */
    private static final int CLIENT_CODE_STACK_INDEX;

    static {
        // Finds out the index of "this code" in the returned stack trace - funny but it differs in JDK 1.5 and 1.6
        int i = 0;
        for (StackTraceElement ste: Thread.currentThread().getStackTrace())
        {
            i++;
            if (ste.getClassName().equals(StackTraceInfo.class.getName()))
            {
                break;
            }
        }
        CLIENT_CODE_STACK_INDEX = i;
    }

    public static String getCurrentMethodName()
    {
        return getCurrentMethodName(1);     // making additional overloaded method call requires +1 offset
    }

    private static String getCurrentMethodName(int offset)
    {
        return Thread.currentThread().getStackTrace()[CLIENT_CODE_STACK_INDEX + offset].getMethodName();
    }

    public static String getCurrentClassName()
    {
        return getCurrentClassName(1);      // making additional overloaded method call requires +1 offset
    }

    private static String getCurrentClassName(int offset)
    {
        return Thread.currentThread().getStackTrace()[CLIENT_CODE_STACK_INDEX + offset].getClassName();
    }

    public static String getCurrentFileName()
    {
        return getCurrentFileName(1);     // making additional overloaded method call requires +1 offset
    }

    private static String getCurrentFileName(int offset)
    {
        String filename = Thread.currentThread().getStackTrace()[CLIENT_CODE_STACK_INDEX + offset].getFileName();
        int lineNumber = Thread.currentThread().getStackTrace()[CLIENT_CODE_STACK_INDEX + offset].getLineNumber();

        return filename + ":" + lineNumber;
    }

    public static String getInvokingMethodName()
    {
        return getInvokingMethodName(2);
    }

    private static String getInvokingMethodName(int offset)
    {
        return getCurrentMethodName(offset + 1);    // re-uses getCurrentMethodName() with desired index
    }

    public static String getInvokingClassName()
    {
        return getInvokingClassName(2);
    }

    private static String getInvokingClassName(int offset)
    {
        return getCurrentClassName(offset + 1);     // re-uses getCurrentClassName() with desired index
    }

    public static String getInvokingFileName()
    {
        return getInvokingFileName(2);
    }

    private static String getInvokingFileName(int offset)
    {
        return getCurrentFileName(offset + 1);     // re-uses getCurrentFileName() with desired index
    }

    public static String getCurrentMethodNameFqn()
    {
        return getCurrentMethodNameFqn(1);
    }

    private static String getCurrentMethodNameFqn(int offset)
    {
        String currentClassName = getCurrentClassName(offset + 1);
        String currentMethodName = getCurrentMethodName(offset + 1);

        return currentClassName + "." + currentMethodName ;
    }

    public static String getCurrentFileNameFqn()
    {
        String CurrentMethodNameFqn = getCurrentMethodNameFqn(1);
        String currentFileName = getCurrentFileName(1);

        return CurrentMethodNameFqn + "(" + currentFileName + ")";
    }

    public static String getInvokingMethodNameFqn()
    {
        return getInvokingMethodNameFqn(2);
    }

    private static String getInvokingMethodNameFqn(int offset)
    {
        String invokingClassName = getInvokingClassName(offset + 1);
        String invokingMethodName = getInvokingMethodName(offset + 1);

        return invokingClassName + "." + invokingMethodName;
    }

    public static String getInvokingFileNameFqn()
    {
        String invokingMethodNameFqn = getInvokingMethodNameFqn(2);
        String invokingFileName = getInvokingFileName(2);

        return invokingMethodNameFqn + "(" + invokingFileName + ")";
    }
}