package com.arn.ui
{
	import flash.display.*;
	import flash.events.*;
	import gs.TweenLite;
	
	/**
	 * Scroll Box
	 * A class that represents a movie clip thats scrolls 
	 * controlled by a scroll bar.
	 * 
	 * @author 	Derrick Williams, Arnold Worldwide
	 * @author	http://arnoldworldwide.com/
	 * @version 1.0, ActionScript 3.0
	 */
	public class ScrollBox extends BaseUIObject
	{	
		// PRIVATE PROPERTIES -----------------------------
		
		private var _tweenSpeed	: Number; 	// Time it takes content to move
		
		
		// CONSTRUCTOR ------------------------------------
		
		public function ScrollBox(){}
		
		// PUBLIC PROPERTIES ------------------------------
		
		public var vScrollBar	: IScrollBar;
		public var hScrollBar	: IScrollBar;
		public var content		: MovieClip;
		public var masker		: MovieClip;
		
		// PRIVATE METHODS --------------------------------
		
		override public function init() : void
		{	
			_tweenSpeed = 1;
			content.mask = masker;	
			if(vScrollBar)
				vScrollBar.addEventListener( ScrollBarEvent.CHANGE, onVerticalChange ); 
				
			if(hScrollBar)
				hScrollBar.addEventListener( ScrollBarEvent.CHANGE, onHorizontalChange );
		}
		
		override public function destroy() : void {
			if(!stage){
			if(vScrollBar)
				vScrollBar.removeEventListener( ScrollBarEvent.CHANGE, onVerticalChange ); 
				
			if(hScrollBar)
				hScrollBar.removeEventListener( ScrollBarEvent.CHANGE, onHorizontalChange );
			}
		}
		
		
		// EVENT LISTENERS --------------------------------
		
		/*
		 * Handles the change event for the vertical scroll bar.
		 */
		private function onVerticalChange( e:ScrollBarEvent ) : void
		{
			var sp:Number = e.scrollPercent;
			var newY:Number	= -sp * (content.height - masker.height);
			TweenLite.to(content, _tweenSpeed, {y: newY } );
		}
		
		/*
		 * Handles the change event for the horizontal scroll bar.
		 */
		private function onHorizontalChange( e:ScrollBarEvent ) : void
		{
			var sp:Number = e.scrollPercent;
			var newX:Number	= -sp * (content.width - masker.width);
			TweenLite.to(content, _tweenSpeed, {x: newX } );
		}
		
		
		// GETTERS/SETTERS -----------------------------
		
		/**
		 * Sets the tween speed (transition time) for the content.
		 */
		public function set tweenSpeed( tweenSpeed:Number ) : void
		{
			_tweenSpeed = tweenSpeed;
		}
	}
}