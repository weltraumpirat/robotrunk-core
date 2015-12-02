package
{
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;
	import org.swiftsuspenders.Injector;

	import flash.display.Sprite;
	import flash.system.Security;


	public class MainTestRunner extends Sprite
	{
		public static var injector:Injector;

		private var core:FlexUnitCore;

		public function MainTestRunner() {
			trace( "Flash Player runs in sandbox:"+Security.sandboxType );

			core = new FlexUnitCore();

			VisualTestEnvironmentBuilder.getInstance( this );

			core.addListener( new TraceListener() );
			core.addListener( new CIListener() );

			core.run( MainTestSuite );
		}
	}
}
