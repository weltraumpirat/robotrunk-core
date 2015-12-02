package org.robotrunk.common.i18n.conf
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	import org.robotrunk.common.i18n.api.LocalizerFactory;
	import org.robotrunk.common.i18n.impl.DateLocalizerFactoryImpl;
	import org.robotrunk.common.i18n.impl.TimeLocalizerFactory;
	import org.swiftsuspenders.Injector;


	public class LocalizerExtension implements IExtension
	{
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );
			injector.map( LocalizerFactory, "date" ).toSingleton( DateLocalizerFactoryImpl );
			injector.map( LocalizerFactory, "time" ).toSingleton( TimeLocalizerFactory );
		}
	}
}
