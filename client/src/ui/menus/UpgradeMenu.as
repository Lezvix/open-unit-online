package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import game.InventoryItem;
   import game.Character;
   import game.CraftSystem;
   import ui.*;
   
   public class UpgradeMenu extends TitledMenu
   {
      
      private const WIDTH:int = 600;
      
      private const HEIGHT:int = 377;
      
      private const TARGET_X:int = 60;
      
      private const TARGET_Y:int = 48;
      
      private const TARGET_W:int = 96;
      
      private const TARGET_H:int = 56;
      
      private const TARGET_INFO_WINDOW_X:int = 165.0;
      
      private const TARGET_INFO_WINDOW_Y:int = 94.0;
      
      private const UPG_X:int = 22;
      
      private const UPG_Y:int = 114.0;
      
      private const UPG_W:int = 330;
      
      private const UPG_H:int = 213.0;
      
      private var itemsToUpgrade:Vector.<InventoryItem>;
      
      private var currentItem:int = 2147483647;
      
      private var userResources:Dictionary;
      
      private var upgradeRecipes:Dictionary;
      
      private var targetSlot:ItemSlot;
      
      private var upgradesList:RowList;
      
      private var componentsList:RowList;
      
      private var currentUpgrade:SelectableButton = null;
      
      private var sendUpgradeRequestButton:NButton;
      
      private var removeUpgradesButton:NButton;
      
      private var infoMenu:ItemInfo;
      
      private var upgradesScrollSprite:ScrollSprite;
      
      private var upgradeDescriptionScrollSprite:ScrollSprite;
      
      private var upgradeNameText:TextField;
      
      private var upgradeChanceText:TextField;
      
      private var loaded:Boolean = false;
      
      private var workbenchId:int;
      
      private var canRemoveUpgrades:Boolean = false;
      
      public function UpgradeMenu(fields:Array)
      {
         super(TYPE_UPGRADE,_("IDS_UPGRADE_MENU"),this.WIDTH,this.HEIGHT);
         drawWindowBg();
         this.targetSlot = new ItemSlot();
         this.targetSlot.setPos(this.TARGET_X,this.TARGET_Y);
         this.targetSlot.showInfoButton(this.infoShow);
         addUIChild(this.targetSlot);
         var button:NButton = new NButton(this.nextUpgradeHandler,getBmp("NEXT_ARROW_BUTTON"),getBmp("NEXT_ARROW_BUTTON_OVER"),getBmp("NEXT_ARROW_BUTTON_PRESS"));
         button.setPos(this.TARGET_X + this.TARGET_W + 6,this.TARGET_Y + (this.TARGET_H - 29) / 2);
         addUIChild(button);
         button = new NButton(this.prevUpgradeHandler,getBmp("PREV_ARROW_BUTTON"),getBmp("PREV_ARROW_BUTTON_OVER"),getBmp("PREV_ARROW_BUTTON_PRESS"));
         button.setPos(this.TARGET_X - 29,this.TARGET_Y + (this.TARGET_H - 29) / 2);
         addUIChild(button);
         drawWindow(_("IDS_AVAILABLE_UPGRADES"),this.UPG_X,this.UPG_Y,this.UPG_W,this.UPG_H);
         this.upgradesScrollSprite = new ScrollSprite(this.UPG_W - 16,this.UPG_H - 38,7);
         this.upgradesScrollSprite.setPos(this.UPG_X + 8,this.UPG_Y + 31);
         addUIChild(this.upgradesScrollSprite);
         this.upgradesList = new RowList(this.UPG_W - 30,this.upgradeClick);
         this.upgradesScrollSprite.addContent(this.upgradesList);
         drawWindow(_("IDS_COMPONENTS"),this.UPG_X + this.UPG_W + 11,this.UPG_Y,this.WIDTH - this.UPG_W - 52,this.UPG_H);
         this.upgradeDescriptionScrollSprite = new ScrollSprite(this.WIDTH - this.UPG_W - 68,this.UPG_H - 38,7);
         this.upgradeDescriptionScrollSprite.setPos(this.UPG_X + this.UPG_W + 19,this.UPG_Y + 31);
         addUIChild(this.upgradeDescriptionScrollSprite);
         this.componentsList = new RowList(this.WIDTH - this.UPG_W - 82);
         this.upgradeDescriptionScrollSprite.addLine(this.componentsList);
         this.upgradeChanceText = createLabel(this.TARGET_X + this.TARGET_W + 45,this.TARGET_Y - 9,"?",NTextFormat.normal.derive({"size":12}),this.WIDTH - this.TARGET_X - this.TARGET_W - 80);
         addChild(this.upgradeChanceText);
         addText(this.TARGET_X + this.TARGET_W + 45,this.TARGET_Y + 7,_("IDS_UPGRADE_NOTIFICATION"),NTextFormat.plain,this.WIDTH - this.TARGET_X - this.TARGET_W - 80);
         this.removeUpgradesButton = createButton(20,this.HEIGHT - 42,_("IDS_REMOVE_UPGRADES"),this.onRemoveUpgradesClick);
         addUIChild(this.removeUpgradesButton);
         this.sendUpgradeRequestButton = createButton(this.WIDTH - 228,this.HEIGHT - 42,_("IDS_TO_UPGRADE"),this.upgradeClickHandler);
         addUIChild(this.sendUpgradeRequestButton);
         addButton(this.WIDTH - 119,this.HEIGHT - 42,_("IDS_TO_CLOSE"),onCloseClick);
         if(!CraftSystem.UpgradeGroupsLoaded)
         {
            GameSocket.socket.sendRequestUpgradeGroups();
         }
         this.infoMenu = new ItemInfo();
         addUIChild(this.infoMenu);
         this.parseData(fields);
      }
      
      public function recipesLoaded() : void
      {
         upgradeRecipes = CraftSystem.getUpgradeRecipes(this.workbenchId);
         loaded = true;
         this.updateCurrentItem(this.currentItem);
      }
      
      public function parseData(fields:Array) : void
      {
         var offset:int = 2;
         canRemoveUpgrades = fields[offset++] == "1";
         var itemCount:int = fields[offset++];
         itemsToUpgrade = new Vector.<InventoryItem>(itemCount);
         var i:int = 0;
         var itemLength:int;
         while(i < itemCount)
         {
            itemLength = fields[offset];
            this.itemsToUpgrade[i] = new InventoryItem(fields.slice(offset,offset + itemLength));
            offset += itemLength;
            i++;
         }
         workbenchId = fields[offset];
         if(CraftSystem.getUpgradeRecipes(this.workbenchId) == null)
         {
            GameSocket.socket.sendRequestUpgradeRecipes();
            upgradeRecipes = new Dictionary();
            loaded = false;
         }
         else
         {
            upgradeRecipes = CraftSystem.getUpgradeRecipes(this.workbenchId);
            loaded = true;
         }
         this.updateCurrentItem(this.currentItem);
      }
      
      protected function onRemoveUpgradesClick(sender:Object) : void
      {
         var item:InventoryItem;
         item = this.itemsToUpgrade[this.currentItem];
         if(item && this.canRemoveUpgrades)
         {
            showConfirm(_("IDS_REMOVE_UPGRADES_WARNING",item.itemname),function():void
            {
               GameSocket.socket.sendOpenPresent(item.inventoryId);
               removeUpgradesButton.enabled = false;
            });
         }
      }
      
      protected function upgradeClickHandler(sender:Object) : void
      {
         var item:InventoryItem = this.itemsToUpgrade[this.currentItem];
         var recipe:Object;
         if(this.currentUpgrade && this.hasRequiredIngredients)
         {
            recipe = this.upgradeRecipes[this.currentUpgrade.value];
            if(recipe.skillType != -1 && recipe.skillValue > int(Main.UserCharacter.skills[recipe.skillType] / 10000))
            {
               showNotification(formatString("IDS_LOW_SKILL",recipe.skillType));
               return;
            }
            GameSocket.socket.sendUpgradeRequest(item.inventoryId,recipe.id);
            this.sendUpgradeRequestButton.enabled = false;
         }
      }
      
      private function get hasRequiredIngredients() : Boolean
      {
         return true;
      }
      
      private function updateCurrentItem(index:int) : void
      {
         this.removeUpgradesButton.enabled = false;
         if(!this.loaded)
         {
            return;
         }
         if(index < 0)
         {
            index = this.itemsToUpgrade.length - 1;
         }
         else if(index >= this.itemsToUpgrade.length)
         {
            index = 0;
         }
         this.targetSlot.removeItem();
         currentItem = index;
         var item:InventoryItem = this.itemsToUpgrade[this.currentItem];
         currentUpgrade = null;
         this.upgradesList.clear();
         this.componentsList.clear();
         this.upgradeDescriptionScrollSprite.init(this.componentsList.height);
         this.upgradeChanceText.text = "";
         if(this.itemsToUpgrade.length == 0)
         {
            this.sendUpgradeRequestButton.enabled = false;
            this.upgradeChanceText.text = _("IDS_NO_ITEMS_TO_UPGRADE");
            if(this.infoMenu.visible)
            {
               this.infoMenu.close();
            }
            return;
         }
         repairSkill = Main.UserCharacter.skills[Character.SKILL_REPAIR] / 10000;
         var repairSkill:int;
         var chance:int = CraftSystem.GetUpgradeChance(item.upgrades.length) * (1 + repairSkill / 500);
         this.upgradeChanceText.text = _("IDS_UPGRADE_CHANCE",Math.min(chance,100));
         this.targetSlot.insertItem(item);
         if(this.infoMenu.visible)
         {
            this.infoMenu.targetItem = item;
            this.infoMenu.create(this.infoMenu.x,this.infoMenu.y);
         }
         var unused:int = 0;
         var upgradeId:int;
         for each(upgradeId in CraftSystem.UpgradeGroups[item.upgradeCategory])
         {
            if(!item.hasUpgrade(upgradeId) && upgradeId in this.upgradeRecipes)
            {
               this.upgradesList.addRow(CraftSystem.GetUpgradeName(upgradeId),"",upgradeId);
            }
         }
         this.upgradesScrollSprite.init(this.upgradesList.height);
         this.removeUpgradesButton.enabled = this.canRemoveUpgrades && item.upgrades.length > 0;
      }
      
      protected function upgradeClick(button:Object) : void
      {
         var recipe:Object = null;
         var ingredient:Object = null;
         var count:int = 0;
         var instrumentNames:Array = null;
         var instrument:Object = null;
         if(this.currentUpgrade)
         {
            this.currentUpgrade.Selected = false;
            this.componentsList.clear();
         }
         currentUpgrade = button as SelectableButton;
         if(this.currentUpgrade)
         {
            recipe = this.upgradeRecipes[button.value];
            for each(ingredient in recipe.ingredients)
            {
               count = ingredient.id == -3 ? ingredient.count * (1 + this.itemsToUpgrade[this.currentItem].level) : ingredient.count;
               this.componentsList.addRow(ingredient.name,count);
            }
            if(recipe.instruments.length > 0)
            {
               instrumentNames = [];
               for each(instrument in recipe.instruments)
               {
                  instrumentNames.push(instrument.name);
               }
               this.componentsList.addRow(instrumentNames.join("/"),"");
            }
            if(recipe.skillType != -1)
            {
               this.componentsList.addRow(_("IDS_SKILL") + " \"" + _("IDS_SKILL_" + recipe.skillType) + "\"",int(Main.UserCharacter.skills[recipe.skillType] / 10000) + "/" + recipe.skillValue);
            }
            this.upgradeDescriptionScrollSprite.init(this.componentsList.height);
            this.sendUpgradeRequestButton.enabled = this.hasRequiredIngredients;
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
      
      protected function infoShow(button:Object) : void
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

