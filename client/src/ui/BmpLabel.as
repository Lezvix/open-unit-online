package ui
{
   import core.display.BmpTextField;
   import flash.display.Bitmap;
   
   public class BmpLabel extends BmpTextField
   {
      
      public function BmpLabel(param1:int, param2:int, param3:Bitmap, param4:String, param5:int = 0)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function assign(param1:Object) : void
      {
         setText(param1.toString());
      }
      
      public function getText() : String
      {
         return text;
      }
   }
}

