package interfaces
{
	import events.GameNotifier;
	
	import screens.GameBoard;
	
	import util.GameUtility;

	public interface IState
	{
		//function update():void;
		function destroy():void;
		function get gameNotifier():GameNotifier;
		function get gameUtility():GameUtility;
		//function showWinMesage():void;
		//function removeWinGamePanel():void;
		function endGame():void;
		function openExitGamePrompt():void;
		function destroyExitGamePrompt():void;
		//function backToHomeScreen():void;

	}
}