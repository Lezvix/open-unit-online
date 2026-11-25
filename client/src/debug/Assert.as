package debug
{
   public class Assert
   {
      
      public function Assert()
      {
         super();
      }
      
      public static function isTrue(param1:Boolean) : void
      {
         if(!param1)
         {
            throw new Error("ASSERT");
         }
      }
   }
}

