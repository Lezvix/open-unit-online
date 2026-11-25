package com.adobe.crypto
{
   import com.adobe.utils.IntUtil;
   import flash.utils.ByteArray;
   
   public class MD5
   {
      
      public static var digest:ByteArray;
      
      public function MD5()
      {
         super();
      }
      
      public static function hash(param1:String) : String
      {
         var inputBytes:ByteArray = new ByteArray();
         inputBytes.writeUTFBytes(param1);
         return getString12(inputBytes);
      }
      
      public static function getString24(param1:ByteArray) : String
      {
         return getString12(param1);
      }
      
      public static function getString12(param1:ByteArray) : String
      {
         var stateA:int = 1732584193;
         var stateB:int = -271733879;
         var stateC:int = -1732584194;
         var stateD:int = 271733878;
         var previousA:int;
         var previousB:int;
         var previousC:int;
         var previousD:int;
         var words:Array = getArray15(param1);
         var wordCount:int = words.length;
         var blockIndex:int = 0;
         while(blockIndex < wordCount)
         {
            previousA = stateA;
            previousB = stateB;
            previousC = stateC;
            previousD = stateD;
            stateA = getInt5(stateA,stateB,stateC,stateD,words[int(blockIndex + 0)],7,-680876936);
            stateD = getInt5(stateD,stateA,stateB,stateC,words[int(blockIndex + 1)],12,-389564586);
            stateC = getInt5(stateC,stateD,stateA,stateB,words[int(blockIndex + 2)],17,606105819);
            stateB = getInt5(stateB,stateC,stateD,stateA,words[int(blockIndex + 3)],22,-1044525330);
            stateA = getInt5(stateA,stateB,stateC,stateD,words[int(blockIndex + 4)],7,-176418897);
            stateD = getInt5(stateD,stateA,stateB,stateC,words[int(blockIndex + 5)],12,1200080426);
            stateC = getInt5(stateC,stateD,stateA,stateB,words[int(blockIndex + 6)],17,-1473231341);
            stateB = getInt5(stateB,stateC,stateD,stateA,words[int(blockIndex + 7)],22,-45705983);
            stateA = getInt5(stateA,stateB,stateC,stateD,words[int(blockIndex + 8)],7,1770035416);
            stateD = getInt5(stateD,stateA,stateB,stateC,words[int(blockIndex + 9)],12,-1958414417);
            stateC = getInt5(stateC,stateD,stateA,stateB,words[int(blockIndex + 10)],17,-42063);
            stateB = getInt5(stateB,stateC,stateD,stateA,words[int(blockIndex + 11)],22,-1990404162);
            stateA = getInt5(stateA,stateB,stateC,stateD,words[int(blockIndex + 12)],7,1804603682);
            stateD = getInt5(stateD,stateA,stateB,stateC,words[int(blockIndex + 13)],12,-40341101);
            stateC = getInt5(stateC,stateD,stateA,stateB,words[int(blockIndex + 14)],17,-1502002290);
            stateB = getInt5(stateB,stateC,stateD,stateA,words[int(blockIndex + 15)],22,1236535329);
            stateA = getInt29(stateA,stateB,stateC,stateD,words[int(blockIndex + 1)],5,-165796510);
            stateD = getInt29(stateD,stateA,stateB,stateC,words[int(blockIndex + 6)],9,-1069501632);
            stateC = getInt29(stateC,stateD,stateA,stateB,words[int(blockIndex + 11)],14,643717713);
            stateB = getInt29(stateB,stateC,stateD,stateA,words[int(blockIndex + 0)],20,-373897302);
            stateA = getInt29(stateA,stateB,stateC,stateD,words[int(blockIndex + 5)],5,-701558691);
            stateD = getInt29(stateD,stateA,stateB,stateC,words[int(blockIndex + 10)],9,38016083);
            stateC = getInt29(stateC,stateD,stateA,stateB,words[int(blockIndex + 15)],14,-660478335);
            stateB = getInt29(stateB,stateC,stateD,stateA,words[int(blockIndex + 4)],20,-405537848);
            stateA = getInt29(stateA,stateB,stateC,stateD,words[int(blockIndex + 9)],5,568446438);
            stateD = getInt29(stateD,stateA,stateB,stateC,words[int(blockIndex + 14)],9,-1019803690);
            stateC = getInt29(stateC,stateD,stateA,stateB,words[int(blockIndex + 3)],14,-187363961);
            stateB = getInt29(stateB,stateC,stateD,stateA,words[int(blockIndex + 8)],20,1163531501);
            stateA = getInt29(stateA,stateB,stateC,stateD,words[int(blockIndex + 13)],5,-1444681467);
            stateD = getInt29(stateD,stateA,stateB,stateC,words[int(blockIndex + 2)],9,-51403784);
            stateC = getInt29(stateC,stateD,stateA,stateB,words[int(blockIndex + 7)],14,1735328473);
            stateB = getInt29(stateB,stateC,stateD,stateA,words[int(blockIndex + 12)],20,-1926607734);
            stateA = getInt32(stateA,stateB,stateC,stateD,words[int(blockIndex + 5)],4,-378558);
            stateD = getInt32(stateD,stateA,stateB,stateC,words[int(blockIndex + 8)],11,-2022574463);
            stateC = getInt32(stateC,stateD,stateA,stateB,words[int(blockIndex + 11)],16,1839030562);
            stateB = getInt32(stateB,stateC,stateD,stateA,words[int(blockIndex + 14)],23,-35309556);
            stateA = getInt32(stateA,stateB,stateC,stateD,words[int(blockIndex + 1)],4,-1530992060);
            stateD = getInt32(stateD,stateA,stateB,stateC,words[int(blockIndex + 4)],11,1272893353);
            stateC = getInt32(stateC,stateD,stateA,stateB,words[int(blockIndex + 7)],16,-155497632);
            stateB = getInt32(stateB,stateC,stateD,stateA,words[int(blockIndex + 10)],23,-1094730640);
            stateA = getInt32(stateA,stateB,stateC,stateD,words[int(blockIndex + 13)],4,681279174);
            stateD = getInt32(stateD,stateA,stateB,stateC,words[int(blockIndex + 0)],11,-358537222);
            stateC = getInt32(stateC,stateD,stateA,stateB,words[int(blockIndex + 3)],16,-722521979);
            stateB = getInt32(stateB,stateC,stateD,stateA,words[int(blockIndex + 6)],23,76029189);
            stateA = getInt32(stateA,stateB,stateC,stateD,words[int(blockIndex + 9)],4,-640364487);
            stateD = getInt32(stateD,stateA,stateB,stateC,words[int(blockIndex + 12)],11,-421815835);
            stateC = getInt32(stateC,stateD,stateA,stateB,words[int(blockIndex + 15)],16,530742520);
            stateB = getInt32(stateB,stateC,stateD,stateA,words[int(blockIndex + 2)],23,-995338651);
            stateA = getInt9(stateA,stateB,stateC,stateD,words[int(blockIndex + 0)],6,-198630844);
            stateD = getInt9(stateD,stateA,stateB,stateC,words[int(blockIndex + 7)],10,1126891415);
            stateC = getInt9(stateC,stateD,stateA,stateB,words[int(blockIndex + 14)],15,-1416354905);
            stateB = getInt9(stateB,stateC,stateD,stateA,words[int(blockIndex + 5)],21,-57434055);
            stateA = getInt9(stateA,stateB,stateC,stateD,words[int(blockIndex + 12)],6,1700485571);
            stateD = getInt9(stateD,stateA,stateB,stateC,words[int(blockIndex + 3)],10,-1894986606);
            stateC = getInt9(stateC,stateD,stateA,stateB,words[int(blockIndex + 10)],15,-1051523);
            stateB = getInt9(stateB,stateC,stateD,stateA,words[int(blockIndex + 1)],21,-2054922799);
            stateA = getInt9(stateA,stateB,stateC,stateD,words[int(blockIndex + 8)],6,1873313359);
            stateD = getInt9(stateD,stateA,stateB,stateC,words[int(blockIndex + 15)],10,-30611744);
            stateC = getInt9(stateC,stateD,stateA,stateB,words[int(blockIndex + 6)],15,-1560198380);
            stateB = getInt9(stateB,stateC,stateD,stateA,words[int(blockIndex + 13)],21,1309151649);
            stateA = getInt9(stateA,stateB,stateC,stateD,words[int(blockIndex + 4)],6,-145523070);
            stateD = getInt9(stateD,stateA,stateB,stateC,words[int(blockIndex + 11)],10,-1120210379);
            stateC = getInt9(stateC,stateD,stateA,stateB,words[int(blockIndex + 2)],15,718787259);
            stateB = getInt9(stateB,stateC,stateD,stateA,words[int(blockIndex + 9)],21,-343485551);
            stateA += previousA;
            stateB += previousB;
            stateC += previousC;
            stateD += previousD;
            blockIndex += 16;
         }
         digest = new ByteArray();
         digest.writeInt(stateA);
         digest.writeInt(stateB);
         digest.writeInt(stateC);
         digest.writeInt(stateD);
         digest.position = 0;
         return IntUtil.getString40(stateA) + IntUtil.getString40(stateB) + IntUtil.getString40(stateC) + IntUtil.getString40(stateD);
      }
      
      private static function f(param1:int, param2:int, param3:int) : int
      {
         return param1 & param2 | ~param1 & param3;
      }
      
      private static function g(param1:int, param2:int, param3:int) : int
      {
         return param1 & param3 | param2 & ~param3;
      }
      
      private static function h(param1:int, param2:int, param3:int) : int
      {
         return param1 ^ param2 ^ param3;
      }
      
      private static function i(param1:int, param2:int, param3:int) : int
      {
         return param2 ^ (param1 | ~param3);
      }
      
      private static function transform(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : int
      {
         var sum:int = param2 + int(param1(param3,param4,param5)) + param6 + param8;
         return IntUtil.getInt13(sum,param7) + param3;
      }
      
      private static function getInt5(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(f,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function getInt29(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(g,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function getInt32(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(h,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function getInt9(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(i,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function getArray15(param1:ByteArray) : Array
      {
         var words:Array = new Array();
         var bitLength:int = param1.length * 8;
         var byteMask:int = 255;
         var bitIndex:int = 0;
         while(bitIndex < bitLength)
         {
            words[int(bitIndex >> 5)] = words[int(bitIndex >> 5)] | (param1[bitIndex / 8] & byteMask) << bitIndex % 32;
            bitIndex += 8;
         }
         words[int(bitLength >> 5)] = words[int(bitLength >> 5)] | 128 << bitLength % 32;
         words[int((bitLength + 64 >>> 9 << 4) + 14)] = bitLength;
         return words;
      }
   }
}

