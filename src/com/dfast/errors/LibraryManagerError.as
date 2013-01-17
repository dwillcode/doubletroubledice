package com.dfast.errors 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class LibraryManagerError extends Error
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function LibraryManagerError( message:* = "", id:* = 0 ) 
		{
			super( message, id );
		}
		
		// ===============================================================
		//
		//	Constants
		//
		// ===============================================================
		
		public static const NO_LIBRARIES_ADDED 		: String = "No libaries have been added to load.";
		
		public static const CLASS_NOT_FOUND 		: String = "Unable to find a class with the given name within the loaded libraries.";
		
		public static const LIBRARY_NOT_FOUND 		: String = "Unable to find a library with the given name.";
		
		public static const MANAGER_NOT_INITIATED 	: String = "Libaray Manager must be loaded.";
		
	}
	
}