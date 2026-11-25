package game.npc
{
   import game.BloodEffect;
   
   public class MonsterNpc extends PlayerItem
   {
      
      public function MonsterNpc()
      {
         super();
         headAnchor.y = -80;
      }
      
      override public function hit(param1:int, param2:int) : void
      {
         if(param2 == MESSAGE_FEAR)
         {
            doAction960(BloodEffect.BLOOD_EFFECT_CONST1);
         }
         super.hit(param1,param2);
      }
      
      override protected function addShadow() : void
      {
         doAction275(bitmapData6,0,2);
      }
      
      override protected function get deathSounds() : Array
      {
         return [58,59,60];
      }
   }
}

