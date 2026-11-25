package social
{
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.clearInterval;
   
   public class ImageLoader
   {
      
      private static var loader:ImageLoader;
      
      private var activeImageLoadCount:int = 0;
      
      private var maxConcurrentImageLoads:int;
      
      private var maxCachedImageEntries:int;
      
      private var loadNextCallback:Function;
      
      private var pendingImageLoads:Array = new Array();
      
      private var cachedImageEntries:Array = new Array();
      
      private var imageEntriesByUrl:Array = new Array();
      
      private var imageQueueIntervalId:int = -1;
      
      private var queue:Array = new Array();
      
      private var imagePlaceholderRules:Array = [];
      
      private var imageLoadErrorBitmap:Bitmap = null;
      
      private var api:ISocialApi;
      
      private var failedImagePolicyDomains:Array = new Array();
      
      public function ImageLoader(concurrentLoadLimit:int, cacheEntryLimit:int, onLoadError:Function, socialApi:ISocialApi)
      {
         super();
         this.maxConcurrentImageLoads = concurrentLoadLimit;
         this.maxCachedImageEntries = cacheEntryLimit;
         this.loadNextCallback = onLoadError;
         this.api = socialApi;
         loader = this;
      }
      
      public static function loadImage(url:String, onComplete:Function = null, callbackData:Object = null) : AvatarImage
      {
         return loader.loadImage(url,onComplete,callbackData);
      }
      
      public static function prioritizeImageLoad(url:String) : void
      {
         return loader.prioritizeImageLoad(url);
      }
      
      private static function getImageUrlOrigin(url:String) : String
      {
         return url ? url.replace(/(.*:\/\/[^\/]*).*/,"$1") : url;
      }
      
      public function registerImagePlaceholder(urlSuffix:String, placeholderBitmap:Bitmap) : void
      {
         this.imagePlaceholderRules.push({
            "urlEnd":urlSuffix,
            "image":placeholderBitmap
         });
      }
      
      public function setImageLoadErrorBitmap(errorBitmap:Bitmap) : void
      {
         imageLoadErrorBitmap = errorBitmap;
      }
      
      private function deliverQueuedImages() : void
      {
         clearInterval(this.imageQueueIntervalId);
         imageQueueIntervalId = -1;
         var processed:int = 0;
         var entry:Object;
         while(this.queue.length > 0)
         {
            entry = this.queue.shift();
            if(entry.onComplete != null)
            {
               if(entry.loader != null)
               {
                  entry.cachedImage.update(entry.loader);
               }
               else
               {
                  entry.cachedImage.updateImage(entry.image);
               }
               if(entry.data != null)
               {
                  entry.onComplete(entry.cachedImage,entry.data);
               }
               else
               {
                  entry.onComplete(entry.cachedImage);
               }
            }
            ++processed;
            if(processed > 3)
            {
               break;
            }
         }
         this.scheduleQueuedImageDelivery();
      }
      
      private function scheduleQueuedImageDelivery() : void
      {
         if(this.queue.length > 0)
         {
            if(this.imageQueueIntervalId < 0)
            {
               imageQueueIntervalId = TimerUtil.setInterval(this.deliverQueuedImages,10);
            }
         }
      }
      
      public function loadImage(url:String, onComplete:Function = null, callbackData:Object = null) : AvatarImage
      {
         var entry:Object = null;
         var image:AvatarImage = null;
         var index:int = 0;
         var placeholder:Object = null;
         var matchPosition:int = 0;
         var imageLoader:Loader = null;
         index = 0;
         while(index < this.imagePlaceholderRules.length)
         {
            placeholder = this.imagePlaceholderRules[index];
            matchPosition = url.indexOf(placeholder.urlEnd);
            if(matchPosition >= 0 && matchPosition == url.length - placeholder.urlEnd.length)
            {
               image = new AvatarImage(this,url);
               this.queue.push({
                  "cachedImage":image,
                  "image":placeholder.image,
                  "onComplete":onComplete,
                  "data":callbackData,
                  "obj":null
               });
               this.scheduleQueuedImageDelivery();
               return image;
            }
            index++;
         }
         entry = this.imageEntriesByUrl[url];
         if(entry != null)
         {
            if(entry.listeners != null)
            {
               image = new AvatarImage(this,url);
               image.propValue74 = entry;
               entry.listeners.push({
                  "image":image,
                  "onComplete":onComplete,
                  "data":callbackData
               });
            }
            else
            {
               image = new AvatarImage(this,url);
               image.propValue74 = entry;
               index = this.cachedImageEntries.indexOf(entry);
               this.cachedImageEntries.splice(index,1);
               this.cachedImageEntries.push(entry);
               this.queue.push({
                  "cachedImage":image,
                  "loader":entry.loader,
                  "onComplete":onComplete,
                  "data":callbackData
               });
               this.scheduleQueuedImageDelivery();
            }
         }
         else
         {
            imageLoader = new Loader();
            image = new AvatarImage(this,url);
            entry = {
               "loader":imageLoader,
               "url":url,
               "listeners":[{
                  "image":image,
                  "onComplete":onComplete,
                  "data":callbackData
               }],
               "cached":true,
               "images":new Array()
            };
            image.propValue74 = entry;
            this.imageEntriesByUrl[url] = entry;
            this.pendingImageLoads.push(entry);
            this.loadNext();
         }
         return image;
      }
      
      public function prioritizeImageLoad(url:String) : void
      {
         var entry:Object = this.imageEntriesByUrl[url];
         if(entry != null)
         {
            pendingIndex = this.pendingImageLoads.indexOf(entry);
            if(pendingIndex >= 0)
            {
               this.pendingImageLoads.splice(pendingIndex,1);
               this.pendingImageLoads.splice(0,0,entry);
            }
         }
         var index:int = 0;
         var pendingIndex:int;
         while(index < this.queue.length)
         {
            if(this.queue[index].cachedImage.url == url)
            {
               entry = this.queue[index];
               this.queue.splice(index,1);
               this.queue.splice(0,0,entry);
            }
            index++;
         }
      }
      
      private function loadNext() : void
      {
         imageFinished = function(e:Event):void
         {
            var errorImage:Bitmap;
            var i:int;
            var newDomainUrl:String;
            var dObj:Object;
            var l:Object;
            if(!(e is IOErrorEvent) && !loader.contentLoaderInfo.childAllowsParent)
            {
               newDomainUrl = getImageUrlOrigin(loader.contentLoaderInfo.url);
               if(loadCounter > 0 && domainUrl == newDomainUrl)
               {
                  ++loadCounter;
                  if(loadCounter < 50)
                  {
                     TimerUtil.setTimeout(imageFinished,100,e);
                     return;
                  }
                  failedImagePolicyDomains.push(domainUrl);
               }
               else if(domainUrl != newDomainUrl && failedImagePolicyDomains.indexOf(newDomainUrl) < 0)
               {
                  domainUrl = newDomainUrl;
                  loadCounter = 1;
                  Security.loadPolicyFile(domainUrl + "/crossdomain.xml");
                  TimerUtil.setTimeout(imageFinished,100,e);
                  return;
               }
            }
            EventListeners.removeEventListener(loader.contentLoaderInfo,Event.COMPLETE,imageFinished);
            EventListeners.removeEventListener(loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,imageFinished);
            --activeImageLoadCount;
            loadNext();
            errorImage = null;
            if(e is IOErrorEvent || !loader.contentLoaderInfo.childAllowsParent)
            {
               delete imageEntriesByUrl[obj.url];
               if(imageLoadErrorBitmap == null)
               {
                  loadNextCallback("Error on loading image: " + obj.url);
               }
               else
               {
                  errorImage = imageLoadErrorBitmap;
                  loader = null;
               }
            }
            if(cachedImageEntries.length >= maxCachedImageEntries)
            {
               dObj = cachedImageEntries[0];
               delete imageEntriesByUrl[dObj.url];
               cachedImageEntries.shift();
               dObj.cached = false;
               if(dObj.images.length == 0 && dObj.loader && dObj.loader.content)
               {
                  dObj.loader.content.bitmapData.dispose();
               }
            }
            cachedImageEntries.push(obj);
            i = 0;
            while(i < obj.listeners.length)
            {
               l = obj.listeners[i];
               try
               {
                  if(loader != null)
                  {
                     l.image.update(loader);
                  }
                  else
                  {
                     l.image.updateImage(errorImage,false);
                  }
               }
               catch(e:Error)
               {
                  if(imageLoadErrorBitmap == null)
                  {
                     loadNextCallback("Error on loading image: " + obj.url);
                  }
                  else
                  {
                     l.image.updateImage(imageLoadErrorBitmap,false);
                  }
               }
               if(l.onComplete != null)
               {
                  if(l.data != null)
                  {
                     l.onComplete(l.image,l.data);
                  }
                  else
                  {
                     l.onComplete(l.image);
                  }
               }
               i++;
            }
            delete obj.listeners;
         };
         if(this.activeImageLoadCount >= this.maxConcurrentImageLoads || this.pendingImageLoads.length == 0)
         {
            return;
         }
         var obj:Object = this.pendingImageLoads.shift();
         var loader:Loader = obj.loader;
         var loadCounter:int = 0;
         var imageUrl:String = obj.url;
         var domainUrl:String = getImageUrlOrigin(imageUrl);
         var imageFinished:Function;
         try
         {
            var context:LoaderContext = new LoaderContext();
            context.checkPolicyFile = true;
            EventListeners.addEventListener(loader.contentLoaderInfo,Event.COMPLETE,imageFinished);
            EventListeners.addEventListener(loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,imageFinished);
            loader.load(new URLRequest(imageUrl),context);
            ++this.activeImageLoadCount;
         }
         catch(e:Error)
         {
            loadNext();
         }
      }
      
      public function doAction584(avatarImage:AvatarImage) : void
      {
         var index:int = 0;
         while(index < this.queue.length)
         {
            if(this.queue[index].cachedImage == avatarImage)
            {
               this.queue.splice(index,1);
            }
            else
            {
               index++;
            }
         }
         if(this.imageQueueIntervalId != -1 && this.queue.length == 0)
         {
            clearInterval(this.imageQueueIntervalId);
            imageQueueIntervalId = -1;
         }
         var entry:Object = this.imageEntriesByUrl[avatarImage.url];
         if(entry != null)
         {
            if(entry.listeners != null)
            {
               index = 0;
               while(index < entry.listeners)
               {
                  if(entry.listeners[index].image == avatarImage)
                  {
                     entry.listeners.splice(index,1);
                  }
                  else
                  {
                     index++;
                  }
               }
            }
         }
      }
   }
}

