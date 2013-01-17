package com.dfast.managers 
 {
	import com.dfast.loaders.ILoadable;
	import com.dfast.styles.StyleFormat;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	 
	/**
	 * The Style Manager loads, parses, and caches external cascading style sheets.
	 */
	public class StyleManager extends EventDispatcher implements ILoadable
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new instance of the Style Manager class. 
		 * StyleManager.getInstance() should be used instead of the "new" operator.
		 * @param	enforcer	Ensures only this class can create a new instance of itself.
		 */
		public function StyleManager(enforcer:SingletonEnforcer) 
		{
			//trace("StyleManager : created");
			
			if (enforcer == null)
			{
				throw new Error("Singleton: Do not instantiate this class with the constructor.");
			}
			
			_intialized = false;
		}
		
		// ===============================================================
		//
		//  Static Vars
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//  Singelton Instance
		// ---------------------------------------------------------------
		
		private static var _instance:StyleManager;
		
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _styleFormats 	: Object = { };
		private var _styleSheet		: StyleSheet;
		private var _intialized		: Boolean;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	isInitialized
		// ---------------------------------------------------------------
		
		public function get isIntialized():Boolean { return _intialized; }
		
		
		
		// ===============================================================
		//	
		//	Static Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	getInstance
		// ---------------------------------------------------------------
		
		/**
		 * Returns an instance of the Style Manager. This function should be used instead
		 * of the "new" operator to create an instance of the Style Manager.
		 * @usage StyleManager.getInstance();
		 * @return The only active (Singleton) instance of the Style Manager class.
		 */
		public static function getInstance() : StyleManager 
		{
			if(!_instance)
			{
				_instance = new StyleManager(new SingletonEnforcer());
			}
			
			return _instance;
		}
		
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	enumerateStyleFormats
		// ---------------------------------------------------------------
		
		/**
		 * Returns an array of the Style Formats in this Style Manager.
		 * @return An array of StyleFormats.
		 */
		public function enumerateStyleFormats() : Array
		{
			var styleFormatsList : Array = [];
			
			trace("\nAvailable Style Formats");
			trace("---------------------------");
			for (var styleFormat:String in _styleFormats) {
				trace( _styleFormats[ styleFormat ].name );
				styleFormatsList.push( _styleFormats[ styleFormat ] );
				_styleFormats[ styleFormat ].enumertateStyleProperties();
			}
			
			return styleFormatsList;
		}
		
		// ---------------------------------------------------------------
		//	getStyleFormat
		// ---------------------------------------------------------------
		
		/**
		 * Returns a Style Format object given the name of the Style Format.
		 * @param	name The name of the Style Format object.
		 * @return	A Style Format object.
		 */
		public function getStyleFormat( name:String ) : StyleFormat
		{
			return _styleFormats[ name ];
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		/**
		 * Loads a CSS file.
		 * @param	url	The path to the CSS file to load.
		 */
		public function load( url:String ) : void
		{
			var _cssRequest : URLRequest = new URLRequest( url );
			var _cssLoader : URLLoader = new URLLoader( _cssRequest );
			_cssLoader.addEventListener( Event.COMPLETE, onCSSLoaded );
		}
		
		// ---------------------------------------------------------------
		//	parseCSS
		// ---------------------------------------------------------------
		
		/**
		 * Parses the loaded CSS file.
		 */
		private function parseCSS() : void 
		{
			for ( var i:int = 0; i < _styleSheet.styleNames.length; i++) {
				var styleFormat : StyleFormat = new StyleFormat();
				styleFormat.parseStyleObject( _styleSheet.getStyle( _styleSheet.styleNames[i] ) );
				//trace(_styleSheet.styleNames[i]);
				
				setStyleFormat( _styleSheet.styleNames[i], styleFormat );
			}
			
			_intialized = true;
			
			dispatchEvent( new Event( Event.INIT ) );
		}
		
		// ---------------------------------------------------------------
		//	setStyleFormat
		// ---------------------------------------------------------------
		
		/**
		 * Sets a new style format.
		 * @param	name		The name to apply to the given Style Format object.
		 * @param	styleFormat	The Style Format object to store. 
		 */
		public function setStyleFormat( name:String, styleFormat:StyleFormat ) : void
		{
			styleFormat.name = name;
			_styleFormats[ name ] = styleFormat;
		}

		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onCSSLoaded
		// ---------------------------------------------------------------
		
		/**
		 * @private
		 * Handles when the CSS file has been loaded.
		 */
		private function onCSSLoaded( event:Event ) : void 
		{
			event.target.removeEventListener( Event.COMPLETE, onCSSLoaded );
			
			_styleSheet = new StyleSheet();
			_styleSheet.parseCSS( event.target.data );
			
			parseCSS();
		}
		
	}

}

class SingletonEnforcer { }
