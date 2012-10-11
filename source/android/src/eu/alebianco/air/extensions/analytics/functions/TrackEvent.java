/*
 * Air Native Extension for Google Analytics on iOS and Android
 * 
 * Author: Alessandro Bianco
 * http://alessandrobianco.eu
 *
 * Copyright (c) 2012 Alessandro Bianco
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.google.android.apps.analytics.GoogleAnalyticsTracker;

import eu.alebianco.air.extensions.analytics.GAContext;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

public class TrackEvent implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		if (args == null || args.length < 2) {

			FREUtils.logEvent(context, LogLevel.FATAL, "Invalid arguments number for method '%s'", FREUtils.getClassName());
			return null;
		}

        String category;
        String action;
        String label = "";
        int value = -1;

        try {
            category = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL, "Unable to read the 'category' parameter.\n(Exception:[name:%s,reason:%s,method:%s])", e.toString().substring(e.toString().lastIndexOf('.') + 1), e.getMessage(), FREUtils.getClassName());
            return null;
        }

        try {
            action = args[1].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL, "Unable to read the 'action' parameter.\n(Exception:[name:%s,reason:%s,method:%s])", e.toString().substring(e.toString().lastIndexOf('.') + 1), e.getMessage(), FREUtils.getClassName());
            return null;
        }

        if (args.length >= 3 && args[2] != null) {
            try {
                label = args[2].getAsString();
            } catch (Exception e) {
                FREUtils.logEvent(context, LogLevel.WARN, "Unable to read the 'label' parameter.\n(Exception:[name:%s,reason:%s,method:%s])", e.toString().substring(e.toString().lastIndexOf('.') + 1), e.getMessage(), FREUtils.getClassName());
            }
        }

        if (args.length >= 4 && args[3] != null) {
            try {
                value = args[3].getAsInt();
            } catch (Exception e) {
                FREUtils.logEvent(context, LogLevel.WARN, "Unable to read the 'value' parameter.\n(Exception:[name:%s,reason:%s,method:%s])", e.toString().substring(e.toString().lastIndexOf('.') + 1), e.getMessage(), FREUtils.getClassName());
            }
        }

		try {

            GoogleAnalyticsTracker tracker = ((GAContext) context).tracker;
			tracker.trackEvent(category, action, label, value);
		}
		catch(Exception e) {

			FREUtils.logEvent(context, LogLevel.FATAL, "%s method failed because: %s", FREUtils.getClassName(), e.getMessage());
		}
		
		return null;
	}

}
