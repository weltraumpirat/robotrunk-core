package org.robotrunk.common.loader.impl
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import org.robotrunk.common.event.ProgressItemEvent;
	import org.robotrunk.common.loader.api.ILoader;
	import org.robotrunk.common.progress.ProgressItemImpl;



	public class BaseLoaderImpl extends ProgressItemImpl implements ILoader
	{
		private var _filePath:String;

		private var _payload:Object;

		protected var _urlLoader:URLLoader;

		override public function destroy():void {
			super.destroy();
			destroyLoader();
			_filePath = null;
			_payload = null;
		}

		private function destroyLoader():void {
			_urlLoader.data = null;
			_urlLoader = null;
		}

		public function load( filePath:String = null, data:URLVariables = null ):void {
			var path:String = filePath != null ? filePath : _filePath;
			if(path != null)
				loadFromPath( path, data );
		}

		private function loadFromPath( path:String, data:URLVariables = null ):void {
			var url:URLRequest = new URLRequest( path );
			url.data = data;
			loadURL( url );
		}

		public function loadURL( url:URLRequest ):void {
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener( Event.COMPLETE, onComplete );
			_urlLoader.addEventListener( Event.OPEN, onLoad );
			_urlLoader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_urlLoader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_urlLoader.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
			_urlLoader.load( url );
		}

		protected function onComplete( ev:Event ):void {
			progress = 1;
			_payload = _urlLoader.data;
			destroyLoader();
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function onHttpStatus( event:HTTPStatusEvent ):void {
			status = "HTTPStatus:"+event.status;
		}

		private function onIOError( ev:IOErrorEvent ):void {
			error = "IO ERROR: "+ev.text;
		}

		protected function onLoad( ev:Event ):void {
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.START ) );
		}

		private function onProgress( ev:ProgressEvent ):void {
			progress = ev.bytesLoaded/ev.bytesTotal;
		}

		private function onSecurityError( ev:SecurityErrorEvent ):void {
			error = "SECURITY ERROR: "+ev.text;
		}

		public function BaseLoaderImpl( filePath:String = null ):void {
			super();
			if(filePath) _filePath = filePath;
		}

		public function get filePath():String {
			return _filePath;
		}

		public function set filePath( filePath:String ):void {
			_filePath = filePath;
		}

		public function get payload():Object {
			return _payload;
		}
	}
}
