/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 01.05
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IViewBuilder;

internal class ViewBuilder implements IViewBuilder {

	private var tracker:Tracker;

	internal var screen:String;

	public function ViewBuilder(tracker:Tracker, screenName:String) {
		this.tracker = tracker;

		this.screen = screenName;
	}

	public function create():Hit {
		return new View(this);
	}

	public function track():void {
		tracker.send(HitType.VIEW, create());
	}
}
}
