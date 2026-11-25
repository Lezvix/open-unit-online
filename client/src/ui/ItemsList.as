package ui
{
   import ui.buttons.ImageButton;
   import ui.buttons.NButton;
   import core.loaders.*;
   import core.ui.UIComponent;
   import flash.display.GradientType;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import game.InventoryItem;
   import game.Chat;
   
   public class ItemsList extends UIComponent
   {
      
      public static const NONE:int = 0;
      
      public static const NORMAL:int = 1;
      
      public static const HIGHLIGHT_RED:int = 2;
      
      public static const HIGHLIGHT_GREEN:int = 3;
      
      public static const HIGHLIGHTS:Array = [NONE,NORMAL,HIGHLIGHT_RED,HIGHLIGHT_GREEN];
      
      public static const MINI_WIDTH:int = 40;
      
      public static const LARGE_WIDTH:int = 96;
      
      public static const NORMAL_WIDTH:int = 96;
      
      public static const TEXT_WIDTH:int = 96;
      
      public static const MINI_HEIGHT:int = 26;
      
      public static const LARGE_HEIGHT:int = 60;
      
      public static const NORMAL_HEIGHT:int = 56;
      
      public static const TEXT_HEIGHT:int = 22;
      
      public static const STYLE_WIDTHS:Array = [LARGE_WIDTH,NORMAL_WIDTH,TEXT_WIDTH,MINI_WIDTH];
      
      public static const STYLE_HEIGHTS:Array = [LARGE_HEIGHT,NORMAL_HEIGHT,TEXT_HEIGHT,MINI_HEIGHT];
      
      public static const STYLE_LARGE:int = 0;
      
      public static const STYLE_NORMAL:int = 1;
      
      public static const STYLE_TEXT:int = 2;
      
      public static const STYLE_MINI:int = 3;
      
      public static const DEFAULT_STYLE:int = STYLE_NORMAL;
      
      public static const DEFAULT_HIGHLIGHT:int = NORMAL;
      
      private static const TEAR_FORMAT:TextFormat = NTextFormat.normal.right.derive({
         "size":8,
         "letterSpacing":-1
      });
      
      private static const COUNT_FORMAT:TextFormat = NTextFormat.normal.derive({
         "size":9,
         "letterSpacing":-1
      });
      
      private static const MINI_COUNT_FORMAT:TextFormat = NTextFormat.titleFormat.derive({"size":11});
      
      private static const MINI_COUNT_FILTERS:Array = [new GlowFilter(3355443,0.5,1.1,1.1,10,BitmapFilterQuality.HIGH)];
      
      private static const NAME_FORMAT:TextFormat = NTextFormat.normal.derive({
         "size":9,
         "letterSpacing":-1
      });
      
      private var slotItem:InventoryItem;
      
      private var lastSelected:int = 1;
      
      private var _highlightMode:int = 1;
      
      private var infoHandler:Function;
      
      private var repairClickHandler:Function;
      
      private var unpackHandler:Function;
      
      private var mouseDownCallback:Function;
      
      private var infoButton:NButton;
      
      private var repairButton:NButton;
      
      private var giftOpenButton:NButton;
      
      private var nameText:TextField;
      
      private var countText:TextField;
      
      private var tearText:TextField;
      
      private var picture:Picture;
      
      public function ItemsList(inventoryItem:InventoryItem, itemStyle:int = 1)
      {
         super();
         this.slotItem = inventoryItem;
         inventoryItem.addChangeListener(this.onItemChange);
         this.lastSelected = itemStyle;
      }
      
      protected function onItemChange(event:Object) : void
      {
         this.updateView();
      }
      
      public function get item() : InventoryItem
      {
         return this.slotItem;
      }
      
      public function hideInfoButton() : void
      {
         infoButtonHandler = null;
      }
      
      public function showInfoButton(handler:Function) : void
      {
         this.infoButtonHandler = handler;
      }
      
      protected function set infoButtonHandler(handler:Function) : void
      {
         if(this.infoHandler != handler)
         {
            infoHandler = handler;
            this.updateView();
         }
      }
      
      public function hideRepairButton() : void
      {
         repairButtonHandler = null;
      }
      
      public function showRepairButton(handler:Function) : void
      {
         this.repairButtonHandler = handler;
      }
      
      protected function set repairButtonHandler(handler:Function) : void
      {
         if(this.repairClickHandler != handler)
         {
            repairClickHandler = handler;
            this.updateView();
         }
      }
      
      public function hideUnpackButton() : void
      {
         unpackButtonHandler = null;
      }
      
      public function showUnpackButton(handler:Function) : void
      {
         this.unpackButtonHandler = handler;
      }
      
      protected function set unpackButtonHandler(handler:Function) : void
      {
         if(this.unpackHandler != handler)
         {
            unpackHandler = handler;
            this.updateView();
         }
      }
      
      override public function handleAddedToUITree() : void
      {
         super.handleAddedToUITree();
         this.updateView();
      }
      
      protected function updateView() : void
      {
         var url:String = null;
         var matrix:Matrix = null;
         if(addedToUITree)
         {
            if(!this.picture && this.style != STYLE_TEXT)
            {
               if(this.style == STYLE_MINI)
               {
                  url = "icons/mini/m" + this.item.image + ".png";
               }
               else
               {
                  url = "icons/" + (this.item.type == InventoryItem.TYPE_ITEM_PRESENT ? "presents/p" : "inv/i") + this.item.image + ".png";
               }
               picture = BitmapCache.getPicture1(url);
               this.picture.addEventListener(Event.COMPLETE,this.onPictureLoad);
               addChild(this.picture);
            }
            if(this.nameText == null)
            {
               nameText = new TextField();
               this.nameText.defaultTextFormat = NAME_FORMAT;
               this.nameText.height = 22;
               this.nameText.width = this.width - 12;
               this.nameText.text = this.item.itemname + " ";
               addChild(this.nameText);
            }
            if(this.item.isExpendable)
            {
               if(this.countText == null)
               {
                  countText = new TextField();
                  this.countText.text = "?";
                  this.countText.height = 22;
                  this.countText.width = this.width;
                  addChild(this.countText);
               }
               if(this.style == STYLE_MINI)
               {
                  this.countText.defaultTextFormat = MINI_COUNT_FORMAT;
                  this.countText.filters = MINI_COUNT_FILTERS;
                  this.countText.text = this.item.count.toString();
               }
               else
               {
                  this.countText.defaultTextFormat = COUNT_FORMAT;
                  this.countText.text = "x " + (this.item.count > 999 ? Chat.formatNumber(this.item.count) : this.item.count) + " ";
               }
            }
            if(this.item.hasDurability)
            {
               if(this.tearText == null)
               {
                  tearText = new TextField();
                  this.tearText.defaultTextFormat = TEAR_FORMAT;
                  this.tearText.text = "?";
                  this.tearText.height = 22;
                  this.tearText.width = this.width;
                  addChild(this.tearText);
               }
               this.tearText.text = this.item.tear + "%";
            }
            if(this.infoHandler == null)
            {
               if(this.infoButton != null)
               {
                  removeUIChild(this.infoButton);
                  infoButton = null;
               }
            }
            else if(this.infoButton == null)
            {
               infoButton = new ImageButton(this.infoHandler);
               this.infoButton.value = this.item;
               addUIChild(this.infoButton);
            }
            if(this.item.isValue39)
            {
               if(this.repairClickHandler == null || this.item.tear == 100)
               {
                  if(this.repairButton != null)
                  {
                     removeUIChild(this.repairButton);
                     repairButton = null;
                  }
               }
               else if(this.repairButton == null)
               {
                  repairButton = new NButton(this.repairClickHandler,getBmp("REPAIR_BUTTON"),getBmp("REPAIR_BUTTON_OVER"),getBmp("REPAIR_BUTTON_PRESSED"));
                  this.repairButton.value = this.item;
                  addUIChild(this.repairButton);
               }
            }
            else if(this.item.type == InventoryItem.TYPE_ITEM_PRESENT)
            {
               if(this.unpackHandler == null || this.item.params[InventoryItem.IPP_CAN_OPEN] != 1)
               {
                  if(this.giftOpenButton != null)
                  {
                     removeUIChild(this.giftOpenButton);
                     giftOpenButton = null;
                  }
               }
               else if(this.giftOpenButton == null && this.item.params[InventoryItem.IPP_CAN_OPEN] == 1)
               {
                  giftOpenButton = new NButton(this.unpackHandler,getBmp("GIFT_OPEN"),getBmp("GIFT_OPEN_OVER"),getBmp("GIFT_OPEN_PRESSED"));
                  this.giftOpenButton.value = this.item;
                  addUIChild(this.giftOpenButton);
               }
            }
            graphics.clear();
            switch(this.style)
            {
               case STYLE_LARGE:
                  if(this.highlightMode != NONE)
                  {
                     matrix = new Matrix();
                     matrix.createGradientBox(this.width,this.height - 22,Math.PI / 2);
                     if(this.highlightMode == NORMAL)
                     {
                        graphics.beginGradientFill(GradientType.LINEAR,[3092271,2236962],[1,1],[0,255],matrix);
                     }
                     else if(this.highlightMode == HIGHLIGHT_RED)
                     {
                        graphics.beginGradientFill(GradientType.LINEAR,[10435130,3092271],[1,0.5],[0,150],matrix);
                     }
                     else if(this.highlightMode == HIGHLIGHT_GREEN)
                     {
                        graphics.beginGradientFill(GradientType.LINEAR,[3245617,3092271],[1,0.5],[0,150],matrix);
                     }
                     graphics.drawRect(0,0,this.width,this.height - 22);
                     graphics.endFill();
                  }
                  graphics.beginFill(4013373);
                  graphics.drawRect(0,this.height - 22,this.width,22);
                  graphics.endFill();
                  this.nameText.visible = true;
                  this.nameText.x = 0;
                  this.nameText.y = this.height - 24;
                  if(this.tearText)
                  {
                     this.tearText.visible = true;
                     this.tearText.y = this.height - 12;
                     this.tearText.width = this.width;
                  }
                  if(this.countText)
                  {
                     this.countText.visible = true;
                     this.countText.y = this.height - 14;
                  }
                  if(this.infoButton)
                  {
                     this.infoButton.setPos(this.width - 11,this.height - 20);
                     this.infoButton.visible = true;
                  }
                  if(this.repairButton)
                  {
                     this.repairButton.setPos(this.width - 11,this.height - 10);
                     this.repairButton.visible = true;
                     if(this.tearText)
                     {
                        this.tearText.width = this.width - 11;
                     }
                  }
                  else if(this.giftOpenButton)
                  {
                     this.giftOpenButton.setPos(this.width - 11,this.height - 10);
                     this.giftOpenButton.visible = true;
                  }
                  if(this.picture)
                  {
                     this.picture.visible = true;
                     this.picture.x = (this.width - this.picture.width) / 2;
                     this.picture.y = (this.height - this.picture.height) / 2 - 7;
                  }
                  break;
               case STYLE_NORMAL:
                  graphics.beginFill(4013373);
                  graphics.drawRect(0,this.height - 16,this.width,16);
                  graphics.endFill();
                  this.nameText.visible = true;
                  this.nameText.x = 1;
                  this.nameText.y = this.height - 16;
                  this.nameText.width = this.width - this.nameText.x;
                  if(this.countText)
                  {
                     this.countText.visible = false;
                  }
                  if(this.tearText)
                  {
                     this.tearText.visible = false;
                  }
                  if(this.infoButton)
                  {
                     this.infoButton.setPos(this.width - 12,this.height - 12);
                     this.infoButton.visible = true;
                  }
                  if(this.repairButton)
                  {
                     this.repairButton.visible = false;
                  }
                  else if(this.giftOpenButton)
                  {
                     this.giftOpenButton.visible = false;
                  }
                  if(this.picture)
                  {
                     this.picture.visible = true;
                     this.picture.x = (this.width - this.picture.width) / 2;
                     this.picture.y = (this.height - this.picture.height) / 2 - 7;
                  }
                  break;
               case STYLE_MINI:
                  this.nameText.visible = false;
                  if(this.countText)
                  {
                     this.countText.visible = true;
                     this.countText.y = this.height - 16;
                  }
                  if(this.tearText)
                  {
                     this.tearText.visible = false;
                  }
                  if(this.infoButton)
                  {
                     this.infoButton.setPos(this.width - 12,this.height - 12);
                     this.infoButton.visible = false;
                  }
                  if(this.repairButton)
                  {
                     this.repairButton.visible = false;
                  }
                  else if(this.giftOpenButton)
                  {
                     this.giftOpenButton.visible = false;
                  }
                  if(this.picture)
                  {
                     this.picture.visible = true;
                     this.picture.x = (this.width - this.picture.width) / 2;
                     this.picture.y = (this.height - this.picture.height) / 2 + 2;
                  }
                  break;
               case STYLE_TEXT:
                  graphics.beginFill(4013373);
                  graphics.drawRect(0,0,this.width,this.height);
                  graphics.endFill();
                  this.nameText.visible = true;
                  this.nameText.x = 0;
                  this.nameText.y = -2;
                  if(this.countText)
                  {
                     this.countText.visible = true;
                     this.countText.y = this.height - 14;
                  }
                  if(this.tearText)
                  {
                     this.tearText.visible = true;
                     this.tearText.y = this.height - 12;
                     this.tearText.width = this.width;
                  }
                  if(this.infoButton)
                  {
                     this.infoButton.setPos(this.width - 11,2);
                     this.infoButton.visible = true;
                  }
                  if(this.repairButton)
                  {
                     this.repairButton.setPos(this.width - 11,this.height - 10);
                     this.repairButton.visible = true;
                     if(this.tearText)
                     {
                        this.tearText.width = this.width - 11;
                     }
                  }
                  else if(this.giftOpenButton)
                  {
                     this.giftOpenButton.setPos(this.width - 11,this.height - 10);
                     this.giftOpenButton.visible = true;
                  }
                  if(this.picture)
                  {
                     this.picture.visible = false;
                  }
                  break;
            }
            if(this.item.isValue1 && this.style != STYLE_MINI)
            {
               draw(getBmp("TEMPORARY_ITEM_ICON"),2,2);
            }
            width = STYLE_WIDTHS[this.style];
            height = STYLE_HEIGHTS[this.style];
         }
      }
      
      override public function dispose() : void
      {
         this.item.removeChangeListener(this.onItemChange);
         super.dispose();
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
      
      public function set style(value:int) : void
      {
         if(this.lastSelected != value)
         {
            if(value == STYLE_MINI || this.lastSelected == STYLE_MINI)
            {
               if(this.picture)
               {
                  picture = null;
               }
            }
            lastSelected = value;
            this.updateView();
         }
      }
      
      public function get highlightMode() : int
      {
         return this._highlightMode;
      }
      
      public function set highlightMode(value:int) : void
      {
         if(this._highlightMode == value || HIGHLIGHTS.indexOf(value) == -1)
         {
            return;
         }
         _highlightMode = value;
         this.updateView();
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

