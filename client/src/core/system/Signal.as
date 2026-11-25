package core.system
{
   public class Signal
   {
      
      private var _id:String;
      
      private var listeners:Vector.<Function>;
      
      private var signalInterceptors:Vector.<Function>;
      
      private var _signalParams:Object;
      
      private var signalListenerIndex:int = -1;
      
      public function Signal(signalId:String, signalParams:Object = null)
      {
         super();
         this._id = signalId;
         this.listeners = new Vector.<Function>();
         this.signalInterceptors = new Vector.<Function>();
         this._signalParams = signalParams;
      }
      
      public function get params() : Object
      {
         return this._signalParams;
      }
      
      public function get hasNoListeners() : Boolean
      {
         return this.listeners.length == 0 && this.signalInterceptors.length == 0;
      }
      
      public function addListener(listener:Function) : void
      {
         if(this.listeners.indexOf(listener) < 0)
         {
            this.listeners.push(listener);
         }
      }
      
      public function removeListener(listener:Function) : void
      {
         var index:int = this.listeners.indexOf(listener);
         if(index >= 0)
         {
            if(index <= this.signalListenerIndex)
            {
               --this.signalListenerIndex;
            }
            this.listeners.splice(index,1);
         }
      }
      
      public function addSignalInterceptor(interceptor:Function) : void
      {
         if(this.signalInterceptors.indexOf(interceptor) < 0)
         {
            this.signalInterceptors.push(interceptor);
         }
      }
      
      public function removeSignalInterceptor(listener:Function) : void
      {
         var index:int = this.signalInterceptors.indexOf(listener);
         if(index >= 0)
         {
            if(index <= this.signalListenerIndex)
            {
               --this.signalListenerIndex;
            }
            this.signalInterceptors.splice(index,1);
         }
      }
      
      public function doAction174(param1:Signal, ... rest) : void
      {
         rest.splice(0,0,param1);
         signalListenerIndex = 0;
         while(this.signalListenerIndex < this.signalInterceptors.length)
         {
            if(this.signalInterceptors[this.signalListenerIndex].apply(null,rest))
            {
               return;
            }
            ++this.signalListenerIndex;
         }
         signalListenerIndex = 0;
         while(this.signalListenerIndex < this.listeners.length)
         {
            this.listeners[this.signalListenerIndex].apply(null,rest);
            ++this.signalListenerIndex;
         }
      }
      
      public function dispatch(... rest) : void
      {
         rest.splice(0,0,this);
         signalListenerIndex = 0;
         while(this.signalListenerIndex < this.signalInterceptors.length)
         {
            if(this.signalInterceptors[this.signalListenerIndex].apply(null,rest))
            {
               return;
            }
            ++this.signalListenerIndex;
         }
         signalListenerIndex = 0;
         while(this.signalListenerIndex < this.listeners.length)
         {
            this.listeners[this.signalListenerIndex].apply(null,rest);
            ++this.signalListenerIndex;
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(signalId:String) : void
      {
         _id = signalId;
      }
   }
}

