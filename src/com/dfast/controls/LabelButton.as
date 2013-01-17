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
	public class LabelButton extends Button
	{
		protected var _label : Label;
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
		
		public function LabelButton(text:String = "", upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, selectedState:DisplayObject = null, disabledState:DisplayObject=null, hitTestState:DisplayObject = null) 
		{
			_text = text;
			
			super(upState, overState, downState, selectedState, disabledState, hitTestState);
			
			_label = new Label();
			addChild(_label);
		}
		
		override public function render() : void
		{
			if (_width != 0 && _height != 0) {
//				trace("width and height are set");
				_label.setSize(_width, _height);
				
				resizeStates();
				
				_label.y = (_height - _label.textHeight) / 2 - 2;
			} else {
//				trace("width and height aren't set");
				_label.setSize( _upState.width, _upState.height);
				_label.y = (_upState.height - _label.textHeight) / 2 - 2;
			}
//			trace("label: " + _label.width + ", " + _label.height);
			_label.text = _text;
			_label.render();
			
			super.render();
		}
		
		private function resizeStates():void
		{
			var states:Array = [_upState, _downState, _overState, _selectedState, _disabledState, _hitTestState];
			var numStates:int = states.length;
			
			while(numStates--){
				setStateSize(states[numStates]);
			}
		}
		
	}
	
}