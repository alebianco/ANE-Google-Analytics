package
{
	import flash.text.TextField;
	
	import mx.core.mx_internal;
	import mx.logging.targets.LineFormattedTarget;
	
	use namespace mx_internal;
	
	public class LoggerTarget extends LineFormattedTarget
	{
		private var logger:TextField;
		
		public function LoggerTarget(logger:TextField)
		{
			super();
			this.logger = logger;
		}
		
		override mx_internal function internalLog(message:String):void
		{
			logger.appendText(message+"\n");
			logger.scrollV = logger.maxScrollV;
		}
	}
}