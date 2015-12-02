package org.robotrunk.common.utils {
	import flash.display.MovieClip;

	import org.robotrunk.common.error.NullPointerException;
	import org.robotrunk.common.logging.api.Logger;

	public class MovieClipHelper {
		[Inject]
		public var log:Logger;

		public function gotoFrameLabel( movie:MovieClip, label:String ):void {
			if( movie ) {
				try {
					movie.gotoAndStop( label );
				} catch( e:Error ) {
					logLabelMissing( label, movie );
				}
			} else throw new NullPointerException( "The 'movie' argument must not be null." );
		}

		public function playFromFrameLabel( movie:MovieClip, label:String ):void {
			if( movie ) {
				try {
					movie.gotoAndPlay( label );
				} catch( e:Error ) {
					logLabelMissing( label, movie );
				}
			} else throw new NullPointerException( "The 'movie' argument must not be null." );
		}

		private function logLabelMissing( label:String, movie:MovieClip ):void {
			if( log )
				log.debug( "Frame:"+label+"  was not found on MovieClip:"+movie.name );
		}
	}
}
