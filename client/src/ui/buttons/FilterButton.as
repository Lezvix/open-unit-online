package ui.buttons
{
   public class FilterButton extends ToggleButton
   {
      
      public function FilterButton(param1:int, param2:Function)
      {
         super(param2,getBmp("FILTER_" + param1),getBmp("FILTER_" + param1 + "_OVER"),getBmp("FILTER_" + param1 + "_PRESSED"));
         value = param1;
      }
   }
}

