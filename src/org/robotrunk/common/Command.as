package org.robotrunk.common
{
	import org.robotrunk.common.Actor;


	public class Command extends Actor
	{
		public function execute () : void {
			if (log) log.debug( "execute", this );	
		}
	}
}
