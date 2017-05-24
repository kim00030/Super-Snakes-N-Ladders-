package data
{
	public class BombData
	{
	
		private static  var _instance:BombData;
		
		private var _deliveredArray:Array; 
		private var _deliveredArray2:Array; 
		
		
		private var _availableShildPositions:Array;
		
		public function BombData()
		{
			
		}
		// -------------------------------------------------------------------------------------------------------------------------		

		public function get deliveredArray2():Array
		{
			return _deliveredArray2;
		}

		public function set deliveredArray2(value:Array):void
		{
			_deliveredArray2 = value;
		}

		public function get availableShildPositions():Array
		{
			return _availableShildPositions;
		}

		public function set availableShildPositions(value:Array):void
		{
			_availableShildPositions = value;
		}

		public function get deliveredArray():Array
		{
			return _deliveredArray;
		}

		public function set deliveredArray(value:Array):void
		{
			_deliveredArray = value;
		}

		public static function getInstance():BombData {
			
			if (!_instance)
				_instance = new BombData();
			
			return _instance;
		}
		/**
		 * 
		 * @param n number of bombs needed
		 * @return array contains tile info 
		 * 
		 */		
		public function getRandomBombPositions(n:int = 0):Array
		{
			//get predetermined bomb positions
			var bombPositons:Array = getBombPositons();
			var shuffledLetters:Array = new Array(bombPositons.length);
			
			var randomPos:Number = 0;
			
			//shuffle them
			for (var i:int = 0; i < shuffledLetters.length; i++)
			{
				randomPos = int(Math.random() * bombPositons.length);
				shuffledLetters[i] = bombPositons.splice(randomPos, 1)[0];   //since splice() returns an Array, we have to specify that we want the first (only) element
			}
			//create delivery array set length passed in this function
			if(deliveredArray) deliveredArray = null;
			deliveredArray = new Array(n);
			//assign shuffled data to the array
			for(i = 0; i<n;i++)
			{
				deliveredArray[i] = shuffledLetters.pop()//shuffledLetters[i];
			}
			availableShildPositions = shuffledLetters;
			return deliveredArray;
		}
		
		/**
		 * function defiens all possible tiles allow bombs
		 * @return array 
		 * 
		 */		
		private function getBombPositons():Array
		{
			var bombPositons:Array = new Array(
				
				//{row:0,col:3},
				/*			{row:0,col:4},
				{row:0,col:5},
				{row:0,col:8},*/
				//{row:0,col:9},
				{row:1,col:7},
				{row:1,col:8},
				{row:2,col:0},
				{row:2,col:4},
				{row:2,col:8},
				{row:3,col:6},
				{row:4,col:0},
				{row:4,col:2},
				{row:4,col:8},
				{row:5,col:0},
				{row:5,col:2},
				{row:5,col:3},
				{row:5,col:6},
				{row:5,col:8},
				{row:6,col:0},
				{row:6,col:1},
				{row:6,col:2},
				{row:6,col:6},
				{row:6,col:8}
			);

			return bombPositons;
		}
		
		public function avaialableShieldPositions(n:int = 0):Array
		{
			if(n == 0)
			{
				deliveredArray2 = null;
				
			}
			else
			{	
				deliveredArray2 = new Array();
				for(var i:int = 0; i<n;i++)
				{
					deliveredArray2[i] = this.availableShildPositions[i];
				}
				
			}
			return deliveredArray2;
		}
		
		public function getSpecialTiles():Array
		{
			var arr:Array;
			
			if(deliveredArray2)
			{
				arr = deliveredArray.concat(deliveredArray2)
			}
			else
			{
				arr = deliveredArray;
			}
			return arr;
		}
		
	}
}