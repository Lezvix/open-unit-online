package com.junkbyte.console.vos
{
   import flash.utils.ByteArray;
   
   public class Log
   {
      
      public var line:uint;
      
      public var text:String;
      
      public var ch:String;
      
      public var priority:int;
      
      public var repeat:Boolean;
      
      public var html:Boolean;
      
      public var time:uint;
      
      public var timeStr:String;
      
      public var str11:String;
      
      public var str24:String;
      
      public var next:Log;
      
      public var log1:Log;
      
      public function Log(param1:String, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         this.text = param1;
         this.ch = param2;
         this.priority = param3;
         this.repeat = param4;
         this.html = param5;
      }
      
      public static function getGraphGroup1(param1:ByteArray) : Log
      {
         var message:String = param1.readUTFBytes(param1.readUnsignedInt());
         var channel:String = param1.readUTF();
         var level:int = param1.readInt();
         var isRepeated:Boolean = param1.readBoolean();
         return new Log(message,channel,level,isRepeated,true);
      }
      
      public function doAction32(param1:ByteArray) : void
      {
         var encodedText:ByteArray = new ByteArray();
         encodedText.writeUTFBytes(this.text);
         param1.writeUnsignedInt(encodedText.length);
         param1.writeBytes(encodedText);
         param1.writeUTF(this.ch);
         param1.writeInt(this.priority);
         param1.writeBoolean(this.repeat);
      }
      
      public function getString26() : String
      {
         return this.text.replace(/<.*?>/g,"").replace(/&lt;/g,"<").replace(/&gt;/g,">");
      }
      
      public function toString() : String
      {
         return "[" + this.ch + "] " + this.getString26();
      }
      
      public function clone() : Log
      {
         var copy:Log = new Log(this.text,this.ch,this.priority,this.repeat,this.html);
         copy.line = this.line;
         copy.time = this.time;
         return copy;
      }
   }
}

