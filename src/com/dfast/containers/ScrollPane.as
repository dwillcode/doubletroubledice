package com.dfast.containers
{
	import flash.display.*;
	import flash.events.*;
	
	import com.dfast.core.UIObject;
	import com.dfast.controls.ScrollBar;
	
	import com.greensock.TweenLite;
	
	
	/**
	 * @author 	Derrick Williams
	 */
	public class ScrollPane extends UIObject
	{	
		public static var tweenDuration	: Number = 1;
		
		public function set tweenSpeed( tweenSpeed:Number ) : void
		{
			tweenDuration = tweenSpeed;
		}
		
		public function set vScrollBar(value:ScrollBar):void 
		{
			_vScrollBar = value;
			addChild(_vScrollBar);
		}
		
		public function set hScrollBar(value:ScrollBar):void 
		{
			_hScrollBar = value;
			addChild(_hScrollBar);
		}
		
		public function ScrollPane(content:Sprite) 
		{
			_content = content;
			addChild(_content);
			
			if (_width != 0 || _height != 0) {
				_masker = new Sprite();
				_masker.graphics.beginFill(0, 1);
				_masker.graphics.drawRect(0, 0, 10, 10);
				_masker.graphics.endFill();
				_masker.width = _width;
				_masker.height = _height;
				
				_content.mask = _masker;
			}
			
			init();
		}
		
		private var _vScrollBar	: ScrollBar;
		private var _hScrollBar	: ScrollBar;
		private var _content	: Sprite;
		private var _masker		: Sprite;
		
		protected function init() : void
		{	
			_content.mask = _masker;
			if(_vScrollBar)
				_vScrollBar.addEventListener( Event.CHANGE, onVerticalChange ); 
				
			if(_hScrollBar)
				_hScrollBar.addEventListener( Event.CHANGE, onHorizontalChange );
		}
		
		override public function destroy() : void {
			if(!stage){
			if(_vScrollBar)
				_vScrollBar.removeEventListener( Event.CHANGE, onVerticalChange ); 
				
			if(_hScrollBar)
				_hScrollBar.removeEventListener( Event.CHANGE, onHorizontalChange );
			}
			
			super.destroy();
		}
		
		private function onVerticalChange( event:Event ) : void
		{
			var scrollPosition:Number = event.target.scrollPosition;
			var newY:Number	= -scrollPosition * (_content.height - _masker.height);
			TweenLite.to(_content, tweenDuration, {y: newY } );
		}
	
		private function onHorizontalChange( event:Event ) : void
		{
			var scrollPosition:Number = event.target.scrollPosition;
			var newX:Number	= -scrollPosition * (_content.width - _masker.width);
			TweenLite.to(_content, tweenDuration, {x: newX } );
		}
	}
}