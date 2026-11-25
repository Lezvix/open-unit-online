package game.world
{
   import core.system.EventListeners;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   
   public class AvatarLoader extends Loader
   {
      
      private static var intValue33:int = 3;
      
      public var url:String;
      
      public var completeHandler:Function;
      
      public var loaded:Boolean = false;
      
      public var bitmapData:BitmapData;
      
      private var request:URLRequest;
      
      private var intValue113:int = 0;
      
      private var callback15:Function;
      
      private var _globalCompleteHandler:Function;
      
      public function AvatarLoader(param1:String, param2:Function, param3:Function)
      {
         super();
         this.url = param1;
         this.completeHandler = param2;
         this.callback15 = param3;
         EventListeners.addEventListener(contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.addEventListener(contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction803);
         this.request = new URLRequest(param1);
         load(this.request);
      }
      
      public function get globalCompleteHandler() : Function
      {
         return this._globalCompleteHandler;
      }
      
      public function set globalCompleteHandler(param1:Function) : void
      {
         _globalCompleteHandler = param1;
      }
      
      private function doAction803(param1:IOErrorEvent) : void
      {
         if(this.intValue113 < intValue33)
         {
            ++this.intValue113;
            request = new URLRequest(this.url + int(Math.random() * 1000000).toString());
            load(this.request);
         }
         else
         {
            loaded = false;
            EventListeners.removeEventListener(contentLoaderInfo,Event.COMPLETE,this.doAction843);
            EventListeners.removeEventListener(contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction803);
            this.callback15(this);
         }
      }
      
      private function doAction843(param1:Event) : void
      {
         bitmapData = new content["BITMAP"]().bitmapData;
         loaded = true;
         EventListeners.removeEventListener(contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.removeEventListener(contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction803);
         this.completeHandler(this);
      }
   }
}

