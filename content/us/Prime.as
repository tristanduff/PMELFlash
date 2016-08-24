package {
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.ui.*;

	public class Prime extends Sprite {
		private var _stat:String;

		public function Prime():void {
			addEventListener(Event.ADDED_TO_STAGE, doInit, false, 0, true);
		}
		private function doInit($e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, doInit);
			stage.quality = StageQuality.HIGH;
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
			defaultItems.zoom = true;
			this.contextMenu = myContextMenu;
			addCallbacks();
		}
		private function addCallbacks():void {
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("sendToFlash",fromJS);
				ExternalInterface.call("doReady");
			}
		}
		private function fromJS($val:String):void {
			var tmp:Array = $val.split(",");
			if (ExternalInterface.available) {
				ExternalInterface.call("doStatus",tmp[1]);
			}
		}
		private function setStat($e:Event):void {
			if (ExternalInterface.available) {
				ExternalInterface.call("doStatus","complete");
			}
		}
	}
}