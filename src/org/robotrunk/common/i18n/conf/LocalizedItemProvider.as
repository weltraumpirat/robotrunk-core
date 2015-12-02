package org.robotrunk.common.i18n.conf
{
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.DependencyProvider;

	import flash.utils.Dictionary;


	public class LocalizedItemProvider implements DependencyProvider
	{
		private var _responseType:Class;

		public function apply( targetType:Class, activeInjector:Injector, injectParameters:Dictionary ):Object {
			var language:String = determineLanguage( injectParameters, activeInjector );
			return activeInjector.getInstance( _responseType, language+"|"+injectParameters.name );
		}

		private function determineLanguage( injectParameters:Dictionary, activeInjector:Injector ):String {
			return languageNotValid( injectParameters ) ? activeInjector.getInstance( String, "language" ) : injectParameters.language;
		}

		private function languageNotValid( injectParameters:Dictionary ):Boolean {
			return !injectParameters || !(injectParameters.language) || injectParameters.language == "default";
		}
		
		public function destroy() : void {
		}

		public function LocalizedItemProvider( responseType:Class ) {
			_responseType = responseType;
		}
	}
}
