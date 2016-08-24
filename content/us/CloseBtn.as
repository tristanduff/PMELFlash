package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class CloseBtn extends Sprite {
		public static const EDIT_MODE = "edit_mode";
		public static const HIDE_MODE = "hide_mode";
		private static const CLICK2_DELAY:int = 450;
		private var _delay:Timer;

		public function CloseBtn() {
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,cleanUp);
			visible = false;
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
			parent.addEventListener(CloseBtn.EDIT_MODE, doView, false, 0, true);
			_delay = new Timer(CLICK2_DELAY,1);
			_delay.addEventListener(TimerEvent.TIMER_COMPLETE,doHide,false,0,true);
			doubleClickEnabled = true;
			addEventListener(MouseEvent.MOUSE_DOWN,doDelay,false,0,true);
			addEventListener(MouseEvent.DOUBLE_CLICK,doRemove,false,0,true);
		}
		private function doDelay($e:Event):void {
			_delay.start();
		}
		private function doView($e:Event):void {
			visible = true;
		}
		private function doHide($e:Event):void {
			visible = false;
			parent.dispatchEvent(new Event(CloseBtn.HIDE_MODE));
		}
		private function doRemove($e:Event):void {
			_delay.stop();
			_delay.removeEventListener(TimerEvent.TIMER_COMPLETE,doHide)
			removeEventListener(MouseEvent.DOUBLE_CLICK, doRemove);
			parent.parent.removeChild(parent);
		}
		private function cleanUp($e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE,cleanUp);
			_delay.stop();
			_delay.removeEventListener(TimerEvent.TIMER_COMPLETE,doHide);
			_delay = null;
			parent.removeEventListener(CloseBtn.EDIT_MODE, doView);
			parent.removeEventListener(CloseBtn.HIDE_MODE, doHide);
		}
	}
}