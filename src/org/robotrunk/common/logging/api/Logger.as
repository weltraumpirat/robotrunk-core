package org.robotrunk.common.logging.api
{

	public interface Logger
	{
		function get loglevel():String;

		function set loglevel( level:String ):void;

		function debug( message:String, loggingObject:Object = null ):String;

		function info( message:String, loggingObject:Object = null ):String;

		function warn( message:String, loggingObject:Object = null ):String;

		function error( message:String, loggingObject:Object = null ):String;
	}
}
