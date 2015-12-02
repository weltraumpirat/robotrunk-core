package org.robotrunk.common.i18n.api
{

	public interface Localizer
	{
		function get localized():*;

		function get german():*;

		function get english():*;

		function get input():String;

		function set input( input:String ):void;

		function get language():String;

		function set language( language:String ):void;
	}
}
