package com.junkbyte.console.core
{
   import com.junkbyte.console.Cc;
   import com.junkbyte.console.Console;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class ConsoleTools extends ConsoleCore
   {
      
      public function ConsoleTools(param1:Console)
      {
         super(param1);
      }
      
      public function map(param1:DisplayObjectContainer, param2:uint = 0, param3:String = null) : void
      {
         if(!param1)
         {
            report("Not a DisplayObjectContainer.",10,true,param3);
            return;
         }
         var depth:int = 0;
         var omissionReported:Boolean;
         var queueIndex:int = 0;
         var previousObject:DisplayObject = null;
         var pendingObjects:Array = new Array();
         var currentObject:DisplayObject;
         var lineText:String;
         var container:DisplayObjectContainer;
         var childCount:int;
         var index:int;
         var childDisplay:DisplayObject;
         var referenceId:uint;
         var displayName:String;
         pendingObjects.push(param1);
         while(queueIndex < pendingObjects.length)
         {
            currentObject = pendingObjects[queueIndex];
            queueIndex++;
            if(currentObject is DisplayObjectContainer)
            {
               container = currentObject as DisplayObjectContainer;
               childCount = container.numChildren;
               index = 0;
               while(index < childCount)
               {
                  childDisplay = container.getChildAt(index);
                  pendingObjects.splice(queueIndex + index,0,childDisplay);
                  index++;
               }
            }
            if(previousObject)
            {
               if(previousObject is DisplayObjectContainer && (previousObject as DisplayObjectContainer).contains(currentObject))
               {
                  depth++;
               }
               else
               {
                  while(previousObject)
                  {
                     previousObject = previousObject.parent;
                     if(previousObject is DisplayObjectContainer)
                     {
                        if(depth > 0)
                        {
                           depth--;
                        }
                        if((previousObject as DisplayObjectContainer).contains(currentObject))
                        {
                           depth++;
                           break;
                        }
                     }
                  }
               }
            }
            lineText = "";
            index = 0;
            while(index < depth)
            {
               lineText += (index == depth - 1) ? " ∟ " : " - ";
               index++;
            }
            if(param2 <= 0 || depth <= param2)
            {
               omissionReported = false;
               referenceId = console.refs.setLogRef(currentObject);
               displayName = currentObject.name;
               if(referenceId)
               {
                  displayName = "<a href=\'event:cl_" + referenceId + "\'>" + displayName + "</a>";
               }
               if(currentObject is DisplayObjectContainer)
               {
                  displayName = "<b>" + displayName + "</b>";
               }
               else
               {
                  displayName = "<i>" + displayName + "</i>";
               }
               lineText += displayName + " " + console.refs.makeRefTyped(currentObject);
               report(lineText,currentObject is DisplayObjectContainer ? 5 : 2,true,param3);
            }
            else if(!omissionReported)
            {
               omissionReported = true;
               report(lineText + "...",5,true,param3);
            }
            previousObject = currentObject;
         }
         report(param1.name + ":" + console.refs.makeRefTyped(param1) + " has " + (pendingObjects.length - 1) + " children/sub-children.",9,true,param3);
         if(config.commandLineAllowed)
         {
            report("Click on the child display\'s name to set scope.",-2,true,param3);
         }
      }
      
      public function explode(param1:Object, param2:int = 3, param3:int = 9) : String
      {
         var valueType:String = typeof param1;
         if(param1 == null)
         {
            return "<p-2>" + param1 + "</p-2>";
         }
         if(param1 is String)
         {
            return "\"" + LogReferences.EscHTML(param1 as String) + "\"";
         }
         if(valueType != "object" || param2 == 0 || param1 is ByteArray)
         {
            return console.refs.makeString(param1);
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         var typeInfo:XML = describeType(param1);
         var nodes:XMLList;
         var propertyName:String;
         var parts:Array = [];
         var accessorNode:XML;
         var variableNode:XML;
         var dynamicKey:String;
         nodes = typeInfo["accessor"];
         for each(accessorNode in nodes)
         {
            propertyName = accessorNode.@name;
            if(accessorNode.@access != "writeonly")
            {
               try
               {
                  parts.push(this.getString23(param1,propertyName,param2,param3));
               }
               catch(e:Error)
               {
               }
            }
            else
            {
               parts.push(propertyName);
            }
         }
         nodes = typeInfo["variable"];
         for each(variableNode in nodes)
         {
            propertyName = variableNode.@name;
            parts.push(this.getString23(param1,propertyName,param2,param3));
         }
         try
         {
            for(dynamicKey in param1)
            {
               parts.push(this.getString23(param1,dynamicKey,param2,param3));
            }
         }
         catch(e:Error)
         {
         }
         return "<p" + param3 + ">{" + LogReferences.ShortClassName(param1) + "</p" + param3 + "> " + parts.join(", ") + "<p" + param3 + ">}</p" + param3 + ">";
      }
      
      private function getString23(param1:*, param2:String, param3:int, param4:int) : String
      {
         return param2 + ":" + this.explode(param1[param2],param3 - 1,param4 - 1);
      }
      
      public function getString2(param1:int, param2:int) : String
      {
         var error:Error = new Error();
         var stackTrace:String = error.hasOwnProperty("getStackTrace") ? error.getStackTrace() : null;
         if(!stackTrace)
         {
            return "";
         }
         var output:String = "";
         var frames:Array = stackTrace.split(/\n\sat\s/);
         var frameCount:int = frames.length;
         var ignoredPattern:RegExp = new RegExp("Function|" + getQualifiedClassName(Console) + "|" + getQualifiedClassName(Cc));
         var foundCaller:Boolean = false;
         var frameIndex:int = 2;
         while(frameIndex < frameCount)
         {
            if(!foundCaller && frames[frameIndex].search(ignoredPattern) != 0)
            {
               foundCaller = true;
            }
            if(foundCaller)
            {
               output += "\n<p" + param2 + "> @ " + frames[frameIndex] + "</p" + param2 + ">";
               if(param2 > 0)
               {
                  param2--;
               }
               param1--;
               if(param1 <= 0)
               {
                  break;
               }
            }
            frameIndex++;
         }
         return output;
      }
   }
}

