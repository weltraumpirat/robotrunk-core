package org.robotrunk.common.loader.impl 
{
	import com.lia.crypto.AES;

	import org.robotrunk.common.event.ProgressItemEvent;

	import flash.events.Event;

	public class SecureXMLLoaderImpl extends XMLLoaderImpl 
	{
		override protected function onComplete (event : Event) : void 
		{
			event.stopImmediatePropagation( );
			progress = 1;
			var key:String = "0123456789abcdef0123456789abcdef";
			var data : String = AES.decrypt (_urlLoader.data, key, AES.BIT_KEY_256);
			
			_xml = new XML( data );
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}
	}
}
