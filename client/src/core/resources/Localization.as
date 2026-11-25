package core.resources
{
   import flash.utils.ByteArray;
   
   public class Localization
   {
      
      public static var localization1:Localization = new Localization();
      
      private var translationsByKey:Object = new Object();
      
      public function Localization()
      {
         super();
      }
      
      public static function getString(key:String) : String
      {
         return localization1.getString37(key);
      }
      
      public static function getFormattedString(key:String, ... rest) : String
      {
         var result:String = getString(key);
         if(result == null)
         {
            return "";
         }
         var argumentCount:uint = rest.length;
         if(argumentCount == 1 && rest[0] is Array)
         {
            argumentsList = rest[0] as Array;
            argumentCount = argumentsList.length;
         }
         else
         {
            argumentsList = rest;
         }
         var argumentsList:Array;
         var index:int = 0;
         while(index < argumentCount)
         {
            result = result.split("{" + index + "}").join(argumentsList[index]);
            index++;
         }
         return result;
      }
      
      public function parseData(bytes:ByteArray) : void
      {
         var key:String = null;
         var value:String = null;
         bytes.uncompress();
         while(bytes.bytesAvailable > 0)
         {
            key = bytes.readUTF();
            value = bytes.readUTF();
            this.translationsByKey[key] = value;
         }
      }
      
      public function getString37(key:String) : String
      {
         return this.translationsByKey[key] ? this.translationsByKey[key] as String : "";
      }
   }
}

