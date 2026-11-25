package game.npc
{
   public class WomanPlayer extends NuclearPlayer
   {
      
      public function WomanPlayer()
      {
         super();
      }
      
      override protected function bodyAnimation() : String
      {
         return "woman";
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_ATTACKER;
      }
   }
}

