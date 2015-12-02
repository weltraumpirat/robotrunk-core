package org.robotrunk.common.i18n.event
{
	import flash.events.Event;


	public class LocalizedItemEvent extends Event
	{
		public static const CHANGE:String = "CHANGE";

		public var key:String;

		public var language:String;

		public var value:String;

		public function LocalizedItemEvent( type:String, key:String, language:String, value:String ) {
			super( type, false, false );
			this.key = key;
			this.language = language;
			this.value = value;
		}
	}
}
