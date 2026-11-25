package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.InventoryItem;
   import game.Chat;
   import ui.*;
   
   public class Barter extends NuclearSprite
   {
      
      private static const LEFT_PANEL_WIDTH:int = 160;
      
      private static const RIGHT_PANEL_WIDTH:int = 574;
      
      private var opponentGrid:ItemsGrid;
      
      private var userOfferGrid:ItemsGrid;
      
      private var inventoryGrid:ItemsGrid;
      
      private var filterButtons:Vector.<FilterButton> = new Vector.<FilterButton>(InventoryItem.TRAUM_8);
      
      private var itemInfoMenu:ItemInfo;
      
      private var dragger:InventoryItemDragger = new InventoryItemDragger();
      
      private var playerPricetext:TextField;
      
      private var botName:TextField;
      
      private var barterText:TextField;
      
      private var _barterEndTime:int = 0;
      
      private var _barterInterval:int = -1;
      
      private var weightButton:WeightButton;
      
      public function Barter(params:Object)
      {
         var fields:Array;
         super(TYPE_BARTER);
         fields = params.data;
         w = LEFT_PANEL_WIDTH + RIGHT_PANEL_WIDTH + 1;
         h = 370;
         fillBg(4,4,LEFT_PANEL_WIDTH - 8,h - 8);
         fillBg(LEFT_PANEL_WIDTH + 5,4,RIGHT_PANEL_WIDTH - 8,h - 8);
         drawTitleBar(12,h - 50,LEFT_PANEL_WIDTH - 20);
         addTextLabel(16,h - 46,_("IDS_COST_EXAMINATION"),NTextFormat.normal.center,LEFT_PANEL_WIDTH - 28);
         this.playerPricetext = createLabel(16,h - 33,"0",NTextFormat.normal.center,LEFT_PANEL_WIDTH - 28);
         addChild(this.playerPricetext);
         drawTitleBar(12,10,LEFT_PANEL_WIDTH - 20,fields[6] + "[" + fields[7] + "]",NTextFormat.normal.center);
         drawTitleBar(LEFT_PANEL_WIDTH + 13,10,LEFT_PANEL_WIDTH - 20,Main.UserCharacter.name + "[" + Main.UserCharacter.level + "]",NTextFormat.normal.center);
         drawTitleBar(LEFT_PANEL_WIDTH + 13,h - 50,LEFT_PANEL_WIDTH - 20);
         addTextLabel(LEFT_PANEL_WIDTH + 17,h - 46,_("IDS_COST_EXAMINATION"),NTextFormat.normal.center,LEFT_PANEL_WIDTH - 28);
         this.botName = createLabel(LEFT_PANEL_WIDTH + 17,h - 33,"0",NTextFormat.normal.center,LEFT_PANEL_WIDTH - 28);
         addChild(this.botName);
         drawTitleBar(2 * LEFT_PANEL_WIDTH - 8,h - 50,RIGHT_PANEL_WIDTH - LEFT_PANEL_WIDTH);
         this.barterText = createLabel(2 * LEFT_PANEL_WIDTH - 8,h - 38,_("IDS_BARTER"),NTextFormat.normal.center,RIGHT_PANEL_WIDTH - LEFT_PANEL_WIDTH);
         addChild(this.barterText);
         drawFrame(0,0,LEFT_PANEL_WIDTH,h);
         drawFrame(LEFT_PANEL_WIDTH + 1,0,RIGHT_PANEL_WIDTH,h);
         fillBg(LEFT_PANEL_WIDTH - 22,70,44,228);
         draw(getBmp("SETKA"),LEFT_PANEL_WIDTH - 20,77);
         draw(getBmp("BARTER_RAMKA_1"),LEFT_PANEL_WIDTH - 10,70);
         draw(getBmp("BARTER_RAMKA_2"),LEFT_PANEL_WIDTH - 10,286);
         drawHSeparator(9,h - 64,LEFT_PANEL_WIDTH - 15);
         drawHSeparator(LEFT_PANEL_WIDTH + 10,h - 64,RIGHT_PANEL_WIDTH - 15);
         width = w;
         height = h;
         var inventoryX:int = LEFT_PANEL_WIDTH * 2 - 7;
         draw(getBmp("BUTTON_BG"),inventoryX,12);
         this.inventoryGrid = new ItemsGrid(245);
         this.inventoryGrid.setPos(inventoryX + 4,56);
         this.inventoryGrid.doAction808(this.onInfoClick);
         this.inventoryGrid.propValue49 = this.onShopItemSelect;
         this.opponentGrid = new ItemsGrid(245,1);
         this.opponentGrid.setPos(21,56);
         this.opponentGrid.doAction808(this.onInfoClick);
         addUIChild(this.opponentGrid);
         this.userOfferGrid = new ItemsGrid(245,1);
         this.userOfferGrid.setPos(191,56);
         this.userOfferGrid.doAction808(this.onInfoClick);
         this.userOfferGrid.propValue49 = this.onOfferItemSelect;
         addUIChild(this.userOfferGrid);
         var filterPanel:InventoryFilterPanel = new InventoryFilterPanel(this.inventoryGrid,InventoryFilterPanel.HORIZONTAL);
         filterPanel.setPos(inventoryX + 14,11);
         addUIChild(filterPanel);
         var button:NButton = new NButton(onCloseClick,getBmp("INV_CLOSE_BUTTON"),getBmp("INV_CLOSE_BUTTON_OVER"),getBmp("INV_CLOSE_BUTTON_PRESSED"));
         button.setPos(w - 49,11);
         addUIChild(button);
         button = new NButton(this.onBGraphicsClick,getBmp("B_GRAPHICS"),getBmp("B_GRAPHICS_OVER"),getBmp("B_GRAPHICS_PRESSED"));
         button.setPos(w - 49,28);
         addUIChild(button);
         var offset:int = 8;
         var itemLength:int;
         while(offset < fields.length - 1)
         {
            itemLength = fields[offset];
            this.inventoryGrid.addItem(new InventoryItem(fields.slice(offset,offset + itemLength)));
            offset += itemLength;
         }
         this.inventoryGrid.selectHandler = Chat.getInt45;
         addUIChild(this.inventoryGrid);
         addButton(inventoryX + 6,h - 42,_("IDS_APPLY"),this.confirmHandler);
         addButton(w - 120,h - 42,_("IDS_REJECT"),onCloseClick);
         this.opponentGrid.addChangeListener(this.onGridChange);
         this.userOfferGrid.addChangeListener(this.onGridChange);
         this.itemInfoMenu = new ItemInfo();
         addUIChild(this.itemInfoMenu);
         this.dragger.dropHandler = this.onShopItemDrop;
         addUIChild(this.dragger);
         this.weightButton = new WeightButton(Main.UserCharacter.CurrentWeight,Main.UserCharacter.MaxWeight,120,true);
         this.weightButton.setPos(w - 117,h - 64);
         addUIChild(this.weightButton);
      }
      
      protected function onGridChange(event:Object) : void
      {
         if(event.property == "itemsPrice")
         {
            this.playerPricetext.text = Chat.formatNumber(this.opponentGrid.propValue107);
            this.botName.text = Chat.formatNumber(this.userOfferGrid.propValue107);
         }
         else if(event.property == "itemsWeight")
         {
            this.weightButton.current = Main.UserCharacter.CurrentWeight + this.opponentGrid.itemsWeight - this.userOfferGrid.itemsWeight;
         }
      }
      
      protected function onBGraphicsClick(sender:Object) : void
      {
         this.opponentGrid.style = this.userOfferGrid.style = this.inventoryGrid.style = this.inventoryGrid.style == ItemsList.STYLE_LARGE ? ItemsList.STYLE_TEXT : ItemsList.STYLE_LARGE;
      }
      
      protected function onInfoClick(button:NButton) : void
      {
         var item:InventoryItem = button.value as InventoryItem;
         if(this.itemInfoMenu.visible)
         {
            if(this.itemInfoMenu.targetItem == item)
            {
               this.itemInfoMenu.close();
            }
            else
            {
               this.itemInfoMenu.close();
               this.itemInfoMenu.targetItem = item;
               this.itemInfoMenu.create();
            }
         }
         else
         {
            this.itemInfoMenu.targetItem = item;
            this.itemInfoMenu.create();
         }
      }
      
      protected function onShopItemSelect(listItem:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(listItem.item,listItem.image);
            this.dragger.setPos(this.inventoryGrid.x + listItem.x,this.inventoryGrid.y + listItem.y - this.inventoryGrid.scrollV);
            this.inventoryGrid.removeItem(listItem.item);
         }
      }
      
      protected function onOfferItemSelect(listItem:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(listItem.item,listItem.image);
            this.dragger.setPos(this.userOfferGrid.x + listItem.x,this.userOfferGrid.y + listItem.y - this.userOfferGrid.scrollV);
            this.userOfferGrid.removeItem(listItem.item);
         }
      }
      
      protected function onShopItemDrop(itemDragger:InventoryItemDragger) : void
      {
         var item:InventoryItem = null;
         if(!itemDragger.isActive)
         {
            item = itemDragger.dropItem();
            if(this.userOfferGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  this.userOfferGrid.addItem(item);
               }
               else if(item.isExpendable && item.count > 1)
               {
                  showModal(new CountMenu(item,this.onOfferCountSelect,this.onOfferCountCancel));
               }
               else if(item.isArt)
               {
                  this.returnItem(item);
               }
               else
               {
                  this.addHandler(item);
                  this.sendItemAdd(item);
               }
            }
            else if(this.inventoryGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  if(item.isExpendable && item.count > 1)
                  {
                     showModal(new CountMenu(item,this.onReturnCountSelect,this.onReturnCountCancel));
                  }
                  else
                  {
                     this.returnItem(item);
                     this.sendItemRemove(item);
                  }
               }
               else
               {
                  this.inventoryGrid.addItem(item);
               }
            }
            else if(item.questItem)
            {
               this.userOfferGrid.addItem(item);
            }
            else
            {
               this.inventoryGrid.addItem(item);
            }
         }
      }
      
      protected function sendItemAdd(item:InventoryItem) : void
      {
         barterEndTime = 0;
         ++GameSocket.socket.barterOpId;
         GameSocket.socket.doAction365(item.inventoryId,item.count);
      }
      
      protected function sendItemRemove(item:InventoryItem) : void
      {
         barterEndTime = 0;
         ++GameSocket.socket.barterOpId;
         GameSocket.socket.doAction518(item.inventoryId,item.count);
      }
      
      protected function addHandler(item:InventoryItem) : void
      {
         item.questItem = true;
         this.userOfferGrid.addItem(item);
      }
      
      protected function returnItem(item:InventoryItem) : void
      {
         item.questItem = false;
         this.inventoryGrid.addItem(item);
      }
      
      protected function onOfferCountSelect(countMenu:CountMenu) : void
      {
         var item:InventoryItem = countMenu.item;
         var splitItem:InventoryItem;
         if(countMenu.count == item.count)
         {
            this.addHandler(item);
            this.sendItemAdd(item);
         }
         else
         {
            splitItem = item.splitStack(countMenu.count);
            this.addHandler(splitItem);
            this.sendItemAdd(splitItem);
            this.returnItem(item);
         }
      }
      
      protected function onOfferCountCancel(countMenu:CountMenu) : void
      {
         this.returnItem(countMenu.item);
      }
      
      protected function onReturnCountCancel(countMenu:CountMenu) : void
      {
         this.addHandler(countMenu.item);
      }
      
      protected function onReturnCountSelect(countMenu:CountMenu) : void
      {
         var item:InventoryItem = countMenu.item;
         var splitItem:InventoryItem;
         if(countMenu.count == item.count)
         {
            this.returnItem(item);
            this.sendItemRemove(item);
         }
         else
         {
            splitItem = item.splitStack(countMenu.count);
            this.returnItem(splitItem);
            this.sendItemRemove(splitItem);
            this.addHandler(item);
         }
      }
      
      override public function closeMenu() : void
      {
         GameSocket.socket.sendActionLeave();
         super.closeMenu();
      }
      
      public function addOpponentItem(fields:Array) : void
      {
         barterEndTime = 0;
         var item:InventoryItem = new InventoryItem(fields.slice(3,3 + fields[3]));
         item.count = fields[2];
         this.opponentGrid.addItem(item);
      }
      
      public function addOpItemCount(inventoryId:int, count:int) : void
      {
         barterEndTime = 0;
         var items:Vector.<InventoryItem> = this.opponentGrid.items;
         var i:int = 0;
         while(i < items.length)
         {
            if(items[i].inventoryId == inventoryId)
            {
               items[i].count = count;
               return;
            }
            i++;
         }
         throw new Error("Smth. is wrong..");
      }
      
      public function delOpItem(inventoryId:int, count:int) : void
      {
         var items:Vector.<InventoryItem> = this.opponentGrid.items;
         var i:int = 0;
         while(i < items.length)
         {
            if(items[i].inventoryId == inventoryId)
            {
               if(!items[i].isExpendable || count <= 0)
               {
                  this.opponentGrid.removeItem(items[i]);
               }
               else
               {
                  if(items[i].count > count)
                  {
                     items[i].count = count;
                  }
                  else
                  {
                     throw new Error("Smth. is wrong..");
                  }
               }
               return;
            }
            i++;
         }
      }
      
      public function opponentConfirm() : void
      {
         barterEndTime = 0;
         this.barterText.text = _("IDS_OPPONENT_WAITING");
      }
      
      private function confirmHandler(sender:Object) : void
      {
         GameSocket.socket.sendActionConfirm();
         if(this.barterText.text == _("IDS_BARTER"))
         {
            this.barterText.text = _("IDS_WAITING_CONFIRM");
         }
      }
      
      public function get barterEndTime() : int
      {
         return this._barterEndTime;
      }
      
      override public function dispose() : void
      {
         barterEndTime = 0;
         super.dispose();
      }
      
      public function set barterEndTime(value:int) : void
      {
         if(this._barterInterval >= 0)
         {
            clearInterval(this._barterInterval);
            _barterInterval = -1;
         }
         _barterEndTime = value;
         if(value > 0)
         {
            _barterInterval = setInterval(this.updateBarterEndTime,1000);
            this.updateBarterEndTime();
         }
         else
         {
            this.barterText.text = _("IDS_BARTER");
         }
      }
      
      private function updateBarterEndTime() : void
      {
         this.barterText.text = _("IDS_BARTER_FINISH_TIME",Math.max(0,int((this._barterEndTime - getTimer()) / 1000)));
      }
      
      public function falseConfirm() : void
      {
         barterEndTime = 0;
      }
   }
}

