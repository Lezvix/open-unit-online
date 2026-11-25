package com.adobe.images
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class PNGEncoder
   {
      
      public function PNGEncoder()
      {
         super();
      }
      
      public static function getString20(param1:BitmapData) : ByteArray
      {
         var pngBytes:ByteArray = new ByteArray();
         pngBytes.writeUnsignedInt(2303741511);
         pngBytes.writeUnsignedInt(218765834);
         var headerBytes:ByteArray = new ByteArray();
         headerBytes.writeInt(param1.width);
         headerBytes.writeInt(param1.height);
         headerBytes.writeUnsignedInt(134610944);
         headerBytes.writeByte(0);
         doAction125(pngBytes,1229472850,headerBytes);
         var pixelBytes:ByteArray = new ByteArray();
         var row:int = 0;
         var pixel:uint;
         var column:int;
         while(row < param1.height)
         {
            pixelBytes.writeByte(0);
            if(!param1.transparent)
            {
               column = 0;
               while(column < param1.width)
               {
                  pixel = param1.getPixel(column,row);
                  pixelBytes.writeUnsignedInt(uint((pixel & 0xFFFFFF) << 8 | 0xFF));
                  column++;
               }
            }
            else
            {
               column = 0;
               while(column < param1.width)
               {
                  pixel = param1.getPixel32(column,row);
                  pixelBytes.writeUnsignedInt(uint((pixel & 0xFFFFFF) << 8 | pixel >>> 24));
                  column++;
               }
            }
            row++;
         }
         pixelBytes.compress();
         doAction125(pngBytes,1229209940,pixelBytes);
         doAction125(pngBytes,1229278788,null);
         return pngBytes;
      }
      
      private static var array32:Array;

      private static var flag56:Boolean = false;

      private static function doAction125(param1:ByteArray, param2:uint, param3:ByteArray) : void
      {
         if(!flag56)
         {
            flag56 = true;
            array32 = [];
            tableIndex = 0;
            while(tableIndex < 256)
            {
               crc = tableIndex;
               bitIndex = 0;
               while(bitIndex < 8)
               {
                  if(crc & 1)
                  {
                     crc = uint(uint(3988292384) ^ uint(crc >>> 1));
                  }
                  else
                  {
                     crc = uint(crc >>> 1);
                  }
                  bitIndex++;
               }
               array32[tableIndex] = crc;
               tableIndex++;
            }
         }
         var chunkLength:uint = 0;
         if(param3 != null)
         {
            chunkLength = param3.length;
         }
         param1.writeUnsignedInt(chunkLength);
         var chunkStart:uint = param1.position;
         param1.writeUnsignedInt(param2);
         if(param3 != null)
         {
            param1.writeBytes(param3);
         }
         var chunkEnd:uint = param1.position;
         param1.position = chunkStart;
         crc = 4294967295;
         var byteIndex:int = 0;
         var crc:uint;
         var tableIndex:uint;
         var bitIndex:uint;
         while(byteIndex < chunkEnd - chunkStart)
         {
            crc = uint(array32[(crc ^ param1.readUnsignedByte()) & uint(255)] ^ uint(crc >>> 8));
            byteIndex++;
         }
         crc = uint(crc ^ uint(4294967295));
         param1.position = chunkEnd;
         param1.writeUnsignedInt(crc);
      }
   }
}

