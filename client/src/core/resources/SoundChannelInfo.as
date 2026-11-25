package core.resources
{
   import flash.media.SoundChannel;
   
   public class SoundChannelInfo
   {
      
      public var soundChannel:SoundChannel;
      
      public var completeHandler:Function = null;
      
      public var stopedHandler:Function = null;
      
      public function SoundChannelInfo()
      {
         super();
      }
   }
}

