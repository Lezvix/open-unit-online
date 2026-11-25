package events
{
   import flash.utils.Dictionary;
   
   public class UnitEventDispatcher
   {
      
      public static const instance:UnitEventDispatcher = new UnitEventDispatcher();
      
      protected var _event_listeners:Dictionary = new Dictionary();
      
      public function UnitEventDispatcher()
      {
         super();
      }
      
      public function addListener(type:EventType, listener:Function) : void
      {
         if(type == null || listener == null)
         {
            return;
         }
         if(this._event_listeners[type] == undefined)
         {
            this._event_listeners[type] = new Vector.<Function>();
         }
         this._event_listeners[type].push(listener);
      }
      
      public function removeListener(type:EventType, listener:Function) : void
      {
         if(type == null || listener == null || this._event_listeners[type] == undefined)
         {
            return;
         }
         var index:int = this._event_listeners[type].indexOf(listener);
         if(index != -1)
         {
            this._event_listeners[type].splice(index,1);
         }
      }
      
      public function dispatch(type:EventType, args:Object = null) : void
      {
         var listeners:Vector.<Function> = this._event_listeners[type];
         if(listeners == null || listeners.length == 0)
         {
            return;
         }
         for each(var listener:Function in listeners)
         {
            listener(args);
         }
      }
   }
}

