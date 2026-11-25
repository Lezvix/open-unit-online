package com.junkbyte.console
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class Cc
   {
      
      private static var _console:Console;
      
      private static var _config:ConsoleConfig;
      
      public function Cc()
      {
         super();
      }
      
      public static function get config() : ConsoleConfig
      {
         if(!_config)
         {
            _config = new ConsoleConfig();
         }
         return _config;
      }
      
      public static function start(param1:DisplayObjectContainer, param2:String = "") : void
      {
         if(_console)
         {
            if(param1 && !_console.parent)
            {
               param1.addChild(_console);
            }
         }
         else
         {
            _console = new Console(param2,config);
            if(param1)
            {
               param1.addChild(_console);
            }
         }
      }
      
      public static function doAction721(param1:DisplayObject, param2:String = "") : void
      {
         if(_console)
         {
            if(param1 && param1.stage && _console.parent != param1.stage)
            {
               param1.stage.addChild(_console);
            }
         }
         else if(param1 && param1.stage)
         {
            start(param1.stage,param2);
         }
         else
         {
            _console = new Console(param2,config);
            if(param1)
            {
               param1.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage2);
            }
         }
      }
      
      public static function add(param1:*, param2:int = 2, param3:Boolean = false) : void
      {
         if(_console)
         {
            _console.add(param1,param2,param3);
         }
      }
      
      public static function ch(param1:*, param2:*, param3:int = 2, param4:Boolean = false) : void
      {
         if(_console)
         {
            _console.ch(param1,param2,param3,param4);
         }
      }
      
      public static function log(... rest) : void
      {
         if(_console)
         {
            _console.log.apply(null,rest);
         }
      }
      
      public static function info(... rest) : void
      {
         if(_console)
         {
            _console.info.apply(null,rest);
         }
      }
      
      public static function doAction28(... rest) : void
      {
         if(_console)
         {
            _console.doAction28.apply(null,rest);
         }
      }
      
      public static function doAction705(... rest) : void
      {
         if(_console)
         {
            _console.doAction705.apply(null,rest);
         }
      }
      
      public static function error(... rest) : void
      {
         if(_console)
         {
            _console.error.apply(null,rest);
         }
      }
      
      public static function doAction176(... rest) : void
      {
         if(_console)
         {
            _console.doAction176.apply(null,rest);
         }
      }
      
      public static function doAction781(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST2);
         }
      }
      
      public static function doAction166(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST11);
         }
      }
      
      public static function doAction33(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST10);
         }
      }
      
      public static function doAction20(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST9);
         }
      }
      
      public static function doAction675(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST8);
         }
      }
      
      public static function doAction101(param1:*, ... rest) : void
      {
         if(_console)
         {
            _console.doAction692(param1,rest,Console.CONSOLE_CONST7);
         }
      }
      
      public static function doAction767(param1:*, param2:int = -1, param3:int = 5) : void
      {
         if(_console)
         {
            _console.doAction767(param1,param2,param3);
         }
      }
      
      public static function doAction489(param1:*, param2:*, param3:int = -1, param4:int = 5) : void
      {
         if(_console)
         {
            _console.doAction489(param1,param2,param3,param4);
         }
      }
      
      public static function inspect(param1:Object, param2:Boolean = true) : void
      {
         if(_console)
         {
            _console.inspect(param1,param2);
         }
      }
      
      public static function doAction745(param1:*, param2:Object, param3:Boolean = true) : void
      {
         if(_console)
         {
            _console.doAction745(param1,param2,param3);
         }
      }
      
      public static function explode(param1:Object, param2:int = 3) : void
      {
         if(_console)
         {
            _console.explode(param1,param2);
         }
      }
      
      public static function explodech(param1:*, param2:Object, param3:int = 3) : void
      {
         if(_console)
         {
            _console.explodech(param1,param2,param3);
         }
      }
      
      public static function doAction793(... rest) : void
      {
         if(_console)
         {
            _console.doAction793.apply(null,rest);
         }
      }
      
      public static function doAction97(param1:*, param2:int, ... rest) : void
      {
         if(_console)
         {
            _console.doAction97.apply(null,new Array(param1,param2).concat(rest));
         }
      }
      
      public static function map(param1:DisplayObjectContainer, param2:uint = 0) : void
      {
         if(_console)
         {
            _console.map(param1,param2);
         }
      }
      
      public static function mapch(param1:String, param2:DisplayObjectContainer, param3:uint = 0) : void
      {
         if(_console)
         {
            _console.mapch(param1,param2,param3);
         }
      }
      
      public static function clear(param1:String = null) : void
      {
         if(_console)
         {
            _console.clear(param1);
         }
      }
      
      public static function doAction842(param1:KeyBind, param2:Function = null, param3:Array = null) : void
      {
         if(_console)
         {
            _console.doAction842(param1,param2,param3);
         }
      }
      
      public static function doAction890(param1:String, param2:Function, param3:Array = null, param4:String = null) : void
      {
         if(_console)
         {
            _console.doAction890(param1,param2,param3,param4);
         }
      }
      
      public static function doAction799(param1:LoaderInfo) : void
      {
         if(_console)
         {
            _console.doAction799(param1);
         }
      }
      
      public static function doAction163(param1:String, param2:Object, param3:Boolean = false) : void
      {
         if(_console)
         {
            _console.doAction163(param1,param2,param3);
         }
      }
      
      public static function doAction874(param1:String, param2:Function, param3:String = "", param4:Boolean = true, param5:String = ";") : void
      {
         if(_console)
         {
            _console.doAction874(param1,param2,param3,param4,param5);
         }
      }
      
      public static function getString9(param1:Object, param2:String = null) : String
      {
         if(_console)
         {
            return _console.getString9(param1,param2);
         }
         return null;
      }
      
      public static function doAction104(param1:String) : void
      {
         if(_console)
         {
            _console.doAction104(param1);
         }
      }
      
      public static function doAction678(param1:String, param2:Object, param3:String, param4:Number = -1, param5:String = null, param6:Rectangle = null, param7:Boolean = false) : void
      {
         if(_console)
         {
            _console.doAction678(param1,param2,param3,param4,param5,param6,param7);
         }
      }
      
      public static function doAction816(param1:String, param2:Number = NaN, param3:Number = NaN) : void
      {
         if(_console)
         {
            _console.doAction816(param1,param2,param3);
         }
      }
      
      public static function removeGraph(param1:String, param2:Object = null, param3:String = null) : void
      {
         if(_console)
         {
            _console.removeGraph(param1,param2,param3);
         }
      }
      
      public static function setViewingChannels(... rest) : void
      {
         if(_console)
         {
            _console.setViewingChannels.apply(null,rest);
         }
      }
      
      public static function doAction156(... rest) : void
      {
         if(_console)
         {
            _console.doAction156.apply(null,rest);
         }
      }
      
      public static function set propValue33(param1:uint) : void
      {
         if(_console)
         {
            _console.propValue33 = param1;
         }
      }
      
      public static function get width() : Number
      {
         if(_console)
         {
            return _console.width;
         }
         return 0;
      }
      
      public static function set width(param1:Number) : void
      {
         if(_console)
         {
            _console.width = param1;
         }
      }
      
      public static function get height() : Number
      {
         if(_console)
         {
            return _console.height;
         }
         return 0;
      }
      
      public static function set height(param1:Number) : void
      {
         if(_console)
         {
            _console.height = param1;
         }
      }
      
      public static function get x() : Number
      {
         if(_console)
         {
            return _console.x;
         }
         return 0;
      }
      
      public static function set x(param1:Number) : void
      {
         if(_console)
         {
            _console.x = param1;
         }
      }
      
      public static function get y() : Number
      {
         if(_console)
         {
            return _console.y;
         }
         return 0;
      }
      
      public static function set y(param1:Number) : void
      {
         if(_console)
         {
            _console.y = param1;
         }
      }
      
      public static function get visible() : Boolean
      {
         if(_console)
         {
            return _console.visible;
         }
         return false;
      }
      
      public static function set visible(param1:Boolean) : void
      {
         if(_console)
         {
            _console.visible = param1;
         }
      }
      
      public static function get fpsMonitor() : Boolean
      {
         if(_console)
         {
            return _console.fpsMonitor;
         }
         return false;
      }
      
      public static function set fpsMonitor(param1:Boolean) : void
      {
         if(_console)
         {
            _console.fpsMonitor = param1;
         }
      }
      
      public static function get memoryMonitor() : Boolean
      {
         if(_console)
         {
            return _console.memoryMonitor;
         }
         return false;
      }
      
      public static function set memoryMonitor(param1:Boolean) : void
      {
         if(_console)
         {
            _console.memoryMonitor = param1;
         }
      }
      
      public static function get commandLine() : Boolean
      {
         if(_console)
         {
            return _console.commandLine;
         }
         return false;
      }
      
      public static function set commandLine(param1:Boolean) : void
      {
         if(_console)
         {
            _console.commandLine = param1;
         }
      }
      
      public static function get displayRoller() : Boolean
      {
         if(_console)
         {
            return _console.displayRoller;
         }
         return false;
      }
      
      public static function set displayRoller(param1:Boolean) : void
      {
         if(_console)
         {
            _console.displayRoller = param1;
         }
      }
      
      public static function setRollerCaptureKey(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(_console)
         {
            _console.setRollerCaptureKey(param1,param4,param2,param3);
         }
      }
      
      public static function get remoting() : Boolean
      {
         if(_console)
         {
            return _console.remoting;
         }
         return false;
      }
      
      public static function set remoting(param1:Boolean) : void
      {
         if(_console)
         {
            _console.remoting = param1;
         }
      }
      
      public static function remotingSocket(param1:String, param2:int) : void
      {
         if(_console)
         {
            _console.remotingSocket(param1,param2);
         }
      }
      
      public static function remove() : void
      {
         if(_console)
         {
            if(_console.parent)
            {
               _console.parent.removeChild(_console);
            }
            _console = null;
         }
      }
      
      public static function getString8(param1:String = "\r\n") : String
      {
         if(_console)
         {
            return _console.getString8(param1);
         }
         return "";
      }
      
      public static function get instance() : Console
      {
         return _console;
      }
      
      private static function onAddedToStage2(param1:Event) : void
      {
         var container:DisplayObjectContainer = param1.currentTarget as DisplayObjectContainer;
         container.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage2);
         if(_console && _console.parent == null)
         {
            container.stage.addChild(_console);
         }
      }
   }
}

