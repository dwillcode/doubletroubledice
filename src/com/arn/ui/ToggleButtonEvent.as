package com.arn.ui
{
	import flash.events.*;

	/**
	 * Scroll Bar Event
	 * 
	 * @author 	Eric Heaton, Arnold Worldwide
	 * @author	http://arnoldworldwide.com/
	 * @version 1.0, ActionScript 3.0
	 */
	public class ToggleButtonEvent extends Event
	{
		public static const CHANGE : String = "change";
		
		public var state : String;
		
		public function ToggleButtonEvent(s:String)
		{
			super(CHANGE);
			state = s;
		}
	}
	
}