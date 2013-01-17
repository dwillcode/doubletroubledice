package com.arn.ui {
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Derrick Williams
	 * @version 0.1
	 */
	public interface IScrollBar extends IEventDispatcher{
		
		/**
		 * Moves the thumb to the given value along the track.
		 * If animate is true, then the thumb will tween to the
		 * given value.
		 * 
		 * @param	value	The position of the thumb.
		 * @param	animate	If true, the thumb will tween to the value.
		 */
		function moveThumb( value:Number, animate:Boolean = false ) : void;
		
	}
	
}