package game
{
   public class NuclearObject extends ObjectItem
   {
      
      private var nuclearWorld:NuclearWorld;
      
      public function NuclearObject(param1:NuclearWorld)
      {
         super(param1);
         this.nuclearWorld = param1;
      }
   }
}

