package core.ui
{
   public class TransparentComponent extends UIComponent
   {
      
      public function TransparentComponent()
      {
         super();
      }
      
      override protected function includesMouse() : Boolean
      {
         return false;
      }
   }
}

