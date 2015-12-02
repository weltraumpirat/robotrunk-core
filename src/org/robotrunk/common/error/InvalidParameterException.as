package org.robotrunk.common.error
{

	public class InvalidParameterException extends Error
	{
		public function InvalidParameterException( message:* = "", id:* = 0 ) {
			super( message, id );
		}
	}
}
