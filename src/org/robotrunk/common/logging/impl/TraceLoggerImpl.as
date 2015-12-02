package org.robotrunk.common.logging.impl {
	import org.robotrunk.common.logging.api.Logger;

	public class TraceLoggerImpl extends BaseLoggerImpl implements Logger {
		override public function set loglevel( id:String ):void {
			super.loglevel = id;
			if( id != null )
				trace( "Loglevel : "+id );
		}

		override public function debug( alert:String, target:Object = null ):String {
			var logEntry:String = super.debug( alert, target );
			return output( logEntry );
		}

		override public function error( alert:String, target:Object = null ):String {
			var logEntry:String = super.error( alert, target );
			return output( logEntry );
		}

		override public function info( alert:String, target:Object = null ):String {
			var logEntry:String = super.info( alert, target );
			return output( logEntry );
		}

		override public function warn( alert:String, target:Object = null ):String {
			var logEntry:String = super.warn( alert, target );
			return output( logEntry );
		}

		private function output( logEntry:String ):String {
			if( logEntry != null && logEntry.length>0 )
				trace( logEntry );
			return logEntry;
		}
	}
}
