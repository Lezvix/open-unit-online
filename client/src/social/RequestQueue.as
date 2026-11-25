package social
{
   import utils.JsonUtil;
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import ru.inspirit.net.MultipartURLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.getTimer;
   
   public class RequestQueue
   {
      
      private var onFatalError:Function;
      
      private var retryCount:int;
      
      private var retryNo:int;
      
      private var requests:Array = new Array();
      
      public var requestRateLimit:int = 0;
      
      public var requestRateWindowMs:int = 1000;
      
      public var retryPeriod:int = 1000;
      
      private var requestStartTimes:Array = new Array();
      
      private var intValue65:int = 0;
      
      private var requestTimerPending:Boolean;
      
      private var timerUtil2:TimerUtil;
      
      public var api:ISocialApi;
      
      private var _deferredQueue:Array;
      
      public function RequestQueue(param1:int, param2:Function)
      {
         super();
         this.onFatalError = param2;
         this.retryCount = param1;
         this.retryNo = 0;
         this.requestTimerPending = false;
         this.timerUtil2 = new TimerUtil(1);
         this.timerUtil2.handler = this.onHandler;
         this._deferredQueue = new Array();
      }
      
      public function request(param1:Object, param2:Object, param3:Object, param4:Function = null, param5:Function = null, param6:Function = null, param7:Boolean = false) : void
      {
         var method:String = param2 == null ? "GET" : "POST";
         this.requests.push({
            "method":method,
            "url":param1,
            "sendData":param2,
            "evtData":param3,
            "onComplete":param4,
            "onError":param5,
            "globalOnError":param6,
            "binaryData":param7
         });
         this.makeRequest();
      }
      
      public function doAction772(param1:Object, param2:Array, param3:Boolean, param4:Object, param5:Function = null, param6:Function = null) : void
      {
         this.requests.push({
            "method":"UPLOAD",
            "url":param1,
            "files":param2,
            "useDescription":param3,
            "evtData":param4,
            "onComplete":param5,
            "onError":param6
         });
         this.makeRequest();
      }
      
      public function get isValue68() : Boolean
      {
         return this.requests.length > 0;
      }
      
      public function get isPaused() : Boolean
      {
         return this.intValue65 != 0;
      }
      
      public function pause() : void
      {
         ++this.intValue65;
      }
      
      public function doAction57() : void
      {
         --this.intValue65;
         if(this.intValue65 < 0)
         {
            throw new Error("Значение _paused не может быть меньше 0");
         }
         if(!this.isPaused)
         {
            this.doAction625();
            this.makeRequest();
         }
      }
      
      public function doAction625() : void
      {
         while(this._deferredQueue.length > 0)
         {
            this._deferredQueue[0].handler(this._deferredQueue[0].event);
            this._deferredQueue.splice(0,1);
         }
      }
      
      private function schedule(param1:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         this.timerUtil2.delay = param1;
         this.timerUtil2.start();
         requestTimerPending = true;
      }
      
      private function onHandler(param1:TimerEvent) : void
      {
         this.timerUtil2.stop();
         requestTimerPending = false;
         this.makeRequest();
      }
      
      private function makeRequest() : void
      {
         var removeListeners:Function = function():void
         {
            EventListeners.removeEventListener(loader,Event.COMPLETE,receivedData);
            EventListeners.removeEventListener(loader,IOErrorEvent.IO_ERROR,ioError);
         };
         var finishWithErr:Function = function(param1:String):void
         {
            if(param1 == null || param1.indexOf("ignore:") == 0)
            {
               retryNo = 0;
               makeRequest();
            }
            else
            {
               retryNo += 1;
               if(retryNo < retryCount && param1.indexOf("retry:") == 0)
               {
                  requests.unshift(req);
                  schedule(retryPeriod);
               }
               else
               {
                  onFatalError(param1 + " " + JsonUtil.getString20(req));
               }
            }
         };
         var receivedDataHandler:Function;
         receivedDataHandler = function(e:Event):void
         {
            var err:String = null;
            try
            {
               if(req.method == "UPLOAD")
               {
                  err = req.onComplete(req.evtData);
               }
               else
               {
                  err = req.onComplete(e.target.data,req.evtData);
               }
            }
            catch(e:Error)
            {
               if(api != null)
               {
                  api.reportError(null,e);
               }
               onFatalError(e.getStackTrace());
               return;
            }
            if(err != null && req.onError != null)
            {
               err = req.onError(req.evtData);
            }
            finishWithErr(err);
         };
         var receivedData:Function;
         receivedData = function(param1:Event):void
         {
            removeListeners();
            if(isPaused)
            {
               _deferredQueue.push({
                  "event":param1,
                  "handler":receivedDataHandler
               });
            }
            else
            {
               receivedDataHandler(param1);
            }
         };
         var ioError:Function;
         ioError = function(e:IOErrorEvent):void
         {
            removeListeners();
            var err:String = null;
            if(req.globalOnError != null)
            {
               err = req.globalOnError(req.evtData);
            }
            else
            {
               err = "retry:" + e.toString();
               try
               {
                  if(req.onError != null)
                  {
                     err = req.onError(req.evtData);
                  }
               }
               catch(e:Error)
               {
                  if(api != null)
                  {
                     api.reportError(null,e);
                  }
                  onFatalError(e.getStackTrace());
                  return;
               }
            }
            finishWithErr(err);
         };
         var req:Object;
         var loader:Object;
         if(this.requestTimerPending || this.requests.length == 0)
         {
            return;
         }
         if(this.requestRateLimit > 0)
         {
            var expTime:int = getTimer() - this.requestRateWindowMs;
            while(this.requestStartTimes.length > 0 && this.requestStartTimes[0] < expTime)
            {
               this.requestStartTimes.shift();
            }
            if(this.requestStartTimes.length < this.requestRateLimit)
            {
               this.requestStartTimes.push(getTimer());
            }
            else
            {
               var delay:int = this.requestStartTimes[0] + this.requestRateWindowMs - getTimer();
               this.schedule(delay);
               return;
            }
         }
         req = this.requests.shift();
         if(req.method == "UPLOAD")
         {
            loader = new MultipartURLLoader();
            EventListeners.addEventListener(loader,Event.COMPLETE,receivedData);
            EventListeners.addEventListener(loader,IOErrorEvent.IO_ERROR,ioError);
            var files:Array = req.files;
            var i:int = 0;
            while(i < files.length)
            {
               if(req.useDescription)
               {
                  var j:int = 0;
                  while(j < files[i].variables.length)
                  {
                     loader.addVariable(files[i].variables[j].name,files[i].variables[j].value);
                     j++;
                  }
               }
               loader.addFile(files[i].data,files[i].fileName,files[i].dataField);
               i++;
            }
            loader.load(req.url.toString());
         }
         else
         {
            loader = new URLLoader();
            EventListeners.addEventListener(loader,Event.COMPLETE,receivedData);
            EventListeners.addEventListener(loader,IOErrorEvent.IO_ERROR,ioError);
            if(req.binaryData)
            {
               loader.dataFormat = URLLoaderDataFormat.BINARY;
            }
            var request:URLRequest = new URLRequest(req.url.toString());
            if(req.sendData)
            {
               request.method = "POST";
               var vars:URLVariables = new URLVariables();
               var key:String;
               for(key in req.sendData)
               {
                  vars[key] = req.sendData[key];
               }
               request.data = vars;
            }
            else
            {
               request.method = "GET";
            }
            loader.load(request);
         }
      }
   }
}

