﻿package com.arn.ui{	import com.arn.ui.BaseUIObject;	import flash.display.MovieClip;	import flash.display.SimpleButton;	import flash.events.*;	/**	 * Animated Button	 *  	 * - The 'hitstate' is a SimpleButton that defines the hit area.	 * - The 'states' movieclip contains animation for the following states: 	 * 		"up", "over", "out", "down", "disabled", "active"	 * 	 * @author 	Derrick Williams, Arnold Worldwide	 * @author	http://arnoldworldwide.com/	 * @version 1.0, ActionScript 3.0	 */	public class AnimatedButton extends BaseUIObject	{		// EVENT CONSTANTS --------------------------------				public static const PRESS 		: String = "onPress";		public static const RELEASE 	: String = "onRelease";		public static const ROLL_OVER 	: String = "onRollOver";		public static const ROLL_OUT	: String = "onRollOut";		public static const ACTIVE		: String = "active";		public static const INACTIVE	: String = "inactive";		public static const ENABLED		: String = "enabled";		public static const DISABLED	: String = "disabled";						// PUBLIC PROPERTIES ------------------------------				public var states	: MovieClip;		public var hitstate	: SimpleButton;				// PRIVATE PROPERTIES -----------------------------				private var _active		: Boolean;		 		// CONSTRUCTOR ------------------------------------				public function AnimatedButton(){}						// PROTECTED METHODS ---------------------------------				override public function init() : void		{			/*this.active 			= false;			this.enabled			= true;*/			states.mouseChildren 	= false;			hitstate.useHandCursor 	= true;			addListeners();			draw();		}				override protected function draw() : void {					}		// PUBLIC METHODS ---------------------------------				/**		 * Overrides the BaseUIObject destroy function to get this Animated Button		 * ready for Garbage Collection.		 */		override public function destroy() : void		{			states.stop();			hitstate.removeEventListener( MouseEvent.MOUSE_UP, 		onMouseEvent );			hitstate.removeEventListener( MouseEvent.MOUSE_DOWN, 	onMouseEvent );			hitstate.removeEventListener( MouseEvent.MOUSE_OUT,  	onMouseEvent );			hitstate.removeEventListener( MouseEvent.MOUSE_OVER, 	onMouseEvent );		}								// EVENT LISTENERS --------------------------------				/*		 * Handles the mouse down, over, up, and down events.		 */		private function onMouseEvent( e:Event ) : void 		{			switch(e.type) 			{					case MouseEvent.MOUSE_DOWN:					states.gotoAndPlay("down");					dispatchEvent( new Event( AnimatedButton.PRESS ) );					break;									case MouseEvent.MOUSE_OVER:					states.gotoAndPlay("over");					dispatchEvent( new Event( AnimatedButton.ROLL_OVER ) );					break;									case MouseEvent.MOUSE_UP:					states.gotoAndPlay("over");					dispatchEvent( new Event( AnimatedButton.RELEASE ) );					break;									case MouseEvent.MOUSE_OUT:					var hasOutFrame : Boolean = false;									for (var i in states.currentLabels) {						if (states.currentLabels[i].name == "out") {							hasOutFrame = true;						}					}						if(hasOutFrame)						states.gotoAndPlay("out");					else						states.gotoAndPlay("up");					dispatchEvent( new Event( AnimatedButton.ROLL_OUT ) );					break;			}		}						// PRIVATE METHODS --------------------------------				/*		 * Adds all the event listeners to hitstate object.		 */		private function addListeners() : void 		{			hitstate.addEventListener( MouseEvent.MOUSE_UP, 	onMouseEvent );			hitstate.addEventListener( MouseEvent.MOUSE_DOWN, 	onMouseEvent );			hitstate.addEventListener( MouseEvent.MOUSE_OUT,  	onMouseEvent );			hitstate.addEventListener( MouseEvent.MOUSE_OVER, 	onMouseEvent );		}				// GETTERS/SETTERS --------------------------------				/**		 * Sets the enabled property.		 */		override public function set enabled( enabled:Boolean ) : void		{			super.enabled = enabled;						if (enabled == false) {				hitstate.enabled = false;				removeChild(hitstate);				states.gotoAndPlay("disabled");				dispatchEvent( new Event( AnimatedButton.DISABLED ) );				destroy();			} else {				hitstate.enabled = true;				addChild(hitstate);				states.gotoAndPlay("up");				dispatchEvent( new Event( AnimatedButton.ENABLED ) );				addListeners();			}		}						/**		 * Gets/Sets the active property for this Animated Button.		 */		public function get active() : Boolean 		{			return _active;		}				public function set active( active:Boolean ) : void		{			_active = active;						if (active) {				states.gotoAndPlay("active");				dispatchEvent( new Event( AnimatedButton.ACTIVE ) );				destroy();							} else {				states.gotoAndPlay("up");				dispatchEvent( new Event( AnimatedButton.INACTIVE ) );				addListeners();			}		}	}}