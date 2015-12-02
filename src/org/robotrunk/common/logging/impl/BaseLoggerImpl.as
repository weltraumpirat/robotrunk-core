package org.robotrunk.common.logging.impl {
	import flash.utils.getQualifiedClassName;

	import org.robotrunk.common.logging.api.Logger;

	public class BaseLoggerImpl implements Logger {
		private var _loglevel:String = LogLevel.DEBUG;

		public function get loglevel():String {
			return _loglevel;
		}

		public function set loglevel( id:String ):void {
			_loglevel = id;
		}

		public function debug( alert:String, target:Object = null ):String {
			return loglevel == LogLevel.DEBUG ? "[DEBUG]  "+getMessage( alert, target ) : "";
		}

		public function error( alert:String, target:Object = null ):String {
			return loglevel == LogLevel.DEBUG || loglevel == LogLevel.INFO || loglevel == LogLevel.WARN || loglevel == LogLevel.ERROR
					? "[ERROR]  "+getMessage( alert, target )
					: "";
		}

		public function info( alert:String, target:Object = null ):String {
			return loglevel == LogLevel.DEBUG || loglevel == LogLevel.INFO
					? "[INFO]  "+getMessage( alert, target )
					: "";
		}

		public function warn( alert:String, target:Object = null ):String {
			return loglevel == LogLevel.DEBUG || loglevel == LogLevel.INFO || loglevel == LogLevel.WARN
					? "[WARN]  "+getMessage( alert, target )
					: "";
		}

		private function getMessage( alert:String, target:Object ):String {
			var msg:String = "";
			msg += target != null ? "["+getClass( target )+"]  --  " : "";
			msg += alert;
			return msg;
		}

		private function getClass( target:Object ):String {
			var name:String = getQualifiedClassName( target );
			return name.substr( name.indexOf( "::" )+2 );
		}
	}
}
