package ui.menus
{
   import ui.buttons.NButton;
   import net.GameSocket;
   import core.ui.BaseButton;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import game.InventoryItem;
   import ui.ItemSlot;
   import ui.ItemInfo;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class PrintMenu extends TitledMenu
   {
      
      private const WIDTH:int = 600;
      
      private const HEIGHT:int = 370;
      
      private const TARGET_X:int = 142;
      
      private const TARGET_Y:int = 80;
      
      private const TARGET_W:int = 96;
      
      private const TARGET_H:int = 56;
      
      private const TARGET_INFO_WINDOW_X:int = 247.0;
      
      private const TARGET_INFO_WINDOW_Y:int = 126.0;
      
      private var itemsToRename:Vector.<InventoryItem>;
      
      private var currentItem:int = 2147483647;
      
      private var infoMenu:ItemInfo;
      
      private var newNameInput:NTextInput;
      
      private var noItemsMessage:TextField;
      
      private var noItemsBmp:Bitmap;
      
      private var sendRenameRequestButton:BaseButton;
      
      private var targetSlot:ItemSlot;
      
      public function PrintMenu(fields:Array)
      {
         super(TYPE_PRINT,_("IDS_PRINT_MENU"),this.WIDTH,this.HEIGHT);
         drawWindowBg();
         var button:NButton = new NButton(this.nextUpgradeHandler,getBmp("NEXT_ARROW_BUTTON"),getBmp("NEXT_ARROW_BUTTON_OVER"),getBmp("NEXT_ARROW_BUTTON_PRESS"));
         button.setPos(this.TARGET_X + this.TARGET_W + 6,this.TARGET_Y + (this.TARGET_H - 29) / 2);
         addUIChild(button);
         this.targetSlot = new ItemSlot();
         this.targetSlot.setPos(this.TARGET_X,this.TARGET_Y);
         this.targetSlot.showInfoButton(this.infoShow);
         addUIChild(this.targetSlot);
         button = new NButton(this.prevUpgradeHandler,getBmp("PREV_ARROW_BUTTON"),getBmp("PREV_ARROW_BUTTON_OVER"),getBmp("PREV_ARROW_BUTTON_PRESS"));
         button.setPos(this.TARGET_X - 29,this.TARGET_Y + (this.TARGET_H - 29) / 2);
         addUIChild(button);
         addTextLabel(42,this.TARGET_Y + 70,_("IDS_ENTER_NEW_NAME"),NTextFormat.titleFormat.propValue12,300);
         this.newNameInput = new NTextInput(32,NTextFormat.input.derive({
            "size":12,
            "align":TextFormatAlign.CENTER
         }));
         this.newNameInput.setPos(42,this.TARGET_Y + 92);
         this.newNameInput.width = 300;
         this.newNameInput.restrict = "a-z A-Zа-яА-ЯёЁ0-9\\-";
         addUIChild(this.newNameInput);
         drawWindow(_("IDS_INFORMATION"),this.WIDTH - 226,43,206,this.HEIGHT - 93);
         this.sendRenameRequestButton = createButton(this.WIDTH - 228,this.HEIGHT - 42,_("IDS_TO_RENAME"),this.renameClickHandler);
         this.sendRenameRequestButton.x = this.WIDTH - 124 - this.sendRenameRequestButton.width;
         addUIChild(this.sendRenameRequestButton);
         addButton(this.WIDTH - 119,this.HEIGHT - 42,_("IDS_TO_CLOSE"),onCloseClick);
         addText(50,this.newNameInput.y + 32,_("IDS_RENAME_RESTRICTIONS"),NTextFormat.normal,300);
         addText(this.WIDTH - 221,66,_("IDS_RENAME_DESCRIPTION"),NTextFormat.normal,196);
         this.noItemsBmp = getBmp("BRAKE_ACTIVE");
         this.noItemsBmp.x = 21;
         this.noItemsBmp.y = this.HEIGHT - 33;
         addChild(this.noItemsBmp);
         this.noItemsMessage = createLabel(38,this.HEIGHT - 34,"#",NTextFormat.plain,330);
         addChild(this.noItemsMessage);
         this.infoMenu = new ItemInfo();
         addUIChild(this.infoMenu);
         this.parseData(fields);
      }
      
      protected function renameClickHandler(sender:Object) : void
      {
         var item:InventoryItem = null;
         if(this.newNameInput.text)
         {
            item = this.itemsToRename[this.currentItem];
            GameSocket.socket.doAction167(item.inventoryId,this.newNameInput.text);
            this.sendRenameRequestButton.enabled = false;
         }
      }
      
      public function parseData(fields:Array) : void
      {
         var offset:int = 2;
         var itemCount:int = fields[offset++];
         itemsToRename = new Vector.<InventoryItem>();
         var i:int = 0;
         var itemLength:int;
         while(i < itemCount)
         {
            itemLength = fields[offset];
            this.itemsToRename.push(new InventoryItem(fields.slice(offset,offset + itemLength)));
            offset += itemLength;
            i++;
         }
         this.updateCurrentItem(this.currentItem);
      }
      
      private function updateCurrentItem(index:int) : void
      {
         if(index < 0)
         {
            index = this.itemsToRename.length - 1;
         }
         else if(index >= this.itemsToRename.length)
         {
            index = 0;
         }
         if(!this.targetSlot.isActive)
         {
            this.targetSlot.removeItem();
         }
         currentItem = index;
         this.newNameInput.text = "";
         this.noItemsMessage.text = "";
         if(this.itemsToRename.length == 0)
         {
            this.noItemsBmp.visible = true;
            this.noItemsMessage.text = _("IDS_NO_ITEMS_TO_RENAME");
            this.noItemsMessage.visible = true;
            this.sendRenameRequestButton.enabled = false;
            if(this.infoMenu.visible)
            {
               removeUIChild(this.infoMenu);
            }
            return;
         }
         var item:InventoryItem = this.itemsToRename[this.currentItem];
         this.sendRenameRequestButton.enabled = true;
         this.noItemsBmp.visible = false;
         this.newNameInput.maxChars = item.itemname.charAt(0) == "+" ? 31 : 32;
         this.targetSlot.insertItem(item);
         if(this.infoMenu.visible)
         {
            this.infoMenu.targetItem = item;
            this.infoMenu.create(this.infoMenu.x,this.infoMenu.y);
         }
      }
      
      protected function nextUpgradeHandler(sender:Object) : void
      {
         this.updateCurrentItem(this.currentItem + 1);
      }
      
      protected function prevUpgradeHandler(sender:Object) : void
      {
         this.updateCurrentItem(this.currentItem - 1);
      }
      
      protected function infoShow(button:NButton) : void
      {
         var item:InventoryItem = button.value as InventoryItem;
         if(this.infoMenu.visible)
         {
            this.infoMenu.close();
         }
         else
         {
            this.infoMenu.targetItem = item;
            this.infoMenu.create(this.TARGET_INFO_WINDOW_X,this.TARGET_INFO_WINDOW_Y);
         }
      }
   }
}

