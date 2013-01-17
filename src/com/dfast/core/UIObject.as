package com.dfast.core 
{
	import com.dfast.styles.IStyleable;
	import com.dfast.styles.StyleFormat;
	import flash.display.DisplayObjectContainer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class UIObject extends Sprite implements IUIObject
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates a new UIObject instance.
		 */
		public function UIObject() 
		{
			super();
			
			_styleFormat 	= new StyleFormat();
			_isAddedToStage = false;
			_scale			= 1;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		protected var _styleFormat 		: StyleFormat;
		protected var _width 			: uint;
		protected var _height 			: uint;
		protected var _scale 			: Number;
		protected var _isAddedToStage 	: Boolean;
		protected var _x 				: Number;
		protected var _y 				: Number;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	bottom
		// ---------------------------------------------------------------
		
		public function get bottom() : Number { return this.y + this.height; }
		
		// ---------------------------------------------------------------
		//	isAddedToStage
		// ---------------------------------------------------------------
		
		public function get isAddedToStage():Boolean { return _isAddedToStage; }
		
		// ---------------------------------------------------------------
		//	right
		// ---------------------------------------------------------------
		
		public function get right() : Number { return this.x + this.width; }
		
		// ---------------------------------------------------------------
		//	scale
		// ---------------------------------------------------------------
		
		public function get scale():Number { return _scale; }
		
		public function set scale( value:Number ):void 
		{
			_scale = value;
			
			invalidate();
		}
		
		// ---------------------------------------------------------------
		//	styleFormat
		// ---------------------------------------------------------------
		
		public function get styleFormat():StyleFormat { return _styleFormat; }
		
		public function set styleFormat( value:StyleFormat ):void 
		{
			_styleFormat = value;
			
			for (var propertyName:String in _styleFormat.properties) {
				if ( Object(this).hasOwnProperty( propertyName ) ) {					
					switch( propertyName ) {	
						case "width": _width =  _styleFormat.properties[ "width" ]; break;
						case "height": _height =  _styleFormat.properties[ "height" ]; break;
						default: this[ propertyName ] = _styleFormat.properties[ propertyName ]; break;
					}		
				}
			}
		}
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		public function centerToStage() : void
		{
			var x:Number = 0;
			var y:Number = 0;
			var parent:DisplayObjectContainer = this.parent;
			trace( parent + ", width: " + parent.width);
			trace( stage + ", width: " + stage.stageWidth);
			trace( this + ", width: " + this.width);
			
			var parentWidth : Number = ( parent == stage ) ? stage.stageWidth : parent.width;
			var parentHeight : Number = ( parent == stage ) ? stage.stageHeight : parent.height;
			
			x = ( parentWidth / 2 )  - ( this.width  / 2 );
			y = ( parentHeight / 2 ) - (this.height  / 2);
			
			trace( this + ", x: " + x );
			
			move( x, y );
		}
		
		// ---------------------------------------------------------------
		//	clone
		// ---------------------------------------------------------------
		
		public function clone() : UIObject
		{
			try {
				var uiObjectClass : Class = Object( this ).constructor as Class;
				var uiObjectClone : UIObject = new uiObjectClass();
			} catch ( error:TypeError ) {
				trace("Couldn't clone " + this + "!");
			}
			
			return uiObjectClone;
		}
		
		// ---------------------------------------------------------------
		//	destroy
		// ---------------------------------------------------------------
		
	    public function destroy() : void
	    {
	        // Warning is raised if subclass doesn't not override destroy()
	        throw new Error( "WARNING: " + this + " did not override destroy()" )
	 
	        // suspend component here.
	    }
		
		// ---------------------------------------------------------------
		//	destroyAllChildren
		// ---------------------------------------------------------------
		
		public function destroyAllChildren() : void
		{
			for ( var i:int = 0; i < this.numChildren; i++) {
				if ( this.getChildAt(i) is IUIObject ) (this.getChildAt(i) as IUIObject).destroy();
			}
		}
		
		// ---------------------------------------------------------------
		//	invalidate
		// ---------------------------------------------------------------
	 
		protected function invalidate() : void
		{
			addEventListener( Event.ENTER_FRAME, onInvalidate, false, 0, true );
		}
		
		// ---------------------------------------------------------------
		//	move
		// ---------------------------------------------------------------
		
		public function move( x:Number, y:Number ) : void
		{
			_x = x;
			_y = y;
			
			if(isAddedToStage) invalidate();
		}
		
		// ---------------------------------------------------------------
		//	render
		// ---------------------------------------------------------------
		
		public function render() : void
		{
			this.x = (_x) ? _x : this.x;
			this.y = (_y) ? _y : this.y;
			
			this.scaleX = _scale;
			this.scaleY = _scale;
			
			dispatchEvent( new Event( Event.RENDER ) );
		}
		
		// ---------------------------------------------------------------
		//	setSize
		// ---------------------------------------------------------------
		
		public function setSize( width:uint, height:uint ) : void
		{
			_width = width;
			_height = height;
			
			if( isAddedToStage ) invalidate();
		}
	
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onAddedToStage
		// ---------------------------------------------------------------
		
		protected function onAddedToStage( event:Event ) : void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			_isAddedToStage = true;
			invalidate();
		}
		
		// ---------------------------------------------------------------
		//	onInvalidate
		// ---------------------------------------------------------------
		
		private function onInvalidate( event:Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, onInvalidate );
	        render();
		}
		
		// ---------------------------------------------------------------
		//	onRemovedFromStage
		// ---------------------------------------------------------------
		
		private function onRemovedFromStage( event:Event ):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			removeEventListener( Event.ENTER_FRAME, onInvalidate );
	        removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	        removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
	        destroy();
		}
		
	}
	
}