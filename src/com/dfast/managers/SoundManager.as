﻿package com.dfast.managers  {	import com.dfast.sounds.ChannelHolder;	import com.dfast.sounds.ChannelType;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.net.URLRequest;		 	public class SoundManager extends EventDispatcher 	{		private static var _instance:SoundManager;				private var _channels:Object;		private var _sounds:Object;		private var _baseUrl:String;		private var _muted:Boolean = false;				public function SoundManager(enforcer:SingletonEnforcer) 		{			if (enforcer == null){				throw new Error("Singleton: Do not instantiate this class with the constructor.");			} else {				createChannels();			}		}				private function createChannels():void		{			_channels = {};						_channels[ChannelType.FX] = new ChannelHolder(ChannelType.FX) ;			_channels[ChannelType.MUSIC] = new ChannelHolder(ChannelType.MUSIC) ;			_channels[ChannelType.OTHER] = new ChannelHolder(ChannelType.OTHER) ;		}				public static function getInstance():SoundManager 		{			if(!_instance)			{				_instance = new SoundManager(new SingletonEnforcer());			}						return _instance;		}				public function play(path:String, channelType:String = "fx", loops:int = 0) : void		{			var request:URLRequest = new URLRequest(path);			var sound:Sound = new Sound();            sound.load(request);						var channelHolder:ChannelHolder = getChannelHolder(channelType);			channelHolder.loops = loops;			channelHolder.sound = sound;						if(!channelHolder.muted)				channelHolder.play();		}						private function getChannelHolder(channelType:String):ChannelHolder		{			return _channels[channelType];		}						public function registerSounds(xml:XMLList, baseUrl:String="../") : void		{			_baseUrl = baseUrl;						var numSounds:int = xml.sound.length();			_sounds = { };			for (var i:int = 0; i < numSounds; i++) {				_sounds[ xml.sound[i].@id ] = baseUrl + xml.sound[i].@src;								loadSound( _sounds[ xml.sound[i].@id ] );			}		}				private function loadSound(path:String) : void		{			var request:URLRequest = new URLRequest(path);			var sound:Sound = new Sound();            sound.load(request);		}				public function playRegisteredSound(soundID:String, channel:String = "fx", loops:int = 0) : void		{			play(_sounds[soundID], channel, loops);		}				public function stop(channel:String) : void		{			_channels[channel].stop();		}				public function mute() : void		{			_muted = true;			_channels[ChannelType.FX].mute();			_channels[ChannelType.MUSIC].mute();			_channels[ChannelType.OTHER].mute();		}						public function unmute() : void		{			_muted = false;			_channels[ChannelType.FX].unmute();			_channels[ChannelType.MUSIC].unmute();			_channels[ChannelType.OTHER].unmute();		}				public function muteChannel(channel:String) : void		{			_channels[channel].mute();		}				public function unmuteChannel(channel:String) : void		{			_channels[channel].unmute();		}				public function get muted():Boolean { return _muted; }				public function isChannelMuted(channel:String) : Boolean		{			trace(channel + " is muted? -- " + _channels[channel].muted);			return _channels[channel].muted;		}	}}class SingletonEnforcer { }