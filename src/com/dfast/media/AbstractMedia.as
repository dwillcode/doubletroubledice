package com.dfast.media 
{
	import com.dfast.events.MediaEvent;
	import com.dfast.loaders.ILoadable;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class AbstractMedia extends EventDispatcher implements IMedia, IAudible, IPlayable
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function AbstractMedia() 
		{
			_volume			= 1;
			_pan 			= 0;
			_paused			= false;
			_playing		= false;
			_progressTimer	= new Timer( PROGRESS_INTERVAL, 0 );
			
			_soundTransform = new SoundTransform();
		}
		
		// ===============================================================
		//
		//	Constants
		//
		// ===============================================================
		
		public static const PROGRESS_INTERVAL : Number = 40;  
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		protected var _duration : Number;
		protected var _fileURL : String; 
		protected var _playing : Boolean;
		protected var _paused : Boolean;
		protected var _position : Number;
		
		private var _volume : Number;
		private var _pan : Number;
		private var _soundTransform : SoundTransform;
		private var _progressTimer : Timer;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	duration
		// ---------------------------------------------------------------
		
		public function get duration() : Number { return _duration; }
		
		// ---------------------------------------------------------------
		//	media
		// ---------------------------------------------------------------
		
		public function get data() : Object { return null; }
		
		// ---------------------------------------------------------------
		//	pan
		// ---------------------------------------------------------------
		
		public function get pan() : Number { return _pan; }
		
		public function set pan( pan:Number ) : void
		{
			_soundTransform.pan = pan;
		}
		
		// ---------------------------------------------------------------
		//	paused
		// ---------------------------------------------------------------
		
		public function get paused():Boolean { return _paused; }
		
		// ---------------------------------------------------------------
		//	playing
		// ---------------------------------------------------------------
		
		public function get playing():Boolean { return _playing; }
		
		// ---------------------------------------------------------------
		//	position
		// ---------------------------------------------------------------
		
		public function get position() : Number { return _position; }
		
		// ---------------------------------------------------------------
		//	soundTransform
		// ---------------------------------------------------------------
		
		public function get soundTransform() : SoundTransform { return _soundTransform; }
		
		public function set soundTransform( transform:SoundTransform ) : void
		{
			_soundTransform = transform;
		}	
		
		// ---------------------------------------------------------------
		//	volume
		// ---------------------------------------------------------------
		
		public function get volume() : Number { return _volume; }
		
		public function set volume( volume:Number ) : void
		{
			_soundTransform.volume = volume;
		}
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	applySoundTransform
		// ---------------------------------------------------------------
		
		protected function applySoundTransform() : void
		{
			throw new Error( "Subclasses must override this method." );
		}
		
		//--------------------------------------------------------------------------
		//  toggleProgessTracking
		//--------------------------------------------------------------------------
		
		protected function toggleProgessTracking( startTracking : Boolean ) : void
		{
			if ( startTracking ) {
				
				dispatchEvent( new MediaEvent( MediaEvent.START, position, duration ) );
				
				_progressTimer.addEventListener( TimerEvent.TIMER, onProgressTimer, false, 0, true );
				_progressTimer.start();
			} else {
				dispatchEvent( new MediaEvent( MediaEvent.STOP, position, duration ) );
				_progressTimer.removeEventListener( TimerEvent.TIMER, onProgressTimer );
				_progressTimer.stop();
			}	
		}
		
		// ---------------------------------------------------------------
		//	destroy
		// ---------------------------------------------------------------
		
		public function destroy() : void
		{
			throw new Error( "Subclasses must override this method." );
		}
		
		// ---------------------------------------------------------------
		//	unload
		// ---------------------------------------------------------------
		
		public function unload() : void
		{
			throw new Error( "Subclasses must override this method." );
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		public function load( url:String ) : void
		{
			_fileURL = url;
			
			_playing = false;
			_paused = false;
		}
		
		// ---------------------------------------------------------------
		//	start
		// ---------------------------------------------------------------
		
		public function start() : void
		{
			_playing 	= true;
			
			this.volume = _volume;
			this.pan = _pan;
			
			toggleProgessTracking( true );
		}
		
		// ---------------------------------------------------------------
		//	seek
		// ---------------------------------------------------------------
		
		public function seek( offset:Number ) : void
		{
			dispatchEvent( new MediaEvent( MediaEvent.PROGRESS, position, duration ) );
		}
		
		// ---------------------------------------------------------------
		//	stop
		// ---------------------------------------------------------------
		
		public function stop() : void
		{
			_playing = false;
			
			toggleProgessTracking( false );
		}
		
		// ---------------------------------------------------------------
		//	pause
		// ---------------------------------------------------------------
		
		public function pause( pause:Boolean ) : void
		{
			_playing 	= !pause;
			_paused 	= pause;
			
			dispatchEvent( new MediaEvent( MediaEvent.PAUSE ) );
			toggleProgessTracking( !pause );
		}
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onProgressTimer
		// ---------------------------------------------------------------
		
		protected function onProgressTimer( event:TimerEvent ) : void
		{
			dispatchEvent( new MediaEvent( MediaEvent.PROGRESS, position, duration ) );
		}
		
	}
	
}