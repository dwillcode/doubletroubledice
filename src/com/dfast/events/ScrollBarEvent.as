package com.dfast.events
{
	
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const CHANGE : String = "change";
		
		public var scrollPercent : Number;
		
		public function ScrollBarEvent(scrollPercent:Number)
		{
			super(CHANGE);
			this.scrollPercent = scrollPercent;
		}
	}
	
}