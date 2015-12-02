package org.robotrunk.rpc.conf
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	import org.swiftsuspenders.Injector;

	import mx.logging.LogEventLevel;

	import flash.display.DisplayObjectContainer;

	public class BlazeDSRemotingExtension implements IExtension
	{
		[Inject]
		public var contextView : DisplayObjectContainer;

		[Inject]
		public var injector : Injector;

		[Inject]
		public var rpcHelper : RpcBootstrapHelper;


		public function extend ( context : IContext ) : void
		{
			context.injector.map ( RpcBootstrapHelper ).toSingleton ( RpcBootstrapHelper );
			context.injector.injectInto ( this );

			FlexLoggingBootstrapUtil.initializeLogging ( LogEventLevel.ERROR );

			rpcHelper.initalizeRPC ( contextView.loaderInfo );
			rpcHelper.registerRemoteClassAliases ( new RequiredRemoteFlexClassesBundle () );
		}
	}
}
