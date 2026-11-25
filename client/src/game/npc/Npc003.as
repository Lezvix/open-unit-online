package game.npc
{
   public class Npc003 extends PlayerItem
   {
      
      public function Npc003()
      {
         super();
         headAnchor.y = -45;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc003"],[layerPal[PANTS_LAYER]]);
      }
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,2);
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_4;
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
         return [41,42,43,47,48,54,52];
      }
   }
}

