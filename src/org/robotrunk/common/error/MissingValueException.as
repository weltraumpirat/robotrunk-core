package org.robotrunk.common.error
{

	public class MissingValueException extends Error
	{
		public function MissingValueException( message:* = "", id:* = 0 ) {
			super( message, id );
		}
	}
}
