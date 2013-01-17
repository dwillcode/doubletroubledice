package com.arn.ui {
	import flash.display.*;
	import flash.events.*;
	import gs.TweenLite;
	
	/**
	 * Vertical Scroll Bar
	 * 
	 * - The 'thumb' is a MovieClip that controls the scrollbar
	 * - The 'track' is a MovieClip that sets the bounds for the scrollbar
	 * 
	 * @author 	Derrick Williams, Arnold Worldwide
	 * @author	http://arnoldworldwide.com/
	 * @version 1.0, ActionScript 3.0
	 */
	public class VScrollBar extends BaseUIObject implements IScrollBar{
		// PRIVATE PROPERTIES -----------------------------
		private var _yMin	: Number;
		private var _yMax	: Number;
		private var _yOffset: Number;		
		
		// PUBLIC PROPERTIES ------------------------------
		public var thumb	: MovieClip;
		public var track	: MovieClip;
		
		// CONSTRUCTOR ------------------------------------
		public function VScrollBar(){}
		
		// PUBLIC METHODS ---------------------------------
		override public function init() : void {	
			_yMin = track.y;
			_yMax = track.y + track.height - thumb.height;
			thumb.buttonMode = true;
			
			addEventListener( MouseEvent.MOUSE_WHEEL, onMouseMove );
			thumb.addEventListener( MouseEvent.MOUSE_DOWN, onThumbDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onThumbUp );
		}
		
		/**
		 * Moves the thumb to the given value along the track.
		 * If animate is true, then the thumb will tween to the
		 * given value.
		 * 
		 * @param	value	The position of the thumb.
		 * @param	animate	If true, the thumb will tween to the value.
		 */
		public function moveThumb( value:Number, animate:Boolean = false ) : void {
			if(!animate){
				thumb.y = value;
				
				// Make sure thumb doesn't pass the track bounds
				if (thumb.y <= _yMin)
					thumb.y = _yMin;
				if (thumb.y >= _yMax)
					thumb.y = _yMax;
					
				update();
			} else {
				TweenLite.to( thumb, .5, {y: value, onUpdate: update} );
			}
		}
		
		override public function destroy() : void {
			if(!stage){
			removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseMove );
			thumb.removeEventListener( MouseEvent.MOUSE_DOWN, onThumbDown );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onThumbUp );
			}
		}
		
		// PRIVATE METHODS --------------------------------
		
		/*
		 * Dispatches the Scroll Bar event when the thumb is moved.
		 */
		private function update() : void {
			dispatchEvent( new ScrollBarEvent( ScrollBarEvent.CHANGE, ( thumb.y / _yMax) ) );
		}
		
		// EVENT LISTENERS --------------------------------
	
		/*
		 * Handles the mouse down event for the thumb.
		 */
		private function onThumbDown( e:MouseEvent ) : void {
			_yOffset = thumb.y - mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		/*
		 * Handles the mouse up event when the thumb is released.
		 */
		private function onThumbUp( e:MouseEvent ) : void {
			if (stage)
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		/*
		 * Handles the mouse move event while the thumb is pressed.
		 */
		private function onMouseMove( e:MouseEvent ) : void {
			var newY : Number = ( e.type == MouseEvent.MOUSE_WHEEL ) ? (thumb.y - e.delta) : (_yOffset + mouseY);
			moveThumb( newY );
			e.updateAfterEvent();
		}
	}
}