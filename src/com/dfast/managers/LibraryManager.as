package com.dfast.managers 
 {
	import com.dfast.loaders.Library;
	import com.dfast.events.LibraryManagerEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	/**
	 * Manages a collection of Library objects.
	 */
	public class LibraryManager extends EventDispatcher
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new instance of the Library Manager class. 
		 * LibraryManager.getInstance() should be used instead of the "new" operator.
		 * @param	enforcer	Ensures only this class can create a new instance of itself.
		 */
		public function LibraryManager( enforcer:SingletonEnforcer ) 
		{
			_libraries = new Array();
			_libraryQueue = new Array();
			_initiated = false;
			
			if (enforcer == null)
			{
				throw new Error("Singleton: Do not instantiate this class with the constructor.");
			}
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
		
		// ===============================================================
		//
		//  Static Vars
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//  Singelton Instance
		// ---------------------------------------------------------------
		
		private static var _instance : LibraryManager;
		
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _libraryQueue : Array;	
		private var _libraries : Array;
		private var _numLibraries : uint;
		private var _initiated : Boolean;
		
		
		// ===============================================================
		//	
		//	Static Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	getInstance
		// ---------------------------------------------------------------
		
		/**
		 * Returns an instance of the Library Manager. This function should be used instead
		 * of the "new" operator to create an instance of the Library Manager.
		 * @usage FontManager.getInstance();
		 * @return The only active (Singleton) instance of the Library Manager class.
		 */
		public static function getInstance() : LibraryManager 
		{
			if(!_instance) _instance = new LibraryManager(new SingletonEnforcer());
			
			return _instance;
		}
		
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	addLibrary
		// ---------------------------------------------------------------
		
		/**
		 * Adds a new swf library to the load queue.
		 * @param	name	The name of the library.
		 * @param	url		The url of the swf library to load.
		 */
		public function addLibrary( name:String, url:String ) : void
		{
			_libraryQueue.push( { name: name, url: url } );		
		}
		
		// ---------------------------------------------------------------
		//	getDefinition
		// ---------------------------------------------------------------
		
		/**
		 * Returns a class based on the given name.
		 * @param	name	The name of the class.
		 * @return	The class if the class if available. Otherwise, return null.
		 */
		public function getDefinition( name:String ) : *
		{
			if ( !_initiated ) {
				throw new Error( MANAGER_NOT_INITIATED );
				return null;
			}
			
			for ( var i:int = 0; i < _libraries.length; i++) {
				if ( _libraries[ i ].hasDefinition( name ) ) {
					return  _libraries[ i ].getDefinition( name );
				}
			}
			
			throw new Error( CLASS_NOT_FOUND );
			return null;
		}
		
		// ---------------------------------------------------------------
		//	getLibrary
		// ---------------------------------------------------------------
		
		/**
		 * Returns a Library object with the given name. 
		 * @param	name	The name of the library to search for.
		 * @return	The Library object with the given name if it exist, a null object if otherwise.
		 */
		public function getLibrary( name:String ) : *
		{
			if ( !_initiated ) {
				throw new Error( MANAGER_NOT_INITIATED );
				return null;
			}
			
			var numLibraries : int = _libraries.length;
			
			for ( var i:int = 0; i < numLibraries; i++ ) {
				if ( _libraries[ i ].name == name ) {
					return _libraries[ i ];
				}
			}
			
			
			return null;
		}
		
		// ---------------------------------------------------------------
		//	getObject
		// ---------------------------------------------------------------
		
		/**
		 * Returns a new instance of an object with the given class name.
		 * @param	name	The name of the class.
		 * @return	An object created from the given class constructor name.
		 */
		public function getObject( name:String ) : *
		{
			if ( !_initiated ) {
				throw new Error( MANAGER_NOT_INITIATED );
				return null;
			}
			
			try {
				var objectClass	: Class = getDefinition( name );
				var object : * = new objectClass();
				return object;
			} catch ( error:Error ) {
				throw new Error( CLASS_NOT_FOUND );
				return null;
			}
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		/**
		 * Loads the libraries available in the load queue.
		 */
		public function load() : void
		{
			var numLibraries : int = _libraryQueue.length;
			
			// check if there are any libraries to load
			if ( numLibraries == 0 ) {
				throw new Error( NO_LIBRARIES_ADDED );
			}
			
			for ( var i:int = 0; i < numLibraries; i++) {
				var library:Library = new Library();
				library.name = _libraryQueue[ i ].name;
				library.load( _libraryQueue[ i ].url );
				library.addEventListener( Event.COMPLETE, onLibraryLoaded );	
			}
		}
		
		// ---------------------------------------------------------------
		//	unload
		// ---------------------------------------------------------------
		
		/**
		 * Unloads the library with the given name from memory.
		 * @param	libraryName	The name of the library to unload.
		 */
		public function unload( libraryName:String ) : void
		{
			var library : Library = getLibrary( libraryName );
			
			if ( library ) {
				library.unload();
				var libraryIndex : int;
				
				for (var i:int = 0; i < _numLibraries; i++) {
					// TODO : Remove the unloaded library form the list of libraries 
				}
			}
			
			// TODO : Should I dispatch an event if the library with the given name isn't found?
		}
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onLibraryLoaded
		// ---------------------------------------------------------------
		
		/**
		 * @private
		 * Handles when a library is loaded.
		 */
		private function onLibraryLoaded( event:Event ) : void 
		{
			event.target.removeEventListener( Event.COMPLETE, onLibraryLoaded );
			_libraries.push( event.target );
			
			// check if all the added libraries have been loaded
			if ( _libraryQueue.length == _libraries.length ) {
				_initiated = true;
				dispatchEvent( new Event( Event.INIT ) );
			}
		}
	}

}

class SingletonEnforcer { }
