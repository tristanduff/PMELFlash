package {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.ui.*;
	import flash.utils.*;
	import flash.external.*;
	import flash.filters.*;

	public class Main extends Sprite {
		private var _getXML:GetXML;
		private var _agenda:Agenda;
		private var _glowFilter:BitmapFilter;
		private var _cover:Sprite;

		public function Main() {
			//stage.align = StageAlign.TOP_LEFT;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			var myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;
			addEventListener(Event.ENTER_FRAME,init);
			addCallbacks();
		}
		private function init($e:Event):void {
			removeEventListener(Event.ENTER_FRAME,init);
			_getXML = new GetXML("main.xml");
			_getXML.addEventListener(ObjEvent.XML_LOADED,doStart);
		}
		private function doStart($e:ObjEvent):void {
			_getXML.removeEventListener(ObjEvent.XML_LOADED,doStart);
			Story.xmlData = $e.obj as XML;
			_agenda = new Agenda();
			_agenda.addEventListener(ObjEvent.ITEM_SELECTED, makeFilters, false, 0 , true);
			addChild(_agenda);
			_cover = new Sprite();
			_cover.graphics.beginFill(0x333333, 0.3);
			_cover.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_cover.graphics.endFill();
			addEventListener(Event.ACTIVATE,onActivate);
			addEventListener(Event.DEACTIVATE,onDeactivate);
		}
		private function getBitmapFilter():BitmapFilter {
			var blurX:Number = 5;
			var blurY:Number = 5;
			return new BlurFilter(blurX, blurY, BitmapFilterQuality.HIGH);
		}
		private function makeFilters($e:ObjEvent=null):void {
			var filter:BitmapFilter = getBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			filters = myFilters;
			addChildAt(_cover, numChildren);
			_cover.alpha = 1;
		}
		private function clearFilters($e:Event=null):void {
			filters = [];
			_cover.alpha = 0;
			addChildAt(_cover, 0);
		}
		private function fromJS($val:Array):void {
			clearFilters();
			_agenda.updateStat($val);
		}
		private function addCallbacks():void {
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("sendToFlash",fromJS);
				ExternalInterface.call("doReady");
			}
		}
		private function onActivate(e:Event):void {
			clearFilters();
		}
		private function onDeactivate(e:Event):void {
			makeFilters();
		}
	}
}