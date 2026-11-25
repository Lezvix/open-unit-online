package net
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class NURLLoader extends URLLoader
   {
      
      private static var PROXY_SEND_DELAY:int = 50;
      
      public static var getDataRequest:URLRequest;

      private var pingInterval:uint;
      
      private var intervalStarted:Boolean = false;
      
      public var dataHandler:Function;
      
      public function NURLLoader(dataHandler:Function)
      {
         super();
         this.dataHandler = dataHandler;
         dataFormat = URLLoaderDataFormat.BINARY;
         addEventListener(Event.COMPLETE,this.urlLoaderCompleteHandler);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.urlLoaderSecurityErrorHandler);
         addEventListener(IOErrorEvent.IO_ERROR,this.urlLoaderIoErrorHandler);
         this.pingInterval = setInterval(this.proxyPing,PROXY_SEND_DELAY);
         this.intervalStarted = true;
      }
      
      public function dispose() : void
      {
         if(this.intervalStarted)
         {
            clearInterval(this.pingInterval);
         }
         removeEventListener(Event.COMPLETE,this.urlLoaderCompleteHandler);
         removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.urlLoaderSecurityErrorHandler);
         removeEventListener(IOErrorEvent.IO_ERROR,this.urlLoaderIoErrorHandler);
      }
      
      private function proxyPing() : void
      {
         clearInterval(this.pingInterval);
         intervalStarted = false;
         load(getDataRequest);
      }
      
      private function urlLoaderCompleteHandler(event:Event) : void
      {
         pingInterval = setInterval(this.proxyPing,PROXY_SEND_DELAY);
         this.dataHandler(this);
      }
      
      private function urlLoaderSecurityErrorHandler(event:SecurityErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(getDataRequest);
         intervalStarted = true;
      }
      
      private function urlLoaderIoErrorHandler(event:IOErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         loader.load(getDataRequest);
      }
   }
}

