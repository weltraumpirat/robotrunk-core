package org.robotrunk.common.i18n.impl
{

	public class TimeLocalizerImpl  extends LocalizerImpl
	{
		override public function get german():* {
			return _tokens ? _tokens[0]+":"+_tokens[1]+":"+_tokens[2] : null;
		}

		override public function get english():* {
			var ret:String = null;

			if(_tokens != null) {
				var ampm:String = _tokens[0] > 12 ? "pm" : "am";
				_tokens[0] = _tokens[0]%12;
				ret = _tokens[0]+":"+_tokens[1]+":"+_tokens[2]+ampm;
			}

			return ret;
		}

		public function TimeLocalizerImpl( input:String = null, language:String = null ) {
			super( input, language );
		}
	}
}
