package org.robotrunk.common.event
{
	import flash.events.Event;

	public class ProgressItemEvent extends Event
	{
		public static const COMPLETE : String = "COMPLETE";
		public static const ERROR : String = "ERROR";
		public static const START : String = "START";
		public static const PROGRESS : String = "PROGRESS";

		public static const STATUS : String = "STATUS";

		public var message : String;
		public var data : *;

		public function ProgressItemEvent ( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super ( type, bubbles, cancelable );
		}
	}
}
