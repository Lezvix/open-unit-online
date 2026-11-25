package game.world
{
   public interface IEventSource extends IProcessable
   {
      
      function get item() : Object;
      
      function set item(param1:Object) : void;
      
      function get source() : Object;
      
      function set source(param1:Object) : void;
      
      function dispatch(param1:String, ... rest) : void;
   }
}

