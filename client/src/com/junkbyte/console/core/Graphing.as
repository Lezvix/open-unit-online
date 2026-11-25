package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.GraphGroup;
   import com.junkbyte.console.vos.GraphInterest;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Graphing extends ConsoleCore
   {
      
      private var array99:Array;
      
      private var obj32:Object;
      
      private var graphGroup1:GraphGroup;
      
      private var graphGroup3:GraphGroup;
      
      private var flag3:Boolean;
      
      private var numValue11:Number = -1;
      
      public function Graphing(m:Console)
      {
         this.array99 = [];
         this.obj32 = {};
         super(m);
         remoter.registerCallback("fps",function(param1:ByteArray):void
         {
            fpsMonitor = param1.readBoolean();
         });
         remoter.registerCallback("mem",function(param1:ByteArray):void
         {
            memoryMonitor = param1.readBoolean();
         });
         remoter.registerCallback("removeGroup",function(param1:ByteArray):void
         {
            removeGroup(param1.readUTF());
         });
         remoter.registerCallback("graph",this.doAction66,true);
      }
      
      public function add(n:String, obj:Object, prop:String, col:Number = -1, key:String = null, rect:Rectangle = null, inverse:Boolean = false) : void
      {
         if(obj == null)
         {
            report("ERROR: Graph [" + n + "] received a null object to graph property [" + prop + "].",10);
            return;
         }
         var group:GraphGroup = this.obj32[n];
         var newGroup:Boolean;
         if(!group)
         {
            newGroup = true;
            group = new GraphGroup(n);
         }
         var interests:Array = group.interests;
         if(isNaN(col) || col < 0)
         {
            if(interests.length <= 5)
            {
               col = config.style["priority" + (10 - interests.length * 2)];
            }
            else
            {
               col = Math.random() * 16777215;
            }
         }
         if(key == null)
         {
            key = prop;
         }
         var i:GraphInterest;
         for each(i in interests)
         {
            if(i.key == key)
            {
               report("Graph with key [" + key + "] already exists in [" + n + "]",10);
               return;
            }
         }
         if(rect)
         {
            group.rect = rect;
         }
         if(inverse)
         {
            group.flag79 = inverse;
         }
         var interest:GraphInterest = new GraphInterest(key,col);
         var v:Number = NaN;
         try
         {
            v = interest.getNumber5(obj,prop);
         }
         catch(e:Error)
         {
            report("Error with graph value for [" + key + "] in [" + n + "]. " + e,10);
            return;
         }
         if(isNaN(v))
         {
            report("Graph value for key [" + key + "] in [" + n + "] is not a number (NaN).",10);
         }
         else
         {
            group.interests.push(interest);
            if(newGroup)
            {
               this.obj32[n] = group;
               this.array99.push(group);
            }
         }
      }
      
      public function doAction683(param1:String, param2:Number = NaN, param3:Number = NaN) : void
      {
         var graphGroup:GraphGroup = this.obj32[param1];
         if(!graphGroup)
         {
            return;
         }
         graphGroup.low = param2;
         graphGroup.hi = param3;
         graphGroup.flag23 = !(isNaN(param2) || isNaN(param3));
      }
      
      public function remove(param1:String, param2:Object = null, param3:String = null) : void
      {
         var interestList:Array = null;
         var index:int = 0;
         var interest:GraphInterest = null;
         if(param2 == null && param3 == null)
         {
            this.removeGroup(param1);
         }
         else if(this.obj32[param1])
         {
            interestList = this.obj32[param1].interests;
            index = interestList.length - 1;
            while(index >= 0)
            {
               interest = interestList[index];
               if((param2 == null || interest.obj == param2) && (param3 == null || interest.prop == param3))
               {
                  interestList.splice(index,1);
               }
               index--;
            }
            if(interestList.length == 0)
            {
               this.removeGroup(param1);
            }
         }
      }
      
      private function removeGroup(param1:String) : void
      {
         var payload:ByteArray = null;
         var graphGroup:GraphGroup = null;
         var groupIndex:int = 0;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            payload = new ByteArray();
            payload.writeUTF(param1);
            remoter.send("removeGroup",payload);
         }
         else
         {
            graphGroup = this.obj32[param1];
            groupIndex = this.array99.indexOf(graphGroup);
            if(groupIndex >= 0)
            {
               this.array99.splice(groupIndex,1);
            }
            delete this.obj32[param1];
         }
      }
      
      public function get fpsMonitor() : Boolean
      {
         if(remoter.remoting == Remoting.RECIEVER)
         {
            return console.panels.fpsMonitor;
         }
         return this.graphGroup1 != null;
      }
      
      public function set fpsMonitor(param1:Boolean) : void
      {
         var payload:ByteArray = null;
         var groupIndex:int = 0;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            payload = new ByteArray();
            payload.writeBoolean(param1);
            remoter.send("fps",payload);
         }
         else if(param1 != this.fpsMonitor)
         {
            if(param1)
            {
               graphGroup1 = this.getGraphGroup2(GraphGroup.FPS_PANEL);
               this.graphGroup1.low = 0;
               this.graphGroup1.flag23 = true;
               this.graphGroup1.averaging = 30;
            }
            else
            {
               numValue11 = -1;
               groupIndex = this.array99.indexOf(this.graphGroup1);
               if(groupIndex >= 0)
               {
                  this.array99.splice(groupIndex,1);
               }
               graphGroup1 = null;
            }
            console.panels.mainPanel.updateMenu();
         }
      }
      
      public function get memoryMonitor() : Boolean
      {
         if(remoter.remoting == Remoting.RECIEVER)
         {
            return console.panels.memoryMonitor;
         }
         return this.graphGroup3 != null;
      }
      
      public function set memoryMonitor(param1:Boolean) : void
      {
         var payload:ByteArray = null;
         var groupIndex:int = 0;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            payload = new ByteArray();
            payload.writeBoolean(param1);
            remoter.send("mem",payload);
         }
         else if(param1 != this.memoryMonitor)
         {
            if(param1)
            {
               graphGroup3 = this.getGraphGroup2(GraphGroup.MEMORY_PANEL);
               this.graphGroup3.intValue161 = 10;
            }
            else
            {
               groupIndex = this.array99.indexOf(this.graphGroup3);
               if(groupIndex >= 0)
               {
                  this.array99.splice(groupIndex,1);
               }
               graphGroup3 = null;
            }
            console.panels.mainPanel.updateMenu();
         }
      }
      
      private function getGraphGroup2(param1:int) : GraphGroup
      {
         var graphGroup:GraphGroup = new GraphGroup("special");
         graphGroup.type = param1;
         this.array99.push(graphGroup);
         var interest:GraphInterest = new GraphInterest("special");
         if(param1 == GraphGroup.FPS_PANEL)
         {
            interest.col = 16724787;
         }
         else
         {
            interest.col = 5267711;
         }
         graphGroup.interests.push(interest);
         return graphGroup;
      }
      
      public function update(fps:Number = 0) : Array
      {
         var interest:GraphInterest;
         var v:Number;
         var group:GraphGroup;
         var ok:Boolean;
         var typ:uint;
         var averaging:uint;
         var interests:Array;
         var time:int;
         var mspf:Number;
         var i:GraphInterest;
         var len:uint;
         var ga:ByteArray;
         var j:uint;
         for each(group in this.array99)
         {
            ok = true;
            if(group.intValue161 > 1)
            {
               ++group.intValue168;
               if(group.intValue168 < group.intValue161)
               {
                  ok = false;
               }
               else
               {
                  group.intValue168 = 0;
               }
            }
            if(ok)
            {
               typ = group.type;
               averaging = group.averaging;
               interests = group.interests;
               if(typ == GraphGroup.FPS_PANEL)
               {
                  group.hi = fps;
                  interest = interests[0];
                  time = getTimer();
                  if(this.numValue11 >= 0)
                  {
                     mspf = time - this.numValue11;
                     v = 1000 / mspf;
                     interest.setValue(v,averaging);
                  }
                  numValue11 = time;
               }
               else if(typ == GraphGroup.MEMORY_PANEL)
               {
                  interest = interests[0];
                  v = Math.round(System.totalMemory / 10485.76) / 100;
                  group.doAction686(v);
                  interest.setValue(v,averaging);
               }
               else
               {
                  for each(i in interests)
                  {
                     try
                     {
                        v = i.getNumber6();
                        i.setValue(v,averaging);
                     }
                     catch(e:Error)
                     {
                        report("Error with graph value for key [" + i.key + "] in [" + group.name + "]. " + e,10);
                        remove(group.name,i.obj,i.prop);
                     }
                     group.doAction686(v);
                  }
               }
            }
         }
         if(remoter.canSend && (this.flag3 || this.array99.length))
         {
            len = this.array99.length;
            ga = new ByteArray();
            j = 0;
            while(j < len)
            {
               GraphGroup(this.array99[j]).doAction32(ga);
               j++;
            }
            remoter.send("graph",ga);
            flag3 = this.array99.length > 0;
         }
         return this.array99;
      }
      
      private function doAction66(param1:ByteArray = null) : void
      {
         var groups:Array = null;
         if(param1 && param1.length)
         {
            param1.position = 0;
            groups = new Array();
            while(param1.bytesAvailable)
            {
               groups.push(GraphGroup.getGraphGroup1(param1));
            }
            console.panels.updateGraphs(groups);
         }
         else
         {
            console.panels.updateGraphs(new Array());
         }
      }
   }
}

