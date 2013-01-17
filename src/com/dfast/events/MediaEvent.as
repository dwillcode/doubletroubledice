package com.dfast.events 
{
	import flash.events.Event;

	/**
	 * @author Derrick Williams
	 */
	public class MediaEvent extends Event
	{
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function MediaEvent(	type 		: String, 
									position 	: Number = 0, 
									duration 	: Number = 0,
									width		: Number = 0,
									height		: Number = 0,
									bubbles		: Boolean = false,
									cancelable	: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			_position 	= position;
			_duration 	= duration;
			_width		= width;
			_height		= height;
				
		}
		
		// ===============================================================
		//
		//	Constants
		//
		// ===============================================================
		
		public static const START 		: String = "mediaStart";
		public static const STOP		: String = "mediaStop";
		public static const PROGRESS	: String = "mediaProgress";
		public static const COMPLETE	: String = "mediaComplete";
		public static const METADATA	: String = "mediaMetadata";
		public static const LOAD		: String = "mediaLoad";
		public static const PAUSE		: String = "mediaPaused";
		
		// ===============================================================
		//
		//	Local Variables
		//
		// ===============================================================
		
		private var _width		: Number;
		private var _height		: Number;
		private var _position	: Number;
		private var _duration	: Number;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	width
		// ---------------------------------------------------------------
		
		public function get width() : Number { return _width; }
		
		// ---------------------------------------------------------------
		//	height
		// ---------------------------------------------------------------
		
		public function get height() : Number { return _height; }
		
		// ---------------------------------------------------------------
		//	position
		// ---------------------------------------------------------------
		
		public function get position() : Number { return _position; }
		
		// ---------------------------------------------------------------
		//	duration
		// ---------------------------------------------------------------
		
		public function get duration() : Number { return _duration; }
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		//--------------------------------------------------------------------------
		//  clone
		//--------------------------------------------------------------------------
		
		override public function clone() : Event
		{
			return new MediaEvent( type, _position, _duration, _width, _height, bubbles, cancelable );
		}
		
		
		
		
	}
}
