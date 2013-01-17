package com.dfast.controls
{
	import com.dfast.core.UIObject;
	import flash.display.Stage;
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class Button extends UIObject
	{
		protected var _statesContainer : Sprite;
		protected var _upState : DisplayObject;
		protected var _overState : DisplayObject;
		protected var _downState : DisplayObject;
		protected var _selectedState : DisplayObject;
		protected var _disabledState : DisplayObject;
		protected var _hitTestState : DisplayObject;
		
		private var _selected : Boolean;
		private var _enabled : Boolean;
		private var _isPressed : Boolean;
		
		private var _url : String;
		private var _window : String;
		
		public function set upState(value:DisplayObject):void 
		{
			_upState = value;
		}
		
		public function set overState(value:DisplayObject):void 
		{
			_overState = value;
		}
		
		public function set downState(value:DisplayObject):void 
		{
			_downState = value;
		}
		
		public function set hitTestState(value:DisplayObject):void 
		{
			_hitTestState = value;
		}
		
		public function set selectedState(value:DisplayObject):void 
		{
			_selectedState = value;
		}
		
		public function set disabledState(value:DisplayObject):void 
		{
			_disabledState = value;
		}
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			if (_selected) {
				removeEventListeners();
				addState(_selectedState);
			} else {
				addEventListeners();
				addState(_upState);
			}
						
		}
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			mouseEnabled = _enabled;
			
			if (_enabled) {
				if (_selected) {
					removeEventListeners();
				} else {
					addEventListeners();
					addState(_upState);
				}
			} else {
				removeEventListeners();
				
				if (_selected) {
					removeEventListeners();
				} else {
					addState(_disabledState);
				}
			}
		}
		
		public function get url():String { return _url; }
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		public function get window():String { return _window; }
		public function set window(value:String):void 
		{
			_window = value;
		}
		
		
		
		public function Button(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, selectedState:DisplayObject=null, disabledState:DisplayObject=null, hitTestState:DisplayObject=null) 
		{
			_upState = upState;
			_overState = overState;
			_downState = downState;
			_selectedState = selectedState;
			_disabledState = disabledState;
			_hitTestState = hitTestState;
			
			_statesContainer = new Sprite();
			addChild(_statesContainer);
			
			addEventListeners();
			
			mouseChildren = false;
			buttonMode = true;
			_selected = false;
			_enabled = true;
			_isPressed = false;
			
			addState(_upState);
			
			super();
		}
		
		private function addEventListeners():void
		{
			addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			addEventListener(MouseEvent.ROLL_OVER, onMouseEvent);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
		}
		
		private function removeEventListeners():void
		{
			removeEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			removeEventListener(MouseEvent.ROLL_OVER, onMouseEvent);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
		}
		
		private function onMouseEvent(event:MouseEvent):void
		{
			switch(event.type) {
				case MouseEvent.MOUSE_UP:
					_isPressed = false;
					stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
				case MouseEvent.ROLL_OVER:
					if (!_isPressed) 
						if (event.currentTarget is Stage) 
							addState(_upState);
						else
							addState(_overState);
					else
						addState(_downState);
					break;
				case MouseEvent.MOUSE_DOWN:
					_isPressed = true;
					stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
					addState(_downState);
					break;
				case MouseEvent.MOUSE_OUT:
					addState(_upState);
					break;
			}
		}
		
		override public function render() : void
		{
			if (_hitTestState) {
				_hitTestState.alpha = 0;
				addChild(_hitTestState);
			}
			
			super.render();
		}
		
		protected function setStateSize( state:DisplayObject ) : void
		{
			if (state) {
				state.width = _width;
				state.height = _height;
			}
		}
		
		private function addState(state:DisplayObject) : void
		{
			if (state) {
				removeCurrentState();
				_statesContainer.addChild(state);
			}
		}
		
		private function removeCurrentState():void
		{
			if (_statesContainer.numChildren > 0) _statesContainer.removeChildAt(0);
		}
		
		override public function destroy() : void
		{
			removeEventListeners();
		}
		
	}
	
}