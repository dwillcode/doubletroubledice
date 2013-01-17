
package com.arn.time 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Eric Heaton
	 */
	public class Delay 
	{
	
		//--------------------------------------------------------------------------
		//  create
		//--------------------------------------------------------------------------
		
		/**
		 * Creates a delayed function call.
		 * 
		 * @param fnct Function name to call after the delay is done
		 * @param time Time to delay the function call ( in seconds )
		 * @param rest Arguments to send the delayed function
		 */
		public static function create( fnct : Function, time : Number, ...rest ) : Timer
		{
			var _timer 				: Timer 	= new Timer( time * 1000, 1 );
			
			var _onTimerComplete 	: Function 	= function( e : TimerEvent ) : void
			{
				fnct.apply( this, rest );	
			};
			
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _onTimerComplete );
			_timer.start();
			
			return _timer;
		}
		
	}
	
}

