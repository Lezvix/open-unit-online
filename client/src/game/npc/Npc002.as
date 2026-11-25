package game.npc
{
   public class Npc002 extends PlayerItem
   {
      
      public function Npc002()
      {
         super();
         headAnchor.y = -45;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc002"],[layerPal[PANTS_LAYER]]);
      }
      
      override protected function hideShadow() : void
      {
         sprite2.graphics.clear();
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_SPECTATOR;
      }
      
      private function get stateAnimation() : String
      {
         var animation:String = null;
         switch(state)
         {
            case stMove:
               animation = running ? "RUN" : "WALK";
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
         return [44,45,49,50];
      }
   }
}

