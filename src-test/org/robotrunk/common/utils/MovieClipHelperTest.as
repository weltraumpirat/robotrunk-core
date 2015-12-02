/*
 * Copyright (c) 2012 Tobias Goeschel.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package org.robotrunk.common.utils
{
	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import org.robotrunk.common.logging.api.Logger;

	import flash.display.MovieClip;


	/**
	 * @author Tobias Goeschel
	 */
	public class MovieClipHelperTest
	{
		public var helper:MovieClipHelper;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var mc:MovieClip;

		[Mock]
		public var log:Logger;

		[Before]
		public function setUp():void {
			helper = new MovieClipHelper();
		}

		[Test]
		public function clipFrameChangesIfLabelExists():void {
			mock( mc ).method( "gotoAndStop" ).args( "first" );
			mock( mc ).getter( "name" ).never();
			mock( log ).method( "debug" ).never();
			helper.log = log;
			helper.gotoFrameLabel( mc, "first" );
		}

		[Test]
		public function clipIssuesLogMessageIfLabelDoesntExist():void {
			mock( mc ).method( "gotoAndStop" ).args( "second" ).throws( new Error() );
			mock( mc ).getter( "name" ).returns( "mock" ).once();
			mock( log ).method( "debug" ).args( "Frame:second  was not found on MovieClip:mock" );
			helper.log = log;
			helper.gotoFrameLabel( mc, "second" );
		}

		[Test(expects="org.robotrunk.common.error.NullPointerException")]
		public function throwsErrorWhenTryingToChangeFrameOnNull():void {
			helper.gotoFrameLabel( null, "whatever" );
		}

		[After]
		public function tearDown():void {
			helper = null;
			mc = null;
			rule = null;
			log = null;
		}
	}
}
