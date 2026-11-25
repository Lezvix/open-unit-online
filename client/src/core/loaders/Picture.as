package core.loaders
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class Picture extends Bitmap
   {
      
      private var idValue:String;
      
      public function Picture(param1:String = null)
      {
         super();
         this.id = param1;
      }
      
      public function get id() : String
      {
         return this.idValue;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 !== this.idValue)
         {
            idValue = param1;
            if(this.idValue)
            {
               if(BitmapCache.check54(this.idValue))
               {
                  this.doAction494(this.idValue);
               }
               else
               {
                  bitmapData = null;
                  BitmapCache.doAction139(this.idValue,this.doAction494);
               }
            }
            else
            {
               bitmapData = null;
            }
         }
      }
      
      private function doAction494(id:String) : void
      {
         var cachedBitmapData:BitmapData = null;
         if(this.idValue === id)
         {
            cachedBitmapData = BitmapCache.doAction50(this.idValue);
            if(cachedBitmapData)
            {
               bitmapData = cachedBitmapData;
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function clone() : Picture
      {
         return new Picture(this.idValue);
      }
   }
}

