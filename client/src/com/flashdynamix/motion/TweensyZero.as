package com.flashdynamix.motion
{
   import core.effects.TweenEffect;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TweensyZero
   {
      
      public static const version:Number = 0.2;
      
      public static const TIME:String = "time";
      
      public static const FRAME:String = "frame";
      
      public static var callback11:Function = easeOut;
      
      public static var callback2:Function;

      public static var array111:Array;

      public static var onComplete:Function;

      public static var array78:Array;

      public static var flag67:Boolean = true;
      
      private static var numValue45:Number = 1 / 30;
      
      private static var frame:Sprite = new Sprite();
      
      private static var time:int = 0;
      
      private static var TIME2:String = "time";
      
      private static var intValue65:Boolean = false;
      
      private static var tweensyTimelineZeroList2:Vector.<TweensyTimelineZero> = new Vector.<TweensyTimelineZero>();
      
      private static var dict6:Dictionary = new Dictionary(true);
      
      public function TweensyZero()
      {
         super();
      }
      
      public static function getTweensyTimelineZero4(param1:Object) : TweensyTimelineZero
      {
         if(!isValue33)
         {
            doAction437();
         }
         var timeline:TweensyTimelineZero = getTweensyTimelineZero1(param1);
         add(timeline);
         return timeline;
      }
      
      public static function to(param1:Object, param2:Object, param3:Number = 0.5, param4:Function = null, param5:Number = 0, param6:Function = null, param7:Array = null) : TweensyTimelineZero
      {
         if(!isValue33)
         {
            doAction437();
         }
         var timeline:TweensyTimelineZero = getTweensyTimelineZero3(param1,param2,param3,param4,param5,param6,param7);
         add(timeline);
         return timeline;
      }
      
      public static function getTweensyTimelineZero5(param1:TweensyTimelineZero) : TweensyTimelineZero
      {
         if(!isValue33)
         {
            doAction437();
         }
         param1 = getTweensyTimelineZero2(param1);
         add(param1);
         return param1;
      }
      
      private static function add(param1:TweensyTimelineZero) : void
      {
         var timelineIndex:int;
         var timelineCount:int;
         var existingTimeline:TweensyTimelineZero;
         var endTime:Number;
         var propertyKey:String;
         if(flag67)
         {
            timelineIndex = 0;
            timelineCount = tweensyTimelineZeroList2.length;
            timelineIndex = timelineCount - 1;
            while(timelineIndex >= 0)
            {
               existingTimeline = tweensyTimelineZeroList2[timelineIndex];
               endTime = existingTimeline.numValue50 + existingTimeline.duration + existingTimeline.numValue59;
               if(existingTimeline.key == param1.key && param1.numValue50 < endTime - existingTimeline.numValue52)
               {
                  for(propertyKey in param1.to)
                  {
                     if(existingTimeline.hasOwnProperty(propertyKey))
                     {
                        delete existingTimeline.to[propertyKey];
                        delete existingTimeline.obj13[propertyKey];
                        --existingTimeline.properties;
                     }
                  }
                  if(existingTimeline.properties == 0)
                  {
                     remove(timelineIndex);
                  }
               }
               timelineIndex--;
            }
         }
         tweensyTimelineZeroList2.push(param1);
         doAction430(param1,tweensyTimelineZeroList2.length - 1);
      }
      
      private static function getTweensyTimelineZero2(param1:TweensyTimelineZero) : TweensyTimelineZero
      {
         var propertyKey:String = null;
         param1.callback14 = param1.callback14 != null ? param1.callback14 : callback11;
         param1.key = param1.instance;
         for(propertyKey in param1.to)
         {
            param1.to[propertyKey] = translate(param1.instance[propertyKey],param1.to[propertyKey]);
            ++param1.properties;
         }
         return param1;
      }
      
      private static function getTweensyTimelineZero1(param1:Object) : TweensyTimelineZero
      {
         var timeline:TweensyTimelineZero = new TweensyTimelineZero();
         var propertyKey:String;
         for(propertyKey in param1)
         {
            timeline[propertyKey] = param1[propertyKey];
         }
         timeline.callback14 = timeline.callback14 != null ? timeline.callback14 : callback11;
         timeline.key = timeline.instance;
         for(propertyKey in param1.to)
         {
            timeline.to[propertyKey] = translate(timeline.instance[propertyKey],timeline.to[propertyKey]);
            ++timeline.properties;
         }
         return timeline;
      }
      
      private static function getTweensyTimelineZero3(param1:Object, param2:Object, param3:Number, param4:Function, param5:Number, param6:Function, param7:Array) : TweensyTimelineZero
      {
         var timeline:TweensyTimelineZero = new TweensyTimelineZero();
         var propertyKey:String;
         timeline.instance = param1;
         timeline.duration = param3;
         timeline.callback14 = param4 != null ? param4 : callback11;
         timeline.numValue50 = param5;
         timeline.onComplete = param6;
         timeline.array78 = param7;
         timeline.key = param1;
         for(propertyKey in param2)
         {
            timeline.to[propertyKey] = translate(param1[propertyKey],param2[propertyKey]);
            ++timeline.properties;
         }
         return timeline;
      }
      
      public static function stop(param1:* = null, param2:Array = null, param3:TweenEffect = null) : void
      {
         var timeline:TweensyTimelineZero;
         var timelineIndex:int = tweensyTimelineZeroList2.length - 1;
         var propertyKey:String;
         while(timelineIndex >= 0)
         {
            timeline = tweensyTimelineZeroList2[timelineIndex];
            if(timeline.key == param1)
            {
               if(param2 == null || param2.length == 0)
               {
                  remove(timelineIndex);
               }
               else
               {
                  for(propertyKey in timeline.to)
                  {
                     if(param2.indexOf(propertyKey) != -1)
                     {
                        delete timeline.to[propertyKey];
                        delete timeline.obj13[propertyKey];
                        --timeline.properties;
                     }
                  }
                  if(timeline.properties == 0 || timeline.effect == param3)
                  {
                     remove(timelineIndex);
                  }
               }
            }
            timelineIndex--;
         }
         if(tweensyTimelineZeroList2.length == 0)
         {
            doAction619();
         }
      }
      
      private static function remove(param1:int) : void
      {
         var removedTimelines:Vector.<TweensyTimelineZero> = tweensyTimelineZeroList2.splice(param1,1);
         var timeline:TweensyTimelineZero = removedTimelines[0];
         var tweenEffect:TweenEffect = timeline.effect;
         if(timeline.onComplete != null)
         {
            timeline.onComplete.apply(null,timeline.array78);
         }
      }
      
      public static function doAction296(param1:TweensyTimelineZero) : void
      {
         var timelineIndex:int = 0;
         timelineIndex = getInt16(param1);
         if(timelineIndex >= 0)
         {
            tweensyTimelineZeroList2.splice(timelineIndex,1);
         }
         if(tweensyTimelineZeroList2.length == 0)
         {
            doAction619();
         }
      }
      
      private static function getInt30(param1:*) : int
      {
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timeline:TweensyTimelineZero;
         var timelineIndex:int = 0;
         while(timelineIndex < timelineCount)
         {
            timeline = tweensyTimelineZeroList2[timelineIndex];
            if(timeline.key == param1)
            {
               return timelineIndex;
            }
            timelineIndex++;
         }
         return -1;
      }
      
      public static var obj38:Object = null;

      public static function doAction797(param1:*) : void
      {
         var timelineIndex:int = 0;
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timeline:TweensyTimelineZero;
         obj38 = param1;
         timelineIndex = timelineCount - 1;
         while(timelineIndex >= 0)
         {
            timeline = tweensyTimelineZeroList2[timelineIndex];
            if(timeline.instance == param1)
            {
               remove(timelineIndex);
            }
            timelineIndex--;
         }
         obj38 = null;
      }
      
      public static function doAction618(param1:*) : void
      {
         var timelineIndex:int = 0;
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timeline:TweensyTimelineZero;
         timelineIndex = timelineCount - 1;
         while(timelineIndex >= 0)
         {
            timeline = tweensyTimelineZeroList2[timelineIndex];
            if(timeline.instance == param1)
            {
               tweensyTimelineZeroList2.splice(timelineIndex,1);
            }
            timelineIndex--;
         }
      }
      
      public static function getArray14(param1:*) : Array
      {
         var effects:Array = null;
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timeline:TweensyTimelineZero;
         var timelineIndex:int = 0;
         while(timelineIndex < timelineCount)
         {
            timeline = tweensyTimelineZeroList2[timelineIndex];
            if(timeline.instance == param1)
            {
               if(effects == null)
               {
                  effects = new Array();
               }
               effects.push(timeline.effect);
            }
            timelineIndex++;
         }
         return effects;
      }
      
      private static function getInt16(param1:*) : int
      {
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timelineIndex:int = 0;
         while(timelineIndex < timelineCount)
         {
            if(param1 == tweensyTimelineZeroList2[timelineIndex])
            {
               return timelineIndex;
            }
            timelineIndex++;
         }
         return -1;
      }
      
      public static function doAction884() : void
      {
         tweensyTimelineZeroList2 = new Vector.<TweensyTimelineZero>();
         doAction619();
      }
      
      public static function pause() : void
      {
         if(intValue65)
         {
            return;
         }
         intValue65 = true;
         doAction619();
      }
      
      public static function doAction377() : void
      {
         if(!intValue65)
         {
            return;
         }
         intValue65 = false;
         doAction437();
      }
      
      public static function get paused() : Boolean
      {
         return intValue65;
      }
      
      public static function set propValue56(param1:Number) : void
      {
         numValue45 = param1;
      }
      
      public static function get propValue56() : Number
      {
         return numValue45;
      }
      
      public static function set TIME2Value(param1:String) : void
      {
         TIME2 = param1;
      }
      
      public static function get TIME2Value() : String
      {
         return TIME2;
      }
      
      public static function get propValue57() : int
      {
         return tweensyTimelineZeroList2.length;
      }
      
      public static function get isValue33() : Boolean
      {
         return propValue57 > 0;
      }
      
      private static function doAction430(param1:TweensyTimelineZero, param2:int) : void
      {
         var easingArgs:Array;
         var elapsed:Number;
         var isComplete:Boolean;
         var propertyKey:String;
         var easedValue:Number;
         var remainingWeight:Number;
         var propertyValue:Number;
         if(param1.numValue52 >= param1.numValue50)
         {
            elapsed = param1.numValue52 - param1.numValue50;
            elapsed = (elapsed > param1.duration) ? param1.duration : elapsed;
            isComplete = elapsed >= param1.duration + param1.numValue59;
            if(isComplete)
            {
               tweensyTimelineZeroList2.splice(param2,1);
               for(propertyKey in param1.to)
               {
                  param1.instance[propertyKey] = param1.to[propertyKey];
               }
               if(param1.callback2 != null)
               {
                  param1.callback2.apply(null,param1.array111);
               }
               if(param1.onComplete != null)
               {
                  param1.onComplete.apply(null,param1.array78);
               }
            }
            else
            {
               easingArgs = [elapsed,0,1,param1.duration].concat(param1.array72);
               easedValue = param1.callback14.apply(null,easingArgs);
               remainingWeight = 1 - easedValue;
               for(propertyKey in param1.to)
               {
                  if(param1.obj13[propertyKey] == null)
                  {
                     param1.obj13[propertyKey] = param1.instance[propertyKey];
                  }
                  propertyValue = param1.obj13[propertyKey] * remainingWeight + param1.to[propertyKey] * easedValue;
                  param1.instance[propertyKey] = propertyValue;
               }
               if(param1.callback2 != null)
               {
                  param1.callback2.apply(null,param1.array111);
               }
            }
         }
      }
      
      private static function update(param1:Event) : void
      {
         var elapsed:Number;
         if(TIME2Value == TIME)
         {
            elapsed = getTimer() - time;
            time += elapsed;
            elapsed *= 0.001;
         }
         var timelineIndex:int = 0;
         var timelineCount:int = tweensyTimelineZeroList2.length;
         var timeline:TweensyTimelineZero;
         timelineIndex = timelineCount - 1;
         while(timelineIndex >= 0)
         {
            if(timelineIndex < tweensyTimelineZeroList2.length)
            {
               timeline = tweensyTimelineZeroList2[timelineIndex];
               timeline.numValue52 += elapsed;
               doAction430(timeline,timelineIndex);
            }
            timelineIndex--;
         }
         if(callback2 != null)
         {
            callback2.apply(null,array111);
         }
         if(!isValue33)
         {
            doAction619();
            if(onComplete != null)
            {
               onComplete.apply(null,array78);
            }
         }
      }
      
      private static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
      }
      
      private static function doAction437() : void
      {
         time = getTimer();
         frame.addEventListener(Event.ENTER_FRAME,update,false,0,true);
      }
      
      private static function doAction619() : void
      {
         frame.removeEventListener(Event.ENTER_FRAME,update);
      }
      
      private static function translate(param1:Number, param2:*) : Number
      {
         var resultValue:Number;
         var parts:Array;
         var minimumOffset:Number;
         var maximumOffset:Number;
         if(param2 is String)
         {
            parts = (param2 as String).split(",");
            if(parts.length == 1)
            {
               resultValue = param1 + parseFloat(param2);
            }
            else
            {
               minimumOffset = parseFloat(parts[0]);
               maximumOffset = parseFloat(parts[1]);
               resultValue = param1 + minimumOffset + Math.random() * (maximumOffset - minimumOffset);
            }
         }
         else
         {
            resultValue = param2;
         }
         return resultValue;
      }
      
      public function toString() : String
      {
         return "TweensyZero " + version + " {timelines:" + propValue57 + "}";
      }
   }
}

