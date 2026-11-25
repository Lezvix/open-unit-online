package game.npc
{
   public class ManPlayer extends NuclearPlayer
   {
      
      public function ManPlayer()
      {
         super();
      }
      
      override protected function bodyAnimation() : String
      {
         return "man";
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_NONE;
      }
   }
}

