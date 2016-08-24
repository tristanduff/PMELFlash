package {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.external.*;
	import flash.text.*;

	public class Agenda extends Sprite {
		private var _numMax:int;
		private var _storyPath:String;
		private var _picName:String;
		private var _htm:String;
		private var _wname:String;
		private var _wide:String;
		private var _tall:String;
		private var _options:String;
		private var _loader:Loader;
		private var _list:Dictionary;
		private var _ct:int = 0;
		private var _num:int;
		private var _status:String;
		private var _txt:TextField;

		public function Agenda() {
			addEventListener(Event.ADDED_TO_STAGE,init);
			_numMax = Story.numStory;
			trace(_numMax);
			_list = new Dictionary(true);
			makeMenu();
		}
		private function init($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function makeMenu():void {
			var item:Boxer;
			var cols:int = 4;
			for (var i:int = 0; i < _numMax; i++) {
				Story.xmlStory = i;
				_storyPath = Story.getAtt('story',i,'path');
				_picName = Story.getNode('tiny');
				if (_picName != null) {
					item = new Boxer();
					item.x = i % cols * 250 + 100;
					item.y = int(i / cols) * 150 + 100;
					//trace(_storyPath + _picName);
					_loader = new Loader();
					_loader.load(new URLRequest(_storyPath + _picName));
					item.addChild(_loader);
					_list[item] = [i];
					//_txt = item.txt;
					//updateStat([i, "incomplete"]);
					item.addEventListener(MouseEvent.CLICK, doClick, false, 0 ,true);
				}
				trace(Story.getNode('what'));
				addChild(item);
			}
		}
		private function doClick($e:Event):void {
			_num = int(_list[$e.currentTarget][0]);
			Story.xmlStory = _num;
			_storyPath = Story.getAtt('story',_num,'path');
			_htm = Story.getNode('full');
			_wname = Story.getNode('what');
			_wide = Story.getNode('wide');
			_tall = Story.getNode('tall');
			_options = Story.getAllAtts('options');
			_status = _list[_num];
			_txt = $e.currentTarget.txt;
			//_txt.text = _status;
			if (_htm != null) {
				if (ExternalInterface.available) {
					dispatchEvent(new ObjEvent(ObjEvent.ITEM_SELECTED,$e.currentTarget));
					_ct = 0;
					addEventListener(Event.ENTER_FRAME,makeModal,false,0,true);
				}
			}
		}
		private function makeModal($e:Event):void {
			if (++_ct > 10) {
				removeEventListener(Event.ENTER_FRAME,makeModal);
				if (ExternalInterface.available) {
					try {
						ExternalInterface.call("doModal",[_num,_status,_storyPath + _htm,_wname,_wide,_tall,_options]);
					} catch (error:SecurityError) {
						//output.appendText("A SecurityError occurred: " + error.message + "\n");
					} catch (error:Error) {
						//output.appendText("An Error occurred: " + error.message + "\n");
					}
				}
			}
		}
		public function updateStat($val:Array):void {
			_status = $val[1];
			_list[int($val[0])] = _status;
			if (_txt != null) {
				_txt.text = _status;
			}
		}
	}
}