package org.robotrunk.common.i18n.impl
{
	import org.robotrunk.common.i18n.api.Localizer;


	public class DateLocalizerFactoryImpl extends AbstractLocalizerFactory
	{
		override public function create( input:String = null, language:String = null ):Localizer {
			return new DateLocalizerImpl( input, userLanguageOrDefaultLanguage( language ) );
		}
	}
}
