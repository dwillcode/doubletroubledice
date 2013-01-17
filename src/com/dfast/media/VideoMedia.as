package com.dfast.media 
{
	import com.dfast.events.MediaEvent;
	import com.dfast.loaders.ILoadable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class VideoMedia extends AbstractMedia
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function VideoMedia() 
		{
			super();
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _netStream : NetStream;
		private var _netConnection : NetConnection;
		private var _videoEnded : Boolean;
		private var _loadTimer : Timer;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		override public function get data() : Object { return _netStream; }
			
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		//----------------------------------------------------------------
		//  applySoundTransform
		//----------------------------------------------------------------
		
		override protected function applySoundTransform() : void
		{
			_netStream.soundTransform = soundTransform;
		}
		
		// ---------------------------------------------------------------
		//	load
		// ---------------------------------------------------------------
		
		override public function load( url:String ) : void
		{
			super.load( url );
			
			_netConnection = new NetConnection();
			
			try {
				_netConnection.connect( null );
				_netStream = new NetStream( _netConnection );
				_netStream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus, false, 0, true );
				_netStream.client = this;
				
				applySoundTransform();
				
				dispatchEvent( new MediaEvent( MediaEvent.LOAD ) );
				start();
				
			} catch ( error : Error ) {}
		}
		
		// ---------------------------------------------------------------
		//	pause
		// ---------------------------------------------------------------
		
		override public function pause( pause:Boolean ) : void
		{
			if ( pause ) {
				_netStream.pause();
			} else {
				if ( !playing ) _netStream.resume();
			}
			
			super.pause( pause );
		}
		
		// ---------------------------------------------------------------
		//	start
		// ---------------------------------------------------------------
		
		override public function start() : void
		{
			_videoEnded = false;
			
			if ( paused ) {
				_netStream.resume();
			} else {
				try {
					_netStream.play( _fileURL );
					if ( _netStream.bytesLoaded != _netStream.bytesTotal && _netStream.bytesTotal > 0 ) {
						_loadTimer = new Timer( 500, 0 );
						//_loadTimer.addEventListener( TimerEvent.TIMER, assessLoad, false, 0, true );
						//_loadTimer.start();
					}
				} catch ( error : Error ) {}
			}
			
			super.start();	
		}
		
		// ---------------------------------------------------------------
		//	stop
		// ---------------------------------------------------------------
		
		override public function stop() : void
		{
			_netStream.seek( 0 );

			_netStream.pause();
			
			super.stop();
		}
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		//----------------------------------------------------------------
		//  onMetaData
		//----------------------------------------------------------------
		
		public function onMetaData( data : Object ) : void
		{
			if ( data.duration > 0 ) _duration = data.duration;
			
			dispatchEvent( new MediaEvent( MediaEvent.METADATA, position, duration, data.width, data.height ) );
		}
		
		//----------------------------------------------------------------
		//  onNetStatus
		//----------------------------------------------------------------
		
		private function onNetStatus( event : NetStatusEvent ) : void
		{
			switch ( event.info.level ) {
				case "error" : 
					dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR, false, false, "Error loading video!!!" ) );
					break;
				case "status" :
					trace( "FLV Status code: "+ event.info.code );
					switch ( event.info.code ) {
						case "NetStream.Play.start" :
							dispatchEvent( new Event( Event.INIT ) );
							break;
						case "NetStream.Play.stop" : 
							_videoEnded = true;
							stop();
							break;	
					}
					break;
			}	
		}
		
		// ---------------------------------------------------------------
		//	onProgressTimer
		// ---------------------------------------------------------------
		
		override protected function onProgressTimer( event:TimerEvent ) : void
		{
			if ( position >= duration - .5 || _videoEnded ) {
				_videoEnded = false;
				
				stop();
				dispatchEvent( new MediaEvent( MediaEvent.COMPLETE, position, duration ) );	
			}
			super.onProgressTimer( event );
		}
		
	}
	
}