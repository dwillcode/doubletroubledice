package com.dfast.controls 
{
	import com.dfast.core.UIObject;
	import flash.events.MouseEvent;

	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class CheckBox extends Button
	{
		private var _value:*;
		
		public function get value():* { return _value; }
		public function set value(value:*):void 
		{
			_value = value;
		}
		
		public function CheckBox(value:* = null, upState:DisplayObject = null, selectedState:DisplayObject = null, disabledState:DisplayObject=null, hitTestState:DisplayObject = null) 
		{
			_value = value;
			super(upState, null, null, selectedState, disabledState, hitTestState);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void 
		{
			this.selected = !this.selected;
		}
	}
	
}