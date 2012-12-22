/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 0.19
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.IEventBuilder;

internal class EventBuilder implements IEventBuilder {

	private var tracker:Tracker;

	internal var category:String;
	internal var action:String;
	internal var label:String;
	internal var value:Object = null;

	public function EventBuilder(tracker:Tracker, category:String, action:String) {
		this.tracker = tracker;

		this.category = category;
		this.action = action;
		this.label = label;
	}

	public function withLabel(label:String):IEventBuilder {
		this.label = label;
		return this;
	}

	public function withValue(value:int):IEventBuilder {
		this.value = value;
		return this;
	}

	public function create():Hit {
		return new EventHit(this);
	}

	public function track():void {
		tracker.send(HitType.EVENT, create());
	}
}
}
