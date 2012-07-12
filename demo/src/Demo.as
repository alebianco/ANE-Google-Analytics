package
{
	import com.bit101.components.TextArea;
	import com.bit101.components.VBox;
	
	import eu.alebianco.air.extensions.analytics.GATracker;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	
	public class Demo extends Sprite
	{
		private var tracker:GATracker;
		
		private var logger:TextArea;
		
		public function Demo()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function init():void {
			
			buildUI();
			
			var logTarget:LoggerTarget = new LoggerTarget(logger.textField);
			logTarget.level = LogEventLevel.ALL;
			logTarget.filters = ["eu.alebianco.*"];
			logTarget.includeDate = true;
			logTarget.includeTime = true;
			logTarget.includeLevel = true;
			Log.addTarget(logTarget);
			
			createTracker(new Event(Event.ACTIVATE));
		}
		
		protected function onAddedToStage(event:Event):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			init();
		}
		
		private function buildUI():void {
			
			var vbox:VBox = new VBox(this, 20, 20);
			
			logger = new TextArea(vbox);
			logger.setSize(stage.stageWidth-40, 300);
		}
		
		private function createTracker(event:Event):void
		{
			if (GATracker.isSupported()) {
				tracker = GATracker.getInstance();
				
				log("GATracker is ready. version: ", tracker.version);
			} else {
				log("GATracker extension not supported.");
			}
		}
		
		private function disposeManager(event:Event):void
		{
			tracker.dispose();
		}
		
		private function log(...params):void {
			
			logger.text += params.join(" ")+"\n";
		}
		
	}
}