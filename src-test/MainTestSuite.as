package
{
	import org.robotrunk.common.logging.TraceLoggerImplTest;
	import org.robotrunk.common.progress.ProgressItemSpriteTest;
	import org.robotrunk.common.progress.ProgressItemTest;
	import org.robotrunk.common.utils.MovieClipHelperTest;


	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class MainTestSuite
	{
		public var movieClipHelperTest:MovieClipHelperTest;

		public var traceLoggerImplTest:TraceLoggerImplTest;

		public var progressItemTest:ProgressItemTest;

		public var progressSpriteTest:ProgressItemSpriteTest;
	}
}
