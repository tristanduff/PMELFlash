package {
	import flash.display.*;
	import flash.events.*;
	import com.greensock.*;

	public class SlideOut extends Sprite {
		private var _tray:Sprite;
		private var _grab:Sprite;
		//private var _bY:int;
		private var _bX:int;
		private var _out:Boolean;

		public function SlideOut() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_tray = getChildByName('tray') as Sprite;
			_grab = getChildByName('grab') as Sprite;
			_out = false;
			//_bY = y = y + _tray.height;
			_bX = x = 0 - _tray.width;
			_grab.addEventListener(MouseEvent.CLICK, doMove, false, 0, true);
		}
		private function doMove($e:Event):void {
			//TweenLite.to(this, 0.5, {y: ((_out) ? _bY : _bY - _tray.height)})
			TweenLite.to(this, 0.5, {x: ((_out) ? _bX : 0)})
			_out = !_out;
		}
	}
}