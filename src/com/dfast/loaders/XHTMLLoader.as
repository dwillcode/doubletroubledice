package com.dfast.loaders 
{
	import com.dfast.loaders.ILoadable;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * Loads and cache an XHTML document.
	 * @author Derrick Williams
	 */
	public class XHTMLLoader extends EventDispatcher implements ILoadable
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new instance of the XHTMLLoader class.
		 */
		public function XHTMLLoader() {}
		
		// ===============================================================
		//
		//	Constants
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	xhtml
		// ---------------------------------------------------------------
		
		/**
		 * The namespace used in the xhtml.
		 */
		public namespace xhtml = "http://www.w3.org/1999/xhtml";
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _body : XMLList;
		private var _head : XMLList;
		private var _xml : XML;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	body
		// ---------------------------------------------------------------
		
		/**
		 * The body node of the XHTML document.
		 */
		public function get body() : XMLList { return _xml.body; }
		
		// ---------------------------------------------------------------
		//	head
		// ---------------------------------------------------------------
		
		/**
		 * The head node of the XHTML document.
		 */
		public function get head() : XMLList { return _xml.head; }
		
		// ---------------------------------------------------------------
		//	xml
		// ---------------------------------------------------------------
		
		/**
		 * Returns the xml that was loaded.
		 */
		public function get xml():XML { return _xml; }
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	getElementById
		// ---------------------------------------------------------------
		
		/**
		 * Returns the element from the XHTML based on the element's id.
		 * @param	element_id	The name of the element.
		 * @return	The element with an id attribute matching the given element_id.
		 */
		public function getElementById( element_id : String ) : *
		{
			return _xml.body.*.( @id == element_id );
		}
		
		// ---------------------------------------------------------------
		//	getElementsByTagName
		// ---------------------------------------------------------------
		
		/**
		 * Returns a element or XMLList based on the tag name.
		 * @param	element_name	The tag name of the element(s).
		 * @return	The elements or XMLList of node with the given tag name.
		 */
		public function getElementsByTagName( element_name : String ) : *
		{
			return _xml.body[ element_name ];
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		/**
		 * Loads a XHTML document.
		 * @param	url	The url of the XHTML document to load.
		 */
		public function load( url : String ) : void
		{
			var request : URLRequest = new URLRequest( url );
			var loader : URLLoader = new URLLoader( request );
			
			loader.addEventListener( Event.COMPLETE, onComplete );
		}
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onComplete
		// ---------------------------------------------------------------
		
		/**
		 * @private
		 * Handles the complete event of the XHTML document loader.
		 */
		private function onComplete( event:Event ) : void 
		{
			event.target.removeEventListener( Event.COMPLETE, onComplete );
			_xml = XML( event.target.data );
			
			_xml.removeNamespace( xhtml );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
	}
	
}