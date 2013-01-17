package com.dfast.controls 
{
	import com.dfast.core.UIObject;
	import com.dfast.styles.StyleFormat;

	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class RadioButton extends Button
	{
		public static const GUTTER : Number = 10;
		
		protected var _label : Label;
		protected var _value : *;
		protected var _text : String;
		
		override public function set styleFormat( value:StyleFormat ):void 
		{
			_label.styleFormat = value;
		}
		
		public function get text():String { return _text; }	
		public function set text(value:String):void 
		{
			_text = value;
		}
		
		public function get value():* { return _value; }
		public function set value(value:*):void 
		{
			_value = value;
		}
		
		public function RadioButton(value:*=null, text:String="", upState:DisplayObject=null, selectedState:DisplayObject=null) 
		{
			_text = text;
			_value = value;
			
			super(upState, null, null, selectedState);
			
			_label = new Label();
			addChild(_label);
			
			addEventListener( MouseEvent.CLICK, onClick);
		}
		
		override public function render() : void
		{
			_label.text = _text;
			_label.x = _upState.width + GUTTER;
			_label.render();
			
			if (_hitTestState) {
				_hitTestState.width = _upState.width + GUTTER + _label.textWidth;
			}
			
			super.render();
		}
		
		private function onClick(event:MouseEvent):void 
		{
			this.selected = true;
		}
		
	}
	
}