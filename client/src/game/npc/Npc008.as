package game.npc
{
   public class Npc008 extends TargetDummy
   {
      
      public function Npc008()
      {
         super();
         getInt38("npc008");
      }
      
      override public function update() : void
      {
         animationName = state == stDead ? "DEATH_0_DOWN_LEFT" : "STAND_DOWN_LEFT";
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_9;
      }
   }
}

