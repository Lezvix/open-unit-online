package game
{
   public class BloodEffect extends AnimatedSprite
   {
      
      public static const BLOOD_EFFECT_CONST1:int = 1;
      
      public static const BLOOD_EFFECT_CONST2:int = 2;
      
      public function BloodEffect(param1:int = 1)
      {
         super();
         getInt38("blood",param1);
         animationName = "CRITICAL_HIT";
      }
      
      override protected function animationCompleted() : void
      {
         stop();
      }
   }
}

