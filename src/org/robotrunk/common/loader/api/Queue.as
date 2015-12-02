package org.robotrunk.common.loader.api
{
	import org.robotrunk.common.progress.ProgressItem;


	public interface Queue extends ProgressItem
	{
		function add( item:ProgressItem, weight:Number = 0 ):void;

		function contains( item:ProgressItem ):Boolean;

		function pause():void;

		function remove( item:ProgressItem ):void;

		function resume():void;

		function start():void;

		function stop():void;

		function get length():int;
	}
}
