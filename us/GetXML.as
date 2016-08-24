package {
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public class GetXML implements IEventDispatcher {
		private var _xmlLoader:URLLoader;
		private var _xmlData:XML;
		private var _file:String;
		private var _dispatcher:EventDispatcher;

		public function GetXML($file:String) {
			_file = $file;
			_dispatcher = new EventDispatcher();
			_xmlLoader = new URLLoader();
			_xmlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_xmlLoader.addEventListener(Event.COMPLETE,LoadXML);
			_xmlLoader.load(new URLRequest(_file));
		}
		private function LoadXML($e:Event):void {
			var bytes:* = $e.target.data;
			var bad = false;
			if (bytes is ByteArray) {
				try {
					ByteArray(bytes).uncompress();
				} catch (e:Error) {
					_xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
					try {
						_xmlLoader.load(new URLRequest(_file));
					} catch (e:Error) {
						bad = true;
						trace("Problem with XML file.");
					}
					return;
				}
			}
			try {
				_xmlData = XML(bytes);
			} catch (e:Error) {
				bad = true;
				trace("Problem with XML file format.");
			}
			if (bad) {
				trace("bad");
			} else {
				_xmlData = XML(bytes);
				_dispatcher.dispatchEvent(new ObjEvent(ObjEvent.XML_LOADED, _xmlData));
			}
		}
		public function addEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=false):void {
			_dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		public function dispatchEvent(event:Event):Boolean {
			return _dispatcher.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean=false):void {
			_dispatcher.removeEventListener(type,listener,useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return _dispatcher.willTrigger(type);
		}
	}
}