
package com.arn.events 
{
	import flash.events.Event;

	/**
	 * @author Eric Heaton
	 */
	public class AnimationEvent extends Event 
	{
		//--------------------------------------------------------------------------
		//
		// Class Constants
		//
		//--------------------------------------------------------------------------
		

		public static const INTRO_BEGIN			: String	= "animateIntroBegin";
		public static const OUTRO_BEGIN			: String	= "animateOutroBegin";		
		public static const INTRO_COMPLETE		: String	= "animateIntroComplete";
		public static const OUTRO_COMPLETE		: String	= "animateOutroComplete";
		public static const UPDATE_COMPLETE		: String	= "animateUpdateComplete";
		public static const UPDATE_BEG			: String	= "animateUpdateBegin";
		public static const ANIMATION_COMPLETE 	: String	= "animateComplete";
		public static const ANIMATION_BEGIN		: String	= "animateBegin";
		public static const INIT_COMPLETE		: String	= "initComplete";		
		
		public var clip : *;
		
		
		public function AnimationEvent (type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
		}

	
		public override function clone() : Event
		{
			return new AnimationEvent(type, clip);	
		}
	}	
}
