package com.dfast.media 
{
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public interface IAudible 
	{
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	volume
		// ---------------------------------------------------------------
		
		function get volume() : Number;
		function set volume( volume:Number ) : void;
		
		// ---------------------------------------------------------------
		//	pan
		// ---------------------------------------------------------------
		
		function get pan() : Number;
		function set pan( pan:Number ) : void;
		
		// ---------------------------------------------------------------
		//	soundTransform
		// ---------------------------------------------------------------
		
		function get soundTransform() : SoundTransform;
		function set soundTransform( transform:SoundTransform ) : void;	
		
	}
	
}