package game
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class AdvertItem extends Sprite
   {
      
      public var imageUrl:String;
      
      public var url:String;
      
      public var isHighlight:Boolean = false;
      
      private var loader:Loader = new Loader();
      
      public function AdvertItem(param1:String, param2:String)
      {
         super();
         this.imageUrl = param1;
         this.url = param2;
         var request:URLRequest = new URLRequest("icons/adv/" + param1);
         this.loader.addEventListener(Event.COMPLETE,this.completeHandler);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.completeHandler);
         this.loader.load(request);
         addChild(this.loader);
      }
      
      public function load() : void
      {
      }
      
      private function completeHandler(param1:Event) : void
      {
         this.loader.removeEventListener(Event.COMPLETE,this.completeHandler);
         this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.completeHandler);
      }
      
      public function processUrl() : void
      {
         var request:URLRequest = new URLRequest(this.url);
         navigateToURL(request,"_blank");
      }
      
      public function free() : void
      {
      }
      
      public function isSelected(param1:int, param2:int) : Boolean
      {
         if(this.loader.content == null)
         {
            return false;
         }
         var bitmap:Bitmap = Bitmap(this.loader.content);
         var pixelAlpha:int = bitmap.bitmapData.getPixel32(param1,param2) >> 24 & 0xFF;
         if(pixelAlpha > 0)
         {
            return true;
         }
         return false;
      }
      
      public function setHighlight(param1:Boolean) : void
      {
         var colorMatrix:Array = null;
         var filter:ColorMatrixFilter = null;
         var filtersList:Array = null;
         if(this.isHighlight != param1)
         {
            isHighlight = param1;
            if(this.isHighlight)
            {
               colorMatrix = new Array();
               colorMatrix = colorMatrix.concat([2,0,0,0,0]);
               colorMatrix = colorMatrix.concat([0,2,0,0,0]);
               colorMatrix = colorMatrix.concat([0,0,2,0,0]);
               colorMatrix = colorMatrix.concat([0,0,0,1,0]);
               filter = new ColorMatrixFilter(colorMatrix);
               filtersList = new Array();
               filtersList.push(filter);
               this.loader.content.filters = filtersList;
            }
            else
            {
               this.loader.content.filters = new Array();
            }
         }
      }
   }
}

