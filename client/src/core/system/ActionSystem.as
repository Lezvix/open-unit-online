package core.system
{
   import social.ISocialApi;
   import social.SocialApi;
   import social.ConnectorEvents;
   import game.world.IProcessable;
   
   public class ActionSystem
   {
      
      private var classList1:Vector.<Class> = new Vector.<Class>();
      
      private var inactiveSignalListeners:Array;
      
      private var inactiveSignalInterceptors:Array;
      
      private var _actionSystemActivated:Boolean = true;
      
      private var activeSignalListeners:Array = new Array();
      
      private var activeSignalInterceptors:Array = new Array();
      
      private var actionSignals:Object = new Object();
      
      public function ActionSystem()
      {
         super();
      }
      
      public function init(param1:Object, param2:Object) : void
      {
      }
      
      public function doAction690() : void
      {
      }
      
      protected function doAction46(param1:Class) : void
      {
         this.classList1.push(param1);
         if(this._actionSystemActivated)
         {
            StateSystem.system.doAction46(this,param1);
         }
      }
      
      private function doAction198() : void
      {
         var index:int = this.classList1.length - 1;
         while(index >= 0)
         {
            StateSystem.system.doAction46(this,this.classList1[index]);
            index--;
         }
      }
      
      protected function get api() : ISocialApi
      {
         return SocialApi.api;
      }
      
      public function get activated() : Boolean
      {
         return this._actionSystemActivated;
      }
      
      protected function doAction949(param1:Object, param2:Function = null) : void
      {
         this.dispatch(ConnectorEvents.CONNECTOR_SEND_EVENT,param1,param2);
      }
      
      protected function doAction616(type:String, action:String, target:IProcessable, instrument:Object = null, includePosition:Boolean = false, user:String = null) : void
      {
         var request:Object = {
            "type":type,
            "action":action,
            "objId":target.id
         };
         if(includePosition)
         {
            request.x = target.propValue154;
            request.y = target.propValue97;
         }
         if(instrument)
         {
            request.instrument = instrument.id;
         }
         if(user)
         {
            request.user = user;
         }
         this.doAction949(request);
      }
      
      protected function doAction770() : void
      {
         this.api.sendPing();
      }
      
      protected function get propValue92() : StateSystem
      {
         return StateSystem.system;
      }
      
      protected function getState(param1:Class) : Object
      {
         return StateSystem.system.getState(param1);
      }
      
      protected function dispatch(param1:String, ... rest) : void
      {
         StateSystem.dispatch.apply(null,[param1].concat(rest));
      }
      
      protected function doAction174(param1:Signal, ... rest) : void
      {
         StateSystem.doAction174.apply(null,[param1].concat(rest));
      }
      
      protected function addListener(param1:String, param2:Function) : void
      {
         if(this._actionSystemActivated)
         {
            this.activeSignalListeners.push({
               "id":param1,
               "handler":param2
            });
            StateSystem.system.addListener(param1,param2);
         }
         else
         {
            this.inactiveSignalListeners.push({
               "id":param1,
               "handler":param2
            });
         }
      }
      
      protected function removeListener(id:String, handler:Function) : void
      {
         var index:int = 0;
         if(this.activated)
         {
            index = this.activeSignalListeners.length - 1;
            while(index >= 0)
            {
               if(this.activeSignalListeners[index].id == id && this.activeSignalListeners[index].handler == handler)
               {
                  this.activeSignalListeners.splice(index,1);
               }
               index--;
            }
            StateSystem.system.removeListener(id,handler);
         }
         else
         {
            index = this.inactiveSignalListeners.length - 1;
            while(index >= 0)
            {
               if(this.inactiveSignalListeners[index].id == id && this.inactiveSignalListeners[index].handler == handler)
               {
                  this.inactiveSignalListeners.splice(index,1);
               }
               index--;
            }
         }
      }
      
      protected function addSignalInterceptor(param1:String, param2:Function) : void
      {
         if(this._actionSystemActivated)
         {
            this.activeSignalInterceptors.push({
               "id":param1,
               "handler":param2
            });
            StateSystem.system.addSignalInterceptor(param1,param2);
         }
         else
         {
            this.inactiveSignalInterceptors.push({
               "id":param1,
               "handler":param2
            });
         }
      }
      
      protected function removeSignalInterceptor(id:String, handler:Function) : void
      {
         var index:int = 0;
         if(this._actionSystemActivated)
         {
            index = this.activeSignalInterceptors.length - 1;
            while(index >= 0)
            {
               if(this.activeSignalInterceptors[index].id == id && this.activeSignalInterceptors[index].handler == handler)
               {
                  this.activeSignalInterceptors.splice(index,1);
               }
               index--;
            }
            StateSystem.system.removeSignalInterceptor(id,handler);
         }
         else
         {
            index = this.inactiveSignalInterceptors.length - 1;
            while(index >= 0)
            {
               if(this.inactiveSignalInterceptors[index].id == id && this.inactiveSignalInterceptors[index].handler == handler)
               {
                  this.inactiveSignalInterceptors.splice(index,1);
               }
               index--;
            }
         }
      }
      
      protected function doAction341(param1:String, param2:Function) : void
      {
         if(param1 == null)
         {
            this.addListener(ConnectorEvents.CONNECTOR_RECIVE_EVENT,param2);
         }
         else
         {
            this.addListener(ConnectorEvents.CONNECTOR_RECIVE_EVENT + param1,param2);
         }
      }
      
      public function process() : void
      {
      }
      
      public function dispose() : void
      {
         var subscription:Object = null;
         while(this.activeSignalListeners.length > 0)
         {
            subscription = this.activeSignalListeners.pop();
            StateSystem.system.removeListener(subscription.id,subscription.handler);
         }
         while(this.activeSignalInterceptors.length > 0)
         {
            subscription = this.activeSignalInterceptors.pop();
            StateSystem.system.removeListener(subscription.id,subscription.handler);
         }
         inactiveSignalListeners = new Array();
         inactiveSignalInterceptors = new Array();
      }
      
      public function activate() : void
      {
         var index:int = 0;
         _actionSystemActivated = true;
         index = this.inactiveSignalListeners.length - 1;
         while(index >= 0)
         {
            StateSystem.system.addListener(this.inactiveSignalListeners[index].id,this.inactiveSignalListeners[index].handler);
            index--;
         }
         index = this.inactiveSignalInterceptors.length - 1;
         while(index >= 0)
         {
            StateSystem.system.addSignalInterceptor(this.inactiveSignalInterceptors[index].id,this.inactiveSignalInterceptors[index].handler);
            index--;
         }
         activeSignalListeners = this.inactiveSignalListeners;
         activeSignalInterceptors = this.inactiveSignalInterceptors;
         inactiveSignalListeners = new Array();
         inactiveSignalInterceptors = new Array();
         this.doAction198();
      }
      
      public function deactivate() : void
      {
         var index:int = 0;
         _actionSystemActivated = false;
         index = this.activeSignalListeners.length - 1;
         while(index >= 0)
         {
            StateSystem.system.removeListener(this.activeSignalListeners[index].id,this.activeSignalListeners[index].handler);
            index--;
         }
         index = this.activeSignalInterceptors.length - 1;
         while(index >= 0)
         {
            StateSystem.system.removeSignalInterceptor(this.activeSignalInterceptors[index].id,this.activeSignalInterceptors[index].handler);
            index--;
         }
         inactiveSignalListeners = this.activeSignalListeners;
         inactiveSignalInterceptors = this.activeSignalInterceptors;
         activeSignalListeners = new Array();
         activeSignalInterceptors = new Array();
      }
      
      public function doAction149(id:String, listener:Function) : void
      {
         var signal:Signal = this.actionSignals[id];
         if(signal == null)
         {
            signal = new Signal(id);
            this.actionSignals[id] = signal;
         }
         signal.addListener(listener);
      }
      
      public function doAction911(id:String, listener:Function) : void
      {
         var signal:Signal = this.actionSignals[id];
         if(signal != null)
         {
            signal.removeListener(listener);
            if(signal.hasNoListeners)
            {
               delete this.actionSignals[id];
            }
         }
      }
      
      protected function doAction360(id:String, ... rest) : void
      {
         var signal:Signal = null;
         if(this.actionSignals != null)
         {
            signal = this.actionSignals[id];
            if(signal != null)
            {
               signal.dispatch.apply(null,rest);
            }
         }
      }
      
      protected function doAction905(sourceSignal:Signal, ... rest) : void
      {
         var signal:Signal = null;
         if(this.actionSignals != null)
         {
            signal = this.actionSignals[sourceSignal.id];
            if(signal != null)
            {
               signal.doAction174.apply(null,[sourceSignal].concat(rest));
            }
         }
      }
   }
}

