package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class TimeWidget extends Sprite {
		private static const DAYS = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
		//private static const MONTHS = ["January","February","March","April","May","June","July","August","September","October","November","December"];
		private static const MONTHS = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
		private var _newDate:Date;
		private var _day:int;
		private var _date:int;
		private var _month:int;
		private var _year:int;
		private var _hours:int;
		private var _minutes:int;
		private var _seconds:int;
		private var _dateTxt:TextField;
		private var _monthTxt:TextField;
		private var _timeTxt:TextField;

		public function TimeWidget() {
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeListeners);
			this.addEventListener(Event.ADDED_TO_STAGE, initFunction);
		}
		private function initFunction($e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, initFunction);
			this.addEventListener(Event.ENTER_FRAME, doUpdate);
			_dateTxt = getChildByName('dateTxt') as TextField;
			_monthTxt = getChildByName('monthTxt') as TextField;
			_timeTxt = getChildByName('timeTxt') as TextField;
		}
		private function doUpdate($e:Event=null):void {
			_newDate = new Date();
			_day = _newDate.getDay();
			_date = _newDate.getDate();
			_month = _newDate.getMonth();
			_year = _newDate.getFullYear();
			_hours = _newDate.getHours();
			_minutes = _newDate.getMinutes();
			_seconds = _newDate.getSeconds();
			_dateTxt.text = ((_date<=9)?"0":"")+String(_date);
			_monthTxt.text = MONTHS[_month] + " " + String(_year);
			_timeTxt.text = ((_hours<=9)?"0":"")+String(_hours)+":"+((_minutes<=9)?"0":"")+String(_minutes)+":"+((_seconds<=9)?"0":"")+String(_seconds);
		}
		private function removeListeners($e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, doUpdate);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeListeners);
		}
	}
}