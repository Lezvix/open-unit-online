package game.npc
{
   public class Npc009 extends MonsterNpc
   {
      
      public function Npc009()
      {
         super();
         getInt38("npc009");
      }
      
      override public function update() : void
      {
         var animation:String = null;
         switch(state)
         {
            case stMove:
               animation = running ? "RUN" : "WALK";
               break;
            case stHit:
               animation = "ATTACK";
               break;
            case stDead:
               animation = "DEATH";
               break;
            case stUse:
               animation = "RELOAD";
               break;
            default:
               animation = "STAND";
               break;
         }
         animationName = animation + "_" + propValue65;
      }
      
      override public function get type() : int
      {
         return ATTACK_SIDE_10;
      }
   }
}

