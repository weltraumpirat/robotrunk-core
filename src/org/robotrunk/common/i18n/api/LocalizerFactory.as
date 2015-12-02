package org.robotrunk.common.i18n.api
{

	public interface LocalizerFactory
	{
		function create (input : String = null, language:String = null) : Localizer;
	}
}
