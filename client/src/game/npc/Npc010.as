package game.npc
{
   public class Npc010 extends MonsterNpc
   {
      
      public function Npc010()
      {
         super();
         getInt38("npc010");
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
            default:
               animation = "STAND";
               break;
         }
         animationName = animation + "_" + propValue65;
      }
      
      override public function get type() : int
      {
         return GOLIATH_11;
      }
   }
}

