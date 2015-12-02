package org.robotrunk.common.loader.api
{
	import org.robotrunk.common.progress.ProgressItem;

	import flash.net.URLRequest;
	import flash.net.URLVariables;

	[Event(name="complete", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="error", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="load", type="org.robotrunk.common.event.ProgressItemEvent")]
	[Event(name="progress", type="org.robotrunk.common.event.ProgressItemEvent")]
	public interface ILoader extends ProgressItem
	{
		function get filePath () : String;

		function set filePath ( str : String ) : void;

		function get payload () : Object;
		
		function load ( filePath : String = null, data : URLVariables = null ) : void;

		function loadURL ( url : URLRequest ) : void;
		
	}
}
