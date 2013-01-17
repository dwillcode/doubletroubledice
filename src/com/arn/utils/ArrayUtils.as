﻿	package com.arn.utils{	public class ArrayUtils {				public static function randomItem( arr : Array ) : Object		{			return arr[ randomIndex( arr ) ];		}						public static function randomIndex( arr : Array ) : Number		{					return Math.round( Math.random() * ( arr.length-1 ) );		}				public static function randomize( arr : Array ) : Array		{			var new_arr : Array = [];						while ( arr.length > 0 ) {				new_arr.push( arr.splice( randomIndex( arr ), 1 ) );			}						return new_arr;		}				public static function swapElements( arr : Array, pos1 : Number, pos2 : Number ) : Array		{			var tmp1 : Object = arr[ pos1 ];			var tmp2 : Object = arr[ pos2 ];						arr[ pos1 ] = tmp2;			arr[ pos2 ] = tmp1;						return arr;		}				public static function equals( arrayA:Array, arrayB:Array, bNotOrdered:Boolean ) : Boolean 		{					// If the two arrays don't have the same number of elements,			// they obviously are not equivalent.			if(arrayA.length != arrayB.length) {				return false;			}					// Create a copy of each so that anything done to the copies 			// doesn't affect the originals.			var arrayACopy:Array = arrayA.concat(  );			var arrayBCopy:Array = arrayB.concat(  );					// If the order of the elements of the two arrays doesn't 			// matter, sort the two copies so the order of the copies 			// matches when comparing.			if(bNotOrdered) {				arrayACopy.sort(  );				arrayBCopy.sort(  );			}					// Loop through each element of the arrays, and compare them. 			// If they don't match, delete the copies and return false.			for(var i:int = 0; i < arrayACopy.length; i++) {				if(arrayACopy[i] != arrayBCopy[i]) {					//delete arrayACopy;					//delete arrayBCopy;					return false;				}			}					// Otherwise the arrays are equivalent. 			// So delete the copies and return true.			//delete arrayACopy;			//delete arrayBCopy;			return true;		}		public static function arrayContainsValue(arr:Array, value:Object):Boolean		{			return (arr.indexOf(value) != -1);		}					/**		*	Remove all instances of the specified value from the array,		* 		* 	@param arr The array from which the value will be removed		*		*	@param value The object that will be removed from the array.		*		* 	@langversion ActionScript 3.0		*	@playerversion Flash 9.0		*	@tiptext		*/				public static function removeValueFromArray(arr:Array, value:Object):void		{			var len:uint = arr.length;						for(var i:Number = len; i > -1; i--)			{				if(arr[i] === value)				{					arr.splice(i, 1);				}			}							}		/**		*	Create a new array that only contains unique instances of objects		*	in the specified array.		*		*	Basically, this can be used to remove duplication object instances		*	from an array		* 		* 	@param arr The array which contains the values that will be used to		*	create the new array that contains no duplicate values.		*		*	@return A new array which only contains unique items from the specified		*	array.		*		* 	@langversion ActionScript 3.0		*	@playerversion Flash 9.0		*	@tiptext		*/			public static function createUniqueCopy(a:Array):Array		{			var newArray:Array = new Array();						var len:Number = a.length;			var item:Object;						for (var i:uint = 0; i < len; ++i)			{				item = a[i];								if(ArrayUtils.arrayContainsValue(newArray, item))				{					continue;				}								newArray.push(item);			}						return newArray;		}			} }