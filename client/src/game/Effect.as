package game
{
   import flash.display.Bitmap;
   import flash.utils.getDefinitionByName;
   import ui.NuclearMenu;
   
   public final class Effect
   {
      
      public static const EFFECT_CONST7:int = 38;
      
      public static const EffectFlashingSeconds:int = 60;
      
      public static const SILENCE:int = 0;
      
      public static const IRRADIATION:int = 1;
      
      public static const DRUG_ADDICTION:int = 2;
      
      public static const CHEMICAL_POISONING:int = 3;
      
      public static const LIGHT_TRAUMA:int = 4;
      
      public static const SEVERE_TRAUMA:int = 5;
      
      public static const ALCOHOLISM:int = 6;
      
      public static const ADD_HP_CONTINUOUSLY:int = 7;
      
      public static const ADD_STATS:int = 8;
      
      public static const SUB_STATS:int = 9;
      
      public static const ADD_HP_ON_HIT:int = 10;
      
      public static const SUB_HP_CONTINUOUSLY:int = 11;
      
      public static const LOW_EXP:int = 12;
      
      public static const INC_RADIATION_RESIST_TIME:int = 13;
      
      public static const BURNING:int = 14;
      
      public static const RESIST_FIRE:int = 15;
      
      public static const POISONING:int = 16;
      
      public static const RESIST_POISON:int = 17;
      
      public static const SHOCK:int = 18;
      
      public static const RESIST_SHOCK:int = 19;
      
      public static const ARMOR_DISRUPTION:int = 20;
      
      public static const RESIST_ARMOR_DISRUPTION:int = 21;
      
      public static const TELEPORTATION:int = 22;
      
      public static const CANCEL:int = 23;
      
      public static const EffectCount:int = 24;
      
      public static const EFFECT_CONST3:int = 25;
      
      public static const EFFECT_CONST10:int = 26;
      
      public static const EFFECT_CONST8:int = 27;
      
      public static const EFFECT_CONST6:int = 28;
      
      public static const EFFECT_CONST12:int = 29;
      
      public static const EFFECT_CONST1:int = 30;
      
      public static const EFFECT_CONST14:int = 31;
      
      public static const EFFECT_CONST9:int = 32;
      
      public static const EFFECT_CONST2:int = 33;
      
      public static const EFFECT_CONST13:int = 34;
      
      public static const EFFECT_CONST5:int = 35;
      
      public static const EFFECT_CONST11:int = 36;
      
      public static const EFFECT_CONST4:int = 37;
      
      public function Effect()
      {
         super();
      }
      
      public static function getBitmap4(param1:int) : Bitmap
      {
         return new NuclearMenu.uiContainer["BUFF_" + param1]();
      }
      
      public static function GetName(param1:Object) : String
      {
         switch(param1.type)
         {
            case Effect.LIGHT_TRAUMA:
            case Effect.SEVERE_TRAUMA:
               return _("IDS_TRAUMA_" + param1.param);
            default:
               return _("IDS_BUFF_" + param1.type);
         }
      }
      
      public static function getString3(param1:int, param2:int) : String
      {
         switch(param1)
         {
            case Effect.IRRADIATION:
            case Effect.DRUG_ADDICTION:
            case Effect.CHEMICAL_POISONING:
            case Effect.ALCOHOLISM:
            case Effect.SUB_STATS:
               return getString4(param2);
            case Effect.ADD_STATS:
               return getString4(param2,"+");
            case Effect.ADD_HP_ON_HIT:
               return onText(param1,param2 & 0xFF,param2 >> 8 & 0xFF);
            case Effect.ADD_HP_CONTINUOUSLY:
               return onText(param1,_get_interval(param2),_get_frequency(param2));
            case Effect.SUB_HP_CONTINUOUSLY:
            case Effect.POISONING:
               return onText(param1,_get_interval(param2,"%"),_get_frequency(param2));
            case Effect.LIGHT_TRAUMA:
            case Effect.SEVERE_TRAUMA:
               return _("IDS_TRAUM_HINT_" + param2);
            case Effect.EffectCount:
               return onText(param1,param2 >> 24 & 0xFF);
            case Effect.EFFECT_CONST3:
               return onText(param1,param2 >> 3 & 0x01FF,_("IDS_SKILL_" + (param2 & 7)));
            case Effect.ARMOR_DISRUPTION:
            case Effect.EFFECT_CONST11:
            case Effect.EFFECT_CONST4:
            case Effect.EFFECT_CONST10:
            case Effect.EFFECT_CONST12:
            case Effect.EFFECT_CONST8:
               return onText(param1,param2);
            case Effect.EFFECT_CONST9:
               return onText(param1,param2,25 / (Main.UserCharacter.level + 2),param2 / 100);
            case Effect.LOW_EXP:
               return onText(param1,param2,param2 % 10);
            case Effect.EFFECT_CONST14:
            case Effect.EFFECT_CONST2:
            case Effect.EFFECT_CONST13:
               return onText(param1);
            default:
               return "";
         }
      }
      
      public static function getString31(param1:Object) : String
      {
         var effectType:int = param1.type;
         if(effectType == Effect.LIGHT_TRAUMA || effectType == Effect.SEVERE_TRAUMA)
         {
            return GetName(param1);
         }
         var effectParam:int = param1.param;
         var probability:int = param1.probability;
         var duration:int = param1.duration;
         var details:String = "";
         if(effectType == Effect.CANCEL)
         {
            details = _("IDS_BUFF_" + effectParam);
            return probability >= 100 ? _("IDS_EFFECT_CANCEL_CHANCE_100",details) : _("IDS_EFFECT_CANCEL_CHANCE",probability,details);
         }
         else
         {
            switch(effectType)
            {
               case Effect.SUB_STATS:
                  details = "(" + getString4(effectParam) + ")";
                  break;
               case Effect.ADD_STATS:
                  details = "(" + getString4(effectParam,"+") + ")";
                  break;
               case Effect.ADD_HP_ON_HIT:
                  details = getString5(effectType,effectParam & 0xFF,effectParam >> 8 & 0xFF,effectParam >> 16);
                  break;
               case Effect.ADD_HP_CONTINUOUSLY:
               case Effect.BURNING:
                  details = getString5(effectType,_get_interval(effectParam),_get_frequency(effectParam));
                  break;
               case Effect.SUB_HP_CONTINUOUSLY:
               case Effect.POISONING:
                  details = getString5(effectType,_get_interval(effectParam,"%"),_get_frequency(effectParam));
                  break;
               case Effect.ARMOR_DISRUPTION:
               case Effect.EFFECT_CONST11:
               case Effect.EFFECT_CONST4:
               case Effect.EFFECT_CONST10:
               case Effect.EFFECT_CONST8:
               case Effect.EFFECT_CONST12:
                  details = getString5(effectType,[effectParam]);
                  break;
               case Effect.EFFECT_CONST9:
                  details = getString5(effectType,effectParam,25 / (Main.UserCharacter.level + 2),effectParam / 100);
                  break;
               case Effect.LOW_EXP:
                  details = getString5(effectType,effectParam,effectParam % 10);
                  break;
               case Effect.TELEPORTATION:
                  details = getString5(effectType,effectParam & 0x3FFF,effectParam >> 14 & 0x3FFF);
                  break;
               case Effect.EFFECT_CONST3:
                  details = getString5(effectType,_("IDS_SKILL_" + (effectParam & 7)),effectParam >> 3 & 0x01FF);
                  break;
            }
            return (probability >= 100 ? _("IDS_EFFECT_LAND_CHANCE_100",_("IDS_BUFF_" + effectType),details) : _("IDS_EFFECT_LAND_CHANCE",probability,_("IDS_BUFF_" + effectType),details)) + (duration > 0 ? " " + _("IDS_ON") + " " + (duration >= 60 ? Chat.round(duration / 60,2) + " " + _("IDS_MINUTES") : duration + " " + _("IDS_SECONDS")) : "");
         }
      }
      
      private static function _get_frequency(param1:int) : String
      {
         var seconds:Number = (param1 >> 16) / 10;
         return seconds >= 60 ? Chat.round(seconds / 60,2) + " " + _("IDS_MINUTES") : seconds + " " + _("IDS_SECONDS");
      }
      
      private static function _get_interval(param1:int, param2:String = "") : String
      {
         var minimum:int = param1 & 0xFF;
         var maximum:int = param1 >> 8 & 0xFF;
         return String(minimum) + param2 + ((maximum > minimum) ? "-" + maximum + param2 : "");
      }
      
      private static function getString4(param1:int, param2:String = "-") : String
      {
         var stats:Array = new Array();
         var index:int = 0;
         while(index < 6)
         {
            if(param1 & 15 << 4 * index)
            {
               stats.push(_("IDS_STAT_" + index) + " " + param2 + (param1 >> 4 * index & 0x0F));
            }
            index++;
         }
         return stats.join(", ");
      }
      
      private static function _(param1:String, ... rest) : String
      {
         return Chat.prepareText(Client._.apply(null,[param1].concat(rest)));
      }
      
      private static function onText(param1:int, ... rest) : String
      {
         return _.apply(null,["IDS_EFFECT_HINT_" + param1].concat(rest));
      }
      
      private static function getString5(param1:int, ... rest) : String
      {
         return _.apply(null,["IDS_ITEM_EFFECT_" + param1].concat(rest));
      }
   }
}

