package {
	import flash.display.*;
	import flash.events.*;

	public class Viewer extends Sprite {
		private var _pic:String = null;

		public function Viewer() {
			addEventListener(Event.REMOVED_FROM_STAGE, cleanUp, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, doInit, false, 0, true);
		}
		public function get pic():String {
			return _pic;
		}
		public function set pic($val:String):void {
			_pic = $val;
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