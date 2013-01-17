package com.dfast.managers 
 {
	import com.dfast.loaders.ILoadable;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.text.Font;
	
	/**
	 * The Font Manager class loads swf that contain fonts to be used throughout an application.
	 */
	public class FontManager extends EventDispatcher implements ILoadable
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new instance of the Font Manager class. 
		 * FontManager.getInstance() should be used instead of the "new" operator.
		 * @param	enforcer	Ensures only this class can create a new instance of itself.
		 */
		public function FontManager( enforcer:SingletonEnforcer ) 
		{
			//trace("FontManager : created");
			
			if (enforcer == null)
			{
				throw new Error("Singleton: Do not instantiate this class with the constructor.");
			}
		}
		
		// ===============================================================
		//
		//  Static Vars
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//  Singelton Instance
		// ---------------------------------------------------------------

		private static var _instance:FontManager;
		
		
		// ===============================================================
		//	
		//	Static Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	getInstance
		// ---------------------------------------------------------------
		
		/**
		 * Returns an instance of the Font Manager. This function should be used instead
		 * of the "new" operator to create an instance of the Font Manager.
		 * @usage FontManager.getInstance();
		 * @return The only active (Singleton) instance of the Font Manager class.
		 */
		public static function getInstance() : FontManager 
		{
			if(!_instance)
			{
				_instance = new FontManager(new SingletonEnforcer());
			}
			
			return _instance;
		}
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	enumerateFonts
		// ---------------------------------------------------------------
		
		/**
		 * Returns an array of the active fonts avaliable.
		 * @param	enumerateDeviceFonts	Determines if the device fonts
		 * 									should be included in the list.
		 * @return	An array with the available fonts.
		 */
		public function enumerateFonts( enumerateDeviceFonts:Boolean = true ) : Array
		{
			return Font.enumerateFonts( enumerateDeviceFonts );
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		/**
		 * Loads a swf with the needed fonts.
		 * @param	url	The path to the font swf to load.
		 */
		public function load( url:String ) : void
		{
			var fontLoader : Loader = new Loader();
			var fontRequest : URLRequest = new URLRequest( url );
			
			fontLoader.load( fontRequest );
			fontLoader.contentLoaderInfo.addEventListener( Event.INIT, onFontSwfLoaded );
		}

		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onFontSwfLoaded
		// ---------------------------------------------------------------
		
		/**
		 * @private
		 * Handles when the font swf is loaded.
		 */
		private function onFontSwfLoaded(event:Event):void 
		{
			event.target.removeEventListener( Event.INIT, onFontSwfLoaded );
			
			dispatchEvent( new Event( Event.INIT ) );
		}
	}

}

class SingletonEnforcer { }
