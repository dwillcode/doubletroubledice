package com.edzis {
	import net.badimon.five3D.display.Graphics3D;
	import net.badimon.five3D.display.Scene3D;
	import net.badimon.five3D.display.Shape3D;
	import net.badimon.five3D.display.Sprite3D;
	import net.badimon.five3D.geom.Matrix3D;
	import net.badimon.five3D.geom.Point3D;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Edgars Simsons, http://edzis.wordpress.com, simsons.edgars{in}gmail.com
	 */
	public class DiceExample extends Sprite {
		private var dice1:Dice;
		private var dice2:Dice;
		
		public function DiceExample():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			dice1 = new Dice();
			dice1.addEventListener(Dice.SCORE, onDiceScore);
			addChild(dice1);
			
			dice2 = new Dice();
			dice2.addEventListener(Dice.SCORE, onDiceScore);
			addChild(dice2);
			
			//stage.addEventListener(MouseEvent.CLICK, roll);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		private function onResize(e:Event = null):void {
			dice1.x = 200;
			dice1.x = 300;
			dice1.y = dice2.y = 200;
		}
		
		public function roll(diceValues:Object):void {
			trace("dice values: " + diceValues.dice1 + ", " + diceValues.dice2);
			dice1.roll(diceValues.dice1);
			dice2.roll(diceValues.dice2);
		}
		
		private function onDiceScore(event:Event):void {
			trace("onDiceScore " + event.target.score);
		}
		
	}
}