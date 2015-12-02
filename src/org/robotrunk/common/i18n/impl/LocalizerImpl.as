package org.robotrunk.common.i18n.impl
{
	import org.robotrunk.common.error.MissingValueException;
	import org.robotrunk.common.i18n.api.Localizer;


	public class LocalizerImpl  implements Localizer
	{
		protected var _language:String;

		protected var _tokens:Array;

		protected var _input:String;

		public function LocalizerImpl( input:String = null, language:String = null ) {
			this.language = language;
			this.input = input;
		}

		public function get localized():* {
			if( isValid )
				return _language == "de" ? german : _language == "en" ? english : _input;
			else
				return null;
		}

		private function get isValid():Boolean {
			if(!language )
				throw new MissingValueException( "You must provide a language." );
			if(!input)
				throw new MissingValueException( "You must provide an input value." );
			return true;
		}

		public function get german():* {
			return _input;
		}

		public function get english():* {
			return _input;
		}

		public function get language():String {
			return _language;
		}

		public function set language( language:String ):void {
			_language = language;
		}

		public function get input():String {
			return _input;
		}

		public function set input( input:String ):void {
			_input = input;
			_tokens = input ? input.split( "-" ) : null;
		}
	}
}
