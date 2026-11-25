package game.compositions
{
   import core.system.Signal;
   import game.actions.ObjectActions;
   import game.interfaces.IGameState;
   import game.interfaces.IStateful;
   import game.world.ObjectGroup;
   import game.world.Composition;
   import game.world.IComposition;
   import game.world.WorldEntity;
   import game.world.ObjectFactory;
   import game.world.WorldBase;
   
   public class GameComposition extends Composition implements IComposition, IStateful
   {
      
      private var _item:Object;
      
      public var flag21:Boolean = true;
      
      private var _gameCompositionSource:Object = new Object();
      
      private var iGameState1:IGameState = null;
      
      private var actionSystemList1:Array = new Array();
      
      private var obj36:Object = new Object();
      
      private var obj9:Object = new Object();
      
      private var signals:Object = new Object();
      
      private var obj31:Object;
      
      public function GameComposition()
      {
         super();
      }
      
      override public function initComposition(param1:WorldBase, param2:ObjectGroup, param3:ObjectFactory, param4:String, param5:String, param6:Object = null) : void
      {
         super.initComposition(param1,param2,param3,param4,param5,param6);
         item = param6;
         this.addListener(ObjectActions.FARM_UPDATE_COMPOSITION_GAMESTATE,this.doAction348);
      }
      
      private function doAction348(param1:Signal) : void
      {
         this.obj31.id = id;
         this.obj31.x = _compositionI;
         this.obj31.y = _compositionJ;
         this.obj31.item = this.item;
      }
      
      private function check56(logic:Object) : Boolean
      {
         try
         {
            logic.init;
         }
         catch(e:*)
         {
            return false;
         }
         return true;
      }
      
      protected function doAction610(param1:Class, ... rest) : CompositionLogic
      {
         var logic:Object = new param1();
         logic.initBase(this);
         if(this.check56(logic))
         {
            logic.init.apply(rest);
         }
         this.actionSystemList1.push(logic);
         return logic as CompositionLogic;
      }
      
      public function get item() : Object
      {
         return this._item;
      }
      
      public function set item(param1:Object) : void
      {
         _item = param1;
      }
      
      public function get isValue44() : Boolean
      {
         return this.isValue50 && this._item != null && this._item.sellCoins != null && this.isValue51;
      }
      
      public function get isValue5() : Boolean
      {
         return this.isValue50 && this._item != null && this._item.sellCoins != null && this.isValue51;
      }
      
      public function get isValue50() : Boolean
      {
         return this.flag21 && !processing && !blocked && this.isValue51;
      }
      
      public function get isValue51() : Boolean
      {
         return true;
      }
      
      override public function onGameEvent(param1:Object) : void
      {
         var logic:CompositionLogic = null;
         for each(logic in this.actionSystemList1)
         {
            logic.onGameEvent(param1);
         }
      }
      
      override public function set gameState(param1:Object) : void
      {
         var logic:CompositionLogic = null;
         obj31 = param1;
         for each(logic in this.actionSystemList1)
         {
            logic.gameState = this.obj31;
         }
      }
      
      public function get gameState() : Object
      {
         this.dispatch(ObjectActions.FARM_UPDATE_COMPOSITION_GAMESTATE);
         return this.obj31;
      }
      
      override public function allAnimationOverHandler() : void
      {
         var logic:CompositionLogic = null;
         for each(logic in this.actionSystemList1)
         {
            logic.allAnimationOverHandler();
         }
      }
      
      override public function process() : void
      {
         var logic:CompositionLogic = null;
         for each(logic in this.actionSystemList1)
         {
            logic.process();
         }
      }
      
      public function get propValue91() : int
      {
         return i;
      }
      
      public function get propValue40() : int
      {
         return j;
      }
      
      public function addListener(param1:String, param2:Function) : void
      {
         var signal:Signal = this.signals[param1];
         if(signal == null)
         {
            signal = new Signal(param1);
            this.signals[param1] = signal;
         }
         signal.addListener(param2);
      }
      
      public function removeListener(param1:String, param2:Function) : void
      {
         var signal:Signal = this.signals[param1];
         if(signal != null)
         {
            signal.removeListener(param2);
            if(signal.hasNoListeners)
            {
               delete this.signals[param1];
            }
         }
      }
      
      public function dispatch(param1:String, ... rest) : void
      {
         var signal:Signal = this.signals[param1];
         if(signal != null)
         {
            signal.dispatch.apply(null,rest);
         }
      }
      
      public function doAction174(param1:Signal, ... rest) : void
      {
         var signal:Signal = this.signals[param1.id];
         if(signal != null)
         {
            signal.doAction174.apply(null,[param1].concat(rest));
         }
      }
      
      public function get propValue175() : Array
      {
         return this.actionSystemList1;
      }
      
      public function get source() : Object
      {
         return this._gameCompositionSource;
      }
      
      public function set source(param1:Object) : void
      {
         _gameCompositionSource = param1;
      }
      
      public function doAction46(param1:CompositionLogic, param2:Class) : void
      {
         this.obj36[param2] = param1;
      }
      
      public function getState(param1:Class) : Object
      {
         var logic:CompositionLogic = this.obj36[param1];
         if(logic != null)
         {
            return logic;
         }
         logic = this.obj9[param1];
         if(logic != null)
         {
            return logic;
         }
         var index:int = this.actionSystemList1.length - 1;
         while(index >= 0)
         {
            if(this.actionSystemList1[index] is param1)
            {
               this.obj9[param1] = this.actionSystemList1[index];
               return this.actionSystemList1[index];
            }
            index--;
         }
         return null;
      }
      
      override protected function mouseOverHandler() : void
      {
         var logic:CompositionLogic = null;
         super.mouseOverHandler();
         for each(logic in this.actionSystemList1)
         {
            logic.doAction356();
         }
      }
      
      override protected function mouseOutHandler() : void
      {
         var logic:CompositionLogic = null;
         super.mouseOutHandler();
         for each(logic in this.actionSystemList1)
         {
            logic.doAction527();
         }
      }
      
      public function set propValue187(param1:IGameState) : void
      {
         iGameState1 = param1;
      }
      
      public function get propValue187() : IGameState
      {
         return this.iGameState1;
      }
      
      override public function passebleForPlayer(param1:WorldEntity) : Boolean
      {
         return this.iGameState1 != null || super.passebleForPlayer(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         iGameState1 = null;
      }
   }
}

