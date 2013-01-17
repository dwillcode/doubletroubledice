﻿package com.arn.ui {		import flash.events.*;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.SimpleButton;	import flash.text.TextField;		import gs.TweenLite;		/**	 * Labeled Button	 *  	 * - The 'hitstate' is a SimpleButton that defines the hit area.	 * - The 'states' movieclip contains animation for the following states: 	 * 		"up", "over", "out", "down", "disabled", "active"	 * 	 * @author 	Derrick Williams, Arnold Worldwide	 * @author	http://arnoldworldwide.com/	 * @version 1.0, ActionScript 3.0	 */	public class LabeledButton extends AnimatedButton {		// EVENT CONSTANTS --------------------------------				// PUBLIC PROPERTIES ------------------------------		public var txt:TextField;				// PRIVATE PROPERTIES -----------------------------		private var _autoSize	: Boolean;		private var _label		: String;		 		// CONSTRUCTOR ------------------------------------				public function LabeledButton() {			super();			// set _label before it drawn from the Super classes constructor			_label = (txt.text) ? txt.text : "";			_autoSize = false;			txt.autoSize = "left";			buttonMode = true;		}				// PROTECTED METHODS ---------------------------------		override protected function draw() : void {			txt.text = _label;						if(_autoSize) {				txt.mouseEnabled = false;				states.width = (2 * txt.x ) + txt.width;				//hitstate.hitTestState.width = states.width;				var shape : Shape = new Shape();				shape.graphics.lineStyle( 1, 0x000000, 1);				shape.graphics.beginFill(0x000000);				shape.graphics.drawRect(0,0,states.width,states.height);				shape.graphics.endFill();								hitstate.hitTestState 	= shape;				hitstate.scaleX 		= 1;				hitstate.scaleY 		= 1;			}		}				// GETTERS/SETTERS --------------------------------		public function get label(): String { return _label; }		public function set label(value:String):void  {			_label = value;			draw();		}				public function get autoSize(): Boolean { return _autoSize; }		public function set autoSize(value:Boolean):void {			_autoSize = value;		}	}}