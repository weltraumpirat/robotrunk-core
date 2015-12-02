package org.robotrunk.common.loader.impl
{
	import org.robotrunk.common.event.ProgressItemEvent;

	import flash.events.Event;
	import flash.text.StyleSheet;


	public class CSSLoaderImpl extends BaseLoaderImpl
	{
		private var _styleSheet:StyleSheet;

		override public function get payload():Object {
			return _styleSheet;
		}

		override public function destroy():void {
			super.destroy();
			_styleSheet = null;
		}

		override protected function onComplete( ev:Event ):void {
			progress = 1;

			parseStyleSheet();
			
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function parseStyleSheet():void {
			_styleSheet = new StyleSheet();
			_styleSheet.parseCSS( _urlLoader.data );
		}

		public function CSSLoaderImpl( filePath:String = null ) {
			super( filePath );
		}
	}
}
