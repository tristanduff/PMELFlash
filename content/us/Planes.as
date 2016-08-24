package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Planes extends Sprite {
		private static const DELAY_SPIN:int = 750;
		private static const CLICK2_DELAY:int = 150;
		private static const R_2_D = 180 / Math.PI;
		private static const DX:int = 30;
		private static const DY:int = 20;
		private static const CX:int = 10;
		private static const CY:int = 10;
		private var _timer:Timer;
		private var _bX:int;
		private var _bY:int;
		private var _begTime:int;
		private var _stage:Stage;
		private var _altData:AltData;
		private var _cData:CData;
		private var _dClip:Sprite;

		public function Planes() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			_begTime = getTimer() - CLICK2_DELAY;
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_DOWN, doDown, false, 0, true);
			_dClip = getChildByName('dataClip') as Sprite;
			_altData = _dClip.getChildByName('altData') as AltData;
			_cData = getChildByName('cData') as CData;
			_stage = stage;
			_cData.gotoAndStop(1);
			doDown();
			makeLine();
		}
		private function makeLine($c:Number=0xFFFFFF):void {
			graphics.clear();
			graphics.lineStyle(1,$c);
			var x1:int = (_dClip.x + DX < _cData.x - CX) ? _dClip.x + DX : (_dClip.x - DX > _cData.x + CX) ? _dClip.x - DX : _dClip.x;
			var y1:int = (_dClip.y + DY < _cData.y - CY) ? _dClip.y + DY : (_dClip.y - DY > _cData.y + CY) ? _dClip.y - DY : _dClip.y;
			graphics.moveTo(x1, y1);
			var x2:int = (_dClip.x + DX < _cData.x - CX) ? _cData.x - CX : (_dClip.x - DX > _cData.x + CX) ? _cData.x + CX : _cData.x;
			var y2:int = (_dClip.y + DY < _cData.y - CY) ? _cData.y - CY : (_dClip.y - DY > _cData.y + CY) ? _cData.y + CY : _cData.y;
			graphics.lineTo(x2, y2);
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
			makeLine(0xFF0000);
		}
		private function doDown($e:Event=null):void {
			if (getTimer() - _begTime < CLICK2_DELAY) {
				doEdit();
			} else {
				_stage.addEventListener(MouseEvent.MOUSE_MOVE, doMove, false, 0, true);
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
			} else {
				_dClip.startDrag();
				makeLine(0xFF0000);
			}
		}
		private function doUp($e:Event):void {
			stopDrag();
			makeLine();
			if (_timer) {
				_timer.stop();
				_timer = null;
			}
			_begTime = getTimer();
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, doMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, doUp);
		}
		private function doEdit($e:Event=null):void {
			if (_timer) {
				_timer.stop();
				_timer = null;
			}
			_altData.changeMode();
			_cData.changeMode();
		}
		public function doRemove():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, doDown);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, doMove);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, doUp);
			_stage.removeChild(this);
		}
	}
}