package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import fl.controls.*;
	import flash.utils.*;
	import fl.managers.*;

	public class ActionMenu extends Sprite {
		private var _msg:TextInput;
		private var _menu:ComboBox;
		private var _powercordEquipStat:Boolean;
		private var _powercordPowerSourceStat:Boolean;
		private var _leadRed:String;
		private var _leadBlack:String;
		private var _isBad:Boolean;
		private var _isBadCheck:Boolean;
		private var _fuseStat:Boolean;
		private var _fuseCoverStat:Boolean;
		private var _fuseEquipStat:Boolean;
		private var _equipPowerSwitchStat:Boolean;
		private var _equipCaseStat:Boolean;
		private var _techOrderStat:Boolean;
		private var _viPowerCord:Boolean;
		private var _viPowerCordConn:Boolean;
		private var _viPowerCordPlug:Boolean;
		private var _viewer:Viewer;

		public function ActionMenu() {
			var tff:TextFormat = new TextFormat("Arial",16,0x000000);
			StyleManager.setStyle("textFormat", tff);
			StyleManager.setComponentStyle(TextField,"embedFonts",true);
			StyleManager.setComponentStyle(TextField,"antiAliasType",AntiAliasType.ADVANCED);
			StyleManager.setComponentStyle(TextField,"gridFitType",flash.text.GridFitType.PIXEL);
			//;
			_msg = new TextInput();
			_msg.editable = false;
			_msg.width = 700;
			_msg.x = 10;
			_msg.y = 10;
			addChild(_msg);
			_menu = new ComboBox();
			_menu.width = 520;
			_menu.rowCount = 16;
			addChild(_menu);
			_menu.x = 100;
			_menu.y = 100;
			_menu.addEventListener(Event.CHANGE,doSelect,false,0,true);
			makeInit();
			makeMenu();
		}
		private function makeInit():void {
			_leadRed = null;
			_leadBlack = null;
			_msg.text = "";
			_isBad = (Math.random() > 0.7 ) ? true : false;
			trace(_isBad);
			_isBadCheck = false;
			_powercordEquipStat = true;
			_powercordPowerSourceStat = false;
			_fuseStat = true;
			_fuseCoverStat = true;
			_fuseEquipStat = true;
			_equipPowerSwitchStat = false;
			_equipCaseStat = true;
			_techOrderStat = false;
			_viPowerCord = false;
			_viPowerCordConn = false;
			_viPowerCordPlug = false;
		}
		private function makeMenu($e:Event = null):void {
			_menu.removeAll();
			if (! _fuseCoverStat) {
				_menu.addItem( { label: "Attach meter lead to outer terminal of fuse holder.", value:"fuse holder"} );
			}
			if ((_leadRed == null || _leadBlack == null) && (_leadRed != "test set" && _leadBlack != "test set")) {
				_menu.addItem( { label: "Attach meter lead to outside test set.", value:"test set"} );
			}
			if (! _powercordPowerSourceStat && (_leadRed == null || _leadBlack == null)) {
				if (_leadRed != "ground blade" && _leadBlack != "ground blade") {
					_menu.addItem( { label: "Attach meter lead to power cord plug ground blade.", value:"ground blade"} );
				}
				if (_leadRed != "hi blade" && _leadBlack != "hi blade") {
					_menu.addItem( { label: "Attach meter lead to power cord plug hi blade.", value:"hi blade"} );
				}
				if (_leadRed != "lo blade" && _leadBlack != "lo blade") {
					_menu.addItem( { label: "Attach meter lead to power cord plug lo blade.", value:"lo blade"} );
				}
			}
			if (! _powercordEquipStat && (_leadRed == null || _leadBlack == null)) {
				if (_leadRed != "gnd terminal" && _leadBlack != "gnd terminal") {
					_menu.addItem( { label: "Attach meter lead to power cord receptacle gnd terminal.", value:"gnd terminal"} );
				}
				if (_leadRed != "hi terminal" && _leadBlack != "hi terminal") {
					_menu.addItem( { label: "Attach meter lead to power cord receptacle hi terminal.", value:"hi terminal"} );
				}
				if (_leadRed != "lo terminal" && _leadBlack != "lo terminal") {
					_menu.addItem( { label: "Attach meter lead to power cord receptacle lo terminal.", value:"lo terminal"} );
				}
			}
			if (! _powercordEquipStat) {
				_menu.addItem( { label: "Attach power cord to equipment.", value:1} );
			}
			if (! _powercordPowerSourceStat) {
				_menu.addItem( { label: "Attach power cord to power source.", value:2 } );
			}
			//_menu.addItem( { label: "Check fuse cap retains fuse.", value:0 } );
			if (_techOrderStat) {
				_menu.addItem( { label: "Close equipment Tech Order.", value:23 } );
			}
			if (_powercordEquipStat) {
				_menu.addItem( { label: "Detach power cord from equipment.", value:3} );
			}
			if (_powercordPowerSourceStat) {
				_menu.addItem( { label: "Detach power cord from power source.", value:4} );
			}
			if (! _fuseEquipStat) {
				_menu.addItem( { label: "Inspect fuse.", value:30 } );
			}
			if (! _fuseCoverStat) {
				_menu.addItem( { label: "Inspect fuse holder.", value:31 } );
			}
			if (! _fuseEquipStat && ! _fuseCoverStat) {
				_menu.addItem( { label: "Inspect fuse wiring.", value:32 } );
			}
			if (! _powercordEquipStat && ! _powercordPowerSourceStat) {
				_menu.addItem( { label: "Inspect power cord.", value:33 } );
			}
			if (! _powercordEquipStat) {
				_menu.addItem( { label: "Inspect power cord connection / receptacle / point of entry.", value:34 } );
			}
			if (! _powercordPowerSourceStat) {
				_menu.addItem( { label: "Inspect power cord plug.", value:35 } );
			}
			if (! _techOrderStat) {
				_menu.addItem( { label: "Open equipment Tech Order.", value:22 } );
			}
			if (! _fuseEquipStat) {
				_menu.addItem( { label: "Reinsert fuse into equipment.", value:24 } );
			}
			if (_leadBlack != null) {
				_menu.addItem( { label: "Remove black meter lead.", value:12} );
			}
			if (_equipCaseStat) {
				_menu.addItem( { label: "Remove equipment case.", value:20} );
			}
			if (_fuseCoverStat) {
				_menu.addItem( { label: "Remove fuse cover.", value:15} );
			}
			if (_fuseEquipStat && ! _fuseCoverStat) {
				_menu.addItem( { label: "Remove fuse from equipment.", value:25} );
			}
			if (_leadRed != null) {
				_menu.addItem( { label: "Remove red meter lead.", value:13} );
			}
			//if (_fuseStat && _fuseCoverStat) {
			//_menu.addItem( { label: "Replace (defective / improper) fuse.", value:0} );
			//}
			if (! _powercordPowerSourceStat && ! _powercordEquipStat) {
				_menu.addItem( { label: "Replace (defective / improper) power cord.", value:14} );
			}
			if (! _equipCaseStat) {
				_menu.addItem( { label: "Replace equipment case.", value:21} );
			}
			if (! _fuseCoverStat) {
				_menu.addItem( { label: "Replace fuse cover.", value:16} );
			}
			//_menu.addItem( { label: "Resolve wiring problems.", value:0} );
			if (_leadRed != null && _leadBlack != null) {
				_menu.addItem( { label: "Reverse meter leads.", value:19} );
			}
			_menu.addItem( { label: "Stop, process complete.", value:99} );
			if (_equipPowerSwitchStat) {
				_menu.addItem( { label: "Turn equipment power switch off.", value:17} );
			}
			if (! _equipPowerSwitchStat) {
				_menu.addItem( { label: "Turn equipment power switch on.", value:18} );
			}
			if (_leadRed != null && _leadBlack != null) {
				_menu.addItem( { label: "View meter reading.", value:"meter"} );
			}
			_menu.prompt = "Select Action...";
		}
		private function doSelect($e:Event):void {
			trace($e.target.selectedItem.value+" - "+$e.target.selectedItem.label);
			switch ($e.target.selectedItem.value) {
				case 0 :
					_msg.text = "ERROR";
					break;
				case 1 :
					_powercordEquipStat = true;
					_msg.text = "Power cord is now attached to the equipment.";
					break;
				case 2 :
					_powercordPowerSourceStat = true;
					_msg.text = "Power cord is now attached to the power source.";
					break;
				case 3 :
					_powercordEquipStat = false;
					_msg.text = "Power cord is now detached from the equipment.";
					break;
				case 4 :
					_powercordPowerSourceStat = false;
					_msg.text = "Power cord is now detached from the power source.";
					break;
				case "ground blade" :
				case "hi blade" :
				case "lo blade" :
				case "gnd terminal" :
				case "hi terminal" :
				case "lo terminal" :
				case "fuse holder" :
				case "test set" :
					if (_leadRed == null) {
						_leadRed = $e.target.selectedItem.value;
						_msg.text = "Red lead attached to the " + $e.target.selectedItem.value + ".";
					} else {
						_leadBlack = $e.target.selectedItem.value;
						_msg.text = "Black lead attached to the "+$e.target.selectedItem.value+".";;
					}
					break;
				case 12 :
					_leadBlack = null;
					_msg.text = "Black lead is no longer attached.";
					break;
				case 13 :
					_leadRed = null;
					_msg.text = "Red lead is no longer attached.";
					break;
				case 14 :
					if (_isBadCheck) {
						if (_isBad) {
							_msg.text = "Replaced power cord.";
							_isBad = (Math.random() > 0.7 ) ? true : false;
							trace(_isBad);
							_isBadCheck = false;
						} else {
							_msg.text = "Power cord is not bad.";
						}
					} else {
						_msg.text = "Check before replacing the cord.";
					}
					break;
				case "meter" :
					if (_leadRed == null || _leadBlack == null) {
						_msg.text = "Both leads are not in use.";
					} else {
						if ((_leadRed == "fuse holder" && _leadBlack == "test set")||(_leadRed == "test set" && _leadBlack == "fuse holder")) {
							_msg.text = "Good reading.";
						} else if ((_leadRed == "ground blade" && _leadBlack == "gnd terminal")||(_leadRed == "gnd terminal" && _leadBlack == "ground blade")) {
							_isBadCheck = true;
							if (_isBad) {
								_msg.text = "Bad reading - cord ground.";
							} else {
								_msg.text = "Good reading - cord ground.";
							}
						} else if ((_leadRed == "hi blade" && _leadBlack == "hi terminal")||(_leadRed == "hi terminal" && _leadBlack == "hi blade")) {
							_msg.text = "Good reading - cord hi.";
						} else if ((_leadRed == "lo blade" && _leadBlack == "lo terminal")||(_leadRed == "lo terminal" && _leadBlack == "lo blade")) {
							_msg.text = "Good reading - cord lo.";
						} else {
							_msg.text = "Bad reading.";
						}
					}
					break;
				case 15 :
					_fuseCoverStat = false;
					_msg.text = "Fuse cover removed.";
					break;
				case 16 :
					_fuseCoverStat = true;
					_msg.text = "Fuse cover replaced.";
					break;
				case 17 :
					_equipPowerSwitchStat = false;
					_msg.text = "Equipment power switch is OFF.";
					break;
				case 18 :
					_equipPowerSwitchStat = true;
					_msg.text = "Equipment power switch is ON.";
					break;
				case 19 :
					var tmp:String = _leadRed;
					_leadRed = _leadBlack;
					_leadBlack = tmp;
					_msg.text = "Meter leads swapped.";
					break;
				case 20 :
					_equipCaseStat = false;
					_msg.text = "Equipment case removed.";
					break;
				case 21 :
					_equipCaseStat = true;
					_msg.text = "Equipment case replaced.";
					break;
				case 22 :
					_techOrderStat = true;
					_msg.text = "Equipment tech order opened.";
					break;
				case 23 :
					_techOrderStat = false;
					_msg.text = "Equipment tech order closed.";
					break;
				case 24 :
					_fuseEquipStat = true;
					_msg.text = "Fuse in equipment.";
					break;
				case 25 :
					_fuseEquipStat = false;
					_msg.text = "Fuse removed from equipment.";
					break;
				case 30 :
					_msg.text = "Fuse visually inspected.";
					break;
				case 31 :
					_msg.text = "Fuse holder visually inspected.";
					break;
				case 32 :
					_msg.text = "Fuse wiring visually inspected.";
					break;
				case 33 :
					_viPowerCord = true;
					_msg.text = "Power cord visually inspected.";
					break;
				case 34 :
					_viPowerCordConn = true;
					_msg.text = "Power cord connection / receptacle / point of entry visually inspected.";
					break;
				case 35 :
					_viPowerCordPlug = true;
					_msg.text = "Power cord plug visually inspected.";
					_viewer = new Viewer("media/powercordplug.jpg");
					_viewer.addEventListener(Viewer.CLOSED, cleanView, false, 0, true);
					addChild(_viewer);
					break;
				case 99 :
					checkDone();
					return;
					break;
				default :
					break;
			}
			makeMenu();
		}
		private function cleanView($e:Event):void {
			_viewer.removeEventListener(Viewer.CLOSED, cleanView);
			removeChild(_viewer);
		}
		private function checkDone():void {
			var isDone:Boolean = false;
			if (_viPowerCord && _viPowerCordConn && _viPowerCordPlug) {
				isDone = true;
			}
			if (isDone) {
				_msg.text = "Passed";
			} else {
				_msg.text = "Failed";
			}
			removeChild(_menu);
		}
	}
}