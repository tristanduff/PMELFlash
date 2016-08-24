package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class Pats extends Sprite {
		private var _obj:* = null;
		private var _bX:int;
		private var _bY:int;
		private var _stage:Stage;

		public function Pats() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_DOWN, doDown, false, 0, true);
			_stage = stage;
		}
		private function doDown($e:Event):void {
			if (_obj != null) {
				_stage.removeChild(_obj);
				_obj = null;
			} else {
				var ClassReference:Class = getDefinitionByName(name) as Class;
				_obj = new ClassReference();
				_stage.addChild(_obj);
				_obj.x = 0;
				_obj.y = 0;
			}
		}
	}
}