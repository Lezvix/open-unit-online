package game.npc
{
   public class Goliath8 extends GoliathBase
   {
      
      public function Goliath8()
      {
         super();
         getInt38("npc012");
      }
      
      override public function get type() : int
      {
         return GOLIATH_8;
      }
   }
}

