package game
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   
   public class PackageLoader extends Loader
   {
      
      public static var MAX_IMAGE_COUNT:int = 50;
      
      public var packageId:int;
      
      public var isPackLoaded:Boolean;
      
      public var imageCount:Array = new Array(MAX_IMAGE_COUNT);
      
      public var bdatas:Array = new Array(MAX_IMAGE_COUNT);
      
      public function PackageLoader(param1:int)
      {
         super();
         var index:uint = 0;
         while(index < MAX_IMAGE_COUNT)
         {
            this.imageCount[index] = 0;
            index++;
         }
         this.packageId = param1;
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
      }
      
      public function loadPackage() : void
      {
         var request:URLRequest = new URLRequest("res/ResPack" + this.packageId + ".swf");
         load(request);
      }
      
      public function getImage(param1:int) : Bitmap
      {
         var bitmap:Bitmap = null;
         if(this.imageCount[param1] == 0)
         {
            this.imageCount[param1] = 1;
            bitmap = new content["IMAGE_" + param1]();
            this.bdatas[param1] = bitmap.bitmapData;
            bitmap.bitmapData.lock();
            return bitmap;
         }
         this.imageCount[param1]++;
         return new Bitmap(this.bdatas[param1]);
      }
      
      public function unloadImage(param1:int) : void
      {
         this.imageCount[param1]--;
         if(this.imageCount[param1] == 0)
         {
            this.bdatas[param1].dispose();
            this.bdatas[param1] = 0;
         }
      }
      
      private function loadErrorHandler(param1:IOErrorEvent) : void
      {
         this.loadPackage();
      }
   }
}

