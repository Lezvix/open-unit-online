package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.WeakObject;
   import com.junkbyte.console.vos.WeakRef;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class CommandLine extends ConsoleCore
   {
      
      private static const COMMAND_LINE_CONST1:String = "<b>Advanced CommandLine is disabled.</b>\nEnable by setting `Cc.config.commandLineAllowed = true;´\nType <b>/commands</b> for permitted commands.";
      
      private static const array13:Array = [Executer.RETURNED,"base","C"];
      
      private var _saved:WeakObject;
      
      private var _scope:*;
      
      private var weakRef1:WeakRef;
      
      private var str45:String = "";
      
      private var obj59:Object;
      
      public var array110:Array;
      
      public function CommandLine(m:Console)
      {
         this.array110 = new Array("filter","filterexp");
         super(m);
         this._saved = new WeakObject();
         this._scope = m;
         this.obj59 = new Object();
         this.weakRef1 = new WeakRef(m);
         this._saved.set("C",m);
         remoter.registerCallback("cmd",function(param1:ByteArray):void
         {
            run(param1.readUTF());
         });
         remoter.registerCallback("scope",function(param1:ByteArray):void
         {
            handleScopeEvent(param1.readUnsignedInt());
         });
         remoter.registerCallback("cls",this.doAction950);
         remoter.addEventListener(Event.CONNECT,this.onRemoterConnect);
         this.addCLCmd("help",this.doAction322,"How to use command line");
         this.addCLCmd("save|store",this.doAction830,"Save current scope as weak reference. (same as Cc.store(...))");
         this.addCLCmd("savestrong|storestrong",this.doAction218,"Save current scope as strong reference");
         this.addCLCmd("saved|stored",this.doAction230,"Show a list of all saved references");
         this.addCLCmd("string",this.doAction181,"Create String, useful to paste complex strings without worrying about \" or \'",false,null);
         this.addCLCmd("commands",this.doAction351,"Show a list of all slash commands",true);
         this.addCLCmd("inspect",this.doAction586,"Inspect current scope");
         this.addCLCmd("explode",this.doAction710,"Explode current scope to its properties and values (similar to JSON)");
         this.addCLCmd("map",this.doAction25,"Get display list map starting from current scope");
         this.addCLCmd("function",this.doAction12,"Create function. param is the commandline string to create as function. (experimental)");
         this.addCLCmd("autoscope",this.doAction349,"Toggle autoscoping.");
         this.addCLCmd("base",this.doAction231,"Return to base scope");
         this.addCLCmd("/",this.doAction237,"Return to previous scope");
      }
      
      public function set base(param1:Object) : void
      {
         if(this.base)
         {
            report("Set new commandLine base from " + this.base + " to " + param1,10);
         }
         else
         {
            this.weakRef1.propValue182 = this._scope;
            _scope = param1;
            str45 = LogReferences.ShortClassName(param1,false);
         }
         this._saved.set("base",param1);
      }
      
      public function get base() : Object
      {
         return this._saved.get("base");
      }
      
      public function doAction950(param1:ByteArray) : void
      {
         str45 = param1.readUTF();
      }
      
      public function handleScopeEvent(param1:uint) : void
      {
         var payload:ByteArray;
         if(remoter.remoting == Remoting.RECIEVER)
         {
            payload = new ByteArray();
            payload.writeUnsignedInt(param1);
            remoter.send("scope",payload);
         }
         else
         {
            var referencedObject:* = console.refs.getRefById(param1);
            if(referencedObject)
            {
               console.cl.setReturned(referencedObject,true,false);
            }
            else
            {
               console.report("Reference no longer exist.",-2);
            }
         }
      }
      
      public function doAction163(param1:String, param2:Object, param3:Boolean = false) : void
      {
         if(!param1)
         {
            report("ERROR: Give a name to save.",10);
            return;
         }
         if(param2 is Function)
         {
            param3 = true;
         }
         param1 = param1.replace(/[^\w]*/g,"");
         if(array13.indexOf(param1) >= 0)
         {
            report("ERROR: The name [" + param1 + "] is reserved",10);
            return;
         }
         this._saved.set(param1,param2,param3);
      }
      
      public function getHintsFor(str:String, max:uint) : Array
      {
         var all:Array = new Array();
         var X:String;
         for(X in this.obj59)
         {
            var cmd:Object = this.obj59[X];
            if(config.commandLineAllowed || cmd.allow)
            {
               all.push(["/" + X + " ",cmd.d ? cmd.d : null]);
            }
         }
         if(config.commandLineAllowed)
         {
            var Y:String;
            for(Y in this._saved)
            {
               all.push(["$" + Y,LogReferences.ShortClassName(this._saved.get(Y))]);
            }
            if(this._scope)
            {
               all.push(["this",LogReferences.ShortClassName(this._scope)]);
               all = all.concat(console.refs.getPossibleCalls(this._scope));
            }
         }
         str = str.toLowerCase();
         var hints:Array = new Array();
         var canadate:Array;
         for each(canadate in all)
         {
            if(canadate[0].toLowerCase().indexOf(str) == 0)
            {
               hints.push(canadate);
            }
         }
         hints = hints.sort(function(param1:Array, param2:Array):int
         {
            if(param1[0].length < param2[0].length)
            {
               return -1;
            }
            if(param1[0].length > param2[0].length)
            {
               return 1;
            }
            return 0;
         });
         if(max > 0 && hints.length > max)
         {
            hints.splice(max);
            hints.push(["..."]);
         }
         return hints;
      }
      
      public function get scopeString() : String
      {
         return config.commandLineAllowed ? this.str45 : "";
      }
      
      public function addCLCmd(param1:String, param2:Function, param3:String, param4:Boolean = false, param5:String = ";") : void
      {
         var aliases:Array = param1.split("|");
         var aliasIndex:int = 0;
         while(aliasIndex < aliases.length)
         {
            param1 = aliases[aliasIndex];
            this.obj59[param1] = new SlashCommand(param1,param2,param3,false,param4,param5);
            if(aliasIndex > 0)
            {
               this.obj59.setPropertyIsEnumerable(param1,false);
            }
            aliasIndex++;
         }
      }
      
      public function doAction874(param1:String, param2:Function, param3:String = "", param4:Boolean = true, param5:String = ";") : void
      {
         var existingCommand:SlashCommand = null;
         param1 = param1.replace(/[^\w]*/g,"");
         if(this.obj59[param1] != null)
         {
            existingCommand = this.obj59[param1];
            if(!existingCommand.user)
            {
               throw new Error("Can not alter build-in slash command [" + param1 + "]");
            }
         }
         if(param2 == null)
         {
            delete this.obj59[param1];
         }
         else
         {
            this.obj59[param1] = new SlashCommand(param1,param2,LogReferences.EscHTML(param3),true,param4,param5);
         }
      }
      
      public function run(str:String, saves:Object = null) : *
      {
         if(!str)
         {
            return;
         }
         str = str.replace(/\s*/,"");
         if(remoter.remoting == Remoting.RECIEVER)
         {
            if(str.charAt(0) == "~")
            {
               str = str.substring(1);
            }
            else if(str.search(new RegExp("/" + this.array110.join("|/"))) != 0)
            {
               report("Run command at remote: " + str,-2);
               var bytes:ByteArray = new ByteArray();
               bytes.writeUTF(str);
               if(!console.remoter.send("cmd",bytes))
               {
                  report("Command could not be sent to client.",10);
               }
               return null;
            }
         }
         report("&gt; " + str,4,false);
         var v:* = null;
         try
         {
            if(str.charAt(0) == "/")
            {
               this.doAction193(str.substring(1));
            }
            else
            {
               if(!config.commandLineAllowed)
               {
                  report(COMMAND_LINE_CONST1,9);
                  return null;
               }
               var exe:Executer = new Executer();
               exe.addEventListener(Event.COMPLETE,this.onExeComplete,false,0,true);
               if(saves)
               {
                  var X:String;
                  for(X in this._saved)
                  {
                     if(!saves[X])
                     {
                        saves[X] = this._saved[X];
                     }
                  }
               }
               else
               {
                  saves = this._saved;
               }
               exe.doAction537(saves);
               exe.doAction524(array13);
               exe.flag115 = config.commandLineAutoScope;
               v = exe.exec(this._scope,str);
            }
         }
         catch(e:Error)
         {
            doAction371(e);
         }
         return v;
      }
      
      private function onExeComplete(param1:Event) : void
      {
         var executer:Executer = param1.currentTarget as Executer;
         if(this._scope == executer.scope)
         {
            this.setReturned(executer.returned);
         }
         else if(executer.scope == executer.returned)
         {
            this.setReturned(executer.scope,true);
         }
         else
         {
            this.setReturned(executer.returned);
            this.setReturned(executer.scope,true);
         }
      }
      
      private function doAction193(str:String) : void
      {
         var brk:int = str.search(/[^\w]/);
         var cmd:String = str.substring(0,brk > 0 ? brk : str.length);
         if(cmd == "")
         {
            this.setReturned(this._saved.get(Executer.RETURNED),true);
            return;
         }
         var param:String = brk > 0 ? str.substring(brk + 1) : "";
         if(this.obj59[cmd] != null)
         {
            try
            {
               var slashcmd:SlashCommand = this.obj59[cmd];
               if(!config.commandLineAllowed && !slashcmd.allow)
               {
                  report(COMMAND_LINE_CONST1,9);
                  return;
               }
               var restStr:String;
               if(slashcmd.endMarker)
               {
                  var endInd:int = param.indexOf(slashcmd.endMarker);
                  if(endInd >= 0)
                  {
                     restStr = param.substring(endInd + slashcmd.endMarker.length);
                     param = param.substring(0,endInd);
                  }
               }
               if(param.length == 0)
               {
                  slashcmd.f();
               }
               else
               {
                  slashcmd.f(param);
               }
               if(restStr)
               {
                  this.run(restStr);
               }
            }
            catch(err:Error)
            {
               doAction371(err);
            }
         }
         else
         {
            report("Undefined command <b>/commands</b> for list of all commands.",10);
         }
      }
      
      public function setReturned(param1:*, param2:Boolean = false, param3:Boolean = true) : void
      {
         if(!config.commandLineAllowed)
         {
            report(COMMAND_LINE_CONST1,9);
            return;
         }
         if(param1 !== undefined)
         {
            this._saved.set(Executer.RETURNED,param1,true);
            if(param2 && param1 !== this._scope)
            {
               this.weakRef1.propValue182 = this._scope;
               _scope = param1;
               if(remoter.remoting != Remoting.RECIEVER)
               {
                  str45 = LogReferences.ShortClassName(this._scope,false);
                  this.onRemoterConnect();
               }
               report("Changed to " + console.refs.makeRefTyped(param1),-1);
            }
            else if(param3)
            {
               report("Returned " + console.refs.makeString(param1),-1);
            }
         }
         else if(param3)
         {
            report("Exec successful, undefined return.",-1);
         }
      }
      
      public function onRemoterConnect(param1:Event = null) : void
      {
         var payload:ByteArray = new ByteArray();
         payload.writeUTF(this.str45);
         console.remoter.send("cls",payload);
      }
      
      private function doAction371(param1:Error) : void
      {
         var errorText:String = console.refs.makeString(param1);
         var stackLines:Array = errorText.split(/\n\s*/);
         var level:int = 10;
         var internalCount:int = 0;
         var lineCount:int = stackLines.length;
         var formattedLines:Array = [];
         var internalPattern:RegExp = new RegExp("\\s*at\\s+(" + Executer.EXECUTER_CONST1 + "|" + getQualifiedClassName(this) + ")");
         var lineIndex:int = 0;
         var stackLine:String;
         while(lineIndex < lineCount)
         {
            stackLine = stackLines[lineIndex];
            if(stackLine.search(internalPattern) == 0)
            {
               if(internalCount > 0 && lineIndex > 0)
               {
                  break;
               }
               internalCount++;
            }
            formattedLines.push("<p" + level + "> " + stackLine + "</p" + level + ">");
            if(level > 6)
            {
               level--;
            }
            lineIndex++;
         }
         report(formattedLines.join("\n"),9);
      }
      
      private function doAction830(param1:String = null) : void
      {
         this.doAction163(param1,this._scope,false);
      }
      
      private function doAction218(param1:String = null) : void
      {
         this.doAction163(param1,this._scope,true);
      }
      
      private function doAction230(... rest) : void
      {
         report("Saved vars: ",-1);
         var savedCount:uint = 0;
         var emptyCount:uint = 0;
         var savedKey:String;
         var reference:WeakRef;
         for(savedKey in this._saved)
         {
            reference = this._saved.getWeakRef1(savedKey);
            savedCount++;
            if(reference.propValue182 == null)
            {
               emptyCount++;
            }
            report((reference.strong ? "strong" : "weak") + " <b>$" + savedKey + "</b> = " + console.refs.makeString(reference.propValue182),-2);
         }
         report("Found " + savedCount + " item(s), " + emptyCount + " empty.",-1);
      }
      
      private function doAction181(param1:String) : void
      {
         report("String with " + param1.length + " chars entered. Use /save <i>(name)</i> to save.",-2);
         this.setReturned(param1,true);
      }
      
      private function doAction351(... rest) : void
      {
         var builtInCommands:Array = [];
         var userCommands:Array = [];
         var command:SlashCommand;
         for each(command in this.obj59)
         {
            if(config.commandLineAllowed || command.allow)
            {
               if(command.user)
               {
                  userCommands.push(command);
               }
               else
               {
                  builtInCommands.push(command);
               }
            }
         }
         builtInCommands = builtInCommands.sortOn("n");
         report("Built-in commands:" + (!config.commandLineAllowed ? " (limited permission)" : ""),4);
         for each(command in builtInCommands)
         {
            report("<b>/" + command.n + "</b> <p-1>" + command.d + "</p-1>",-2);
         }
         if(userCommands.length)
         {
            userCommands = userCommands.sortOn("n");
            report("User commands:",4);
            for each(command in userCommands)
            {
               report("<b>/" + command.n + "</b> <p-1>" + command.d + "</p-1>",-2);
            }
         }
      }
      
      private function doAction586(... rest) : void
      {
         console.refs.focus(this._scope);
      }
      
      private function doAction710(param1:String = "0") : void
      {
         var depth:int = int(param1);
         console.explodech(console.panels.mainPanel.reportChannel,this._scope,depth <= 0 ? 3 : depth);
      }
      
      private function doAction25(param1:String = "0") : void
      {
         console.mapch(console.panels.mainPanel.reportChannel,this._scope as DisplayObjectContainer,int(param1));
      }
      
      private function doAction12(param1:String = "") : void
      {
         var fakeFunction:FakeFunction = new FakeFunction(this.run,param1);
         report("Function created. Use /savestrong <i>(name)</i> to save.",-2);
         this.setReturned(fakeFunction.exec,true);
      }
      
      private function doAction349(... rest) : void
      {
         config.commandLineAutoScope = !config.commandLineAutoScope;
         report("Auto-scoping <b>" + (config.commandLineAutoScope ? "enabled" : "disabled") + "</b>.",10);
      }
      
      private function doAction231(... rest) : void
      {
         this.setReturned(this.base,true);
      }
      
      private function doAction237(... rest) : void
      {
         this.setReturned(this.weakRef1.propValue182,true);
      }
      
      private function doAction322(... rest) : void
      {
         report("____Command Line Help___",10);
         report("/filter (text) = filter/search logs for matching text",5);
         report("/commands to see all slash commands",5);
         report("Press up/down arrow keys to recall previous line",2);
         report("__Examples:",10);
         report("<b>stage.stageWidth</b>",5);
         report("<b>stage.scaleMode = flash.display.StageScaleMode.NO_SCALE</b>",5);
         report("<b>stage.frameRate = 12</b>",5);
         report("__________",10);
      }
   }
}

class FakeFunction
{
   
   private var line:String;
   
   private var run:Function;
   
   public function FakeFunction(param1:Function, param2:String)
   {
      super();
      this.run = param1;
      this.line = param2;
   }
   
   public function exec(... rest) : *
   {
      return this.run(this.line,rest);
   }
}

class SlashCommand
{
   
   public var n:String;
   
   public var f:Function;
   
   public var d:String;
   
   public var user:Boolean;
   
   public var allow:Boolean;
   
   public var endMarker:String;
   
   public function SlashCommand(param1:String, param2:Function, param3:String, param4:Boolean, param5:Boolean, param6:String)
   {
      super();
      this.n = param1;
      this.f = param2;
      this.d = param3 ? param3 : "";
      this.user = param4;
      this.allow = param5;
      this.endMarker = param6;
   }
}
