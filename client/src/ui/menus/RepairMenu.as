package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import game.*;
   import ui.*;
   
   public class RepairMenu extends NuclearSprite
   {
      
      public static const TYPE_ASK_REPAIR:int = 0;
      
      public static const TYPE_BOT_REPAIR:int = 1;
      
      public static const TYPE_REPAIR:int = 2;
      
      private static const LEFT_PANEL_WIDTH:int = 323;
      
      private var repairType:int;
      
      private var botRepairPercent:int;
      
      private var selectedFactor:int = 0;
      
      private var statusText:TextField;
      
      private var inventoryGrid:ItemsGrid;
      
      private var paymentGrid:ItemsGrid;
      
      private var repairSlot:IconItemSlot;
      
      private var itemInfoMenu:ItemInfo;
      
      private var repairText:TextField;
      
      private var traumText:TextField;
      
      private var dragger:InventoryItemDragger;
      
      private var traumName:TextField;
      
      private var countInput:NTextInput;
      
      public function RepairMenu(params:Object)
      {
         var fields:Array;
         super(TYPE_BARTER);
         fields = params.data;
         var offset:int = params.offset;
         this.repairType = params.type;
         this.botRepairPercent = fields[2];
         w = 717;
         h = 370;
         fillBg(4,4,w - 50,h - 8);
         draw(getBmp("BACK"),0,0);
         drawTitleBar(12,10,LEFT_PANEL_WIDTH);
         drawTitleBar(LEFT_PANEL_WIDTH + 24,10,w - LEFT_PANEL_WIDTH - 75);
         this.statusText = createLabel(LEFT_PANEL_WIDTH + 24,21,_("IDS_REPAIR_MENU"),NTextFormat.titleFormat,w - LEFT_PANEL_WIDTH - 75);
         addChild(this.statusText);
         drawTitleBar(12,h - 103,LEFT_PANEL_WIDTH);
         drawTitleBar(12,h - 50,w - 63);
         drawFrame(0,0,w - 42,h);
         drawHSeparator(9,h - 64,w - 57);
         drawVSeparator(LEFT_PANEL_WIDTH + 11,6,h - 64);
         this.repairSlot = new IconItemSlot();
         this.repairSlot.showInfoButton(this.onInfoClick);
         if(this.repairType == TYPE_REPAIR)
         {
            this.repairSlot.setPos(82,59);
            factorIndex = 4;
            while(factorIndex >= 0)
            {
               button = new CommonButton("x1." + (factorIndex + 1),this.onFactorClick);
               button.value = factorIndex;
               button.setPos(w - 216 - (button.width + 2) * (4 - factorIndex),h - 42);
               addUIChild(button);
               factorIndex--;
            }
            addTextLabel(156,h - 38,_("IDS_FACTOR"),NTextFormat.normal.right,button.x - 160);
            this.countInput = createInput(this.repairSlot.x + this.repairSlot.width + 5,this.repairSlot.y + 7,51);
            addUIChild(this.countInput);
            button = new NButton(this.onPlusClick2,getBmp("PLUS"),getBmp("PLUS_OVER"),getBmp("PLUS_PRESSED"));
            button.setPos(this.countInput.x + this.countInput.width + 1,this.countInput.y);
            addUIChild(button);
            button = new NButton(this.onMinusClick2,getBmp("MINUS"),getBmp("MINUS_OVER"),getBmp("MINUS_PRESSED"));
            button.setPos(this.countInput.x + this.countInput.width + button.width + 1,this.countInput.y);
            addUIChild(button);
            addButton(this.countInput.x,this.countInput.y + this.countInput.height + 1,_("IDS_SET"),this.setCost);
         }
         else
         {
            this.repairSlot.setPos(12 + (LEFT_PANEL_WIDTH - this.repairSlot.width) / 2,59);
            addButton(126,h - 42,_("IDS_AUTO_COUNT"),this.onAutoCountClick);
         }
         this.traumName = createLabel(12,22,formatString("IDS_REPAIR_COST",0),NTextFormat.normal.center,LEFT_PANEL_WIDTH);
         addChild(this.traumName);
         this.traumText = createLabel(21,this.repairSlot.y + this.repairSlot.height + 1,"?",NTextFormat.normal,LEFT_PANEL_WIDTH - 16);
         this.traumText.visible = false;
         addChild(this.traumText);
         addTextLabel(16,h - 98,_("IDS_COST_EXAMINATION"),NTextFormat.normal.center,LEFT_PANEL_WIDTH - 8);
         this.repairText = createLabel(16,h - 85,"0",NTextFormat.normal.center,LEFT_PANEL_WIDTH - 8);
         addChild(this.repairText);
         addUIChild(this.repairSlot);
         button = new NButton(onCloseClick,getBmp("INV_CLOSE_BUTTON"),getBmp("INV_CLOSE_BUTTON_OVER"),getBmp("INV_CLOSE_BUTTON_PRESSED"));
         button.setPos(w - 80,12);
         addUIChild(button);
         button = new NButton(this.onBGraphicsClick,getBmp("B_GRAPHICS"),getBmp("B_GRAPHICS_OVER"),getBmp("B_GRAPHICS_PRESSED"));
         button.setPos(w - 80,29);
         addUIChild(button);
         addButton(19,h - 42,_("IDS_APPLY"),this.confirmHandler);
         addButton(w - 162,h - 42,_("IDS_REJECT"),onCloseClick);
         this.paymentGrid = new ItemsGrid(123,3);
         this.paymentGrid.setPos(20,138);
         this.paymentGrid.doAction808(this.onInfoClick);
         graphics.lineStyle(1,2236962);
         fillBg(this.paymentGrid.x,this.paymentGrid.y,this.paymentGrid.width - 12,this.paymentGrid.height);
         graphics.lineStyle();
         this.inventoryGrid = new ItemsGrid(245,3);
         this.inventoryGrid.setPos(LEFT_PANEL_WIDTH + 32,56);
         this.inventoryGrid.doAction808(this.onInfoClick);
         while(offset < fields.length - 1)
         {
            itemLength = fields[offset];
            this.inventoryGrid.addItem(new InventoryItem(fields.slice(offset,offset + itemLength)));
            offset += itemLength;
         }
         this.paymentGrid.addChangeListener(this.onGridChange);
         this.inventoryGrid.selectHandler = Chat.getInt45;
         addUIChild(this.paymentGrid);
         addUIChild(this.inventoryGrid);
         var filterPanel:InventoryFilterPanel = new InventoryFilterPanel(this.inventoryGrid);
         var factorIndex:int;
         var button:NButton;
         var itemLength:int;
         filterPanel.setPos(w - 42,8);
         addUIChild(filterPanel);
         this.itemInfoMenu = new ItemInfo();
         addUIChild(this.itemInfoMenu);
         if(this.repairType != TYPE_REPAIR)
         {
            this.repairSlot.mouseDown = this.onRepairSlotSelect;
            this.inventoryGrid.propValue49 = this.onShopItemSelect;
            this.paymentGrid.propValue49 = this.onOfferItemSelect;
            this.dragger = new InventoryItemDragger();
            this.dragger.dropHandler = this.onShopItemDrop;
            addUIChild(this.dragger);
         }
         width = w;
         height = h;
      }
      
      protected function setCost(button:NButton) : void
      {
         var price:int = int(this.countInput.text);
         GameSocket.socket.setPrice(price);
         this.traumName.text = formatString("IDS_REPAIR_COST",price);
      }
      
      public function setPrice(price:int) : void
      {
         this.traumName.text = formatString("IDS_REPAIR_COST",price);
         selectedFactor = price;
      }
      
      protected function onFactorClick(button:NButton) : void
      {
         var factor:Number = 1 + (int(button.value) + 1) / 10;
         this.countInput.text = int(this.getSparesCount() * factor).toString();
      }
      
      protected function onPlusClick2(button:NButton) : void
      {
         this.countInput.text = Math.max(0,this.countInput.text ? int(this.countInput.text) + 1 : 1).toString();
      }
      
      protected function onMinusClick2(button:NButton) : void
      {
         this.countInput.text = Math.max(0,this.countInput.text ? int(this.countInput.text) - 1 : 0).toString();
      }
      
      protected function updateRepairInfo() : void
      {
         var sparesCount:int = this.getSparesCount();
         if(sparesCount > 0)
         {
            if(this.repairType == TYPE_REPAIR)
            {
               this.traumText.text = formatString("IDS_SPAIRS_NEEDED",sparesCount);
            }
            else
            {
               this.traumText.text = formatString("IDS_SPAIRS_NEEDED_SELF",sparesCount);
            }
            this.traumText.visible = true;
         }
         else
         {
            this.traumText.visible = false;
         }
         if(this.repairType == TYPE_BOT_REPAIR)
         {
            this.traumName.text = formatString("IDS_REPAIR_COST",this.repairSlot.isActive ? 0 : this.repairSlot.item.getBotRepairCost(this.botRepairPercent));
         }
      }
      
      protected function onRepairSlotSelect(listItem:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(listItem.item,listItem.image);
            this.dragger.setPos(this.repairSlot.x + listItem.x,this.repairSlot.y + listItem.y);
            this.repairSlot.removeItem();
            this.updateRepairInfo();
         }
      }
      
      public function addOpponentItem(fields:Array) : void
      {
         var item:InventoryItem = null;
         if(this.repairType == TYPE_REPAIR)
         {
            item = new InventoryItem(fields.slice(3,3 + fields[3]));
            item.count = fields[2];
            this.paymentGrid.addItem(item);
         }
      }
      
      public function addOpItemCount(inventoryId:int, count:int) : void
      {
         var items:Vector.<InventoryItem> = null;
         var i:int = 0;
         if(this.repairType == TYPE_REPAIR)
         {
            items = this.paymentGrid.items;
            i = 0;
            while(i < items.length)
            {
               if(items[i].inventoryId == inventoryId)
               {
                  items[i].count = count;
                  return;
               }
               i++;
            }
         }
      }
      
      public function delOpItem(inventoryId:int, count:int) : void
      {
         var items:Vector.<InventoryItem> = null;
         var i:int = 0;
         if(this.repairType == TYPE_REPAIR)
         {
            items = this.paymentGrid.items;
            i = 0;
            while(i < items.length)
            {
               if(items[i].inventoryId == inventoryId)
               {
                  if(!items[i].isExpendable || count <= 0)
                  {
                     this.paymentGrid.removeItem(items[i]);
                  }
                  else if(items[i].count > count)
                  {
                     items[i].count = count;
                  }
                  return;
               }
               i++;
            }
         }
      }
      
      public function addServerUserItem(fields:Array) : void
      {
         var itemLength:int = 0;
         if(this.repairType == TYPE_REPAIR)
         {
            itemLength = fields[2];
            this.repairSlot.insertItem(new InventoryItem(fields.slice(2,2 + itemLength)));
            this.updateRepairInfo();
         }
      }
      
      public function delServerUserItem() : void
      {
         if(this.repairType == TYPE_REPAIR && !this.repairSlot.isActive)
         {
            this.repairSlot.removeItem();
            this.updateRepairInfo();
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
            this.dragger.setPos(this.paymentGrid.x + listItem.x,this.paymentGrid.y + listItem.y - this.paymentGrid.scrollV);
            this.paymentGrid.removeItem(listItem.item);
         }
      }
      
      protected function onShopItemDrop(itemDragger:InventoryItemDragger) : void
      {
         var item:InventoryItem = null;
         if(!itemDragger.isActive)
         {
            item = itemDragger.dropItem();
            if(this.paymentGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  this.addHandler(item);
               }
               else if(item.isExpendable && item.count > 1)
               {
                  showModal(new CountMenu(item,this.onOfferCountSelect,this.onOfferCountCancel));
               }
               else
               {
                  if(item.flag51)
                  {
                     ++GameSocket.socket.barterOpId;
                     GameSocket.socket.sendDelFixItem();
                     this.updateRepairInfo();
                  }
                  if(item.isArt)
                  {
                     this.returnItem(item);
                  }
                  else
                  {
                     this.addHandler(item);
                     this.sendItemAdd(item);
                  }
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
                  if(item.flag51)
                  {
                     ++GameSocket.socket.barterOpId;
                     GameSocket.socket.sendDelFixItem();
                     this.updateRepairInfo();
                  }
                  this.returnItem(item);
               }
            }
            else if(this.repairSlot.isMouseOver)
            {
               if(item.isValue39 && !item.repairType == InventoryItem.set)
               {
                  if(!this.repairSlot.isActive)
                  {
                     this.returnItem(this.repairSlot.removeItem());
                  }
                  this.putToRepairSlot(item);
               }
               else if(item.questItem)
               {
                  this.addHandler(item);
               }
               else
               {
                  this.returnItem(item);
               }
            }
            else if(item.questItem)
            {
               this.addHandler(item);
            }
            else if(item.flag51)
            {
               this.putToRepairSlot(item);
            }
            else
            {
               this.returnItem(item);
            }
         }
      }
      
      protected function sendItemAdd(item:InventoryItem) : void
      {
         ++GameSocket.socket.barterOpId;
         if(this.repairType == TYPE_ASK_REPAIR)
         {
            GameSocket.socket.doAction365(item.inventoryId,item.count);
         }
      }
      
      protected function sendItemRemove(item:InventoryItem) : void
      {
         ++GameSocket.socket.barterOpId;
         if(this.repairType == TYPE_ASK_REPAIR)
         {
            GameSocket.socket.doAction518(item.inventoryId,item.count);
         }
      }
      
      protected function addHandler(item:InventoryItem) : void
      {
         item.questItem = true;
         item.flag51 = false;
         this.paymentGrid.addItem(item);
      }
      
      protected function returnItem(item:InventoryItem) : void
      {
         item.questItem = false;
         item.flag51 = false;
         this.inventoryGrid.addItem(item);
      }
      
      protected function putToRepairSlot(item:InventoryItem) : void
      {
         item.questItem = false;
         item.flag51 = true;
         this.repairSlot.insertItem(item);
         this.updateRepairInfo();
         ++GameSocket.socket.barterOpId;
         if(this.repairType == TYPE_ASK_REPAIR)
         {
            GameSocket.socket.sendActionAccept(item.inventoryId);
         }
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
      
      protected function onGridChange(event:Object) : void
      {
         if(event.property == "itemsPrice")
         {
            this.repairText.text = formatString("IDS_MONEY_TEMPLATE",this.paymentGrid.propValue107);
         }
      }
      
      protected function getSparesCount() : int
      {
         return this.repairSlot.isActive ? 0 : this.repairSlot.item.getRepairCost(Main.UserCharacter.skills[Character.SKILL_REPAIR] / 10000);
      }
      
      protected function onAutoCountClick(sender:Object) : void
      {
         var requiredAmount:int = 0;
         var offeredValue:int = 0;
         var difference:int = 0;
         var moneyItem:InventoryItem = null;
         var splitItem:InventoryItem = null;
         if(this.repairType != TYPE_REPAIR)
         {
            requiredAmount = this.repairType == TYPE_BOT_REPAIR ? this.repairSlot.item.getBotRepairCost(this.botRepairPercent) : this.selectedFactor;
            offeredValue = this.paymentGrid.propValue107;
            if(requiredAmount > offeredValue)
            {
               difference = requiredAmount - offeredValue;
               moneyItem = this.inventoryGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count <= difference)
                  {
                     if(moneyItem.count < difference)
                     {
                        showNotification(_("IDS_NE_MONEY"));
                     }
                     this.inventoryGrid.removeItem(moneyItem);
                     this.addHandler(moneyItem);
                     this.sendItemAdd(moneyItem);
                  }
                  else
                  {
                     splitItem = moneyItem.splitStack(difference);
                     this.addHandler(splitItem);
                     this.sendItemAdd(splitItem);
                  }
               }
               else
               {
                  showNotification(_(this.paymentGrid.getFirstItem() ? "IDS_NE_MONEY" : "IDS_NO_MONEY"));
               }
            }
            else if(requiredAmount < offeredValue)
            {
               difference = offeredValue - requiredAmount;
               moneyItem = this.paymentGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count <= difference)
                  {
                     this.paymentGrid.removeItem(moneyItem);
                     this.returnItem(moneyItem);
                     this.sendItemRemove(moneyItem);
                  }
                  else
                  {
                     splitItem = moneyItem.splitStack(difference);
                     this.sendItemRemove(splitItem);
                     this.returnItem(splitItem);
                  }
               }
            }
         }
      }
      
      protected function confirmHandler(sender:Object) : void
      {
         if(this.repairSlot.isActive)
         {
            showNotification(_("IDS_NO_REP_ITEM"));
            return;
         }
         var requiredAmount:int = this.repairType == TYPE_BOT_REPAIR ? this.repairSlot.item.getBotRepairCost(this.botRepairPercent) : this.getSparesCount();
         var offeredValue:int = this.paymentGrid.propValue107;
         var spares:InventoryItem;
         switch(this.repairType)
         {
            case TYPE_BOT_REPAIR:
               if(requiredAmount > offeredValue)
               {
                  showNotification(_("IDS_CANT_REPAIR_BOT"));
               }
               else if(requiredAmount < offeredValue)
               {
                  showModal(new QuestionMenu(_("IDS_REPAIR_COST_WARNING"),this.onRepairCostWarningClick));
               }
               else
               {
                  this.onRepairCostWarningClick();
               }
               break;
            case TYPE_REPAIR:
               spares = this.inventoryGrid.getInventoryItem1(this.repairSlot.item.sparesId);
               if(spares == null)
               {
                  showNotification(_("IDS_NO_SPARES"));
               }
               else if(spares.count < requiredAmount)
               {
                  showNotification(_("IDS_SPARES_LOW"));
               }
               else
               {
                  GameSocket.socket.sendActionConfirm();
                  this.statusText.text = _("IDS_WAITING_CONFIRM");
               }
               break;
            case TYPE_ASK_REPAIR:
               GameSocket.socket.sendActionConfirm();
               this.statusText.text = _("IDS_WAITING_CONFIRM");
               break;
         }
      }
      
      public function opponentConfirm() : void
      {
         this.statusText.text = _("IDS_OPPONENT_WAITING");
      }
      
      protected function onRepairCostWarningClick(sender:Object = null) : void
      {
         GameSocket.socket.sendStr("bb|" + this.repairSlot.item.inventoryId + "|" + Chat.getString38(this.paymentGrid.items));
      }
      
      public function falseConfirm() : void
      {
         switch(this.repairType)
         {
            case TYPE_BOT_REPAIR:
               showNotification(_("IDS_CANT_REPAIR_BOT"));
               break;
            default:
               this.statusText.text = _("IDS_REPAIR_MENU");
               showNotification(_("IDS_CANT_REPAIR"));
               break;
         }
      }
      
      override public function closeMenu() : void
      {
         GameSocket.socket.sendActionLeave();
         super.closeMenu();
      }
      
      protected function onBGraphicsClick(sender:Object) : void
      {
         this.paymentGrid.style = this.inventoryGrid.style = this.inventoryGrid.style == ItemsList.STYLE_LARGE ? ItemsList.STYLE_TEXT : ItemsList.STYLE_LARGE;
      }
      
      protected function onInfoClick(button:NButton) : void
      {
         var item:InventoryItem = button.value as InventoryItem;
         if(this.itemInfoMenu.visible)
         {
            if(this.itemInfoMenu.targetItem.inventoryId == item.inventoryId)
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
   }
}

