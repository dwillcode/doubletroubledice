/**
* Dice by Edgars Simsons. March 13, 2009
*
* Copyright (c) 2009 Edgars Simsons
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

package com.doubletroubledice.ui
{
	//import caurina.transitions.Tweener;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import net.badimon.five3D.display.Bitmap3D;
	import net.badimon.five3D.display.Graphics3D;
	import net.badimon.five3D.display.Scene3D;
	import net.badimon.five3D.display.Shape3D;
	import net.badimon.five3D.display.Sprite3D;
	import net.badimon.five3D.geom.Matrix3D;
	import net.badimon.five3D.geom.Point3D;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Dice ©2009 Edgars Simsons, edzis.wordpress.com
	 * Licensed under the MIT license. See the source file header for more information.
	 * <hr>
	 * 3D dice with rounded edges that has a dynamic rotation animation to the next score.
	 * The following libraries are used:
	 * - FiVe3D v.2.1.1 @link http://five3d.mathieu-badimon.com/
	 * - Tweener @link http://code.google.com/p/tweener/
	 * Note that FiVe3D requires @see fl.motion.Color to be included in the classpath. You migh want to include C:\Program Files\Adobe\Adobe Flash CS3\en\Configuration\ActionScript 3.0\Classes
	 * If you use or extend it, please, show it to me.
	 *
	 * @author Edgars Simsons, http://edzis.wordpress.com, simsons.edgars{in}gmail.com
	 * @version 1.0
	 */
	public class Dice extends Sprite {
		/**
		 * Width, height and depth of the dice
		 */
		private const SIZE					:int = 100;
		
		/**
		 * The dice can be wiewed from a particular angle
		 */
		private const DEFAULT_ROTATION_X	:int = 0;
		private const DEFAULT_ROTATION_Y	:int = 0;
		
		
		/**
		 * The dice can be wiewed from a particular camera position relative to the dice center
		 */
		private const CAMERA_X			:int = 0;
		private const CAMERA_Y			:int = 0;
		private const CAMERA_Z			:int = 600;
		
		/**
		 * Manipulates the ambient light direction vector. Used to have a slight shadow on the side of the dice when viewing iot from the side
		 */
		private const LIGHT_OFFSET_X	:int = 20;
		
		public static const ROLL_COMPLETE :String = "diceRollComplete";
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var radius:Number = 60;
		public var mass:Number = 2;
		
		public var rotationDuration:Number = 2;

		
		private const MIN_ROTATION_COUNT	:int = 2;
		private const MAX_ROTATION_COUNT	:int = 1;
		private const BOX_WIDTH				:int = 160;
		private const BOX_HEIGHT			:int = 160;
		
		private const CIRCLE_RADIUS	:int = 7;
		
		private var _score	:int;
		private var _starAnimation:StarAnimation;
		
		private var scene:Scene3D;
		private var dice:Sprite3D;
		private var face:Shape3D;
		private var logo:Bitmap3D;
		private var endRotations	:Array = [];
		
		public function Dice():void {
			build();
		}
		
		/**
		 * Makes the dice roll to a new score. Mouse position adds slight changes to the rotation directions and ammount.
		 * @param	score Gives opportunity to force a particular score. If not set in the valid range of [1;6] it is generated on random. @default -1
		 */
		public function roll(score:int = -1):void {
			_score = (score >= 1 && score <= 6)? score : Math.ceil(Math.random() * 6);
			var mousePosX:Number = (mouseX < -BOX_WIDTH/2)? -BOX_WIDTH/2 : (mouseX > BOX_WIDTH/2)? BOX_WIDTH/2 : mouseX;
			var mousePosY:Number = (mouseY < -BOX_HEIGHT/2)? -BOX_HEIGHT/2 : (mouseY > BOX_HEIGHT/2)? BOX_HEIGHT/2 : mouseY;
			var rotCountX:int = (mousePosY - BOX_HEIGHT / 2) / BOX_HEIGHT * 2 * MAX_ROTATION_COUNT;
			var rotCountY:int = (mousePosX - BOX_WIDTH / 2) / BOX_WIDTH * 2 * MAX_ROTATION_COUNT;
			var rotCountZ:int = Math.round(-MIN_ROTATION_COUNT/2 + Math.random() * MIN_ROTATION_COUNT);
			rotCountX = (rotCountX > 0)? rotCountX + MIN_ROTATION_COUNT: rotCountX - MIN_ROTATION_COUNT;
			rotCountY = (rotCountY > 0)? rotCountY + MIN_ROTATION_COUNT: rotCountY - MIN_ROTATION_COUNT;
			
			var targetRotation:Point = endRotations[_score] as Point;
			TweenLite.to(dice, rotationDuration, { rotationX:360 * rotCountX + targetRotation.x, 
									rotationY:360 * rotCountY + targetRotation.y, 
									rotationZ:360 * rotCountZ,
									ease: Circ.easeOut,
									onComplete:animationCompleteHandler } );
		}
		
		
		private function build():void {
			_starAnimation = new StarAnimation();
			addChild(_starAnimation);
			
			scene = new Scene3D();
			scene.x = CAMERA_X;
			scene.y = CAMERA_Y;
			scene.viewDistance = CAMERA_Z;
			scene.ambientLightVector = new Point3D(-CAMERA_X + LIGHT_OFFSET_X, 80-CAMERA_Y, 0);
			scene.ambientLightIntensity = 0.2;
			addChild(scene);
			
			var transformContainer:Sprite3D = new Sprite3D();
			transformContainer.rotationX = DEFAULT_ROTATION_X;
			transformContainer.rotationY = DEFAULT_ROTATION_Y;
			transformContainer.x = -CAMERA_X;
			transformContainer.y = -CAMERA_Y;
			scene.addChild(transformContainer);
			
			
			dice = new Sprite3D();
			dice.childrenSorted = true;
			dice.scaleX = dice.scaleY = dice.scaleZ = SIZE/100;
			transformContainer.addChild(dice);
			
			var j:int;
			var jj:int;
			
			//	ROUNDED CORNERS
			for (j = 0; j < 4; j++) {
				for (jj = 0; jj < 2; jj++) {
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(45, -45, -50);
					face.graphics3D.lineToSpace(45, -48.5, -48.5);
					face.graphics3D.lineToSpace(48.5, -45, -48.5);
					face.graphics3D.lineToSpace(45, -45, -50);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					dice.addChild(face);
					
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(45, -48.5, -48.5);
					face.graphics3D.lineToSpace(45, -50, -45);
					face.graphics3D.lineToSpace(48.5, -48.5, -45);
					face.graphics3D.lineToSpace(45, -48.5, -48.5);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					dice.addChild(face);
					
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(48.5, -45, -48.5);
					face.graphics3D.lineToSpace(48.5, -48.5, -45);
					face.graphics3D.lineToSpace(50, -45, -45);
					face.graphics3D.lineToSpace(48.5, -45, -48.5);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					dice.addChild(face);
					
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(45, -48.5, -48.5);
					face.graphics3D.lineToSpace(48.5, -45, -48.5);
					face.graphics3D.lineToSpace(48.5, -48.5, -45);
					face.graphics3D.lineToSpace(45, -48.5, -48.5);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					dice.addChild(face);
				}
			}
			
			//	ROUNDED EDGES
			for (j = 0; j < 4; j++) {
				for (jj = 0; jj < 3; jj++) {
				//	RECT ABOWE	
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(45,-48.5, -48.5);
					face.graphics3D.lineToSpace(45,-50, -45);
					face.graphics3D.lineToSpace(-45,-50, -45);
					face.graphics3D.lineToSpace(-45,-48.5, -48.5);
					face.graphics3D.lineToSpace(45,-48.5, -48.5);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					face.rotationZ = (jj == 2)? 90 : 0;
					dice.addChild(face);
					
					face = new Shape3D();
					face.graphics3D.beginFill(0xFFFFFF, 1);
					face.graphics3D.moveToSpace(-45,-45, -50);
					face.graphics3D.lineToSpace(45, -45, -50);
					face.graphics3D.lineToSpace(45,-48.5, -48.5);
					face.graphics3D.lineToSpace(-45,-48.5, -48.5);
					face.graphics3D.lineToSpace(-45,-45, -50);
					face.graphics3D.endFill();
					face.rotationY = j * 90;
					face.rotationX = (jj == 1)? 180 : 0;
					face.rotationZ = (jj == 2)? 90 : 0;
					dice.addChild(face);
				}
			}
			
			//	FACES
			for (var i:int = 0; i < 6; i++) {
				
				switch(i + 1) {
					case 1:
						logo = new Bitmap3D(new JokerImage(90,90), true);
						logo.singleSided = true;
						logo.flatShaded = true;
						logo.x = -45;
						logo.y = -45;
						dice.addChild(logo);
						break;
						
					case 6:
						logo = new Bitmap3D(new GSNLogoImage(90,90), true);
						logo.singleSided = true;
						logo.flatShaded = true;
						logo.x = 45;
						logo.y = -45;
						dice.addChild(logo);
						break;
						
					default:
						face = new Shape3D();
						face.singleSided = true;
						face.flatShaded = true;
						face.graphics3D.beginFill(0xFFFFFF);
						face.graphics3D.drawRect( -45, -45, 90, 90);
						face.graphics3D.endFill();
						dice.addChild(face);
						break;
				}
				
					
				
				switch (i+1) {
					case 1: //	FRONT
						/*face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(0, 0, CIRCLE_RADIUS);
						face.graphics3D.endFill();*/
						break;
						
					case 2: //	LEFT
						face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(-12.5, 12.5, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(12.50, -12.5, CIRCLE_RADIUS);
						face.graphics3D.endFill();
						break;
						
					case 3:	//	BOTTOM
						face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(-20, 20, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(0, 0, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(20, -20, CIRCLE_RADIUS);
						face.graphics3D.endFill();
						break;
						
					case 4:	//	TOP
						face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(-18, -18, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(-18, 18, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(18, -18, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(18, 18, CIRCLE_RADIUS);
						face.graphics3D.endFill();
						break;
						
					case 5:	//	RIGHT
						face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(-20, -20, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(-20, 20, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(0, 0, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(20, -20, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(20, 20, CIRCLE_RADIUS);
						face.graphics3D.endFill();
						break;
						
					case 6:	//	BACK
						/*face.graphics3D.beginFill(0x000000);
						face.graphics3D.drawCircle(-16, -30, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(-16, 0, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(-16, 30, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(16, -30, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(16, 0, CIRCLE_RADIUS);
						face.graphics3D.drawCircle(16, 30, CIRCLE_RADIUS);
						face.graphics3D.endFill();*/
						break;
				}
				
				switch (i+1) {
					case 1: //	FRONT
						//face.z = -50;
						logo.z = -50;
						endRotations[i + 1] = new Point(0, 0);
						break;
					case 2: //	LEFT
						face.rotationY = -90;
						face.x = 50;
						endRotations[i + 1] = new Point(0, 90);
						break;
					case 3:	//	BOTTOM
						face.rotationX = 90;
						face.y = 50;
						endRotations[i + 1] = new Point(-90, 90);
						break;
					case 4:	//	TOP
						face.rotationX = -90;
						face.y = -50;
						endRotations[i + 1] = new Point(90, 0);
						break;
					case 5:	//	RIGHT
						face.rotationY = 90;
						face.x = -50;
						endRotations[i + 1] = new Point(0, -90);
						break;
					case 6:	//	BACK
						/*face.rotationY = -180;
						face.z = 50;*/
						logo.rotationY = -180;
						logo.z = 50;
						endRotations[i + 1] = new Point(0, 180);
						break;
				}
				
				dice.addChild(face);
			}
		}
		
		private function animationCompleteHandler():void{
			dispatchEvent(new Event(ROLL_COMPLETE));
		}
		
		/**
		 * The last score to which the dice had to rotate. Available just after the @see roll() command
		 */
		public function get score():int { return _score; }
		
		public function playStarAnimation() : void
		{
			_starAnimation.play();
		}
		
	}
}