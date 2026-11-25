package game
{
   import game.npc.PlayerItem;
   import debug.Assert;
   
   public class InventoryItem implements IListenable
   {
      
      public static const INVENTORY_MAX_ID:int = 1000000000;
      
      public static const array79:Array = [2,4];
      
      public static const AMMO_TYPE_NORMAL:int = 0;
      
      public static const TRAUM_HARD:int = 1;
      
      public static const FILTER_ARMOR:int = 0;
      
      public static const FILTER_WEAPON:int = 1;
      
      public static const FILTER_BULLET:int = 2;
      
      public static const FILTER_ADDON:int = 4;
      
      public static const FILTER_MEDICINE:int = 3;
      
      public static const FILTER_ITEM:int = 5;
      
      public static const FILTER_QUEST:int = 6;
      
      public static const FILTER_ALL:int = 7;
      
      public static const TRAUM_8:int = 8;
      
      public static const TRAUM_LIGHT:int = 0;
      
      public static const set:int = 1;
      
      public static const REPAIR_TYPE_NONE:int = 2;
      
      public static const FIRE_SINGLE:int = 0;
      
      public static const WEAPON_TYPE_SINGLE:int = 1;
      
      public static const WEAPON_TYPE_HALFAUTO:int = 2;
      
      public static const EXPENDABLES_HEIGHT:int = 30;
      
      public static const TYPE_WEAPON:int = 0;
      
      public static const TYPE_HELMET:int = 1;
      
      public static const TYPE_ARMOR:int = 2;
      
      public static const TYPE_PANTS:int = 3;
      
      public static const TYPE_BOOTS:int = 4;
      
      public static const TYPE_GRENADE:int = 5;
      
      public static const TYPE_MONEY:int = 6;
      
      public static const TYPE_MEDICINE:int = 7;
      
      public static const TYPE_AMMO:int = 8;
      
      public static const TYPE_ADDON:int = 9;
      
      public static const TYPE_OTHER_ITEM:int = 10;
      
      public static const TYPE_OTHER_EXP:int = 11;
      
      public static const TYPE_SPARES:int = 12;
      
      public static const TYPE_HEAL_PACKS:int = 13;
      
      public static const TYPE_ITEM_PRESENT:int = 14;
      
      public static const TYPE_TOOL:int = 15;
      
      public static const TYPE_MINE:int = 16;
      
      public static const TYPE_SAPPER_TOOL:int = 17;
      
      public static const TYPE_RARE_EXP:int = 18;
      
      public static const TYPE_RARE_19:int = 19;
      
      public static const TYPE_RARE_20:int = 20;
      
      public static const TYPE_RARE_21:int = 21;
      
      public static const array83:Array = [0,Character.HELMET_IDX,Character.ARMOR_IDX,Character.PANTS_IDX,Character.BOOTS_IDX];
      
      public static const array113:Array = [0,PlayerItem.WEAPON_4,PlayerItem.BODY_5,PlayerItem.WEAPON_LAYER,PlayerItem.WEAPON_3];
      
      public static const array81:Array = [0.05,0.08,0.12];
      
      public static const array10:Array = [40,40,30,20];
      
      public static const WEAPON_TYPE_NEAR:int = 0;
      
      public static const FIRE_AUTO:int = 1;
      
      public static const WEAPON_TYPE_2:int = 2;
      
      public static const WEAPON_TYPE_AUTO:int = 3;
      
      public static const WEAPON_TYPE_NEAR_USE:int = 4;
      
      public static const WEAPON_TYPE_5:int = 5;
      
      public static const WEAPON_TYPE_HEALING:int = 6;
      
      public static const WP_WEAPON_TYPE:int = 0;
      
      public static const WP_DAMAGE_MIN:int = 1;
      
      public static const WP_DAMAGE_MAX:int = 2;
      
      public static const WP_ACCURACY:int = 3;
      
      public static const WP_ARMOR_FAULT:int = 4;
      
      public static const WP_DISTANCE:int = 5;
      
      public static const WP_SPEED:int = 6;
      
      public static const WP_AMMO_TYPE:int = 7;
      
      public static const WP_MAGAZIN_COUNT:int = 8;
      
      public static const WP_BURST_COUNT:int = 9;
      
      public static const WP_SKILL_TYPE:int = 10;
      
      public static const WP_SKILL_VALUE:int = 11;
      
      public static const WP_MIN_STRENGTH:int = 12;
      
      public static const WP_DURABILITY:int = 13;
      
      public static const WP_CONCENTRATION:int = 14;
      
      public static const WP_CRITICAL_POINT:int = 15;
      
      public static const WP_PENALTY_ZONES:int = 16;
      
      public static const WP_PENALTY_TYPES:int = 17;
      
      public static const TP_WEAPON_TYPE:int = 0;
      
      public static const TP_DAMAGE_MIN:int = 1;
      
      public static const TP_DAMAGE_MAX:int = 2;
      
      public static const TP_ACCURACY:int = 3;
      
      public static const TP_ARMOR_FAULT:int = 4;
      
      public static const TP_DISTANCE:int = 5;
      
      public static const TP_SPEED:int = 6;
      
      public static const TP_AMMO_TYPE:int = 7;
      
      public static const TP_MAGAZIN_COUNT:int = 8;
      
      public static const TP_BURST_COUNT:int = 9;
      
      public static const TP_SKILL_TYPE:int = 10;
      
      public static const TP_SKILL_VALUE:int = 11;
      
      public static const TP_MIN_STRENGTH:int = 12;
      
      public static const TP_DURABILITY:int = 13;
      
      public static const TP_CONCENTRATION:int = 14;
      
      public static const TP_CRITICAL_POINT:int = 15;
      
      public static const TP_PENALTY_ZONES:int = 16;
      
      public static const TP_PENALTY_TYPES:int = 17;
      
      public static const TP_PRODUCTION_SPEED:int = 18;
      
      public static const TP_PRODUCTION_EFFICACY:int = 19;
      
      public static const TP_HARVESTER_ADD:int = 20;
      
      public static const TP_RESOURCE_TYPE:int = 21;
      
      public static const STP_WEAPON_TYPE:int = 0;
      
      public static const STP_DAMAGE_MIN:int = 1;
      
      public static const STP_DAMAGE_MAX:int = 2;
      
      public static const STP_ACCURACY:int = 3;
      
      public static const STP_ARMOR_FAULT:int = 4;
      
      public static const STP_DISTANCE:int = 5;
      
      public static const STP_SPEED:int = 6;
      
      public static const STP_AMMO_TYPE:int = 7;
      
      public static const STP_MAGAZIN_COUNT:int = 8;
      
      public static const STP_BURST_COUNT:int = 9;
      
      public static const STP_SKILL_TYPE:int = 10;
      
      public static const STP_SKILL_VALUE:int = 11;
      
      public static const STP_MIN_STRENGTH:int = 12;
      
      public static const STP_DURABILITY:int = 13;
      
      public static const STP_CONCENTRATION:int = 14;
      
      public static const STP_CRITICAL_POINT:int = 15;
      
      public static const STP_PENALTY_ZONES:int = 16;
      
      public static const STP_PENALTY_TYPES:int = 17;
      
      public static const STP_CLEARING_SPEED:int = 18;
      
      public static const STP_BLOW_PROBABILITY:int = 19;
      
      public static const AP_APPEARANCE_IMG:int = 0;
      
      public static const AP_APPEARANCE_PAL:int = 1;
      
      public static const AP_ARMOR_CLASS:int = 2;
      
      public static const AP_STAB_RADIATION:int = 3;
      
      public static const AP_STAB_NORMAL:int = 4;
      
      public static const AP_STAB_FIRE:int = 5;
      
      public static const AP_STAB_PLAZMA:int = 6;
      
      public static const AP_DURABILITY:int = 7;
      
      public static const AP_SEX:int = 8;
      
      public static const AP_9:int = 9;
      
      public static const AP_10:int = 10;
      
      public static const AP_11:int = 11;
      
      public static const AP_12:int = 12;
      
      public static const AP_13:int = 13;
      
      public static const AP_14:int = 14;
      
      public static const AP_15:int = 15;
      
      public static const SPARES_16:int = 16;
      
      public static const SPARES_ID:int = 17;
      
      public static const SPARES_18:int = 18;
      
      public static const WEAPON_PENALTY_19:int = 19;
      
      public static const WEAPON_PENALTY_NONE:int = 0;
      
      public static const WEAPON_PENALTY_LOW:int = 1;
      
      public static const WEAPON_PENALTY_MEDIUM:int = 2;
      
      public static const WEAPON_PENALTY_3:int = 3;
      
      public static const WEAPON_PENALTY_4:int = 4;
      
      public static const WEAPON_PENALTY_5:int = 5;
      
      public static const WEAPON_PENALTY_6:int = 6;
      
      public static const WEAPON_PENALTY_7:int = 7;
      
      public static const WEAPON_PENALTY_8:int = 8;
      
      public static const WEAPON_PENALTY_9:int = 9;
      
      public static const GP_10:int = 10;
      
      public static const GP_DISTANCE:int = 0;
      
      public static const GP_RADIUS:int = 1;
      
      public static const GP_DAMAGE_MIN:int = 2;
      
      public static const GP_DAMAGE_MAX:int = 3;
      
      public static const GP_SUB_RUN:int = 4;
      
      public static const MP_TIME:int = 0;
      
      public static const MP_RADIUS:int = 1;
      
      public static const MP_DAMAGE_MIN:int = 2;
      
      public static const MP_DAMAGE_MAX:int = 3;
      
      public static const MP_MONEY_TYPE:int = 0;
      
      public static const MDP_MEDICINE_SPEED:int = 0;
      
      public static const MDP_MEDICINE_ACTION_0:int = 1;
      
      public static const MDP_MEDICINE_VAL_0:int = 2;
      
      public static const MDP_MEDICINE_ACTION_1:int = 3;
      
      public static const MDP_MEDICINE_VAL_1:int = 4;
      
      public static const MDP_MEDICINE_ACTION_2:int = 5;
      
      public static const MDP_MEDICINE_VAL_2:int = 6;
      
      public static const MDP_MEDICINE_ACTION_3:int = 7;
      
      public static const MDP_MEDICINE_VAL_3:int = 8;
      
      public static const MDP_MEDICINE_ACTION_4:int = 9;
      
      public static const MDP_MEDICINE_VAL_4:int = 10;
      
      public static const MDP_MEDICINE_ACTION_5:int = 11;
      
      public static const MDP_MEDICINE_VAL_5:int = 12;
      
      public static const MDP_MEDICINE_ACTION_6:int = 13;
      
      public static const MDP_MEDICINE_VAL_6:int = 14;
      
      public static const MDP_MEDICINE_ACTION_7:int = 15;
      
      public static const MDP_MEDICINE_VAL_7:int = 16;
      
      public static const MDP_MEDICINE_ACTION_8:int = 17;
      
      public static const MDP_MEDICINE_VAL_8:int = 18;
      
      public static const MDP_MEDICINE_ACTION_9:int = 19;
      
      public static const MDP_MEDICINE_VAL_9:int = 20;
      
      public static const MDP_MEDICINE_ACTION_10:int = 21;
      
      public static const MDP_MEDICINE_VAL_10:int = 22;
      
      public static const HPP_TRAUM_TYPE:int = 0;
      
      public static const AMP_TYPE:int = 0;
      
      public static const AMP_SPECIAL_TYPE:int = 1;
      
      public static const AMP_SPECIAL_VALUE:int = 2;
      
      public static const AMP_SPECIAL_VALUE_2:int = 3;
      
      public static const AMP_SPECIAL_VALUE_3:int = 4;
      
      public static const AMP_SPECIAL_VALUE_4:int = 5;
      
      public static const IPP_CAN_OPEN:int = 0;
      
      public static const IPP_SENDER_LOGIN:int = 1;
      
      public static const IPP_SIGNATURE:int = 2;
      
      public static const MAT_NONE:int = 0;
      
      public static const MAT_ADD_HP:int = 1;
      
      public static const MAT_ADD_INTERVAL_HP:int = 2;
      
      public static const MAT_SUB_INTERVAL_HP:int = 3;
      
      public static const MAT_ADD_HIT_HP:int = 4;
      
      public static const MAT_ADD_STAT_0:int = 5;
      
      public static const MAT_ADD_STAT_1:int = 6;
      
      public static const MAT_ADD_STAT_2:int = 7;
      
      public static const MAT_ADD_STAT_3:int = 8;
      
      public static const MAT_ADD_STAT_4:int = 9;
      
      public static const MAT_ADD_STAT_5:int = 10;
      
      public static const MAT_SUB_STAT_0:int = 11;
      
      public static const MAT_SUB_STAT_1:int = 12;
      
      public static const MAT_SUB_STAT_2:int = 13;
      
      public static const MAT_SUB_STAT_3:int = 14;
      
      public static const MAT_SUB_STAT_4:int = 15;
      
      public static const MAT_SUB_STAT_5:int = 16;
      
      public static const MAT_ADD_RADIATION_DP:int = 17;
      
      public static const MAT_ADD_NARCOTICS_DP:int = 18;
      
      public static const MAT_ADD_ALCOHOL_DP:int = 19;
      
      public static const MAT_ADD_CHEMICAL_DP:int = 20;
      
      public static const MAT_SUB_RADIATION_DP:int = 21;
      
      public static const MAT_SUB_NARCOTICS_DP:int = 22;
      
      public static const MAT_SUB_ALCOHOL_DP:int = 23;
      
      public static const MAT_SUB_CHEMICAL_DP:int = 24;
      
      public static const MAT_DURMAN_TRAUMA:int = 25;
      
      public static const MAT_ADD_RADIATION_TIME:int = 26;
      
      public static const MAT_USE_LIMIT:int = 27;
      
      public static const MAT_TIMER_VALUE:int = 28;
      
      public static const ADP_ADDON_TYPE:int = 0;
      
      public static const STATUS_NOT_WEAR:int = 0;
      
      public static const STATUS_WEAR:int = 1;
      
      public static const STATUS_WEAR_SECOND:int = 2;
      
      public static const WEAPON_PENALTY_BIG:int = 3;
      
      public static const WEAPON_PENALTY:Array = [0,15,30,45];
      
      public var itemId:int;
      
      public var inventoryId:int;
      
      public var itemname:String;
      
      public var level:int;
      
      public var image:int;
      
      public var type:int;
      
      public var price:int;
      
      public var repairPrice:int;
      
      public var weight:int;
      
      public var upgradeCategory:int;
      
      public var itemClass:int = 0;
      
      public var status:int;
      
      public var loadStatus:int;
      
      protected var _inventoryCount:int = 1;
      
      protected var _itemTear:int = -1;
      
      public var isArt:Boolean = false;
      
      public var repairType:int = 0;
      
      public var effects:Array = new Array();
      
      public var upgrades:Array = new Array();
      
      public var params:Array = new Array();
      
      public var slotIdx:int;
      
      public var isChanged:Boolean = false;
      
      private var data:Array;
      
      public var questItem:Boolean = false;
      
      public var flag51:Boolean = false;
      
      private var endtime:int = 0;
      
      private var _rank:int = 0;
      
      public function InventoryItem(fields:Array)
      {
         super();
         this.data = fields;
         var position:int = 0;
         var recordLength:int = fields[position++];
         this.itemId = fields[position++];
         this.inventoryId = fields[position++];
         this.endtime = fields[position++];
         this._rank = fields[position++];
         this.itemname = fields[position++];
         this.level = fields[position++];
         this.image = fields[position++];
         this.type = fields[position++];
         this.price = fields[position++];
         this.weight = fields[position++];
         this.upgradeCategory = fields[position++];
         var effectCount:int = fields[position++];
         var upgradesRemaining:int = fields[position++];
         this.upgrades = new Array();
         while(upgradesRemaining > 0)
         {
            this.upgrades.push(int(fields[position++]));
            upgradesRemaining--;
         }
         var effectsStart:int = recordLength - 4 * effectCount;
         this.effects = new Array();
         this.params = new Array();
         switch(this.type)
         {
            case TYPE_AMMO:
            case TYPE_MEDICINE:
            case TYPE_MINE:
            case TYPE_GRENADE:
            case TYPE_MONEY:
            case TYPE_RARE_21:
               this.status = fields[position++];
               this.count = fields[position++];
               break;
            case TYPE_ADDON:
               this.status = fields[position++];
               this.repairPrice = fields[position++];
               this.isChanged = fields[position++] == "1";
               this.isArt = fields[position++] == "1";
               this.tear = fields[position++];
               break;
            case TYPE_OTHER_ITEM:
            case TYPE_RARE_19:
               this.repairPrice = fields[position++];
               this.isChanged = fields[position++] == "1";
               this.isArt = fields[position++] == "1";
               break;
            case TYPE_ITEM_PRESENT:
               this.itemname = Client._("IDS_PRESENT");
               this.tear = 0;
               break;
            case TYPE_OTHER_EXP:
            case TYPE_RARE_EXP:
            case TYPE_SPARES:
            case TYPE_HEAL_PACKS:
               this.count = fields[position++];
               break;
            default:
               this.itemClass = fields[position++];
               this.status = fields[position++];
               this.repairPrice = fields[position++];
               this.isChanged = fields[position++] == "1";
               this.isArt = fields[position++] == "1";
               this.tear = fields[position++];
               switch(fields[position])
               {
                  case "1":
                     this.repairType = set;
                     break;
                  case "2":
                     this.repairType = REPAIR_TYPE_NONE;
                     break;
                  default:
                     this.repairType = TRAUM_LIGHT;
                     break;
               }
               position++;
               break;
         }
         while(position < effectsStart)
         {
            this.params.push(fields[position++]);
         }
         var effectPosition:int = effectsStart;
         while(effectPosition < recordLength)
         {
            this.effects.push({
               "type":int(fields[effectPosition]),
               "probability":int(fields[effectPosition + 1]),
               "param":int(fields[effectPosition + 2]),
               "duration":Number(int(fields[effectPosition + 3]) / 10)
            });
            effectPosition += 4;
         }
         this.loadStatus = this.status;
      }
      
      public static function getNumber7(param1:int) : Number
      {
         if(param1 > 70)
         {
            return 1.1;
         }
         if(param1 > 40)
         {
            return 1.2;
         }
         if(param1 > 15)
         {
            return 1.4;
         }
         if(param1 > -5)
         {
            return 1.6;
         }
         if(param1 > -50)
         {
            return 1.8;
         }
         if(param1 > -100)
         {
            return 2;
         }
         return 2.2;
      }
      
      private static function getDescr(param1:int) : String
      {
         return Client._(param1.toString());
      }
      
      public function get isValue1() : Boolean
      {
         return this.endtime > 0;
      }
      
      public function get propValue95() : int
      {
         return this._rank;
      }
      
      public function get propValue101() : String
      {
         return Chat.getString32(this.endtime);
      }
      
      public function clone() : InventoryItem
      {
         return new InventoryItem(this.data);
      }
      
      public function splitStack(amount:int) : InventoryItem
      {
         Assert.isTrue(this.isExpendable);
         Assert.isTrue(amount > 0 && amount < this.count);
         var splitItem:InventoryItem = this.clone();
         splitItem.count = amount;
         this.count -= amount;
         return splitItem;
      }
      
      public function get statusChanged() : Boolean
      {
         return this.status != this.loadStatus;
      }
      
      public function hasUpgrade(param1:int) : Boolean
      {
         return this.upgrades.indexOf(param1) != -1;
      }
      
      public function get description() : String
      {
         var description:String = getDescr(this.itemId);
         return description == null ? "" : description;
      }
      
      public function get descriptionOrDefault() : String
      {
         var description:String = getDescr(this.itemId);
         return description == null ? getDescr(0) : description;
      }
      
      public function filter(param1:int) : Boolean
      {
         if(this.type == TYPE_MONEY)
         {
            return true;
         }
         switch(param1)
         {
            case FILTER_ARMOR:
               return this.type == TYPE_ARMOR || this.type == TYPE_BOOTS || this.type == TYPE_HELMET || this.type == TYPE_PANTS;
            case FILTER_WEAPON:
               return this.type == TYPE_WEAPON;
            case FILTER_ADDON:
               return this.type == TYPE_ADDON || this.type == TYPE_TOOL || this.type == TYPE_SAPPER_TOOL || this.type == TYPE_SPARES || this.type == TYPE_RARE_20;
            case FILTER_BULLET:
               return this.type == TYPE_AMMO || this.type == TYPE_GRENADE || this.type == TYPE_MINE;
            case FILTER_MEDICINE:
               return this.type == TYPE_MEDICINE || this.type == TYPE_HEAL_PACKS || this.type == TYPE_RARE_21;
            case FILTER_QUEST:
               return this.isChanged;
            case FILTER_ITEM:
               return this.type == TYPE_OTHER_EXP;
            case FILTER_ALL:
            default:
               return true;
         }
      }
      
      public function get hasDurability() : Boolean
      {
         return this.type == TYPE_ARMOR || this.type == TYPE_BOOTS || this.type == TYPE_HELMET || this.type == TYPE_PANTS || this.type == TYPE_SAPPER_TOOL || this.type == TYPE_TOOL || this.type == TYPE_WEAPON || this.type == TYPE_RARE_20;
      }
      
      public function get isValue39() : Boolean
      {
         return this.hasDurability && this.repairType != REPAIR_TYPE_NONE;
      }
      
      public function get sparesId() : int
      {
         return this.repairType == set ? -226 : -17;
      }
      
      public function get isExpendable() : Boolean
      {
         switch(this.type)
         {
            case TYPE_AMMO:
            case TYPE_GRENADE:
            case TYPE_HEAL_PACKS:
            case TYPE_MEDICINE:
            case TYPE_RARE_21:
            case TYPE_MINE:
            case TYPE_MONEY:
            case TYPE_OTHER_EXP:
            case TYPE_RARE_EXP:
            case TYPE_SPARES:
               return true;
            default:
               return false;
         }
      }
      
      public function get isValue59() : Boolean
      {
         return this.type == TYPE_ARMOR || this.type == TYPE_BOOTS || this.type == TYPE_HELMET || this.type == TYPE_PANTS;
      }
      
      public function get isValue67() : Boolean
      {
         return this.type == TYPE_MEDICINE || this.type == TYPE_GRENADE || this.type == TYPE_MINE || this.type == TYPE_RARE_21;
      }
      
      public function get isWeapon() : Boolean
      {
         return this.type == TYPE_WEAPON || this.type == TYPE_TOOL || this.type == TYPE_SAPPER_TOOL || this.type == TYPE_RARE_20;
      }
      
      public function get count() : int
      {
         return this._inventoryCount;
      }
      
      public function set count(param1:int) : void
      {
         if(this._inventoryCount != param1)
         {
            _inventoryCount = param1;
            this.dispatchChange("count");
         }
      }
      
      public function get tear() : int
      {
         return this._itemTear;
      }
      
      public function set tear(param1:int) : void
      {
         if(this._itemTear != param1)
         {
            _itemTear = param1;
            this.dispatchChange("tear");
         }
      }
      
      public function getBotRepairCost(percent:int) : int
      {
         Assert.isTrue(this.repairType == TRAUM_LIGHT);
         var cost:int = 0;
         switch(this.type)
         {
            case TYPE_WEAPON:
            case TYPE_TOOL:
            case TYPE_SAPPER_TOOL:
               cost = Math.max(1,(this.repairPrice - int(this.repairPrice * array10[this.params[WP_DURABILITY]] / 100)) * (100 - this.tear) / 100);
               break;
            case TYPE_HELMET:
            case TYPE_ARMOR:
            case TYPE_PANTS:
            case TYPE_BOOTS:
               cost = Math.max(1,(this.repairPrice - int(this.repairPrice * array10[this.params[WEAPON_PENALTY_7]] / 100)) * (100 - this.tear) / 100);
               break;
         }
         return cost * 1.1 * percent / 100;
      }
      
      public function getRepairCost(repairSkill:int) : int
      {
         Assert.isTrue(this.isValue39);
         var cost:int = 0;
         switch(this.type)
         {
            case TYPE_WEAPON:
            case TYPE_TOOL:
            case TYPE_SAPPER_TOOL:
            case TYPE_RARE_20:
               cost = Math.max(1,(this.repairPrice - int(this.repairPrice * array10[this.params[WP_DURABILITY]] / 100)) * (100 - this.tear) / 100);
               if(this.repairType == TRAUM_LIGHT)
               {
                  if(this.params[WP_SKILL_VALUE] < repairSkill)
                  {
                     if(repairSkill - this.params[WP_SKILL_VALUE] > 80)
                     {
                        cost = Math.max(1,cost * 0.75);
                     }
                     else
                     {
                        cost = Math.max(1,cost * (1.15 - 0.005 * (repairSkill - this.params[WP_SKILL_VALUE])));
                     }
                  }
                  else
                  {
                     cost = Math.max(1,cost * 1.2);
                     cost += cost * 0.005 * (this.params[WP_SKILL_VALUE] - repairSkill);
                  }
               }
               break;
            case TYPE_HELMET:
            case TYPE_ARMOR:
            case TYPE_PANTS:
            case TYPE_BOOTS:
               cost = Math.max(1,(this.repairPrice - int(this.repairPrice * array10[this.params[WEAPON_PENALTY_7]] / 100)) * (100 - this.tear) / 100);
               if(this.repairType == TRAUM_LIGHT)
               {
                  if(this.params[WEAPON_PENALTY_MEDIUM] < repairSkill)
                  {
                     if(repairSkill - this.params[WEAPON_PENALTY_MEDIUM] > 80)
                     {
                        cost = Math.max(1,cost * 0.75);
                     }
                     else
                     {
                        cost = Math.max(1,cost * (1.15 - 0.005 * (repairSkill - this.params[WEAPON_PENALTY_MEDIUM])));
                     }
                  }
                  else
                  {
                     cost = Math.max(1,cost * 1.2);
                     cost += cost * 0.005 * (this.params[WEAPON_PENALTY_MEDIUM] - repairSkill);
                  }
               }
               break;
         }
         return cost;
      }
      
      public function addChangeListener(param1:Function) : void
      {
         if(param1 == null || this.listeners.indexOf(param1) != -1)
         {
            return;
         }
         this.listeners.push(param1);
      }
      
      public function removeChangeListener(listener:Function) : void
      {
         var index:int = this.listeners.indexOf(listener);
         if(index != -1)
         {
            this.listeners.splice(index,1);
         }
      }
      
      protected const listeners:Vector.<Function> = new Vector.<Function>();

      protected function dispatchChange(property:String) : void
      {
         var change:Object = {"property":property};
         var listener:Function;
         for each(listener in this.listeners)
         {
            listener(change);
         }
      }
   }
}

