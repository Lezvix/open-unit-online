package ui
{
   import flash.display.Bitmap;
   import game.InventoryItem;
   
   public class IconItemSlot extends ItemSlot
   {
      
      private var icon:Bitmap;
      
      public function IconItemSlot()
      {
         super(ItemsList.STYLE_LARGE);
         this.icon = getBmp("ICON");
         this.icon.x = (width - this.icon.width) / 2;
         this.icon.y = (height - this.icon.height) / 2;
         addChild(this.icon);
      }
      
      override public function insertItem(item:InventoryItem, count:int = 1) : void
      {
         super.insertItem(item,count);
         if(contains(this.icon))
         {
            removeChild(this.icon);
         }
      }
      
      override public function removeItem() : InventoryItem
      {
         var oldItem:InventoryItem = super.removeItem();
         if(!contains(this.icon))
         {
            addChild(this.icon);
         }
         return oldItem;
      }
   }
}

