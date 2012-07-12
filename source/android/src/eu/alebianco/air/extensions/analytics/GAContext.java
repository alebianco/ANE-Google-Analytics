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
 package eu.alebianco.air.extensions.analytics;

import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.google.android.apps.analytics.GoogleAnalyticsTracker;

import eu.alebianco.air.extensions.analytics.functions.Dispatch;
import eu.alebianco.air.extensions.analytics.functions.GetCustomVar;
import eu.alebianco.air.extensions.analytics.functions.GetDebug;
import eu.alebianco.air.extensions.analytics.functions.GetDryRun;
import eu.alebianco.air.extensions.analytics.functions.GetSampleRate;
import eu.alebianco.air.extensions.analytics.functions.GetVersion;
import eu.alebianco.air.extensions.analytics.functions.IsSupported;
import eu.alebianco.air.extensions.analytics.functions.SetAnonymizeIp;
import eu.alebianco.air.extensions.analytics.functions.SetCustomVar;
import eu.alebianco.air.extensions.analytics.functions.SetDebug;
import eu.alebianco.air.extensions.analytics.functions.SetDryRun;
import eu.alebianco.air.extensions.analytics.functions.SetSampleRate;
import eu.alebianco.air.extensions.analytics.functions.StartNewSession;
import eu.alebianco.air.extensions.analytics.functions.StopSession;
import eu.alebianco.air.extensions.analytics.functions.TrackEvent;
import eu.alebianco.air.extensions.analytics.functions.TrackPageView;

public class GAContext extends FREContext {

	public GoogleAnalyticsTracker tracker;
	
	public void initialize() {
		
		tracker = GoogleAnalyticsTracker.getInstance(); 
	}
	
	@Override
	public void dispose() {
		
		tracker.stopSession();
		tracker = null;
	}
	
	@Override
	public Map<String, FREFunction> getFunctions() {
		
		Map<String, FREFunction> functions = new java.util.HashMap<String, FREFunction>();
		
		functions.put("isSupported", new IsSupported());
		functions.put("getVersion", new GetVersion());
		
		functions.put("startNewSession", new StartNewSession());
		functions.put("stopSession", new StopSession());
		
		functions.put("dispatch", new Dispatch());

		functions.put("setSampleRate", new SetSampleRate());
		functions.put("getSampleRate", new GetSampleRate());
		
		functions.put("setCustomVar", new SetCustomVar());
		functions.put("getCustomVar", new GetCustomVar());
		
		functions.put("setDebug", new SetDebug());
		functions.put("getDebug", new GetDebug());
		functions.put("setDryRun", new SetDryRun());
		functions.put("getDryRun", new GetDryRun());

		functions.put("setAnonymizeIp", new SetAnonymizeIp());
		
		functions.put("trackPageView", new TrackPageView());
		functions.put("trackEvent", new TrackEvent());
		
		/*
			tracker.addTransaction(arg0)
			tracker.addItem(arg0)
			tracker.trackTransactions()
			tracker.clearTransactions()
		*/
		
		return functions;
	}

}
