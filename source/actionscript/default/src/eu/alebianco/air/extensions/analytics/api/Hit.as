/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 00.29
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.api {
import eu.alebianco.air.extensions.analytics.HitType;

public interface Hit {
    /**
     * Returns the type of data to be tracked.
     */
    function get type():HitType;
}
}
