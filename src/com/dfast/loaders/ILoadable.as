package com.dfast.loaders 
{
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public interface ILoadable 
	{
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		function load( url:String ) : void;
		
	}
	
}