
package com.arn.ui 
{
	import com.arn.ui.BaseUIObject;

	/**
	 * @author Eric Heaton
	 */
	public class SimpleButton extends BaseUIObject 
	{
		public function SimpleButton ()
		{
			super( );
		}
		
		override public function init() : void
		{
			this.buttonMode 	= true;
			this.mouseChildren	= false;	
		}
	}
}
