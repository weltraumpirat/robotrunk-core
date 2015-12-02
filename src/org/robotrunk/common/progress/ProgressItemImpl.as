package org.robotrunk.common.progress
{
	import org.robotrunk.common.event.ProgressItemEvent;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;


	public class ProgressItemImpl extends EventDispatcher implements ProgressItem
	{
		private var _error:String;

		private var _failOnError:Boolean;

		private var _progress:Number = 0;

		private var _status:String;

		public function ProgressItemImpl( target:IEventDispatcher = null ) {
			super( target );
		}

		public function destroy():void {
			_error = null;
			_failOnError = false;
			_progress = 0;
			_status = null;
		}

		private function dispatch( type:String, str:String, data:* = null ):void {
			var event:ProgressItemEvent = new ProgressItemEvent( type ) ;
			event.message = str;
			event.data = data;
			dispatchEvent( event );
		}

		public function get error():String {
			return _error;
		}

		public function set error( str:String ):void {
			_error = !_error ? str : _error+"\n"+str;
			dispatch( ProgressItemEvent.ERROR, str );
		}

		public function get failOnError():Boolean {
			return _failOnError;
		}

		public function set failOnError( bool:Boolean ):void {
			_failOnError = bool;
		}

		public function get progress():Number {
			return isNaN(_progress) ? 0 : _progress;
		}

		public function set progress( percent:Number ):void {
			
			_progress = isNaN(percent) || percent < 0 ? 0 : percent > 1 ? 1 : percent;
			if(_progress > 0) dispatch( ProgressItemEvent.PROGRESS, null, _progress );
		}

		public function get progressPercent():Number {
			return Math.round( _progress*10000 )*.01;
		}

		public function get status():String {
			return _status;
		}

		public function set status( str:String ):void {
			_status = _status == null ? str : _status+"\n"+str;
			dispatch( ProgressItemEvent.STATUS, str );
		}
	}
}
