package com.arn.ui
{
	
	import flash.events.*;
	
	/**
	 * Scroll Bar Event
	 * 
	 * @author 	Derrick Williams, Arnold Worldwide
	 * @author	http://arnoldworldwide.com/
	 * @version 1.0, ActionScript 3.0
	 */
	public class ScrollBarEvent extends Event
	{
		public static const CHANGE : String = "change";
		public static const DRAG_UPDATE : String = "update";
		
		
		public var scrollPercent : Number;
		
		public function ScrollBarEvent( type : String, sp:Number)
		{
			super(type);
			scrollPercent = sp;
		}
	}
	
}