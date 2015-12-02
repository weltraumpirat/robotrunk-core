package org.robotrunk.common.i18n.impl
{
	import org.robotrunk.common.error.AbstractMethodInvocationException;
	import org.robotrunk.common.i18n.api.Localizer;
	import org.robotrunk.common.i18n.api.LocalizerFactory;


	public class AbstractLocalizerFactory implements LocalizerFactory
	{
		[Inject(name="language")]
		public var appLanguage:String;

		protected function userLanguageOrDefaultLanguage( language:String ):String {
			return language ? language : appLanguage ? appLanguage : "en";
		}

		public function create( input:String = null, language:String = null ):Localizer {
			throw new AbstractMethodInvocationException( "You must override the 'create()' method." );
			return null;
		}
	}
}
