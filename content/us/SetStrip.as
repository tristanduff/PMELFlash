package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class SetStrip extends Sprite {
		private static const DELAY_SPIN:int = 750;
		private static const CLICK2_DELAY:int = 150;
		private static const R_2_D = 180 / Math.PI;
		private var _timer:Timer;
		private var _bX:int;
		private var _bY:int;
		private var _begTime:int;
		private var _stage:Stage;

		public function SetStrip() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			_begTime = getTimer() - CLICK2_DELAY;
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_DOWN, doDown, false, 0, true);
			_stage = stage;
			y = 593;
			x = 0;
			doDown();
		}
		private function startTime():void {
			_timer = new Timer(DELAY_SPIN,1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, setSpin, false, 0, true);
			_timer.start();
		}
		private function setSpin($e:TimerEvent):void {
			stopDrag();
			_timer.stop();
			_timer = null;
		}
		private function doDown($e:Event=null):void {
			if (getTimer() - _begTime < CLICK2_DELAY) {
				doEdit();
			} else {
				//_stage.addEventListener(MouseEvent.MOUSE_MOVE, doMove, false, 0, true);
				_stage.addEventListener(MouseEvent.MOUSE_UP, doUp, false, 0, true);
				_stage.addChildAt(this, _stage.numChildren-1);
				startTime();
			}
		}
		private function doMove($e:Event):void {
			if (_timer) {
				_timer.reset();
				_timer.start();
				startDrag();
			}
		}
		private function doUp($e:Event):void {
			stopDrag();
			if (_timer) {
				_timer.stop();
				_timer = null;
			}
			_begTime = getTimer();
			//_stage.removeEventListener(MouseEvent.MOUSE_MOVE, doMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, doUp);
		}
		private function doEdit($e:Event=null):void {
			if (_timer) {
				_timer.stop();
				_timer = null;
			}
			doRemove();
		}
		public function doRemove():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, doDown);
			//_stage.removeEventListener(MouseEvent.MOUSE_MOVE, doMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, doUp);
			_stage.removeChild(this);
		}
	}
}