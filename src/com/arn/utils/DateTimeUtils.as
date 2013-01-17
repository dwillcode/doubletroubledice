
package com.arn.utils 
{

	/**
	 * @author Eric Heaton
	 */
	public class DateTimeUtils 
	{
		
		public static var SHORT_FORMAT	: String	= "";
		public static var MEDIUM_FORMAT	: String	= "";
		public static var LONG_FORMAT	: String	= "";
		
		private static var WEEKDAY_NAMES 	: Array = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
		private static var MONTH_NAMES		: Array	= [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		
		public static function format( d : Date, mask : String ) : String
		{
			var str 		: String 	= mask;
			var leadingZero : String	= "";
			
			str = StringUtils.replace( str, "DDDD", String( WEEKDAY_NAMES[ d.day ] ) );
			str = StringUtils.replace( str, "MMMM", String( MONTH_NAMES[ d.month ] ) );
			str = StringUtils.replace( str, "DDD", String( WEEKDAY_NAMES[ d.day ] ).substr( 0, 3 ) );
			str = StringUtils.replace( str, "MMM", String( MONTH_NAMES[ d.month ] ).substr( 0, 3 ) );
			trace( d.getHours() );
			
			if ( mask.indexOf( "MM" ) > -1 && d.month < 10 ) leadingZero = "0";
			else leadingZero = "";
			str = StringUtils.replace( str, "MM",leadingZero + String( d.month ) );
			
			if ( mask.indexOf( "DD" ) > -1 && d.date < 10 ) leadingZero = "0";
			else leadingZero = "";
			str = StringUtils.replace( str, "DD", leadingZero + String( d.date ) );
			str = StringUtils.replace( str, "YYYY", String( d.fullYear ) );
			
			if ( mask.indexOf( "mm" ) > -1 && d.minutes < 10 ) leadingZero = "0";
			else leadingZero = "";
			str = StringUtils.replace( str, "mm", leadingZero + String( d.minutes ) );
			
			if ( mask.indexOf( "hh" ) > -1 && d.hours < 10 ) leadingZero = "0";
			else leadingZero = "";
			str = StringUtils.replace( str, "hh", leadingZero + String( d.hours ) );
			
			if ( mask.indexOf( "ss" ) > -1 && d.seconds < 10 ) leadingZero = "0";
			else leadingZero = "";
			str = StringUtils.replace( str, "ss", leadingZero + String( d.seconds ) );
			
			str = StringUtils.replace( str, "D", String( d.date ) );
			str = StringUtils.replace( str, "M", String( d.month ) );
			str = StringUtils.replace( str, "h", String( d.hours ) );
			str = StringUtils.replace( str, "m", String( d.minutes ) );
			str = StringUtils.replace( str, "s", String( d.seconds ) );
			
			return str;
		}
		
		
	}
}
