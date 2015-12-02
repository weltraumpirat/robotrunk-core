package org.robotrunk.common.progress
{
	import flash.events.IEventDispatcher;

	[Event (name="COMPLETE", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event (name="ERROR", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event (name="START", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event (name="PROGRESS", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event (name="STATUS", type="org.robotrunk.common.event.ProgressItemEvent")]
	public interface ProgressItem extends IEventDispatcher
	{
		function get error () : String;

		function set error ( str : String ) : void;

		function get failOnError () : Boolean;

		function set failOnError ( bool : Boolean ) : void;

		function get status () : String;

		function set status ( str : String ) : void;

		function get progress () : Number;
		
		function set progress ( n : Number ) : void;

		function get progressPercent () : Number;
		
		function destroy () : void;
	}
}
