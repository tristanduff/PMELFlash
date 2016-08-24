package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;

	public class Craft extends Sprite {
		protected static const CLICK2_DELAY:int = 450;
		private static const R_2_D:Number = 180 / Math.PI;
		public static const VIEW_MODE = "view_mode";
		public static const EDIT_MODE = "edit_mode";
		protected var _delay:Timer;
		protected var _stage:Stage;
		protected var _isEdit:Boolean;
		private var _bX:Number;
		private var _bY:Number;
		private var _obj:DisplayObject;

		public function Craft() {
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,cleanUp);
		}
		protected function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			_stage = stage;
			_delay = new Timer(CLICK2_DELAY,1);
			_delay.addEventListener(TimerEvent.TIMER_COMPLETE,doDown,false,0,true);
			_isEdit = false;
			doDown();
			mouseChildren = false;
			doubleClickEnabled = true;
			addEventListener(MouseEvent.MOUSE_DOWN,doDelay,false,0,true);
			addEventListener(MouseEvent.DOUBLE_CLICK,doEdit,false,0,true);
			addEventListener(CloseBtn.HIDE_MODE, doneEdit, false, 0, true);
		}
		protected function doDelay($e:Event):void {
			if (! _isEdit) {
				_stage.addChildAt(this,_stage.numChildren - 1);
				_delay.start();
				addEventListener(MouseEvent.MOUSE_MOVE,doMoved,false,0,true);
				_stage.addEventListener(MouseEvent.MOUSE_UP,doUp,false,0,true);
			}
		}
		protected function doMoved($e:Event):void {
			removeEventListener(MouseEvent.MOUSE_MOVE,doMoved);
			if (! _isEdit) {
				_delay.reset();
				startDrag();
				_isEdit = false;
			}
		}
		protected function doDown($e:Event=null):void {
			if ($e == null) {
				startDrag(true);
			} else {
				startDrag();
			}
			_isEdit = false;
			_stage.addEventListener(MouseEvent.MOUSE_UP,doUp,false,0,true);
		}
		protected function doUp($e:Event):void {
			stopDrag();
			_delay.reset();
			_stage.removeEventListener(MouseEvent.MOUSE_UP,doUp);
		}
		protected function doEdit($e:Event):void {
			_delay.reset();
			_isEdit = true;
			mouseChildren = _isEdit;
			modeEdit(_isEdit);
			dispatchEvent(new Event(CloseBtn.EDIT_MODE));
		}
		protected function doneEdit($e:Event):void {
			_delay.reset();
			_isEdit = false;
			mouseChildren = _isEdit;
			modeEdit(_isEdit);
		}
		protected function modeEdit($val:Boolean):void {
			_obj = getChildAt(0);
			if ($val) {
				_obj.addEventListener(MouseEvent.MOUSE_DOWN, doItDown, false, 0, true);
			}else{
				_obj.removeEventListener(MouseEvent.MOUSE_DOWN, doItDown)
			}
		}
		private function doItDown($e:Event=null):void {
			if (_isEdit) {
				var clickPoint:Point = new Point(0,0);
				_bX = _obj.localToGlobal(clickPoint).x;
				_bY = _obj.localToGlobal(clickPoint).y;
				_obj.addEventListener(Event.ENTER_FRAME, doItMove, false, 0, true);
				stage.addEventListener(MouseEvent.MOUSE_UP, doItUp, false, 0, true);
			}
		}
		private function doItMove($e:Event):void {
			_obj.rotation = (Math.atan2(stage.mouseY - _bY, stage.mouseX - _bX) * R_2_D);
		}
		private function doItUp($e:Event):void {
			_obj.removeEventListener(Event.ENTER_FRAME, doItMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, doItUp);
		}
		protected function cleanUp($e:Event):void {
			modeEdit(false);
			stopDrag();
			removeEventListener(Event.REMOVED_FROM_STAGE,cleanUp);
			_stage.removeEventListener(MouseEvent.MOUSE_UP,doUp);
			removeEventListener(MouseEvent.MOUSE_DOWN,doDelay);
			removeEventListener(MouseEvent.DOUBLE_CLICK,doEdit);
			_delay.removeEventListener(TimerEvent.TIMER_COMPLETE,doDown);
			_delay.stop();
			_delay = null;
		}
	}
}