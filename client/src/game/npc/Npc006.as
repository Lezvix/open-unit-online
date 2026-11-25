package game.npc
{
   public class Npc006 extends PlayerItem
   {
      
      public function Npc006()
      {
         super();
         headAnchor.y = -45;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc006"],[layerPal[PANTS_LAYER]]);
      }
      
      private function get stateAnimation() : String
      {
         var animation:String = null;
         switch(state)
         {
            case stMove:
               animation = "WALK";
               break;
            case stHit:
               animation = "MELEE_KICK";
               break;
            case stDead:
               animation = "DEATH_0";
               break;
            default:
               animation = "STAND";
               break;
         }
         return animation + "_" + propValue65;
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_7;
      }
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,2);
      }
      
      override protected function animationCompleted() : void
      {
         if(state == stHit && anim > 1)
         {
            frame = 1;
            anim = anim - 1;
         }
         else
         {
            super.animationCompleted();
         }
      }
      
      override protected function get deathSounds() : Array
      {
         return [57];
      }
   }
}

