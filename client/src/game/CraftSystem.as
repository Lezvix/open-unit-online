package game
{
   import flash.utils.Dictionary;
   
   public final class CraftSystem
   {
      
      public static const UpgradeCount:int = 26;
      
      public static const W_IncAccuracy_10p:int = 0;
      
      public static const W_IncDispuption_10p:int = 1;
      
      public static const W_IncMagazineCapacity_10p:int = 2;
      
      public static const W_IncDamage_5p:int = 3;
      
      public static const W_DecReqStrength_1:int = 4;
      
      public static const W_IncDurability_20p:int = 5;
      
      public static const A_IncCB_7p:int = 6;
      
      public static const A_IncRNormal_15:int = 7;
      
      public static const A_IncRPlasma_15:int = 8;
      
      public static const A_IncDurability_20p:int = 9;
      
      public static const A_IncHp_7:int = 10;
      
      public static const A_IncPerception:int = 11;
      
      public static const A_IncStrength:int = 12;
      
      public static const A_IncEndurance:int = 13;
      
      public static const A_IncDeftness:int = 14;
      
      public static const W_IncAccuracy_15p:int = 15;
      
      public static const W_IncDispuption_15p:int = 16;
      
      public static const W_IncMagazineCapacity_15p:int = 17;
      
      public static const W_IncDamage_8p:int = 18;
      
      public static const W_DecReqStrength_1_:int = 19;
      
      public static const W_IncDurability_30p:int = 20;
      
      public static const A_IncCB_10p:int = 21;
      
      public static const A_IncRNormal_25:int = 22;
      
      public static const A_IncRPlasma_25:int = 23;
      
      public static const A_IncDurability_30p:int = 24;
      
      public static const A_IncHp_10:int = 25;
      
      private static var _upgradeGroupsLoaded:Boolean = false;
      
      private static var _upgradeRecipes:Dictionary = new Dictionary();
      
      private static var _craftRecipes:Dictionary = new Dictionary();
      
      private static var _upgradeGroups:Dictionary = new Dictionary();
      
      public function CraftSystem()
      {
         super();
      }
      
      public static function parseCraftRecipes(param1:Array) : void
      {
         var position:int = 1;
         var workbenchId:int = param1[position++];
         if(workbenchId in _craftRecipes)
         {
            return;
         }
         var recipes:Array = new Array();
         var recipesRemaining:int = param1[position++];
         var recipe:Object;
         var instrumentsRemaining:int;
         var productLength:int;
         var product:InventoryItem;
         var ingredientsRemaining:int;
         var ingredients:Array;
         while(recipesRemaining > 0)
         {
            recipe = new Object();
            recipe["id"] = int(param1[position++]);
            recipe["productCount"] = int(param1[position++]);
            recipe["group"] = int(param1[position++]);
            recipe["skillType"] = int(param1[position++]);
            recipe["skillValue"] = int(param1[position++]);
            recipe["instruments"] = [];
            instrumentsRemaining = int(param1[position++]);
            while(instrumentsRemaining > 0)
            {
               recipe["instruments"].push({
                  "id":int(param1[position++]),
                  "name":param1[position++]
               });
               instrumentsRemaining--;
            }
            productLength = param1[position];
            product = new InventoryItem(param1.slice(position,position + productLength));
            position += productLength;
            recipe["product"] = product;
            ingredientsRemaining = param1[position++];
            ingredients = new Array();
            while(ingredientsRemaining > 0)
            {
               ingredients.push({
                  "id":int(param1[position++]),
                  "name":param1[position++],
                  "count":int(param1[position++])
               });
               ingredientsRemaining--;
            }
            recipe["ingredients"] = ingredients;
            recipes.push(recipe);
            recipesRemaining--;
         }
         _craftRecipes[workbenchId] = recipes;
      }
      
      public static function getCraftRecipes(param1:int) : Array
      {
         return _craftRecipes[param1];
      }
      
      public static function parseUpgradeRecipes(param1:Array) : void
      {
         var position:int = 1;
         var workbenchId:int = param1[position++];
         if(workbenchId in _upgradeRecipes)
         {
            return;
         }
         var recipes:Dictionary = new Dictionary();
         var recipesRemaining:int = param1[position++];
         var recipe:Object;
         var instrumentsRemaining:int;
         var ingredientsRemaining:int;
         var ingredients:Array;
         while(recipesRemaining > 0)
         {
            recipe = new Object();
            recipe["id"] = int(param1[position++]);
            recipe["upgrade"] = int(param1[position++]);
            recipe["skillType"] = int(param1[position++]);
            recipe["skillValue"] = int(param1[position++]);
            recipe["instruments"] = [];
            instrumentsRemaining = int(param1[position++]);
            while(instrumentsRemaining > 0)
            {
               recipe["instruments"].push({
                  "id":int(param1[position++]),
                  "name":param1[position++]
               });
               instrumentsRemaining--;
            }
            ingredientsRemaining = param1[position++];
            ingredients = new Array();
            while(ingredientsRemaining > 0)
            {
               ingredients.push({
                  "id":int(param1[position++]),
                  "name":param1[position++],
                  "count":int(param1[position++])
               });
               ingredientsRemaining--;
            }
            recipe["ingredients"] = ingredients;
            recipes[recipe.upgrade] = recipe;
            recipesRemaining--;
         }
         _upgradeRecipes[workbenchId] = recipes;
      }
      
      public static function getUpgradeRecipes(param1:int) : Dictionary
      {
         return _upgradeRecipes[param1];
      }
      
      public static function get UpgradeGroupsLoaded() : Boolean
      {
         return _upgradeGroupsLoaded;
      }
      
      public static function parseUpgradeGroups(param1:Array) : void
      {
         _upgradeGroups = new Dictionary();
         var position:int = 1;
         var groupsRemaining:int = param1[position++];
         var groupId:int;
         var upgradesRemaining:int;
         var upgrades:Array;
         while(groupsRemaining > 0)
         {
            groupId = param1[position++];
            upgradesRemaining = param1[position++];
            upgrades = new Array();
            while(upgradesRemaining > 0)
            {
               upgrades.push(int(param1[position++]));
               upgradesRemaining--;
            }
            _upgradeGroups[groupId] = upgrades;
            groupsRemaining--;
         }
         _upgradeGroupsLoaded = true;
      }
      
      public static function get UpgradeGroups() : Dictionary
      {
         return _upgradeGroups;
      }
      
      public static function GetUpgradeName(param1:int) : String
      {
         return Client.getString("IDS_UPGRADE_" + param1);
      }
      
      public static function GetUpgradeChance(param1:int) : Number
      {
         return 25 + 75 / Math.pow(Math.E,param1);
      }
   }
}

