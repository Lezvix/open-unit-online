package com.junkbyte.console
{
   import com.junkbyte.console.view.RollerPanel;
   import com.junkbyte.console.view.PanelsManager;
   import com.junkbyte.console.vos.Log;
   import com.junkbyte.console.core.KeyBinder;
   import com.junkbyte.console.core.Graphing;
   import com.junkbyte.console.core.MemoryMonitor;
   import com.junkbyte.console.core.Logs;
   import com.junkbyte.console.core.Remoting;
   import com.junkbyte.console.core.CommandLine;
   import com.junkbyte.console.core.LogReferences;
   import com.junkbyte.console.core.ConsoleTools;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class Console extends Sprite
   {
      
      public static const VERSION:Number = 2.6;
      
      public static const RC2:String = "RC";
      
      public static const CONSOLE_CONST5:int = 605;
      
      public static const CONSOLE_CONST6:String = "2011/12/08 22:28";
      
      public static const CONSOLE_CONST2:uint = 1;
      
      public static const CONSOLE_CONST11:uint = 3;
      
      public static const CONSOLE_CONST10:uint = 6;
      
      public static const CONSOLE_CONST9:uint = 8;
      
      public static const CONSOLE_CONST8:uint = 9;
      
      public static const CONSOLE_CONST7:uint = 10;
      
      public static const CONSOLE_CONST1:String = " * ";
      
      public static const CONSOLE_CONST3:String = "-";
      
      public static const C2:String = "C";
      
      public static const CONSOLE_CONST4:String = "~";
      
      private var _config:ConsoleConfig;
      
      private var _panels:PanelsManager;
      
      private var commandLine1:CommandLine;
      
      private var keyBinder1:KeyBinder;
      
      private var logReferences1:LogReferences;
      
      private var memoryMonitor1:MemoryMonitor;
      
      private var _graphing:Graphing;
      
      private var remoting1:Remoting;
      
      private var consoleTools1:ConsoleTools;
      
      private var intValue152:int = 50;
      
      private var intValue65:Boolean;
      
      private var keyBind1:KeyBind;
      
      private var logs1:Logs;
      
      private var sharedObject1:SharedObject;
      
      private var obj15:Object;
      
      public function Console(password:String = "", config:ConsoleConfig = null)
      {
         this.obj15 = {};
         super();
         name = "Console";
         if(config == null)
         {
            config = new ConsoleConfig();
         }
         this._config = config;
         if(password)
         {
            this._config.keystrokePassword = password;
         }
         this.remoting1 = new Remoting(this);
         this.logs1 = new Logs(this);
         this.logReferences1 = new LogReferences(this);
         this.commandLine1 = new CommandLine(this);
         this.consoleTools1 = new ConsoleTools(this);
         this._graphing = new Graphing(this);
         this.memoryMonitor1 = new MemoryMonitor(this);
         this.keyBinder1 = new KeyBinder(this);
         this.cl.addCLCmd("remotingSocket",function(param1:String = ""):void
         {
            var socketAddressParts:Array = param1.split(/\s+|\:/);
            remotingSocket(socketAddressParts[0],socketAddressParts[1]);
         },"Connect to socket remote. /remotingSocket ip port");
         if(this._config.str21)
         {
            try
            {
               this.sharedObject1 = SharedObject.getLocal(this._config.str21,this._config.str44);
               this.obj15 = this.sharedObject1.data;
            }
            catch(e:Error)
            {
            }
         }
         this._config.style.updateStyleSheet();
         this._panels = new PanelsManager(this);
         if(password)
         {
            this.visible = false;
         }
         this.report("<b>Console v" + VERSION + RC2 + "</b> build " + CONSOLE_CONST5 + ". " + Capabilities.playerType + " " + Capabilities.version + ".",-2);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame4);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public static function getString10(param1:*) : String
      {
         if(param1 is String)
         {
            return param1 as String;
         }
         if(param1)
         {
            return LogReferences.ShortClassName(param1);
         }
         return CONSOLE_CONST3;
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         if(this.commandLine1.base == null)
         {
            this.commandLine1.base = parent;
         }
         if(loaderInfo)
         {
            this.doAction799(loaderInfo);
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         stage.addEventListener(Event.MOUSE_LEAVE,this.onStageMouseLeave,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyBinder1.onStageKeyDown,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyBinder1.onStageKeyUp,false,0,true);
      }
      
      private function onRemovedFromStage(param1:Event = null) : void
      {
         this.commandLine1.base = null;
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.removeEventListener(Event.MOUSE_LEAVE,this.onStageMouseLeave);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyBinder1.onStageKeyDown);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyBinder1.onStageKeyUp);
      }
      
      private function onStageMouseLeave(param1:Event) : void
      {
         this._panels.tooltip(null);
      }
      
      public function doAction799(param1:LoaderInfo) : void
      {
         var errorEvents:IEventDispatcher = null;
         try
         {
            errorEvents = param1["uncaughtErrorEvents"];
            if(errorEvents)
            {
               errorEvents.addEventListener("uncaughtError",this.onUncaughtError,false,0,true);
            }
         }
         catch(err:Error)
         {
         }
      }
      
      private function onUncaughtError(param1:Event) : void
      {
         var errorValue:* = param1.hasOwnProperty("error") ? param1["error"] : param1;
         var errorText:String;
         if(errorValue is Error)
         {
            errorText = this.logReferences1.makeString(errorValue);
         }
         else if(errorValue is ErrorEvent)
         {
            errorText = ErrorEvent(errorValue).text;
         }
         if(!errorText)
         {
            errorText = String(errorValue);
         }
         this.report(errorText,CONSOLE_CONST7,false);
      }
      
      public function doAction678(param1:String, param2:Object, param3:String, param4:Number = -1, param5:String = null, param6:Rectangle = null, param7:Boolean = false) : void
      {
         this._graphing.add(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function doAction816(param1:String, param2:Number = NaN, param3:Number = NaN) : void
      {
         this._graphing.doAction683(param1,param2,param3);
      }
      
      public function removeGraph(param1:String, param2:Object = null, param3:String = null) : void
      {
         this._graphing.remove(param1,param2,param3);
      }
      
      public function doAction842(param1:KeyBind, param2:Function, param3:Array = null) : void
      {
         if(param1)
         {
            this.keyBinder1.doAction842(param1,param2,param3);
         }
      }
      
      public function doAction890(param1:String, param2:Function, param3:Array = null, param4:String = null) : void
      {
         this.panels.mainPanel.doAction890(param1,param2,param3,param4);
      }
      
      public function get displayRoller() : Boolean
      {
         return this._panels.displayRoller;
      }
      
      public function set displayRoller(param1:Boolean) : void
      {
         this._panels.displayRoller = param1;
      }
      
      public function setRollerCaptureKey(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(this.keyBind1)
         {
            this.doAction842(this.keyBind1,null);
            keyBind1 = null;
         }
         if(param1 && param1.length == 1)
         {
            keyBind1 = new KeyBind(param1,param2,param3,param4);
            this.doAction842(this.keyBind1,this.doAction146);
         }
      }
      
      public function get rollerCaptureKey() : KeyBind
      {
         return this.keyBind1;
      }
      
      private function doAction146() : void
      {
         if(this.displayRoller)
         {
            this.report("Display Roller Capture:<br/>" + RollerPanel(this._panels.getConsolePanel1(RollerPanel.CHANNELS_PANEL)).getString50(true),-1);
         }
      }
      
      public function get fpsMonitor() : Boolean
      {
         return this._graphing.fpsMonitor;
      }
      
      public function set fpsMonitor(param1:Boolean) : void
      {
         this._graphing.fpsMonitor = param1;
      }
      
      public function get memoryMonitor() : Boolean
      {
         return this._graphing.memoryMonitor;
      }
      
      public function set memoryMonitor(param1:Boolean) : void
      {
         this._graphing.memoryMonitor = param1;
      }
      
      public function getString9(param1:Object, param2:String = null) : String
      {
         return this.memoryMonitor1.getString9(param1,param2);
      }
      
      public function doAction104(param1:String) : void
      {
         this.memoryMonitor1.doAction104(param1);
      }
      
      public function gc() : void
      {
         this.memoryMonitor1.gc();
      }
      
      public function doAction163(param1:String, param2:Object, param3:Boolean = false) : void
      {
         this.commandLine1.doAction163(param1,param2,param3);
      }
      
      public function map(param1:DisplayObjectContainer, param2:uint = 0) : void
      {
         this.consoleTools1.map(param1,param2,CONSOLE_CONST3);
      }
      
      public function mapch(param1:*, param2:DisplayObjectContainer, param3:uint = 0) : void
      {
         this.consoleTools1.map(param2,param3,getString10(param1));
      }
      
      public function inspect(param1:Object, param2:Boolean = true) : void
      {
         this.logReferences1.inspect(param1,param2,CONSOLE_CONST3);
      }
      
      public function doAction745(param1:*, param2:Object, param3:Boolean = true) : void
      {
         this.logReferences1.inspect(param2,param3,getString10(param1));
      }
      
      public function explode(param1:Object, param2:int = 3) : void
      {
         this.addLogLine(new Array(this.consoleTools1.explode(param1,param2)),1,null,false,true);
      }
      
      public function explodech(param1:*, param2:Object, param3:int = 3) : void
      {
         this.addLogLine(new Array(this.consoleTools1.explode(param2,param3)),1,param1,false,true);
      }
      
      public function get paused() : Boolean
      {
         return this.intValue65;
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(this.intValue65 == param1)
         {
            return;
         }
         if(param1)
         {
            this.report("Paused",10);
         }
         else
         {
            this.report("Resumed",-1);
         }
         intValue65 = param1;
         this._panels.mainPanel.doAction229(param1);
      }
      
      override public function get width() : Number
      {
         return this._panels.mainPanel.width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._panels.mainPanel.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         this._panels.mainPanel.height = param1;
      }
      
      override public function get height() : Number
      {
         return this._panels.mainPanel.height;
      }
      
      override public function get x() : Number
      {
         return this._panels.mainPanel.x;
      }
      
      override public function set x(param1:Number) : void
      {
         this._panels.mainPanel.x = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         this._panels.mainPanel.y = param1;
      }
      
      override public function get y() : Number
      {
         return this._panels.mainPanel.y;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            this._panels.mainPanel.visible = true;
         }
      }
      
      private function onEnterFrame4(param1:Event) : void
      {
         var currentTime:int = getTimer();
         var logsChanged:Boolean = this.logs1.update(currentTime);
         var graphGroups:Array;
         this.logReferences1.update(currentTime);
         this.memoryMonitor1.update();
         if(this.remoter.remoting != Remoting.RECIEVER)
         {
            graphGroups = this._graphing.update(stage ? stage.frameRate : 0);
         }
         this.remoting1.update();
         if(visible && parent)
         {
            if(this.config.flag103 && parent.getChildAt(parent.numChildren - 1) != this && this.intValue152 > 0)
            {
               --this.intValue152;
               parent.addChild(this);
               this.report("Moved console on top (alwaysOnTop enabled), " + this.intValue152 + " attempts left.",-1);
            }
            this._panels.update(this.intValue65,logsChanged);
            if(graphGroups)
            {
               this._panels.updateGraphs(graphGroups);
            }
         }
      }
      
      public function get remoting() : Boolean
      {
         return this.remoting1.remoting == Remoting.REMOTING_CONST1;
      }
      
      public function set remoting(param1:Boolean) : void
      {
         this.remoting1.remoting = param1 ? Remoting.REMOTING_CONST1 : Remoting.NONE;
      }
      
      public function remotingSocket(param1:String, param2:int) : void
      {
         this.remoting1.remotingSocket(param1,param2);
      }
      
      public function setViewingChannels(... rest) : void
      {
         this._panels.mainPanel.setViewingChannels.apply(this,rest);
      }
      
      public function doAction156(... rest) : void
      {
         this._panels.mainPanel.doAction156.apply(this,rest);
      }
      
      public function set propValue33(param1:uint) : void
      {
         this._panels.mainPanel.priority = param1;
      }
      
      public function report(param1:*, param2:int = 0, param3:Boolean = true, param4:String = null) : void
      {
         if(!param4)
         {
            param4 = this._panels.mainPanel.reportChannel;
         }
         this.addLogLine([param1],param2,param4,false,param3,0);
      }
      
      public function addLogLine(param1:Array, param2:int = 0, param3:* = null, param4:Boolean = false, param5:Boolean = false, param6:int = -1) : void
      {
         var message:String = "";
         var argumentCount:int = param1.length;
         var argumentIndex:int = 0;
         while(argumentIndex < argumentCount)
         {
            message += (argumentIndex ? " " : "") + this.logReferences1.makeString(param1[argumentIndex],null,param5);
            argumentIndex++;
         }
         if(param2 >= this._config.intValue193 && param6 < 0)
         {
            param6 = this._config.intValue115;
         }
         if(!param5 && param6 > 0)
         {
            message += this.consoleTools1.getString2(param6,param2);
         }
         this.logs1.add(new Log(message,getString10(param3),param2,param4,param5));
      }
      
      public function set commandLine(param1:Boolean) : void
      {
         this._panels.mainPanel.commandLine = param1;
      }
      
      public function get commandLine() : Boolean
      {
         return this._panels.mainPanel.commandLine;
      }
      
      public function doAction874(param1:String, param2:Function, param3:String = "", param4:Boolean = true, param5:String = ";") : void
      {
         this.commandLine1.doAction874(param1,param2,param3,param4,param5);
      }
      
      public function add(param1:*, param2:int = 2, param3:Boolean = false) : void
      {
         this.addLogLine([param1],param2,CONSOLE_CONST3,param3);
      }
      
      public function doAction767(param1:*, param2:int = -1, param3:int = 5) : void
      {
         this.addLogLine([param1],param3,CONSOLE_CONST3,false,false,param2 >= 0 ? param2 : this._config.intValue115);
      }
      
      public function doAction489(param1:*, param2:*, param3:int = -1, param4:int = 5) : void
      {
         this.addLogLine([param2],param4,param1,false,false,param3 >= 0 ? param3 : this._config.intValue115);
      }
      
      public function log(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST2);
      }
      
      public function info(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST11);
      }
      
      public function doAction28(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST10);
      }
      
      public function doAction705(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST9);
      }
      
      public function error(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST8);
      }
      
      public function doAction176(... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST7);
      }
      
      public function ch(param1:*, param2:*, param3:Number = 2, param4:Boolean = false) : void
      {
         this.addLogLine([param2],param3,param1,param4);
      }
      
      public function doAction781(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST2,param1);
      }
      
      public function doAction166(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST11,param1);
      }
      
      public function doAction33(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST10,param1);
      }
      
      public function doAction20(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST9,param1);
      }
      
      public function doAction675(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST8,param1);
      }
      
      public function doAction101(param1:*, ... rest) : void
      {
         this.addLogLine(rest,CONSOLE_CONST7,param1);
      }
      
      public function doAction692(param1:*, param2:Array, param3:int = 2, param4:Boolean = false) : void
      {
         this.addLogLine(param2,param3,param1,param4);
      }
      
      public function doAction793(... rest) : void
      {
         this.addLogLine(rest,2,CONSOLE_CONST3,false,this.check47(rest));
      }
      
      public function doAction97(param1:*, param2:int, ... rest) : void
      {
         this.addLogLine(rest,param2,param1,false,this.check47(rest));
      }
      
      private function check47(args:Array) : Boolean
      {
         try
         {
            new XML("<p>" + args.join("") + "</p>");
         }
         catch(err:Error)
         {
            return false;
         }
         return true;
      }
      
      public function clear(param1:String = null) : void
      {
         this.logs1.clear(param1);
         if(!this.intValue65)
         {
            this._panels.mainPanel.doAction560();
         }
         this._panels.updateMenu();
      }
      
      public function getString8(param1:String = "\r\n") : String
      {
         return this.logs1.getLogsAsString(param1);
      }
      
      public function get config() : ConsoleConfig
      {
         return this._config;
      }
      
      public function get panels() : PanelsManager
      {
         return this._panels;
      }
      
      public function get cl() : CommandLine
      {
         return this.commandLine1;
      }
      
      public function get remoter() : Remoting
      {
         return this.remoting1;
      }
      
      public function get graphing() : Graphing
      {
         return this._graphing;
      }
      
      public function get refs() : LogReferences
      {
         return this.logReferences1;
      }
      
      public function get logs() : Logs
      {
         return this.logs1;
      }
      
      public function get propValue190() : ConsoleTools
      {
         return this.consoleTools1;
      }
      
      public function get so() : Object
      {
         return this.obj15;
      }
      
      public function updateSO(param1:String = null) : void
      {
         if(this.sharedObject1)
         {
            if(param1)
            {
               this.sharedObject1.setDirty(param1);
            }
            else
            {
               this.sharedObject1.clear();
            }
         }
      }
   }
}

