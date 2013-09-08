/**
 * Project: ANE-Google-Analytics
 *
 * Author:  Alessandro Bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 22/12/12 17.33
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.functions;

import com.adobe.fre.*;
import com.google.analytics.tracking.android.*;
import com.stackoverflow.util.StackTraceInfo;
import eu.alebianco.air.extensions.utils.FREUtils;
import eu.alebianco.air.extensions.utils.LogLevel;

import java.util.Map;

public class TrackData implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FREObject result = null;

        String trackingId;
        try {
            trackingId = args[0].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'trackingId' parameter. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'trackingId' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        String type;
        try {
            type = args[1].getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read the 'type' parameter. [Exception:(type:%s, method:%s)].",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read the 'type' parameter on method '%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()));
        }

        Tracker tracker = GoogleAnalytics.getInstance(context.getActivity()).getTracker(trackingId);

        FREObject data = args[2];

        switch (HitType.valueOf(type)) {
            case VIEW:
                return trackView(context, tracker, data);
            case EVENT:
                return trackEvent(context, tracker, data);
            case EXCEPTION:
                return trackException(context, tracker, data);
            case TIMING:
                return trackTiming(context, tracker, data);
            case SOCIAL:
                return trackSocial(context, tracker, data);
            case TRANSACTION:
                return trackTransaction(context, tracker, data);
            default:
                FREUtils.logEvent(context, LogLevel.WARN, "Hit type not recognized: {0}", type);
        }

        return result;
    }

    private FREObject trackView(FREContext context, Tracker tracker, FREObject data) {

        String screen;
        try {
            screen = data.getProperty("screen").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        tracker.sendView(screen);
        return null;
    }

    private FREObject trackEvent(FREContext context, Tracker tracker, FREObject data) {

        String category;
        String action;
        String label;
        Long value;

        try {
            category = data.getProperty("category").getAsString();
            action = data.getProperty("action").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            label = data.getProperty("label").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            label = null;
        }

        try {
            value = (long) data.getProperty("value").getAsInt();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            value = null;
        }

        Map<String, String> hit = tracker.constructEvent(category, action, label, value);
        tracker.send(ModelFields.EVENT, hit);

        return null;
    }

    private FREObject trackException(FREContext context, Tracker tracker, FREObject data) {

        Boolean fatal;
        String description;

        try {
            fatal = data.getProperty("fatal").getAsBool();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            description = data.getProperty("description").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            description = null;
        }

        Map<String, String> hit = tracker.constructException(description, fatal);
        tracker.send(ModelFields.EXCEPTION, hit);

        return null;
    }

    private FREObject trackTiming(FREContext context, Tracker tracker, FREObject data) {

        String category;
        Long interval;
        String name;
        String label;

        try {
            category = data.getProperty("category").getAsString();
            interval = (long) data.getProperty("interval").getAsInt();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            name = data.getProperty("name").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            name = null;
        }

        try {
            label = data.getProperty("label").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            label = null;
        }

        Map<String, String> hit = tracker.constructTiming(category, interval, name, label);
        tracker.send(ModelFields.TIMING, hit);

        return null;
    }

    private FREObject trackSocial(FREContext context, Tracker tracker, FREObject data) {

        String network;
        String action;
        String content;

        try {
            network = data.getProperty("network").getAsString();
            action = data.getProperty("action").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            content = data.getProperty("content").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            content = null;
        }

        Map<String, String> hit = tracker.constructSocial(network, action, content);
        tracker.send(ModelFields.SOCIAL, hit);

        return null;
    }

    private FREObject trackTransaction(FREContext context, Tracker tracker, FREObject data) {

        String id;
        Double cost;
        String affiliation;
        Double shipping;
        Double tax;

        Long numProducts;
        FREArray products;

        try {
            id = data.getProperty("id").getAsString();
            cost = data.getProperty("cost").getAsDouble();
            products = (FREArray) data.getProperty("products");
            numProducts = products.getLength();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        try {
            affiliation = data.getProperty("affiliation").getAsString();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            affiliation = null;
        }

        try {
            shipping = data.getProperty("shipping").getAsDouble();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            shipping = null;
        }

        try {
            tax = data.getProperty("tax").getAsDouble();
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.INFO,
                    "Unable to read a property, falling back to default value. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            tax = null;
        }


        Transaction.Builder builder = new Transaction.Builder(id, (long) (cost * 1000000));
        if (affiliation != null)
            builder.setAffiliation(affiliation);
        if (shipping != null)
            builder.setShippingCostInMicros((long) (shipping * 1000000));
        if (tax != null)
            builder.setShippingCostInMicros((long) (tax * 1000000));

        Transaction transaction = builder.build();

        try {
            for (long i = 0; i < numProducts; i++) {
                Transaction.Item item = getProductAt(i, products);
                transaction.addItem(item);
            }
        } catch (Exception e) {
            FREUtils.logEvent(context, LogLevel.FATAL,
                    "Unable to read a property. (Exception:[name:%s, reason:%s, method:%s:%s])",
                    FREUtils.stripPackageFromClassName(e.toString()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
            return FREUtils.createRuntimeException("ArgumentError", 0, "Unable to read a property on method '%s:%s'.", FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentClassName()), FREUtils.stripPackageFromClassName(StackTraceInfo.getCurrentMethodName()));
        }

        tracker.sendTransaction(transaction);

        return null;
    }

    private Transaction.Item getProductAt(long i, FREArray products) throws FREWrongThreadException, FREInvalidObjectException, FRETypeMismatchException, FREASErrorException, FRENoSuchNameException {

        FREObject product = products.getObjectAt(i);

        String sku = product.getProperty("sku").getAsString();
        String name = product.getProperty("name").getAsString();
        Double price = product.getProperty("price").getAsDouble();
        Long quantity = (long) product.getProperty("quantity").getAsInt();

        String category;
        try {
            category = product.getProperty("category").getAsString();
        } catch (Exception e) {
            category = null;
        }

        Transaction.Item.Builder builder = new Transaction.Item.Builder(sku, name, (long) (price * 1000000), quantity);
        if (category != null)
            builder.setProductCategory(category);

        return builder.build();
    }

    private enum HitType {
        VIEW, EVENT, EXCEPTION, TIMING, SOCIAL, TRANSACTION
    }
}