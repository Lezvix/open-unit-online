package core.ui.views
{
   public class Size
   {
      
      public var width:int;
      
      public var height:int;
      
      public function Size(param1:int = -1, param2:int = -1)
      {
         super();
         this.width = param1;
         this.height = param2;
      }
      
      public function clone() : Size
      {
         return new Size(this.width,this.height);
      }
   }
}

