package game.npc
{
   public class GoliathBase extends PlayerItem
   {
      
      public function GoliathBase()
      {
         super();
         headAnchor.y = -80;
      }
      
      override public function get running() : Boolean
      {
         return false;
      }
      
      override public function update() : void
      {
         var animation:String = null;
         switch(state)
         {
            case stMove:
               animation = "WALK";
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
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,2);
      }
      
      override protected function get deathSounds() : Array
      {
         return [56,57];
      }
   }
}

