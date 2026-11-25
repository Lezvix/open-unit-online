package core.effects
{
   import social.SocialApi;
   import com.flashdynamix.motion.TweensyTimelineZero;
   import com.flashdynamix.motion.TweensyZero;
   import fl.motion.easing.Linear;
   
   public class TweenEffect
   {
      
      public var to:Object = {};
      
      public var obj13:Object = {};
      
      public var callback14:Function;
      
      public var numValue50:Number = 0;
      
      public var numValue59:Number = 0;
      
      private var _tweenDuration:Number = 0;
      
      private var tweensyTimelineZeroList1:Vector.<TweensyTimelineZero> = null;
      
      private var array17:Array = null;
      
      private var _tweenPlaying:Boolean = false;
      
      private var flag74:Boolean = false;
      
      private var functionList1:Vector.<Function> = new Vector.<Function>();
      
      private var endListeners:Vector.<Function> = new Vector.<Function>();
      
      private var tweenTimeline:TweensyTimelineZero = null;
      
      private var intValue145:int = 0;
      
      private var intValue75:int = 1;
      
      private var intValue186:int;
      
      public function TweenEffect(param1:Object = null)
      {
         super();
         this._tweenDuration = 0.5;
         this.callback14 = Linear.easeNone;
         this.instance = param1;
      }
      
      public static function doAction797(param1:Object) : void
      {
         TweensyZero.doAction797(param1);
      }
      
      public function get tweenRepeatCount() : int
      {
         return this.intValue75;
      }
      
      public function set tweenRepeatCount(param1:int) : void
      {
         intValue75 = param1;
      }
      
      public function set instance(param1:Object) : void
      {
         if(param1 == null)
         {
            array17 = null;
         }
         else
         {
            array17 = [param1];
         }
      }
      
      public function get instance() : Object
      {
         if(this.tweenTimeline != null)
         {
            return this.tweenTimeline.instance;
         }
         if(this.array17 != null)
         {
            return this.array17[0];
         }
         return null;
      }
      
      public function set tweenTargets(param1:Array) : void
      {
         array17 = param1;
      }
      
      public function get tweenTargets() : Array
      {
         return this.array17;
      }
      
      public function get propValue156() : Number
      {
         return this.callback14(this.time,0,this._tweenDuration,this._tweenDuration);
      }
      
      public function get time() : Number
      {
         return Math.min(this.tweenTimeline.numValue52 - this.numValue50,this._tweenDuration);
      }
      
      protected function doAction822() : void
      {
         var f:Function = null;
         for each(f in this.functionList1)
         {
            try
            {
               f(this);
            }
            catch(e:Error)
            {
               if(SocialApi.api != null)
               {
                  SocialApi.api.reportError(null,e);
               }
            }
         }
         flag74 = true;
      }
      
      private function doAction228(param1:TweensyTimelineZero) : void
      {
         if(!this.flag74)
         {
            this.doAction822();
         }
         tweenTimeline = param1;
         this.updateHandler();
         this.doAction102();
         tweenTimeline = null;
      }
      
      private function doAction102() : void
      {
      }
      
      public function dispose() : void
      {
         this.stop();
         if(this.endListeners.length > 0)
         {
            endListeners = new __AS3__.vec.Vector.<Function>(0);
         }
      }
      
      protected function updateHandler() : void
      {
      }
      
      public function doAction11(param1:Function) : void
      {
         this.functionList1.push(param1);
      }
      
      public function doAction161(listener:Function) : void
      {
         var index:int = this.functionList1.indexOf(listener);
         if(index >= 0)
         {
            this.functionList1.splice(index,1);
         }
      }
      
      public function addEndListener(param1:Function) : void
      {
         this.endListeners.push(param1);
      }
      
      public function removeEndListener(listener:Function) : void
      {
         var index:int = this.endListeners.indexOf(listener);
         if(index >= 0)
         {
            this.endListeners.splice(index,1);
         }
      }
      
      protected function get isValue26() : Boolean
      {
         return this.array17 != null && this.array17.indexOf(TweensyZero.obj38) >= 0;
      }
      
      protected function doAction110(timeline:TweensyTimelineZero, forceFinish:Boolean = false) : void
      {
         var pc:int;
         var f:Function;
         tweenTimeline = timeline;
         this.onStop();
         tweenTimeline = null;
         if(this.intValue145 <= 0)
         {
            if((this.intValue75 <= 0 || this.intValue186 > 1) && !forceFinish && !this.isValue26)
            {
               pc = this.intValue186;
               this.play();
               intValue186 = pc - 1;
            }
            else
            {
               _tweenPlaying = false;
               flag74 = false;
               for each(f in this.endListeners)
               {
                  try
                  {
                     f(this);
                  }
                  catch(e:Error)
                  {
                     if(SocialApi.api != null)
                     {
                        SocialApi.api.reportError(null,e);
                     }
                  }
               }
            }
         }
      }
      
      private function completeHandler(param1:TweensyTimelineZero) : void
      {
         --this.intValue145;
         this.doAction110(param1);
      }
      
      public function get isPlaying() : Boolean
      {
         return this._tweenPlaying;
      }
      
      protected function init() : void
      {
      }
      
      protected function doAction764(param1:Object = null) : void
      {
         if(param1 != null)
         {
            instance = param1;
         }
         if(this.instance == null)
         {
            throw new Error("effect target must be not null");
         }
         this.stop();
         tweensyTimelineZeroList1 = new Vector.<TweensyTimelineZero>();
         _tweenPlaying = true;
         flag74 = false;
         intValue186 = this.intValue75;
      }
      
      public function play(target:Object = null, reversed:Boolean = false) : void
      {
         var currentTarget:Object = null;
         var properties:Array = null;
         var timeline:TweensyTimelineZero = null;
         var property:String = null;
         var index:int = 0;
         this.doAction764(target);
         for each(currentTarget in this.array17)
         {
            properties = this.getTweenedProps();
            TweensyZero.stop(currentTarget,properties,this);
            timeline = new TweensyTimelineZero();
            this.tweensyTimelineZeroList1.push(timeline);
            tweenTimeline = timeline;
            timeline.instance = currentTarget;
            this.init();
            timeline.numValue50 = this.numValue50;
            timeline.numValue59 = this.numValue59;
            timeline.duration = this._tweenDuration;
            timeline.properties = 0;
            timeline.effect = this;
            timeline.onStop = this.onStop;
            if(reversed)
            {
               for(property in this.to)
               {
                  timeline.to[property] = this.obj13[property];
               }
               for(property in this.obj13)
               {
                  timeline.obj13[property] = this.to[property];
               }
            }
            else
            {
               for(property in this.to)
               {
                  timeline.to[property] = this.to[property];
               }
               for(property in this.obj13)
               {
                  timeline.obj13[property] = this.obj13[property];
               }
            }
            index = properties.length - 1;
            while(index >= 0)
            {
               if(timeline.to[properties[index]] == null)
               {
                  ++timeline.properties;
               }
               index--;
            }
            timeline.callback14 = this.callback14;
            timeline.array78 = [timeline];
            timeline.onComplete = this.completeHandler;
            timeline.array111 = [timeline];
            timeline.callback2 = this.doAction228;
            TweensyZero.getTweensyTimelineZero5(timeline);
         }
         tweenTimeline = null;
         intValue145 = this.array17.length;
      }
      
      protected function getTweenedProps() : Array
      {
         throw new Error("NLEffect getTweenedProps must be overrided");
      }
      
      protected function onStop() : void
      {
      }
      
      public function stop() : void
      {
         var timeline:TweensyTimelineZero = null;
         if(this.tweensyTimelineZeroList1 != null)
         {
            for each(timeline in this.tweensyTimelineZeroList1)
            {
               tweenTimeline = timeline;
               this.onStop();
               this.doAction102();
               TweensyZero.doAction296(timeline);
            }
            tweenTimeline = null;
         }
         _tweenPlaying = false;
         intValue145 = 0;
      }
      
      public function end() : void
      {
         var timeline:TweensyTimelineZero = null;
         var property:String = null;
         if(this._tweenPlaying)
         {
            for each(timeline in this.tweensyTimelineZeroList1)
            {
               for(property in this.to)
               {
                  timeline.instance[property] = timeline.to[property];
               }
               this.doAction228(timeline);
            }
            tweenTimeline = null;
            this.stop();
         }
      }
      
      public function reverse() : void
      {
         var timeline:TweensyTimelineZero = null;
         var property:String = null;
         var previousValue:Object = null;
         for each(timeline in this.tweensyTimelineZeroList1)
         {
            for(property in this.to)
            {
               previousValue = timeline.to[property];
               timeline.to[property] = timeline.obj13[property];
               timeline.obj13[property] = previousValue;
            }
         }
         tweenTimeline = null;
      }
      
      public function get duration() : Number
      {
         return this._tweenDuration;
      }
      
      public function set duration(param1:Number) : void
      {
         _tweenDuration = param1;
      }
   }
}

