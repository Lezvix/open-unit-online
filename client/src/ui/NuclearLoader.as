package ui
{
   import core.ui.UIComponent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import game.Chat;
   
   public class NuclearLoader extends UIComponent
   {
      
      protected var item:RecipeSlot;
      
      protected var image:DisplayObject;
      
      protected var mouseUpCallback:Function;
      
      public function NuclearLoader()
      {
         super();
      }
      
      public function startDragItem(slot:RecipeSlot) : void
      {
         var loader:Loader = null;
         var upgradeIcon:Bitmap = null;
         this.clearImage();
         this.item = slot;
         if(slot.recipeData.type == 0)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,Chat.doAction936);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoad);
            loader.load(new URLRequest("icons/inv/i" + slot.recipeData.product.item.image + ".png"));
            image = loader;
         }
         else
         {
            upgradeIcon = getBmp("FACTORY_UPGRADE_" + slot.recipeData.upgrade.type);
            upgradeIcon.x = (96 - upgradeIcon.width) / 2;
            upgradeIcon.y = (56 - upgradeIcon.height) / 2;
            image = upgradeIcon;
         }
         addChild(this.image);
         visible = true;
         startDrag();
      }
      
      private function onIconLoad(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onIconLoad);
         event.target.loader.x = (96 - event.target.loader.width) / 2;
         event.target.loader.y = (56 - event.target.loader.height) / 2 - 6;
      }
      
      public function dropItem() : RecipeSlot
      {
         var slot:RecipeSlot;
         this.clearImage();
         slot = this.item;
         item = null;
         visible = false;
         stopDrag();
         return slot;
      }
      
      protected function clearImage() : void
      {
         if(this.image)
         {
            removeChild(this.image);
            if(this.image is Bitmap)
            {
               (this.image as Bitmap).bitmapData.dispose();
            }
            else if(this.image is Loader)
            {
               (this.image as Loader).unload();
            }
            image = null;
         }
         removeChildren();
      }
      
      override public function get cursorId() : int
      {
         return GameCursor.CURSOR_2;
      }
      
      override public function dispose() : void
      {
         this.clearImage();
         super.dispose();
      }
      
      public function get isActive() : Boolean
      {
         return this.item == null;
      }
      
      public function set dropHandler(handler:Function) : void
      {
         mouseUpCallback = handler;
      }
      
      override public function mouseUpHandler() : void
      {
         this.mouseUpCallback == null ? super.mouseUpHandler() : this.mouseUpCallback(this);
      }
   }
}

