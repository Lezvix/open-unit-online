package net
{
   public final class GameEventDispatcher
   {
      
      private static const listeners:Object = new Object();
      
      public function GameEventDispatcher()
      {
         super();
      }
      
      public static function addCommandHandler(command:String, handler:Function) : void
      {
         var handlers:Vector.<Function> = listeners[command];
         if(handlers == null)
         {
            listeners[command] = handlers = new Vector.<Function>();
         }
         handlers.push(handler);
      }
      
      public static function removeCommandHandler(command:String, handler:Function) : void
      {
         var handlers:Vector.<Function> = listeners[command];
         if(handlers == null)
         {
            return;
         }
         var index:int = handlers.indexOf(handler);
         if(index != -1)
         {
            handlers.splice(index,1);
         }
      }
      
      public static function dispatch(fields:Array) : void
      {
         if(fields == null || fields.length == 0)
         {
            return;
         }
         var handlers:Vector.<Function> = listeners[fields[0]];
         var handler:Function;
         if(handlers != null)
         {
            for each(handler in handlers)
            {
               handler(fields);
            }
         }
      }
   }
}

