package ui.buttons
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import ui.NTextFormat;
   
   public class QuickSlotButton extends NButton
   {
      
      public static const WIDTH:int = 50;
      
      public static const HEIGHT:int = 31;
      
      protected static const colorHighlighted:ColorTransform = new ColorTransform(1.3,1.3,1.3);
      
      protected static const colorNormal:ColorTransform = new ColorTransform();
      
      protected static const COUNT_FILTERS:Array = [new GlowFilter(3355443,0.5,1.1,1.1,10,BitmapFilterQuality.HIGH)];
      
      private var _loader:Loader = new Loader();
      
      private var countText:TextField = new TextField();
      
      private var _itemname:String = "";
      
      private var image:int = 0;
      
      private var count:int = 1;
      
      private var _index:int;
      
      public function QuickSlotButton(slotIndex:int, clickHandler:Function)
      {
         this._index = slotIndex;
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onContentLoaderInfoComplete);
         var sprite:Sprite = new Sprite();
         sprite.graphics.drawRect(0,0,WIDTH,HEIGHT);
         sprite.width = WIDTH;
         sprite.height = HEIGHT;
         sprite.addChild(this.loader);
         this.countText.defaultTextFormat = NTextFormat.titleFormat.derive({
            "size":11,
            "color":16765023
         });
         this.countText.width = WIDTH;
         this.countText.text = this.count.toString();
         this.countText.height = this.countText.textHeight + 6;
         this.countText.y = HEIGHT - this.countText.height;
         this.countText.filters = COUNT_FILTERS;
         sprite.addChild(this.countText);
         super(clickHandler,sprite);
         visible = false;
      }
      
      public function get loader() : Loader
      {
         return this._loader;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function update(imageId:int, itemName:String, itemCount:int) : void
      {
         if(imageId == 0 || itemCount == 0)
         {
            visible = false;
         }
         else
         {
            if(this.image != imageId)
            {
               this.image = imageId;
               this.loader.unload();
               this.loader.load(new URLRequest("icons/mini/m" + imageId + ".png"));
            }
            if(this.count != itemCount)
            {
               this.count = itemCount;
               this.countText.text = itemCount.toString();
            }
            _itemname = itemName;
            visible = true;
         }
      }
      
      public function get imageId() : int
      {
         return this.image;
      }
      
      public function get itemname() : String
      {
         return this._itemname;
      }
      
      public function decreaseCount() : void
      {
         this.update(this.image,this._itemname,this.count - 1);
      }
      
      protected function onContentLoaderInfoComplete(event:Event) : void
      {
         this.loader.x = (WIDTH - this.loader.width) / 2;
         this.loader.y = (HEIGHT - this.loader.height) / 2;
      }
      
      override public function mouseOverHandler() : void
      {
         this.loader.transform.colorTransform = colorHighlighted;
         super.mouseOverHandler();
      }
      
      override public function mouseOutHandler() : void
      {
         this.loader.transform.colorTransform = colorNormal;
         super.mouseOutHandler();
      }
   }
}

