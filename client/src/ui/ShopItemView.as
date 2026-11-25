package ui
{
   import ui.buttons.*;
   import core.loaders.BitmapCache;
   import core.loaders.Picture;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import game.*;
   
   public class ShopItemView extends NUIComponent
   {
      
      public static const STYLE_LARGE:int = 0;
      
      public static const STYLE_NORMAL:int = 1;
      
      public static const DEFAULT_STYLE:int = STYLE_LARGE;
      
      public static const LARGE_WIDTH:int = 284;
      
      public static const NORMAL_WIDTH:int = 202;
      
      public static const LARGE_HEIGHT:int = 62;
      
      public static const NORMAL_HEIGHT:int = 62;
      
      private static const STYLE_WIDTHS:Array = [LARGE_WIDTH,NORMAL_WIDTH];
      
      private static const STYLE_HEIGHTS:Array = [LARGE_HEIGHT,NORMAL_HEIGHT];
      
      private static const ITEM_FORMAT:NTextFormat = NTextFormat.plain.right;
      
      private static const NAME_FORMAT:NTextFormat = NTextFormat.normal.derive({
         "size":9,
         "bold":true
      });
      
      private static const DISCOUNT_FORMAT:NTextFormat = new NTextFormat({
         "size":12,
         "bold":true,
         "italic":true,
         "color":11141120
      });
      
      private static const COST_FORMAT:NTextFormat = ITEM_FORMAT.right.strong;
      
      private static const DISCOUNT_FILTERS:Array = [new GlowFilter(16777215,1,5,5,6,BitmapFilterQuality.HIGH)];
      
      private var slotItem:ShopItem;
      
      private var infoHandler:Function;
      
      private var mouseDownCallback:Function;
      
      private var picture:Picture;
      
      private var lastSelected:int = 0;
      
      public function ShopItemView(item:ShopItem, onInfo:Function, itemStyle:int = 0)
      {
         super();
         this.slotItem = item;
         this.lastSelected = itemStyle;
         this.infoHandler = onInfo;
      }
      
      public function get shopitem() : ShopItem
      {
         return this.slotItem;
      }
      
      override public function handleAddedToUITree() : void
      {
         super.handleAddedToUITree();
         this.updateView();
      }
      
      protected function updateView() : void
      {
         var matrix:Matrix;
         var textField:TextField;
         if(addedToUITree)
         {
            if(!this.picture)
            {
               var url:String = "icons/inv/i" + this.shopitem.image + ".png";
               picture = BitmapCache.getPicture1(url);
               this.picture.addEventListener(Event.COMPLETE,this.onPictureLoad);
               this.picture.x = 3;
               addChild(this.picture);
               if(this.shopitem.filterGroup == ShopItem.PAY_FILTER_COUNT && this.shopitem.discount > 0)
               {
                  textField = new TextField();
                  textField.defaultTextFormat = DISCOUNT_FORMAT;
                  textField.text = "-" + this.shopitem.discount + "%";
                  textField.width = textField.textWidth + 5;
                  textField.height = textField.textHeight + 5;
                  textField.filters = DISCOUNT_FILTERS;
                  var discountBmp:Bitmap = new Bitmap(new BitmapData(textField.width + 10,textField.height + 10,true,0));
                  var discountMatrix:Matrix = new Matrix(1,0,0,1,0,4);
                  discountBmp.smoothing = true;
                  discountBmp.bitmapData.draw(textField,discountMatrix);
                  discountBmp.rotation = 35;
                  discountBmp.x = this.picture.x + 50;
                  discountBmp.y = this.picture.y - 8;
                  addChild(discountBmp);
               }
               textField = new TextField();
               textField.defaultTextFormat = NAME_FORMAT;
               textField.text = this.shopitem.name;
               textField.height = 15;
               textField.width = this.width;
               textField.x = 1;
               textField.y = this.height - 16;
               addChild(textField);
               if(this.style != STYLE_NORMAL)
               {
                  textField = new TextField();
                  textField.defaultTextFormat = COST_FORMAT;
                  textField.text = _("IDS_CREDS_COST",this.shopitem.cost);
                  textField.height = 16;
                  textField.y = this.height - 16;
                  textField.width = this.width;
                  addChild(textField);
                  var items:Vector.<InventoryItem> = this.shopitem.items;
                  var i:int = items.length - 1;
                  while(i >= 0)
                  {
                     textField = new TextField();
                     textField.defaultTextFormat = ITEM_FORMAT;
                     textField.height = 16;
                     textField.width = this.width - 10;
                     textField.text = items[i].itemname;
                     if(items[i].isExpendable && items[i].count > 1)
                     {
                        textField.appendText(" - " + items[i].count + _("IDS_COUNT_SHORT"));
                     }
                     textField.y = this.height - 11 * (items.length - i) - 20;
                     addChild(textField);
                     var infoButton:NButton = new ImageButton(this.infoHandler);
                     infoButton.value = items[i];
                     infoButton.setPos(this.width - 11,textField.y + 4);
                     addUIChild(infoButton);
                     i--;
                  }
               }
            }
            this.picture.y = (this.height - this.picture.height) / 2 - 7;
            graphics.clear();
            graphics.beginFill(4013373);
            graphics.drawRect(0,this.height - 15,this.width,15);
            graphics.endFill();
            matrix = new Matrix();
            matrix.createGradientBox(this.width / 2,this.height / 2,Math.PI / 2);
            graphics.beginGradientFill(GradientType.LINEAR,[3092271,2236962],[1,1],[0,255],matrix);
            graphics.drawRect(0,0,this.width,this.height - 15);
            graphics.endFill();
            width = STYLE_WIDTHS[this.style];
            height = STYLE_HEIGHTS[this.style];
         }
      }
      
      private function onPictureLoad(event:Event) : void
      {
         if(this.picture)
         {
            this.picture.removeEventListener(Event.COMPLETE,this.onPictureLoad);
         }
         this.updateView();
      }
      
      override public function get height() : Number
      {
         return STYLE_HEIGHTS[this.style];
      }
      
      override public function get width() : Number
      {
         return STYLE_WIDTHS[this.style];
      }
      
      public function get style() : int
      {
         return this.lastSelected;
      }
      
      public function get image() : Picture
      {
         return this.picture;
      }
      
      public function set mouseDown(handler:Function) : void
      {
         mouseDownCallback = handler;
      }
      
      override public function mouseDownHandler() : void
      {
         this.mouseDownCallback == null ? super.mouseDownHandler() : this.mouseDownCallback(this);
      }
   }
}

