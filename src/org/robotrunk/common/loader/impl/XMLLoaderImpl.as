package org.robotrunk.common.loader.impl
{
	import org.robotrunk.common.event.ProgressItemEvent;
	import org.robotrunk.common.loader.api.ILoader;

	import flash.events.Event;


	public class XMLLoaderImpl extends BaseLoaderImpl implements ILoader
	{
		internal var _xml:XML;

		override public function get payload():Object {
			return _xml;
		}

		override public function destroy():void {
			super.destroy();
			_xml = null;
		}

		override protected function onComplete( event:Event ):void {
			progress = 1;
			parseXML();
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function parseXML():void {
			if(_urlLoader.data) _xml = new XML( _urlLoader.data );
		}

		public function XMLLoaderImpl( filePath:String = null ) {
			super( filePath );
		}
	}
}