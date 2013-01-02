/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 12.00
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.ITimingBuilder;

internal class TimingBuilder implements ITimingBuilder {

	private var tracker:Tracker;

	internal var category:String;
	internal var interval:uint;
	internal var name:String = null;
	internal var label:String = null;

	public function TimingBuilder(tracker:Tracker, category:String, interval:uint) {
		this.tracker = tracker;

		this.category = category;
		this.interval = interval;
	}

	public function withName(name:String):ITimingBuilder {
		this.name = name;
		return this;
	}

	public function withLabel(label:String):ITimingBuilder {
		this.label = label;
		return this;
	}

	public function create():Hit {
		return new Timing(this);
	}

	public function track():void {
		tracker.send(HitType.TIMING, create());
	}
}
}
