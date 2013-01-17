package com.dfast.core 
{
	import com.dfast.styles.IStyleable;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public interface IUIObject extends IEventDispatcher, IStyleable
	{
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		function destroy() : void;
		function destroyAllChildren() : void;
			
	}
	
}