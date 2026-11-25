package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import game.*;
   import ui.*;
   
   public class BotBarter extends NuclearSprite
   {
      
      public static const NPC_TRADE_BOT:int = 0;
      
      public static const NPC_TRADE_BOX:int = 1;
      
      public static const NPC_TRADE_CELL:int = 2;
      
      public static const NPC_TRADE_DEAD_BOX:int = 3;
      
      private var tradeType:int;
      
      private var shopType:Boolean = true;
      
      private var botItems:Vector.<InventoryItem> = new Vector.<InventoryItem>();
      
      private var botGrid:ItemsGrid;
      
      private var botOfferGrid:ItemsGrid;
      
      private var botDragger:InventoryItemDragger = new InventoryItemDragger();
      
      private var userItems:Vector.<InventoryItem> = new Vector.<InventoryItem>();
      
      private var userGrid:ItemsGrid;
      
      private var userOfferGrid:ItemsGrid;
      
      private var userDragger:InventoryItemDragger = new InventoryItemDragger();
      
      private var ownTradeSkill:int;
      
      private var botTradeSkill:int;
      
      private var botOfferPriceText:TextField;
      
      private var botName:TextField;
      
      private var botPriceCount:int;
      
      private var userPriceCount:int;
      
      private var userWeightButton:WeightButton;
      
      private var cellWeightButton:WeightButton;
      
      private var itemInfoMenu:ItemInfo;
      
      private var deadContainerId:int;
      
      public function BotBarter(params:Object)
      {
         super(TYPE_BOT_BARTER);
         w = 807;
         h = 362;
         var fields:Array = params.data;
         this.tradeType = params.type;
         var tileState:Bitmap = getBmp("TILE_STATE");
         var tileConnect:Bitmap = getBmp("TILE_CONNECT");
         var tileEdge:Bitmap = getBmp("TILE_EDGE");
         var tileEdgeRight:Bitmap = getBmp("TILE_EDGE_RIGHT");
         fillBg(46,4,w - 92,h - 8);
         drawFrame(42,0,w - 84,h);
         drawTile(tileState,273,5,tileState.width,309);
         drawTile(tileState,522,5,tileState.width,309);
         drawTile(tileConnect,273,5,tileConnect.width,tileConnect.height);
         drawTile(tileConnect,522,5,tileConnect.width,tileConnect.height);
         drawTile(tileEdge,272,312 - tileEdge.height,tileEdge.width,tileEdge.height);
         drawTile(tileEdgeRight,521,312 - tileEdge.height,tileEdgeRight.width,tileEdgeRight.height);
         drawTile(bitmap14,frameLeft.width + 40,312 - tileEdge.height,221,bitmap14.height);
         draw(bitmap17,frameLeft.width + 38,312 - tileEdge.height);
         drawTile(bitmap14,521 + tileEdgeRight.width,313 - tileEdge.height,220,bitmap14.height);
         draw(frameRightBmp,737 + tileEdgeRight.width,313 - tileEdge.height);
         var title:String = null;
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.ownTradeSkill = int(fields[3]);
            this.botTradeSkill = int(fields[4]);
            title = _("IDS_TRADE");
         }
         else if(this.tradeType == NPC_TRADE_CELL)
         {
            this.userPriceCount = int(fields[4]);
            this.botPriceCount = int(fields[6]);
            this.shopType = fields[1] != "0";
            if(this.botPriceCount == 5 || this.botPriceCount == 6)
            {
               title = _("IDS_FACTORY_CELL");
            }
            else if(this.botPriceCount == 8)
            {
               title = _("IDS_CLAN_PRODUCT_DEPOD_MENU");
            }
            else
            {
               title = _("IDS_DEPOD_CELL");
            }
         }
         else if(this.tradeType == NPC_TRADE_BOX)
         {
            if(fields[6] == "")
            {
               title = _("IDS_CONTAINER");
            }
            else
            {
               this.deadContainerId = fields[5];
               this.tradeType = NPC_TRADE_DEAD_BOX;
               title = _("IDS_DEAD_CONTAINER");
            }
         }
         drawTitleBar(54,h - 49,w - 105,title);
         drawTitleBar(284,7,240);
         drawTitleBar(52,7,225,this.tradeType == NPC_TRADE_CELL ? _("IDS_CELL_" + fields[6]) : fields[6]);
         drawTitleBar(533,7,194,Main.UserCharacter.name);
         this.userWeightButton = new WeightButton(0,Main.UserCharacter.MaxWeight,120);
         Main.UserCharacter.addChangeListener(this.onCharacterChange);
         this.userWeightButton.setPos(405,294);
         addUIChild(this.userWeightButton);
         if(this.tradeType == NPC_TRADE_CELL)
         {
            this.cellWeightButton = new WeightButton(0,this.userPriceCount);
            this.cellWeightButton.setPos(291,294);
            addUIChild(this.cellWeightButton);
         }
         var button:NButton = new NButton(this.onCloseClick,getBmp("INV_CLOSE_BUTTON"),getBmp("INV_CLOSE_BUTTON_OVER"),getBmp("INV_CLOSE_BUTTON_PRESSED"));
         button.setPos(w - 79,11);
         addUIChild(button);
         button = new NButton(this.onBGraphicsClick,getBmp("B_GRAPHICS"),getBmp("B_GRAPHICS_OVER"),getBmp("B_GRAPHICS_PRESSED"));
         button.setPos(w - 79,28);
         addUIChild(button);
         this.botGrid = new ItemsGrid(245,2);
         this.botGrid.setPos(60,50);
         this.botGrid.doAction808(this.onInfoClick);
         this.botGrid.propValue49 = this.onBotItemSelect;
         this.botGrid.selectHandler = Chat.getInt45;
         addUIChild(this.botGrid);
         this.userGrid = new ItemsGrid(245,2);
         this.userGrid.setPos(542,50);
         this.userGrid.doAction808(this.onInfoClick);
         this.userGrid.propValue49 = this.onUserItemSelect;
         this.userGrid.selectHandler = Chat.getInt45;
         addUIChild(this.userGrid);
         var filterPanel:InventoryFilterPanel = new InventoryFilterPanel(this.botGrid);
         filterPanel.setPos(0,8);
         addUIChild(filterPanel);
         filterPanel = new InventoryFilterPanel(this.userGrid);
         filterPanel.setPos(w - 42,8);
         addUIChild(filterPanel);
         this.botOfferGrid = new ItemsGrid(245,1);
         this.botOfferGrid.setPos(292,50);
         this.botOfferGrid.doAction808(this.onInfoClick);
         this.botOfferGrid.propValue49 = this.onBotOfferItemSelect;
         addUIChild(this.botOfferGrid);
         this.userOfferGrid = new ItemsGrid(245,1);
         this.userOfferGrid.setPos(406,50);
         this.userOfferGrid.doAction808(this.onInfoClick);
         this.userOfferGrid.propValue49 = this.onUserOfferItemSelect;
         addUIChild(this.userOfferGrid);
         if(this.tradeType == NPC_TRADE_BOT)
         {
            addButton(62,321,_("IDS_AUTO_COUNT"),this.onAutoCountClick);
            addTextLabel(284,12,_("IDS_COST_EXAMINATION"),NTextFormat.normal.center,240);
            this.botOfferPriceText = createLabel(284,25,"0",NTextFormat.normal.center,120);
            addChild(this.botOfferPriceText);
            this.botName = createLabel(404,25,"0",NTextFormat.normal.center,120);
            addChild(this.botName);
            this.botOfferGrid.addChangeListener(this.onGridChange);
            this.userOfferGrid.addChangeListener(this.onGridChange);
         }
         else if(this.tradeType == NPC_TRADE_CELL)
         {
            clanPosition = Main.UserCharacter.clanPosition;
            if(hasCellStatistic(this.botPriceCount) && (this.botPriceCount == 2 || (clanPosition == ClanMenu.USER_HEAD || clanPosition == ClanMenu.USER_VC_HEAD || clanPosition == ClanMenu.USER_TREASURER)))
            {
               addButton(62,321,_("IDS_STATISTIC"),this.showCellStatistic);
            }
            this.botGrid.addChangeListener(this.onGridWeightChange);
            if(this.botPriceCount == 8 || this.botPriceCount == 6)
            {
               this.userGrid.propValue49 = null;
            }
            else if(this.botPriceCount == 5 && !this.shopType)
            {
               this.botGrid.propValue49 = null;
            }
         }
         else if(this.tradeType == NPC_TRADE_BOX || this.tradeType == NPC_TRADE_DEAD_BOX)
         {
            addButton(62,321,_("IDS_TAKE_ALL"),this.showLeft);
         }
         this.userOfferGrid.addChangeListener(this.onGridWeightChange);
         this.botOfferGrid.addChangeListener(this.onGridWeightChange);
         addButton(538,321,_("IDS_APPLY"),this.onApplyClick);
         addButton(645,321,_("IDS_REJECT"),this.onCloseClick);
         var userItemCount:int = fields[7];
         var offset:int = 8;
         var itemLength:int;
         var i:int = 0;
         var clanPosition:int;
         while(i < userItemCount)
         {
            itemLength = fields[offset];
            this.userItems.push(new InventoryItem(fields.slice(offset,offset + itemLength)));
            offset += itemLength;
            i++;
         }
         this.userGrid.doAction715(this.userItems);
         while(offset < fields.length - 1)
         {
            itemLength = fields[offset];
            this.botItems.push(new InventoryItem(fields.slice(offset,offset + itemLength)));
            offset += itemLength;
         }
         this.botGrid.doAction715(this.botItems);
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.botGrid.getArray3(this.markItemLevel);
         }
         this.itemInfoMenu = new ItemInfo();
         addUIChild(this.itemInfoMenu);
         this.botDragger.dropHandler = this.onBotItemDrop;
         this.userDragger.dropHandler = this.onUserItemDrop;
         addUIChild(this.botDragger);
         addUIChild(this.userDragger);
         this.refreshWeights();
         height = h;
      }
      
      private static function hasCellStatistic(cellType:int) : Boolean
      {
         switch(cellType)
         {
            case 2:
            case 3:
            case 4:
            case 8:
            case 5:
            case 6:
               return true;
            default:
               return false;
         }
      }
      
      private function markItemLevel(listItem:ItemsList) : void
      {
         var userLevel:int = Main.UserCharacter.level;
         if(listItem.item.isExpendable)
         {
            if(listItem.item.level > userLevel)
            {
               listItem.highlightMode = ItemsList.HIGHLIGHT_RED;
            }
         }
         else if(listItem.item.isValue59 || listItem.item.isWeapon)
         {
            if(listItem.item.level > userLevel)
            {
               listItem.highlightMode = ItemsList.HIGHLIGHT_RED;
            }
            else if(listItem.item.level == userLevel)
            {
               listItem.highlightMode = ItemsList.HIGHLIGHT_GREEN;
            }
         }
      }
      
      override public function dispose() : void
      {
         Main.UserCharacter.removeChangeListener(this.onCharacterChange);
         super.dispose();
      }
      
      protected function onGridWeightChange(event:Object) : void
      {
         if(event.property == "itemsWeight")
         {
            this.refreshWeights();
         }
      }
      
      protected function onCharacterChange(event:Object) : void
      {
         if(event.property == "MaxWeight")
         {
            this.refreshWeights();
         }
      }
      
      protected function onGridChange(event:Object) : void
      {
         if(event.property == "itemsPrice")
         {
            this.botOfferPriceText.text = Chat.formatNumber(this.botOfferGrid.getInt1(this.ownTradeSkill,this.botTradeSkill));
            this.botName.text = Chat.formatNumber(this.userOfferGrid.propValue107);
         }
      }
      
      protected function refreshWeights() : void
      {
         if(this.tradeType == NPC_TRADE_CELL)
         {
            this.cellWeightButton.current = this.botGrid.itemsWeight + this.userOfferGrid.itemsWeight;
         }
         this.userWeightButton.current = Main.UserCharacter.CurrentWeight - this.userOfferGrid.itemsWeight + this.botOfferGrid.itemsWeight;
         this.userWeightButton.maxValueValue = Main.UserCharacter.MaxWeight;
      }
      
      protected function cancelHandler(sender:Object) : void
      {
         this.sendTrade();
      }
      
      protected function sendTrade() : void
      {
         GameSocket.socket.sendStr("bb|" + this.userOfferGrid.propValue75 + "|" + Chat.getString38(this.userOfferGrid.items) + Chat.getString38(this.botOfferGrid.items));
         closeMenu();
      }
      
      protected function onApplyClick(sender:Object) : void
      {
         if(this.tradeType == NPC_TRADE_BOX && this.userOfferGrid.propValue75 != 0)
         {
            showConfirm(_("IDS_BOX_BARTER_MESSAGE"),this.cancelHandler);
            return;
         }
         if(this.tradeType == NPC_TRADE_CELL)
         {
            if(this.botGrid.itemsWeight + this.userOfferGrid.itemsWeight > this.userPriceCount)
            {
               showNotification(_("IDS_CELL_OVERLOAD"));
               return;
            }
         }
         else if(this.tradeType == NPC_TRADE_BOT)
         {
            if(this.botOfferGrid.getInt1(this.ownTradeSkill,this.botTradeSkill) < this.userOfferGrid.propValue107)
            {
               showModal(new QuestionMenu(_("IDS_BARTER_WARNING"),this.cancelHandler));
               return;
            }
            if(this.botOfferGrid.getInt1(this.ownTradeSkill,this.botTradeSkill) > this.userOfferGrid.propValue107)
            {
               showNotification(_("IDS_BARTER_WARNING_1"));
               return;
            }
            if((this.userGrid.itemsWeight + this.botOfferGrid.itemsWeight) / Main.UserCharacter.MaxWeight >= 1.2)
            {
               showNotification(_("IDS_OVERLOAD_WARNING"));
               return;
            }
         }
         this.sendTrade();
      }
      
      override protected function onCloseClick(sender:Object) : void
      {
         GameSocket.socket.sendActionLeave();
         super.onCloseClick(sender);
      }
      
      protected function showLeft(sender:Object) : void
      {
         this.botOfferGrid.doAction715(this.botGrid.items);
         this.botGrid.clear();
         this.onApplyClick(null);
      }
      
      protected function showCellStatistic(sender:Object) : void
      {
         GameSocket.socket.requestCellLog(0);
      }
      
      protected function reduceOffers() : void
      {
         var botMoney:InventoryItem = null;
         var userMoney:InventoryItem = null;
         var commonCount:int = 0;
         if(this.tradeType == NPC_TRADE_BOT)
         {
            botMoney = this.botOfferGrid.getFirstItem();
            userMoney = this.userOfferGrid.getFirstItem();
            if(botMoney && userMoney)
            {
               commonCount = Math.min(botMoney.count,userMoney.count);
               if(botMoney.count > commonCount)
               {
                  this.returnItem(this.botGrid,botMoney.splitStack(commonCount));
               }
               else
               {
                  this.botOfferGrid.removeItem(botMoney);
                  this.returnItem(this.botGrid,botMoney);
               }
               if(userMoney.count > commonCount)
               {
                  this.returnItem(this.userGrid,userMoney.splitStack(commonCount));
               }
               else
               {
                  this.userOfferGrid.removeItem(userMoney);
                  this.returnItem(this.userGrid,userMoney);
               }
            }
         }
      }
      
      protected function onAutoCountClick(sender:Object) : void
      {
         var botOfferPrice:int = 0;
         var userOfferPrice:int = 0;
         var difference:int = 0;
         var moneyItem:InventoryItem = null;
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.reduceOffers();
            botOfferPrice = this.botOfferGrid.getInt1(this.ownTradeSkill,this.botTradeSkill);
            userOfferPrice = this.userOfferGrid.propValue107;
            if(botOfferPrice > userOfferPrice)
            {
               difference = botOfferPrice - userOfferPrice;
               moneyItem = this.botOfferGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count == difference)
                  {
                     this.botOfferGrid.removeItem(moneyItem);
                     this.returnItem(this.botGrid,moneyItem);
                  }
                  else if(moneyItem.count > difference)
                  {
                     this.returnItem(this.botGrid,moneyItem.splitStack(difference));
                  }
                  else
                  {
                     this.botOfferGrid.removeItem(moneyItem);
                     this.returnItem(this.botGrid,moneyItem);
                     this.onAutoCountClick(sender);
                  }
                  return;
               }
               moneyItem = this.userGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count < difference)
                  {
                     showNotification(_("IDS_NE_MONEY"));
                  }
                  else if(moneyItem.count == difference)
                  {
                     this.userGrid.removeItem(moneyItem);
                     this.addHandler(this.userOfferGrid,moneyItem);
                  }
                  else
                  {
                     this.addHandler(this.userOfferGrid,moneyItem.splitStack(difference));
                  }
               }
               else
               {
                  showNotification(_(this.userOfferGrid.getFirstItem() ? "IDS_NE_MONEY" : "IDS_NO_MONEY"));
               }
            }
            else if(botOfferPrice < userOfferPrice)
            {
               difference = userOfferPrice - botOfferPrice;
               moneyItem = this.userOfferGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count == difference)
                  {
                     this.userOfferGrid.removeItem(moneyItem);
                     this.returnItem(this.userGrid,moneyItem);
                  }
                  else if(moneyItem.count > difference)
                  {
                     this.returnItem(this.userGrid,moneyItem.splitStack(difference));
                  }
                  else
                  {
                     this.userOfferGrid.removeItem(moneyItem);
                     this.returnItem(this.userGrid,moneyItem);
                     this.onAutoCountClick(sender);
                  }
                  return;
               }
               moneyItem = this.botGrid.getFirstItem();
               if(moneyItem)
               {
                  if(moneyItem.count < difference)
                  {
                     showNotification(_("IDS_TRADE_NE_MONEY"));
                  }
                  else if(moneyItem.count == difference)
                  {
                     this.botGrid.removeItem(moneyItem);
                     this.addHandler(this.botOfferGrid,moneyItem);
                  }
                  else
                  {
                     this.addHandler(this.botOfferGrid,moneyItem.splitStack(difference));
                  }
               }
               else
               {
                  showNotification(_(this.botOfferGrid.getFirstItem() ? "IDS_TRADE_NE_MONEY" : "IDS_TRADE_NO_MONEY"));
               }
            }
         }
      }
      
      protected function onBotItemDrop(dragger:InventoryItemDragger) : void
      {
         var item:InventoryItem = null;
         if(!dragger.isActive)
         {
            item = dragger.dropItem();
            if(this.botOfferGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  this.botOfferGrid.addItem(item);
               }
               else if(item.isExpendable && item.count > 1)
               {
                  showModal(new CountMenu(item,this.onBotOfferCountSelect,this.onBotOfferCountCancel));
               }
               else
               {
                  this.addHandler(this.botOfferGrid,item);
               }
            }
            else if(this.botGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  if(item.isExpendable && item.count > 1)
                  {
                     showModal(new CountMenu(item,this.onBotReturnCountSelect,this.onBotReturnCountCancel));
                  }
                  else
                  {
                     this.returnItem(this.botGrid,item);
                  }
               }
               else
               {
                  this.botGrid.addItem(item);
               }
            }
            else if(item.questItem)
            {
               this.botOfferGrid.addItem(item);
            }
            else
            {
               this.botGrid.addItem(item);
            }
            if(this.tradeType == NPC_TRADE_BOT)
            {
               this.botGrid.getArray3(this.markItemLevel);
               this.botOfferGrid.getArray3(this.markItemLevel);
            }
         }
      }
      
      protected function onUserOfferCountSelect(countMenu:CountMenu) : void
      {
         if(countMenu.count == countMenu.item.count)
         {
            this.addHandler(this.userOfferGrid,countMenu.item);
         }
         else
         {
            this.addHandler(this.userOfferGrid,countMenu.item.splitStack(countMenu.count));
            this.returnItem(this.userGrid,countMenu.item);
         }
      }
      
      protected function addHandler(grid:ItemsGrid, item:InventoryItem) : void
      {
         item.questItem = true;
         grid.addItem(item);
      }
      
      protected function returnItem(grid:ItemsGrid, item:InventoryItem) : void
      {
         item.questItem = false;
         grid.addItem(item);
      }
      
      protected function onUserOfferCountCancel(countMenu:CountMenu) : void
      {
         this.returnItem(this.userGrid,countMenu.item);
      }
      
      protected function onUserReturnCountCancel(countMenu:CountMenu) : void
      {
         this.addHandler(this.userOfferGrid,countMenu.item);
      }
      
      protected function onBotOfferCountCancel(countMenu:CountMenu) : void
      {
         this.returnItem(this.botGrid,countMenu.item);
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.botGrid.getArray3(this.markItemLevel);
         }
      }
      
      protected function onBotReturnCountCancel(countMenu:CountMenu) : void
      {
         this.addHandler(this.botOfferGrid,countMenu.item);
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.botOfferGrid.getArray3(this.markItemLevel);
         }
      }
      
      protected function onUserReturnCountSelect(countMenu:CountMenu) : void
      {
         if(countMenu.count == countMenu.item.count)
         {
            this.returnItem(this.userGrid,countMenu.item);
         }
         else
         {
            this.returnItem(this.userGrid,countMenu.item.splitStack(countMenu.count));
            this.addHandler(this.userOfferGrid,countMenu.item);
         }
      }
      
      protected function onBotOfferCountSelect(countMenu:CountMenu) : void
      {
         if(countMenu.count == countMenu.item.count)
         {
            this.addHandler(this.botOfferGrid,countMenu.item);
         }
         else
         {
            this.addHandler(this.botOfferGrid,countMenu.item.splitStack(countMenu.count));
            this.returnItem(this.botGrid,countMenu.item);
         }
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.botGrid.getArray3(this.markItemLevel);
            this.botOfferGrid.getArray3(this.markItemLevel);
         }
      }
      
      protected function onBotReturnCountSelect(countMenu:CountMenu) : void
      {
         if(countMenu.count == countMenu.item.count)
         {
            this.returnItem(this.botGrid,countMenu.item);
         }
         else
         {
            this.returnItem(this.botGrid,countMenu.item.splitStack(countMenu.count));
            this.addHandler(this.botOfferGrid,countMenu.item);
         }
         if(this.tradeType == NPC_TRADE_BOT)
         {
            this.botGrid.getArray3(this.markItemLevel);
            this.botOfferGrid.getArray3(this.markItemLevel);
         }
      }
      
      protected function onUserItemDrop(dragger:InventoryItemDragger) : void
      {
         var item:InventoryItem = null;
         if(!dragger.isActive)
         {
            item = dragger.dropItem();
            if(this.userOfferGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  this.userOfferGrid.addItem(item);
               }
               else if(item.isExpendable && item.count > 1)
               {
                  showModal(new CountMenu(item,this.onUserOfferCountSelect,this.onUserOfferCountCancel));
               }
               else if(item.isArt && this.tradeType == NPC_TRADE_CELL && (this.botPriceCount >= 2 && this.botPriceCount <= 4))
               {
                  this.returnItem(this.userGrid,item);
               }
               else
               {
                  this.addHandler(this.userOfferGrid,item);
               }
            }
            else if(this.userGrid.isMouseOver)
            {
               if(item.questItem)
               {
                  if(item.isExpendable && item.count > 1)
                  {
                     showModal(new CountMenu(item,this.onUserReturnCountSelect,this.onUserReturnCountCancel));
                  }
                  else
                  {
                     this.returnItem(this.userGrid,item);
                  }
               }
               else
               {
                  this.userGrid.addItem(item);
               }
            }
            else if(item.questItem)
            {
               this.userOfferGrid.addItem(item);
            }
            else
            {
               this.userGrid.addItem(item);
            }
         }
      }
      
      protected function onBGraphicsClick(sender:Object) : void
      {
         if(this.userGrid.style == ItemsList.STYLE_LARGE)
         {
            this.botOfferGrid.style = this.userOfferGrid.style = this.botGrid.style = this.userGrid.style = ItemsList.STYLE_TEXT;
         }
         else
         {
            this.botOfferGrid.style = this.userOfferGrid.style = this.botGrid.style = this.userGrid.style = ItemsList.STYLE_LARGE;
         }
      }
      
      protected function onUserOfferItemSelect(listItem:ItemsList) : void
      {
         if(this.botDragger.isActive && this.userDragger.isActive)
         {
            this.userDragger.startDragItem(listItem.item,listItem.image);
            this.userDragger.setPos(this.userOfferGrid.x + listItem.x,this.userOfferGrid.y + listItem.y - this.userOfferGrid.scrollV);
            this.userOfferGrid.removeItem(listItem.item);
         }
      }
      
      protected function onBotOfferItemSelect(listItem:ItemsList) : void
      {
         if(this.botDragger.isActive && this.userDragger.isActive)
         {
            this.botDragger.startDragItem(listItem.item,listItem.image);
            this.botDragger.setPos(this.botOfferGrid.x + listItem.x,this.botOfferGrid.y + listItem.y - this.botOfferGrid.scrollV);
            this.botOfferGrid.removeItem(listItem.item);
         }
      }
      
      protected function onUserItemSelect(listItem:ItemsList) : void
      {
         if(this.botDragger.isActive && this.userDragger.isActive)
         {
            this.userDragger.startDragItem(listItem.item,listItem.image);
            this.userDragger.setPos(this.userGrid.x + listItem.x,this.userGrid.y + listItem.y - this.userGrid.scrollV);
            this.userGrid.removeItem(listItem.item);
         }
      }
      
      protected function onBotItemSelect(listItem:ItemsList) : void
      {
         if(this.botDragger.isActive && this.userDragger.isActive)
         {
            this.botDragger.startDragItem(listItem.item,listItem.image);
            this.botDragger.setPos(this.botGrid.x + listItem.x,this.botGrid.y + listItem.y - this.botGrid.scrollV);
            this.botGrid.removeItem(listItem.item);
         }
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

