package game.npc
{
   import game.BloodEffect;
   
   public class ActionNpc extends PlayerItem
   {
      
      public function ActionNpc()
      {
         super();
         headAnchor.y = -65;
      }
      
      override protected function get dieTypesCount() : int
      {
         return 2;
      }
      
      override public function get running() : Boolean
      {
         return false;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc001"],[layerPal[PANTS_LAYER]]);
      }
      
      override protected function hideShadow() : void
      {
         sprite2.graphics.clear();
      }
      
      private function get stateAnimation() : String
      {
         var animation:String = null;
         switch(state)
         {
            case stMove:
               animation = "WALK";
               break;
            case stUse:
               animation = "ACTION";
               break;
            case stHit:
               animation = "MELEE_KICK";
               break;
            case stDead:
               animation = "DEATH_" + intValue156;
               break;
            default:
               animation = "STAND";
               break;
         }
         return animation + "_" + propValue65;
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_DEFENDER;
      }
      
      override public function hit(param1:int, param2:int) : void
      {
         if(param2 == MESSAGE_FEAR)
         {
            doAction960(BloodEffect.BLOOD_EFFECT_CONST1);
         }
         super.hit(param1,param2);
      }
      
      override protected function get deathSounds() : Array
      {
         return intValue156 == 0 ? [46,1] : [16,51];
      }
   }
}

