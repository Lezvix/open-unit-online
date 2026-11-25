package core.resources
{
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import game.world.NPoint;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   
   public class SoundManager
   {
      
      private static const SOUND_MANAGER_CONST2:int = 5000;
      
      private static const SOUND_MANAGER_CONST1:Number = 0;
      
      public static var sharedInstance:SoundManager;

      private var soundEffectsVolume:Number = 1;
      
      private var soundEffectsEnabled:Boolean = true;
      
      private var repeatSoundsById:Object = new Object();
      
      private var nPoint2:NPoint = new NPoint(0,0);
      
      private var soundAudibleRadius:int;
      
      private var music:Object = null;
      
      private var musicEnabled:Boolean = true;
      
      private var soundChannelInfoList1:Vector.<SoundChannelInfo> = new Vector.<SoundChannelInfo>();
      
      private var positionalSoundsByOwner:Object = new Object();
      
      private var flag13:Boolean;
      
      private var musicFadeIntervalId:int = -1;
      
      private var musicFadeStartTime:int;
      
      private var musicFadeDuration:int;
      
      private var musicFadeStartVolume:Number;
      
      private var resourcePackList2:Vector.<ResourcePack> = new Vector.<ResourcePack>();
      
      private var soundPacksByResourceName:Object = new Object();
      
      private var fadeBeforeMusicChange:Boolean = false;
      
      private var pendingMusicId:String = null;
      
      private var pendingMusicVolume:Number = 1;
      
      public function SoundManager(param1:Boolean = false, param2:Boolean = false)
      {
         super();
         this.flag13 = param1;
         this.fadeBeforeMusicChange = param2;
         sharedInstance = this;
      }
      
      public static function doAction87(param1:ResourcePack) : void
      {
         sharedInstance.doAction24(param1);
      }
      
      public static function doAction119(param1:int, param2:int) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.propValue87 = new NPoint(param1,param2);
         }
      }
      
      public static function playMusic(param1:String, param2:Number = 1, param3:Boolean = false) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction347(param1,param2,param3);
         }
      }
      
      public static function doAction429() : void
      {
         sharedInstance.doAction429();
         sharedInstance.doAction258();
      }
      
      public static function doAction288(param1:Object) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction923(param1);
         }
      }
      
      public static function doAction580(param1:Object) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction580(param1);
         }
      }
      
      public static function doAction381(param1:String, param2:Object = null, param3:Boolean = false) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction691(param1,param2,param3);
         }
      }
      
      public static function doAction350(param1:String, param2:Boolean = false) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction292(param1,param2);
         }
      }
      
      public static function doAction89(param1:Object) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction519(param1);
         }
      }
      
      public static function doAction656(param1:String) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction528(param1);
         }
      }
      
      public static function doAction544() : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction522();
         }
      }
      
      public static function playSound(param1:String, param2:Function = null, param3:Function = null) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.play(param1,param2,param3);
         }
      }
      
      public static function playObjectSound(param1:String, param2:Object, param3:Function = null, param4:Function = null) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction252(param1,param2,param3,param4);
         }
      }
      
      public static function doAction529(param1:String, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
      {
         if(sharedInstance != null)
         {
            sharedInstance.doAction84(param1,param2,param3,param4,param5);
         }
      }
      
      private function getSound1(param1:String) : Sound
      {
         var pack:ResourcePack = this.soundPacksByResourceName[param1];
         if(pack != null)
         {
            return new (pack.getResource(param1))() as Sound;
         }
         var soundClass:Class = null;
         var index:int = this.resourcePackList2.length - 1;
         while(index >= 0 && soundClass == null)
         {
            soundClass = this.resourcePackList2[index].getResource(param1);
            index--;
         }
         if(soundClass != null)
         {
            this.soundPacksByResourceName[param1] = this.resourcePackList2[index + 1];
            return new soundClass() as Sound;
         }
         return null;
      }
      
      public function doAction24(param1:ResourcePack) : void
      {
         this.resourcePackList2.push(param1);
      }
      
      protected function set propValue63(param1:int) : void
      {
         soundAudibleRadius = param1;
      }
      
      protected function get propValue63() : int
      {
         return this.soundAudibleRadius;
      }
      
      public function get propValue87() : NPoint
      {
         return this.nPoint2;
      }
      
      public function set propValue87(param1:NPoint) : void
      {
         nPoint2 = param1;
         this.doAction673();
         this.doAction498();
      }
      
      public function get volume() : Number
      {
         return this.soundEffectsVolume;
      }
      
      public function set volume(param1:Number) : void
      {
         soundEffectsVolume = param1;
         this.doAction673();
      }
      
      public function set musicVolume(param1:Number) : void
      {
         var transform:SoundTransform = null;
         if(this.music && this.music.c != null)
         {
            transform = new SoundTransform(param1);
            this.music.c.soundTransform = transform;
         }
      }
      
      private function doAction648() : void
      {
         var elapsed:int = getTimer() - this.musicFadeStartTime;
         if(elapsed >= this.musicFadeDuration)
         {
            if(this.music != null && this.music.c != null)
            {
               this.music.c.soundTransform = new SoundTransform(this.music.v);
            }
            clearInterval(this.musicFadeIntervalId);
         }
         else if(this.music != null && this.music.c != null)
         {
            this.music.c.soundTransform = new SoundTransform(this.musicFadeStartVolume + (this.music.v - this.musicFadeStartVolume) * elapsed / this.musicFadeDuration);
         }
      }
      
      private function doAction955() : void
      {
         if(this.musicFadeIntervalId)
         {
            clearInterval(this.musicFadeIntervalId);
         }
      }
      
      private function doAction863() : void
      {
         var elapsed:int = getTimer() - this.musicFadeStartTime;
         if(elapsed >= this.musicFadeDuration)
         {
            clearInterval(this.musicFadeIntervalId);
            if(this.music != null && this.music.c != null)
            {
               this.music.c.soundTransform = new SoundTransform(SOUND_MANAGER_CONST1);
               this.music.c.stop();
               music = null;
            }
            this.doAction347(this.pendingMusicId,this.pendingMusicVolume);
         }
         else if(this.music != null && this.music.c != null)
         {
            this.music.c.soundTransform = new SoundTransform(this.musicFadeStartVolume - (this.musicFadeStartVolume - SOUND_MANAGER_CONST1) * elapsed / this.musicFadeDuration);
         }
      }
      
      private function check53() : Boolean
      {
         if(this.volume > SOUND_MANAGER_CONST1)
         {
            if(this.musicEnabled)
            {
               musicFadeStartTime = getTimer();
               musicFadeStartVolume = this.music.c.soundTransform.volume;
               musicFadeDuration = SOUND_MANAGER_CONST2 * (this.musicFadeStartVolume - SOUND_MANAGER_CONST1) / (this.music.v - SOUND_MANAGER_CONST1);
               musicFadeIntervalId = TimerUtil.setInterval(this.doAction863,50);
               return true;
            }
         }
         return false;
      }
      
      private function doAction942() : void
      {
         if(this.music != null && this.music.c != null)
         {
            if(this.flag13 && this.music.v > this.music.c.soundTransform.volume)
            {
               if(this.musicEnabled)
               {
                  musicFadeStartTime = getTimer();
                  musicFadeStartVolume = this.music.c.soundTransform.volume;
                  musicFadeDuration = SOUND_MANAGER_CONST2 * (this.music.v - this.musicFadeStartVolume) / (this.music.v - SOUND_MANAGER_CONST1);
                  musicFadeIntervalId = TimerUtil.setInterval(this.doAction648,50);
               }
            }
            else
            {
               this.music.c.soundTransform = new SoundTransform(this.volume);
            }
         }
      }
      
      private function getSoundTransform2(param1:Number) : SoundTransform
      {
         var transform:SoundTransform = null;
         if(this.flag13 && param1 > SOUND_MANAGER_CONST1)
         {
            transform = new SoundTransform(SOUND_MANAGER_CONST1);
            if(this.musicEnabled)
            {
               musicFadeStartTime = getTimer();
               musicFadeDuration = SOUND_MANAGER_CONST2;
               musicFadeStartVolume = SOUND_MANAGER_CONST1;
               musicFadeIntervalId = TimerUtil.setInterval(this.doAction648,50);
            }
         }
         else
         {
            transform = new SoundTransform(param1);
         }
         return transform;
      }
      
      public function doAction347(param1:String, param2:Number = 1, param3:Boolean = false) : void
      {
         var sound:Sound = null;
         var channel:SoundChannel = null;
         var transform:SoundTransform = null;
         this.doAction955();
         if(param3 || this.music == null || this.music.sId != param1)
         {
            if(this.music != null && this.music.c != null)
            {
               if(this.fadeBeforeMusicChange && this.check53())
               {
                  pendingMusicId = param1;
                  pendingMusicVolume = param2;
                  return;
               }
               this.music.c.stop();
            }
            sound = this.getSound1(param1);
            channel = null;
            if(this.musicEnabled && sound != null)
            {
               transform = this.getSoundTransform2(param2);
               channel = this.getSoundChannel1(sound,25,int.MAX_VALUE,transform,false);
            }
            music = {
               "s":sound,
               "c":channel,
               "v":param2,
               "sId":param1
            };
         }
         else
         {
            this.doAction942();
         }
      }
      
      public function doAction536() : void
      {
         if(this.music != null)
         {
            this.doAction955();
            if(this.music.c != null)
            {
               this.music.c.stop();
            }
            music = null;
         }
      }
      
      public function doAction258() : void
      {
         var transform:SoundTransform = null;
         if(this.music != null && this.music.c == null)
         {
            this.doAction955();
            if(this.music.s == null)
            {
               this.music.s = this.getSound1(this.music.sId);
            }
            if(this.music.s != null && this.musicEnabled)
            {
               transform = this.getSoundTransform2(this.music.v);
               this.music.c = this.getSoundChannel1(this.music.s,25,int.MAX_VALUE,transform,false);
            }
         }
      }
      
      public function set isValue64(param1:Boolean) : void
      {
         var transform:SoundTransform = null;
         musicEnabled = param1;
         if(this.musicEnabled)
         {
            if(this.music != null && this.music.c == null && this.music.s != null)
            {
               this.doAction955();
               transform = this.getSoundTransform2(this.music.v);
               this.music.c = this.getSoundChannel1(this.music.s,25,int.MAX_VALUE,transform,false);
            }
         }
         else if(this.music != null && this.music.c != null)
         {
            this.doAction955();
            this.music.c.stop();
            this.music.c = null;
         }
      }
      
      public function get isValue64() : Boolean
      {
         return this.musicEnabled;
      }
      
      public function doAction923(param1:Object) : void
      {
         var entry:Object = this.repeatSoundsById[param1.soundRepeatId];
         if(entry != null && entry.sound != null && entry.sound.c != null)
         {
            entry.sound.c.soundTransform = this.getSoundTransform3(entry.owner);
         }
      }
      
      public function doAction673() : void
      {
         var entry:Object = null;
         var transform:SoundTransform = new SoundTransform(this.soundEffectsVolume);
         for each(entry in this.repeatSoundsById)
         {
            if(entry.sound != null && entry.sound.c != null && entry.owner)
            {
               entry.sound.c.soundTransform = this.getSoundTransform3(entry.owner);
            }
         }
      }
      
      private function getSoundTransform1(param1:int, param2:int) : SoundTransform
      {
         var deltaX:int = this.nPoint2.x - param1;
         var deltaY:int = this.nPoint2.y - param2;
         var pan:Number = 0;
         var distance:Number = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
         if(distance == 0)
         {
            pan = 0;
         }
         else if(deltaX != 0 || deltaY != 0)
         {
            pan = -deltaX / distance * this.propValue84;
         }
         if(distance > this.soundAudibleRadius)
         {
            return new SoundTransform(0);
         }
         return new SoundTransform((this.soundAudibleRadius - distance) / this.soundAudibleRadius * this.soundEffectsVolume,pan);
      }
      
      protected function get propValue84() : Number
      {
         return 1;
      }
      
      private function getSoundTransform3(param1:Object) : SoundTransform
      {
         if(param1.hasSoundCoords)
         {
            return this.getSoundTransform1(param1.soundX,param1.soundY);
         }
         return new SoundTransform(this.soundEffectsVolume);
      }
      
      public function doAction429() : void
      {
         var entry:Object = null;
         if(this.soundEffectsEnabled)
         {
            for each(entry in this.repeatSoundsById)
            {
               if(entry.sound && entry.sound.s == null)
               {
                  entry.sound = this.getObject2(entry.soundId,entry.owner);
               }
            }
         }
      }
      
      public function set enableSounds(param1:Boolean) : void
      {
         var entry:Object = null;
         if(this.soundEffectsEnabled != param1)
         {
            soundEffectsEnabled = param1;
            for each(entry in this.repeatSoundsById)
            {
               if(this.soundEffectsEnabled)
               {
                  entry.sound = this.getObject2(entry.soundId,entry.owner);
               }
               else
               {
                  if(entry.sound != null && entry.sound.c != null)
                  {
                     entry.sound.c.stop();
                  }
                  entry.sound = null;
               }
            }
         }
      }
      
      public function get enableSounds() : Boolean
      {
         return this.soundEffectsEnabled;
      }
      
      public function doAction292(param1:String, param2:Boolean = false) : void
      {
         this.doAction376(param1,param1,null,param2);
      }
      
      public function doAction691(param1:String, param2:Object, param3:Boolean = false) : void
      {
         var repeatId:String = param2.soundRepeatId;
         this.doAction376(param1,repeatId,param2,param3);
      }
      
      private function doAction376(param1:String, param2:String, param3:Object = null, param4:Boolean = false) : void
      {
         var existingEntry:Object = this.repeatSoundsById[param2];
         var entry:Object;
         if(existingEntry == null || existingEntry.soundId != param1)
         {
            if(existingEntry != null)
            {
               this.doAction519(param3);
            }
            entry = {
               "soundId":param1,
               "owner":param3,
               "sound":(this.soundEffectsEnabled ? this.getObject2(param1,param3) : null),
               "cos":param4
            };
            this.repeatSoundsById[param2] = entry;
         }
         else if(existingEntry.sound != null && existingEntry.sound.c != null && existingEntry.sound.timer != null)
         {
            existingEntry.sound.timer.dispose();
            existingEntry.sound.timer = null;
         }
      }
      
      private function getObject2(param1:String, param2:Object) : Object
      {
         var transform:SoundTransform = null;
         if(param2 != null)
         {
            transform = this.getSoundTransform3(param2);
         }
         var sound:Sound = this.getSound1(param1);
         var channel:SoundChannel = null;
         if(sound != null)
         {
            channel = this.getSoundChannel1(sound,25,int.MAX_VALUE,transform,false);
         }
         return {
            "s":sound,
            "c":channel
         };
      }
      
      public function doAction519(param1:Object) : void
      {
         this.doAction528(param1.soundRepeatId);
      }
      
      public function doAction528(repeatId:String) : void
      {
         var obj:Object;
         var onStop:Function;
         onStop = function(param1:Object):void
         {
            obj.sound.c.stop();
            delete repeatSoundsById[repeatId];
         };
         obj = this.repeatSoundsById[repeatId];
         if(obj != null)
         {
            if(obj.sound != null && obj.sound.c != null)
            {
               if(obj.cos)
               {
                  if(obj.sound.timer == null)
                  {
                     var timer:TimerUtil = new TimerUtil(obj.sound.s.length - obj.sound.c.position,1);
                     timer.handler = onStop;
                     timer.start();
                     obj.sound.timer = timer;
                  }
                  return;
               }
               else
               {
                  obj.sound.c.stop();
               }
            }
            delete this.repeatSoundsById[repeatId];
         }
      }
      
      public function doAction522() : void
      {
         var entry:Object = null;
         for each(entry in this.repeatSoundsById)
         {
            if(entry.sound != null && entry.sound.c != null)
            {
               entry.sound.c.stop();
               if(entry.sound.timer != null)
               {
                  entry.sound.timer.dispose();
                  entry.sound.timer = null;
               }
            }
         }
         repeatSoundsById = new Object();
      }
      
      public function play(param1:String, param2:Function = null, param3:Function = null) : void
      {
         var transform:SoundTransform = null;
         var sound:Sound = null;
         if(this.soundEffectsEnabled)
         {
            transform = new SoundTransform(this.soundEffectsVolume);
            sound = this.getSound1(param1);
            if(sound)
            {
               this.getSoundChannel1(sound,0,0,transform,true,param2,param3);
            }
         }
      }
      
      public function doAction84(param1:String, param2:int, param3:int, param4:Function = null, param5:Function = null) : void
      {
         var transform:SoundTransform = null;
         var sound:Sound = null;
         if(this.soundEffectsEnabled && this.nPoint2)
         {
            transform = this.getSoundTransform1(param2,param3);
            sound = this.getSound1(param1);
            if(sound)
            {
               this.getSoundChannel1(sound,0,0,transform,true,param4,param5);
            }
         }
      }
      
      public function doAction580(param1:Object) : void
      {
         var ownerId:String = param1.uid;
         var entries:Array = this.positionalSoundsByOwner[ownerId] as Array;
         var entry:Object;
         var channel:SoundChannel;
         if(entries != null)
         {
            for each(entry in entries)
            {
               channel = entry.soundChannel as SoundChannel;
               if(channel != null)
               {
                  channel.soundTransform = this.getSoundTransform3(param1);
               }
            }
         }
      }
      
      public function doAction498() : void
      {
         var entries:Array = null;
         var entry:Object = null;
         var channel:SoundChannel = null;
         for each(entries in this.positionalSoundsByOwner)
         {
            for each(entry in entries)
            {
               channel = entry.soundChannel as SoundChannel;
               if(channel != null)
               {
                  channel.soundTransform = this.getSoundTransform3(entry.owner);
               }
            }
         }
      }
      
      private function doAction190(param1:Event) : void
      {
         this.doAction361(param1.target as SoundChannel,true);
      }
      
      private function doAction361(param1:SoundChannel, param2:Boolean = false) : void
      {
         var index:int = 0;
         while(this.soundChannelInfoList1[index].soundChannel != param1)
         {
            index++;
         }
         var channelInfo:SoundChannelInfo = this.soundChannelInfoList1[index];
         this.soundChannelInfoList1.splice(index,1);
         EventListeners.removeEventListener(param1,Event.SOUND_COMPLETE,this.doAction190);
         if(param2 && channelInfo.completeHandler != null)
         {
            channelInfo.completeHandler();
         }
      }
      
      private function doAction203(param1:int, param2:Boolean = false) : void
      {
         var channel:SoundChannel = this.soundChannelInfoList1[param1].soundChannel;
         if(param2)
         {
            if(this.soundChannelInfoList1[param1].completeHandler != null)
            {
               this.soundChannelInfoList1[param1].completeHandler();
            }
         }
         else if(this.soundChannelInfoList1[param1].stopedHandler != null)
         {
            this.soundChannelInfoList1[param1].stopedHandler();
         }
         this.soundChannelInfoList1.splice(param1,1);
         if(channel)
         {
            EventListeners.removeEventListener(channel,Event.SOUND_COMPLETE,this.doAction190);
         }
      }
      
      private function getSoundChannel1(param1:Sound, param2:int, param3:int, param4:SoundTransform, param5:Boolean = true, param6:Function = null, param7:Function = null) : SoundChannel
      {
         var channel:SoundChannel = param1.play(0,param3,param4);
         var channelInfo:SoundChannelInfo;
         while(channel == null && this.soundChannelInfoList1.length > 0)
         {
            if(this.soundChannelInfoList1[0].soundChannel)
            {
               this.soundChannelInfoList1[0].soundChannel.stop();
            }
            this.doAction203(0);
            channel = param1.play(0,param3,param4);
         }
         if(param5 && channel)
         {
            channelInfo = new SoundChannelInfo();
            channelInfo.soundChannel = channel;
            channelInfo.completeHandler = param6;
            channelInfo.stopedHandler = param7;
            this.soundChannelInfoList1.push(channelInfo);
            EventListeners.addEventListener(channel,Event.SOUND_COMPLETE,this.doAction190);
         }
         return channel;
      }
      
      public function doAction450(param1:Object) : void
      {
         var ownerId:String = param1.uid;
         var entries:Array = this.positionalSoundsByOwner[ownerId] as Array;
         var index:int;
         var entry:Object;
         if(entries)
         {
            index = entries.length - 1;
            while(index >= 0)
            {
               entry = entries[index];
               if((entry) && entry.soundChannel)
               {
                  entry.soundChannel.stop();
               }
               index--;
            }
         }
         this.positionalSoundsByOwner[ownerId] = null;
      }
      
      public function doAction252(soundId:String, owner:Object, onComplete:Function = null, onStoped:Function = null) : void
      {
         if(this.soundEffectsEnabled && this.nPoint2)
         {
            var objId:String = owner.uid;
            var transform:SoundTransform = this.getSoundTransform3(owner);
            var sound:Sound = this.getSound1(soundId);
            if(sound)
            {
               var sc:SoundChannel = this.getSoundChannel1(sound,0,0,transform,true,onComplete,onStoped);
               if(sc != null)
               {
                  var a:Array;
                  var so:Object;
                  var soundCompleteHandler:Function = function(param1:Event):void
                  {
                     a.splice(a.indexOf(so),1);
                     if(a.length == 0)
                     {
                        delete positionalSoundsByOwner[objId];
                     }
                     EventListeners.removeEventListener(sc,Event.SOUND_COMPLETE,soundCompleteHandler);
                  };
                  a = this.positionalSoundsByOwner[objId] as Array;
                  if(a == null)
                  {
                     a = new Array();
                     this.positionalSoundsByOwner[objId] = a;
                  }
                  so = {
                     "owner":owner,
                     "soundChannel":sc,
                     "sound":sound
                  };
                  a.push(so);
                  EventListeners.addEventListener(sc,Event.SOUND_COMPLETE,soundCompleteHandler);
               }
            }
         }
      }
   }
}

