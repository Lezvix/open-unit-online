package com.adobe.utils
{
   public class IntUtil
   {
      
      public function IntUtil()
      {
         super();
      }
      
      public static function getInt13(param1:int, param2:int) : int
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      public static function getUint2(param1:int, param2:int) : uint
      {
         var rotation:int = 32 - param2;
         return param1 << rotation | param1 >>> 32 - rotation;
      }
      
      private static var str39:String = "0123456789abcdef";

      public static function getString40(param1:int, param2:Boolean = false) : String
      {
         var hexString:String = "";
         if(param2)
         {
            for(var bigEndianIndex:int = 0; bigEndianIndex < 4; bigEndianIndex++)
            {
               hexString += str39.charAt(param1 >> (3 - bigEndianIndex) * 8 + 4 & 0x0F) + str39.charAt(param1 >> (3 - bigEndianIndex) * 8 & 0x0F);
            }
         }
         else
         {
            for(var littleEndianIndex:int = 0; littleEndianIndex < 4; littleEndianIndex++)
            {
               hexString += str39.charAt(param1 >> littleEndianIndex * 8 + 4 & 0x0F) + str39.charAt(param1 >> littleEndianIndex * 8 & 0x0F);
            }
         }
         return hexString;
      }
   }
}

