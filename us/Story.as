package {
	// gets the data from the loaded xml file
	public class Story {
		private static var _xmlStory:XML;
		private static var _xmlData:XML;

		public function Story() {
			//
		}
		public static function getNode($node:String):String {
			return _xmlStory[$node];
		}
		public static function getAllAtts($node:String):String {
			var tmp:String = "";
			var attList:XMLList = _xmlStory[$node]. @ *;
			for (var i:int = 0; i < attList.length(); i++) {
				tmp += (attList[i].name() + ":" + attList[i] + "; ");
			}
			return tmp;
		}
		public static function getAtt($node:String, $val:int, $att:String):String {
			var attNamesList:XMLList = _xmlData[$node][$val]. @ *;
			for (var i:int = 0; i < attNamesList.length(); i++) {
				if (attNamesList[i].name() == $att) {
					return _xmlData[$node][$val].@ [$att];
				}
			}
			return "";
		}
		public static function get numStory():int {
			return _xmlData.child('story').length();
		}
		public static function set xmlStory($val:int):void {
			_xmlStory = _xmlData.child('story')[$val];
		}
		public static function set xmlData($xml:XML):void {
			_xmlData = $xml;
		}
	}
}