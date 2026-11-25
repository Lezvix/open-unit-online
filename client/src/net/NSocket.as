package net
{
   import flash.errors.EOFError;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class NSocket extends Socket
   {
      
      private static const CHARS_D0:Array = [168,128,129,170,189,178,175,163,165,140,142,141,0,161,143,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239];
      
      private static const CHARS_D1:Array = [240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,0,184,144,131,186,190,179,191,188,154,156,158,157,0,162,159];
      
      private static const CHARS_D2:Array = [165,180];
      
      private static const CHARS_3:int = 3;
      
      private static const CHARS_1000:int = 1000;
      
      private var BA_CHARS_D0:ByteArray = new ByteArray();
      
      private var BA_CHARS_D1:ByteArray = new ByteArray();
      
      private var BA_CHARS_D2:ByteArray = new ByteArray();
      
      public var dataHandler:Function;
      
      public var connectHandler:Function;
      
      public var closeHandler:Function;
      
      public var connectionErrorHandler:Function;
      
      public var securityErrorHandler:Function;
      
      public var proxyConnectionErrorHandler:Function;
      
      public var proxySecurityErrorHandler:Function;
      
      public var host:String;
      
      public var port:uint;
      
      public var proxyHost:String;
      
      public var proxyPort:uint;
      
      public var lastSecurityEvent:SecurityErrorEvent;
      
      public var sockData:String;
      
      public var getData:Array;
      
      private var PROXY_LOADERS_COUNT:int = 1;
      
      private var urlLoaders:Array = new Array(PROXY_LOADERS_COUNT);
      
      private var getDataRequest:URLRequest;
      
      private var getVariables:URLVariables;
      
      private var proxyId:int = -1;
      
      private var hash:String = "";
      
      public var proxyConnect:Boolean = false;
      
      public var stopConnecting:Boolean = false;
      
      private var proxySendBuf:ByteArray;
      
      private var proxyHashBytes:ByteArray;
      
      private var socketReconnectAttempts:int = 0;
      
      public function NSocket(host:String = null, port:int = 5190)
      {
         var index:uint;
         var tableLength:uint = CHARS_D0.length;
         index = 0;
         while(index < tableLength)
         {
            this.BA_CHARS_D0.writeByte(CHARS_D0[index]);
            index++;
         }
         tableLength = CHARS_D1.length;
         index = 0;
         while(index < tableLength)
         {
            this.BA_CHARS_D1.writeByte(CHARS_D1[index]);
            index++;
         }
         tableLength = CHARS_D2.length;
         index = 0;
         while(index < tableLength)
         {
            this.BA_CHARS_D2.writeByte(CHARS_D2[index]);
            index++;
         }
         this.host = host;
         this.port = port;
         addEventListener(Event.CONNECT,this.socketConnectHandler);
         addEventListener(Event.CLOSE,this.socketCloseHandler);
         addEventListener(ProgressEvent.SOCKET_DATA,this.socketDataHandler);
         addEventListener(IOErrorEvent.IO_ERROR,this.closeSocket);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.socketSecurityErrorHandler);
         this.sockData = "";
         super();
      }
      
      public function connectGame() : void
      {
         var index:uint = 0;
         while(index < this.PROXY_LOADERS_COUNT)
         {
            if(this.urlLoaders[index])
            {
               this.urlLoaders[index].dispose();
               this.urlLoaders[index] = null;
            }
            index++;
         }
         proxyConnect = false;
         socketReconnectAttempts = 0;
         this.doAction782();
      }
      
      private function socketConnectHandler(event:Event) : void
      {
         this.connectHandler();
      }
      
      private function socketCloseHandler(event:Event) : void
      {
         this.closeHandler();
      }
      
      private function socketDataHandler(event:ProgressEvent) : void
      {
         sockData += readMultiByte(bytesAvailable,"x-cp1251");
         var messages:Array = this.sockData.split("#");
         var index:int = 0;
         while(index < messages.length - 1)
         {
            getData = messages[index].split("|");
            if(this.dataHandler == null || !this.dataHandler(this.getData))
            {
               this.handleData();
            }
            index++;
         }
         sockData = messages[messages.length - 1];
      }
      
      private function closeSocket(event:IOErrorEvent) : void
      {
         this.doAction961();
      }
      
      private function doAction961() : void
      {
         var delay:int = CHARS_1000 + (this.socketReconnectAttempts - 1) * 500;
         setTimeout(this.doAction782,delay);
      }
      
      private function doAction782() : void
      {
         if(this.socketReconnectAttempts < CHARS_3)
         {
            this.connect(this.host,this.port);
         }
         else if(!this.stopConnecting)
         {
            this.connectViaProxy();
            this.connectionErrorHandler();
         }
      }
      
      override public function connect(host:String, port:int) : void
      {
         socketReconnectAttempts += 1;
         super.connect(host,port);
      }
      
      private function socketSecurityErrorHandler(event:SecurityErrorEvent) : void
      {
         lastSecurityEvent = event;
         this.doAction961();
      }
      
      public function sendStr(str:String) : void
      {
         var request:URLRequest;
         var urlLoader:URLLoader;
         if(this.proxyConnect)
         {
            request = new URLRequest("http://" + this.host + "/webrule.fcgi");
            request.method = URLRequestMethod.POST;
            request.contentType = "application/x-www-form-urlencoded";
            proxySendBuf = new ByteArray();
            this.proxySendBuf.writeBytes(this.proxyHashBytes);
            this.writeCP1251String(str);
            request.data = this.proxySendBuf;
            urlLoader = new URLLoader();
            urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            try
            {
               urlLoader.addEventListener(Event.COMPLETE,this.urlSendLoaderCompleteHandler);
               urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.urlLoaderSendSecurityErrorHandler);
               urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.urlLoaderSendIoErrorHandler);
               urlLoader.load(request);
            }
            catch(error:Error)
            {
               trace(error);
            }
         }
         else if(connected)
         {
            writeByte(str.length & 0xFF);
            writeByte(str.length >> 8 & 0xFF);
            writeByte(str.length >> 16 & 0xFF);
            writeByte(str.length >> 24);
            this.writeCP1251String(str);
            flush();
         }
      }
      
      public function writeCP1251String(utfString:String) : void
      {
         var utfBytes:ByteArray = new ByteArray();
         var byteValue:int;
         utfBytes.writeUTFBytes(utfString);
         utfBytes.position = 0;
         try
         {
            while(true)
            {
               byteValue = utfBytes.readUnsignedByte();
               switch(byteValue)
               {
                  case 194:
                     byteValue = utfBytes.readUnsignedByte();
                     break;
                  case 208:
                     byteValue = this.BA_CHARS_D0[utfBytes.readUnsignedByte() - 129];
                     break;
                  case 209:
                     byteValue = this.BA_CHARS_D1[utfBytes.readUnsignedByte() - 128];
                     break;
                  case 209:
                     byteValue = this.BA_CHARS_D2[utfBytes.readUnsignedByte() - 144];
                     break;
                  case 226:
                     byteValue = utfBytes.readUnsignedByte();
                     switch(byteValue)
                     {
                        case 128:
                           byteValue = utfBytes.readUnsignedByte();
                           switch(byteValue)
                           {
                              case 147:
                                 byteValue = 150;
                                 break;
                              case 148:
                                 byteValue = 183;
                                 break;
                              case 152:
                                 byteValue = 145;
                                 break;
                              case 153:
                                 byteValue = 146;
                                 break;
                              case 154:
                                 byteValue = 130;
                                 break;
                              case 156:
                                 byteValue = 147;
                                 break;
                              case 157:
                                 byteValue = 148;
                                 break;
                              case 158:
                                 byteValue = 132;
                                 break;
                              case 160:
                                 byteValue = 134;
                                 break;
                              case 161:
                                 byteValue = 135;
                                 break;
                              case 162:
                                 byteValue = 149;
                                 break;
                              case 166:
                                 byteValue = 133;
                                 break;
                              case 176:
                                 byteValue = 137;
                                 break;
                              case 185:
                                 byteValue = 139;
                                 break;
                              case 186:
                                 byteValue = 155;
                                 break;
                           }
                           break;
                        case 130:
                           byteValue = 88;
                           break;
                        case 132:
                           byteValue = utfBytes.readUnsignedByte();
                           switch(byteValue)
                           {
                              case 150:
                                 byteValue = 185;
                                 break;
                              case 162:
                                 byteValue = 153;
                                 break;
                           }
                           break;
                     }
                     break;
               }
               if(this.proxyConnect)
               {
                  this.proxySendBuf.writeByte(byteValue);
               }
               else
               {
                  writeByte(byteValue);
               }
            }
         }
         catch(e:EOFError)
         {
         }
      }
      
      public function connectViaProxy() : void
      {
         proxyConnect = true;
         getVariables = new URLVariables();
         getDataRequest = new URLRequest("http://" + this.host + "/webrule.fcgi");
         this.getDataRequest.method = URLRequestMethod.POST;
         this.getDataRequest.data = this.getVariables;
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,this.startLoaderCompleteHandler);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.startLoaderSecurityErrorHandler);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.startLoaderIoErrorHandler);
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         loader.load(this.getDataRequest);
      }
      
      private function urlLoaderCompleteHandler(loader:NURLLoader) : void
      {
         sockData += loader.data.readMultiByte(loader.data.bytesAvailable,"x-cp1251");
         var messages:Array = this.sockData.split("#");
         var index:int = 0;
         while(index < messages.length - 1)
         {
            getData = messages[index].split("|");
            if(this.dataHandler == null || !this.dataHandler(this.getData))
            {
               this.handleData();
            }
            index++;
         }
         sockData = messages[messages.length - 1];
      }
      
      private function urlSendLoaderCompleteHandler(event:Event) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         sockData += loader.data.readMultiByte(loader.data.bytesAvailable,"x-cp1251");
         var messages:Array = this.sockData.split("#");
         var index:int = 0;
         while(index < messages.length - 1)
         {
            getData = messages[index].split("|");
            if(this.dataHandler == null || !this.dataHandler(this.getData))
            {
               this.handleData();
            }
            index++;
         }
         sockData = messages[messages.length - 1];
         loader.removeEventListener(Event.COMPLETE,this.urlSendLoaderCompleteHandler);
         loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.urlLoaderSecurityErrorHandler);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,this.urlLoaderIoErrorHandler);
      }
      
      private function startLoaderCompleteHandler(event:Event) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         proxyHashBytes = new ByteArray();
         var response:String = loader.data.readMultiByte(loader.data.bytesAvailable,"x-cp1251");
         var parts:Array = response.split(":");
         proxyId = parts[0];
         hash = parts[1];
         this.getVariables.sock = this.proxyId;
         this.getVariables.hash = this.hash;
         this.proxyHashBytes.writeUTFBytes("sock=" + this.proxyId + "&hash=" + this.hash + "&put=");
         getDataRequest = new URLRequest("http://" + this.host + "/webrule.fcgi");
         this.getDataRequest.method = URLRequestMethod.POST;
         this.getDataRequest.data = this.getVariables;
         NURLLoader.getDataRequest = this.getDataRequest;
         var index:int = 0;
         while(index < this.PROXY_LOADERS_COUNT)
         {
            this.urlLoaders[index] = new NURLLoader(this.urlLoaderCompleteHandler);
            index++;
         }
         this.connectHandler();
      }
      
      private function startLoaderIoErrorHandler(event:IOErrorEvent) : void
      {
         this.proxyConnectionErrorHandler();
      }
      
      private function startLoaderSecurityErrorHandler(event:SecurityErrorEvent) : void
      {
         this.proxySecurityErrorHandler();
      }
      
      private function urlLoaderIoErrorHandler(event:IOErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(this.getDataRequest);
      }
      
      private function urlLoaderSecurityErrorHandler(event:SecurityErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(this.getDataRequest);
      }
      
      private function urlLoaderSendIoErrorHandler(event:IOErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(this.getDataRequest);
      }
      
      private function urlLoaderSendSecurityErrorHandler(event:SecurityErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(this.getDataRequest);
      }
      
      public function objDataHandler(param1:String) : void
      {
      }
      
      protected function handleData() : Boolean
      {
         return false;
      }
   }
}

