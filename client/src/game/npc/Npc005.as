package game.npc
{
   import game.BloodEffect;
   
   public class Npc005 extends PlayerItem
   {
      
      public function Npc005()
      {
         super();
         headAnchor.y = -75;
      }
      
      override public function update() : void
      {
         animationName = this.stateAnimation;
         doAction285(["npc005"],[layerPal[PANTS_LAYER]]);
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
      
      override public function get type() : int
      {
         return cHitAnimCount;
      }
      
      override public function hit(param1:int, param2:int) : void
      {
         if(param2 == MESSAGE_FEAR)
         {
            doAction960(BloodEffect.BLOOD_EFFECT_CONST2);
         }
         super.hit(param1,param2);
      }
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,2);
      }
      
      override protected function hideShadow() : void
      {
         doAction275(bitmapData4,0,2);
      }
      
      override protected function get deathSounds() : Array
      {
         return [38,39];
      }
   }
}

