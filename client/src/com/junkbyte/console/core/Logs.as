package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.Log;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class Logs extends ConsoleCore
   {
      
      private var obj40:Object;
      
      private var uintValue10:uint;
      
      private var log2:Log;
      
      private var log3:Log;
      
      private var flag94:Boolean;
      
      private var glowTimer:uint;
      
      public var first:Log;
      
      public var last:Log;
      
      private var uintValue21:uint;
      
      private var uintValue9:uint;
      
      public function Logs(console:Console)
      {
         super(console);
         this.obj40 = new Object();
         remoter.addEventListener(Event.CONNECT,this.onRemoterConnect2);
         remoter.registerCallback("log",function(param1:ByteArray):void
         {
            registerLog(Log.getGraphGroup1(param1));
         });
      }
      
      private function onRemoterConnect2(param1:Event) : void
      {
         var entry:Log = this.first;
         while(entry)
         {
            this.doAction194(entry);
            entry = entry.next;
         }
      }
      
      private function doAction194(param1:Log) : void
      {
         var payload:ByteArray = null;
         if(remoter.canSend)
         {
            payload = new ByteArray();
            param1.doAction32(payload);
            remoter.send("log",payload);
         }
      }
      
      public function update(param1:uint) : Boolean
      {
         glowTimer = param1;
         if(this.uintValue10 > 0)
         {
            --this.uintValue10;
         }
         if(this.log3)
         {
            if(this.log2)
            {
               this.remove(this.log2);
            }
            log2 = this.log3;
            log3 = null;
            this.push(this.log2);
         }
         var wasUpdated:Boolean = this.flag94;
         flag94 = false;
         return wasUpdated;
      }
      
      public function add(param1:Log) : void
      {
         ++this.uintValue9;
         param1.line = this.uintValue9;
         param1.time = this.glowTimer;
         this.registerLog(param1);
      }
      
      private function registerLog(param1:Log) : void
      {
         flag94 = true;
         this.addChannel(param1.ch);
         param1.str11 = param1.line + " ";
         param1.str24 = "[<a href=\"event:channel_" + param1.ch + "\">" + param1.ch + "</a>] ";
         param1.timeStr = config.timeStampFormatter(param1.time) + " ";
         this.doAction194(param1);
         if(param1.repeat)
         {
            if(this.uintValue10 > 0 && this.log2)
            {
               param1.line = this.log2.line;
               log3 = param1;
               return;
            }
            uintValue10 = config.maxRepeats;
            log2 = param1;
         }
         this.push(param1);
         while(this.uintValue21 > config.maxLines && config.maxLines > 0)
         {
            this.remove(this.first);
         }
         if(config.tracing && config.traceCall != null)
         {
            config.traceCall(param1.ch,param1.getString26(),param1.priority);
         }
      }
      
      public function clear(param1:String = null) : void
      {
         var entry:Log = null;
         if(param1)
         {
            entry = this.first;
            while(entry)
            {
               if(entry.ch == param1)
               {
                  this.remove(entry);
               }
               entry = entry.next;
            }
            delete this.obj40[param1];
         }
         else
         {
            first = null;
            last = null;
            uintValue21 = 0;
            obj40 = new Object();
         }
      }
      
      public function getLogsAsString(param1:String, param2:Boolean = true, param3:Function = null) : String
      {
         var output:String = "";
         var entry:Log = this.first;
         while(entry)
         {
            if(param3 == null || param3(entry))
            {
               if(this.first != entry)
               {
                  output += param1;
               }
               output += param2 ? entry.toString() : entry.getString26();
            }
            entry = entry.next;
         }
         return output;
      }
      
      public function getChannels() : Array
      {
         var specialChannels:Array = new Array(Console.CONSOLE_CONST1);
         this.doAction164(Console.CONSOLE_CONST3,specialChannels);
         this.doAction164(Console.CONSOLE_CONST4,specialChannels);
         this.doAction164(LogReferences.LOG_REFERENCES_CONST1,specialChannels);
         this.doAction164(Console.C2,specialChannels);
         var otherChannels:Array = new Array();
         var channel:String;
         for(channel in this.obj40)
         {
            if(specialChannels.indexOf(channel) < 0)
            {
               otherChannels.push(channel);
            }
         }
         return specialChannels.concat(otherChannels.sort(Array.CASEINSENSITIVE));
      }
      
      private function doAction164(param1:String, param2:Array) : void
      {
         if(this.obj40.hasOwnProperty(param1))
         {
            param2.push(param1);
         }
      }
      
      public function doAction329() : void
      {
         obj40 = new Object();
         var entry:Log = this.first;
         while(entry)
         {
            this.addChannel(entry.ch);
            entry = entry.next;
         }
      }
      
      public function addChannel(param1:String) : void
      {
         this.obj40[param1] = null;
      }
      
      private function push(param1:Log) : void
      {
         if(this.last == null)
         {
            first = param1;
         }
         else
         {
            this.last.next = param1;
            param1.log1 = this.last;
         }
         last = param1;
         ++this.uintValue21;
      }
      
      private function remove(param1:Log) : void
      {
         if(this.first == param1)
         {
            first = param1.next;
         }
         if(this.last == param1)
         {
            last = param1.log1;
         }
         if(param1 == this.log2)
         {
            log2 = null;
         }
         if(param1 == this.log3)
         {
            log3 = null;
         }
         if(param1.next != null)
         {
            param1.next.log1 = param1.log1;
         }
         if(param1.log1 != null)
         {
            param1.log1.next = param1.next;
         }
         --this.uintValue21;
      }
   }
}

