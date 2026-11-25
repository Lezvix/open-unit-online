package game
{
   import debug.Assert;
   import events.*;
   import flash.utils.Dictionary;
   import ui.ChatPanel;
   
   public class Character implements IListenable
   {
      
      public static const HEALTH_PARAMS_COUNT:int = 5;
      
      public static const HEALTH_PARAMS_CRITICAL_VALUES:Array = [30,30,30,30,30];
      
      public static const HEALTH_PARAMS_MAX_VALUES:Array = [99,99,99,99,99];
      
      public static const CRITICAL_LUCK_VAL:Array = new Array(1,1,1,3,5,7,9,11,13,15);
      
      public static const SKILL_ADD_VALUE:Array = new Array(14,14,14,16,17,18,19,21,23,26);
      
      public static var MAX_WEIGHT_CONST:int = 40;
      
      public static const MAX_PERK_COUNT:int = 32;
      
      public static const SEX_MALE:int = 0;
      
      public static const SEX_FEMALE:int = 1;
      
      public static const RACE_A:int = 0;
      
      public static const RACE_B:int = 1;
      
      public static const STAT_STRENGTH:int = 0;
      
      public static const STAT_ENDURANCE:int = 1;
      
      public static const STAT_LUCK:int = 2;
      
      public static const STAT_PERCEPTION:int = 3;
      
      public static const STAT_DEFTNESS:int = 4;
      
      public static const STAT_INTELLECT:int = 5;
      
      public static const STAT_COUNT:int = 6;
      
      public static const SKILL_COLD_7:int = 7;
      
      public static const SKILL_COLD_ARMS:int = 0;
      
      public static const SKILL_SMALL_ARMS:int = 1;
      
      public static const SKILL_HEAVY_WEAPON:int = 2;
      
      public static const SKILL_POWER_WEAPON:int = 3;
      
      public static const SKILL_DOCTOR:int = 4;
      
      public static const SKILL_TRADE:int = 5;
      
      public static const SKILL_REPAIR:int = 6;
      
      public static const SKILL_SCIENCE:int = 7;
      
      public static const SKILL_COUNT:int = 9;
      
      public static const CUR_SKILL_COUNT:int = 8;
      
      public static const ABILITY_CRITICAL_HIT:int = 0;
      
      public static const ABILITY_EVADE_CHANCE:int = 1;
      
      public static const ABILITY_ARMOR_CLASS:int = 2;
      
      public static const ABILITY_WEAPON_HIT:int = 3;
      
      public static const ABILITY_ADD_RUN:int = 4;
      
      public static const ABILITY_ADD_HP_LOW:int = 5;
      
      public static const ABILITY_ADD_HP_HIGH:int = 6;
      
      public static const ABILITY_MAX_WEIGHT:int = 7;
      
      public static const ABILITY_ADD_RUN2:int = 8;
      
      public static const ABILITY_WEAPON_HIT2:int = 9;
      
      public static const ABILITY_CRITICAL_HIT2:int = 10;
      
      public static const ABILITY_EVADE_CHANCE2:int = 11;
      
      public static const ABILITY_EVADE_CHANCE3:int = 12;
      
      public static const ABILITY_EVADE_CHANCE4:int = 13;
      
      public static const ABILITY_WEAPON_HIT3:int = 14;
      
      public static const ABILITY_SPECIAL_COMMITTEE:int = 15;
      
      public static const ABILITY_SPECIAL_16:int = 16;
      
      public static const ABILITY_CLAN_RATING_17:int = 17;
      
      public static const ABILITY_CLAN_RATING_1:int = 18;
      
      public static const ABILITY_CLAN_RATING_2:int = 19;
      
      public static const ABILITY_CLAN_RATING_3:int = 20;
      
      public static const ABILITY_CLAN_RATING_21:int = 21;
      
      public static const START_STAT_22:int = 22;
      
      public static const START_STAT_VAL:int = 3;
      
      public static const START_SKILL_VAL:int = 1;
      
      public static const MAX_STAT_VAL:int = 10;
      
      public static const START_STAT_AVAIBLE:int = 21;
      
      public static const START_SKILLS_AVAIBLE:int = 9;
      
      public static const APPEARANCE_IDX:int = 0;
      
      public static const HAIR_IDX:int = 1;
      
      public static const HELMET_IDX:int = 2;
      
      public static const ARMOR_IDX:int = 3;
      
      public static const PANTS_IDX:int = 4;
      
      public static const BOOTS_IDX:int = 5;
      
      public static const IDX_COUNT:int = 6;
      
      public static const TRAUMA_BLEEDING:int = 0;
      
      public static const TRAUMA_LACERATION:int = 1;
      
      public static const TRAUMA_CONCUSSION:int = 2;
      
      public static const TRAUMA_DURMAN:int = 3;
      
      public static const TRAUMA_BROKENHAND:int = 4;
      
      public static const TRAUMA_BROKENLEG:int = 5;
      
      public static const TRAUMA_CONTUSION:int = 6;
      
      public static const TRAUMA_BRAININJURY:int = 7;
      
      public static const TRAUMA_BATTLE:int = 8;
      
      public static const TRAUMA_RESPONSE:int = 9;
      
      public static const PERK_10:int = 10;
      
      public static const PERK_DODGER:int = 0;
      
      public static const PERK_GUTTAPERCHA:int = 1;
      
      public static const PERK_STRONG_SPIN:int = 2;
      
      public static const PERK_REGENERATION:int = 3;
      
      public static const PERK_ENDURING:int = 4;
      
      public static const PERK_METABOLISM:int = 5;
      
      public static const PERK_CALLING_DOCTOR:int = 6;
      
      public static const PERK_CALLING_TRADER:int = 7;
      
      public static const PERK_CALLING_MASTER:int = 8;
      
      public static const PERK_ANATOMY:int = 9;
      
      public static const PERK_SHELL:int = 10;
      
      public static const PERK_FLASH_ENDURANCE:int = 11;
      
      public static const PERK_FLASH_DEFNESS:int = 12;
      
      public static const PERK_CINQUEFOIL:int = 13;
      
      public static const PERK_TRAINER:int = 14;
      
      public static const PERK_GRENADIER:int = 15;
      
      public static const PERK_SUBCUTANEOUS_ARMOR:int = 16;
      
      public static const PERK_TRAUMATOLOGIST:int = 17;
      
      public static const PERK_BULLETING_OF_DEATH:int = 18;
      
      public static const PERK_EXTRA_REFLEXES:int = 19;
      
      public static const PERK_WEIGHTLIFTER:int = 20;
      
      public static const PERK_SPECIAL_TRAINING:int = 21;
      
      public static const PERKS_COUNT:int = 22;
      
      public static const SEVERITY_LIGHT:int = 0;
      
      public static const SEVERITY_HARD:int = 1;
      
      public static const TRAUM_SEVERITY:Array = new Array(0,0,0,0,1,1,1,1,1,1,1);
      
      public static const TRAUM_FACTOR:Array = new Array(15,35,90,75,155,175,125,200,210,175,1);
      
      public static const TRAUM_COST:Array = new Array(4,5,8,7,5,6,8,12,20,10,89);
      
      private static const AVAIBLE_PERKS:Array = [[PERK_DODGER,PERK_GUTTAPERCHA,PERK_STRONG_SPIN,PERK_REGENERATION],[PERK_ENDURING,PERK_METABOLISM],[PERK_CALLING_DOCTOR,PERK_CALLING_TRADER,PERK_CALLING_MASTER],[PERK_ANATOMY,PERK_SHELL],[PERK_FLASH_ENDURANCE,PERK_FLASH_DEFNESS,PERK_CINQUEFOIL,PERK_SUBCUTANEOUS_ARMOR,PERK_TRAUMATOLOGIST,PERK_EXTRA_REFLEXES,PERK_WEIGHTLIFTER,PERK_SPECIAL_TRAINING],[PERK_TRAINER,PERK_GRENADIER,PERK_BULLETING_OF_DEATH]];
      
      private var healthParams:Array = new Array(HEALTH_PARAMS_COUNT);
      
      public var stats:Array = new Array(STAT_COUNT);
      
      public var skills:Array = new Array(SKILL_COUNT);
      
      public var pieceSkillSum:int = 0;
      
      public var battleSkillSum:int = 0;
      
      public var intellect:int;
      
      public var email:String = "";
      
      public var login:String;
      
      public var name:String;
      
      public var fullName:String = "";
      
      public var city:String = "";
      
      public var country:String = "";
      
      public var about:String = "";
      
      public var terminal:int;
      
      public var online:int;
      
      public var userId:int;
      
      public var level:int;
      
      public var race:int;
      
      public var sex:int;
      
      public var hp:int;
      
      public var hpAll:int;
      
      public var radiationResist:int;
      
      public var avatarImg:int;
      
      public var weaponImg:Array = new Array("","");
      
      public var weaponName:Array = new Array("","");
      
      public var isInfoFull:Boolean = false;
      
      public var experience:int;
      
      public var levelExp:int;
      
      public var nextLevelExp:int;
      
      public var prioritySkills:int;
      
      public var avaiblePerks:int;
      
      public var perks:int;
      
      public var seenPerks:int;
      
      public var armorClass:int = 0;
      
      public var armorBonus:int = 0;
      
      public var clanId:int = 0;
      
      public var clanName:String;
      
      public var clanUrl:String;
      
      public var hireClanId:int = 0;
      
      public var hireClanName:String;
      
      public var hireClanUrl:String;
      
      public var clanPosition:int = 0;
      
      private const services:Vector.<uint> = new Vector.<uint>(2,true);
      
      protected var _money:int = 0;
      
      protected var _pvpRating:Number = 0.0;
      
      protected var _rank:int = 0;
      
      protected var _nextRankPoints:Number = 0;
      
      protected var _friendList:Array = new Array();
      
      protected var _enemyList:Array = new Array();
      
      protected var _friendRequests:int = 0;
      
      public function Character()
      {
         var index:int;
         super();
         index = 0;
         while(index < SKILL_COUNT)
         {
            this.skills[index] = 10000;
            index++;
         }
         index = 0;
         while(index < IDX_COUNT)
         {
            this.images[index] = 0;
            index++;
         }
         index = 0;
         while(index < HEALTH_PARAMS_COUNT)
         {
            this.healthParams[index] = 0;
            index++;
         }
         index = 0;
         while(index < this.services.length)
         {
            this.services[index] = 0;
            index++;
         }
      }
      
      public static function hasPerkInPerks(param1:int, param2:int) : Boolean
      {
         return (param1 >> param2 & 1) == 1;
      }
      
      public static function getPerksCount(param1:int) : int
      {
         return param1 / 3 + 1;
      }
      
      public static function getPreksCountInPerks(param1:int) : int
      {
         var count:int = 0;
         while(param1 != 0)
         {
            if((param1 & 1) != 0)
            {
               count++;
            }
            param1 >>= 1;
         }
         return count;
      }
      
      public static function isPerkAvaible(param1:int, param2:int, param3:int, param4:Array) : Boolean
      {
         switch(param2)
         {
            case PERK_FLASH_ENDURANCE:
               if(param4[STAT_ENDURANCE] >= MAX_STAT_VAL)
               {
                  return false;
               }
               break;
            case PERK_FLASH_DEFNESS:
               if(param4[STAT_DEFTNESS] >= MAX_STAT_VAL)
               {
                  return false;
               }
               break;
            case PERK_CINQUEFOIL:
               if(param4[STAT_LUCK] >= MAX_STAT_VAL)
               {
                  return false;
               }
               break;
            case PERK_SUBCUTANEOUS_ARMOR:
               if(!hasPerkInPerks(param1,PERK_SHELL))
               {
                  return false;
               }
               break;
            case PERK_SPECIAL_TRAINING:
               if(!hasPerkInPerks(param1,PERK_ANATOMY))
               {
                  return false;
               }
               break;
            case PERK_EXTRA_REFLEXES:
               if(!hasPerkInPerks(param1,PERK_GUTTAPERCHA))
               {
                  return false;
               }
               break;
            case PERK_WEIGHTLIFTER:
               if(!hasPerkInPerks(param1,PERK_STRONG_SPIN))
               {
                  return false;
               }
               break;
         }
         var tierIndex:int = 0;
         while(tierIndex < AVAIBLE_PERKS.length && AVAIBLE_PERKS[tierIndex].indexOf(param2) < 0)
         {
            tierIndex++;
         }
         if(tierIndex > param3)
         {
            return false;
         }
         return true;
      }
      
      public static function checkPerk(param1:int, param2:Array) : Boolean
      {
         var selectedPerks:int = 0;
         var remainingMask:int;
         var selectedCount:int = 0;
         var availablePerk:int = 0;
         var perkIndex:int;
         while(selectedPerks != param1)
         {
            perkIndex = 0;
            remainingMask = param1;
            availablePerk = -1;
            while(remainingMask != 0)
            {
               if((remainingMask & 1) != 0 && (selectedPerks >> perkIndex & 1) == 0)
               {
                  if(isPerkAvaible(selectedPerks,perkIndex,selectedCount,param2))
                  {
                     availablePerk = perkIndex;
                  }
               }
               remainingMask >>= 1;
               perkIndex++;
            }
            if(availablePerk == -1)
            {
               return false;
            }
            selectedPerks |= 1 << availablePerk;
            selectedCount++;
         }
         return true;
      }
      
      public static function getAvaiblePerks(param1:int, param2:int, param3:Array) : int
      {
         var maxTier:int = Math.min(AVAIBLE_PERKS.length - 1,param1 / 3);
         var availableMask:int;
         var tierIndex:int;
         var perkIndex:int;
         if(getPerksCount(param1) > getPreksCountInPerks(param2))
         {
            availableMask = 0;
            tierIndex = 0;
            while(tierIndex <= maxTier)
            {
               perkIndex = 0;
               while(perkIndex < AVAIBLE_PERKS[tierIndex].length)
               {
                  if(isPerkAvaible(param2,AVAIBLE_PERKS[tierIndex][perkIndex],1000,param3))
                  {
                     availableMask |= 1 << AVAIBLE_PERKS[tierIndex][perkIndex];
                  }
                  perkIndex++;
               }
               tierIndex++;
            }
            return availableMask;
         }
         return 0;
      }
      
      public function get friendRequests() : int
      {
         return this._friendRequests;
      }
      
      public function get friendList() : Array
      {
         return this._friendList;
      }
      
      public function get enemyList() : Array
      {
         return this._enemyList;
      }
      
      public function check32(param1:String) : Boolean
      {
         var index:int = this._enemyList.length - 1;
         while(index >= 0)
         {
            if(this._enemyList[index].name == param1)
            {
               return true;
            }
            index--;
         }
         return false;
      }
      
      public var images:Array = new Array(IDX_COUNT);

      public var palettes:Array = new Array(IDX_COUNT);

      public var traumsLoaded:Boolean = false;

      private var _effects:Dictionary = new Dictionary();

      public var presentTypes:Array = null;

      public var presents:Array = null;

      public var traumTypes:Array = null;

      public var traumParams:Array = null;

      public var traumTimes:Array = null;

      public var clanAbilities:int = 0;

      public var userAbilities:int = 0;

      public var raidPartyId:int = -1;

      public function parseMoney(param1:Array) : void
      {
         if(this._money != param1[1])
         {
            _money = param1[1];
         }
      }
      
      public function get money() : int
      {
         return this._money;
      }
      
      public function get pvpRating() : Number
      {
         return this._pvpRating;
      }
      
      public function check12(param1:int) : Boolean
      {
         return (this.services[param1 >> 5] >> (param1 & 0x1F) & 1) == 1;
      }
      
      public function onServicesUpdate(param1:Object) : void
      {
         var index:int = 0;
         while(index < this.services.length)
         {
            this.services[index] = param1.data[index];
            index++;
         }
         this.dispatchChange("MaxWeight");
      }
      
      public function get propValue81() : Array
      {
         var perkIndices:Array = new Array();
         var index:int = 0;
         while(index < MAX_PERK_COUNT)
         {
            if((this.perks >> index & 1) == 1)
            {
               perkIndices.push(index);
            }
            index++;
         }
         return perkIndices;
      }
      
      public function get propValue16() : Array
      {
         var perkIndices:Array = new Array();
         var index:int = 0;
         while(index < MAX_PERK_COUNT)
         {
            if((this.avaiblePerks >> index & 1) == 1)
            {
               perkIndices.push(index);
            }
            index++;
         }
         return perkIndices;
      }
      
      public function check5(param1:int) : Boolean
      {
         return (this.prioritySkills >> param1 & 1) == 1;
      }
      
      public function onEmailUpdate(param1:Array) : void
      {
         var position:int = 1;
         email = param1[position++];
      }
      
      public function onStatusUpdate(param1:Array) : void
      {
         var position:int = 1;
         var remaining:int = param1[position++];
         var parameterId:int;
         var value:Number;
         while(remaining > 0)
         {
            parameterId = param1[position++];
            value = param1[position++];
            remaining--;
            switch(parameterId)
            {
               case CharParam.CHAR_PARAM_CONST5:
                  this.healthParams[CharParam.CHAR_PARAM_CONST5] = value;
                  this.dispatchChange("alcoholism");
                  break;
               case CharParam.CHAR_PARAM_CONST12:
                  this.healthParams[CharParam.CHAR_PARAM_CONST12] = value;
                  this.dispatchChange("chemicalPoisoning");
                  break;
               case CharParam.CHAR_PARAM_CONST4:
                  this.healthParams[CharParam.CHAR_PARAM_CONST4] = value;
                  this.dispatchChange("irradiation");
                  break;
               case CharParam.CHAR_PARAM_CONST1:
                  this.healthParams[CharParam.CHAR_PARAM_CONST1] = value;
                  this.dispatchChange("drugAddiction");
                  break;
               case CharParam.EffectCount:
                  this.healthParams[CharParam.EffectCount] = value;
                  this.dispatchChange("aspd");
                  break;
               case CharParam.CHAR_PARAM_CONST3:
                  radiationResist = value;
                  break;
               case CharParam.CurrentWeight:
                  CurrentWeight = value;
                  break;
               case CharParam.CHAR_PARAM_CONST8:
                  _pvpRating = value;
                  this.dispatchChange("pvpRating");
                  break;
               case CharParam.Rank:
                  _rank = int(value);
                  this.dispatchChange("Rank");
                  break;
               case CharParam.NextRankPoints:
                  _nextRankPoints = Number(value);
                  this.dispatchChange("NextRankPoints");
                  break;
               case CharParam.CHAR_PARAM_CONST11:
               case CharParam.CHAR_PARAM_CONST10:
               case CharParam.Irradiation:
               case CharParam.CHAR_PARAM_CONST9:
               case CharParam.CHAR_PARAM_CONST2:
               case CharParam.CHAR_PARAM_CONST6:
               case CharParam.CHAR_PARAM_CONST7:
                  this.skills[parameterId - CharParam.CHAR_PARAM_CONST11] = value;
                  break;
               case CharParam.CHAR_PARAM_CONST14:
                  this.skills[SKILL_TRADE] = value;
                  this.dispatchChange("MaxWeight");
                  break;
            }
         }
      }
      
      public function get propValue70() : int
      {
         return this.stats[STAT_STRENGTH];
      }
      
      public function get propValue60() : int
      {
         return this.stats[STAT_ENDURANCE];
      }
      
      public function get propValue152() : int
      {
         return this.stats[STAT_LUCK];
      }
      
      public function get propValue114() : int
      {
         return this.stats[STAT_PERCEPTION];
      }
      
      public function get propValue38() : int
      {
         return this.stats[STAT_DEFTNESS];
      }
      
      public function get propValue89() : int
      {
         return this.stats[STAT_INTELLECT];
      }
      
      public function get propValue37() : int
      {
         return Math.max(0,SKILL_ADD_VALUE[this.propValue89 - 1] * (this.level + 1) - this.battleSkillSum);
      }
      
      public function get propValue104() : int
      {
         return Math.max(0,SKILL_ADD_VALUE[this.propValue89 - 1] * (this.level + 1) - this.pieceSkillSum);
      }
      
      public function get propValue36() : int
      {
         if(this.propValue70 + this.propValue60 <= 10)
         {
            return 4;
         }
         if(this.propValue70 + this.propValue60 < 15)
         {
            return 5;
         }
         if(this.propValue70 + this.propValue60 < 17)
         {
            return 7;
         }
         return 8;
      }
      
      public function get hpAllValue() : int
      {
         return this.hpAll;
      }
      
      public function get propValue21() : int
      {
         return this.propValue70 < 7 ? 1 : 2;
      }
      
      public function get propValue146() : int
      {
         return this.propValue70 < 7 ? 4 : 6;
      }
      
      public function get propValue121() : int
      {
         var value:int = (this.propValue38 - 2) * 2;
         if(this.hasPerk(PERK_GUTTAPERCHA))
         {
            value += 6;
         }
         if(this.propValue114 + this.propValue38 >= 17)
         {
            value += 12;
         }
         else if(this.propValue114 + this.propValue38 >= 15)
         {
            value += 4;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE))
         {
            value += 3;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE2))
         {
            value += 12;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE3))
         {
            value += 10;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE4))
         {
            value += 10;
         }
         if(this.hasPerk(PERK_EXTRA_REFLEXES))
         {
            value += 6;
         }
         return value;
      }
      
      public function get propValue112() : int
      {
         var value:int = (this.propValue114 / 5 + this.propValue38 - 2) * 2;
         if(this.hasPerk(PERK_GUTTAPERCHA))
         {
            value += 6;
         }
         if(this.propValue114 + this.propValue38 >= 17)
         {
            value += 12;
         }
         else if(this.propValue114 + this.propValue38 >= 15)
         {
            value += 4;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE))
         {
            value += 3;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE2))
         {
            value += 12;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE3))
         {
            value += 10;
         }
         if(this.hasAbility(ABILITY_EVADE_CHANCE4))
         {
            value += 10;
         }
         if(this.hasPerk(PERK_EXTRA_REFLEXES))
         {
            value += 6;
         }
         return value;
      }
      
      public function get propValue43() : int
      {
         return SKILL_ADD_VALUE[this.propValue89 - 1];
      }
      
      public function get propValue193() : int
      {
         var criticalChance:int = CRITICAL_LUCK_VAL[this.propValue152 - 1];
         if(this.hasPerk(PERK_ANATOMY))
         {
            criticalChance += 5;
         }
         if(this.propValue152 + this.propValue89 >= 17)
         {
            criticalChance += 8;
         }
         else if(this.propValue152 + this.propValue89 >= 15)
         {
            criticalChance += 3;
         }
         if(this.hasAbility(ABILITY_CRITICAL_HIT))
         {
            criticalChance += 5;
         }
         if(this.hasAbility(ABILITY_CRITICAL_HIT2))
         {
            criticalChance += 8;
         }
         return criticalChance;
      }
      
      public function getNumber9(param1:int) : Number
      {
         switch(param1)
         {
            case CharParam.CHAR_PARAM_CONST5:
            case CharParam.CHAR_PARAM_CONST12:
            case CharParam.CHAR_PARAM_CONST1:
            case CharParam.CHAR_PARAM_CONST4:
            case CharParam.EffectCount:
               return this.healthParams[param1];
            case CharParam.hpAllValue:
               return this.hpAllValue;
            case CharParam.propValue36:
               return this.propValue36;
            case CharParam.CHAR_PARAM_CONST13:
               return this.MaxWeight;
            case CharParam.propValue21:
               return this.propValue21;
            case CharParam.propValue146:
               return this.propValue146;
            case CharParam.CHAR_PARAM_CONST3:
               return this.radiationResist;
            case CharParam.propValue121:
               return this.propValue121;
            case CharParam.propValue112:
               return this.propValue112;
            case CharParam.propValue43:
               return this.propValue43;
            case CharParam.propValue193:
               return this.propValue193;
            case CharParam.CHAR_PARAM_CONST8:
               return this.pvpRating;
            case CharParam.Rank:
               return this.Rank;
            default:
               Assert.isTrue(false);
         }
         return 0;
      }
      
      protected var _currentWeight:Number = 0;

      public function get CurrentWeight() : Number
      {
         return this._currentWeight;
      }
      
      public function set CurrentWeight(param1:Number) : void
      {
         if(param1 != this._currentWeight)
         {
            _currentWeight = param1;
            this.dispatchChange("CurrentWeight");
         }
      }
      
      private const intList2:Vector.<int> = new Vector.<int>();

      public function check26(param1:int) : Boolean
      {
         return this.intList2.indexOf(param1) != -1;
      }
      
      private var flag70:Boolean;

      public function get isValue8() : Boolean
      {
         return this.flag70;
      }
      
      public function doAction303(param1:Array) : void
      {
         var position:int = 1;
         var entriesRemaining:int;
         clanId = param1[position++];
         if(this.clanId == 0)
         {
            clanName = "";
            clanUrl = "";
            clanPosition = -1;
            flag70 = false;
            this.intList2.splice(0,this.intList2.length);
         }
         else
         {
            clanName = param1[position++];
            clanUrl = param1[position++];
            clanPosition = param1[position++];
            entriesRemaining = param1[position++];
            this.intList2.splice(0,this.intList2.length);
            while(entriesRemaining > 0)
            {
               this.intList2.push(param1[position++]);
               entriesRemaining--;
            }
            flag70 = param1[position++] == "1";
         }
      }
      
      public function get MaxWeight() : Number
      {
         var weightLimit:Number = (40 + this.propValue70 * 3 + this.propValue60 * 4) * 1000;
         if(this.level > 8)
         {
            weightLimit += 15000;
         }
         if(this.hasPerk(PERK_STRONG_SPIN))
         {
            weightLimit += 100000;
         }
         if(this.hasPerk(PERK_CALLING_TRADER))
         {
            weightLimit += 50000;
         }
         if(this.hasPerk(PERK_WEIGHTLIFTER))
         {
            weightLimit += 150000;
         }
         if(this.hasAbility(ABILITY_MAX_WEIGHT))
         {
            weightLimit += 100000;
         }
         if(this.check12(Service.BagSize2))
         {
            weightLimit += 300000;
         }
         else if(this.check12(Service.BagSize1))
         {
            weightLimit += 100000;
         }
         else if(this.check12(Service.GameBigBag))
         {
            weightLimit += 25000;
         }
         weightLimit += 0.05 * this.skills[SKILL_TRADE];
         return weightLimit;
      }
      
      public function getHealthParam(param1:int) : int
      {
         if(param1 < 0 || param1 >= HEALTH_PARAMS_COUNT)
         {
            throw new ArgumentError();
         }
         return this.healthParams[param1];
      }
      
      public function hasEffect(param1:int) : Boolean
      {
         return this.getEffect(param1) != null;
      }
      
      public function getEffect(param1:int) : Object
      {
         var effect:Object = null;
         for each(effect in this._effects)
         {
            if(effect.type == param1)
            {
               return effect;
            }
         }
         return null;
      }
      
      public function get Effects() : Dictionary
      {
         return this._effects;
      }
      
      public function _on_effect_removed(param1:Object) : void
      {
         delete this._effects[param1["uid"]];
      }
      
      public function _on_effect_updated(param1:Object) : void
      {
         var existingEffect:Object = this._effects[param1["uid"]];
         var property:*;
         if(existingEffect == null)
         {
            this._effects[param1["uid"]] = param1;
            UnitEventDispatcher.instance.dispatch(EventType.EffectAdded,param1);
         }
         else
         {
            for(property in param1)
            {
               existingEffect[property] = param1[property];
            }
         }
      }
      
      protected var intValue35:int = 0;

      public function set Permissions(param1:int) : void
      {
         intValue35 = param1;
      }
      
      public function hasAccess(param1:int) : Boolean
      {
         return (this.intValue35 >> param1 & 1) == 1;
      }
      
      public function parseInfo(param1:Array, param2:int = 1) : int
      {
         traumsLoaded = false;
         userId = param1[param2++];
         name = param1[param2++];
         level = param1[param2++];
         sex = param1[param2++];
         race = param1[param2++];
         hp = param1[param2++];
         hpAll = param1[param2++];
         clanId = param1[param2++];
         clanName = param1[param2++];
         clanUrl = param1[param2++];
         hireClanId = param1[param2++];
         hireClanName = param1[param2++];
         hireClanUrl = param1[param2++];
         clanPosition = param1[param2++];
         armorClass = param1[param2++];
         armorBonus = param1[param2++];
         seenPerks = param1[param2++];
         terminal = param1[param2++];
         online = param1[param2++];
         this.stats[0] = int(param1[param2++]);
         this.stats[1] = int(param1[param2++]);
         this.stats[2] = int(param1[param2++]);
         this.stats[3] = int(param1[param2++]);
         this.stats[4] = int(param1[param2++]);
         this.stats[5] = int(param1[param2++]);
         this.healthParams[0] = int(param1[param2++]);
         this.healthParams[1] = int(param1[param2++]);
         this.healthParams[2] = int(param1[param2++]);
         this.healthParams[3] = int(param1[param2++]);
         this.healthParams[4] = int(param1[param2++]);
         userAbilities = param1[param2++];
         clanAbilities = param1[param2++];
         avatarImg = param1[param2++];
         this.palettes[0] = int(param1[param2++]);
         this.palettes[1] = int(param1[param2++]);
         this.palettes[2] = int(param1[param2++]);
         this.palettes[3] = int(param1[param2++]);
         this.palettes[4] = int(param1[param2++]);
         this.palettes[5] = int(param1[param2++]);
         this.images[0] = int(param1[param2++]);
         this.images[1] = int(param1[param2++]);
         this.images[2] = int(param1[param2++]);
         this.images[3] = int(param1[param2++]);
         this.images[4] = int(param1[param2++]);
         this.images[5] = int(param1[param2++]);
         this.weaponImg[0] = int(param1[param2++]);
         this.weaponImg[1] = int(param1[param2++]);
         this.weaponName[0] = param1[param2++];
         this.weaponName[1] = param1[param2++];
         _rank = int(param1[param2++]);
         _nextRankPoints = Number(param1[param2++]);
         return param2;
      }
      
      public function hasAbility(param1:int) : Boolean
      {
         return ((this.userAbilities | this.clanAbilities) >> param1 & 1) == 1;
      }
      
      public function hasPerk(param1:int) : Boolean
      {
         return (this.perks >> param1 & 1) == 1;
      }
      
      public function hasSeenPerk(param1:int) : Boolean
      {
         return (this.seenPerks >> param1 & 1) == 1;
      }
      
      public function parseFullInfo(param1:Array, param2:int = 1) : int
      {
         param2 = this.parseInfo(param1,param2);
         experience = param1[param2];
         prioritySkills = param1[param2 + 1];
         avaiblePerks = param1[param2 + 2];
         perks = param1[param2 + 3];
         intellect = param1[param2 + 4];
         param2 += 5;
         isInfoFull = true;
         var skillIndex:int = 0;
         while(skillIndex < SKILL_COUNT)
         {
            this.skills[skillIndex] = int(param1[param2 + skillIndex]);
            skillIndex++;
         }
         param2 += SKILL_COUNT;
         battleSkillSum = param1[param2];
         pieceSkillSum = param1[param2 + 1];
         return param2 + 2;
      }
      
      public function parseExtendedInfo(param1:Array, param2:int = 1) : int
      {
         this.images[HELMET_IDX] = int(param1[param2]);
         this.images[ARMOR_IDX] = int(param1[param2 + 1]);
         this.images[PANTS_IDX] = int(param1[param2 + 2]);
         this.images[BOOTS_IDX] = int(param1[param2 + 3]);
         fullName = param1[param2 + 4];
         city = param1[param2 + 5];
         country = param1[param2 + 6];
         about = param1[param2 + 7];
         param2 += 8;
         var skillIndex:int = 0;
         while(skillIndex < SKILL_COUNT)
         {
            this.skills[skillIndex] = int(param1[param2 + skillIndex]);
            skillIndex++;
         }
         param2 += SKILL_COUNT;
         battleSkillSum = param1[param2];
         pieceSkillSum = param1[param2 + 1];
         return param2 + 2;
      }
      
      public function parseTraums(param1:Array, param2:int = 1) : int
      {
         fullName = param1[param2];
         country = param1[param2 + 1];
         city = param1[param2 + 2];
         about = param1[param2 + 3];
         var recordsRemaining:int = param1[param2 + 4];
         param2 += 5;
         presents = new Array();
         while(recordsRemaining > 0)
         {
            this.presents.push({
               "id":int(param1[param2]),
               "senderLogin":param1[param2 + 1],
               "type":int(param1[param2 + 2]),
               "img":int(param1[param2 + 3]),
               "sig":param1[param2 + 4]
            });
            param2 += 5;
            recordsRemaining--;
         }
         traumTypes = new Array();
         traumParams = new Array();
         traumTimes = new Array();
         recordsRemaining = param1[param2];
         param2++;
         while(recordsRemaining > 0)
         {
            this.traumTypes.push(int(param1[param2++]));
            this.traumParams.push(int(param1[param2++]));
            this.traumTimes.push(int(param1[param2++]));
            recordsRemaining--;
         }
         _pvpRating = Number(param1[param2++]);
         return param2;
      }
      
      public function get Rank() : int
      {
         return this._rank;
      }
      
      public function get NextRankPoints() : Number
      {
         return this._nextRankPoints;
      }
      
      public function get isValue65() : Boolean
      {
         return this.clanId != 0 && this.clanPosition == 1;
      }
      
      public function get isValue29() : Boolean
      {
         return this.isValue65 || this.clanId != 0 && this.clanPosition == 2;
      }
      
      public function get isValue6() : Boolean
      {
         return this.isValue29 || this.clanId != 0 && this.clanPosition == 3;
      }
      
      public function get isValue49() : Boolean
      {
         return this.isValue6 || this.clanId != 0 && this.clanPosition == 4;
      }
      
      public function parseFriendsInfo(param1:Array) : void
      {
         var position:int = 1;
         var recordsRemaining:int = param1[position++];
         var offlineIds:Array = [];
         var newlyOnlineNames:Array = [];
         var friend:Object;
         var channel:String;
         var friendName:String;
         for each(friend in this._friendList)
         {
            if(!friend.online)
            {
               offlineIds.push(friend.id);
            }
         }
         _friendList = [];
         _friendRequests = 0;
         while(recordsRemaining > 0)
         {
            friend = {
               "name":param1[position++],
               "level":param1[position++],
               "id":param1[position++],
               "online":param1[position++] == "1",
               "clan":{
                  "id":param1[position++],
                  "name":param1[position++]
               },
               "status":param1[position++]
            };
            this._friendList.push(friend);
            if(friend.online && offlineIds.indexOf(friend.id) != -1)
            {
               newlyOnlineNames.push(friend.name);
            }
            if(friend.status == 2)
            {
               ++this._friendRequests;
            }
            recordsRemaining--;
         }
         if(ChatPanel.instance != null && ChatPanel.instance.visible && Client.settings.showFriendGoesOnline && newlyOnlineNames.length > 0)
         {
            channel = ChatPanel.instance.getString51();
            for each(friendName in newlyOnlineNames)
            {
               ChatPanel.instance.doAction242(channel,Client._("IDS_FRIEND_COMES_ONLINE",friendName),7);
            }
         }
         recordsRemaining = param1[position++];
         _enemyList = [];
         while(recordsRemaining > 0)
         {
            this._enemyList.push({
               "name":param1[position++],
               "level":param1[position++],
               "id":param1[position++],
               "clan":{
                  "id":param1[position++],
                  "name":param1[position++]
               }
            });
            recordsRemaining--;
         }
      }
      
      public function addChangeListener(param1:Function) : void
      {
         if(param1 == null || this.listeners.indexOf(param1) != -1)
         {
            return;
         }
         this.listeners.push(param1);
      }
      
      public function removeChangeListener(param1:Function) : void
      {
         var index:int = this.listeners.indexOf(param1);
         if(index != -1)
         {
            this.listeners.splice(index,1);
         }
      }
      
      protected const listeners:Vector.<Function> = new Vector.<Function>();

      protected function dispatchChange(param1:String) : void
      {
         var change:Object = {"property":param1};
         var listener:Function;
         for each(listener in this.listeners)
         {
            listener(change);
         }
      }
   }
}

class Service
{
   
   public static const BagSize1:int = 0;
   
   public static const BagSize2:int = 1;
   
   public static const SmallRespawnTime1:int = 2;
   
   public static const SmallRespawnTime2:int = 3;
   
   public static const SmallRespawnTime3:int = 4;
   
   public static const FastHPRegeneration1:int = 5;
   
   public static const FastHPRegeneration2:int = 6;
   
   public static const SmallTraumTime1:int = 7;
   
   public static const SmallTraumTime2:int = 8;
   
   public static const LongRun1:int = 9;
   
   public static const LongRun2:int = 10;
   
   public static const LongRun3:int = 11;
   
   public static const ExpBonus1:int = 12;
   
   public static const ExpBonus2:int = 13;
   
   public static const ExpBonus3:int = 14;
   
   public static const ExpBonus4:int = 15;
   
   public static const Autoattack:int = 16;
   
   public static const SkillBonus1:int = 17;
   
   public static const SkillBonus2:int = 18;
   
   public static const SkillBonus3:int = 19;
   
   public static const TradeSkillBonus:int = 20;
   
   public static const CurrencyConvertBonus1:int = 21;
   
   public static const CurrencyConvertBonus2:int = 22;
   
   public static const CurrencyConvertBonus3:int = 23;
   
   public static const PlaceRespawn:int = 24;
   
   public static const DropAutocollection:int = 25;
   
   public static const ItemLottery:int = 26;
   
   public static const FreeZoneCrossing:int = 27;
   
   public static const LimitColdArms:int = 28;
   
   public static const LimitsmallArms:int = 29;
   
   public static const LimitHeavyWeapon:int = 30;
   
   public static const LimitPowerWeapon:int = 31;
   
   public static const LimitDoctor:int = 32;
   
   public static const LimitTrade:int = 33;
   
   public static const LimitRepair:int = 34;
   
   public static const LimitHarvester:int = 35;
   
   public static const LimitChemist:int = 36;
   
   public static const FriendPet1:int = 37;
   
   public static const FriendPet2:int = 38;
   
   public static const FriendKsenomorf:int = 39;
   
   public static const HireLicense:int = 40;
   
   public static const GameBigBag:int = 41;
   
   public static const ReferalExpBonus:int = 42;
   
   public static const FriendPet3:int = 43;
   
   public static const FriendPet4:int = 44;
   
   public static const FriendPet5:int = 45;
   
   public static const LongNopvpRun1:int = 46;
   
   public static const Invisible:int = 47;
   
   public static const FriendPet6:int = 48;
   
   public static const FriendPet7:int = 49;
   
   public static const FriendPet8:int = 50;
   
   public static const FriendPet9:int = 51;
   
   public function Service()
   {
      super();
   }
}
