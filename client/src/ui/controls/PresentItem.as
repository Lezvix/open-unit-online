package ui.controls
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class PresentItem
   {
      
      public static const PT_DEFAULT:int = 0;
      
      public static const PT_NO_DELETE:int = 1;
      
      public static const PT_ITEM_PRESENT:int = 2;
      
      public static const PT_ITEM_3:int = 3;
      
      public var presentText:String;
      
      public var presentId:int;
      
      public var image:int;
      
      public var type:int;
      
      public var loaderSprite:Sprite;
      
      public var loader:Loader = new Loader();
      
      public function PresentItem(id:int, presentType:int, imageId:int, str:String, iconPath:String = "presents/p")
      {
         super();
         this.type = presentType;
         this.presentId = id;
         this.image = imageId;
         this.presentText = str;
         this.loaderSprite = new Sprite();
         this.loaderSprite.x = 49;
         this.loaderSprite.y = 30;
         var request:URLRequest = new URLRequest("icons/" + iconPath + this.image + ".png");
         this.loader.load(request);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoad);
         this.loaderSprite.addChild(this.loader);
      }
      
      private function onLoad(event:Event) : void
      {
         this.loader.x -= int(this.loader.width / 2);
         this.loader.y -= int(this.loader.height / 2);
      }
      
      public function clone() : PresentItem
      {
         var copy:PresentItem = new PresentItem(this.presentId,this.type,this.image,this.presentText);
         return copy;
      }
      
      public function dispose() : void
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad);
         if(this.loader.content)
         {
            Bitmap(this.loader.content).bitmapData.dispose();
         }
      }
      
      public function startDrag(container:Sprite) : void
      {
         container.addChild(this.loaderSprite);
         this.loaderSprite.startDrag();
      }
      
      public function stopDrag() : void
      {
         this.loaderSprite.stopDrag();
         this.loaderSprite.x = 49;
         this.loaderSprite.y = 30;
      }
   }
}

