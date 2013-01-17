package com.dfast.display 
{
	import com.dfast.media.IMedia;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class AbstractMediaDisplay extends Sprite
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function AbstractMediaDisplay() 
		{
			
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		protected var _width : Number;
		protected var _height : Number;
		
		protected var _media : IMedia;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		public function get media() : IMedia { return _media; }
		
		public function set media( media:IMedia ) : void 
		{
			_media = media;
		}
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		public function setSize( width:Number, height:Number) : void
		{
			_width = width;
			_height = height;
		}
		
		
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
	}
	
}