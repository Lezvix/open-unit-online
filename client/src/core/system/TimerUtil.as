package core.system
{
   import social.ISocialApi;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class TimerUtil extends Timer
   {
      
      public static var api:ISocialApi = null;
      
      private var timerCallback:Function = null;
      
      private var _signalParams:Object = null;
      
      private var intValue220:int;
      
      public function TimerUtil(param1:Number, param2:int = 0)
      {
         super(param1,param2);
         addEventListener(TimerEvent.TIMER,this.timerHandler);
         addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
      }
      
      public static function setTimeout(handler:Function, delay:Number, data:Object = null) : uint
      {
         var timeoutHandler:Function;
         timeoutHandler = function(data:Object):void
         {
            try
            {
               if(data != null)
               {
                  handler(data);
               }
               else
               {
                  handler();
               }
            }
            catch(e:Error)
            {
               if(api != null)
               {
                  api.reportError(null,e);
               }
            }
         };
         return flash.utils.setTimeout(timeoutHandler,delay,data);
      }
      
      public static function setInterval(handler:Function, delay:int, ... params) : int
      {
         var timeoutHandler:Function;
         timeoutHandler = function():void
         {
            try
            {
               handler.apply(null,params);
            }
            catch(e:Error)
            {
               if(api != null)
               {
                  api.reportError(null,e);
               }
            }
         };
         return flash.utils.setInterval(timeoutHandler,delay);
      }
      
      public static function clearInterval(param1:int) : void
      {
         flash.utils.clearInterval(param1);
      }
      
      public function get params() : Object
      {
         return this._signalParams;
      }
      
      public function set params(param1:Object) : void
      {
         _signalParams = param1;
      }
      
      public function dispose() : void
      {
         removeEventListener(TimerEvent.TIMER,this.timerHandler);
         removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
      }
      
      public function remove() : void
      {
         stop();
         this.dispose();
      }
      
      private function onTimerComplete(param1:Event) : void
      {
         this.dispose();
      }
      
      private function timerHandler(event:Object) : void
      {
         if(this.timerCallback != null)
         {
            try
            {
               if(this.params == null)
               {
                  this.timerCallback(event);
               }
               else
               {
                  this.timerCallback(event,this.params);
               }
            }
            catch(e:Error)
            {
               if(api != null)
               {
                  api.reportError(null,e);
               }
            }
         }
      }
      
      public function set handler(param1:Function) : void
      {
         timerCallback = param1;
      }
      
      public function get handler() : Function
      {
         return this.timerCallback;
      }
      
      public function get timeLeft() : int
      {
         return delay - getTimer() + this.intValue220;
      }
      
      override public function start() : void
      {
         super.start();
         intValue220 = getTimer();
      }
   }
}

