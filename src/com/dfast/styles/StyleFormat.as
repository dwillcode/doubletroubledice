package com.dfast.styles 
{
	import com.dfast.utils.StringUtils;
	
	/**
	 * An object containing properties used to format a UIObject.
	 * @author Derrick Williams
	 */
	public class StyleFormat 
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new Style Format object.
		 */
		public function StyleFormat() 
		{
			_properties = { };
			_name = "";
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _name 		: String;
		private var _properties : Object;
		
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	name
		// ---------------------------------------------------------------
		
		/**
		 * The name of this Style Format instance.
		 */
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		// ---------------------------------------------------------------
		//	properties
		// ---------------------------------------------------------------
		
		/**
		 * The properties stored in this Style Format object.
		 */
		public function get properties() : Object { return _properties; }
		
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	enumertateStyleProperties
		// ---------------------------------------------------------------
		
		/**
		 * Returns an array of the names of properties in this StyleFormat object.
		 * @return An array of property names.
		 */
		public function enumertateStyleProperties() : Array
		{
			var propertiesList : Array = [];
			
			for (var property:String in _properties) {
				propertiesList.push( property );
			}
			
			return propertiesList;
		}
		
		// ---------------------------------------------------------------
		//	getProperty
		// ---------------------------------------------------------------
		
		/**
		 * Returns a value given the property name.
		 * @param	name	The name of the property.
		 * @return The value of the property.
		 */
		public function getProperty( name:String ) : *
		{
			return _properties[ name ];
		}
		
		// ---------------------------------------------------------------
		//	parseStyleObject
		// ---------------------------------------------------------------
		
		/**
		 * Parses a given stylObject and stores the properties in this StyleFormat object.
		 * @param	styleObject The object with the style properties to parse and store.
		 */
		public function parseStyleObject( styleObject:Object ) : void
		{
			for (var property:String in styleObject) {
				
				var propertyValue : * = styleObject[ property ];
				var propertyName : String = property;
				
				// convert the property name to camel case if a "-" is used
				var dashIndex : int = property.indexOf("-");
				if( dashIndex  > -1 ) {
					var propertyPrefix : String = property.substring( 0, dashIndex );
					var propertySuffix : String = StringUtils.toInitialCap( property.substring( dashIndex + 1 ) );
					
					propertyName = propertyPrefix + propertySuffix;
				}
				
				// change "#000000" color format to "0x000000"
				if ( ( propertyValue as String ).indexOf( "#" ) > -1 ) {
					propertyValue = StringUtils.replace( propertyValue as String, "#", "0x" );
				}
				
				// covert "true" and "false" to booleans
				propertyValue = (propertyValue == "true") ? true : propertyValue;
				propertyValue = (propertyValue == "false") ? false : propertyValue;
				
				// strip quotation marks from the property value
				propertyValue = StringUtils.remove( propertyValue, "\"" );
				
				// remove unit suffixes if the property is font size
				var fontUnits : Array = [ "px", "pt", "em", "ems", "ex", "%" ];
				
				if ( propertyName == "fontSize" ) {
					for ( var i:int = 0; i < fontUnits.length; i++) {
						propertyValue = StringUtils.remove( propertyValue, fontUnits[ i ] );
					}
				}
				
				// set the property
				setProperty( propertyName, propertyValue );
			}
		}
		
		// ---------------------------------------------------------------
		//	setProperty
		// ---------------------------------------------------------------
		
		/**
		 * Sets a property for this StyleFormat object.
		 * @param	name	The name of the property set.
		 * @param	value	The value of the property being set.
		 */
		public function setProperty( name : String, value : * ) : void
		{
			_properties[ name ] = value;
		}
		
		
	}
	
}