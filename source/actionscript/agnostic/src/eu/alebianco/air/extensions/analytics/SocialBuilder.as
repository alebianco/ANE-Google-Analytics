/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.06
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.ISocialBuilder;

internal class SocialBuilder implements ISocialBuilder {

	private var tracker:Tracker;

	internal var network:String;
	internal var action:String;
	internal var content:String;

	public function SocialBuilder(tracker:Tracker, network:String, action:String) {
		this.tracker = tracker;

		this.network = network;
		this.action = action;
	}

	public function forContent(content:String):ISocialBuilder {
		this.content = content;
		return this;
	}

	public function create():Hit {
		return new SocialHit(this);
	}

	public function track():void {
		tracker.send(HitType.SOCIAL, create());
	}
}
}
