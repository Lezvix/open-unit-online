package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.system.EventListeners;
   import events.*;
   import flash.display.Bitmap;
   import flash.events.*;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import game.*;
   import ui.*;
   
   public class Inventory extends NuclearSprite
   {
      
      private static const WIDTH:int = 685;
      
      private static const HEIGHT:int = 373;
      
      private static const LEFT_PANEL_WIDTH:int = 262;
      
      private static const LEFT_PANEL_373:int = 373;
      
      private static const RIGHT_PANEL_WIDTH:int = 436;
      
      private static const LEFT_PANEL_362:int = 362;
      
      private static const INVENTORY_CONST1:int = WIDTH - RIGHT_PANEL_WIDTH;
      
      private static const LEFT_PANEL_8M2:int = (HEIGHT - LEFT_PANEL_362) / 2;
      
      private static var flag141:Boolean = false;
      
      private var nuiComponent16:NUIComponent;
      
      private var itemsListList1:Vector.<ItemsList> = new Vector.<ItemsList>(NuclearEPanel.QUICK_SLOTS_COUNT);
      
      private var inventoryItemList2:Vector.<InventoryItem> = new Vector.<InventoryItem>(Character.IDX_COUNT);
      
      private var weapon1Slot:ItemSlot;
      
      private var weapon2Slot:ItemSlot;
      
      private var itemSlot2:ItemSlot;
      
      private var gameBitmap1:GameBitmap;
      
      private var currentWeapon:InventoryItem;
      
      private var armorClassText:TextField;
      
      private var textField39:TextField;
      
      private var items:Vector.<InventoryItem> = new Vector.<InventoryItem>();
      
      private var inventoryGrid:ItemsGrid;
      
      private var itemInfoMenu:ItemInfo;
      
      private var weightButton:WeightButton;
      
      private var dragger:InventoryItemDragger = new InventoryItemDragger();
      
      private var invCloseButton:NButton;
      
      private var flag58:Boolean = false;
      
      public function Inventory(param1:Object)
      {
         Main.instance.checkTutorialSelector(GameConsts.GAME_CONSTS_CONST2);
         super(TYPE_INVENTORY);
         w = WIDTH;
         h = HEIGHT;
         fillBg(INVENTORY_CONST1 + 4,LEFT_PANEL_8M2 + 4,RIGHT_PANEL_WIDTH - 8,LEFT_PANEL_362 - 8);
         draw(getBmp("BUTTON_BG"),INVENTORY_CONST1 + 13,LEFT_PANEL_8M2 + 12);
         drawFrame(INVENTORY_CONST1,LEFT_PANEL_8M2,RIGHT_PANEL_WIDTH,LEFT_PANEL_362);
         var bottomPanelY:int = LEFT_PANEL_8M2 + LEFT_PANEL_362 - 57;
         drawTile(bitmap14,INVENTORY_CONST1 + 10 + bitmap17.width,bottomPanelY,RIGHT_PANEL_WIDTH - 24,bitmap14.height);
         draw(bitmap17,INVENTORY_CONST1 + 10,bottomPanelY);
         draw(frameRightBmp,WIDTH - bitmap17.width - frameLeft.width + 7,bottomPanelY);
         fillBg(4,4,LEFT_PANEL_WIDTH - 8,LEFT_PANEL_373 - 8);
         draw(getBmp("INV_WINDOW_BG"),7,31);
         drawFrame(0,0,LEFT_PANEL_WIDTH,LEFT_PANEL_373);
         this.weightButton = new WeightButton(0,Main.UserCharacter.MaxWeight,120,true);
         this.weightButton.setPos(WIDTH - bitmap17.width - frameLeft.width - 95,bottomPanelY);
         addUIChild(this.weightButton);
         var quickPanelTile:Bitmap = getBmp("INV_QUICK_P_TILE");
         this.nuiComponent16 = new NUIComponent();
         this.nuiComponent16.setPos(INVENTORY_CONST1 + 9 + bitmap17.width,bottomPanelY + bitmap14.height);
         this.nuiComponent16.setSize(RIGHT_PANEL_WIDTH - 24,quickPanelTile.height);
         addUIChild(this.nuiComponent16);
         this.nuiComponent16.drawTile(quickPanelTile,0,0,this.nuiComponent16.width,this.nuiComponent16.height);
         var quickSlotBitmap:Bitmap = getBmp("INV_QUICK_P_BUTTON");
         var index:int = 0;
         while(index < NuclearEPanel.QUICK_SLOTS_COUNT)
         {
            this.nuiComponent16.draw(quickSlotBitmap,index * (quickSlotBitmap.width + 1),2);
            this.nuiComponent16.draw(getBmp("QP_" + (index + 1) % 10),index * (quickSlotBitmap.width + 1) + (quickSlotBitmap.width - 25) / 2,2);
            index++;
         }
         addTextLabel(16,16,_("IDS_INVENTORY"),NTextFormat.titleFormat,LEFT_PANEL_WIDTH - 32);
         var armorLabel:TextField = createLabel(28,LEFT_PANEL_373 - 32,_("IDS_AC") + ":",NTextFormat.normal.strong);
         addChild(armorLabel);
         this.armorClassText = createLabel(armorLabel.x + armorLabel.textWidth + 20,armorLabel.y,"?",NTextFormat.normal.strong);
         addChild(this.armorClassText);
         this.textField39 = createLabel(this.armorClassText.x + this.armorClassText.textWidth + 5,armorLabel.y,"(?)",NTextFormat.normal.derive({
            "color":16731648,
            "bold":true
         }));
         addChild(this.textField39);
         this.weapon1Slot = new ItemSlot();
         this.weapon1Slot.setPos(142,83);
         this.weapon1Slot.showInfoButton(this.onInfoClick);
         this.weapon1Slot.mouseDown = this.weaponSlot1MouseDown;
         addUIChild(this.weapon1Slot);
         this.weapon2Slot = new ItemSlot();
         this.weapon2Slot.setPos(this.weapon1Slot.x,152);
         this.weapon2Slot.showInfoButton(this.onInfoClick);
         this.weapon2Slot.mouseDown = this.weaponSlot2MouseDown;
         addUIChild(this.weapon2Slot);
         this.itemSlot2 = new ItemSlot();
         this.itemSlot2.setPos(this.weapon2Slot.x,237);
         this.itemSlot2.showInfoButton(this.onInfoClick);
         this.itemSlot2.mouseDown = this.onMouseDown4;
         addUIChild(this.itemSlot2);
         addTextLabel(this.itemSlot2.x,296,_("IDS_INV_TYPE_9"),NTextFormat.normal.center,this.itemSlot2.width);
         this.gameBitmap1 = new GameBitmap();
         this.gameBitmap1.onMouseDown = this.onOnMouseDown;
         addUIChild(this.gameBitmap1);
         this.gameBitmap1.setPos(30,50);
         this.gameBitmap1.doAction945(Main.UserCharacter);
         this.gameBitmap1.doAction698();
         this.invCloseButton = new NButton(this.onCloseClick,getBmp("INV_CLOSE_BUTTON"),getBmp("INV_CLOSE_BUTTON_OVER"),getBmp("INV_CLOSE_BUTTON_PRESSED"));
         this.invCloseButton.setPos(WIDTH - 49,LEFT_PANEL_8M2 + 11);
         addUIChild(this.invCloseButton);
         var viewButton:NButton = new NButton(this.onBGraphicsClick,getBmp("B_GRAPHICS"),getBmp("B_GRAPHICS_OVER"),getBmp("B_GRAPHICS_PRESSED"));
         viewButton.setPos(WIDTH - 49,LEFT_PANEL_8M2 + 28);
         addUIChild(viewButton);
         this.inventoryGrid = new ItemsGrid(LEFT_PANEL_362 - 117);
         this.inventoryGrid.setPos(INVENTORY_CONST1 + 19,LEFT_PANEL_8M2 + 55);
         this.inventoryGrid.doAction808(this.onInfoClick);
         this.inventoryGrid.doAction93(this.repairHandler);
         this.inventoryGrid.doAction606(this.openPresentHandler);
         this.inventoryGrid.propValue49 = this.onShopItemSelect;
         var itemData:Array = param1.data;
         index = 2;
         while(index < itemData.length - 1)
         {
            recordLength = itemData[index];
            item = new InventoryItem(itemData.slice(index,index + recordLength));
            this.items.push(item);
            this.doAction274(item);
            index += recordLength;
         }
         var weaponSlot:ItemSlot = Main.instance.currentWeapon == 0 ? this.weapon1Slot : this.weapon2Slot;
         this.currentWeapon = weaponSlot.item;
         this.inventoryGrid.selectHandler = Chat.getInt45;
         addUIChild(this.inventoryGrid);
         var filterPanel:InventoryFilterPanel = new InventoryFilterPanel(this.inventoryGrid,InventoryFilterPanel.HORIZONTAL);
         var recordLength:int;
         var item:InventoryItem;
         filterPanel.setPos(INVENTORY_CONST1 + 28,LEFT_PANEL_8M2 + 11);
         addUIChild(filterPanel);
         this.itemInfoMenu = new ItemInfo();
         addUIChild(this.itemInfoMenu);
         this.doAction359();
         this.doAction521();
         UnitEventDispatcher.instance.addListener(EventType.EffectRemoved,this.doAction504);
         UnitEventDispatcher.instance.addListener(EventType.EffectUpdated,this.doAction504);
         UnitEventDispatcher.instance.addListener(EventType.eventType1,this.doAction521);
         Main.UserCharacter.addChangeListener(this.doAction394);
         this.dragger.dropHandler = this.onShopItemDrop;
         addUIChild(this.dragger);
         height = HEIGHT;
         EventListeners.addEventListener(Main.instance.stage,KeyboardEvent.KEY_DOWN,this.doAction462);
         EventListeners.addEventListener(Main.instance.stage,KeyboardEvent.KEY_UP,this.handleKeyUp);
         flag141 = flag141 || Main.UserCharacter.level > 0;
         if(!flag141)
         {
            Main.instance.removeTutorialSelector();
            this.tutorHighligt(GameConsts.RAM_2);
         }
      }
      
      protected function doAction462(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SHIFT)
         {
            flag58 = true;
         }
      }
      
      protected function handleKeyUp(param1:KeyboardEvent) : void
      {
         flag58 = false;
      }
      
      override public function tutorHighligt(param1:int) : void
      {
         var item:InventoryItem = null;
         var itemView:ItemsList = null;
         switch(param1)
         {
            case GameConsts.RAM_2:
               item = this.inventoryGrid.getInventoryItem1(InventoryItem.EXPENDABLES_HEIGHT);
               if(item != null && item.status == InventoryItem.FIRE_SINGLE)
               {
                  itemView = this.inventoryGrid.getItemsList1(item);
                  Main.instance.doAction131(0,0,itemView.width,itemView.height,itemView,15);
               }
               break;
            case GameConsts.RAM_BOTTOM:
               Main.instance.doAction131(this.weapon1Slot.x,this.weapon1Slot.y,this.weapon1Slot.width,this.weapon1Slot.height,this,15);
               break;
            case GameConsts.RAM_3:
               Main.instance.doAction131(this.invCloseButton.x,this.invCloseButton.y,this.invCloseButton.width,this.invCloseButton.height,this,20);
               break;
         }
      }
      
      protected function onShopItemSelect(param1:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            if(this.flag58)
            {
               ChatPanel.instance.doAction221(" " + param1.item.itemname + (param1.item.count > 1 ? " x" + Chat.formatNumber(param1.item.count) : ""));
            }
            else
            {
               this.dragger.startDragItem(param1.item,param1.image);
               this.dragger.setPos(this.inventoryGrid.x + param1.x,this.inventoryGrid.y + param1.y - this.inventoryGrid.scrollV);
               if(!flag141 && param1.item.itemId == InventoryItem.EXPENDABLES_HEIGHT)
               {
                  Main.instance.addTutorialSelector(GameConsts.RAM_BOTTOM);
               }
               this.inventoryGrid.removeItem(param1.item);
            }
         }
      }
      
      protected function onMouseDown5(param1:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.item,param1.image);
            this.dragger.setPos(this.nuiComponent16.x + param1.x,this.nuiComponent16.y + param1.y);
            this.nuiComponent16.removeUIChild(param1);
            this.itemsListList1[param1.item.status - 1] = null;
         }
      }
      
      protected function weaponSlot1MouseDown(param1:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.item,param1.image);
            this.dragger.setPos(this.weapon1Slot.x + param1.x,this.weapon1Slot.y + param1.y);
            this.weapon1Slot.removeItem();
         }
      }
      
      protected function weaponSlot2MouseDown(param1:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.item,param1.image);
            this.dragger.setPos(this.weapon2Slot.x + param1.x,this.weapon2Slot.y + param1.y);
            this.weapon2Slot.removeItem();
         }
      }
      
      protected function onMouseDown4(param1:ItemsList) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.item,param1.image);
            this.dragger.setPos(this.itemSlot2.x + param1.x,this.itemSlot2.y + param1.y);
            this.itemSlot2.removeItem();
         }
      }
      
      protected function onShopItemDrop(param1:InventoryItemDragger) : void
      {
         var draggedItem:InventoryItem = null;
         var slotIndex:int = 0;
         var itemView:ItemsList = null;
         if(!param1.isActive)
         {
            draggedItem = param1.dropItem();
            if(!this.includesMouse())
            {
               if(draggedItem.type == InventoryItem.TYPE_ITEM_PRESENT)
               {
                  showNotification(_("IDS_DROP_PRESENT"));
                  this.doAction274(draggedItem);
               }
               else if(draggedItem.isChanged)
               {
                  showNotification(_("IDS_DROP_QUEST"));
                  this.doAction274(draggedItem);
               }
               else if(draggedItem.loadStatus != InventoryItem.FIRE_SINGLE)
               {
                  showNotification(_("IDS_DROP_WEAR"));
                  this.doAction274(draggedItem);
               }
               else
               {
                  showModal(new QuestionMenu(_("IDS_DROP_WARNING",draggedItem.itemname),this.getFunction2(draggedItem),this.getFunction1(draggedItem)));
               }
            }
            else if(this.inventoryGrid.isMouseOver)
            {
               this.returnItem(draggedItem);
            }
            else if(this.weapon1Slot.isMouseOver)
            {
               if(draggedItem.isWeapon && this.check1(draggedItem))
               {
                  if(this.weapon1Slot.isActive)
                  {
                     this.weapon1Slot.insertItem(draggedItem);
                  }
                  else
                  {
                     this.returnItem(this.weapon1Slot.replaceItem(draggedItem));
                  }
                  if(!flag141 && draggedItem.itemId == InventoryItem.EXPENDABLES_HEIGHT)
                  {
                     Main.instance.addTutorialSelector(GameConsts.RAM_3);
                  }
                  draggedItem.status = InventoryItem.WEAPON_TYPE_SINGLE;
               }
               else if(draggedItem.type == InventoryItem.TYPE_AMMO && !this.weapon1Slot.isActive && this.weapon1Slot.item.params[InventoryItem.WP_AMMO_TYPE] == draggedItem.params[InventoryItem.AMP_TYPE])
               {
                  this.sendConfirm(0,draggedItem.inventoryId);
               }
               else
               {
                  this.doAction274(draggedItem);
               }
            }
            else if(this.weapon2Slot.isMouseOver)
            {
               if(draggedItem.isWeapon && this.check1(draggedItem))
               {
                  if(!flag141 && draggedItem.itemId == InventoryItem.EXPENDABLES_HEIGHT)
                  {
                     this.doAction274(draggedItem);
                     return;
                  }
                  if(this.weapon2Slot.isActive)
                  {
                     this.weapon2Slot.insertItem(draggedItem);
                  }
                  else
                  {
                     this.returnItem(this.weapon2Slot.replaceItem(draggedItem));
                  }
                  draggedItem.status = InventoryItem.WEAPON_TYPE_HALFAUTO;
               }
               else if(draggedItem.type == InventoryItem.TYPE_AMMO && !this.weapon2Slot.isActive && this.weapon2Slot.item.params[InventoryItem.WP_AMMO_TYPE] == draggedItem.params[InventoryItem.AMP_TYPE])
               {
                  this.sendConfirm(1,draggedItem.inventoryId);
               }
               else
               {
                  this.doAction274(draggedItem);
               }
            }
            else if(this.itemSlot2.isMouseOver)
            {
               if(draggedItem.type == InventoryItem.TYPE_ADDON && this.check1(draggedItem))
               {
                  if(this.itemSlot2.isActive)
                  {
                     this.itemSlot2.insertItem(draggedItem);
                  }
                  else
                  {
                     this.returnItem(this.itemSlot2.replaceItem(draggedItem));
                  }
                  draggedItem.status = InventoryItem.WEAPON_TYPE_SINGLE;
               }
               else
               {
                  this.doAction274(draggedItem);
               }
            }
            else if(this.gameBitmap1.mouseX >= 0 && this.gameBitmap1.mouseX < 100 && this.gameBitmap1.mouseY >= 0 && this.gameBitmap1.mouseY <= 270)
            {
               if(draggedItem.isValue59 && this.check1(draggedItem))
               {
                  if(this.inventoryItemList2[InventoryItem.array83[draggedItem.type]] != null)
                  {
                     this.gameBitmap1.doAction657(this.inventoryItemList2[InventoryItem.array83[draggedItem.type]]);
                     this.returnItem(this.inventoryItemList2[InventoryItem.array83[draggedItem.type]]);
                  }
                  this.gameBitmap1.doAction211(draggedItem);
                  this.inventoryItemList2[InventoryItem.array83[draggedItem.type]] = draggedItem;
                  draggedItem.status = InventoryItem.WEAPON_TYPE_SINGLE;
                  this.doAction359();
               }
               else
               {
                  this.doAction274(draggedItem);
               }
            }
            else if(this.nuiComponent16.isMouseOver)
            {
               if(draggedItem.isValue67 && this.check1(draggedItem))
               {
                  slotIndex = this.nuiComponent16.mouseX / (this.nuiComponent16.width / NuclearEPanel.QUICK_SLOTS_COUNT);
                  if(this.itemsListList1[slotIndex] != null)
                  {
                     this.returnItem(this.itemsListList1[slotIndex].item);
                     this.nuiComponent16.removeUIChild(this.itemsListList1[slotIndex]);
                  }
                  itemView = new ItemsList(draggedItem,ItemsList.STYLE_MINI);
                  itemView.mouseDown = this.onMouseDown5;
                  itemView.setPos(slotIndex * 41,2);
                  this.itemsListList1[slotIndex] = itemView;
                  this.nuiComponent16.addUIChild(itemView);
                  draggedItem.status = 1 + slotIndex;
               }
               else
               {
                  this.doAction274(draggedItem);
               }
            }
            else
            {
               this.doAction274(draggedItem);
            }
         }
      }
      
      protected function sendConfirm(param1:int, param2:int) : void
      {
         var statusChanges:String = "";
         var itemIndex:int = 0;
         while(itemIndex < this.items.length)
         {
            if(this.items[itemIndex].statusChanged)
            {
               statusChanges += this.items[itemIndex].inventoryId + "|" + this.items[itemIndex].status + "|";
            }
            itemIndex++;
         }
         if(statusChanges || param2 != 0)
         {
            GameSocket.socket.sendStr("ia|" + param1 + "|" + param2 + "|" + statusChanges);
         }
         closeMenu();
      }
      
      protected function doAction274(param1:InventoryItem) : void
      {
         var itemView:ItemsList = null;
         if(param1.status == InventoryItem.FIRE_SINGLE)
         {
            this.returnItem(param1);
         }
         else if(param1.status != InventoryItem.FIRE_SINGLE)
         {
            if(param1.isWeapon)
            {
               if(param1.status == InventoryItem.WEAPON_TYPE_SINGLE && this.weapon1Slot.isActive && this.check1(param1,false))
               {
                  this.weapon1Slot.insertItem(param1);
               }
               else if(param1.status == InventoryItem.WEAPON_TYPE_HALFAUTO && this.weapon2Slot.isActive && this.check1(param1,false))
               {
                  this.weapon2Slot.insertItem(param1);
               }
               else
               {
                  this.returnItem(param1);
               }
            }
            else if(param1.type == InventoryItem.TYPE_ADDON && param1.status == InventoryItem.WEAPON_TYPE_SINGLE && this.itemSlot2.isActive && this.check1(param1,false))
            {
               this.itemSlot2.insertItem(param1);
            }
            else if(param1.isValue59 && param1.status == InventoryItem.WEAPON_TYPE_SINGLE && this.inventoryItemList2[InventoryItem.array83[param1.type]] == null && this.check1(param1,false))
            {
               this.gameBitmap1.doAction211(param1);
               this.inventoryItemList2[InventoryItem.array83[param1.type]] = param1;
               this.doAction359();
            }
            else if(param1.isValue67 && this.itemsListList1[param1.status - 1] == null)
            {
               itemView = new ItemsList(param1,ItemsList.STYLE_MINI);
               itemView.mouseDown = this.onMouseDown5;
               itemView.setPos((param1.status - 1) * 41,2);
               this.itemsListList1[param1.status - 1] = itemView;
               this.nuiComponent16.addUIChild(itemView);
            }
            else
            {
               this.returnItem(param1);
            }
         }
      }
      
      protected function returnItem(param1:InventoryItem) : void
      {
         param1.status = InventoryItem.FIRE_SINGLE;
         this.inventoryGrid.addItem(param1);
         if(!flag141 && param1.itemId == InventoryItem.EXPENDABLES_HEIGHT)
         {
            Main.instance.addTutorialSelector(GameConsts.RAM_2);
         }
      }
      
      private function getInt4(param1:int) : int
      {
         var skillAdjustment:int = 0;
         var skillType:int;
         var skillValue:int;
         if(this.currentWeapon && (this.currentWeapon.type === InventoryItem.TYPE_RARE_20 || this.currentWeapon.type === InventoryItem.TYPE_TOOL))
         {
            if(this.currentWeapon.type === InventoryItem.TYPE_TOOL)
            {
               skillType = 7;
               skillValue = this.currentWeapon.params[InventoryItem.TP_HARVESTER_ADD];
            }
            else
            {
               skillType = this.currentWeapon.params[InventoryItem.STP_CLEARING_SPEED];
               skillValue = this.currentWeapon.params[InventoryItem.STP_BLOW_PROBABILITY];
            }
            if(skillType > 3 && skillType === param1)
            {
               skillAdjustment = skillValue;
            }
         }
         return Main.UserCharacter.skills[param1] / 10000 - skillAdjustment;
      }
      
      protected function check1(param1:InventoryItem, param2:Boolean = true) : Boolean
      {
         var skillType:int = 0;
         var requiredSkill:int = 0;
         switch(param1.type)
         {
            case InventoryItem.TYPE_HELMET:
            case InventoryItem.TYPE_ARMOR:
            case InventoryItem.TYPE_PANTS:
            case InventoryItem.TYPE_BOOTS:
               if(param1.params[InventoryItem.WEAPON_PENALTY_8] != 0 && param1.params[InventoryItem.WEAPON_PENALTY_8] - 1 != Main.UserCharacter.sex)
               {
                  return false;
               }
               break;
            case InventoryItem.TYPE_WEAPON:
            case InventoryItem.TYPE_RARE_20:
               skillType = param1.params[InventoryItem.WP_SKILL_TYPE];
               requiredSkill = param1.params[InventoryItem.WP_SKILL_VALUE];
               if(skillType > 3 && this.getInt4(skillType) < requiredSkill)
               {
                  if(param2)
                  {
                     showNotification(formatString("IDS_LOW_SKILL",skillType));
                  }
                  return false;
               }
               break;
            case InventoryItem.TYPE_GRENADE:
            case InventoryItem.TYPE_MEDICINE:
            case InventoryItem.TYPE_MINE:
            case InventoryItem.TYPE_SAPPER_TOOL:
            case InventoryItem.TYPE_TOOL:
            case InventoryItem.TYPE_ADDON:
            case InventoryItem.TYPE_RARE_21:
               break;
            default:
               return false;
         }
         if(param1.level > Main.UserCharacter.level)
         {
            if(param2)
            {
               showNotification(_("IDS_LOW_LEVEL",param1.level));
            }
            return false;
         }
         if(param1.propValue95 > Main.UserCharacter.Rank)
         {
            if(param2)
            {
               showNotification(_("IDS_LOW_PVP_RANK"));
            }
            return false;
         }
         if(param1.hasDurability && param1.tear == 0)
         {
            if(param2)
            {
               showNotification(_("IDS_BROKEN_ITEM"));
            }
            return false;
         }
         return true;
      }
      
      private function onOnMouseDown(param1:Object) : void
      {
         var slotIndex:int = 0;
         var draggedItem:InventoryItem = null;
         if(this.dragger.isActive)
         {
            slotIndex = this.gameBitmap1.getInt37();
            if(slotIndex != -1 && this.inventoryItemList2[slotIndex])
            {
               draggedItem = this.inventoryItemList2[slotIndex];
               this.inventoryItemList2[slotIndex] = null;
               this.dragger.startDragItem(draggedItem,this.gameBitmap1.image);
               this.dragger.setPos(this.gameBitmap1.x,this.gameBitmap1.y);
               this.gameBitmap1.doAction657(draggedItem);
               this.doAction359();
            }
         }
      }
      
      private function doAction504(param1:Object) : void
      {
         if(param1["type"] == Effect.ARMOR_DISRUPTION || param1["type"] == Effect.EffectCount)
         {
            this.doAction359();
         }
         this.doAction521(param1);
      }
      
      private function doAction521(param1:Object = null) : void
      {
         this.weightButton.current = Main.UserCharacter.CurrentWeight;
         this.weightButton.maxValueValue = Main.UserCharacter.MaxWeight;
      }
      
      protected function doAction359() : void
      {
         var baseArmor:int = 0;
         var setBonus:int = 0;
         var armorClasses:Array = [-1,-1,-1];
         var classCounts:Array = [0,0,0];
         var classArmor:Array = [0,0,0];
         var itemIndex:int = 0;
         var armorItem:InventoryItem;
         var classIndex:int;
         while(itemIndex < this.inventoryItemList2.length)
         {
            if(this.inventoryItemList2[itemIndex])
            {
               armorItem = this.inventoryItemList2[itemIndex];
               baseArmor += int(armorItem.params[InventoryItem.WEAPON_PENALTY_MEDIUM]);
               if(armorItem.itemClass != 0)
               {
                  classIndex = 0;
                  while(classIndex < 3)
                  {
                     if(armorClasses[classIndex] == -1 || armorClasses[classIndex] == armorItem.itemClass)
                     {
                        armorClasses[classIndex] = armorItem.itemClass;
                        classCounts[classIndex]++;
                        classArmor[classIndex] += int(armorItem.params[InventoryItem.WEAPON_PENALTY_MEDIUM]);
                        break;
                     }
                     classIndex++;
                  }
               }
            }
            itemIndex++;
         }
         itemIndex = 0;
         while(itemIndex < 3)
         {
            if(armorClasses[itemIndex] != -1 && classCounts[itemIndex] >= 2)
            {
               setBonus += int(classArmor[itemIndex] * InventoryItem.array81[classCounts[itemIndex] - 2]);
            }
            itemIndex++;
         }
         this.setArmorClass(baseArmor,setBonus);
      }
      
      protected function onBGraphicsClick(param1:Object) : void
      {
         this.inventoryGrid.style = this.inventoryGrid.style == ItemsList.STYLE_LARGE ? ItemsList.STYLE_TEXT : ItemsList.STYLE_LARGE;
      }
      
      protected function openPresentHandler(param1:NButton) : void
      {
         var item:InventoryItem = param1.value as InventoryItem;
         GameSocket.socket.sendChangeFire(item.inventoryId);
      }
      
      protected function repairHandler(param1:NButton) : void
      {
         var item:InventoryItem = param1.value as InventoryItem;
         var sparesId:int = item.sparesId;
         var spares:InventoryItem = null;
         var itemIndex:int = 0;
         while(itemIndex < this.items.length)
         {
            if(this.items[itemIndex].itemId == sparesId)
            {
               spares = this.items[itemIndex];
               break;
            }
            itemIndex++;
         }
         var repairCost:int = item.getRepairCost(Main.UserCharacter.skills[Character.SKILL_REPAIR] / 10000);
         if(item.repairType == InventoryItem.set)
         {
            if(spares)
            {
               if(repairCost <= spares.count)
               {
                  showConfirm(_("IDS_REPAIR_REAL",item.itemname,repairCost),this.getFunction3(item.inventoryId));
               }
               else
               {
                  showNotification(_("IDS_NOT_ENOUGHT_FIX_PACK",repairCost));
               }
            }
            else
            {
               showNotification(_("IDS_NO_FIX_PACK"));
            }
         }
         else if(item.repairType == InventoryItem.TRAUM_LIGHT)
         {
            if(spares)
            {
               if(repairCost <= spares.count)
               {
                  showConfirm(_("IDS_REPAIR_NORMAL",item.itemname,repairCost),this.getFunction3(item.inventoryId));
               }
               else
               {
                  showNotification(_("IDS_NOT_ENOUGHT_SPARES",repairCost));
               }
            }
            else
            {
               showNotification(_("IDS_NO_SPARES"));
            }
         }
      }
      
      protected function getFunction3(inventoryId:int) : Function
      {
         return function(param1:Object):void
         {
            GameSocket.socket.sendVisualState(inventoryId);
         };
      }
      
      public function itemRepaired(param1:int, param2:int) : void
      {
         var repairedItem:InventoryItem = null;
         var itemIndex:int = 0;
         var sparesId:int;
         while(itemIndex < this.items.length)
         {
            if(this.items[itemIndex].inventoryId == param1)
            {
               repairedItem = this.items[itemIndex];
               break;
            }
            itemIndex++;
         }
         if(repairedItem)
         {
            repairedItem.tear = 100;
            sparesId = repairedItem.sparesId;
            itemIndex = 0;
            while(itemIndex < this.items.length)
            {
               if(this.items[itemIndex].itemId == sparesId)
               {
                  if(param2 > 0)
                  {
                     this.items[itemIndex].count = param2;
                  }
                  else
                  {
                     this.inventoryGrid.doAction713([this.items[itemIndex]]);
                     this.items.splice(itemIndex,1);
                  }
                  break;
               }
               itemIndex++;
            }
         }
      }
      
      protected function onInfoClick(param1:NButton) : void
      {
         var item:InventoryItem = param1.value as InventoryItem;
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
      
      public function setArmorClass(param1:int, param2:int) : void
      {
         param1 = Math.min(999,param1 + param2);
         var modifierPercent:int = 0;
         if(Main.UserCharacter.hasPerk(Character.PERK_SHELL))
         {
            modifierPercent += 7;
         }
         if(Main.UserCharacter.hasAbility(Character.ABILITY_ARMOR_CLASS))
         {
            modifierPercent += 5;
         }
         var effect:Object = Main.UserCharacter.getEffect(Effect.ARMOR_DISRUPTION);
         if(effect)
         {
            modifierPercent -= effect.param;
         }
         effect = Main.UserCharacter.getEffect(Effect.EFFECT_CONST11);
         if(effect)
         {
            modifierPercent += effect.param;
         }
         effect = Main.UserCharacter.getEffect(Effect.EffectCount);
         if(effect)
         {
            modifierPercent -= effect.param >> 24 & 0xFF;
         }
         modifierPercent = Math.max(-100,modifierPercent);
         if(modifierPercent != 0)
         {
            param1 *= (100 + modifierPercent) / 100;
         }
         param1 = Math.max(0,Math.min(999,param1));
         this.armorClassText.text = param1.toString();
         this.armorClassText.width = this.armorClassText.textWidth + 5;
         this.textField39.text = param2 > 0 ? "(" + param2 + ")" : "";
         this.textField39.width = this.textField39.textWidth + 5;
         this.textField39.x = this.armorClassText.x + this.armorClassText.textWidth + 5;
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && (mouseY >= 0 && mouseX >= 0 && mouseX <= LEFT_PANEL_WIDTH && mouseY <= LEFT_PANEL_373 || mouseY >= LEFT_PANEL_8M2 && mouseX >= INVENTORY_CONST1 && mouseX <= WIDTH && mouseY < LEFT_PANEL_8M2 + LEFT_PANEL_362);
      }
      
      override public function dispose() : void
      {
         EventListeners.removeEventListener(stage,KeyboardEvent.KEY_DOWN,this.doAction462);
         EventListeners.removeEventListener(stage,KeyboardEvent.KEY_UP,this.handleKeyUp);
         UnitEventDispatcher.instance.removeListener(EventType.EffectUpdated,this.doAction504);
         UnitEventDispatcher.instance.removeListener(EventType.EffectRemoved,this.doAction504);
         UnitEventDispatcher.instance.removeListener(EventType.eventType1,this.doAction521);
         Main.UserCharacter.removeChangeListener(this.doAction394);
         this.itemInfoMenu.close();
         super.dispose();
      }
      
      protected function doAction394(param1:Object) : void
      {
         if(param1.property == "MaxWeight" || param1.property == "CurrentWeight")
         {
            this.doAction521();
         }
      }
      
      override protected function onCloseClick(param1:Object) : void
      {
         if(!flag141 && !this.weapon1Slot.isActive && this.weapon1Slot.item.itemId == InventoryItem.EXPENDABLES_HEIGHT)
         {
            flag141 = true;
         }
         this.sendConfirm(0,0);
         super.onCloseClick(param1);
      }
      
      protected function getFunction2(item:InventoryItem) : Function
      {
         return function(param1:Object):void
         {
            if(item.count > 1)
            {
               showModal(new CountMenu(item,doAction168,getFunction1(item)));
            }
            else
            {
               items.splice(items.indexOf(item),1);
               GameSocket.socket.doAction90(item.inventoryId,1);
            }
         };
      }
      
      protected function doAction168(param1:CountMenu) : void
      {
         var count:int = param1.count;
         if(count == param1.item.count)
         {
            this.items.splice(this.items.indexOf(param1.item),1);
         }
         else
         {
            param1.item.count -= count;
            this.doAction274(param1.item);
         }
         GameSocket.socket.doAction90(param1.item.inventoryId,count);
      }
      
      protected function getFunction1(item:InventoryItem) : Function
      {
         return function(param1:Object):void
         {
            doAction274(item);
         };
      }
   }
}

