package {
	import flash.events.*;

	public class ObjEvent extends Event {

		public static const ITEM_SELECTED:String = "item_selected";
		public static const XML_LOADED:String = "xml_loaded";

		private var _obj:Object;

		public function ObjEvent(type:String, $obj:Object=null, bubbles:Boolean=false, cancelable:Boolean=true) {
			_obj = $obj;
			super(type, bubbles, cancelable);
		}
		public function get obj():Object {
			return _obj;
		}
		public override function clone():Event {
			return new ObjEvent(type, obj, bubbles, cancelable);
		}
		public override function toString():String {
			return formatToString("ObjEvent", "type", "obj");
		}
	}
}