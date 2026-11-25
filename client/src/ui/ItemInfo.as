package ui
{
   import ui.buttons.TextLinkButton;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.InventoryItem;
   import game.Effect;
   import game.CraftSystem;
   
   public class ItemInfo extends NUIComponent
   {
      
      private static const ITEM_INFO_CONST1:int = 0;
      
      private static const ITEM_INFO_CONST2:int = 1;
      
      public var nameText:TextField;
      
      private var paramFormat:TextFormat;
      
      private var paramValueFormat:TextFormat;
      
      public var textButton:TextLinkButton;
      
      public var imageLoader:Loader;
      
      public var image:int;
      
      public var textName:String;
      
      public var descriptionText:String;
      
      public var texts:Array;
      
      public var textsValue:Array;
      
      public var description:TextField;
      
      public var targetItem:InventoryItem;
      
      public var mainParent:Object;
      
      private var paramId:int = 0;
      
      public function ItemInfo(param1:Object = null)
      {
         super();
         this.mainParent = param1;
         visible = false;
         this.paramFormat = NuclearMenu.getTextFormat();
         this.paramValueFormat = NuclearMenu.getTextFormat({
            "bold":true,
            "align":TextFormatAlign.RIGHT
         });
         this.imageLoader = new Loader();
         addChild(this.imageLoader);
         this.nameText = new TextField();
         this.nameText.selectable = false;
         this.nameText.y = 3;
         this.nameText.defaultTextFormat = NuclearMenu.getTextFormat({
            "bold":true,
            "align":TextFormatAlign.CENTER
         });
         addChild(this.nameText);
         this.description = new TextField();
         this.description.selectable = false;
         this.description.wordWrap = true;
         this.description.defaultTextFormat = NuclearMenu.getTextFormat({
            "bold":true,
            "leftMargin":4,
            "rightMargin":4
         });
         addChild(this.description);
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0;
      }
      
      override public function mouseDownHandler() : void
      {
         if(mouseY < 30)
         {
            startDrag();
         }
      }
      
      override public function mouseUpHandler() : void
      {
         stopDrag();
      }
      
      public function addParam(param1:String, param2:Object, param3:int = 0) : void
      {
         var labelField:TextField = new TextField();
         labelField.defaultTextFormat = this.paramFormat;
         labelField.x = 125;
         labelField.y = 26 + 15 * this.paramId;
         labelField.text = param1;
         labelField.selectable = false;
         labelField.width = 170;
         this.texts.push(labelField);
         this.addChild(labelField);
         var valueField:TextField = new TextField();
         valueField.defaultTextFormat = this.paramValueFormat;
         if(param3 == ITEM_INFO_CONST2)
         {
            valueField.textColor = 15597568;
         }
         valueField.x = 170;
         valueField.y = 26 + 15 * this.paramId;
         valueField.text = param2.toString();
         valueField.selectable = false;
         valueField.width = 177;
         this.textsValue.push(valueField);
         this.addChild(valueField);
         ++this.paramId;
      }
      
      public function create(param1:int = 150, param2:int = 50, param3:int = 360, param4:int = 200) : void
      {
         if(this.visible)
         {
            this.close();
         }
         this.x = param1;
         this.y = param2;
         this.visible = true;
         this.graphics.clear();
         paramId = 0;
         descriptionText = "";
         this.description.text = "";
         this.description.visible = false;
         this.clearText();
         texts = new Array();
         textsValue = new Array();
         image = this.targetItem.image;
         this.nameText.text = this.targetItem.itemname;
         this.nameText.width = param3;
         this.description.width = param3 - 20;
         var itemTypeLabel:String = _("IDS_INV_TYPE_" + this.targetItem.type);
         if(this.targetItem.type == InventoryItem.TYPE_MEDICINE)
         {
            index = InventoryItem.MDP_MEDICINE_ACTION_0;
            while(index < InventoryItem.MDP_MEDICINE_VAL_10)
            {
               switch(this.targetItem.params[index])
               {
                  case InventoryItem.MAT_ADD_NARCOTICS_DP:
                     itemTypeLabel = _("IDS_MED_NARCOTICS");
                     break;
                  case InventoryItem.MAT_ADD_ALCOHOL_DP:
                     itemTypeLabel = _("IDS_MED_ALCOHOL");
                     break;
               }
               index += 2;
            }
         }
         this.addParam(_("IDS_INV_TYPE"),itemTypeLabel);
         this.addParam(_("IDS_INV_LEVEL"),this.targetItem.level,this.targetItem.level > Main.UserCharacter.level ? ITEM_INFO_CONST2 : ITEM_INFO_CONST1);
         this.addParam(_("IDS_INV_PRICE"),this.targetItem.price);
         this.addParam(_("IDS_INV_WEIGHT"),this.targetItem.weight / 1000);
         var index:int;
         var upgradeBonus:int = 0;
         var effect:Object;
         var imageRequest:URLRequest;
         var weaponType:int;
         var requiredSkill:Object;
         var distanceTotal:int;
         switch(this.targetItem.type)
         {
            case InventoryItem.TYPE_AMMO:
               if(this.targetItem.params[InventoryItem.AMP_TYPE] == 12)
               {
                  this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.AMP_SPECIAL_VALUE_3] + " - " + this.targetItem.params[InventoryItem.AMP_SPECIAL_VALUE_4]);
                  this.addParam(_("IDS_INV_RADIUS"),this.targetItem.params[InventoryItem.AMP_SPECIAL_VALUE]);
               }
               break;
            case InventoryItem.TYPE_ITEM_PRESENT:
               descriptionText = _("IDS_PRESENTS_FROM") + " " + this.targetItem.params[InventoryItem.IPP_SENDER_LOGIN] + ". " + this.targetItem.params[InventoryItem.IPP_SIGNATURE];
               break;
            case InventoryItem.TYPE_MEDICINE:
            case InventoryItem.TYPE_RARE_21:
               this.addParam(_("IDS_INV_SPEED"),_("IDS_MED_SPEED_" + this.targetItem.params[InventoryItem.MDP_MEDICINE_SPEED]));
               index = InventoryItem.MDP_MEDICINE_ACTION_0;
               while(index < InventoryItem.MDP_MEDICINE_VAL_10)
               {
                  switch(int(this.targetItem.params[index]))
                  {
                     case InventoryItem.MAT_ADD_HP:
                        if((this.targetItem.params[index + 1] & 0xFF) == this.targetItem.params[index + 1] >> 8)
                        {
                           this.addParam(_("IDS_МЕD_ADD_HP"),this.targetItem.params[index + 1] & 0xFF);
                        }
                        else
                        {
                           this.addParam(_("IDS_МЕD_ADD_HP"),(this.targetItem.params[index + 1] & 0xFF) + "-" + (this.targetItem.params[index + 1] >> 8));
                        }
                        break;
                     case InventoryItem.MAT_ADD_RADIATION_DP:
                     case InventoryItem.MAT_ADD_NARCOTICS_DP:
                     case InventoryItem.MAT_ADD_ALCOHOL_DP:
                     case InventoryItem.MAT_ADD_CHEMICAL_DP:
                        this.addParam("+ " + _("IDS_MED_DEPENDENCE_" + (this.targetItem.params[index] - InventoryItem.MAT_ADD_RADIATION_DP)),this.targetItem.params[index + 1]);
                        break;
                     case InventoryItem.MAT_SUB_RADIATION_DP:
                     case InventoryItem.MAT_SUB_NARCOTICS_DP:
                     case InventoryItem.MAT_SUB_ALCOHOL_DP:
                     case InventoryItem.MAT_SUB_CHEMICAL_DP:
                        this.addParam("- " + _("IDS_MED_DEPENDENCE_" + (this.targetItem.params[index] - InventoryItem.MAT_SUB_RADIATION_DP)),this.targetItem.params[index + 1]);
                        break;
                  }
                  index += 2;
               }
               break;
            case InventoryItem.TYPE_WEAPON:
               weaponType = this.targetItem.params[InventoryItem.WP_WEAPON_TYPE];
               this.addParam(_("IDS_INV_TEAR"),this.targetItem.tear);
               if(this.targetItem.params[InventoryItem.WP_AMMO_TYPE] != 3)
               {
                  this.addParam(_("IDS_INV_WEAPON_TYPE"),_("IDS_WEAPON_TYPE_" + weaponType));
               }
               else
               {
                  this.addParam(_("IDS_INV_WEAPON_TYPE"),_("IDS_EN_WEAPON_TYPE_" + weaponType));
               }
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.W_IncDamage_5p))
               {
                  upgradeBonus += 5;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.W_IncDamage_8p))
               {
                  upgradeBonus += 8;
               }
               if(weaponType != InventoryItem.WEAPON_TYPE_HEALING)
               {
                  this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.WP_DAMAGE_MIN] + " - " + this.targetItem.params[InventoryItem.WP_DAMAGE_MAX] + (upgradeBonus > 0 ? " (+" + upgradeBonus + "%)" : ""));
               }
               if(weaponType != InventoryItem.WEAPON_TYPE_5 && weaponType != InventoryItem.WEAPON_TYPE_HEALING)
               {
                  upgradeBonus = 0;
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncAccuracy_10p))
                  {
                     upgradeBonus += 10;
                  }
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncAccuracy_15p))
                  {
                     upgradeBonus += 15;
                  }
                  this.addParam(_("IDS_INV_ACCURACY"),this.targetItem.params[InventoryItem.WP_ACCURACY] + (upgradeBonus > 0 ? " (+" + upgradeBonus + "%)" : ""));
                  upgradeBonus = 0;
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncDispuption_10p))
                  {
                     upgradeBonus += 10;
                  }
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncDispuption_15p))
                  {
                     upgradeBonus += 15;
                  }
                  this.addParam(_("IDS_INV_ARMOR_FAULT"),this.targetItem.params[InventoryItem.WP_ARMOR_FAULT] + (upgradeBonus > 0 ? " (+" + upgradeBonus + "%)" : ""));
               }
               this.addParam(_("IDS_INV_DISTANCE"),this.targetItem.params[InventoryItem.WP_DISTANCE]);
               this.addParam(_("IDS_INV_ATTACK_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.WP_SPEED]) >> 2 & 3)));
               this.addParam(_("IDS_INV_RELOAD_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.WP_SPEED]) & 3)));
               if(weaponType != InventoryItem.WEAPON_TYPE_NEAR)
               {
                  upgradeBonus = 0;
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncMagazineCapacity_10p))
                  {
                     upgradeBonus += 10;
                  }
                  if(this.targetItem.hasUpgrade(CraftSystem.W_IncMagazineCapacity_15p))
                  {
                     upgradeBonus += 15;
                  }
                  this.addParam(_("IDS_INV_MAGAZIN"),this.targetItem.params[InventoryItem.WP_MAGAZIN_COUNT] + (upgradeBonus > 0 ? " (+" + upgradeBonus + "%)" : ""));
                  this.addParam(_("IDS_INV_AMMO_TYPE"),_("IDS_AMMO_" + this.targetItem.params[InventoryItem.WP_AMMO_TYPE]));
                  if(weaponType != InventoryItem.WEAPON_TYPE_5 && weaponType != InventoryItem.WEAPON_TYPE_HEALING)
                  {
                     if(this.targetItem.params[InventoryItem.WP_BURST_COUNT] > 1 && this.targetItem.params[InventoryItem.WP_DISTANCE] > 1)
                     {
                        this.addParam(_("IDS_INV_CONCENTRATION"),_("IDS_CONCENTRATION_" + this.targetItem.params[InventoryItem.WP_CONCENTRATION]));
                     }
                     this.addParam(_("IDS_INV_CRITICAL_POINT"),this.targetItem.params[InventoryItem.WP_CRITICAL_POINT]);
                  }
               }
               if(this.targetItem.params[InventoryItem.WP_BURST_COUNT] > 1 && weaponType != InventoryItem.WEAPON_TYPE_5)
               {
                  this.addParam(_("IDS_INV_BURST"),this.targetItem.params[InventoryItem.WP_BURST_COUNT]);
               }
               requiredSkill = {
                  "id":int(this.targetItem.params[InventoryItem.WP_SKILL_TYPE]),
                  "value":int(this.targetItem.params[InventoryItem.WP_SKILL_VALUE])
               };
               this.addParam(_("IDS_SKILL_" + requiredSkill.id),requiredSkill.value,requiredSkill.value > Main.UserCharacter.skills[requiredSkill.id] / 10000 ? ITEM_INFO_CONST2 : ITEM_INFO_CONST1);
               if(this.targetItem.params[InventoryItem.WP_MIN_STRENGTH] > 0)
               {
                  upgradeBonus = 0;
                  if(this.targetItem.hasUpgrade(CraftSystem.W_DecReqStrength_1))
                  {
                     upgradeBonus += 1;
                  }
                  if(this.targetItem.hasUpgrade(CraftSystem.W_DecReqStrength_1_))
                  {
                     upgradeBonus += 1;
                  }
                  this.addParam(_("IDS_INV_STRENGTH"),this.targetItem.params[InventoryItem.WP_MIN_STRENGTH] + (upgradeBonus > 0 ? " (-" + upgradeBonus + ")" : ""));
               }
               this.addParam(_("IDS_INV_DURABILITY"),_("IDS_DURABILITY_" + this.targetItem.params[InventoryItem.WP_DURABILITY]));
               if(!this.targetItem.isValue39)
               {
                  this.addParam(_("IDS_INV_NOT_REPAIRABLE"),"");
               }
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.W_IncDurability_20p))
               {
                  upgradeBonus += 20;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.W_IncDurability_30p))
               {
                  upgradeBonus += 30;
               }
               if(upgradeBonus > 0)
               {
                  this.addParam(_("IDS_BREAK_CHANCE"),"-" + upgradeBonus + "%");
               }
               if(weaponType != InventoryItem.WEAPON_TYPE_5 && weaponType != InventoryItem.WEAPON_TYPE_NEAR && weaponType != InventoryItem.WEAPON_TYPE_HEALING && this.targetItem.params[InventoryItem.WP_DISTANCE] > 1)
               {
                  index = 0;
                  distanceTotal = 0;
                  descriptionText = _("IDS_INV_OPTIMAL_DIST");
                  while((this.targetItem.params[InventoryItem.WP_PENALTY_ZONES] >> index * 5 & 0x1F) != 0 && index < 5)
                  {
                     descriptionText += " " + (distanceTotal + 1).toString() + "-" + (distanceTotal + (this.targetItem.params[InventoryItem.WP_PENALTY_ZONES] >> index * 5 & 0x1F)).toString() + "(" + InventoryItem.WEAPON_PENALTY[this.targetItem.params[InventoryItem.WP_PENALTY_TYPES] >> (index << 1) & 3] + "%)";
                     distanceTotal += this.targetItem.params[InventoryItem.WP_PENALTY_ZONES] >> index * 5 & 0x1F;
                     index++;
                  }
               }
               break;
            case InventoryItem.TYPE_TOOL:
               this.addParam(_("IDS_INV_TEAR"),this.targetItem.tear);
               this.addParam(_("IDS_INV_PRODUCTION_SPEED"),_("IDS_PROD_SPEED_" + this.targetItem.params[InventoryItem.TP_PRODUCTION_SPEED]));
               this.addParam(_("IDS_INV_PRODUCTION_EFF"),_("IDS_PROD_EFF_" + this.targetItem.params[InventoryItem.TP_PRODUCTION_SPEED]));
               this.addParam(_("IDS_INV_HARVESTER_ADD"),this.targetItem.params[InventoryItem.TP_HARVESTER_ADD]);
               this.addParam(_("IDS_INV_RESOURCE_TYPE"),_("IDS_RES_TYPE_" + this.targetItem.params[InventoryItem.TP_RESOURCE_TYPE]));
               this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.TP_DAMAGE_MIN] + " - " + this.targetItem.params[InventoryItem.TP_DAMAGE_MAX]);
               this.addParam(_("IDS_INV_ACCURACY"),this.targetItem.params[InventoryItem.TP_ACCURACY]);
               this.addParam(_("IDS_INV_ARMOR_FAULT"),this.targetItem.params[InventoryItem.TP_ARMOR_FAULT]);
               this.addParam(_("IDS_INV_DISTANCE"),this.targetItem.params[InventoryItem.TP_DISTANCE]);
               this.addParam(_("IDS_INV_ATTACK_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.TP_SPEED]) >> 2 & 3)));
               this.addParam(_("IDS_INV_RELOAD_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.TP_SPEED]) & 3)));
               this.addParam(_("IDS_SKILL_" + this.targetItem.params[InventoryItem.TP_SKILL_TYPE]),this.targetItem.params[InventoryItem.TP_SKILL_VALUE]);
               if(this.targetItem.params[InventoryItem.TP_MIN_STRENGTH] > 0)
               {
                  this.addParam(_("IDS_INV_STRENGTH"),this.targetItem.params[InventoryItem.TP_MIN_STRENGTH]);
               }
               this.addParam(_("IDS_INV_DURABILITY"),_("IDS_DURABILITY_" + this.targetItem.params[InventoryItem.TP_DURABILITY]));
               if(!this.targetItem.isValue39)
               {
                  this.addParam(_("IDS_INV_NOT_REPAIRABLE"),"");
               }
               break;
            case InventoryItem.TYPE_RARE_20:
               this.addParam(_("IDS_INV_TEAR"),this.targetItem.tear);
               if(this.targetItem.params[InventoryItem.STP_BLOW_PROBABILITY] > 0)
               {
                  this.addParam(formatString("IDS_SKILL_ADDED",this.targetItem.params[InventoryItem.STP_CLEARING_SPEED]),this.targetItem.params[InventoryItem.STP_BLOW_PROBABILITY]);
               }
               this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.STP_DAMAGE_MIN] + " - " + this.targetItem.params[InventoryItem.STP_DAMAGE_MAX]);
               this.addParam(_("IDS_INV_ACCURACY"),this.targetItem.params[InventoryItem.STP_ACCURACY]);
               this.addParam(_("IDS_INV_ARMOR_FAULT"),this.targetItem.params[InventoryItem.STP_ARMOR_FAULT]);
               this.addParam(_("IDS_INV_DISTANCE"),this.targetItem.params[InventoryItem.STP_DISTANCE]);
               this.addParam(_("IDS_INV_ATTACK_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.STP_SPEED]) >> 2 & 3)));
               this.addParam(_("IDS_INV_RELOAD_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.STP_SPEED]) & 3)));
               this.addParam(_("IDS_SKILL_" + this.targetItem.params[InventoryItem.STP_SKILL_TYPE]),this.targetItem.params[InventoryItem.STP_SKILL_VALUE],this.targetItem.params[InventoryItem.STP_SKILL_VALUE] > Main.UserCharacter.skills[this.targetItem.params[InventoryItem.STP_SKILL_TYPE]] / 10000 ? ITEM_INFO_CONST2 : ITEM_INFO_CONST1);
               if(this.targetItem.params[InventoryItem.STP_MIN_STRENGTH] > 0)
               {
                  this.addParam(_("IDS_INV_STRENGTH"),this.targetItem.params[InventoryItem.STP_MIN_STRENGTH]);
               }
               this.addParam(_("IDS_INV_DURABILITY"),_("IDS_DURABILITY_" + this.targetItem.params[InventoryItem.STP_DURABILITY]));
               if(!this.targetItem.isValue39)
               {
                  this.addParam(_("IDS_INV_NOT_REPAIRABLE"),"");
               }
               break;
            case InventoryItem.TYPE_SAPPER_TOOL:
               this.addParam(_("IDS_INV_TEAR"),this.targetItem.tear);
               this.addParam(_("IDS_INV_MINE_CLEAR_SPEED"),_("IDS_MINE_SPEED_" + this.targetItem.params[InventoryItem.SPARES_18]));
               this.addParam(_("IDS_INV_BLOW_PROBABILITY"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_19] + "%");
               this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.AP_APPEARANCE_PAL] + " - " + this.targetItem.params[InventoryItem.AP_ARMOR_CLASS]);
               this.addParam(_("IDS_INV_ACCURACY"),this.targetItem.params[InventoryItem.AP_STAB_RADIATION]);
               this.addParam(_("IDS_INV_ARMOR_FAULT"),this.targetItem.params[InventoryItem.AP_STAB_NORMAL]);
               this.addParam(_("IDS_INV_DISTANCE"),this.targetItem.params[InventoryItem.AP_STAB_FIRE]);
               this.addParam(_("IDS_INV_ATTACK_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.AP_STAB_PLAZMA]) >> 2 & 3)));
               this.addParam(_("IDS_INV_RELOAD_SPEED"),_("IDS_MED_SPEED_" + (int(this.targetItem.params[InventoryItem.AP_STAB_PLAZMA]) & 3)));
               this.addParam(_("IDS_SKILL_" + this.targetItem.params[InventoryItem.AP_10]),this.targetItem.params[InventoryItem.AP_11]);
               if(this.targetItem.params[InventoryItem.AP_12] > 0)
               {
                  this.addParam(_("IDS_INV_STRENGTH"),this.targetItem.params[InventoryItem.AP_12]);
               }
               this.addParam(_("IDS_INV_DURABILITY"),_("IDS_DURABILITY_" + this.targetItem.params[InventoryItem.AP_13]));
               if(!this.targetItem.isValue39)
               {
                  this.addParam(_("IDS_INV_NOT_REPAIRABLE"),"");
               }
               break;
            case InventoryItem.TYPE_ARMOR:
            case InventoryItem.TYPE_BOOTS:
            case InventoryItem.TYPE_HELMET:
            case InventoryItem.TYPE_PANTS:
               this.addParam(_("IDS_INV_TEAR"),this.targetItem.tear);
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncCB_7p))
               {
                  upgradeBonus += 7;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncCB_10p))
               {
                  upgradeBonus += 10;
               }
               this.addParam(_("IDS_INV_ARMOR_CLASS"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_MEDIUM] + (upgradeBonus > 0 ? " (+" + upgradeBonus + "%)" : ""));
               this.addParam(_("IDS_INV_STAB_RAD"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_3]);
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncRNormal_15))
               {
                  upgradeBonus += 15;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncRNormal_25))
               {
                  upgradeBonus += 25;
               }
               this.addParam(_("IDS_INV_STAB_NORMAL"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_4] + (upgradeBonus > 0 ? " (+" + upgradeBonus + ")" : ""));
               this.addParam(_("IDS_INV_STAB_FIRE"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_5]);
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncRPlasma_15))
               {
                  upgradeBonus += 15;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncRPlasma_25))
               {
                  upgradeBonus += 25;
               }
               this.addParam(_("IDS_INV_STAB_PLAZMA"),this.targetItem.params[InventoryItem.WEAPON_PENALTY_6] + (upgradeBonus > 0 ? " (+" + upgradeBonus + ")" : ""));
               this.addParam(_("IDS_INV_DURABILITY"),_("IDS_DURABILITY_" + this.targetItem.params[InventoryItem.WEAPON_PENALTY_7]));
               if(this.targetItem.params[InventoryItem.WEAPON_PENALTY_8] != 0)
               {
                  this.addParam(_("IDS_SEX"),_("IDS_SEX_" + (this.targetItem.params[InventoryItem.WEAPON_PENALTY_8] - 1)));
               }
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncDurability_20p))
               {
                  upgradeBonus += 20;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncDurability_30p))
               {
                  upgradeBonus += 30;
               }
               if(upgradeBonus > 0)
               {
                  this.addParam(_("IDS_BREAK_CHANCE"),"-" + upgradeBonus + "%");
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncDeftness))
               {
                  this.addParam(_("IDS_STAT_4"),"+1");
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncEndurance))
               {
                  this.addParam(_("IDS_STAT_1"),"+1");
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncPerception))
               {
                  this.addParam(_("IDS_STAT_3"),"+1");
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncStrength))
               {
                  this.addParam(_("IDS_STAT_0"),"+1");
               }
               upgradeBonus = 0;
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncHp_7))
               {
                  upgradeBonus += 7;
               }
               if(this.targetItem.hasUpgrade(CraftSystem.A_IncHp_10))
               {
                  upgradeBonus += 10;
               }
               if(upgradeBonus > 0)
               {
                  this.addParam(_("IDS_МЕD_ADD_HP"),"+" + upgradeBonus);
               }
               if(!this.targetItem.isValue39)
               {
                  this.addParam(_("IDS_INV_NOT_REPAIRABLE"),"");
               }
               break;
            case InventoryItem.TYPE_GRENADE:
               this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.GP_DAMAGE_MIN] + " - " + this.targetItem.params[InventoryItem.GP_DAMAGE_MAX]);
               this.addParam(_("IDS_INV_RADIUS"),this.targetItem.params[InventoryItem.GP_RADIUS]);
               if(this.targetItem.params[InventoryItem.GP_SUB_RUN] > 0)
               {
                  this.addParam(_("IDS_INV_SUB_RUN"),this.targetItem.params[InventoryItem.GP_SUB_RUN]);
               }
               break;
            case InventoryItem.TYPE_MINE:
               this.addParam(_("IDS_INV_DAMAGE"),this.targetItem.params[InventoryItem.MP_DAMAGE_MIN] + " - " + this.targetItem.params[InventoryItem.MP_DAMAGE_MAX]);
               this.addParam(_("IDS_INV_LIVE_TIME"),this.targetItem.params[InventoryItem.MP_TIME] + _("IDS_HOURS"));
               this.addParam(_("IDS_INV_RADIUS"),this.targetItem.params[InventoryItem.MP_RADIUS]);
               break;
         }
         if(this.targetItem.isValue1)
         {
            this.addParam(_("EXPIRATION_DATE"),this.targetItem.propValue101);
         }
         if(this.targetItem.propValue95 > 0)
         {
            this.addParam(_("IDS_PVP_RANK"),_("IDS_RANK_" + this.targetItem.propValue95),this.targetItem.propValue95 > Main.UserCharacter.Rank ? ITEM_INFO_CONST2 : ITEM_INFO_CONST1);
         }
         if(this.targetItem.type != InventoryItem.TYPE_ITEM_PRESENT)
         {
            descriptionText += this.targetItem.description;
         }
         for each(effect in this.targetItem.effects)
         {
            switch(effect.type)
            {
               case Effect.LIGHT_TRAUMA:
               case Effect.SEVERE_TRAUMA:
                  this.addParam(Effect.getString31(effect),effect.probability + "%");
                  break;
               case Effect.EFFECT_CONST5:
                  this.addParam(Effect.GetName(effect),effect.param + "%");
                  break;
               default:
                  if(this.descriptionText)
                  {
                     descriptionText += "\n";
                  }
                  descriptionText += Effect.getString31(effect);
                  break;
            }
         }
         if(this.descriptionText)
         {
            this.description.text = this.descriptionText;
            this.description.background = true;
            this.description.backgroundColor = 2829099;
            this.description.height = 6 + this.description.textHeight;
            this.description.x = 10;
            this.description.y = 39 + this.paramId * 15;
            this.description.visible = true;
         }
         param4 = 39 + this.paramId * 15 + (this.descriptionText ? 8 + this.description.height : 0);
         graphics.beginFill(1776411);
         graphics.lineStyle(1,16688932,0.6);
         graphics.drawRect(0,0,param3,param4);
         graphics.endFill();
         graphics.lineStyle();
         graphics.beginFill(2829099);
         graphics.drawRect(120,24,param3 - 130,6 + this.paramId * 15);
         graphics.endFill();
         graphics.beginBitmapFill(slotBmp.bitmapData,new Matrix(1,0,0,1,10,(6 + this.paramId * 15) / 2 - 1));
         graphics.drawRect(10,(6 + this.paramId * 15) / 2 - 1,100,50);
         graphics.endFill();
         textButton = new TextLinkButton(this.onClose,"x",32);
         this.textButton.x = param3 - 4 - this.textButton.width;
         addUIChild(this.textButton);
         this.imageLoader.x = 60;
         this.imageLoader.y = (6 + this.paramId * 15) / 2 + 24;
         if(this.targetItem.type == InventoryItem.TYPE_ITEM_PRESENT)
         {
            imageRequest = new URLRequest("icons/presents/p" + this.image + ".png");
         }
         else
         {
            imageRequest = new URLRequest("icons/inv/i" + this.image + ".png");
         }
         this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoad);
         this.imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoad);
         this.imageLoader.load(imageRequest);
         this.width = param3;
         this.height = param4;
      }
      
      private function onLoad(param1:Event) : void
      {
         this.imageLoader.x -= int(this.imageLoader.width / 2);
         this.imageLoader.y -= int(this.imageLoader.height / 2);
         this.imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad);
         this.imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoad);
      }
      
      private function clearText() : void
      {
         var fieldIndex:int = 0;
         if(this.texts)
         {
            fieldIndex = 0;
            while(fieldIndex <= this.texts.length - 1)
            {
               this.removeChild(this.texts[fieldIndex]);
               this.removeChild(this.textsValue[fieldIndex]);
               fieldIndex++;
            }
         }
         texts = null;
         textsValue = null;
      }
      
      public function close() : void
      {
         visible = false;
         this.clearText();
         dispose();
      }
      
      private function onClose(param1:TextLinkButton) : void
      {
         this.close();
      }
   }
}

