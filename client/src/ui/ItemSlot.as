package ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import game.InventoryItem;
   
   public class ItemSlot extends NUIComponent
   {
      
      [Embed(source="/assets/ItemSlot_IMG_2.png")]
      
      private static const IMG_2:Class;
      
      [Embed(source="/assets/ItemSlot_IMG_27.png")]
      
      private static const IMG_27:Class;
      
      protected static const SLOT_BG:Bitmap = new IMG_2();
      
      protected static const SLOT_BG_LARGE:Bitmap = new IMG_27();
      
      public static const DEFAULT_STYLE:int = ItemsList.STYLE_NORMAL;
      
      private static const COUNT_FILTERS:Array = [new GlowFilter(1776411,0.5,1.1,1.1,15,BitmapFilterQuality.HIGH)];
      
      protected var style:int;
      
      protected var slotItem:InventoryItem;
      
      protected var itemView:ItemsList;
      
      private var infoHandler:Function;
      
      private var mouseDownCallback:Function;
      
      private var countText:TextField;
      
      public function ItemSlot(slotStyle:int = 1)
      {
         super();
         this.style = slotStyle;
         graphics.clear();
         graphics.beginBitmapFill(ItemsList.STYLE_HEIGHTS[slotStyle] > SLOT_BG.height ? SLOT_BG_LARGE.bitmapData : SLOT_BG.bitmapData);
         graphics.drawRect(0,0,ItemsList.STYLE_WIDTHS[slotStyle],ItemsList.STYLE_HEIGHTS[slotStyle]);
         graphics.endFill();
         width = ItemsList.STYLE_WIDTHS[slotStyle];
         height = ItemsList.STYLE_HEIGHTS[slotStyle];
      }
      
      public function get item() : InventoryItem
      {
         return this.slotItem;
      }
      
      public function get isActive() : Boolean
      {
         return this.item == null;
      }
      
      public function insertItem(item:InventoryItem, count:int = 1) : void
      {
         this.removeItem();
         slotItem = item;
         itemView = new ItemsList(item,this.style);
         if(this.infoHandler != null)
         {
            this.itemView.showInfoButton(this.infoHandler);
         }
         if(this.mouseDownCallback != null)
         {
            this.itemView.mouseDown = this.mouseDownCallback;
         }
         addUIChild(this.itemView);
         if(count > 1)
         {
            if(!this.countText)
            {
               countText = new TextField();
               this.countText.defaultTextFormat = NTextFormat.normal;
               this.countText.x = 2;
               addChild(this.countText);
            }
            this.countText.text = "x" + count;
            this.countText.visible = true;
            this.countText.filters = COUNT_FILTERS;
            setChildIndex(this.itemView,0);
         }
         else if(this.countText)
         {
            this.countText.visible = false;
         }
      }
      
      public function removeItem() : InventoryItem
      {
         var oldItem:InventoryItem = this.slotItem;
         if(this.itemView)
         {
            removeUIChild(this.itemView);
            slotItem = null;
            itemView = null;
         }
         return oldItem;
      }
      
      public function replaceItem(item:InventoryItem) : InventoryItem
      {
         var oldItem:InventoryItem = this.slotItem;
         this.insertItem(item);
         return oldItem;
      }
      
      public function hideInfoButton() : void
      {
         if(this.itemView)
         {
            this.itemView.hideInfoButton();
         }
         infoHandler = null;
      }
      
      public function showInfoButton(handler:Function) : void
      {
         if(this.infoHandler != handler)
         {
            if(this.itemView)
            {
               this.itemView.showInfoButton(handler);
            }
            infoHandler = handler;
         }
      }
      
      public function set mouseDown(handler:Function) : void
      {
         if(this.itemView)
         {
            this.itemView.mouseDown = this.mouseDownCallback;
         }
         mouseDownCallback = handler;
      }
   }
}

