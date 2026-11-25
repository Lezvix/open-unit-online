package ui
{
   import ui.buttons.FilterButton;
   import game.InventoryItem;
   
   public class InventoryFilterPanel extends NUIComponent
   {
      
      public static const HORIZONTAL:int = 0;
      
      public static const VERTICAL:int = 1;
      
      protected var grid:ItemsGrid;
      
      protected var filterButtons:Vector.<FilterButton> = new Vector.<FilterButton>(InventoryItem.TRAUM_8);
      
      public function InventoryFilterPanel(itemsGrid:ItemsGrid, orientation:int = 1)
      {
         super();
         this.grid = itemsGrid;
         var i:int = 0;
         var button:FilterButton;
         while(i < InventoryItem.TRAUM_8)
         {
            button = new FilterButton(i,this.onFilterClick);
            button.hintText = _("IDS_INV_FILTER_" + i);
            if(orientation == VERTICAL)
            {
               button.y = button.height * i;
            }
            else
            {
               button.x = 45 * i;
            }
            this.filterButtons[i] = button;
            addUIChild(button);
            i++;
         }
         this.setFilter(itemsGrid.filter);
      }
      
      protected function setFilter(filterIndex:int) : void
      {
         this.filterButtons[filterIndex].toggleOn();
         this.grid.filter = filterIndex;
      }
      
      protected function onFilterClick(button:FilterButton) : void
      {
         this.filterButtons[this.grid.filter].toggleOff();
         var filterIndex:int = int(button.value);
         this.setFilter(this.grid.filter == filterIndex ? InventoryItem.FILTER_ALL : filterIndex);
      }
   }
}

