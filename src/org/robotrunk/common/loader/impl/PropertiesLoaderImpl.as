package org.robotrunk.common.loader.impl
{
	import org.robotrunk.common.event.ProgressItemEvent;

	import flash.events.Event;


	[Event(name="complete", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="error", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="load", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="progress", type="org.robotrunk.common.event.ProgressItemEvent")]
	public class PropertiesLoaderImpl extends BaseLoaderImpl
	{
		private var _properties:Object;

		override public function get payload():Object {
			return _properties;
		}

		override public function destroy():void {
			super.destroy();
			_properties = null;
		}

		override protected function onComplete( ev:Event ):void {
			progress = 1;
			try {
				readProperties();
			} catch (e:Error) {
			}
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function readProperties():void {
			_properties = {};
			
			var propertyLines:Array = String( _urlLoader.data ).split( /[\r|\n]/g );
			for each(var line : String in propertyLines)
				if(line.length > 0 && line.charAt(0) != "#")
					addKeyValuePair( line );
		}

		private function addKeyValuePair( items:String ):void {
			var pair:Array = items.split( "=" );
			_properties[pair[0]] = pair[1];
		}

		public function PropertiesLoaderImpl( filePath:String = null ) {
			super( filePath );
		}
	}
}
