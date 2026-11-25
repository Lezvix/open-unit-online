package game.npc
{
   public class Npc004 extends PlayerItem
   {
      
      public function Npc004()
      {
         super();
         headAnchor.y = -45;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc004"],[layerPal[PANTS_LAYER]]);
      }
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,-4);
      }
      
      override protected function hideShadow() : void
      {
         doAction275(bitmapData4,0,-2);
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_5;
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
      
      override protected function get deathSounds() : Array
      {
         return [47,49,50,51,53,55];
      }
   }
}

