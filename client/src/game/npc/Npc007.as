package game.npc
{
   public class Npc007 extends TargetDummy
   {
      
      public function Npc007()
      {
         super();
         getInt38("npc007");
      }
      
      override public function update() : void
      {
         animationName = state == stDead ? "DEATH_0_DOWN_RIGHT" : "STAND_DOWN_RIGHT";
      }
      
      override public function get type() : int
      {
         return cAnimCount;
      }
   }
}

