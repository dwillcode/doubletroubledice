package com.dfast.controls 
{
	import com.dfast.core.UIObject;
	import com.dfast.styles.StyleFormat;
	
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextFormatAlign;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class Label extends UIObject
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		/**
		 * Creates an new instance of the Label.
		 */
		public function Label() 
		{
			super();
			
			_defaultText = "";
			_isHtmlText = false;
			
			textField = new TextField();
			textField.name = "textfield";
			addChild( textField );
			
			_textFormat = new TextFormat();
			textField.defaultTextFormat = _textFormat;
			
			// set defaults
			antiAliasType = AntiAliasType.NORMAL;
			autoSize = TextFieldAutoSize.LEFT;
			blockIndent = 0 ;
			color = 0x000000;
			var operatingSystem : String = Capabilities.os.toLowerCase();
			fontFamily = (operatingSystem.indexOf("mac") == -1) ? "Times New Roman" : "Times";
			fontSharpness = 0;
			fontSize = 12;
			fontStyle = "normal";
			fontThickness = 0;
			fontWeight : "normal";
			kerning = false;
			leading = 0;
			letterSpacing  = 0;
			marginLeft = 0;
			marginRight = 0;
			mouseWheelEnabled = true;
			multiline = false;
			selectable = true;
			textAlign = TextFormatAlign.LEFT;
			textDecoration = "none";
			textIndent = 0;
			wordWrap = false;
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		protected var _text : String;
		protected var _defaultText : String;
		protected var _embedFonts : Boolean;
		protected var _htmlText : String;
		protected var _isHtmlText : Boolean;
		protected var _textFormat : TextFormat;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		public var antiAliasType : String;
		public var autoSize : String;
		public var blockIndent : Number;
		public var color : Number;
		public var fontFamily : String;
		public var fontSharpness : Number;
		public var fontSize : Number;
		public var fontStyle : String;
		public var fontThickness : Number;
		public var fontWeight : String;
		public var kerning : Boolean;
		public var leading : Number;
		public var letterSpacing : Number;
		public var marginLeft : Number;
		public var marginRight : Number;
		public var mouseWheelEnabled : Boolean;
		public var multiline : Boolean;
		public var selectable : Boolean;
		public var textAlign : String;
		public var textDecoration : String;
		public var textIndent : Number;
		public var wordWrap : Boolean;
		
		// ---------------------------------------------------------------
		//	embedFonts
		// ---------------------------------------------------------------
		
		public function get embedFonts():Boolean { return _embedFonts; }
		
		public function set embedFonts(value:Boolean):void 
		{
			_embedFonts = value;
			textField.embedFonts = value;
		}
		
		// ---------------------------------------------------------------
		//	defaultText
		// ---------------------------------------------------------------
		
		public function get defaultText():String { return _defaultText; }
		
		public function set defaultText(value:String):void 
		{
			_defaultText = value;
		}
		
		// ---------------------------------------------------------------
		//	htmlText
		// ---------------------------------------------------------------
		
		public function get htmlText():String { return _htmlText; }
		
		public function set htmlText(value:String):void 
		{
			_htmlText = value;
			_isHtmlText = true;
		}
		
		// ---------------------------------------------------------------
		//	text
		// ---------------------------------------------------------------
		
		public function get text():String { return _text; }
		
		public function set text(value:String):void 
		{
			_text = value;
			_isHtmlText = false;
		}
		
		// ---------------------------------------------------------------
		//	textField
		// ---------------------------------------------------------------
		
		public var textField : TextField;
		
		// ---------------------------------------------------------------
		//	textFormat
		// ---------------------------------------------------------------
		
		public function get textFormat() : TextFormat { return textField.getTextFormat(); }
		
		// ---------------------------------------------------------------
		//	textHeight
		// ---------------------------------------------------------------
		
		public function get textHeight() : Number { return textField.textHeight; }
		
		// ---------------------------------------------------------------
		//	textWidth
		// ---------------------------------------------------------------
		
		public function get textWidth() : Number { return textField.textWidth; }
		
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	applyProperties
		// ---------------------------------------------------------------
		
		protected function applyProperties() : void
		{	
			// text field properties
			textField.antiAliasType = antiAliasType;
			textField.autoSize		= autoSize;
			textField.sharpness		= fontSharpness;
			textField.thickness		= fontThickness;
			textField.selectable	= selectable;
			textField.wordWrap		= wordWrap;
			
			// text format properties
			_textFormat.align			= textAlign;
			_textFormat.bold			= ( fontWeight == "bold" ) ? true : false;
			_textFormat.blockIndent 	= blockIndent;
			_textFormat.color			= color;
			_textFormat.font			= fontFamily;
			_textFormat.italic			= ( fontStyle == "italic" ) ? true : false;
			_textFormat.kerning			= kerning;
			_textFormat.leading			= leading;
			_textFormat.leftMargin		= marginLeft;
			_textFormat.letterSpacing 	= letterSpacing;
			_textFormat.rightMargin		= marginRight;
			_textFormat.size			= fontSize;
			_textFormat.underline		= ( textDecoration == "underline" ) ? true : false;
			
			textField.setTextFormat( _textFormat );
		}
		
		// ---------------------------------------------------------------
		//	render
		// ---------------------------------------------------------------
		
		/**
		 * @overridden
		 */
		override public function render() : void
		{	
			textField.width		= (_width) ? _width : textField.width;
			textField.height	= (_height) ? _width : textField.height;
			
			if(_isHtmlText) textField.htmlText = (_htmlText) ? _htmlText : _defaultText;
			else textField.text = (_text) ? _text : _defaultText;
			
			applyProperties();
			
			super.render();
		}
	}
	
}