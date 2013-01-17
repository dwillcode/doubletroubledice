package com.dfast.loaders 
{
	import com.dfast.loaders.ILoadable;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	
	/**
	 * Library objects serve as containers for items found in the library of an FLA.
	 * @author Derrick Williams
	 */
	public class Library extends EventDispatcher implements ILoadable
	{		
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new instance of the Library class.
		 */
		public function Library() 
		{
			_loader = new Loader();
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _loader	: Loader;
		private var _name: String;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	name
		// ---------------------------------------------------------------
		
		/**
		 * The name of this library object.
		 */
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	getDefinition
		// ---------------------------------------------------------------
		
		/**
		 * Gets the Class for the object with the given name. 
		 * @param	name	The name of the Class to search for.
		 * @return	The Class object for the given definition.
		 */
		public function getDefinition( name:String ) : Class
		{
			return _loader.content.loaderInfo.applicationDomain.getDefinition( name ) as Class;
		}
		
		// ---------------------------------------------------------------
		//	hasDefintion
		// ---------------------------------------------------------------
		
		/**
		 * Determines if the given Class exists.
		 * @param	name	The name of the Class to search for.
		 * @return	True if the Class exists, flase if not.
		 */
		public function hasDefinition( name:String ) : Boolean
		{
			return _loader.content.loaderInfo.applicationDomain.hasDefinition( name );
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		/**
		 * Loads the swf that constitutes this library object.
		 * @param	swfUrl	The url of the swf to load.
		 */
		public function load( url:String ) : void
		{
			var request : URLRequest = new URLRequest( url );
			var context : LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
			
			
			_loader.load( request, context );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoaderComplete );
		}
		
		
		public function unload() : void
		{
			//var flashVersion : String = Capabilities.version;
			
			try {
				_loader.unloadAndStop();
			} catch ( error:Error ) {
				_loader.unload();
			}
			
			trace( "unload complete");
		}
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onLoaderComplete
		// ---------------------------------------------------------------
		
		/**
		 * @private
		 * Handles when the swf has loaded.
		 */
		private function onLoaderComplete( event:Event ):void 
		{
			event.target.removeEventListener( Event.COMPLETE, onLoaderComplete );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
	
}