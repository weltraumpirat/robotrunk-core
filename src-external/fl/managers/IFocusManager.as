package fl.managers {
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;

	// Derived from fl.managers.IFocusManager,
	
	public interface IFocusManager extends IEventDispatcher {
		function get nextTabIndex() : int;

		function getFocus() : InteractiveObject;

		function setFocus(o : InteractiveObject) : void;

		function activate() : void;

		function deactivate() : void;

		function findFocusManagerComponent(component : InteractiveObject) : InteractiveObject;

		function getNextFocusManagerComponent(backward : Boolean = false) : InteractiveObject;
	}
}
