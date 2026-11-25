package com.junkbyte.console
{
   public class ConsoleConfig
   {
      
      public var keystrokePassword:String;
      
      public var remotingPassword:String;
      
      public var maxLines:uint = 1000;
      
      public var maxRepeats:int = 75;
      
      public var intValue193:int = Console.CONSOLE_CONST7;
      
      public var intValue115:int = 2;
      
      public var useObjectLinking:Boolean = true;
      
      public var objectHardReferenceTimer:uint = 0;
      
      public var tracing:Boolean;
      
      public var traceCall:Function = function(param1:String, param2:String, ... rest):void
      {
      };
      
      public var showTimestamp:Boolean = false;
      
      public var timeStampFormatter:Function = function(param1:uint):String
      {
         var seconds:uint = param1 * 0.001;
         return getString33(seconds / 60) + ":" + getString33(seconds % 60);
      };
      
      public function ConsoleConfig()
      {
         super();
         this.consoleStyle1 = new ConsoleStyle();
      }

      private function getString33(param1:uint) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return String(param1);
      }

      public var showLineNumber:Boolean = false;
      
      public var remotingConnectionName:String = "_Console";
      
      public var allowedRemoteDomain:String = "*";
      
      public var commandLineAllowed:Boolean;
      
      public var commandLineAutoScope:Boolean;
      
      public var commandLineInputPassThrough:Function;
      
      public var commandLineAutoCompleteEnabled:Boolean = true;
      
      public var keyBindsEnabled:Boolean = true;
      
      public var displayRollerEnabled:Boolean = true;
      
      public var rulerToolEnabled:Boolean = true;
      
      public var flag130:Boolean = true;
      
      public var str21:String = "com.junkbyte/Console/UserData";
      
      public var str44:String = "/";
      
      public var rememberFilterSettings:Boolean;
      
      public var flag103:Boolean = true;
      
      public function get style() : ConsoleStyle
      {
         return this.consoleStyle1;
      }

      private var consoleStyle1:ConsoleStyle;
   }
}

