package {
	import flash.display.*;
	import flash.events.*;

	public class Meter extends Sprite {
		private var _ohms:Number = 0;

		public function Meter() {
			addEventListener(Event.REMOVED_FROM_STAGE, cleanUp, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, doInit, false, 0, true);
		}
		public function get ohms():Number {
			return _ohms;
		}
		public function set ohms($num:Number):void {
			_ohms = $num;
			upDate();
		}
		private function doInit($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, doInit);
		}
		private function upDate($e:Event=null):void {
			//
		}
		private function cleanUp($e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
		}
	}
}