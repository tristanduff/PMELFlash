package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Icons extends Sprite {
		private var _obj:*;
		private var _bX:int;
		private var _bY:int;
		private var _stage:Stage;

		public function Icons() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_DOWN, doDown, false, 0, true);
			_stage = stage;
		}
		private function doDown($e:Event):void {
			_stage.addEventListener(MouseEvent.MOUSE_UP, doUp, false, 0, true);
			var ClassReference:Class = getDefinitionByName(name) as Class;
			_obj = new ClassReference();
			_obj.x = _bX = _stage.mouseX;
			_obj.y = _bY = _stage.mouseY;
			_stage.addChild(_obj);
			_obj.startDrag();
		}
		private function doUp($e:Event):void {
			_stage.removeEventListener(MouseEvent.MOUSE_UP, doUp);
			stopDrag();
		}
	}
}