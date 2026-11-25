package core.system
{
   import social.ISocialApi;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class EventListeners
   {
      
      public static var api:ISocialApi = null;
      
      public static var listeners:Dictionary = new Dictionary();
      
      public function EventListeners()
      {
         super();
      }
      
      public static function addEventListener(target:Object, type:String, listener:Function) : void
      {
         var handler:Function;
         var targetAr:Array;
         handler = function(event:Event):void
         {
            try
            {
               listener(event);
            }
            catch(e:Error)
            {
               if(api != null)
               {
                  api.reportError(null,e);
               }
            }
         };
         if(listeners[target])
         {
            targetAr = listeners[target] as Array;
         }
         else
         {
            targetAr = new Array();
            listeners[target] = targetAr;
         }
         targetAr.push({
            "type":type,
            "listener":listener,
            "handler":handler
         });
         target.addEventListener(type,handler);
      }
      
      public static function removeEventListener(target:Object, type:String, listener:Function) : void
      {
         var targetListeners:Array = null;
         var index:int = 0;
         if(listeners[target])
         {
            targetListeners = listeners[target] as Array;
            index = 0;
            while(index < targetListeners.length)
            {
               if(targetListeners[index].type == type && targetListeners[index].listener == listener)
               {
                  target.removeEventListener(type,targetListeners[index].handler);
                  targetListeners.splice(index,1);
               }
               else
               {
                  index++;
               }
            }
            if(targetListeners.length == 0)
            {
               delete listeners[target];
            }
         }
      }
   }
}

