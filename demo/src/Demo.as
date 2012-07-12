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
		private const ANALYTICS_ID:String = "UA-29711569-1";
		
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
			form.start.add(startSession);
			form.stop.add(stopSession);
				
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
		
		protected function startSession(interval:int):void
		{
			if (GATracker.isSupported()) {
				tracker = GATracker.getInstance();
				tracker.startNewSession(ANALYTICS_ID, interval);
				form.status = SessionStatus.ACTIVE;
				log("GATracker is ready. version: ", tracker.version);
			} else {
				log("GATracker extension not supported.");
			}
		}
		
		protected function stopSession():void
		{
			try {
				tracker.stopSession();
				tracker.dispose();
			}
			catch (e:Error)
			{
				log(e);
			}
			finally {
				tracker = null;
				form.status = SessionStatus.IDLE;
			}
		}
		
		private function log(...params):void
		{
			logger.debug(params.join(" "));
		}
		
	}
}