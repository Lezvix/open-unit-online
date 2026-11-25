package core.resources
{
   import core.system.EventListeners;
   import core.ui.TextStyle;
   import core.ui.PackBitmap;
   import core.ui.ComponentFactory;
   import game.world.MovieBitmap;
   import game.world.AvatarLoader;
   import game.world.PackageLoader;
   import game.world.MovieLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class ResourceManager
   {
      
      public static const RESOURCE_MANAGER_CONST1:int = -1;
      
      private static var resourcePackList1:Vector.<ResourcePack> = new Vector.<ResourcePack>();
      
      public static var sharedInstance:ResourceManager;

      private static var resourceDigestsByUrl:Object;

      private var resourcePacksById:Object;
      
      private var pendingResourcePacks:Array = new Array();
      
      private var packLoader:Loader = null;
      
      private var fontLoader:FontLoader;
      
      private var urlLoader:URLLoader;
      
      private var textLoader:URLLoader;
      
      private var resourcePack1:ResourcePack;
      
      private var resourceLoadInProgress:Boolean = false;
      
      private var packageLoader:PackageLoader;
      
      private var onResourcePackComplete:Function = null;
      
      private var onFontUrlLoaderProgress:Function = null;
      
      private var onComplete:Function = null;
      
      private var resourceUrlPrefix:String;
      
      private var request:URLRequest;
      
      private var currentResourceUrl:String;
      
      private var resourcePack2:ResourcePack;
      
      private var obj49:Object = new Object();
      
      private var sharedPackBitmaps:Object = new Object();
      
      private var obj42:Object = {};
      
      private var resourceNumbersByKey:Object = new Object();
      
      public function ResourceManager()
      {
         var digestUrl:String;
         var cacheToken:String;
         super();
         this.resourcePacksById = new Object();
         this.packLoader = new Loader();
         this.fontLoader = new FontLoader();
         this.urlLoader = new URLLoader();
         this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.resourceUrlPrefix = "";
         this.currentResourceUrl = this.resourceUrlPrefix + "digests.txt";
         if(!resourceDigestsByUrl)
         {
            this.textLoader = new URLLoader();
            this.textLoader.dataFormat = URLLoaderDataFormat.TEXT;
            this.resourceUrlPrefix = "";
            this.resourceLoadInProgress = true;
            digestUrl = this.currentResourceUrl;
            cacheToken = int(Math.random() * 1000000).toString();
            digestUrl = this.getString46(digestUrl,cacheToken);
            this.request = new URLRequest(digestUrl);
            this.textLoader.load(this.request);
         }
         this.doAction807();
      }
      
      public function resolveUrl(url:String, retry:Boolean = false) : String
      {
         var digest:String = this.getString44(url);
         if(digest != null && digest != "0")
         {
            url = this.getString46(url,this.getString44(url));
         }
         if(retry)
         {
            if(url.indexOf("?") >= 0)
            {
               url += "&";
            }
            else
            {
               url += "?";
            }
            url += "r=" + int(Math.random() * 1000000).toString();
         }
         return url;
      }
      
      private function getString46(url:String, version:String) : String
      {
         if(url.indexOf("?") >= 0)
         {
            return url + "&ver=" + version;
         }
         return url + "?ver=" + version;
      }
      
      public function getString44(url:String) : String
      {
         var digest:String = resourceDigestsByUrl[url] as String;
         if(digest == null)
         {
            digest = "0";
         }
         return digest;
      }
      
      public function getInt33(key:String) : int
      {
         var value:Object = this.resourceNumbersByKey[key];
         if(value == null)
         {
            return 0;
         }
         return int(value);
      }
      
      public function set propValue185(param1:Function) : void
      {
         onFontUrlLoaderProgress = param1;
      }
      
      public function set completeHandler(param1:Function) : void
      {
         onComplete = param1;
      }
      
      public function set packCompleteHandler(param1:Function) : void
      {
         onResourcePackComplete = param1;
      }
      
      private function doAction807() : void
      {
         if(this.textLoader)
         {
            EventListeners.addEventListener(this.textLoader,Event.COMPLETE,this.doAction484);
            EventListeners.addEventListener(this.textLoader,IOErrorEvent.IO_ERROR,this.doAction957);
         }
         EventListeners.addEventListener(this.packLoader.contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.addEventListener(this.packLoader.contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction680);
         EventListeners.addEventListener(this.packLoader.contentLoaderInfo,ProgressEvent.PROGRESS,this.doAction581);
         EventListeners.addEventListener(this.urlLoader,Event.COMPLETE,this.urlLoaderCompleteHandler);
         EventListeners.addEventListener(this.urlLoader,IOErrorEvent.IO_ERROR,this.urlLoaderIoErrorHandler);
         EventListeners.addEventListener(this.urlLoader,ProgressEvent.PROGRESS,this.doAction581);
         EventListeners.addEventListener(this.fontLoader,Event.COMPLETE,this.urlLoaderCompleteHandler);
         EventListeners.addEventListener(this.fontLoader,IOErrorEvent.IO_ERROR,this.doAction469);
         EventListeners.addEventListener(this.fontLoader,ProgressEvent.PROGRESS,this.doAction581);
      }
      
      private function doAction530() : void
      {
         if(this.textLoader)
         {
            EventListeners.removeEventListener(this.textLoader,Event.COMPLETE,this.doAction484);
            EventListeners.removeEventListener(this.textLoader,IOErrorEvent.IO_ERROR,this.doAction957);
         }
         EventListeners.removeEventListener(this.packLoader.contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.removeEventListener(this.packLoader.contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction680);
         EventListeners.removeEventListener(this.packLoader.contentLoaderInfo,ProgressEvent.PROGRESS,this.doAction581);
         EventListeners.removeEventListener(this.urlLoader,Event.COMPLETE,this.urlLoaderCompleteHandler);
         EventListeners.removeEventListener(this.urlLoader,IOErrorEvent.IO_ERROR,this.urlLoaderIoErrorHandler);
         EventListeners.removeEventListener(this.urlLoader,ProgressEvent.PROGRESS,this.doAction581);
         EventListeners.removeEventListener(this.fontLoader,Event.COMPLETE,this.urlLoaderCompleteHandler);
         EventListeners.removeEventListener(this.fontLoader,IOErrorEvent.IO_ERROR,this.doAction469);
         EventListeners.removeEventListener(this.fontLoader,ProgressEvent.PROGRESS,this.doAction581);
      }
      
      public function dispose() : void
      {
         this.doAction530();
      }
      
      public function loadResourcePack(param1:int, param2:String, param3:int = 0, param4:Object = null, param5:Function = null, param6:Boolean = false) : void
      {
         var pack:ResourcePack = new ResourcePack(param1,param2,param3,param4,param5,param6);
         var index:int;
         if(!this.resourceLoadInProgress)
         {
            this.doAction935(pack);
         }
         else
         {
            if(param1 != RESOURCE_MANAGER_CONST1)
            {
               index = 0;
               while(index < this.pendingResourcePacks.length)
               {
                  if(this.pendingResourcePacks[index].packId == param1)
                  {
                     this.pendingResourcePacks.splice(index,1);
                  }
                  else
                  {
                     index++;
                  }
               }
            }
            this.pendingResourcePacks.push(pack);
            if(this.resourcePack1 != null && this.resourcePack1.packId == param1 && param1 != RESOURCE_MANAGER_CONST1)
            {
               this.doAction18();
               this.doAction113(false);
            }
         }
      }
      
      public function getResource(packId:int, resourceName:String) : Class
      {
         var pack:ResourcePack = this.resourcePacksById[packId] as ResourcePack;
         if(pack != null)
         {
            return pack.getResource(resourceName);
         }
         return null;
      }
      
      public function getObject7(resourceName:String) : Object
      {
         var resourceClass:Class = null;
         var index:int = 0;
         while(index < resourcePackList1.length)
         {
            resourceClass = resourcePackList1[index].getResource(resourceName);
            if(resourceClass != null)
            {
               return new resourceClass();
            }
            index++;
         }
         return null;
      }
      
      public function getObject8(packId:int, resourceName:String) : Object
      {
         var pack:ResourcePack = this.resourcePacksById[packId] as ResourcePack;
         if(pack != null)
         {
            return new (pack.getResource(resourceName))();
         }
         return null;
      }
      
      public function getBitmap2(resourceName:String) : Bitmap
      {
         var resourceClass:Class = null;
         var index:int = 0;
         while(index < resourcePackList1.length)
         {
            resourceClass = resourcePackList1[index].getResource(resourceName);
            if(resourceClass != null)
            {
               return new resourceClass();
            }
            index++;
         }
         return null;
      }
      
      public function getBmp(param1:int, param2:String) : Bitmap
      {
         return new (this.getResource(param1,param2))();
      }
      
      public function getPackBitmap1(param1:int, param2:String, param3:Object = null) : PackBitmap
      {
         var cacheKey:String = param1 + " - " + param2;
         var bitmap:Bitmap;
         var cachedBitmap:PackBitmap;
         var matrix:Matrix;
         var scaledData:BitmapData;
         if(!this.sharedPackBitmaps[cacheKey])
         {
            bitmap = new (this.getResource(param1,param2))();
            cachedBitmap = new PackBitmap();
            if(param3)
            {
               matrix = new Matrix();
               if(param3.width && param3.height)
               {
                  matrix.scale(param3.width / bitmap.width,param3.height / bitmap.height);
                  scaledData = new BitmapData(param3.width,param3.height,true,0);
                  scaledData.draw(bitmap.bitmapData,matrix);
                  bitmap.bitmapData.dispose();
                  bitmap.bitmapData = scaledData;
               }
            }
            cachedBitmap.bitmapData = bitmap.bitmapData;
            cachedBitmap.packId = param1;
            cachedBitmap.packBitmapResourceName = param2;
            this.sharedPackBitmaps[cacheKey] = cachedBitmap;
         }
         ++this.sharedPackBitmaps[cacheKey].count;
         return this.sharedPackBitmaps[cacheKey];
      }
      
      public function doAction652(bitmap:PackBitmap) : void
      {
         var cacheKey:String = bitmap.packId + " - " + bitmap.packBitmapResourceName;
         --bitmap.count;
         if(bitmap.count == 0)
         {
            bitmap.dispose();
            delete this.sharedPackBitmaps[cacheKey];
         }
      }
      
      private function doAction18() : void
      {
         switch(this.resourcePack1.packType)
         {
            case ResourcePack.RESOURCE_PACK_CONST8:
            case ResourcePack.RESOURCE_PACK_CONST1:
            case ResourcePack.RESOURCE_PACK_CONST7:
               this.packLoader.close();
               break;
            case ResourcePack.RESOURCE_PACK_CONST3:
               this.fontLoader.close();
               break;
            default:
               this.urlLoader.close();
               break;
         }
      }
      
      private function doAction935(param1:ResourcePack) : void
      {
         resourcePack1 = param1;
         resourceLoadInProgress = true;
         currentResourceUrl = this.resourceUrlPrefix + param1.packUrl;
         if(param1.packType == ResourcePack.RESOURCE_PACK_CONST4)
         {
            MovieLoader.doAction418(this.resolveUrl(this.currentResourceUrl),this.doAction557);
         }
         else
         {
            request = new URLRequest(this.resolveUrl(this.currentResourceUrl));
            switch(param1.packType)
            {
               case ResourcePack.RESOURCE_PACK_CONST8:
               case ResourcePack.RESOURCE_PACK_CONST1:
               case ResourcePack.RESOURCE_PACK_CONST7:
                  this.packLoader.load(this.request);
                  break;
               case ResourcePack.RESOURCE_PACK_CONST3:
                  this.fontLoader.load(this.request);
                  break;
               default:
                  this.urlLoader.load(this.request);
                  break;
            }
         }
      }
      
      protected function doAction693(param1:ResourcePack) : void
      {
      }
      
      private function doAction113(notify:Boolean = true) : void
      {
         var nextPack:ResourcePack = null;
         var callback:Function = null;
         if(notify)
         {
            if(this.onResourcePackComplete != null)
            {
               this.onResourcePackComplete(this.resourcePack2);
            }
            if(this.resourcePack2.doAction568 != null)
            {
               this.resourcePack2.doAction568(this.resourcePack2);
            }
            this.doAction693(this.resourcePack2);
         }
         if(this.pendingResourcePacks.length > 0)
         {
            nextPack = ResourcePack(this.pendingResourcePacks[0]);
            this.pendingResourcePacks.splice(0,1);
            this.doAction935(nextPack);
         }
         else
         {
            resourceLoadInProgress = false;
            if(this.onComplete != null)
            {
               callback = this.onComplete;
               onComplete = null;
               callback();
            }
         }
      }
      
      protected function doAction531() : void
      {
      }
      
      private function doAction484(event:Event) : void
      {
         resourceDigestsByUrl = {};
         var lines:Array = this.textLoader.data.split("\n");
         var entry:Array;
         var index:int = 0;
         while(index < lines.length)
         {
            entry = lines[index].split("=");
            if(entry[0].indexOf("!") == 0)
            {
               this.resourceNumbersByKey[String(entry[0]).substr(1)] = int(entry[1]);
            }
            else
            {
               resourceDigestsByUrl[this.resourceUrlPrefix + entry[0]] = entry[1];
            }
            index++;
         }
         this.doAction531();
         this.doAction113(false);
      }
      
      private function urlLoaderCompleteHandler(param1:Event) : void
      {
         resourcePack2 = this.resourcePack1;
         this.resourcePack1.data = this.urlLoader.data;
         switch(this.resourcePack1.packType)
         {
            case ResourcePack.RESOURCE_PACK_CONST9:
               Localization.localization1.parseData(this.resourcePack1.data as ByteArray);
               break;
            case ResourcePack.RESOURCE_PACK_CONST5:
               ComponentFactory.init(this.resourcePack1.data as ByteArray);
               break;
            default:
               this.resourcePacksById[this.resourcePack1.packId] = this.resourcePack1;
               break;
         }
         this.doAction113();
      }
      
      private function doAction557(param1:AvatarLoader) : void
      {
         this.doAction113();
      }
      
      private function doAction843(param1:Event) : void
      {
         if(this.resourcePack1.includeInGlobalResourceSearch)
         {
            resourcePackList1.push(this.resourcePack1);
         }
         resourcePack2 = this.resourcePack1;
         this.resourcePack1.data = this.packLoader.content;
         switch(this.resourcePack1.packType)
         {
            case ResourcePack.RESOURCE_PACK_CONST7:
               MovieBitmap.doAction790(this.resourcePack1);
               break;
            case ResourcePack.RESOURCE_PACK_CONST1:
               SoundManager.doAction87(this.resourcePack1);
               SoundManager.doAction429();
               break;
            default:
               this.resourcePacksById[this.resourcePack1.packId] = this.resourcePack1;
               break;
         }
         this.doAction113();
      }
      
      private function doAction581(param1:ProgressEvent) : void
      {
         if(this.onFontUrlLoaderProgress != null)
         {
            this.onFontUrlLoaderProgress(param1.bytesLoaded,param1.bytesTotal);
         }
      }
      
      private function doAction680(param1:IOErrorEvent) : void
      {
         request = new URLRequest(this.resolveUrl(this.currentResourceUrl,true));
         this.packLoader.load(this.request);
      }
      
      private function doAction957(param1:IOErrorEvent) : void
      {
         request = new URLRequest(this.resolveUrl(this.currentResourceUrl,true));
         this.textLoader.load(this.request);
      }
      
      private function urlLoaderIoErrorHandler(param1:IOErrorEvent) : void
      {
         request = new URLRequest(this.resolveUrl(this.currentResourceUrl,true));
         this.urlLoader.load(this.request);
      }
      
      private function doAction469(param1:IOErrorEvent) : void
      {
         request = new URLRequest(this.resolveUrl(this.currentResourceUrl,true));
         this.fontLoader.load(this.request);
      }
      
      public function loadPackById(param1:int) : void
      {
      }
      
      public function getTextStyle1(fontName:String, fontSize:uint = 12, color:uint = 0) : TextStyle
      {
         var style:TextStyle = new TextStyle();
         style.size = fontSize;
         style.useEmbeddedFonts = true;
         style.color = color;
         style.fontName = fontName;
         return style;
      }
      
      public function check40(param1:int) : Boolean
      {
         return this.resourcePacksById[param1] != null;
      }
      
      public function getObject3(param1:int) : Object
      {
         return this.resourcePacksById[param1].data;
      }
      
      public function doAction47(param1:int) : void
      {
         delete this.resourcePacksById[param1];
      }
   }
}

