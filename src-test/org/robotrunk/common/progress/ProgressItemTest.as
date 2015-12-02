package org.robotrunk.common.progress
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.robotrunk.common.event.ProgressItemEvent;


	public class ProgressItemTest
	{
		protected var item:ProgressItem;

		private var error:String;

		private var error2:String;

		private var status:String;

		private var status2:String;

		[Before]
		public function setUp():void {
			item = new ProgressItemImpl();
			error = "Error was encountered.";
			error2 = "Another error.";
			status = "New status was reached.";
			status2 = "Another status.";
		}

		[Test(async)]
		public function propagatesIndividualErrorEvents():void {
			var async1:Function = throwErrorAndReceiveEvent( error );
			item.removeEventListener( ProgressItemEvent.ERROR, async1 );
			var async2:Function = throwErrorAndReceiveEvent( error2 );
			item.removeEventListener( ProgressItemEvent.ERROR, async2 );
		}

		private function throwErrorAndReceiveEvent( err:String ):Function {
			var async:Function = Async.asyncHandler( this, onError, 100, err );
			item.addEventListener( ProgressItemEvent.ERROR, async );
			item.error = err;
			return async;
		}

		private function onError( ev:ProgressItemEvent, data:Object = null ):void {
			assertEquals( ProgressItemEvent.ERROR, ev.type );
			assertEquals( data, ev.message );
		}

		[Test()]
		public function keepsAListOfAllErrors():void {
			item.error = error;
			item.error = error2;

			assertEquals( error+"\n"+error2, item.error );
		}

		[Test(async)]
		public function propagatesIndividualStatusMessages():void {
			var async1:Function = setStatusAndReceiveEvent( status );
			item.removeEventListener( ProgressItemEvent.STATUS, async1 );
			var async2:Function = setStatusAndReceiveEvent( status2 );
			item.removeEventListener( ProgressItemEvent.STATUS, async2 );
		}

		private function setStatusAndReceiveEvent( stat:String ):Function {
			var async:Function = Async.asyncHandler( this, onStatus, 100, stat );
			item.addEventListener( ProgressItemEvent.STATUS, async );
			item.status = stat;
			return async;
		}

		private function onStatus( ev:ProgressItemEvent, data:Object = null ):void {
			assertEquals( ProgressItemEvent.STATUS, ev.type );
			assertEquals( data, ev.message );
		}

		[Test()]
		public function keepsAListOfAllStatusMessages():void {
			item.status = status;
			item.status = status2;

			assertEquals( status+"\n"+status2, item.status );
		}

		[Test(async)]
		public function propagatesProgress():void {
			var async1:Function = setProgressAndReceiveEvent( 0.1 );
			item.removeEventListener( ProgressItemEvent.PROGRESS, async1 );
			var async2:Function = setProgressAndReceiveEvent( 0.561 );
			item.removeEventListener( ProgressItemEvent.PROGRESS, async2 );
		}

		private function setProgressAndReceiveEvent( prog:Number ):Function {
			var async:Function = Async.asyncHandler( this, onProgress, 100, prog < 0 ? 0 : prog > 1 ? 1 : prog );
			item.addEventListener( ProgressItemEvent.PROGRESS, async );
			item.progress = prog;
			return async;
		}

		private function onProgress( ev:ProgressItemEvent, data:Object = null ):void {
			assertEquals( ProgressItemEvent.PROGRESS, ev.type );
			assertEquals( data, ev.data );
		}

		[Test(async)]
		public function doesNotAllowProgressBelowZero():void {
			item.progress = -1;
			assertEquals( 0, item.progress );
			item.progress = -10;
			assertEquals( 0, item.progress );
			item.progress = -123458925679;
			assertEquals( 0, item.progress );
		}

		[Test(async)]
		public function doesNotAllowProgressGreaterThanOne():void {
			item.progress = 2;
			assertEquals( 1, item.progress );
			item.progress = 10;
			assertEquals( 1, item.progress );
			item.progress = 123458925679;
			assertEquals( 1, item.progress );
		}

		[After]
		public function tearDown():void {
			item = null;
			error = null;
			error2 = null;
			status = null;
			status2 = null;
		}
	}
}
