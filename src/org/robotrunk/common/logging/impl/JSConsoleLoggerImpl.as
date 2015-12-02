package org.robotrunk.common.logging.impl
{
	import org.robotrunk.common.logging.api.Logger;

	import flash.external.ExternalInterface;


	public class JSConsoleLoggerImpl extends BaseLoggerImpl implements Logger
	{
		override public function set loglevel( id:String ):void {
			super.loglevel = id;
			if(id != null) 
				logExternal( "Log level:" + id );
		}

		override public function debug( alert:String, target:Object = null ):String {
			var logEntry :String = super.debug (alert, target);
			return logExternal( logEntry );
		}

		override public function error( alert:String, target:Object = null ):String {
			var logEntry :String = super.error (alert, target);
			return logExternal( logEntry );
		}

		override public function info( alert:String, target:Object = null ):String {
			var logEntry :String = super.info (alert, target);
			return logExternal( logEntry );
		}

		override public function warn( alert:String, target:Object = null ):String {
			var logEntry :String = super.warn (alert, target);
			return logExternal( logEntry );
		}
		
		private function logExternal ( msg : String ) : String {
			if (ExternalInterface.available) 
              ExternalInterface.call ("flashlog", msg);
			return msg;
		}
	}
}
