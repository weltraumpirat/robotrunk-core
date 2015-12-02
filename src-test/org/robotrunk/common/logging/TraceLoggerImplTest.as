package org.robotrunk.common.logging
{
	import org.flexunit.asserts.assertEquals;
	import org.robotrunk.common.logging.impl.LogLevel;
	import org.robotrunk.common.logging.impl.TraceLoggerImpl;


	public class TraceLoggerImplTest
	{
		private var logger:TraceLoggerImpl;

		[Before]
		public function setUp():void {
			logger = new TraceLoggerImpl();
		}

		[Test]
		public function canSetLogLevel():void {
			logger.loglevel = LogLevel.DEBUG;
			assertEquals( LogLevel.DEBUG, logger.loglevel );

			logger.loglevel = LogLevel.INFO;
			assertEquals( LogLevel.INFO, logger.loglevel );
		}
		
		[Test]
		public function debugOutputsAllMessages () : void 
		{
			logger.loglevel = LogLevel.DEBUG;
			passMessages(LogLevel.DEBUG, logger.debug);
			passMessages(LogLevel.INFO, logger.info);
			passMessages(LogLevel.WARN, logger.warn);
			passMessages(LogLevel.ERROR, logger.error);
		}

		private function passMessages( level:String, fn:Function ):void {
			assertEquals( "["+level.toUpperCase()+"]  debug", fn( "debug" ) );
			assertEquals( "["+level.toUpperCase()+"]  [TraceLoggerImplTest]  --  debug", fn( "debug", this ) );
		}
		
		private function failMessages( fn:Function ):void {
			assertEquals( "", fn( "debug" ) );
			assertEquals( "", fn( "debug", this ) );
		}
		
		[Test]
		public function infoSuppressesDebugMessages () : void 
		{
			logger.loglevel = LogLevel.INFO;
			failMessages(logger.debug);
			passMessages(LogLevel.INFO, logger.info);
			passMessages(LogLevel.WARN, logger.warn);
			passMessages(LogLevel.ERROR, logger.error);
		}
		
		[Test]
		public function warnSuppressesDebugAndInfoMessages () : void 
		{
			logger.loglevel = LogLevel.WARN;
			failMessages(logger.debug);
			failMessages( logger.info);
			passMessages(LogLevel.WARN, logger.warn);
			passMessages(LogLevel.ERROR, logger.error);
		}
		
		[Test]
		public function errorSuppressesDebugInfoAndWarnMessages () : void 
		{
			logger.loglevel = LogLevel.ERROR;
			failMessages(logger.debug);
			failMessages(logger.info);
			failMessages(logger.warn);
			passMessages(LogLevel.ERROR, logger.error);
		}

		[After]
		public function tearDown():void {
			logger.loglevel = LogLevel.DEBUG;
			logger = null;
		}
	}
}
