package org.robotrunk.common.loader.impl
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.robotrunk.common.event.ProgressItemEvent;
	import org.robotrunk.common.loader.api.ILoader;
	import org.robotrunk.common.progress.ProgressItemSpriteImpl;



	public class BaseSpriteLoaderImpl extends ProgressItemSpriteImpl implements ILoader
	{
		private var _filePath:String;

		public var loader:Loader;

		private var _payload:Object;

		override public function destroy():void {
			while(numChildren > 0) removeChildAt( 0 );
			super.destroy();
			_filePath = null;
			_payload = null;
			clearLoader();
		}

		private function clearLoader():void {
			loader = null;
		}

		private function finalize():void {
			clearListeners();
			destroy();
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
			var loaderContext:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
			init();
			loader.load( url, loaderContext );
			createListeners();
		}

		private function init():void {
			loader ||= new Loader();
			addChild( loader );
		}

		private function createListeners():void {
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( Event.OPEN, onLoad );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
		}

		protected function clearListeners():void {
			if(!loader) return;

			loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.removeEventListener( Event.OPEN, onLoad );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			loader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onHttpStatus );
		}

		private function onAddedToStage( ev:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			init();
		}

		protected function onComplete( ev:Event ):void {
			progress = 1;
			_payload = LoaderInfo( ev.target ).content;
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

		private function onRemovedFromStage( ev:Event ):void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			finalize();
		}

		private function onSecurityError( ev:SecurityErrorEvent ):void {
			error = "SECURITY ERROR: "+ev.text;
		}

		public function BaseSpriteLoaderImpl( filePath:String = null ):void {
			super();
			if(filePath) _filePath = filePath;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
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
