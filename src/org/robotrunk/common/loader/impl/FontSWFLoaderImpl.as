package org.robotrunk.common.loader.impl
{
	import ru.etcs.utils.FontLoader;

	import org.robotrunk.common.event.ProgressItemEvent;
	import org.robotrunk.common.loader.api.ILoader;
	import org.robotrunk.common.progress.ProgressItemImpl;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;




	public class FontSWFLoaderImpl extends ProgressItemImpl implements ILoader
	{
		private var _filePath:String;

		private var _loader:FontLoader;

		override public function destroy():void {
			clearListeners();
			_loader = null;
			super.destroy();
		}

		public function load( filePath:String = null, data:URLVariables = null ):void {
			var path:String = filePath != null ? filePath : _filePath;
			if(path)
				loadFromPath( path, data );
		}

		private function loadFromPath( path:String, data:URLVariables ):void {
			var url:URLRequest = new URLRequest( path );
			url.data = data;
			loadURL( url );
		}

		public function loadURL( url:URLRequest ):void {
			_loader ||= new FontLoader();
			_loader.autoRegister = true;
			_loader.load( url );
			createListeners();
		}

		private function createListeners():void {
			_loader.addEventListener( Event.COMPLETE, onComplete );
			_loader.addEventListener( Event.OPEN, onLoad );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_loader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
		}

		private function clearListeners():void {
			_loader.removeEventListener( Event.COMPLETE, onComplete );
			_loader.removeEventListener( Event.OPEN, onLoad );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_loader.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
		}

		protected function onComplete( ev:Event ):void {
			progress = 1;
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

		public function FontSWFLoaderImpl( filePath:String = null ) {
			_filePath = filePath;
		}

		public function get filePath():String {
			return _filePath;
		}

		public function set filePath( filePath:String ):void {
			_filePath = filePath;
		}

		public function get payload():Object {
			return null;
		}
	}
}
