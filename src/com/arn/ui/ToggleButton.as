
package com.arn.ui 
{
	import com.arn.ui.BaseUIObject;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Eric Heaton
	 */
	public class ToggleButton extends BaseUIObject 
	{
		
		// CONSTANTS ------------------------------------
		public static const TOGGLE_ON		: String 		= "on";
		public static const TOGGLE_OFF		: String		= "off";
		
		// PRIVATE PROPERTIES ---------------------------
		private var _currState			: String;
		private var _states				: Array;
		// PUBLIC PROPERTIES ----------------------------
		public var state1				: MovieClip;
		public var state2				: MovieClip;
		
		public function ToggleButton ()
		{
			super( );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Metods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  init
		//--------------------------------------------------------------------------
		
		override public function init() : void
		{
			if ( !_currState ) _currState = ToggleButton.TOGGLE_OFF;
			
			_states = [];
			_states[ TOGGLE_OFF ] = state1;
			_states[ TOGGLE_ON ] = state2;	
			
			
			state1.mouseChildren = false;
			state2.mouseChildren = false;
			
			state1.buttonMode = true;
			state2.buttonMode = true;
			
			state1.addEventListener( MouseEvent.CLICK, toggleState );
			state2.addEventListener( MouseEvent.CLICK, toggleState );
			
			render();
		}
		
		//--------------------------------------------------------------------------
		//  reset
		//--------------------------------------------------------------------------
		
		public function reset() : void
		{
			
		}
		
		
		//--------------------------------------------------------------------------
		//  destroy
		//--------------------------------------------------------------------------
		
		override public function destroy() : void
		{
			state1.removeEventListener( MouseEvent.CLICK, toggleState);
			state2.removeEventListener( MouseEvent.CLICK, toggleState);
				
		}
		
		//--------------------------------------------------------------------------
		//  getState
		//--------------------------------------------------------------------------
		
		/**
		 * @return String The current state of the button
		 */
		public function getState() : String
		{
			return _currState;
		}
		
		public function setState( str : String ) : void
		{
			_currState = str;
		
			render();	
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  toggleState
		//--------------------------------------------------------------------------
		
		private function toggleState( $event : MouseEvent ) : void
		{
			for ( var s : String in _states ) {
				if ( $event.currentTarget != _states[ s ] ) {
					_currState = s;
					break;
				}
			}
			
			dispatchEvent( new ToggleButtonEvent( _currState ) );
			render();
		}
		
		//--------------------------------------------------------------------------
		//  render
		//--------------------------------------------------------------------------
		
		private function render() : void
		{
			for ( var s : String in _states ) {
				if ( _currState == s  ) {
					_states[ s ].visible = true;
				} else {
					_states[ s ].visible = false;
				}
			}
		}

		
		public function setStates ( $state : String, $mc : MovieClip ) : void
		{
			_states[ $state ] = $mc;
		}
	}
}
