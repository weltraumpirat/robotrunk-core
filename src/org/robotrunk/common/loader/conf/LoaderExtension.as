package org.robotrunk.common.loader.conf
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	import org.robotrunk.common.loader.api.ILoader;
	import org.robotrunk.common.loader.impl.CSSLoaderImpl;
	import org.robotrunk.common.loader.impl.FontSWFLoaderImpl;
	import org.robotrunk.common.loader.impl.ImageLoaderImpl;
	import org.robotrunk.common.loader.impl.PropertiesLoaderImpl;
	import org.robotrunk.common.loader.impl.SWFLoaderImpl;
	import org.robotrunk.common.loader.impl.SecureXMLLoaderImpl;
	import org.robotrunk.common.loader.impl.XMLLoaderImpl;
	import org.swiftsuspenders.Injector;


	public class LoaderExtension implements IExtension
	{
		[Inject]
		public var injector:Injector;

		public function extend( context:IContext ):void {
			context.injector.injectInto( this );
			injector.map( ILoader, "Properties" ).toType( PropertiesLoaderImpl );
			injector.map( ILoader, "CSS" ).toType( CSSLoaderImpl );
			injector.map( ILoader, "XML" ).toType( XMLLoaderImpl );
			injector.map( ILoader, "SecureXML" ).toType( SecureXMLLoaderImpl );
			injector.map( ILoader, "SWF" ).toType( SWFLoaderImpl );
			injector.map( ILoader, "FontSWF" ).toType( FontSWFLoaderImpl );
			injector.map( ILoader, "Image" ).toType( ImageLoaderImpl );
		}
	}
}
