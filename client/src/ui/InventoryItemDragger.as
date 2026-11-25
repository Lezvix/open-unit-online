package ui
{
   import core.loaders.Picture;
   import core.ui.UIComponent;
   import game.InventoryItem;
   
   public class InventoryItemDragger extends UIComponent
   {
      
      protected var item:InventoryItem;
      
      protected var image:Picture;
      
      protected var mouseUpCallback:Function;
      
      public function InventoryItemDragger()
      {
         super();
         this.image = new Picture(null);
         addChild(this.image);
         visible = false;
      }
      
      public function startDragItem(inventoryItem:InventoryItem, picture:Picture) : void
      {
         this.item = inventoryItem;
         if(picture === null)
         {
            this.image.id = "icons/" + (inventoryItem.type == InventoryItem.TYPE_ITEM_PRESENT ? "presents/p" : "inv/i") + inventoryItem.image + ".png";
         }
         else
         {
            this.image.id = picture.id;
            this.image.x = picture.x;
            this.image.y = picture.y;
         }
         visible = true;
         startDrag();
      }
      
      public function dropItem() : InventoryItem
      {
         var droppedItem:InventoryItem = this.item;
         item = null;
         visible = false;
         stopDrag();
         return droppedItem;
      }
      
      override public function get cursorId() : int
      {
         return GameCursor.CURSOR_2;
      }
      
      public function get isActive() : Boolean
      {
         return this.item === null;
      }
      
      public function set dropHandler(handler:Function) : void
      {
         mouseUpCallback = handler;
      }
      
      override public function mouseUpHandler() : void
      {
         this.mouseUpCallback === null ? super.mouseUpHandler() : this.mouseUpCallback(this);
      }
   }
}

