package game
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   
   public class SoundObject
   {
      
      public static const DEFAULT_EFFECT_TIME:int = 5000;
      
      public static const INTERVAL_TIME:int = 100;
      
      public static const TYPE_ITEM_SOUND:int = 0;
      
      public static const TYPE_CYCLED_MUSIC:int = 1;
      
      public static const TYPE_RADIO:int = 2;
      
      public static const XML_NOT_LOADED:int = 0;
      
      public static const XML_LOADING:int = 1;
      
      public static const XML_LOADED:int = 2;
      
      public static var currentMusicId:int = -1;
      
      public static var currentMusicCrossfaid:int = -1;
      
      public static var currentMusic:SoundObject = null;
      
      public static var lastMusic:SoundObject = null;
      
      public static var xmlState:int = XML_NOT_LOADED;
      
      private static var musicDictionary:Dictionary = null;
      
      public static var cachedSound:Sound;

      public var coordI:int;
      
      public var coordJ:int;
      
      private var soundId:int = -1;
      
      private var type:int;
      
      private var soundChannel:SoundChannel;
      
      private var transform:SoundTransform;
      
      private var xmlLoader:URLLoader;
      
      private var enabled:Boolean = true;
      
      private var intervalId:int = -1;
      
      private var started:Boolean = false;
      
      private var crossfaid:int = -1;
      
      private var crossfaidInterval:int = -1;
      
      public var currentVolume:Number = 0;
      
      private var effectTime:int;
      
      private var effectStartTime:int;
      
      public var sound:Sound;
      
      public function SoundObject(param1:int, param2:int, param3:int, param4:Sound = null, param5:int = 0)
      {
         super();
         this.soundId = param1;
         this.type = param2;
         this.effectTime = param3;
         var soundNumber:String = "";
         switch(param2)
         {
            case TYPE_ITEM_SOUND:
               if(param1 < 100)
               {
                  soundNumber += "0";
               }
               if(param1 < 10)
               {
                  soundNumber += "0";
               }
               soundNumber += param1.toString();
               this.sound = new Sound(new URLRequest("sounds/items/" + soundNumber + ".mp3"));
               this.sound.addEventListener(Event.COMPLETE,this.compleateHandler);
               this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundIoError);
               break;
            case TYPE_CYCLED_MUSIC:
               if(!currentMusic || currentMusic.type != TYPE_CYCLED_MUSIC || currentMusic.soundId != param1 || param4 != null)
               {
                  if(currentMusic)
                  {
                     currentMusic.effectTime = param3;
                     currentMusic.hideMusic();
                  }
                  currentMusic = this;
                  if(param4 != null)
                  {
                     this.sound = param4;
                     this.crossfaid = param5;
                     this.startMusicPlay();
                  }
                  else
                  {
                     switch(xmlState)
                     {
                        case XML_NOT_LOADED:
                           this.loadXml();
                           break;
                        case XML_LOADED:
                           this.loadMusic();
                           break;
                     }
                  }
               }
               break;
            case TYPE_RADIO:
               this.sound = new Sound();
               if(lastMusic)
               {
                  lastMusic.stopMusic();
               }
               if(currentMusic)
               {
                  currentMusic.stopMusic();
               }
               lastMusic = null;
               currentMusic = this;
               this.loadRadio();
               break;
         }
      }
      
      public static function stopPlaying() : void
      {
         if(currentMusic)
         {
            currentMusic.hideMusic();
            currentMusic = null;
         }
      }
      
      public static function updateMusic() : void
      {
         if(Client.settings["enableMusic"])
         {
            if(!currentMusic)
            {
               startPlaying();
            }
         }
         else if(currentMusic && currentMusic.type == TYPE_CYCLED_MUSIC)
         {
            stopPlaying();
         }
      }
      
      public static function startPlaying(param1:int = -1, param2:Sound = null, param3:int = 0) : void
      {
         var music:SoundObject = null;
         if(param1 == -1)
         {
            param1 = DEFAULT_EFFECT_TIME;
         }
         if(currentMusicId != -1)
         {
            music = new SoundObject(currentMusicId,TYPE_CYCLED_MUSIC,param1,param2,param3);
         }
      }
      
      public static function startRadio() : void
      {
         var radio:SoundObject = new SoundObject(Client.settings["radioType"],TYPE_RADIO,DEFAULT_EFFECT_TIME);
      }
      
      public static function updateRadioVolume() : void
      {
         if(currentMusic && currentMusic.type == TYPE_RADIO)
         {
            currentMusic.setVolume(Client.settings["radioVolume"]);
         }
      }
      
      public static function updateMusicVolume() : void
      {
         if(currentMusic && currentMusic.type == TYPE_CYCLED_MUSIC)
         {
            currentMusic.setVolume(Client.settings["musicVolume"]);
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         if(this.started)
         {
            currentVolume = param1;
            transform = new SoundTransform(param1);
            this.soundChannel.soundTransform = this.transform;
         }
      }
      
      public function stopMusic() : void
      {
         if(!this.sound)
         {
            return;
         }
         enabled = false;
         this.sound.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         if(this.soundChannel)
         {
            this.soundChannel.stop();
            if(this.type == TYPE_RADIO)
            {
               try
               {
                  if(this.sound != cachedSound)
                  {
                     this.sound.close();
                  }
               }
               catch(e:*)
               {
               }
            }
         }
         else
         {
            this.sound.removeEventListener(Event.COMPLETE,this.musicCompleateHandler);
         }
         if(this.crossfaidInterval != -1)
         {
            clearInterval(this.crossfaidInterval);
            crossfaidInterval = -1;
         }
      }
      
      private function hideMusic() : void
      {
         if(this.crossfaidInterval != -1)
         {
            clearInterval(this.crossfaidInterval);
            crossfaidInterval = -1;
         }
         if(lastMusic)
         {
            if(lastMusic.soundChannel && lastMusic.currentVolume > this.currentVolume)
            {
               this.stopMusic();
               return;
            }
            lastMusic.stopMusic();
         }
         lastMusic = this;
         enabled = false;
         effectStartTime = getTimer();
         if(this.intervalId != -1)
         {
            clearInterval(this.intervalId);
            intervalId = -1;
         }
         if(this.soundChannel)
         {
            intervalId = setInterval(this.hideInterval,INTERVAL_TIME);
         }
      }
      
      private function get volume() : Number
      {
         switch(this.type)
         {
            case TYPE_ITEM_SOUND:
               return Client.settings["soundVolume"];
            case TYPE_CYCLED_MUSIC:
               return Client.settings["musicVolume"];
            case TYPE_RADIO:
               return Client.settings["radioVolume"];
         }
         return 1;
      }
      
      private function startInterval() : void
      {
         var now:int = getTimer();
         if(this.effectStartTime + this.effectTime > now)
         {
            currentVolume = Math.min(this.currentVolume + (this.volume - this.currentVolume) * INTERVAL_TIME / (this.effectStartTime + this.effectTime - now),1);
         }
         else
         {
            currentVolume = 1;
         }
         if(this.currentVolume >= this.volume)
         {
            currentVolume = this.volume;
            transform = new SoundTransform(this.volume);
            this.soundChannel.soundTransform = this.transform;
            started = true;
            clearInterval(this.intervalId);
         }
         else
         {
            transform = new SoundTransform(this.currentVolume);
            this.soundChannel.soundTransform = this.transform;
         }
      }
      
      private function hideInterval() : void
      {
         var now:int = getTimer();
         if(this.effectStartTime + this.effectTime > now)
         {
            currentVolume = Math.min(this.currentVolume - this.currentVolume * INTERVAL_TIME / (this.effectStartTime + this.effectTime - now),1);
         }
         else
         {
            currentVolume = 0;
         }
         transform = new SoundTransform(this.currentVolume);
         this.soundChannel.soundTransform = this.transform;
         if(this.currentVolume <= 0)
         {
            clearInterval(this.intervalId);
            this.stopMusic();
         }
      }
      
      private function loadRadio() : void
      {
         var url:String = Client.getString("IDS_RADIO_URL_" + this.soundId);
         this.sound.load(new URLRequest(url));
         this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         transform = new SoundTransform(0);
         soundChannel = this.sound.play(0,0,this.transform);
         effectStartTime = getTimer();
         intervalId = setInterval(this.startInterval,INTERVAL_TIME);
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private function loadMusic() : void
      {
         var musicInfo:Object = musicDictionary[this.soundId];
         var crossfades:Array = musicInfo.crossfade;
         var trackIndex:int;
         var trackId:int;
         if(musicInfo.tracks.length > 0)
         {
            trackIndex = Math.random() * musicInfo.tracks.length;
            trackId = musicInfo.tracks[trackIndex];
            crossfaid = crossfades[trackIndex];
            sound = new Sound();
            this.sound.load(new URLRequest("sounds/music/" + ((trackId < 10 ? "00" : (trackId < 100 ? "0" : "")) + trackId) + ".mp3"));
            this.sound.addEventListener(Event.COMPLETE,this.musicCompleateHandler);
            this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundIoError);
         }
      }
      
      private function musicCompleateHandler(param1:Event) : void
      {
         if(this.crossfaid > 0)
         {
            if(!cachedSound || cachedSound.url != this.sound.url)
            {
               cachedSound = new Sound(new URLRequest(this.sound.url));
            }
         }
         this.sound.removeEventListener(Event.COMPLETE,this.musicCompleateHandler);
         this.sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onSoundIoError);
         this.startMusicPlay();
      }
      
      private function startMusicPlay() : void
      {
         transform = new SoundTransform(0);
         soundChannel = this.sound.play(50,this.crossfaid != 0 ? 1 : int.MAX_VALUE,this.transform);
         if(this.crossfaid != 0)
         {
            crossfaidInterval = setInterval(this.crossfaidIntervalHandler,this.crossfaid);
         }
         effectStartTime = getTimer();
         intervalId = setInterval(this.startInterval,100);
      }
      
      private function loadXml() : void
      {
         xmlState = XML_LOADING;
         xmlLoader = new URLLoader();
         var request:URLRequest = new URLRequest("sounds/music/zone_music.xml");
         this.xmlLoader.addEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
         this.xmlLoader.load(request);
      }
      
      private function xmlCompleteHandler(param1:Event) : void
      {
         var loader:URLLoader = null;
         var xml:XML = null;
         var musicInfo:Object = null;
         var index:int = 0;
         var crossfades:Array = null;
         var trackEntries:Array = null;
         var tracks:Array = null;
         if(this.enabled)
         {
            musicDictionary = new Dictionary();
            loader = param1.target as URLLoader;
            xml = new XML(loader.data);
            for each(musicInfo in xml.elements("music"))
            {
               crossfades = new Array();
               trackEntries = musicInfo.tracks.split(";");
               tracks = new Array();
               index = 0;
               while(index < trackEntries.length)
               {
                  if(trackEntries[index] != "")
                  {
                     tracks.push(trackEntries[index]);
                     crossfades.push(int(musicInfo["cf_" + index]));
                  }
                  index++;
               }
               musicDictionary[int(musicInfo.type_id)] = {
                  "tracks":tracks,
                  "crossfade":crossfades
               };
            }
            xmlState = XML_LOADED;
            if(this.soundId != -1)
            {
               this.loadMusic();
            }
         }
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
      }
      
      private function xmlIoErrorHandler(param1:IOErrorEvent) : void
      {
         xmlState = XML_NOT_LOADED;
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
      }
      
      private function onSoundIoError(param1:Event) : void
      {
         if(this.sound)
         {
            this.sound.removeEventListener(Event.COMPLETE,this.musicCompleateHandler);
            this.sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onSoundIoError);
         }
      }
      
      private function compleateHandler(param1:Event) : void
      {
         var deltaI:int = this.coordI - Client.client.player.i;
         var deltaJ:int = this.coordJ - Client.client.player.j;
         var sum:int = deltaI + deltaJ;
         var difference:int = deltaI - deltaJ;
         var pan:Number = 0;
         var distance:Number = Math.sqrt(sum * sum + difference * difference);
         if(sum != 0 || difference != 0)
         {
            pan = sum / distance;
         }
         transform = new SoundTransform(Math.max(0,(World.MAX_DISTANCE - distance) / World.MAX_DISTANCE),pan);
         this.sound.play(0,0,this.transform);
         this.sound.removeEventListener(Event.COMPLETE,this.compleateHandler);
         this.sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onSoundIoError);
      }
      
      private function crossfaidIntervalHandler() : void
      {
         startPlaying(this.sound.length - this.soundChannel.position,cachedSound,this.crossfaid);
         cachedSound = this.sound;
         clearInterval(this.crossfaidInterval);
         crossfaidInterval = -1;
      }
   }
}

