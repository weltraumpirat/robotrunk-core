package org.robotrunk.common.loader.api
{
	import flash.display.DisplayObject;


	public interface SWFLoader extends ILoader
	{
		function playContent():void;

		function unload():void;

		function get autoPlay():Boolean ;

		function set autoPlay( bool:Boolean ):void;

		function get content():DisplayObject;
	}
}
