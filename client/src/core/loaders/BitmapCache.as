package core.loaders
{
   import flash.display.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class BitmapCache
   {
      
      private static const array106:Array = [];
      
      private static const obj6:Object = {};
      
      public function BitmapCache()
      {
         super();
      }
      
      public static function doAction50(id:String) : *
      {
         return obj6[id];
      }
      
      public static function check54(id:String) : Boolean
      {
         return id in obj6;
      }
      
      public static function getPicture1(id:String) : Picture
      {
         return new Picture(id);
      }
      
      public static function doAction139(id:String, callback:Function) : void
      {
         var index:int = 0;
         while(index < array106.length)
         {
            request = array106[index];
            if(request.id === id)
            {
               request.callbacks.push(callback);
               return;
            }
            index++;
         }
         var loader:ImageLoader = new ImageLoader(id);
         var request:Object;
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onContentLoaderInfoIoError3);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onContentLoaderInfoComplete3);
         array106.push({
            "id":id,
            "callbacks":[callback],
            "loader":loader
         });
         loader.doAction179();
      }
      
      private static function onContentLoaderInfoIoError3(event:IOErrorEvent) : void
      {
         var loaderInfo:LoaderInfo = event.target as LoaderInfo;
         var loader:ImageLoader = loaderInfo.loader as ImageLoader;
         var id:String = loader.id;
         var index:int;
         if(loader.propValue99 > 3)
         {
            loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onContentLoaderInfoIoError3);
            loaderInfo.removeEventListener(Event.COMPLETE,onContentLoaderInfoComplete3);
            index = 0;
            while(index < array106.length)
            {
               if(array106[index].id === id)
               {
                  array106.splice(index,1);
                  return;
               }
               index++;
            }
         }
         else
         {
            loader.doAction179();
         }
      }
      
      private static function onContentLoaderInfoComplete3(event:Event) : void
      {
         var loaderInfo:LoaderInfo = event.target as LoaderInfo;
         var loader:ImageLoader = loaderInfo.loader as ImageLoader;
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onContentLoaderInfoIoError3);
         loaderInfo.removeEventListener(Event.COMPLETE,onContentLoaderInfoComplete3);
         var id:String = loader.id;
         var content:* = loader.content;
         if(content is Bitmap)
         {
            obj6[id] = content.bitmapData;
         }
         else if(content is Sprite)
         {
            obj6[id] = content;
            if("BITMAP" in content)
            {
               bitmap = new content.BITMAP();
               obj6[id + "/BITMAP"] = bitmap.bitmapData;
            }
         }
         loader.unload();
         var index:int = 0;
         var bitmap:Bitmap;
         var request:Object;
         while(index < array106.length)
         {
            request = array106[index];
            if(request.id === id)
            {
               array106.splice(index,1);
               index = request.callbacks.length;
               while(index > 0)
               {
                  request.callbacks[--index](id);
               }
               return;
            }
            index++;
         }
      }
   }
}

