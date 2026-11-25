package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class MemoryMonitor extends ConsoleCore
   {
      
      private var obj21:Object;
      
      private var _namesList:Dictionary;
      
      private var uintValue11:uint;
      
      public function MemoryMonitor(param1:Console)
      {
         super(param1);
         this.obj21 = new Object();
         this._namesList = new Dictionary(true);
         console.remoter.registerCallback("gc",this.gc);
      }
      
      public function getString9(param1:Object, param2:String) : String
      {
         var className:String = getQualifiedClassName(param1);
         if(!param2)
         {
            param2 = className + "@" + getTimer();
         }
         if(this._namesList[param1])
         {
            if(this.obj21[this._namesList[param1]])
            {
               this.doAction104(this._namesList[param1]);
            }
         }
         if(this.obj21[param2])
         {
            if(this._namesList[param1] == param2)
            {
               --this.uintValue11;
            }
            else
            {
               param2 = param2 + "@" + getTimer() + "_" + Math.floor(Math.random() * 100);
            }
         }
         this.obj21[param2] = true;
         ++this.uintValue11;
         this._namesList[param1] = param2;
         return param2;
      }
      
      public function doAction104(param1:String) : void
      {
         var trackedObject:Object = null;
         for(trackedObject in this._namesList)
         {
            if(this._namesList[trackedObject] == param1)
            {
               delete this._namesList[trackedObject];
            }
         }
         if(this.obj21[param1])
         {
            delete this.obj21[param1];
            --this.uintValue11;
         }
      }
      
      public function update() : void
      {
         if(this.uintValue11 == 0)
         {
            return;
         }
         var collectedNames:Array = new Array();
         var liveNames:Object = new Object();
         var trackedObject:Object;
         var trackedName:String;
         for(trackedObject in this._namesList)
         {
            liveNames[this._namesList[trackedObject]] = true;
         }
         for(trackedName in this.obj21)
         {
            if(!liveNames[trackedName])
            {
               collectedNames.push(trackedName);
               delete this.obj21[trackedName];
               --this.uintValue11;
            }
         }
         if(collectedNames.length)
         {
            report("<b>GARBAGE COLLECTED " + collectedNames.length + " item(s): </b>" + collectedNames.join(", "),-2);
         }
      }
      
      public function get count() : uint
      {
         return this.uintValue11;
      }
      
      public function gc() : void
      {
         var ok:Boolean = false;
         var str:String = null;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            try
            {
               remoter.send("gc");
            }
            catch(e:Error)
            {
               report(e,10);
            }
         }
         else
         {
            try
            {
               if(System["gc"] != null)
               {
                  System["gc"]();
                  ok = true;
               }
            }
            catch(e:Error)
            {
            }
            str = "Manual garbage collection " + (ok ? "successful." : "FAILED. You need debugger version of flash player.");
            report(str,ok ? -1 : 10);
         }
      }
   }
}

