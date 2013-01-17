package com.arn.utils
{
	/**
	 * MathUtils
	 * Class that contains static functions that manipulate numbers.
	 * 
	 * @author 	Derrick Williams, Arnold Worldwide
	 * @author	http://arnoldworldwide.com/
	 * @version 1.0, ActionScript 3.0
	 */
	public class  MathUtils
	{
		/**
		 * Generates a number between a given range.
		 * @param	pMin	The lowest number to be used in the range of numbers.
		 * @param	pMax	The highest number to be used in the range of numbers.
		 * @return	A number within the given range of the min and max.
		 */
		public static function randRange( pMin:Number, pMax:Number ) : Number 
		{
			var randomNum:Number = Math.floor(Math.random() * (pMax - pMin + 1)) + pMin;
			return randomNum;
		}
		
		/**
		 * Determines if a given number is a prime number. 
		 * @param	pNum	The number to be tested.
		 * @return	True if the number is a prime number, false uf otherwise.
		 */
		public static function isPrime( pNum:Number ) : Boolean
		{
			if (pNum < 2){
				return false;
			} else {
				for (var i:uint = 2; i < pNum; i++)
				{
					if ((pNum % i) == 0) return false;
				}
				return true;
			}
		}
		
		/**
		 * Generates a prime number between a given range.
		 * @param	pMin	The lowest number to be used in the range of numbers.
		 * @param	pMax	The highest number to be used in the range of numbers.
		 * @return	A prime number within the given range of the min and max.
		 */
		public static function randPrime( pMin:Number, pMax:Number ) : Number 
		{
			var randomNumber:Number = randRange(pMin, pMax);
			
			if(isPrime(randomNumber)) {
				return randomNumber;
			} else {
				return randPrime(pMin, pMax);
			}
		} 
		
		/**
		 * Checks if a number is within a given range.
		 * @param	val	The number to check.
		 * @param	min	The lowest number to be used in the range of numbers.
		 * @param	max	The highest number to be used in the range of numbers.
		 * @return	True if the number is within the range, flase otherwise.
		 */
		public static function checkRange( val : Number, min : Number, max : Number ) : Boolean
		{
			if ( val > min && val < max ) return true;
			else return false;
		}
		
		
		public static function deg2Rad( angle : Number ) : Number
		{
			
			return angle * Math.PI / 180;
		}
	}
}