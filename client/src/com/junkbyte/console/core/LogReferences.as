package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.WeakObject;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class LogReferences extends ConsoleCore
   {
      
      public static const LOG_REFERENCES_CONST1:String = "⌂";
      
      private var weakObject1:WeakObject;
      
      private var dict3:Dictionary;
      
      private var uintValue28:uint = 1;
      
      private var flag135:Boolean;
      
      private var value2:*;
      
      private var array25:Array;
      
      private var uintValue30:uint;
      
      private var array65:Array;
      
      private var array66:Array;
      
      private var uintValue18:uint;
      
      public function LogReferences(console:Console)
      {
         this.weakObject1 = new WeakObject();
         this.dict3 = new Dictionary(true);
         this.array65 = new Array();
         this.array66 = new Array();
         super(console);
         remoter.registerCallback("ref",function(param1:ByteArray):void
         {
            handleString(param1.readUTF());
         });
         remoter.registerCallback("focus",this.doAction756);
      }
      
      public static function EscHTML(param1:String) : String
      {
         return param1.replace(/</g,"&lt;").replace(/\>/g,"&gt;").replace(/\x00/g,"");
      }
      
      public static function ShortClassName(param1:Object, param2:Boolean = true) : String
      {
         var className:String = getQualifiedClassName(param1);
         var separatorIndex:int = className.indexOf("::");
         var classMarker:String = param1 is Class ? "*" : "";
         className = classMarker + className.substring(separatorIndex >= 0 ? separatorIndex + 2 : 0) + classMarker;
         if(param2)
         {
            return EscHTML(className);
         }
         return className;
      }
      
      public function update(param1:uint) : void
      {
         if(this.array66.length || this.array65.length)
         {
            if(param1 > this.uintValue18 + config.objectHardReferenceTimer * 1000)
            {
               array65 = this.array66;
               array66 = new Array();
               uintValue18 = param1;
            }
         }
      }
      
      public function setLogRef(param1:*) : uint
      {
         if(!config.useObjectLinking)
         {
            return 0;
         }
         var referenceId:uint = this.dict3[param1];
         var cleanupIndex:int;
         if(!referenceId)
         {
            referenceId = this.uintValue28;
            this.weakObject1[referenceId] = param1;
            this.dict3[param1] = referenceId;
            if(config.objectHardReferenceTimer)
            {
               this.array66.push(param1);
            }
            ++this.uintValue28;
            cleanupIndex = referenceId - 50;
            while(cleanupIndex >= 0)
            {
               if(this.weakObject1[cleanupIndex] === null)
               {
                  delete this.weakObject1[cleanupIndex];
               }
               cleanupIndex -= 50;
            }
         }
         return referenceId;
      }
      
      public function getUint1(param1:*) : uint
      {
         return this.dict3[param1];
      }
      
      public function getRefById(param1:uint) : *
      {
         return this.weakObject1[param1];
      }
      
      public function makeString(o:*, prop:* = null, html:Boolean = false, maxlen:int = -1) : String
      {
         var txt:String;
         var v:*;
         var err:Error;
         var stackstr:String;
         var str:String;
         var len:int;
         var hasmaxlen:Boolean;
         var i:int;
         var strpart:String;
         var add:String;
         try
         {
            v = prop ? o[prop] : o;
         }
         catch(err:Error)
         {
            return "<p0><i>" + err.toString() + "</i></p0>";
         }
         if(v is Error)
         {
            err = v as Error;
            stackstr = err.hasOwnProperty("getStackTrace") ? err.getStackTrace() : err.toString();
            if(stackstr)
            {
               return stackstr;
            }
            return err.toString();
         }
         else if(v is XML || v is XMLList)
         {
            return this.getString47(EscHTML(v.toXMLString()),maxlen,o,prop);
         }
         else if(v is QName)
         {
            return String(v);
         }
         else if(v is Array || getQualifiedClassName(v).indexOf("__AS3__.vec::Vector.") == 0)
         {
            str = "[";
            len = v.length;
            hasmaxlen = maxlen >= 0;
            i = 0;
            while(i < len)
            {
               strpart = this.makeString(v[i],null,false,maxlen);
               str += (i ? ", " : "") + strpart;
               maxlen -= strpart.length;
               if(hasmaxlen && maxlen <= 0 && i < len - 1)
               {
                  str += ", " + this.getString14(o,prop,"...");
                  break;
               }
               i++;
            }
            return str + "]";
         }
         else if(config.useObjectLinking && v && typeof v == "object")
         {
            add = "";
            if(v is ByteArray)
            {
               add = " position:" + v.position + " length:" + v.length;
            }
            else if(v is Date || v is Rectangle || v is Point || v is Matrix || v is Event)
            {
               add = " " + String(v);
            }
            else if(v is DisplayObject && v.name)
            {
               add = " " + v.name;
            }
            txt = "{" + this.getString14(o,prop,ShortClassName(v)) + EscHTML(add) + "}";
         }
         else
         {
            if(v is ByteArray)
            {
               txt = "[ByteArray position:" + ByteArray(v).position + " length:" + ByteArray(v).length + "]";
            }
            else
            {
               txt = String(v);
            }
            if(!html)
            {
               return this.getString47(EscHTML(txt),maxlen,o,prop);
            }
         }
         return txt;
      }
      
      public function makeRefTyped(param1:*) : String
      {
         if(param1 && typeof param1 == "object" && !(param1 is QName))
         {
            return "{" + this.getString14(param1,null,ShortClassName(param1)) + "}";
         }
         return ShortClassName(param1);
      }
      
      private function getString14(param1:*, param2:*, param3:String) : String
      {
         if(param2 && !(param2 is String))
         {
            param1 = param1[param2];
            param2 = null;
         }
         var referenceId:uint = this.setLogRef(param1);
         if(referenceId)
         {
            return "<menu><a href=\'event:ref_" + referenceId + (param2 ? "_" + param2 : "") + "\'>" + param3 + "</a></menu>";
         }
         return param3;
      }
      
      private function getString47(param1:String, param2:int, param3:*, param4:* = null) : String
      {
         if(param2 >= 0 && param1.length > param2)
         {
            param1 = param1.substring(0,param2);
            return param1 + this.getString14(param3,param4," ...");
         }
         return param1;
      }
      
      private function doAction390(param1:int) : void
      {
         uintValue30 += param1;
         var targetObject:* = this.array25[this.uintValue30];
         if(targetObject)
         {
            this.focus(targetObject,this.flag135);
         }
      }
      
      public function handleRefEvent(param1:String) : void
      {
         var payload:ByteArray = null;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            payload = new ByteArray();
            payload.writeUTF(param1);
            remoter.send("ref",payload);
         }
         else
         {
            this.handleString(param1);
         }
      }
      
      private function handleString(param1:String) : void
      {
         var idStart:int = 0;
         var referenceId:uint = 0;
         var propertyName:String = null;
         var separatorIndex:int = 0;
         var targetObject:Object = null;
         if(param1 == "refexit")
         {
            this.exitFocus();
            console.setViewingChannels();
         }
         else if(param1 == "refprev")
         {
            this.doAction390(-2);
         }
         else if(param1 == "reffwd")
         {
            this.doAction390(0);
         }
         else if(param1 == "refi")
         {
            this.focus(this.value2,!this.flag135);
         }
         else
         {
            idStart = param1.indexOf("_") + 1;
            if(idStart > 0)
            {
               propertyName = "";
               separatorIndex = param1.indexOf("_",idStart);
               if(separatorIndex > 0)
               {
                  referenceId = uint(param1.substring(idStart,separatorIndex));
                  propertyName = param1.substring(separatorIndex + 1);
               }
               else
               {
                  referenceId = uint(param1.substring(idStart));
               }
               targetObject = this.getRefById(referenceId);
               if(propertyName)
               {
                  targetObject = targetObject[propertyName];
               }
               if(targetObject)
               {
                  if(param1.indexOf("refe_") == 0)
                  {
                     console.explodech(console.panels.mainPanel.reportChannel,targetObject);
                  }
                  else
                  {
                     this.focus(targetObject,this.flag135);
                  }
                  return;
               }
            }
            report("Reference no longer exist (garbage collected).",-2);
         }
      }
      
      public function focus(param1:*, param2:Boolean = false) : void
      {
         remoter.send("focus");
         console.clear(LogReferences.LOG_REFERENCES_CONST1);
         console.setViewingChannels(LogReferences.LOG_REFERENCES_CONST1);
         if(!this.array25)
         {
            array25 = new Array();
         }
         if(this.value2 != param1)
         {
            value2 = param1;
            if(this.array25.length <= this.uintValue30)
            {
               this.array25.push(param1);
            }
            else
            {
               this.array25[this.uintValue30] = param1;
            }
            ++this.uintValue30;
         }
         flag135 = param2;
         this.inspect(param1,this.flag135);
      }
      
      private function doAction756() : void
      {
         console.clear(LogReferences.LOG_REFERENCES_CONST1);
         console.setViewingChannels(LogReferences.LOG_REFERENCES_CONST1);
      }
      
      public function exitFocus() : void
      {
         var payload:ByteArray = null;
         value2 = null;
         flag135 = false;
         array25 = null;
         uintValue30 = 0;
         if(remoter.remoting == Remoting.REMOTING_CONST1)
         {
            payload = new ByteArray();
            payload.writeUTF("refexit");
            remoter.send("ref",payload);
         }
         console.clear(LogReferences.LOG_REFERENCES_CONST1);
      }
      
      public function inspect(obj:*, viewAll:Boolean = true, ch:String = null) : void
      {
         if(!obj)
         {
            report(obj,-2,true,ch);
            return;
         }
         var refIndex:uint = this.setLogRef(obj);
         var showInherit:String = "";
         if(!viewAll)
         {
            showInherit = " [<a href=\'event:refi\'>show inherited</a>]";
         }
         var menuStr:String;
         if(this.array25)
         {
            menuStr = "<b>[<a href=\'event:refexit\'>exit</a>]";
            if(this.uintValue30 > 1)
            {
               menuStr += " [<a href=\'event:refprev\'>previous</a>]";
            }
            if(this.array25 && this.uintValue30 < this.array25.length)
            {
               menuStr += " [<a href=\'event:reffwd\'>forward</a>]";
            }
            menuStr += "</b> || [<a href=\'event:ref_" + refIndex + "\'>refresh</a>]";
            menuStr += "</b> [<a href=\'event:refe_" + refIndex + "\'>explode</a>]";
            if(config.commandLineAllowed)
            {
               menuStr += " [<a href=\'event:cl_" + refIndex + "\'>scope</a>]";
            }
            if(viewAll)
            {
               menuStr += " [<a href=\'event:refi\'>hide inherited</a>]";
            }
            else
            {
               menuStr += showInherit;
            }
            report(menuStr,-1,true,ch);
            report("",1,true,ch);
         }
         var V:XML = describeType(obj);
         var cls:Object = obj is Class ? obj : obj.constructor;
         var clsV:XML = describeType(cls);
         var self:String = V.@name;
         var isClass:Boolean = obj is Class;
         var st:String = isClass ? "*" : "";
         var str:String = "<b>{" + st + this.getString14(obj,null,EscHTML(self)) + st + "}</b>";
         var props:Array = [];
         if(V.@isStatic == "true")
         {
            props.push("<b>static</b>");
         }
         if(V.@isDynamic == "true")
         {
            props.push("dynamic");
         }
         if(V.@isFinal == "true")
         {
            props.push("final");
         }
         if(props.length > 0)
         {
            str += " <p-1>" + props.join(" | ") + "</p-1>";
         }
         report(str,-2,true,ch);
         var nodes:XMLList;
         nodes = V.extendsClass;
         if(nodes.length())
         {
            props = [];
            for each(var extendX:XML in nodes)
            {
               st = extendX.@type.toString();
               props.push(st.indexOf("*") < 0 ? this.getString27(getDefinitionByName(st)) : EscHTML(st));
               if(!viewAll)
               {
                  break;
               }
            }
            report("<p10>Extends:</p10> " + props.join(" &gt; "),1,true,ch);
         }
         nodes = V.implementsInterface;
         if(nodes.length())
         {
            props = [];
            for each(var implementX:XML in nodes)
            {
               props.push(this.getString27(getDefinitionByName(implementX.@type.toString())));
            }
            report("<p10>Implements:</p10> " + props.join(", "),1,true,ch);
         }
         report("",1,true,ch);
         props = [];
         nodes = V.metadata.(@name == "Event");
         if(nodes.length())
         {
            for each(var metadataX:XML in nodes)
            {
               var mn:XMLList = metadataX.arg;
               var en:String = mn.(@key == "name").@value;
               var et:String = mn.(@key == "type").@value;
               if(refIndex)
               {
                  props.push("<a href=\'event:cl_" + refIndex + "_dispatchEvent(new " + et + "(\"" + en + "\"))\'>" + en + "</a><p0>(" + et + ")</p0>");
               }
               else
               {
                  props.push(en + "<p0>(" + et + ")</p0>");
               }
            }
            report("<p10>Events:</p10> " + props.join("<p-1>; </p-1>"),1,true,ch);
            report("",1,true,ch);
         }
         if(obj is DisplayObject)
         {
            var disp:DisplayObject = obj as DisplayObject;
            var theParent:DisplayObjectContainer = disp.parent;
            if(theParent)
            {
               props = new Array("@" + theParent.getChildIndex(disp));
               while(theParent)
               {
                  var pr:DisplayObjectContainer = theParent;
                  theParent = theParent.parent;
                  var indstr:String = theParent ? "@" + theParent.getChildIndex(pr) : "";
                  props.push("<b>" + pr.name + "</b>" + indstr + this.getString27(pr));
               }
               report("<p10>Parents:</p10> " + props.join("<p-1> -> </p-1>") + "<br/>",1,true,ch);
            }
         }
         if(obj is DisplayObjectContainer)
         {
            props = [];
            var cont:DisplayObjectContainer = obj as DisplayObjectContainer;
            var clen:int = cont.numChildren;
            var ci:int = 0;
            while(ci < clen)
            {
               var child:DisplayObject = cont.getChildAt(ci);
               props.push("<b>" + child.name + "</b>@" + ci + this.getString27(child));
               ci++;
            }
            if(clen)
            {
               report("<p10>Children:</p10> " + props.join("<p-1>; </p-1>") + "<br/>",1,true,ch);
            }
         }
         props = [];
         nodes = clsV..constant;
         for each(var constantX:XML in nodes)
         {
            report(" const <p3>" + constantX.@name + "</p3>:" + constantX.@type + " = " + this.getString27(cls,constantX.@name.toString()) + "</p0>",1,true,ch);
         }
         if(nodes.length())
         {
            report("",1,true,ch);
         }
         var inherit:uint = 0;
         var hasstuff:Boolean;
         var isstatic:Boolean;
         props = [];
         nodes = clsV..method;
         for each(var methodX:XML in nodes)
         {
            if(viewAll || self == methodX.@declaredBy)
            {
               hasstuff = true;
               isstatic = methodX.parent().name() != "factory";
               str = " " + (isstatic ? "static " : "") + "function ";
               var params:Array = [];
               var mparamsList:XMLList = methodX.parameter;
               for each(var paraX:XML in mparamsList)
               {
                  params.push(paraX.@optional == "true" ? "<i>" + paraX.@type + "</i>" : paraX.@type);
               }
               if(refIndex && (isstatic || !isClass))
               {
                  str += "<a href=\'event:cl_" + refIndex + "_" + methodX.@name + "()\'><p3>" + methodX.@name + "</p3></a>";
               }
               else
               {
                  str += "<p3>" + methodX.@name + "</p3>";
               }
               str += "(" + params.join(", ") + "):" + methodX.@returnType;
               report(str,1,true,ch);
            }
            else
            {
               inherit++;
            }
         }
         if(inherit)
         {
            report("   \t + " + inherit + " inherited methods." + showInherit,1,true,ch);
         }
         else if(hasstuff)
         {
            report("",1,true,ch);
         }
         hasstuff = false;
         inherit = 0;
         props = [];
         nodes = clsV..accessor;
         for each(var accessorX:XML in nodes)
         {
            if(viewAll || self == accessorX.@declaredBy)
            {
               hasstuff = true;
               isstatic = accessorX.parent().name() != "factory";
               str = " ";
               if(isstatic)
               {
                  str += "static ";
               }
               var access:String = accessorX.@access;
               if(access == "readonly")
               {
                  str += "get";
               }
               else if(access == "writeonly")
               {
                  str += "set";
               }
               else
               {
                  str += "assign";
               }
               if(refIndex && (isstatic || !isClass))
               {
                  str += " <a href=\'event:cl_" + refIndex + "_" + accessorX.@name + "\'><p3>" + accessorX.@name + "</p3></a>:" + accessorX.@type;
               }
               else
               {
                  str += " <p3>" + accessorX.@name + "</p3>:" + accessorX.@type;
               }
               if(access != "writeonly" && (isstatic || !isClass))
               {
                  str += " = " + this.getString27(isstatic ? cls : obj,accessorX.@name.toString());
               }
               report(str,1,true,ch);
            }
            else
            {
               inherit++;
            }
         }
         if(inherit)
         {
            report("   \t + " + inherit + " inherited accessors." + showInherit,1,true,ch);
         }
         else if(hasstuff)
         {
            report("",1,true,ch);
         }
         nodes = clsV..variable;
         for each(var variableX:XML in nodes)
         {
            isstatic = variableX.parent().name() != "factory";
            str = isstatic ? " static" : "";
            if(refIndex)
            {
               str += " var <p3><a href=\'event:cl_" + refIndex + "_" + variableX.@name + " = \'>" + variableX.@name + "</a>";
            }
            else
            {
               str += " var <p3>" + variableX.@name;
            }
            str += "</p3>:" + variableX.@type + " = " + this.getString27(isstatic ? cls : obj,variableX.@name.toString());
            report(str,1,true,ch);
         }
         try
         {
            props = [];
            for(var X:* in obj)
            {
               if(X is String)
               {
                  if(refIndex)
                  {
                     str = "<a href=\'event:cl_" + refIndex + "_" + X + " = \'>" + X + "</a>";
                  }
                  else
                  {
                     str = X;
                  }
                  report(" dynamic var <p3>" + str + "</p3> = " + this.getString27(obj,X),1,true,ch);
               }
               else
               {
                  report(" dictionary <p3>" + this.getString27(X) + "</p3> = " + this.getString27(obj,X),1,true,ch);
               }
            }
         }
         catch(e:Error)
         {
            report("Could not get dynamic values. " + e.message,9,false,ch);
         }
         if(obj is String)
         {
            report("",1,true,ch);
            report("String",10,true,ch);
            report(EscHTML(obj),1,true,ch);
         }
         else if(obj is XML || obj is XMLList)
         {
            report("",1,true,ch);
            report("XMLString",10,true,ch);
            report(EscHTML(obj.toXMLString()),1,true,ch);
         }
         if(menuStr)
         {
            report("",1,true,ch);
            report(menuStr,-1,true,ch);
         }
      }
      
      public function getPossibleCalls(param1:*) : Array
      {
         var results:Array = new Array();
         var typeInfo:XML = describeType(param1);
         var nodes:XMLList = typeInfo.method;
         var methodNode:XML;
         var accessorNode:XML;
         var variableNode:XML;
         var parameters:Array;
         var parameterNodes:XMLList;
         var parameterNode:XML;
         for each(methodNode in nodes)
         {
            parameters = [];
            parameterNodes = methodNode.parameter;
            for each(parameterNode in parameterNodes)
            {
               parameters.push(parameterNode.@optional == "true" ? "<i>" + parameterNode.@type + "</i>" : parameterNode.@type);
            }
            results.push([methodNode.@name + "(",parameters.join(", ") + " ):" + methodNode.@returnType]);
         }
         nodes = typeInfo.accessor;
         for each(accessorNode in nodes)
         {
            results.push([String(accessorNode.@name),String(accessorNode.@type)]);
         }
         nodes = typeInfo.variable;
         for each(variableNode in nodes)
         {
            results.push([String(variableNode.@name),String(variableNode.@type)]);
         }
         return results;
      }
      
      private function getString27(param1:*, param2:* = null) : String
      {
         return this.makeString(param1,param2,false,config.useObjectLinking ? 100 : -1);
      }
   }
}

