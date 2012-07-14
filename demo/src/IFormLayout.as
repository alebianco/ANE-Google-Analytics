package
{	
	import org.osflash.signals.Signal;

	public interface IFormLayout
	{
		function get status():SessionStatus;
		function set status(value:SessionStatus):void;
		
		function get ready():Signal;
		function get start():Signal;
		function get sync():Signal;
		function get stop():Signal;
		function get pageView():Signal;
		function get event():Signal;
		
		function get error():Signal;
		
	}
}