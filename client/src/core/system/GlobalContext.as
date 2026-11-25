package core.system
{
   public class GlobalContext
   {
      
      protected static var _sharedInstance:GlobalContext = null;
      
      private var array61:Array;
      
      public function GlobalContext()
      {
         super();
         _sharedInstance = this;
      }
      
      public static function get sharedInstance() : GlobalContext
      {
         return _sharedInstance;
      }
      
      public function get propValue174() : Object
      {
         return null;
      }
   }
}

