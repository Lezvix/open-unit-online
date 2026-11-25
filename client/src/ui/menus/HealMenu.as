package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import game.*;
   import ui.*;
   
   public class HealMenu extends NuclearSprite
   {
      
      public static const TYPE_ASK_HEAL:int = 0;
      
      public static const TYPE_BOT_HEAL:int = 1;
      
      public static const TYPE_HEAL:int = 2;
      
      private static const LEFT_PANEL_WIDTH:int = 323;
      
      private var healType:int;
      
      private var botSkill:int;
      
      private var selectedFactor:int = 0;
      
      private var statusText:TextField;
      
      private var inventoryGrid:ItemsGrid;
      
      private var paymentGrid:ItemsGrid;
      
      private var itemInfoMenu:ItemInfo;
      
      private var repairText:TextField;
      
      private var dragger:InventoryItemDragger;
      
      private var costText:TextField;
      
      private var packsText:TextField;
      
      private var traumList:RowList;
      
      private var _selectedTraum:int = -1;
      
      private var selectedTraumText:TextField;
      
      private var traums:Array;
      
      private var countInput:NTextInput;
      
      private var packsLabel:TextField;
      
      public function HealMenu(params:Object)
      {
         var responseFields:Array;
         super(TYPE_BARTER);
         responseFields = params.data;
         var fieldIndex:int = params.offset;
         this.healType = params.type;
         this.botSkill = responseFields[2];
         w = 717;
         h = 364;
         fillBg(4,4,w - 50,h - 8);
         draw(getBmp("BACK"),0,0);
         drawTitleBar(12,10,LEFT_PANEL_WIDTH);
         drawTitleBar(LEFT_PANEL_WIDTH + 24,10,w - LEFT_PANEL_WIDTH - 75);
         this.statusText = createLabel(LEFT_PANEL_WIDTH + 24,21,_("IDS_HEAL_MENU"),NTextFormat.titleFormat,w - LEFT_PANEL_WIDTH - 75);
         addChild(this.statusText);
         drawTitleBar(12,h - 103,LEFT_PANEL_WIDTH);
         drawTitleBar(12,h - 50,w - 63);
         drawFrame(0,0,w - 42,h);
         drawHSeparator(9,h - 64,w - 57);
         drawVSeparator(LEFT_PANEL_WIDTH + 11,6,h - 64);
         this.selectedTraumText = createLabel(21,58,_("IDS_SELECTED_TRAUM"),NTextFormat.normal);
         addChild(this.selectedTraumText);
         this.selectedTraumText = createLabel(this.selectedTraumText.x + this.selectedTraumText.width + 2,58,"-",NTextFormat.normal,150);
         addChild(this.selectedTraumText);
         this.packsLabel = createLabel(21,this.selectedTraumText.y + this.selectedTraumText.height,"?",NTextFormat.normal,LEFT_PANEL_WIDTH - 9);
         this.packsLabel.visible = false;
         addChild(this.packsLabel);
         if(this.healType == TYPE_HEAL)
         {
            this.packsLabel.text = _("IDS_TRAUMPACKS_NEEDED");
            this.packsText = createLabel(this.packsLabel.x + this.packsLabel.textWidth + 3,this.packsLabel.y,"?",NTextFormat.normal,LEFT_PANEL_WIDTH - 9);
            index = 4;
            while(index >= 0)
            {
               button = new CommonButton("x1." + (index + 1),this.onFactorClick);
               button.value = index;
               button.setPos(w - 216 - (button.width + 2) * (4 - index),h - 42);
               addUIChild(button);
               index--;
            }
            addTextLabel(156,h - 38,_("IDS_FACTOR"),NTextFormat.normal.right,button.x - 160);
            this.countInput = createInput(21,this.packsLabel.y + this.packsLabel.height + 7,71);
            addUIChild(this.countInput);
            button = new NButton(this.onPlusClick2,getBmp("PLUS"),getBmp("PLUS_OVER"),getBmp("PLUS_PRESSED"));
            button.setPos(this.countInput.x + this.countInput.width + 5,this.countInput.y);
            addUIChild(button);
            button = new NButton(this.onMinusClick2,getBmp("MINUS"),getBmp("MINUS_OVER"),getBmp("MINUS_PRESSED"));
            button.setPos(this.countInput.x + this.countInput.width + button.width + 1,this.countInput.y);
            addUIChild(button);
            addButton(button.x + button.width + 1,this.countInput.y,_("IDS_SET"),this.setCost);
            this.inventoryGrid = new ItemsGrid(245,3);
            this.inventoryGrid.setPos(LEFT_PANEL_WIDTH + 32,56);
         }
         else
         {
            this.packsLabel.text = _("IDS_TRAUMPACKS_NEEDED_SELF");
            this.packsText = createLabel(21,this.packsLabel.y + this.packsLabel.height,"?",NTextFormat.normal.center,LEFT_PANEL_WIDTH - 9);
            drawHSeparator(LEFT_PANEL_WIDTH + 21,150,w - LEFT_PANEL_WIDTH - 69);
            addButton(126,h - 42,_("IDS_AUTO_COUNT"),this.onAutoCountClick);
            this.inventoryGrid = new ItemsGrid(123,3);
            this.inventoryGrid.setPos(LEFT_PANEL_WIDTH + 32,172);
         }
         this.packsText.visible = false;
         addChild(this.packsText);
         this.costText = createLabel(12,22,formatString("IDS_HEAL_COST",0),NTextFormat.normal.center,LEFT_PANEL_WIDTH);
         addChild(this.costText);
         addTextLabel(16,h - 98,_("IDS_COST_EXAMINATION"),NTextFormat.normal.center,LEFT_PANEL_WIDTH - 8);
         this.repairText = createLabel(16,h - 85,formatString("IDS_MONEY_TEMPLATE",0),NTextFormat.normal.center,LEFT_PANEL_WIDTH - 8);
         addChild(this.repairText);
         var filterPanel:InventoryFilterPanel = new InventoryFilterPanel(this.inventoryGrid);
         var index:int;
         var button:NButton;
         var traumaCount:int;
         var traumaScroll:ScrollSprite;
         var trauma:Object;
         var itemRecordLength:int;
         filterPanel.setPos(w - 42,8);
         addUIChild(filterPanel);
         button = new NButton(onCloseClick,getBmp("INV_CLOSE_BUTTON"),getBmp("INV_CLOSE_BUTTON_OVER"),getBmp("INV_CLOSE_BUTTON_PRESSED"));
         button.setPos(w - 80,12);
         addUIChild(button);
         button = new NButton(this.onBGraphicsClick,getBmp("B_GRAPHICS"),getBmp("B_GRAPHICS_OVER"),getBmp("B_GRAPHICS_PRESSED"));
         button.setPos(w - 80,29);
         addUIChild(button);
         addButton(19,h - 42,_("IDS_APPLY"),this.confirmHandler);
         addButton(w - 162,h - 42,_("IDS_REJECT"),onCloseClick);
         this.paymentGrid = new ItemsGrid(123,3);
         this.paymentGrid.setPos(20,132);
         this.paymentGrid.doAction808(this.onInfoClick);
         graphics.lineStyle(1,2236962);
         fillBg(this.paymentGrid.x,this.paymentGrid.y,this.paymentGrid.width - 12,this.paymentGrid.height);
         graphics.lineStyle();
         this.inventoryGrid.doAction808(this.onInfoClick);
         if(this.healType != TYPE_HEAL)
         {
            traumaCount = responseFields[fieldIndex++];
            this.traums = new Array(traumaCount);
            traumaScroll = new ScrollSprite(this.inventoryGrid.width,89);
            traumaScroll.setPos(this.inventoryGrid.x,56);
            this.traumList = new RowList(traumaScroll.width - 15,this.onTraumSelect);
            index = 0;
            while(index < traumaCount)
            {
               trauma = {
                  "uid":uint(responseFields[fieldIndex++]),
                  "type":int(responseFields[fieldIndex++]),
                  "endtime":int(responseFields[fieldIndex++]) * 1000 + getTimer()
               };
               this.traums[index] = trauma;
               this.traumList.addRow(_("IDS_TRAUMA_" + trauma.type),"?",index);
               if(Character.TRAUM_SEVERITY[trauma.type] == Character.SEVERITY_HARD)
               {
                  this.traumList.setRowColor(this.traumList.totalRows - 1,16737792);
               }
               index++;
            }
            traumaScroll.addContent(this.traumList);
            addUIChild(traumaScroll);
         }
         while(fieldIndex < responseFields.length - 1)
         {
            itemRecordLength = responseFields[fieldIndex];
            this.inventoryGrid.addItem(new InventoryItem(responseFields.slice(fieldIndex,fieldIndex + itemRecordLength)));
            fieldIndex += itemRecordLength;
         }
         this.paymentGrid.addChangeListener(this.onGridChange);
         this.inventoryGrid.selectHandler = Chat.getInt45;
         addUIChild(this.paymentGrid);
         addUIChild(this.inventoryGrid);
         this.itemInfoMenu = new ItemInfo();
         addUIChild(this.itemInfoMenu);
         if(this.healType != TYPE_HEAL)
         {
            this.inventoryGrid.propValue49 = this.onShopItemSelect;
            this.paymentGrid.propValue49 = this.onOfferItemSelect;
            this.dragger = new InventoryItemDragger();
            this.dragger.dropHandler = this.onShopItemDrop;
            addUIChild(this.dragger);
            processIntervalValue = 1000;
         }
         width = w;
         height = h;
      }
      
      public function addHealTraum(traumType:int) : void
      {
         if(this.healType == TYPE_HEAL)
         {
            traums = [{"type":traumType}];
            this.selectedTraumText.text = _("IDS_TRAUMA_" + traumType);
            selectedTraum = 0;
         }
      }
      
      public function delHealTraum() : void
      {
         if(this.healType == TYPE_HEAL)
         {
            traums = null;
            this.selectedTraumText.text = "-";
            selectedTraum = -1;
         }
      }
      
      protected function onTraumSelect(button:SelectableButton) : void
      {
         if(this.healType != TYPE_HEAL)
         {
            if(button.Selected)
            {
               this.selectedTraumText.text = button.getLabel(0).text;
               selectedTraum = int(button.value);
            }
            else
            {
               this.selectedTraumText.text = "-";
               selectedTraum = -1;
            }
         }
      }
      
      protected function set selectedTraum(value:int) : void
      {
         if(value != this._selectedTraum || this.healType == TYPE_HEAL)
         {
            _selectedTraum = value;
            this.updateHealInfo();
            if(this.healType == TYPE_ASK_HEAL)
            {
               ++GameSocket.socket.barterOpId;
               if(value == -1)
               {
                  GameSocket.socket.sendDelHealTraum();
               }
               else
               {
                  GameSocket.socket.sendAddItem(this.traums[value].uid);
               }
            }
         }
      }
      
      protected function get selectedTraum() : int
      {
         return this._selectedTraum;
      }
      
      override protected function process() : void
      {
         var currentTime:int = getTimer();
         var traumaIndex:int = 0;
         var secondsRemaining:int;
         while(traumaIndex < this.traums.length)
         {
            secondsRemaining = (this.traums[traumaIndex].endtime - currentTime) / 1000;
            if(secondsRemaining > 0)
            {
               this.traumList.setData(traumaIndex,1,Chat.secondsToStr(secondsRemaining));
            }
            else
            {
               if(this.selectedTraum == traumaIndex)
               {
                  selectedTraum = -1;
                  this.selectedTraumText.text = "-";
               }
               this.traumList.removeRow(traumaIndex);
               this.traums.splice(traumaIndex,1);
               traumaIndex--;
            }
            traumaIndex++;
         }
      }
      
      protected function setCost(button:NButton) : void
      {
         var price:int = int(this.countInput.text);
         GameSocket.socket.setPrice(price);
         this.costText.text = formatString("IDS_HEAL_COST",price);
      }
      
      public function setPrice(price:int) : void
      {
         this.costText.text = formatString("IDS_HEAL_COST",price);
         selectedFactor = price;
      }
      
      protected function onFactorClick(button:NButton) : void
      {
         var priceFactor:Number;
         var traumaType:int = 0;
         var severity:int = 0;
         var packCount:int = 0;
         var baseCost:int = 0;
         if(this.selectedTraum == -1)
         {
            this.countInput.text = "0";
         }
         else
         {
            priceFactor = 1 + (int(button.value) + 1) / 10;
            traumaType = this.traums[this.selectedTraum].type;
            severity = Character.TRAUM_SEVERITY[traumaType];
            packCount = this.getPackCount(Main.UserCharacter.skills[Character.SKILL_DOCTOR] / 10000);
            baseCost = InventoryItem.array79[severity] * packCount;
            this.countInput.text = int(baseCost * priceFactor).toString();
         }
      }
      
      protected function onPlusClick2(button:NButton) : void
      {
         this.countInput.text = Math.max(0,this.countInput.text ? int(this.countInput.text) + 1 : 1).toString();
      }
      
      protected function onMinusClick2(button:NButton) : void
      {
         this.countInput.text = Math.max(0,this.countInput.text ? int(this.countInput.text) - 1 : 0).toString();
      }
      
      protected function updateHealInfo() : void
      {
         var traumaType:int = 0;
         var severity:int = 0;
         var packCount:int = 0;
         var baseCost:int = 0;
         if(this.selectedTraum == -1)
         {
            this.costText.text = formatString("IDS_HEAL_COST",0);
            selectedFactor = 0;
            this.packsLabel.visible = false;
            this.packsText.visible = false;
         }
         else
         {
            traumaType = this.traums[this.selectedTraum].type;
            severity = Character.TRAUM_SEVERITY[traumaType];
            packCount = this.getPackCount(Main.UserCharacter.skills[Character.SKILL_DOCTOR] / 10000);
            baseCost = InventoryItem.array79[severity] * packCount;
            this.packsText.text = formatString("IDS_TRAUMPACKS_TEMPLATE",packCount,severity,baseCost);
            if(this.healType == TYPE_BOT_HEAL)
            {
               this.costText.text = formatString("IDS_HEAL_COST",int(this.getPackCount(this.botSkill) * 1.1 * this.botSkill / 100) * InventoryItem.array79[severity]);
            }
            this.packsLabel.visible = true;
            this.packsText.visible = true;
         }
      }
      
      public function addOpponentItem(fields:Array) : void
      {
         var item:InventoryItem = null;
         if(this.healType == TYPE_HEAL)
         {
            item = new InventoryItem(fields.slice(3,3 + fields[3]));
            item.count = fields[2];
            this.paymentGrid.addItem(item);
         }
      }
      
      public function addOpItemCount(inventoryId:int, count:int) : void
      {
         var items:Vector.<InventoryItem> = null;
         var itemIndex:int = 0;
         if(this.healType == TYPE_HEAL)
         {
            items = this.paymentGrid.items;
            itemIndex = 0;
            while(itemIndex < items.length)
            {
               if(items[itemIndex].inventoryId == inventoryId)
               {
                  items[itemIndex].count = count;
                  return;
               }
               itemIndex++;
            }
         }
      }
      
      public function delOpItem(inventoryId:int, count:int) : void
      {
         var items:Vector.<InventoryItem> = null;
         var itemIndex:int = 0;
         if(this.healType == TYPE_HEAL)
         {
            items = this.paymentGrid.items;
            itemIndex = 0;
            while(itemIndex < items.length)
            {
               if(items[itemIndex].inventoryId == inventoryId)
               {
                  if(!items[itemIndex].isExpendable || count <= 0)
                  {
                     this.paymentGrid.removeItem(items[itemIndex]);
                  }
                  else if(items[itemIndex].count > count)
                  {
                     items[itemIndex].count = count;
                  }
                  return;
               }
               itemIndex++;
            }
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
         var draggedItem:InventoryItem = null;
         if(!itemDragger.isActive)
         {
            draggedItem = itemDragger.dropItem();
            if(this.paymentGrid.isMouseOver)
            {
               if(draggedItem.questItem)
               {
                  this.addHandler(draggedItem);
               }
               else if(draggedItem.isExpendable && draggedItem.count > 1)
               {
                  showModal(new CountMenu(draggedItem,this.onOfferCountSelect,this.onOfferCountCancel));
               }
               else if(draggedItem.isArt)
               {
                  this.returnItem(draggedItem);
               }
               else
               {
                  this.addHandler(draggedItem);
                  this.sendItemAdd(draggedItem);
               }
            }
            else if(this.inventoryGrid.isMouseOver)
            {
               if(draggedItem.questItem)
               {
                  if(draggedItem.isExpendable && draggedItem.count > 1)
                  {
                     showModal(new CountMenu(draggedItem,this.onReturnCountSelect,this.onReturnCountCancel));
                  }
                  else
                  {
                     this.returnItem(draggedItem);
                     this.sendItemRemove(draggedItem);
                  }
               }
               else
               {
                  this.returnItem(draggedItem);
               }
            }
            else if(draggedItem.questItem)
            {
               this.addHandler(draggedItem);
            }
            else
            {
               this.returnItem(draggedItem);
            }
         }
      }
      
      protected function sendItemAdd(item:InventoryItem) : void
      {
         ++GameSocket.socket.barterOpId;
         if(this.healType == TYPE_ASK_HEAL)
         {
            GameSocket.socket.doAction365(item.inventoryId,item.count);
         }
      }
      
      protected function sendItemRemove(item:InventoryItem) : void
      {
         ++GameSocket.socket.barterOpId;
         if(this.healType == TYPE_ASK_HEAL)
         {
            GameSocket.socket.doAction518(item.inventoryId,item.count);
         }
      }
      
      protected function addHandler(item:InventoryItem) : void
      {
         item.questItem = true;
         this.paymentGrid.addItem(item);
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
      
      protected function onGridChange(event:Object) : void
      {
         if(event.property == "itemsPrice")
         {
            this.repairText.text = formatString("IDS_MONEY_TEMPLATE",this.paymentGrid.propValue107);
         }
      }
      
      protected function getPackCount(skill:int) : int
      {
         var trauma:Object = this.traums[this.selectedTraum];
         var skillThreshold:int = Character.TRAUM_FACTOR[trauma.type];
         var baseCount:int = Character.TRAUM_COST[trauma.type];
         if(skill >= skillThreshold)
         {
            return baseCount;
         }
         return baseCount * (1 + (skillThreshold - skill) / 100);
      }
      
      protected function getBotHealCost() : int
      {
         var traumaType:int = 0;
         var severity:int = 0;
         if(this.selectedTraum == -1)
         {
            return 0;
         }
         traumaType = this.traums[this.selectedTraum].type;
         severity = Character.TRAUM_SEVERITY[traumaType];
         return int(this.getPackCount(this.botSkill) * 1.1 * this.botSkill / 100) * InventoryItem.array79[severity];
      }
      
      protected function onAutoCountClick(sender:Object) : void
      {
         var requiredAmount:int = 0;
         var offeredValue:int = 0;
         var difference:int = 0;
         var moneyItem:InventoryItem = null;
         var splitItem:InventoryItem = null;
         if(this.healType != TYPE_HEAL)
         {
            requiredAmount = this.healType == TYPE_BOT_HEAL ? this.getBotHealCost() : this.selectedFactor;
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
         if(this.selectedTraum == -1)
         {
            showNotification(_("IDS_NO_HEAL_TRAUM"));
            return;
         }
         var requiredAmount:int = this.healType == TYPE_BOT_HEAL ? this.getBotHealCost() : this.selectedFactor;
         var offeredValue:int = this.paymentGrid.propValue107;
         var healPack:InventoryItem;
         switch(this.healType)
         {
            case TYPE_BOT_HEAL:
               if(requiredAmount > offeredValue)
               {
                  showNotification(_("IDS_CANT_REPAIR_BOT"));
               }
               else if(requiredAmount < offeredValue)
               {
                  showModal(new QuestionMenu(_("IDS_HEAL_COST_WARNING"),this.onHealCostWarningClick));
               }
               else
               {
                  this.onHealCostWarningClick();
               }
               break;
            case TYPE_HEAL:
               healPack = this.inventoryGrid.getInventoryItem1(Character.TRAUM_SEVERITY[this.traums[this.selectedTraum].type] == Character.SEVERITY_LIGHT ? -18 : -19);
               if(healPack == null)
               {
                  showNotification(_("IDS_NO_HEAL_PACKS"));
               }
               else if(healPack.count < requiredAmount)
               {
                  showNotification(_("IDS_NE_HEAL_PACKS"));
               }
               else
               {
                  GameSocket.socket.sendActionConfirm();
                  this.statusText.text = _("IDS_WAITING_CONFIRM");
               }
               break;
            case TYPE_ASK_HEAL:
               GameSocket.socket.sendActionConfirm();
               this.statusText.text = _("IDS_WAITING_CONFIRM");
               break;
         }
      }
      
      public function opponentConfirm() : void
      {
         this.statusText.text = _("IDS_OPPONENT_WAITING");
      }
      
      protected function onHealCostWarningClick(sender:Object = null) : void
      {
         GameSocket.socket.sendStr("bb|" + this.traums[this.selectedTraum].uid + "|" + Chat.getString38(this.paymentGrid.items));
      }
      
      public function falseConfirm() : void
      {
         switch(this.healType)
         {
            case TYPE_BOT_HEAL:
               showNotification(_("IDS_CANT_REPAIR_BOT"));
               break;
            default:
               this.statusText.text = _("IDS_HEAL_MENU");
               showNotification(_("IDS_CANT_HEAL"));
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

