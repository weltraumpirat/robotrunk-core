package org.robotrunk.common.loader.impl
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import org.robotrunk.common.loader.api.ILoader;


	public class ImageLoaderImpl extends BaseSpriteLoaderImpl implements ILoader
	{
		public function get content():DisplayObject {
			return loader != null ? DisplayObject( loader.content ) : null;
		}

		public function clearContent():void {
			if(loader == null) return;
			if(contains( loader )) removeChild( loader );
			loader = null;
		}

		override protected function onComplete( ev:Event ):void {
			loader.visible = true;
			super.onComplete( ev );
		}

		override protected function onLoad( ev:Event ):void {
			super.onLoad( ev );
		}

		public function ImageLoaderImpl( filePath:String = null ) {
			super( filePath );
		}
	}
}
