package core.system
{
   import social.ConnectorEvents;
   import flash.utils.clearInterval;
   
   public class StateSystem
   {
      
      public static var system:StateSystem;
      
      private var signals:Object = new Object();
      
      private var lastState:Object;
      
      private var uiComponentList1:Object;
      
      private var obj33:Object = new Object();
      
      private var actionSystemList1:Vector.<ActionSystem> = new Vector.<ActionSystem>();
      
      private var flag5:Boolean = false;
      
      private var array87:Array = new Array();
      
      private var obj36:Object = new Object();
      
      private var obj9:Object = new Object();
      
      private var intervalId:int = -1;
      
      public function StateSystem()
      {
         super();
         system = this;
      }
      
      public static function doAction46(param1:ActionSystem, param2:Class) : void
      {
         system.doAction46(param1,param2);
      }
      
      public static function getState(systemClass:Class) : Object
      {
         return system.getState(systemClass);
      }
      
      public static function getObject1(param1:String) : Object
      {
         return system.getObject1(param1);
      }
      
      public static function get state() : Object
      {
         return system.state;
      }
      
      public static function get items() : Object
      {
         return system.uiComponentList1;
      }
      
      public static function dispatch(id:String, ... rest) : void
      {
         system.dispatch.apply(null,[id].concat(rest));
      }
      
      public static function doAction174(sourceSignal:Signal, ... rest) : void
      {
         system.doAction174.apply(null,[sourceSignal].concat(rest));
      }
      
      public static function addListener(id:String, listener:Function) : void
      {
         system.addListener(id,listener);
      }
      
      public static function removeListener(id:String, listener:Function) : void
      {
         system.removeListener(id,listener);
      }
      
      public static function addSignalInterceptor(id:String, listener:Function) : void
      {
         system.addSignalInterceptor(id,listener);
      }
      
      public static function removeSignalInterceptor(id:String, listener:Function) : void
      {
         system.removeSignalInterceptor(id,listener);
      }
      
      protected function doAction946() : void
      {
         this.doAction137();
      }
      
      protected function doAction137(contexts:Array = null) : void
      {
         obj36 = new Object();
         obj9 = new Object();
         var nextSystems:Vector.<ActionSystem> = new Vector.<ActionSystem>();
         var index:int;
         var contextSystems:Vector.<ActionSystem>;
         var actionSystem:ActionSystem;
         nextSystems = nextSystems.concat(this.obj33[""]);
         if(contexts != null)
         {
            index = contexts.length - 1;
            while(index >= 0)
            {
               contextSystems = this.obj33[contexts[index]];
               if(contextSystems != null)
               {
                  for each(actionSystem in contextSystems)
                  {
                     if(nextSystems.indexOf(actionSystem) < 0)
                     {
                        nextSystems.push(actionSystem);
                     }
                  }
               }
               index--;
            }
         }
         index = this.actionSystemList1.length - 1;
         while(index >= 0)
         {
            if(nextSystems.indexOf(this.actionSystemList1[index]) < 0)
            {
               this.actionSystemList1[index].deactivate();
            }
            index--;
         }
         index = nextSystems.length - 1;
         while(index >= 0)
         {
            if(!nextSystems[index].activated)
            {
               nextSystems[index].activate();
            }
            index--;
         }
         actionSystemList1 = nextSystems;
         this.dispatch(NativeEvents.CONTEXT_INITED,contexts);
      }
      
      protected function doAction538(param1:int) : void
      {
         if(this.intervalId >= 0)
         {
            clearInterval(this.intervalId);
         }
         intervalId = TimerUtil.setInterval(this.process,param1);
      }
      
      private function process() : void
      {
         var actionSystem:ActionSystem = null;
         for each(actionSystem in this.actionSystemList1)
         {
            actionSystem.process();
         }
      }
      
      public function get state() : Object
      {
         return this.lastState;
      }
      
      public function get items() : Object
      {
         return this.uiComponentList1;
      }
      
      private function doAction311(actionSystem:ActionSystem, context:String) : void
      {
         var contextSystems:Vector.<ActionSystem> = null;
         if(this.obj33[context] == null)
         {
            contextSystems = new Vector.<ActionSystem>();
            contextSystems.push(actionSystem);
            this.obj33[context] = contextSystems;
         }
         else
         {
            this.obj33[context].push(actionSystem);
         }
      }
      
      protected function doAction610(systemClass:Class, callback:Function = null, contexts:Array = null) : void
      {
         var actionSystem:ActionSystem = new systemClass() as ActionSystem;
         var index:int;
         actionSystem.deactivate();
         if(contexts == null)
         {
            this.doAction311(actionSystem,"");
         }
         else
         {
            index = contexts.length - 1;
            while(index >= 0)
            {
               this.doAction311(actionSystem,contexts[index]);
               index--;
            }
         }
         actionSystem.init(this.lastState,this.uiComponentList1);
         actionSystem.doAction690();
         if(callback != null)
         {
            callback(actionSystem);
         }
      }
      
      protected function doAction380() : void
      {
         var unused:ActionSystem = null;
         while(this.actionSystemList1.length > 0)
         {
            ActionSystem(this.actionSystemList1.pop()).dispose();
         }
      }
      
      public function addListener(id:String, listener:Function) : void
      {
         var signal:Signal = this.signals[id];
         if(signal == null)
         {
            signal = new Signal(id);
            this.signals[id] = signal;
         }
         signal.addListener(listener);
      }
      
      public function removeListener(id:String, listener:Function) : void
      {
         var signal:Signal = this.signals[id];
         if(signal != null)
         {
            signal.removeListener(listener);
            if(signal.hasNoListeners)
            {
               delete this.signals[id];
            }
         }
      }
      
      public function addSignalInterceptor(id:String, listener:Function) : void
      {
         var signal:Signal = this.signals[id];
         if(signal == null)
         {
            signal = new Signal(id);
            this.signals[id] = signal;
         }
         signal.addSignalInterceptor(listener);
      }
      
      public function removeSignalInterceptor(id:String, listener:Function) : void
      {
         var signal:Signal = this.signals[id];
         if(signal != null)
         {
            signal.removeSignalInterceptor(listener);
            if(signal.hasNoListeners)
            {
               delete this.signals[id];
            }
         }
      }
      
      public function dispatch(id:String, ... rest) : void
      {
         var signal:Signal = this.signals[id];
         if(signal != null)
         {
            signal.dispatch.apply(null,rest);
         }
      }
      
      public function doAction174(sourceSignal:Signal, ... rest) : void
      {
         var signal:Signal = this.signals[sourceSignal.id];
         if(signal != null)
         {
            signal.doAction174.apply(null,[sourceSignal].concat(rest));
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
      
      public function overrideState(param1:Object, param2:Object) : void
      {
         uiComponentList1 = param2;
         lastState = param1;
         this.doAction946();
      }
      
      public function getArray11(itemType:String) : Array
      {
         var matchingItems:Array = [];
         var item:Object;
         for each(item in this.uiComponentList1)
         {
            if(item.type == itemType)
            {
               matchingItems.push(item);
            }
         }
         return matchingItems;
      }
      
      public function getObject1(param1:String) : Object
      {
         return this.uiComponentList1[param1];
      }
      
      public function doAction46(param1:ActionSystem, param2:Class) : void
      {
         this.obj36[param2] = param1;
      }
      
      public function getState(systemClass:Class) : Object
      {
         var actionSystem:ActionSystem = this.obj36[systemClass];
         if(actionSystem != null)
         {
            return actionSystem;
         }
         actionSystem = this.obj9[systemClass];
         if(actionSystem != null)
         {
            return actionSystem;
         }
         var index:int = this.actionSystemList1.length - 1;
         while(index >= 0)
         {
            if(this.actionSystemList1[index] is systemClass)
            {
               this.obj9[systemClass] = this.actionSystemList1[index];
               return this.actionSystemList1[index];
            }
            index--;
         }
         return null;
      }
   }
}

