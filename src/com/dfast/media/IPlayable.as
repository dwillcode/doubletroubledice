package com.dfast.media 
{
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public interface IPlayable 
	{
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		function get duration() : Number;
		function get position() : Number;
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		function start() : void;
		function seek( offset:Number ) : void;
		function stop() : void;
		function pause( pause:Boolean ) : void;
		
	}
	
}