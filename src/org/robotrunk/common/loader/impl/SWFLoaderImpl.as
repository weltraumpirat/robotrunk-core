package org.robotrunk.common.loader.impl
{
	import org.robotrunk.common.loader.api.SWFLoader;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;


	public class SWFLoaderImpl extends BaseSpriteLoaderImpl implements SWFLoader
	{
		internal var _autoplay:Boolean = false;

		override public function destroy():void {
			var content:MovieClip = contentMovieOrNull;
			if(content) content.stop();
			autoPlay = false;
			super.destroy();
		}

		public function playContent():void {
			if(content) {
				showContent();
				startPlayingContent();
			}
		}

		public function unload():void {
			if(loader != null && loader.content != null) {
				loader.content.removeEventListener( Event.ENTER_FRAME, onContentEnterFrame );
				loader.unload();
			}
			loader = null;
		}

		private function showContent():void {
			loader.visible = true;
			if(loader.parent)
				bringLoaderToFront();
		}

		private function bringLoaderToFront():void {
			loader.parent.setChildIndex( loader, loader.parent.numChildren-1 );
		}

		private function startPlayingContent():void {
			var content:MovieClip = loader.content as MovieClip;
			if( content )
				startMovieClip( content );
			else
				startApplication();
		}

		private function startMovieClip( content:MovieClip ):void {
			content.play();
			content.addEventListener( Event.ENTER_FRAME, onContentEnterFrame );
		}

		private function startApplication():void {
			try {
				loader.content["init"]();
			} catch (e:Error) {
			}
		}

		override protected function onComplete( ev:Event ):void {
			super.onComplete( ev );
			if( autoPlay ) playContent();
		}

		private function onContentEnterFrame( evt:Event ):void {
			if( isMovieFinished() ) {
				var content:MovieClip = contentMovieOrNull;
				if( content ) content.removeEventListener( Event.ENTER_FRAME, onContentEnterFrame );
				dispatchEvent( new Event( Event.CLOSE ) );
			}
		}

		private function isMovieFinished():Boolean {
			var content:MovieClip = contentMovieOrNull;
			return !content || content.currentFrame == content.totalFrames;
		}

		public function SWFLoaderImpl( filePath:String = null, autoPlay:Boolean = false ) {
			super( filePath );
			_autoplay = autoPlay;
		}

		public function get autoPlay():Boolean {
			return _autoplay;
		}

		public function set autoPlay( autoPlay:Boolean ):void {
			_autoplay = autoPlay;
		}

		public function get content():DisplayObject {
			return loader && loader.content ? loader.content as DisplayObject : null;
		}

		public function get contentMovieOrNull():MovieClip {
			return content ? content as MovieClip : null;
		}
	}
}
