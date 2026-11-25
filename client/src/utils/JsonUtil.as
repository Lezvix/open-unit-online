package utils
{
   public class JsonUtil
   {
      
      public function JsonUtil()
      {
         super();
      }
      
      public static function getString20(param1:Object) : String
      {
         return JSON.stringify(param1);
      }
      
      public static function doAction546(param1:String) : *
      {
         return JSON.parse(param1);
      }
   }
}

