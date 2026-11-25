package game.npc
{
   public class Goliath6 extends GoliathBase
   {
      
      public function Goliath6()
      {
         super();
         getInt38("npc011");
      }
      
      override public function get type() : int
      {
         return GOLIATH_6;
      }
   }
}

