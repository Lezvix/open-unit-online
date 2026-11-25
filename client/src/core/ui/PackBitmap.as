package core.ui
{
   import flash.display.Bitmap;
   
   public class PackBitmap extends Bitmap
   {
      
      public var count:int = 0;
      
      public var packId:int = 0;
      
      public var packBitmapResourceName:String = null;
      
      public function PackBitmap()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(bitmapData)
         {
            bitmapData.dispose();
         }
      }
   }
}

