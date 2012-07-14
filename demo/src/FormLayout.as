package
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.TextArea;
	import com.bit101.utils.MinimalConfigurator;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	public class FormLayout extends Sprite implements IFormLayout
	{
		private var config:MinimalConfigurator;
		
		private var _state:SessionStatus = SessionStatus.IDLE;
		
		private var _ready:Signal = new Signal(TextArea);
		private var _start:Signal = new Signal(int, Boolean, Boolean, Boolean);
		private var _sync:Signal = new Signal();
		private var _stop:Signal = new Signal();
		private var _pageView:Signal = new Signal(String);
		private var _event:Signal = new Signal(String, String, String, int);
		private var _error:Signal = new Signal(String);
		
		public function FormLayout()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		public function get error():Signal
		{
			return _error;
		}

		public function get event():Signal
		{
			return _event;
		}

		public function get pageView():Signal
		{
			return _pageView;
		}

		public function set status(value:SessionStatus):void
		{
			if (_state != value) {
				_state = value;
				update();
			}
		}
		
		public function get status():SessionStatus
		{
			return _state;
		}
		
		public function get sync():Signal
		{
			return _sync;
		}
		
		public function get stop():Signal
		{
			return _stop;
		}

		public function get start():Signal
		{
			return _start;
		}

		public function get ready():Signal
		{
			return _ready;
		}

		protected function onAddedToStage(evt:Event):void
		{
			init();
		}
		
		private function init():void {
			
			Component.initStage(stage);
			config = new MinimalConfigurator(this);
			config.loadXML("layout.xml");
			config.addEventListener(Event.COMPLETE, onLayoutReady);
		}
		
		private function update():void {
			
			var active:Boolean = status == SessionStatus.ACTIVE;
			
			config.getCompById("session_start").enabled 	= !active;
			config.getCompById("session_stop").enabled 		= active;
			config.getCompById("dispatch").enabled 			= active && CheckBox(config.getCompById("mode_manual")).selected;;
			
			config.getCompById("mode_manual").enabled 		= !active;
			config.getCompById("dispatch_interval").enabled = !active && !CheckBox(config.getCompById("mode_manual")).selected;
			
			config.getCompById("mode_debug").enabled 		= !active;
			config.getCompById("mode_dry").enabled 			= !active;
			config.getCompById("mode_anonymous").enabled 	= !active;
			
			config.getCompById("page_url").enabled 			= active;
			config.getCompById("track_page").enabled 		= active;
			
			config.getCompById("event_category").enabled 	= active;
			config.getCompById("event_action").enabled 		= active;
			config.getCompById("event_label").enabled 		= active;
			config.getCompById("event_value").enabled 		= active;
			config.getCompById("track_event").enabled 		= active;
		}
		
		protected function onLayoutReady(evt:Event):void
		{
			update();
			
			var logger:TextArea = config.getCompById("logger") as TextArea;
			ready.dispatch(logger);
		}
		
		public function onSessionStart(evt:Event):void
		{
			var debug:Boolean = CheckBox(config.getCompById("mode_debug")).selected;
			var dry:Boolean = CheckBox(config.getCompById("mode_dry")).selected;
			var anonymous:Boolean = CheckBox(config.getCompById("mode_anonymous")).selected;

			var manual:Boolean = CheckBox(config.getCompById("mode_manual")).selected;
			var interval:int = NumericStepper(config.getCompById("dispatch_interval")).value;
			
			start.dispatch((manual) ? 0 : interval, debug, dry, anonymous);
		}
		
		public function onDispatch(evt:Event):void
		{
			sync.dispatch();
		}
		
		public function onSessionStop(evt:Event):void
		{
			stop.dispatch();
		}
		
		public function onManualDispatchChange(evt:Event):void
		{
			update();
		}
		
		public function onDebugModeChange(evt:Event):void
		{
			
		}
		
		public function onDryModeChange(evt:Event):void
		{
			
		}
		
		public function onAnonymousModeChange(evt:Event):void
		{
			
		}
		
		public function onTrackPageView(evt:Event):void
		{
			var url:String = InputText(config.getCompById("page_url")).text;
			
			if (url == "") {
				error.dispatch("Missing mandatory field 'url'.");
			} else {
				pageView.dispatch(url);
			}
		}
		
		public function onTrackEvent(evt:Event):void
		{
			var category:String = InputText(config.getCompById("event_category")).text;
			var action:String = InputText(config.getCompById("event_action")).text;
			var label:String = InputText(config.getCompById("event_label")).text || "";
			var value:int = NumericStepper(config.getCompById("event_value")).value || -1;
			
			if (category == "") {
				error.dispatch("Missing mandatory field 'category'.");
			} else if (action == "") {
				error.dispatch("Missing mandatory field 'action'.");
			} else {
				event.dispatch(category, action, label, value);
			}
		}
		
	}
}