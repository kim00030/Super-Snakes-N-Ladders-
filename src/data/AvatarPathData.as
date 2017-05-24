package data
{
	public class AvatarPathData
	{
		
		private static var _instance:AvatarPathData;
		private var _path:Array;
		
		// -------------------------------------------------------------------------------------------------------------------------		
		public function AvatarPathData()
		{
			init();
			
		}
		
		// -------------------------------------------------------------------------------------------------------------------------		
		public static function getInstance():AvatarPathData {
			
			if (!_instance)
				_instance = new AvatarPathData();
			
			return _instance;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public function get path():Array
		{
			return _path;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		private function init():void
		{
			_path = new Array(
				
				{row:7,col:1,STEP:1,type:"normal"},
				{row:7,col:2,STEP:2,type:"normal"},	
				{row:7,col:3,STEP:3,type:"normal"},
				{row:7,col:4,STEP:4,type:"normal"},
				{row:7,col:5,STEP:5,type:"normal"},
				{row:7,col:6,STEP:6,type:"normal"},
				{row:7,col:7,STEP:7,type:"normal"},
				{row:7,col:8,STEP:8,type:"normal"},
				{row:7,col:9,STEP:9,type:"normal"},
				
				{row:6,col:9,STEP:10,type:"normal"},
				{row:6,col:8,STEP:11,type:"normal"},
				{row:6,col:7,STEP:12,type:"ladder",subPath:[{row:5,col:7},{row:4,col:7}],destIndex:31},//ladder
				{row:6,col:6,STEP:13,type:"normal"},
				{row:6,col:5,STEP:14,type:"snake",subPath:[{row:6,col:4},{row:7,col:4},{row:7,col:3},{row:7,col:2},{row:7,col:1}],destIndex:0 },//pink snake
				{row:6,col:4,STEP:15,type:"normal"},
				{row:6,col:3,STEP:16,type:"normal"},
				{row:6,col:2,STEP:17,type:"normal"},
				{row:6,col:1,STEP:18,type:"normal"},
				{row:6,col:0,STEP:19,type:"normal"},
				
				{row:5,col:0,STEP:20,type:"normal"},
				{row:5,col:1,STEP:21,type:"ladder",subPath:[{row:4,col:1},{row:3,col:1},{row:3,col:0}],destIndex:39},//ladder
				{row:5,col:2,STEP:22,type:"normal"},
				{row:5,col:3,STEP:23,type:"normal"},
				{row:5,col:4,STEP:24,type:"normal"},		
				{row:5,col:5,STEP:25,type:"normal"},
				{row:5,col:6,STEP:26,type:"normal"},
				{row:5,col:7,STEP:27,type:"normal"},
				{row:5,col:8,STEP:28,type:"normal"},		
				{row:5,col:9,STEP:29,type:"normal"},
				
				{row:4,col:9,STEP:30,type:"snake",subPath:[{row:5,col:9},{row:6,col:9}],destIndex:9},		
				{row:4,col:8,STEP:31,type:"normal"},
				{row:4,col:7,STEP:32,type:"normal"},		
				{row:4,col:6,STEP:33,type:"normal"},
				{row:4,col:5,STEP:34,type:"normal"},
				{row:4,col:4,STEP:35,type:"normal"},
				{row:4,col:3,STEP:36,type:"normal"},
				{row:4,col:2,STEP:37,type:"normal"},
				{row:4,col:1,STEP:38,type:"normal"},
				{row:4,col:0,STEP:39,type:"normal"},
				
				{row:3,col:0,STEP:40,type:"normal"},
				{row:3,col:1,STEP:41,type:"normal"},
				{row:3,col:2,STEP:42,type:"normal"},
				{row:3,col:3,STEP:43,type:"normal"},
				{row:3,col:4,STEP:44,type:"normal"},		
				{row:3,col:5,STEP:45,type:"normal"},
				{row:3,col:6,STEP:46,type:"normal"},
				{row:3,col:7,STEP:47,type:"normal"},
				{row:3,col:8,STEP:48,type:"normal"},		
				{row:3,col:9,STEP:49,type:"ladder",subPath:[{row:2,col:9},{row:1,col:9}],destIndex:68},//ladder
				
				
				{row:2,col:9,STEP:50,type:"normal"},
				{row:2,col:8,STEP:51,type:"normal"},
				{row:2,col:7,STEP:52,type:"snake",subPath:[{row:3,col:7},{row:3,col:8}],destIndex:47},
				{row:2,col:6,STEP:53,type:"normal"},
				{row:2,col:5,STEP:54,type:"normal"},
				{row:2,col:4,STEP:55,type:"normal"},
				{row:2,col:3,STEP:56,type:"ladder",subPath:[{row:1,col:3},{row:1,col:4}],destIndex:63},
				{row:2,col:2,STEP:57,type:"normal"},
				{row:2,col:1,STEP:58,type:"normal"},
				{row:2,col:0,STEP:59,type:"normal"},
				
				
				{row:1,col:0,STEP:60,type:"normal"},
				{row:1,col:1,STEP:61,type:"normal"},
				{row:1,col:2,STEP:62,type:"normal"},
				{row:1,col:3,STEP:63,type:"normal"},
				{row:1,col:4,STEP:64,type:"normal"},
				{row:1,col:5,STEP:65,type:"normal"},
				{row:1,col:6,STEP:66,type:"normal"},
				{row:1,col:7,STEP:67,type:"normal"},
				{row:1,col:8,STEP:68,type:"normal"},
				{row:1,col:9,STEP:69,type:"normal"},
				
				
				{row:0,col:9,STEP:70,type:"normal"},
				{row:0,col:8,STEP:71,type:"normal"},
				{row:0,col:7,STEP:72,type:"normal"},
				{row:0,col:6,STEP:73,type:"snake",subPath:[{row:1,col:6},{row:1,col:5},{row:2,col:5},{row:3,col:5}],destIndex:44},//orange snake
				{row:0,col:5,STEP:74,type:"normal"},
				{row:0,col:4,STEP:75,type:"normal"},
				{row:0,col:3,STEP:76,type:"normal"},
				//light blue snake
				{row:0,col:2,STEP:77,type:"snake",subPath:[{row:1,col:2},{row:2,col:2},{row:3,col:2},{row:3,col:3},{row:4,col:3},{row:4,col:3},{row:4,col:4}],destIndex:34},
				{row:0,col:1,STEP:78,type:"snake",subPath:[{row:1,col:1},{row:2,col:1}],destIndex:57},
				{row:0,col:0,STEP:79,type:"completed"},
				{row:0,col:-1,STEP:79,type:"completed"}
				
				);
			
		}
	}
}