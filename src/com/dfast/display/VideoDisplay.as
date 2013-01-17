package com.dfast.display 
{
	import com.dfast.events.MediaEvent;
	import com.dfast.media.IMedia;
	import com.dfast.media.VideoMedia;
	import flash.net.NetStream;
	
	import flash.media.Video;
	
	/**
	 * ...
	 * @author Derrick Williams
	 */
	public class VideoDisplay extends AbstractMediaDisplay
	{
		
		// ===============================================================
		//
		//	Constructor
		//
		// ===============================================================
		
		public function VideoDisplay() 
		{
			_video = new Video();
			_video.smoothing = true;
			addChild( _video );
		}
		
		// ===============================================================
		//	
		//	Local Variables
		//
		// ===============================================================
		
		private var _video : Video;
		private var _scaleMode : String;
		
		// ===============================================================
		//
		//	Instance Variables
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	scaleMode
		// ---------------------------------------------------------------
		
		public function get scaleMode():String { return _scaleMode; }
		
		public function set scaleMode(value:String):void 
		{
			_scaleMode = value;
		}
			
		// ---------------------------------------------------------------
		//	media
		// ---------------------------------------------------------------
		
		override public function set media ( media:IMedia ) : void 
		{
			_media = media;
			
			var videoMedia : VideoMedia = media as VideoMedia;
			
			videoMedia.addEventListener( MediaEvent.LOAD, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.METADATA, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.COMPLETE, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.PROGRESS, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.PAUSE, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.START, onMediaEvent, false, 0, true );
			videoMedia.addEventListener( MediaEvent.STOP, onMediaEvent, false, 0, true );
		}
		
		// ===============================================================
		//
		//	Instance Methods
		//
		// ===============================================================
		
		
		// ===============================================================
		//
		//	Event Listeners
		//
		// ===============================================================
		
		// ---------------------------------------------------------------
		//	onMediaEvent
		// ---------------------------------------------------------------
		
		private function onMediaEvent( event:MediaEvent ) : void
		{
			switch( event.type ) {
				
				case MediaEvent.LOAD:
					trace( "media loaded" );
					_video.attachNetStream( media.data as NetStream );
					break;
					
				case MediaEvent.METADATA:
					
					break;
					
				default:
					trace("Media Event: " + event.type);
					break;
			}
		}
	}
	
}



















