package
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.Component;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.TextArea;
	import com.bit101.utils.MinimalConfigurator;
	
	import eu.alebianco.air.extensions.analytics.GATracker;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	
	public class Demo extends Sprite
	{
		private const ANALYTICS_ID:String = "<YOUR_ID>";
		
		private var tracker:GATracker;
		private var logger:ILogger;
		private var form:IFormLayout;
		
		public function Demo()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var className:String = getQualifiedClassName(this).replace("::", ".");
			logger = Log.getLogger(className);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			init();
		}
		
		private function init():void {
			
			form = new FormLayout();
			form.ready.addOnce(registerLogger);
			form.error.add(error);
			form.start.add(startSession);
			form.sync.add(syncQueue);
			form.stop.add(stopSession);
			form.pageView.add(trackPageView);
			form.event.add(trackEvent);
				
			addChild(form as DisplayObject);
		}
		
		protected function registerLogger(logger:TextArea):void
		{
			var logTarget:LoggerTarget = new LoggerTarget(logger.textField);
			logTarget.level = LogEventLevel.ALL;
			logTarget.filters = ["eu.alebianco.*", "Demo"];
			logTarget.includeDate = false;
			logTarget.includeTime = true;
			logTarget.includeLevel = true;
			logTarget.fieldSeparator = "  ";
			Log.addTarget(logTarget);
		}
		
		protected function startSession(interval:int = 20, debug:Boolean = false, dry:Boolean = false, anonymous:Boolean = false):void
		{
			if (GATracker.isSupported()) {
				
				tracker = GATracker.getInstance();
				tracker.startNewSession(ANALYTICS_ID, interval);
				tracker.debug = debug;
				tracker.dryRun = dry;
				tracker.anonymizeIp = anonymous;
				
				form.status = SessionStatus.ACTIVE;
				logger.debug("GATracker is ready. version: {0}", tracker.version);
			} else {
				logger.debug("GATracker extension not supported.");
			}
		}
		
		protected function syncQueue():void
		{
			tracker.dispatch();
		}
		
		protected function stopSession():void
		{
			try {
				tracker.stopSession();
				tracker.dispose();
			}
			catch (e:Error)
			{
				logger.error("{0}", e);
			}
			finally {
				tracker = null;
				form.status = SessionStatus.IDLE;
			}
		}
		
		protected function trackPageView(url:String):void
		{
			tracker.trackPageView(url);
		}
		
		protected function trackEvent(category:String, action:String, label:String = "", value:int = -1):void
		{
			tracker.trackEvent(category, action, label, value);
		}
		
		private function error(...params):void
		{
			logger.error(params.join(" "));
		}
	}
}