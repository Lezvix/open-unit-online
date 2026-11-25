package com.junkbyte.console.core
{
   import com.junkbyte.console.Console;
   import flash.events.AsyncErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Remoting extends ConsoleCore
   {
      
      public static const NONE:uint = 0;
      
      public static const REMOTING_CONST1:uint = 1;
      
      public static const RECIEVER:uint = 2;
      
      private var obj18:Object;
      
      private var intValue192:uint;
      
      private var _local:LocalConnection;
      
      private var _socket:Socket;
      
      private var _sendBuffer:ByteArray;
      
      private var obj45:Object;
      
      private var dict5:Dictionary;
      
      private var str1:String = "";
      
      private var flag59:Boolean;
      
      private var str23:String;
      
      private var str7:String;
      
      public function Remoting(m:Console)
      {
         this.obj18 = new Object();
         this._sendBuffer = new ByteArray();
         this.obj45 = new Object();
         this.dict5 = new Dictionary();
         super(m);
         this.registerCallback("login",function(param1:ByteArray):void
         {
            login(param1.readUTF());
         });
         this.registerCallback("requestLogin",this.requestLogin);
         this.registerCallback("loginFail",this.loginFail);
         this.registerCallback("loginSuccess",this.loginSuccess);
      }
      
      public function update() : void
      {
         var id:String = null;
         var packet:ByteArray = null;
         var target:String = null;
         var newbuffer:ByteArray = null;
         var buffer:ByteArray = null;
         var pointer:uint = 0;
         var cmd:String = null;
         var arg:ByteArray = null;
         var callbackData:Object = null;
         var blen:uint = 0;
         var recbuffer:ByteArray = null;
         if(this._sendBuffer.length)
         {
            if(this._socket && this._socket.connected)
            {
               this._socket.writeBytes(this._sendBuffer);
               _sendBuffer = new ByteArray();
            }
            else if(this._local)
            {
               this._sendBuffer.position = 0;
               if(this._sendBuffer.bytesAvailable < 38000)
               {
                  packet = this._sendBuffer;
                  _sendBuffer = new ByteArray();
               }
               else
               {
                  packet = new ByteArray();
                  this._sendBuffer.readBytes(packet,0,Math.min(38000,this._sendBuffer.bytesAvailable));
                  newbuffer = new ByteArray();
                  this._sendBuffer.readBytes(newbuffer);
                  _sendBuffer = newbuffer;
               }
               target = config.remotingConnectionName + (this.remoting == Remoting.RECIEVER ? REMOTING_CONST1.toString() : RECIEVER.toString());
               this._local.send(target,"synchronize",this.str23,packet);
            }
            else
            {
               _sendBuffer = new ByteArray();
            }
         }
         for(id in this.obj45)
         {
            if(!this.dict5[id])
            {
               this.dict5[id] = true;
               if(this.str7)
               {
                  report("Remote switched to new sender [" + id + "] as primary.",-2);
               }
               str7 = id;
            }
            buffer = this.obj45[id];
            try
            {
               pointer = buffer.position = 0;
               while(buffer.bytesAvailable)
               {
                  cmd = buffer.readUTF();
                  arg = null;
                  if(buffer.bytesAvailable == 0)
                  {
                     break;
                  }
                  if(buffer.readBoolean())
                  {
                     if(buffer.bytesAvailable == 0)
                     {
                        break;
                     }
                     blen = buffer.readUnsignedInt();
                     if(buffer.bytesAvailable < blen)
                     {
                        break;
                     }
                     arg = new ByteArray();
                     buffer.readBytes(arg,0,blen);
                  }
                  callbackData = this.obj18[cmd];
                  if(!callbackData.latest || id == this.str7)
                  {
                     if(arg)
                     {
                        callbackData.fun(arg);
                     }
                     else
                     {
                        callbackData.fun();
                     }
                  }
                  pointer = buffer.position;
               }
               if(pointer < buffer.length)
               {
                  recbuffer = new ByteArray();
                  recbuffer.writeBytes(buffer,pointer);
                  this.obj45[id] = buffer = recbuffer;
               }
               else
               {
                  delete this.obj45[id];
               }
            }
            catch(err:Error)
            {
               report("Remoting sync error: " + err,9);
            }
         }
      }
      
      private function synchronize(param1:String, param2:Object) : void
      {
         if(!(param2 is ByteArray))
         {
            report("Remoting sync error. Recieved non-ByteArray:" + param2,9);
            return;
         }
         var incomingBytes:ByteArray = param2 as ByteArray;
         var existingBuffer:ByteArray = this.obj45[param1];
         if(existingBuffer)
         {
            existingBuffer.position = existingBuffer.length;
            existingBuffer.writeBytes(incomingBytes);
         }
         else
         {
            this.obj45[param1] = incomingBytes;
         }
      }
      
      public function send(param1:String, param2:ByteArray = null) : Boolean
      {
         if(this.intValue192 == NONE)
         {
            return false;
         }
         this._sendBuffer.position = this._sendBuffer.length;
         this._sendBuffer.writeUTF(param1);
         if(param2)
         {
            this._sendBuffer.writeBoolean(true);
            this._sendBuffer.writeUnsignedInt(param2.length);
            this._sendBuffer.writeBytes(param2);
         }
         else
         {
            this._sendBuffer.writeBoolean(false);
         }
         return true;
      }
      
      public function get remoting() : uint
      {
         return this.intValue192;
      }
      
      public function get canSend() : Boolean
      {
         return this.intValue192 == REMOTING_CONST1 && this.flag59;
      }
      
      public function set remoting(param1:uint) : void
      {
         var sandboxKind:String = null;
         if(param1 == this.intValue192)
         {
            return;
         }
         str23 = this.getString49();
         if(param1 == REMOTING_CONST1)
         {
            if(!this.check37(REMOTING_CONST1))
            {
               report("Could not create remoting client service. You will not be able to control this console with remote.",10);
            }
            _sendBuffer = new ByteArray();
            this._local.addEventListener(StatusEvent.STATUS,this.onStatus,false,0,true);
            report("<b>Remoting started.</b> " + this.getInfo(),-1);
            flag59 = this.check17("");
            if(this.flag59)
            {
               this.doAction225();
            }
            else
            {
               this.send("requestLogin");
            }
         }
         else if(param1 == RECIEVER)
         {
            if(this.check37(RECIEVER))
            {
               _sendBuffer = new ByteArray();
               this._local.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onAsyncError,false,0,true);
               this._local.addEventListener(StatusEvent.STATUS,this.onStatus2,false,0,true);
               report("<b>Remote started.</b> " + this.getInfo(),-1);
               sandboxKind = Security.sandboxType;
               if(sandboxKind == Security.LOCAL_WITH_FILE || sandboxKind == Security.LOCAL_WITH_NETWORK)
               {
                  report("Untrusted local sandbox. You may not be able to listen for logs properly.",10);
                  this.doAction370();
               }
               this.login(this.str1);
            }
            else
            {
               report("Could not create remote service. You might have a console remote already running.",10);
            }
         }
         else
         {
            this.close();
         }
         console.panels.updateMenu();
      }
      
      public function remotingSocket(param1:String, param2:int = 0) : void
      {
         if(this._socket && this._socket.connected)
         {
            this._socket.close();
            _socket = null;
         }
         if(param1 && param2)
         {
            remoting = REMOTING_CONST1;
            report("Connecting to socket " + param1 + ":" + param2);
            _socket = new Socket();
            this._socket.addEventListener(Event.CLOSE,this.socketCloseHandler);
            this._socket.addEventListener(Event.CONNECT,this.socketConnectHandler);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.closeSocket);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.socketSecurityErrorHandler);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.socketDataHandler);
            this._socket.connect(param1,param2);
         }
      }
      
      private function socketCloseHandler(param1:Event) : void
      {
         if(param1.currentTarget == this._socket)
         {
            _socket = null;
         }
      }
      
      private function socketConnectHandler(param1:Event) : void
      {
         report("Remoting socket connected.",-1);
         _sendBuffer = new ByteArray();
         if(this.flag59 || this.check17(""))
         {
            this.doAction225();
         }
         else
         {
            this.send("requestLogin");
         }
      }
      
      private function closeSocket(param1:Event) : void
      {
         report("Remoting socket error." + param1,9);
         this.remotingSocket(null);
      }
      
      private function socketSecurityErrorHandler(param1:Event) : void
      {
         report("Remoting security error." + param1,9);
         this.remotingSocket(null);
      }
      
      private function socketDataHandler(param1:Event) : void
      {
         this.doAction903(param1.currentTarget as Socket);
      }
      
      public function doAction903(param1:Socket) : void
      {
         if(!this.dict5[param1])
         {
            this.dict5[param1] = this.getString49();
            _socket = param1;
         }
         var incomingBytes:ByteArray = new ByteArray();
         param1.readBytes(incomingBytes);
         this.synchronize(this.dict5[param1],incomingBytes);
      }
      
      private function onStatus(param1:StatusEvent) : void
      {
         if(param1.level == "error" && !(this._socket && this._socket.connected))
         {
            flag59 = false;
         }
      }
      
      private function onStatus2(param1:StatusEvent) : void
      {
         if(this.remoting == Remoting.RECIEVER && param1.level == "error")
         {
            report("Problem communicating to client.",10);
         }
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         report("Remoting security error.",9);
         this.doAction370();
      }
      
      private function onAsyncError(param1:AsyncErrorEvent) : void
      {
         report("Problem with remote sync. [<a href=\'event:remote\'>Click here</a>] to restart.",10);
         remoting = NONE;
      }
      
      private function getInfo() : String
      {
         return "<p4>channel:" + config.remotingConnectionName + " (" + Security.sandboxType + ")</p4>";
      }
      
      private function doAction370() : void
      {
         report("Make sure your flash file is \'trusted\' in Global Security Settings.",-2);
         report("Go to Settings Manager [<a href=\'event:settings\'>click here</a>] &gt; \'Global Security Settings Panel\' (on left) &gt; add the location of the local flash (swf) file.",-2);
      }
      
      private function getString49() : String
      {
         return new Date().time + "." + Math.floor(Math.random() * 100000);
      }
      
      private function check37(targetmode:uint) : Boolean
      {
         this.close();
         intValue192 = targetmode;
         _local = new LocalConnection();
         this._local.client = {"synchronize":this.synchronize};
         if(config.allowedRemoteDomain)
         {
            this._local.allowDomain(config.allowedRemoteDomain);
            this._local.allowInsecureDomain(config.allowedRemoteDomain);
         }
         this._local.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
         try
         {
            this._local.connect(config.remotingConnectionName + this.intValue192);
         }
         catch(err:Error)
         {
            return false;
         }
         return true;
      }
      
      public function registerCallback(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.obj18[param1] = {
            "fun":param2,
            "latest":param3
         };
      }
      
      private function loginFail() : void
      {
         if(this.remoting != Remoting.RECIEVER)
         {
            return;
         }
         report("Login Failed",10);
         console.panels.mainPanel.requestLogin();
      }
      
      private function doAction225() : void
      {
         flag59 = true;
         this.send("loginSuccess");
         dispatchEvent(new Event(Event.CONNECT));
      }
      
      private function loginSuccess() : void
      {
         console.setViewingChannels();
         report("Login Successful",-1);
      }
      
      private function requestLogin() : void
      {
         if(this.remoting != Remoting.RECIEVER)
         {
            return;
         }
         _sendBuffer = new ByteArray();
         if(this.str1)
         {
            this.login(this.str1);
         }
         else
         {
            console.panels.mainPanel.requestLogin();
         }
      }
      
      public function login(param1:String = "") : void
      {
         var payload:ByteArray = null;
         if(this.remoting == Remoting.RECIEVER)
         {
            str1 = param1;
            report("Attempting to login...",-1);
            payload = new ByteArray();
            payload.writeUTF(param1);
            this.send("login",payload);
         }
         else if(this.flag59 || this.check17(param1))
         {
            this.doAction225();
         }
         else
         {
            this.send("loginFail");
         }
      }
      
      private function check17(param1:String) : Boolean
      {
         return config.remotingPassword === null && config.keystrokePassword == param1 || config.remotingPassword === "" || config.remotingPassword == param1;
      }
      
      public function close() : void
      {
         if(this._local)
         {
            try
            {
               this._local.close();
            }
            catch(error:Error)
            {
               report("Remote.close: " + error,10);
            }
         }
         intValue192 = NONE;
         _sendBuffer = new ByteArray();
         _local = null;
      }
   }
}

