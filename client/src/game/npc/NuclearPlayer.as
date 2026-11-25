package game.npc
{
   import game.BloodEffect;
   
   public class NuclearPlayer extends PlayerItem
   {
      
      private static const array109:Array = ["","ak47","heavy_gun","pistol","bita","knife_01","laser_gun","shotgun","heavy_gun"];
      
      private static const array46:Array = [-1,dirLeft,dirLeftDown,dirRightDown,dirDown,dirRight,dirRightUp];
      
      private static const ANIMATION_FEMALE:int = 1;
      
      private static const ANIMATION_BOMZ:int = 2;
      
      private static const ANIMATION_DOG:int = 3;
      
      private static const ANIMATION_BUG:int = 4;
      
      private static const ANIMATION_LIZARD:int = 5;
      
      private static const ANIMATION_ALIEN:int = 6;
      
      private static const ANIMATION_ROBOT:int = 7;
      
      private static const ANIMATION_TARGET_A:int = 8;
      
      private static const array85:Array = [6,6,5,4,6,6,6,6,5];
      
      public function NuclearPlayer()
      {
         super();
         headAnchor.y = -65;
      }
      
      override protected function get dieTypesCount() : int
      {
         return 4;
      }
      
      protected function bodyAnimation() : String
      {
         throw new Error();
      }
      
      private function get stateAnimation() : String
      {
         var stateName:String = null;
         switch(state)
         {
            case stMove:
               if(running)
               {
                  stateName = "RUN";
               }
               else
               {
                  stateName = "WALK";
                  switch(layerView[BODY_LAYER])
                  {
                     case ANIMATION_FEMALE:
                     case ANIMATION_BOMZ:
                     case ANIMATION_ALIEN:
                     case ANIMATION_ROBOT:
                     case ANIMATION_TARGET_A:
                        stateName += "_RIFLE";
                        break;
                  }
               }
               break;
            case stUse:
               stateName = "ACTION";
               break;
            case stHit:
               switch(layerView[BODY_LAYER])
               {
                  case ANIMATION_FEMALE:
                  case ANIMATION_ALIEN:
                  case ANIMATION_ROBOT:
                     stateName = "RIFLE_SHOT";
                     break;
                  case ANIMATION_BOMZ:
                  case ANIMATION_TARGET_A:
                     stateName = "GUN_SHOT";
                     break;
                  case ANIMATION_DOG:
                     stateName = "PISTOL_SHOT";
                     break;
                  default:
                     stateName = "MELEE_KICK";
                     break;
               }
               break;
            case stDead:
               stateName = "DEATH_" + intValue156;
               break;
            default:
               stateName = "STAND";
               switch(layerView[BODY_LAYER])
               {
                  case ANIMATION_FEMALE:
                  case ANIMATION_BOMZ:
                  case ANIMATION_ALIEN:
                  case ANIMATION_ROBOT:
                  case ANIMATION_TARGET_A:
                     stateName += "_RIFLE";
                     break;
               }
               break;
         }
         return stateName + "_" + propValue65;
      }
      
      override public function hit(param1:int, param2:int) : void
      {
         if(param2 == MESSAGE_FEAR)
         {
            doAction960(BloodEffect.BLOOD_EFFECT_CONST1);
         }
         super.hit(param1,param2);
      }
      
      override protected function hideShadow() : void
      {
         sprite2.graphics.clear();
      }
      
      override public function animate() : void
      {
         if(state == stHit && anim > 1 && frame == array85[layerView[BODY_LAYER]])
         {
            frame -= 2;
            anim = anim - 1;
         }
         super.animate();
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         var animationLayers:Array = [this.bodyAnimation()];
         var layerPalettes:Array = [layerPal[PANTS_LAYER]];
         var genderPrefix:String = this is ManPlayer ? "" : "f_";
         if(layerView[WEAPON_3] > 0)
         {
            animationLayers.push(genderPrefix + "boots00" + layerView[WEAPON_3]);
            layerPalettes.push(layerPal[WEAPON_3]);
         }
         if(layerView[WEAPON_LAYER] > 0)
         {
            animationLayers.push(genderPrefix + "pants00" + layerView[WEAPON_LAYER]);
            layerPalettes.push(layerPal[WEAPON_LAYER]);
         }
         var armorBeforeWeapon:Boolean = array46.indexOf(dir) != -1;
         if(armorBeforeWeapon)
         {
            if(layerView[BODY_5] > 0)
            {
               animationLayers.push(genderPrefix + "armor00" + layerView[BODY_5]);
               layerPalettes.push(layerPal[BODY_5]);
            }
            if(layerView[WEAPON_4] > 0)
            {
               animationLayers.push(genderPrefix + "helm00" + layerView[WEAPON_4]);
               layerPalettes.push(layerPal[WEAPON_4]);
            }
            else if(layerView[HAIR_LAYER] > 0)
            {
               animationLayers.push(genderPrefix + "hair_0" + layerView[HAIR_LAYER]);
               layerPalettes.push(layerPal[HAIR_LAYER]);
            }
         }
         if(layerView[BODY_LAYER] > 0 && (state == stStand || state == stMove && !running || state == stHit))
         {
            animationLayers.push(genderPrefix + array109[layerView[BODY_LAYER]]);
            layerPalettes.push(layerPal[BODY_LAYER]);
            switch(layerView[BODY_LAYER])
            {
               case ANIMATION_ALIEN:
               case ANIMATION_FEMALE:
               case ANIMATION_ROBOT:
               case ANIMATION_BOMZ:
               case ANIMATION_DOG:
                  animationLayers.push("fire");
                  layerPalettes.push(0);
                  break;
            }
         }
         if(!armorBeforeWeapon)
         {
            if(layerView[BODY_5] > 0)
            {
               animationLayers.push(genderPrefix + "armor00" + layerView[BODY_5]);
               layerPalettes.push(layerPal[BODY_5]);
            }
            if(layerView[WEAPON_4] > 0)
            {
               animationLayers.push(genderPrefix + "helm00" + layerView[WEAPON_4]);
               layerPalettes.push(layerPal[WEAPON_4]);
            }
            else if(layerView[HAIR_LAYER] > 0)
            {
               animationLayers.push(genderPrefix + "hair_0" + layerView[HAIR_LAYER]);
               layerPalettes.push(layerPal[HAIR_LAYER]);
            }
         }
         animationLayers.push("blood");
         layerPalettes.push(0);
         doAction285(animationLayers,layerPalettes);
      }
      
      override protected function get deathSounds() : Array
      {
         return intValue156 < 2 ? [55,1] : [16,17,53];
      }
   }
}

