package game.compositions
{
   import social.ConnectorEvents;
   import core.system.StateSystem;
   import core.system.Signal;
   
   public class CompositionLogic
   {
      
      protected var composition:GameComposition;
      
      public function CompositionLogic()
      {
         super();
      }
      
      public function initBase(param1:GameComposition) : void
      {
         this.composition = param1;
      }
      
      public function set state(param1:int) : void
      {
         this.composition.state = param1;
      }
      
      public function get state() : int
      {
         return this.composition.state;
      }
      
      public function process() : void
      {
      }
      
      public function onGameEvent(param1:Object) : void
      {
      }
      
      public function set gameState(param1:Object) : void
      {
      }
      
      public function allAnimationOverHandler() : void
      {
      }
      
      public function get maxStateCount() : int
      {
         return this.composition.maxStateCount;
      }
      
      public function get maxAnimCount() : int
      {
         return this.composition.maxAnimCount;
      }
      
      public function get blocked() : Boolean
      {
         return this.composition.blocked;
      }
      
      public function set blocked(param1:Boolean) : void
      {
         this.composition.blocked = param1;
      }
      
      protected function doAction949(param1:Object, param2:Function = null) : void
      {
         StateSystem.dispatch(ConnectorEvents.CONNECTOR_SEND_EVENT,param1,param2);
      }
      
      protected function get item() : Object
      {
         return this.composition.item;
      }
      
      public function addListener(param1:String, param2:Function) : void
      {
         this.composition.addListener(param1,param2);
      }
      
      public function removeListener(param1:String, param2:Function) : void
      {
         this.composition.removeListener(param1,param2);
      }
      
      public function dispatch(param1:String, ... rest) : void
      {
         this.composition.dispatch.apply(null,[param1].concat(rest));
      }
      
      public function doAction174(param1:Signal, ... rest) : void
      {
         this.composition.doAction174.apply(null,[param1].concat(rest));
      }
      
      public function getState(param1:Class) : Object
      {
         return this.composition.getState(param1);
      }
      
      public function doAction356() : void
      {
      }
      
      public function doAction527() : void
      {
      }
   }
}

