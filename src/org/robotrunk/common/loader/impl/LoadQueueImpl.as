package org.robotrunk.common.loader.impl
{
	import flash.events.Event;
	import org.robotrunk.common.event.ProgressItemEvent;
	import org.robotrunk.common.loader.api.ILoader;
	import org.robotrunk.common.loader.api.Queue;
	import org.robotrunk.common.progress.ProgressItem;
	import org.robotrunk.common.progress.ProgressItemImpl;



	public class LoadQueueImpl extends ProgressItemImpl implements Queue
	{
		private var _current:int = 0;

		private var _highestWeight:Number = 0;

		private var _queue:Vector.<ProgressItem> = new Vector.<ProgressItem>();

		private var _totalWeight:Number = 0;

		private var _sumOfAllWeights:Number;

		private var _weights:Vector.<Number> = new Vector.<Number>();

		override public function destroy():void {
			clearListeners();
			_current = 0;
			_queue = null;
			_weights = null;
			super.destroy();
		}

		public function next():void {
			if(++current < _queue.length) load( _queue[current] as ILoader );
			else dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function load( loader:ILoader ):void {
			loader.load( loader.filePath );
		}

		private function normalizeWeights():void {
			calculateHighestWeight();
			calculateTotalWeight();
		}

		private function calculateTotalWeight():void {
			_sumOfAllWeights = 0;
			for each(var weight:Number in _weights)
				_sumOfAllWeights += weight == 0 ? _highestWeight : weight;

			_totalWeight = _sumOfAllWeights;
		}

		private function calculateHighestWeight():void {
			_sumOfAllWeights = 0;

			var tmpWeights:Vector.<Number> = new Vector.<Number>();
			for each(var weight:Number in _weights) {
				tmpWeights.push( weight );
				_sumOfAllWeights += weight;
			}

			_highestWeight = highestWeightOr1( tmpWeights );
		}

		private function highestWeightOr1( tmpWeights:Vector.<Number> ):Number {
			return _sumOfAllWeights == 0 ? 1 : tmpWeights.sort( Array.NUMERIC )[tmpWeights.length-1];
		}

		public function add( item:ProgressItem, weight:Number = 0 ):void {
			createListeners( item );
			_queue.push( item );
			_weights.push( weight );
		}

		public function contains( item:ProgressItem ):Boolean {
			return _queue.indexOf( item ) > 1;
		}

		public function remove( item:ProgressItem ):void {
			if(contains( item )) {
				removeListeners( item );
				_queue.splice( _queue.indexOf( item ), 1 );
			}
		}

		public function start():void {
			normalizeWeights();
			current = -1;
			next();
		}

		private function clearListeners():void {
			for each(var item:ProgressItem in _queue)
				removeListeners( item );
		}

		private function createListeners( item:ProgressItem ):void {
			item.addEventListener( ProgressItemEvent.COMPLETE, onItemComplete );
			item.addEventListener( ProgressItemEvent.ERROR, onItemError );
			item.addEventListener( ProgressItemEvent.START, onItemStart );
			item.addEventListener( ProgressItemEvent.STATUS, onItemStatus );
			item.addEventListener( ProgressItemEvent.PROGRESS, onItemProgress );
		}

		private function removeListeners( item:ProgressItem ):void {
			item.removeEventListener( ProgressItemEvent.COMPLETE, onItemComplete );
			item.removeEventListener( ProgressItemEvent.ERROR, onItemError );
			item.removeEventListener( ProgressItemEvent.START, onItemStart );
			item.removeEventListener( ProgressItemEvent.STATUS, onItemStatus );
			item.removeEventListener( ProgressItemEvent.PROGRESS, onItemProgress );
		}

		private function onItemComplete( ev:Event ):void {
			checkForCompletion();
		}

		private function checkForCompletion():void {
			calculateProgress();
			if(progress < 1)
				next();
			else
				dispatchEvent( new ProgressItemEvent( ProgressItemEvent.COMPLETE ) );
		}

		private function calculateProgress():void {
			var all:Number = 0;

			var i:int = -1;
			while( ++i < _queue.length )
				all += itemProgressWeight( i );
			
			progress = all/_totalWeight;
		}

		private function itemProgressWeight( i:int ):Number {
			var item:ProgressItem = _queue[i];
			var progressWeight:Number = item.progress * _weights[i];
			return item.error && !failOnError ? _highestWeight : progressWeight;
		}

		private function onItemError( ev:Event ):void {
			error = "Loading failed on item "+current+": "+_queue[current].error;
			if(!failOnError)
				checkForCompletion();
		}

		private function onItemProgress( ev:Event ):void {
			calculateProgress();
		}

		private function onItemStart( ev:Event ):void {
			status = "Loading item:"+current;
			dispatchEvent( new ProgressItemEvent( ProgressItemEvent.START ) );
		}

		private function onItemStatus( ev:Event ):void {
			status = _queue[current].status;
		}

		public function LoadQueueImpl() {
			_queue = new Vector.<ProgressItem>();
			_weights = new Vector.<Number>();
		}

		public function pause():void {
		}

		public function resume():void {
		}

		public function stop():void {
		}

		public function get current():int {
			return _current;
		}

		public function set current( current:int ):void {
			_current = current;
		}

		public function get length():int {
			return _queue.length;
		}
	}
}
