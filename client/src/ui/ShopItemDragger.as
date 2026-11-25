package ui
{
   import core.loaders.Picture;
   import core.ui.UIComponent;
   import game.ShopItem;
   
   public class ShopItemDragger extends UIComponent
   {
      
      private var shopItem:ShopItem;
      
      private var picture:Picture;
      
      private var mouseUpCallback:Function;
      
      public function ShopItemDragger()
      {
         super();
         this.picture = new Picture(null);
         addChild(this.picture);
         visible = false;
      }
      
      public function startDragItem(item:ShopItem, sourcePicture:Picture) : void
      {
         shopItem = item;
         if(this.picture === null)
         {
            this.picture.id = "icons/inv/i" + item.image + ".png";
         }
         else
         {
            this.picture.id = sourcePicture.id;
            this.picture.x = sourcePicture.x;
            this.picture.y = sourcePicture.y;
         }
         visible = true;
         startDrag();
      }
      
      public function dropItem() : ShopItem
      {
         var droppedItem:ShopItem = this.shopItem;
         shopItem = null;
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
         return this.shopItem == null;
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

