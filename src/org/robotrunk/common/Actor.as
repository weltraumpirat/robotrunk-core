package org.robotrunk.common
{
	import org.robotrunk.common.logging.api.Logger;

	import flash.events.Event;
	import flash.events.IEventDispatcher;


	public class Actor
	{
		[Inject]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var log:Logger;

		public function dispatch( evt:Event ):void {
			var msg:String = evt.toString();
			try {
				msg = evt["message"];
			} catch (e:Error) {
			}
			if(log) log.debug( evt.type+":"+msg, this );
			dispatcher.dispatchEvent( evt );
		}
	}
}
