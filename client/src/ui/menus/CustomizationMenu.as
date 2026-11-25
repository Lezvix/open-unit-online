package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import game.npc.PlayerItem;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import game.*;
   import ui.*;
   
   public class CustomizationMenu extends TitledMenu
   {
      
      [Embed(source="/assets/CustomizationMenu_IMG_15.png")]
      
      private static const IMG_15:Class;
      
      private static const PREVIEW_BG:Bitmap = new IMG_15();
      
      private const WIDTH:int = 690;
      
      private const HEIGHT:int = 390;
      
      private var items:DefaultsProxy;
      
      private var typeLabels:DefaultsProxy;
      
      private var _currentItem:InventoryItem = null;
      
      private var currentType:int = -1;
      
      private var shop:Object;
      
      private var categoryLabels:Object;
      
      private var gameMoney:int = 0;
      
      private var goldMoney:int = 0;
      
      private var typeDropDown:DropDown;
      
      private var categoryDropDown:DropDown;
      
      private var colorDropDown:DropDown;
      
      private var itemSlot:ItemSlot;
      
      private var goldCheckBox:NCheckBox;
      
      private var moneyCheckBox:NCheckBox;
      
      private var changeCostText:TextField;
      
      private var viewCostText:TextField;
      
      private var applyChangeButton:NButton;
      
      private var applyViewButton:NButton;
      
      private var goldText:TextField;
      
      private var moneyText:TextField;
      
      private var goldIcon:Bitmap;
      
      private var silverIcon:Bitmap;
      
      private var arrowLargeButton:NButton;
      
      private var arrowLargeButton2:NButton;
      
      private var viewButtons:Vector.<NButton> = new Vector.<NButton>();
      
      private var selectedViewButton:NButton = null;
      
      private var viewsOffset:int = 0;
      
      private var preview:PlayerPreview;
      
      private var dirIndex:int;
      
      public function CustomizationMenu()
      {
         var pos:Point;
         Main.closeMenus(TYPE_CUSTOMIZATION,TYPE_UPGRADE,TYPE_CRAFT,TYPE_INVENTORY,TYPE_ACTION_10,TYPE_PRINT);
         super(TYPE_CUSTOMIZATION,_("IDS_ITEM_CUSTOMIZATION_MENU"),this.WIDTH,this.HEIGHT);
         pos = new Point(24,44);
         drawBorder(this,pos.x,pos.y,160,this.HEIGHT - 46 - pos.y);
         this.typeDropDown = new DropDown(130,null,this.onTypeChange);
         this.typeDropDown.setPos(pos.x + 15,pos.y + 20);
         pos.offset(33,60);
         this.itemSlot = new ItemSlot();
         this.itemSlot.setPos(pos.x,pos.y);
         addUIChild(this.itemSlot);
         var button:NButton = new NButton(this.onPrevItemClick,getBmp("ARROW_LARGE_BUTTON"),getBmp("ARROW_LARGE_BUTTON_OVER"),getBmp("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(pos.x - 12,pos.y);
         addUIChild(button);
         button = new NButton(this.onNextItemClick,getBitmap5("ARROW_LARGE_BUTTON"),getBitmap5("ARROW_LARGE_BUTTON_OVER"),getBitmap5("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(pos.x + this.itemSlot.width + 13,pos.y);
         addUIChild(button);
         pos.offset(0,this.itemSlot.height + 30);
         draw(PREVIEW_BG,pos.x,pos.y);
         var player:PlayerItem = Main.instance.player;
         this.preview = new PlayerPreview(player.type);
         this.preview.x = pos.x + 48;
         this.preview.y = pos.y + 100;
         this.preview.previewPlayer.layerView[PlayerItem.HAIR_LAYER] = player.layerView[PlayerItem.HAIR_LAYER];
         this.preview.previewPlayer.layerView[PlayerItem.PANTS_LAYER] = player.layerView[PlayerItem.PANTS_LAYER];
         this.preview.previewPlayer.layerView[PlayerItem.BODY_5] = 0;
         this.preview.previewPlayer.layerView[PlayerItem.WEAPON_LAYER] = 0;
         this.preview.previewPlayer.layerView[PlayerItem.WEAPON_3] = 0;
         this.preview.previewPlayer.layerView[PlayerItem.BODY_LAYER] = 0;
         this.preview.previewPlayer.layerView[PlayerItem.WEAPON_4] = 0;
         this.preview.previewPlayer.layerPal[PlayerItem.HAIR_LAYER] = player.layerPal[PlayerItem.HAIR_LAYER];
         this.preview.previewPlayer.layerPal[PlayerItem.PANTS_LAYER] = player.layerPal[PlayerItem.PANTS_LAYER];
         this.preview.previewPlayer.layerPal[PlayerItem.BODY_5] = 0;
         this.preview.previewPlayer.layerPal[PlayerItem.WEAPON_LAYER] = 0;
         this.preview.previewPlayer.layerPal[PlayerItem.WEAPON_3] = 0;
         this.preview.previewPlayer.layerPal[PlayerItem.BODY_LAYER] = 0;
         this.preview.previewPlayer.layerPal[PlayerItem.WEAPON_4] = 0;
         this.setRotation(1);
         this.preview.previewPlayer.state = PlayerItem.stStand;
         addChild(this.preview);
         button = new NButton(this.onRotateLeftClick,getBmp("ARROW_LARGE_BUTTON"),getBmp("ARROW_LARGE_BUTTON_OVER"),getBmp("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(pos.x - 12,pos.y + (135 - button.height) / 2);
         addUIChild(button);
         button = new NButton(this.onRotateRightClick,getBitmap5("ARROW_LARGE_BUTTON"),getBitmap5("ARROW_LARGE_BUTTON_OVER"),getBitmap5("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(pos.x + this.itemSlot.width + 13,pos.y + (135 - button.height) / 2);
         addUIChild(button);
         addText(16,this.HEIGHT - 41,_("IDS_CUSTOM_VIEW_WARN_0"),NTextFormat.plain,2 * this.WIDTH / 3);
         addUIChild(this.typeDropDown);
         pos.x = 198;
         pos.y = 44;
         drawBorder(this,pos.x,pos.y,this.WIDTH - pos.x - 20,100);
         pos.offset(4,12);
         addTextLabel(pos.x,pos.y,_("IDS_CATEGORY") + " *",NTextFormat.plain.right,80);
         pos.offset(84,-2);
         this.categoryDropDown = new DropDown(170,null,this.onCategoryChange);
         this.categoryDropDown.setPos(pos.x,pos.y);
         pos.offset(170,2);
         addTextLabel(pos.x,pos.y,_("IDS_COLOR"),NTextFormat.plain.right,50);
         pos.offset(54,-2);
         this.colorDropDown = new DropDown(150,null,this.onColorChange);
         this.colorDropDown.maxVisibleRows = 42;
         this.colorDropDown.setPos(pos.x,pos.y);
         pos.x = 198 + 60;
         pos.y = 44 + 46;
         var label:TextField = addTextLabel(pos.x,pos.y - 4,_("IDS_COST") + " (",NTextFormat.titleFormat.left,200);
         pos.x += label.textWidth + 2;
         this.moneyCheckBox = new NCheckBox(this.onCurrencyClick,null,NCheckBox.TYPE_CIRCLE);
         this.moneyCheckBox.setPos(pos.x,pos.y);
         this.moneyCheckBox.checked = true;
         addUIChild(this.moneyCheckBox);
         addTextLabel(pos.x + 14,pos.y - 4,_("IDS_GAMEMONEY"),NTextFormat.titleFormat.left,200);
         pos.x += 70;
         this.goldCheckBox = new NCheckBox(this.onCurrencyClick,null,NCheckBox.TYPE_CIRCLE);
         this.goldCheckBox.setPos(pos.x,pos.y);
         this.goldCheckBox.checked = false;
         addUIChild(this.goldCheckBox);
         label = addTextLabel(pos.x + 14,pos.y - 4,_("IDS_GOLDMONEY") + "):",NTextFormat.titleFormat.left,200);
         pos.x += 20 + label.textWidth;
         this.changeCostText = addTextLabel(pos.x,pos.y - 4,"0",NTextFormat.titleFormat.left,200);
         this.applyChangeButton = createButton(this.WIDTH - 96 - 34,pos.y + 22,_("IDS_APPLY"),this.onApplyChangeClick);
         addUIChild(this.applyChangeButton);
         pos.x = 198;
         pos.y = 158;
         drawBorder(this,pos.x,pos.y,this.WIDTH - pos.x - 20,this.HEIGHT - 86 - pos.y);
         pos.offset(4,4);
         addTextLabel(pos.x,pos.y,_("IDS_CUSTOM_INVENTORY_VIEW"),NTextFormat.titleFormat.left,this.WIDTH - pos.x - 20);
         pos.offset(4,42);
         this.arrowLargeButton = new NButton(this.onViewsPrevClick,getBmp("ARROW_LARGE_BUTTON"),getBmp("ARROW_LARGE_BUTTON_OVER"),getBmp("ARROW_LARGE_BUTTON_PRESSED"));
         this.arrowLargeButton.setPos(pos.x,pos.y);
         this.arrowLargeButton.visible = false;
         addUIChild(this.arrowLargeButton);
         this.arrowLargeButton2 = new NButton(this.onViewsNextClick,getBitmap5("ARROW_LARGE_BUTTON"),getBitmap5("ARROW_LARGE_BUTTON_OVER"),getBitmap5("ARROW_LARGE_BUTTON_PRESSED"));
         this.arrowLargeButton2.setPos(pos.x + this.itemSlot.width + 13,pos.y);
         this.arrowLargeButton2.visible = false;
         addUIChild(this.arrowLargeButton2);
         pos.offset(-4,78);
         label = addTextLabel(pos.x,pos.y,_("IDS_COST") + ":",NTextFormat.titleFormat.left,200);
         this.viewCostText = addTextLabel(pos.x + label.textWidth + 3,pos.y,"0",NTextFormat.titleFormat.left,200);
         this.applyViewButton = createButton(this.WIDTH - 96 - 34,pos.y - 10,_("IDS_APPLY"),this.onApplyViewClick);
         addUIChild(this.applyViewButton);
         pos.x = 198;
         pos.y = this.HEIGHT - 72;
         drawBorder(this,pos.x,pos.y,this.WIDTH - pos.x - 20,this.HEIGHT - 46 - pos.y);
         pos.offset(4,4);
         addTextLabel(pos.x,pos.y,_("IDS_BALANCE"),NTextFormat.titleFormat.left,this.WIDTH - pos.x - 20);
         this.goldIcon = getBmp("V_GOLD");
         addChild(this.goldIcon);
         this.silverIcon = getBmp("V_SILVER");
         addChild(this.silverIcon);
         this.goldMoney = Main.UserCharacter.money;
         this.goldText = addTextLabel(pos.x,pos.y,"?",NTextFormat.titleFormat.right,this.WIDTH - pos.x - 204);
         this.moneyText = addTextLabel(pos.x,pos.y,"?",NTextFormat.titleFormat.right,this.WIDTH - pos.x - 24);
         addUIChild(this.colorDropDown);
         addUIChild(this.categoryDropDown);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST30,this.onCustomizationData);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST8,this.onMoneyUpdate);
         GameSocket.socket.send(Commands.COMMANDS_CONST30);
         this.updateBalance();
      }
      
      private function onCurrencyClick(checkBox:Object) : void
      {
         this.moneyCheckBox.checked = this.goldCheckBox.checked = false;
         checkBox.checked = true;
         this.updateChangeCost();
      }
      
      private function onApplyChangeClick(sender:Object) : void
      {
         onChangeConfirm = function():void
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST40,moneyCheckBox.checked ? "1" : "0",_currentItem.inventoryId,categoryDropDown.SelectedKey,colorDropDown.SelectedKey);
            applyChangeButton.enabled = false;
         };
         if(this._currentItem == null)
         {
            return;
         }
         var sameType:Boolean = this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] == this.categoryDropDown.SelectedKey;
         var onChangeConfirm:Function;
         if(sameType && this._currentItem.params[InventoryItem.GP_10] == this.colorDropDown.SelectedKey)
         {
            return;
         }
         if(sameType)
         {
            showModal(new QuestionMenu(_("IDS_CUSTOM_VIEW_WARN_2",this._currentItem.itemname,this.colorDropDown.selectedLabel,this.changeCostText.text),onChangeConfirm));
         }
         else
         {
            showModal(new SoberConfirmMenu(_("IDS_CUSTOM_VIEW_WARN_1",this._currentItem.itemname,this.changeCostText.text),onChangeConfirm));
         }
      }
      
      private function onApplyViewClick(sender:Object) : void
      {
         if(this._currentItem == null || this.selectedViewButton == null)
         {
            return;
         }
         var sameType:Boolean = this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] == this.categoryDropDown.SelectedKey;
         if(!sameType)
         {
            return;
         }
         var warning:String = _("IDS_CUSTOM_VIEW_WARN_3",this._currentItem.itemname,this.viewCostText.text);
         showModal(new QuestionMenu(warning,function():void
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST36,_currentItem.inventoryId,shop[_currentItem.type][_currentItem.params[InventoryItem.WEAPON_PENALTY_9]].views[selectedViewButton.value].view);
            applyViewButton.enabled = false;
         }));
      }
      
      private function updateChangeCost() : void
      {
         this.applyChangeButton.enabled = false;
         if(this._currentItem == null)
         {
            this.changeCostText.text = "0";
            return;
         }
         if(this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] == this.categoryDropDown.SelectedKey && this._currentItem.params[InventoryItem.GP_10] == this.colorDropDown.SelectedKey)
         {
            this.changeCostText.text = "0";
            return;
         }
         var cost:int = 0;
         var paletteId:int = this.colorDropDown.SelectedKey;
         if(this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] != this.categoryDropDown.SelectedKey)
         {
            category = this.shop[this._currentItem.type][this.categoryDropDown.SelectedKey];
            cost += this.moneyCheckBox.checked ? category.cost : category.goldcost;
         }
         var palettes:Array = this.shop[this._currentItem.type][this.categoryDropDown.SelectedKey].palettes;
         var i:int = 0;
         var category:Object;
         while(i < palettes.length)
         {
            if(palettes[i].id == paletteId)
            {
               cost += this.moneyCheckBox.checked ? palettes[i].cost : palettes[i].goldcost;
               break;
            }
            i++;
         }
         if(this.moneyCheckBox.checked)
         {
            this.applyChangeButton.enabled = cost <= this.gameMoney;
            this.changeCostText.text = formatString("IDS_MONEY_TEMPLATE",cost);
         }
         else
         {
            this.applyChangeButton.enabled = cost <= this.goldMoney;
            this.changeCostText.text = cost + " " + _("IDS_CREDS");
         }
      }
      
      private function onMoneyUpdate(fields:Array) : void
      {
         goldMoney = Main.UserCharacter.money;
         this.updateBalance();
         this.updateChangeCost();
      }
      
      private function get currentItem() : InventoryItem
      {
         return this._currentItem;
      }
      
      private function set currentItem(item:InventoryItem) : void
      {
         var button:NButton = null;
         if(item != this._currentItem)
         {
            if(this._currentItem != null)
            {
               this.preview.previewPlayer.layerView[InventoryItem.array113[this._currentItem.type]] = 0;
               this.preview.previewPlayer.layerPal[InventoryItem.array113[this._currentItem.type]] = 0;
               for each(button in this.viewButtons)
               {
                  button.disposeOnRemove = true;
                  if(button.addedToUITree)
                  {
                     removeUIChild(button);
                  }
               }
               viewButtons = new Vector.<NButton>();
               selectedViewButton = null;
            }
            _currentItem = item;
            viewsOffset = 0;
            if(item != null)
            {
               this.preview.previewPlayer.layerView[InventoryItem.array113[item.type]] = item.params[InventoryItem.WEAPON_PENALTY_9];
               this.preview.previewPlayer.layerPal[InventoryItem.array113[item.type]] = item.params[InventoryItem.GP_10];
               this.categoryDropDown.selectedValue = this.categoryLabels[item.type];
               this.categoryDropDown.SelectedKey = item.params[InventoryItem.WEAPON_PENALTY_9];
               this.colorDropDown.selectedValue = this.shop[item.type][item.params[InventoryItem.WEAPON_PENALTY_9]].palsDict;
               this.colorDropDown.SelectedKey = item.params[InventoryItem.GP_10];
               this.arrowLargeButton.visible = this.arrowLargeButton2.visible = true;
               this.createViewButtons();
            }
            else
            {
               this.categoryDropDown.selectedValue = null;
               this.colorDropDown.selectedValue = null;
               if(this.arrowLargeButton.visible)
               {
                  this.arrowLargeButton.visible = this.arrowLargeButton2.visible = false;
               }
            }
            this.preview.previewPlayer.update();
            this.updateChangeCost();
            this.updateBalance();
            this.itemSlot.removeItem();
            if(this.currentItem != null)
            {
               this.itemSlot.insertItem(this.currentItem);
            }
         }
      }
      
      private function createViewButtons() : void
      {
         var views:Array = this.shop[this._currentItem.type][this.categoryDropDown.SelectedKey].views;
         var sameCategory:Boolean = this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] == this.categoryDropDown.SelectedKey;
         if(!sameCategory)
         {
            for each(view in views)
            {
               if(view.view == this.shop[this._currentItem.type][this.categoryDropDown.SelectedKey].defaultView)
               {
                  views = [view];
                  break;
               }
            }
         }
         var swapButton:NButton = null;
         var i:int = 0;
         var view:Object;
         var loader:Loader;
         var sprite:Sprite;
         var matrix:Matrix;
         while(i < views.length)
         {
            loader = new Loader();
            loader.load(new URLRequest("icons/inv/i" + views[i].img + ".png"));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onViewIconLoad);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onViewIconError);
            sprite = new Sprite();
            matrix = new Matrix();
            matrix.createGradientBox(ItemsList.NORMAL_WIDTH - 1,ItemsList.NORMAL_HEIGHT - 1,Math.PI / 2);
            sprite.graphics.beginGradientFill(GradientType.LINEAR,[3092271,2236962],[1,1],[0,255],matrix);
            sprite.graphics.drawRect(1,1,ItemsList.NORMAL_WIDTH - 1,ItemsList.NORMAL_HEIGHT - 1);
            sprite.graphics.endFill();
            sprite.addChild(loader);
            sprite.addChild(createLabel(2,0,String.fromCharCode(97 + i),NTextFormat.plain));
            this.viewButtons.push(new NButton(this.onViewClick,sprite));
            this.viewButtons[i].disposeOnRemove = false;
            this.viewButtons[i].value = i;
            this.viewButtons[i].enabled = sameCategory;
            if(this.viewButtons[i].enabled)
            {
               if(views[i].view == this._currentItem.params[InventoryItem.WEAPON_PENALTY_NONE])
               {
                  if(i != 0)
                  {
                     swapButton = this.viewButtons[0];
                     this.viewButtons[0] = this.viewButtons[i];
                     this.viewButtons[i] = swapButton;
                  }
               }
            }
            i++;
         }
         this.selectView(this.viewButtons[0]);
         this.layoutViewButtons();
         this.updateViewCost();
      }
      
      private function onViewClick(sender:Object) : void
      {
         this.selectView(sender as NButton);
      }
      
      private function updateViewCost() : void
      {
         this.applyViewButton.enabled = false;
         if(this._currentItem == null || this.selectedViewButton == null)
         {
            this.viewCostText.text = "0";
            return;
         }
         var sameCategory:Boolean = this._currentItem.params[InventoryItem.WEAPON_PENALTY_9] == this.categoryDropDown.SelectedKey;
         var viewIndex:int = int(this.selectedViewButton.value);
         var view:Object = this.shop[this._currentItem.type][this._currentItem.params[InventoryItem.WEAPON_PENALTY_9]].views[viewIndex];
         this.applyViewButton.visible = sameCategory;
         if(!sameCategory || view.view == this._currentItem.params[InventoryItem.WEAPON_PENALTY_NONE] % 1000)
         {
            this.viewCostText.text = "0";
            return;
         }
         var cost:int = view.goldcost;
         this.applyViewButton.enabled = cost <= this.goldMoney;
         this.viewCostText.text = cost + " " + _("IDS_CREDS");
      }
      
      private function selectView(button:NButton) : void
      {
         if(this.selectedViewButton != button)
         {
            if(this.selectedViewButton != null)
            {
               this.selectedViewButton.graphics.clear();
            }
            selectedViewButton = button;
            button.drawRect(0,0,ItemsList.NORMAL_WIDTH,ItemsList.NORMAL_HEIGHT,16763904,0.5);
            this.updateViewCost();
         }
      }
      
      private function onViewIconLoad(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onViewIconLoad);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onViewIconError);
         event.target.loader.x = (ItemsList.NORMAL_WIDTH - event.target.loader.width) / 2;
         event.target.loader.y = (ItemsList.NORMAL_HEIGHT - event.target.loader.height) / 2;
      }
      
      private function onViewIconError(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onViewIconLoad);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onViewIconError);
      }
      
      override public function dispose() : void
      {
         this.preview.dispose();
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST8,this.onMoneyUpdate);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST30,this.onCustomizationData);
         super.dispose();
      }
      
      private function onCustomizationData(fields:Array) : void
      {
         var offset:int = 1;
         gameMoney = fields[offset++];
         var count:int = fields[offset++];
         items = new DefaultsProxy([]);
         typeLabels = new DefaultsProxy();
         this.typeLabels["-1"] = _("IDS_ALL");
         var i:int = 0;
         var itemLength:int;
         var item:InventoryItem;
         var itemType:int;
         var categoryCount:int;
         var category:Object;
         var paletteCount:int;
         var viewCount:int;
         var palette:Object;
         while(i < count)
         {
            itemLength = fields[offset];
            item = new InventoryItem(fields.slice(offset,offset + itemLength));
            if(this.currentItem != null && this.currentItem.inventoryId == item.inventoryId)
            {
               currentItem = item;
            }
            if(!(item.type in this.typeLabels))
            {
               this.typeLabels[item.type] = _("IDS_INV_TYPE_" + item.type);
            }
            this.items["-1"].push(item);
            this.items[item.type].push(item);
            offset += itemLength;
            i++;
         }
         shop = {};
         categoryLabels = {};
         count = fields[offset++];
         while(count > 0)
         {
            itemType = fields[offset++];
            categoryCount = fields[offset++];
            this.shop[itemType] = new DefaultsProxy();
            this.categoryLabels[itemType] = new DefaultsProxy();
            i = 0;
            while(i < categoryCount)
            {
               category = {
                  "type":int(fields[offset++]),
                  "cost":int(fields[offset++]),
                  "goldcost":int(fields[offset++]),
                  "defaultView":int(fields[offset++]),
                  "palettes":[],
                  "palsDict":new DefaultsProxy(),
                  "views":[]
               };
               paletteCount = fields[offset++];
               while(paletteCount > 0)
               {
                  palette = {
                     "id":int(fields[offset++]),
                     "cost":int(fields[offset++]),
                     "goldcost":int(fields[offset++]),
                     "color":int(fields[offset++])
                  };
                  category.palettes.push(palette);
                  category.palsDict[palette.id] = _("PAL_" + palette.color);
                  paletteCount--;
               }
               viewCount = fields[offset++];
               while(viewCount > 0)
               {
                  category.views.push({
                     "view":int(fields[offset++]),
                     "img":int(fields[offset++]),
                     "goldcost":int(fields[offset++])
                  });
                  viewCount--;
               }
               this.shop[itemType][category.type] = category;
               this.categoryLabels[itemType][category.type] = _("IDS_CATEGORY_TYPE_" + itemType + "_" + category.type);
               i++;
            }
            count--;
         }
         if(this.currentItem == null && this.items[this.currentType].length > 0)
         {
            currentItem = this.items[this.currentType][0];
         }
         this.typeDropDown.selectedValue = this.typeLabels;
         this.typeDropDown.SelectedKey = this.currentType;
      }
      
      private function setRotation(rotationIndex:int) : void
      {
         this.preview.previewPlayer.dir = PlayerItem.ROTATE_DIRS[dirIndex = rotationIndex];
      }
      
      private function onRotateRightClick(sender:Object) : void
      {
         this.setRotation((this.dirIndex + 1) % PlayerItem.ROTATE_DIRS.length);
      }
      
      private function onRotateLeftClick(sender:Object) : void
      {
         this.setRotation((PlayerItem.ROTATE_DIRS.length + this.dirIndex - 1) % PlayerItem.ROTATE_DIRS.length);
      }
      
      private function onTypeChange(dropDown:Object) : void
      {
         currentType = this.typeDropDown.SelectedKey;
         currentItem = this.items[this.currentType][0];
      }
      
      private function onCategoryChange(dropDown:Object) : void
      {
         var button:NButton = null;
         if(this._currentItem)
         {
            this.preview.previewPlayer.layerView[InventoryItem.array113[this._currentItem.type]] = this.categoryDropDown.SelectedKey;
            this.preview.previewPlayer.layerPal[InventoryItem.array113[this._currentItem.type]] = 0;
            this.colorDropDown.selectedValue = this.shop[this._currentItem.type][this.categoryDropDown.SelectedKey].palsDict;
            this.colorDropDown.SelectedKey = 0;
            this.updateChangeCost();
            for each(button in this.viewButtons)
            {
               button.disposeOnRemove = true;
               if(button.addedToUITree)
               {
                  removeUIChild(button);
               }
            }
            viewButtons = new Vector.<NButton>();
            selectedViewButton = null;
            viewsOffset = 0;
            this.createViewButtons();
            this.preview.previewPlayer.update();
         }
      }
      
      private function onColorChange(dropDown:Object) : void
      {
         if(this._currentItem)
         {
            this.preview.previewPlayer.layerPal[InventoryItem.array113[this._currentItem.type]] = this.colorDropDown.SelectedKey;
            this.updateChangeCost();
            this.preview.previewPlayer.update();
         }
      }
      
      private function layoutViewButtons() : void
      {
         var i:int = 0;
         i = 0;
         while(i < this.viewButtons.length)
         {
            if(this.viewButtons[i].addedToUITree)
            {
               removeUIChild(this.viewButtons[i]);
            }
            i++;
         }
         i = 0;
         while(i < Math.min(4,this.viewButtons.length))
         {
            this.viewButtons[this.viewsOffset + i].setPos(18 + this.arrowLargeButton.x + i * (this.viewButtons[this.viewsOffset + i].width + 12),this.arrowLargeButton.y + 1);
            addUIChild(this.viewButtons[this.viewsOffset + i]);
            i++;
         }
         this.colorDropDown.disposeOnRemove = false;
         removeUIChild(this.colorDropDown);
         addUIChild(this.colorDropDown);
         this.colorDropDown.disposeOnRemove = true;
         this.arrowLargeButton2.setPos(24 + this.arrowLargeButton.x + i * (this.viewButtons[0].width + 12),this.arrowLargeButton.y);
      }
      
      private function onViewsNextClick(sender:Object) : void
      {
         if(this.viewButtons.length > 4 && this.viewsOffset + 4 < this.viewButtons.length)
         {
            ++this.viewsOffset;
            this.layoutViewButtons();
         }
      }
      
      private function onViewsPrevClick(sender:Object) : void
      {
         if(this.viewButtons.length > 4 && this.viewsOffset > 0)
         {
            --this.viewsOffset;
            this.layoutViewButtons();
         }
      }
      
      private function onNextItemClick(sender:Object) : void
      {
         var typeItems:Array = this.items[this.currentType];
         var index:int;
         if(typeItems.length > 1)
         {
            index = typeItems.indexOf(this.currentItem);
            currentItem = typeItems[(index + 1) % typeItems.length];
         }
      }
      
      private function onPrevItemClick(sender:Object) : void
      {
         var typeItems:Array = this.items[this.currentType];
         var index:int;
         if(typeItems.length > 1)
         {
            index = typeItems.indexOf(this.currentItem);
            currentItem = typeItems[(index - 1 + typeItems.length) % typeItems.length];
         }
      }
      
      private function updateBalance() : void
      {
         this.goldText.text = this.goldMoney + " " + _("IDS_CREDS");
         this.moneyText.text = formatString("IDS_MONEY_TEMPLATE",this.gameMoney);
         this.goldIcon.y = this.goldText.y + 4;
         this.goldIcon.x = this.goldText.x + (this.goldText.width - this.goldText.textWidth) - 18;
         this.silverIcon.y = this.moneyText.y + 4;
         this.silverIcon.x = this.moneyText.x + (this.moneyText.width - this.moneyText.textWidth) - 18;
      }
   }
}

