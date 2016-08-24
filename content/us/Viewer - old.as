package {
	import flash.display.*;
	import flash.events.*;
	import fl.containers.*;
	import flash.net.*;

	public class Viewer extends Sprite {
		public static const CLOSED = "closed";
		private var _file:String;
		private var _view:ScrollPane;
		private var _cover:CoverScreen;

		public function Viewer($url:String) {
			_file = $url;
			addEventListener(Event.ADDED_TO_STAGE, doInit, false, 0, true);
		}
		private function doInit($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, doInit);
			_cover = new CoverScreen();
			_cover.addEventListener(MouseEvent.CLICK, doDone, false, 0, true);
			addChild(_cover);
			_view = new ScrollPane();
			//_view.scrollDrag = true;
			_view.load(new URLRequest(_file));
			_view.height = 300;
			_view.width = 600;
			_view.x = 50;
			_view.y = 50;
			addChild(_view);
		}
		private function doDone($e:Event):void {
			_cover.removeEventListener(MouseEvent.CLICK, doDone);
			dispatchEvent(new Event(Viewer.CLOSED));
		}
	}
}