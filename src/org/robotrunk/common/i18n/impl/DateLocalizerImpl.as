package org.robotrunk.common.i18n.impl
{

	public class DateLocalizerImpl extends LocalizerImpl
	{
		override public function get german():* {
			return _tokens ? _tokens[0]+"."+_tokens[1]+"."+_tokens[2] : null;
		}

		override public function get english():* {
			return _tokens ? _tokens[1]+"/"+_tokens[0]+"/"+_tokens[2] : null;
		}

		public function DateLocalizerImpl( input:String = null, language:String = null ) {
			super( input, language );
		}
	}
}
