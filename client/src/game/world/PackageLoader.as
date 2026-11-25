package game.world
{
   import core.resources.ResourcePack;
   import core.resources.ResourceManager;
   import core.system.EventListeners;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   
   public class PackageLoader extends Loader
   {
      
      public static const MAX_IMAGE_COUNT:int = 50;
      
      public var packageId:int;
      
      public var isPackLoaded:Boolean;
      
      public var imageCount:Array = new Array(MAX_IMAGE_COUNT);
      
      public var bdatas:Array = new Array(MAX_IMAGE_COUNT);
      
      private var str43:String;
      
      public var resourceBundle:ResourcePack = null;
      
      public function PackageLoader(packageId:int, basePath:String)
      {
         super();
         this.str43 = basePath;
         var index:uint = 0;
         while(index < MAX_IMAGE_COUNT)
         {
            this.imageCount[index] = 0;
            index++;
         }
         this.packageId = packageId;
         EventListeners.addEventListener(contentLoaderInfo,IOErrorEvent.IO_ERROR,this.loadErrorHandler);
      }
      
      public static function getString21(packageId:int) : String
      {
         return "ResPack" + packageId + ".swf";
      }
      
      public function loadPackage(retry:Boolean = false) : void
      {
         var path:String = this.str43 + getString21(this.packageId);
         var url:String = ResourceManager.sharedInstance.resolveUrl(path,retry);
         var request:URLRequest = new URLRequest(url);
         load(request);
      }
      
      public function getImage(imageId:int) : Bitmap
      {
         var bitmap:Bitmap = null;
         if(this.imageCount[imageId] == 0)
         {
            this.imageCount[imageId] = 1;
            if(this.resourceBundle == null)
            {
               bitmap = new content["IMAGE_" + imageId]();
            }
            else
            {
               bitmap = new this.resourceBundle.data["IMAGE_" + imageId]();
            }
            this.bdatas[imageId] = bitmap.bitmapData;
            bitmap.bitmapData.lock();
            return bitmap;
         }
         else
         {
            this.imageCount[imageId]++;
            return new Bitmap(this.bdatas[imageId]);
         }
      }
      
      public function unloadImage(imageId:int) : void
      {
         this.imageCount[imageId]--;
         if(this.imageCount[imageId] == 0)
         {
            this.bdatas[imageId].dispose();
            this.bdatas[imageId] = 0;
         }
      }
      
      private function loadErrorHandler(event:IOErrorEvent) : void
      {
         this.loadPackage(true);
      }
   }
}

