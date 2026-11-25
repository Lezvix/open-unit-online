package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import game.InventoryItem;
   import game.CraftSystem;
   import ui.*;
   
   public class CraftMenu extends TitledMenu
   {
      
      private const WIDTH:int = 600;
      
      private const HEIGHT:int = 377;
      
      private const PRODUCT_X:int = 60;
      
      private const PRODUCT_Y:int = 48;
      
      private const PRODUCT_W:int = 96;
      
      private const PRODUCT_H:int = 56;
      
      private const PRODUCT_INFO_WINDOW_X:int = 165.0;
      
      private const PRODUCT_INFO_WINDOW_Y:int = 94.0;
      
      private const INGR_X:int = 22;
      
      private const INGR_Y:int = 114.0;
      
      private const INGR_W:int = 300;
      
      private const INGR_H:int = 213.0;
      
      private var currentRecipe:int = 2147483647;
      
      private var recipes:Array;
      
      private var userResources:Dictionary;
      
      private var currentIngredient:SelectableButton = null;
      
      private var sendCraftRequestButton:NButton;
      
      private var infoMenu:ItemInfo;
      
      private var ingredientsScrollSprite:ScrollSprite;
      
      private var ingredients:RowList;
      
      private var ingredientsDescrScrollSprite:ScrollSprite;
      
      private var ingredientDescription:TextField;
      
      private var productDescription:TextField;
      
      private var productSlot:ItemSlot;
      
      private var workbenchId:int;
      
      private var groups:Array;
      
      private var recipesByGroup:Dictionary;
      
      private var groupDropDown:DropDown;
      
      private var currentGroup:int = -1;
      
      public function CraftMenu(fields:Array)
      {
         super(TYPE_CRAFT,_("IDS_CRAFT_MENU"),this.WIDTH,this.HEIGHT);
         drawWindowBg();
         this.productSlot = new ItemSlot();
         this.productSlot.setPos(this.PRODUCT_X,this.PRODUCT_Y);
         this.productSlot.showInfoButton(this.infoShow);
         addUIChild(this.productSlot);
         var button:NButton = new NButton(this.nextProductHandler,getBmp("NEXT_ARROW_BUTTON"),getBmp("NEXT_ARROW_BUTTON_OVER"),getBmp("NEXT_ARROW_BUTTON_PRESS"));
         button.setPos(this.PRODUCT_X + this.PRODUCT_W + 6,this.PRODUCT_Y + (this.PRODUCT_H - 29) / 2);
         addUIChild(button);
         button = new NButton(this.prevProductHandler,getBmp("PREV_ARROW_BUTTON"),getBmp("PREV_ARROW_BUTTON_OVER"),getBmp("PREV_ARROW_BUTTON_PRESS"));
         button.setPos(this.PRODUCT_X - 29,this.PRODUCT_Y + (this.PRODUCT_H - 29) / 2);
         addUIChild(button);
         drawWindow(_("IDS_NEED"),this.INGR_X,this.INGR_Y,this.INGR_W,this.INGR_H);
         this.ingredientsScrollSprite = new ScrollSprite(this.INGR_W - 16,this.INGR_H - 38,7);
         this.ingredientsScrollSprite.x = this.INGR_X + 8;
         this.ingredientsScrollSprite.y = this.INGR_Y + 31;
         addUIChild(this.ingredientsScrollSprite);
         this.ingredients = new RowList(this.INGR_W - 30,this.ingredientClick);
         this.ingredientsScrollSprite.addContent(this.ingredients);
         this.ingredientsDescrScrollSprite = new ScrollSprite(this.WIDTH - this.INGR_W - 68,this.INGR_H - 38,3);
         this.ingredientsDescrScrollSprite.x = this.INGR_X + this.INGR_W + 18;
         this.ingredientsDescrScrollSprite.y = this.INGR_Y + 31;
         addUIChild(this.ingredientsDescrScrollSprite);
         drawWindow(_("IDS_DESCRIPTION"),this.INGR_X + this.INGR_W + 11,this.INGR_Y,this.WIDTH - this.INGR_W - 52,this.INGR_H);
         this.ingredientDescription = createText(0,-4,"",NTextFormat.normal,this.WIDTH - this.INGR_W - 80);
         this.productDescription = createText(this.PRODUCT_X + this.PRODUCT_W + 42,this.PRODUCT_Y - 3,"",NTextFormat.plain.derive({
            "size":12,
            "color":10187041
         }),this.WIDTH - this.PRODUCT_X - this.PRODUCT_W - 80);
         this.ingredientsDescrScrollSprite.addLine(this.ingredientDescription);
         addChild(this.productDescription);
         this.sendCraftRequestButton = createButton(this.WIDTH - 228,this.HEIGHT - 42,_("IDS_TO_CREATE"),this.createItemHandler);
         addUIChild(this.sendCraftRequestButton);
         addButton(this.WIDTH - 119,this.HEIGHT - 42,_("IDS_TO_CLOSE"),onCloseClick);
         this.groupDropDown = new DropDown(160,null,this.onGroupChange);
         this.groupDropDown.x = this.WIDTH - 216;
         this.groupDropDown.y = this.PRODUCT_Y - 31;
         addUIChild(this.groupDropDown);
         this.infoMenu = new ItemInfo();
         addUIChild(this.infoMenu);
         this.parseData(fields);
      }
      
      private function onGroupChange(dropDown:Object) : void
      {
         if(this.currentGroup != dropDown.SelectedKey)
         {
            currentGroup = dropDown.SelectedKey;
            if(!this.productSlot.isActive)
            {
               this.productSlot.removeItem();
            }
            recipes = this.recipesByGroup[this.currentGroup];
            currentRecipe = int.MAX_VALUE;
            this.updateCurrentRecipe(this.currentRecipe);
         }
      }
      
      public function recipesLoaded() : void
      {
         this.groupRecipes();
         this.updateCurrentRecipe(this.currentRecipe);
      }
      
      private function groupRecipes() : void
      {
         var recipe:Object = null;
         var groupLabels:Dictionary = null;
         var group:int = 0;
         recipesByGroup = new Dictionary();
         this.recipesByGroup[-1] = new Array();
         groups = new Array();
         this.groups.push(-1);
         for each(recipe in CraftSystem.getCraftRecipes(this.workbenchId))
         {
            if(this.groups.indexOf(recipe.group) == -1)
            {
               this.groups.push(recipe.group);
            }
            if(!(recipe.group in this.recipesByGroup))
            {
               this.recipesByGroup[recipe.group] = new Array();
            }
            this.recipesByGroup[recipe.group].push(recipe);
            this.recipesByGroup[-1].push(recipe);
         }
         groupLabels = new Dictionary();
         for each(group in this.groups)
         {
            groupLabels[group] = _("IDS_CRAFT_GROUP_" + group);
         }
         this.groupDropDown.selectedValue = groupLabels;
         recipes = this.recipesByGroup[this.currentGroup];
         this.groupDropDown.SelectedKey = this.currentGroup;
      }
      
      public function parseData(fields:Array) : void
      {
         var offset:int = 2;
         var resourceCount:int = fields[offset++];
         userResources = new Dictionary();
         while(resourceCount > 0)
         {
            this.userResources[int(fields[offset++])] = int(fields[offset++]);
            resourceCount--;
         }
         workbenchId = fields[offset];
         if(CraftSystem.getCraftRecipes(this.workbenchId) == null)
         {
            recipes = new Array();
            GameSocket.socket.sendRequestCraftRecipes();
         }
         else
         {
            this.groupRecipes();
         }
         this.updateCurrentRecipe(this.currentRecipe);
      }
      
      protected function createItemHandler(sender:Object) : void
      {
         var recipe:Object = null;
         if(this.hasRequiredIngredients)
         {
            recipe = this.recipes[this.currentRecipe];
            if(recipe.skillType != -1 && recipe.skillValue > int(Main.UserCharacter.skills[recipe.skillType] / 10000))
            {
               showNotification(formatString("IDS_LOW_SKILL",recipe.skillType));
               return;
            }
            GameSocket.socket.sendRepairOwn(recipe.id);
            this.sendCraftRequestButton.enabled = false;
         }
      }
      
      private function get hasRequiredIngredients() : Boolean
      {
         var ingredient:Object = null;
         for each(ingredient in this.recipes[this.currentRecipe].ingredients)
         {
            if(ingredient.count > int(this.userResources[ingredient.id]))
            {
               return false;
            }
         }
         return true;
      }
      
      private function updateCurrentRecipe(index:int) : void
      {
         if(this.recipes.length == 0)
         {
            return;
         }
         if(index < 0)
         {
            index = this.recipes.length - 1;
         }
         else if(index >= this.recipes.length)
         {
            index = 0;
         }
         var selectedIngredientId:int = index == this.currentRecipe && this.currentIngredient ? this.currentIngredient.value : 0;
         if(!this.productSlot.isActive)
         {
            this.productSlot.removeItem();
         }
         currentRecipe = index;
         var product:InventoryItem = this.recipes[this.currentRecipe].product;
         var description:String = _("IDS_PRODUCT_INFO_" + product.itemId);
         this.productDescription.text = description ? description : _("IDS_NO_DESCRIPTION");
         this.productDescription.height = this.productDescription.textHeight + 5;
         currentIngredient = null;
         this.ingredients.clear();
         this.ingredientDescription.text = "";
         this.productSlot.insertItem(product);
         if(this.infoMenu.visible)
         {
            this.infoMenu.targetItem = product;
            this.infoMenu.create(this.infoMenu.x,this.infoMenu.y);
         }
         var recipe:Object = this.recipes[this.currentRecipe];
         var ingredient:Object;
         var instrumentNames:Array;
         var instrumentIds:Array;
         var instrument:Object;
         for each(ingredient in recipe.ingredients)
         {
            this.ingredients.addRow(ingredient.name,int(this.userResources[ingredient.id]) + "/" + ingredient.count,ingredient.id);
            if(ingredient.id == selectedIngredientId)
            {
               currentIngredient = this.ingredients.getRow(this.ingredients.totalRows - 1);
               this.ingredients.selectRow(this.ingredients.totalRows - 1);
            }
         }
         if(recipe.instruments.length > 0)
         {
            instrumentNames = [];
            instrumentIds = [];
            for each(instrument in recipe.instruments)
            {
               instrumentNames.push(instrument.name);
               instrumentIds.push(instrument.id);
            }
            this.ingredients.addRow(instrumentNames.join(" / "),"",instrumentIds.join(","));
         }
         if(recipe.skillType != -1)
         {
            this.ingredients.addRow(_("IDS_SKILL") + " \"" + _("IDS_SKILL_" + recipe.skillType) + "\"",int(Main.UserCharacter.skills[recipe.skillType] / 10000) + "/" + recipe.skillValue,null,true);
         }
         this.ingredientsScrollSprite.init(this.ingredients.height);
         this.sendCraftRequestButton.enabled = this.hasRequiredIngredients;
      }
      
      protected function ingredientClick(button:Object) : void
      {
         var unused:Array = null;
         var key:String = null;
         var description:String = null;
         if(this.currentIngredient)
         {
            this.currentIngredient.Selected = false;
            this.ingredientDescription.text = "";
         }
         currentIngredient = button as SelectableButton;
         if(this.currentIngredient)
         {
            unused = [];
            for each(key in button.value.toString().split(","))
            {
               description = _(key);
               if(description)
               {
                  if(this.ingredientDescription.text)
                  {
                     this.ingredientDescription.appendText("\n\n");
                  }
                  this.ingredientDescription.appendText(description);
               }
            }
            if(!this.ingredientDescription.text)
            {
               this.ingredientDescription.text = _("0");
            }
         }
         this.ingredientDescription.height = this.ingredientDescription.textHeight + 7;
         this.ingredientsDescrScrollSprite.init(this.ingredientDescription.height);
      }
      
      protected function nextProductHandler(sender:Object) : void
      {
         this.updateCurrentRecipe(this.currentRecipe + 1);
      }
      
      protected function prevProductHandler(sender:Object) : void
      {
         this.updateCurrentRecipe(this.currentRecipe - 1);
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
            this.infoMenu.create(this.PRODUCT_INFO_WINDOW_X,this.PRODUCT_INFO_WINDOW_Y);
         }
      }
   }
}

