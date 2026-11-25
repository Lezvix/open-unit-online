package core.ui.views
{
   import core.ui.UIComponent;
   
   public class GridView extends ContainerView
   {
      
      private var _gridRows:int = 1;
      
      private var _gridColumns:int = 1;
      
      public function GridView()
      {
         super();
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         _gridRows = Math.max(1,param1.rows);
         _gridColumns = Math.max(1,param1.columns);
      }
      
      override public function add(param1:UIComponent) : Boolean
      {
         return this.isValue14 ? false : super.add(param1);
      }
      
      override protected function sortItems(param1:int = 0) : void
      {
         var cellWidth:int = width / this._gridColumns;
         var cellHeight:int = height / this._gridRows;
         var index:int = param1;
         while(index < uiComponentList1.length)
         {
            uiComponentList1[index].x = int(index % this._gridColumns * cellWidth + (cellWidth - uiComponentList1[index].width) / 2);
            uiComponentList1[index].y = int(int(index / this._gridColumns) * cellHeight + (cellHeight - uiComponentList1[index].height) / 2);
            index++;
         }
      }
      
      public function get isValue14() : Boolean
      {
         return uiComponentList1.length >= this._gridRows * this._gridColumns;
      }
      
      public function get rows() : int
      {
         return this._gridRows;
      }
      
      public function get columns() : int
      {
         return this._gridColumns;
      }
      
      public function set rows(param1:int) : void
      {
         if(param1 > 0 && param1 != this._gridRows)
         {
            _gridRows = param1;
            this.sortItems();
         }
      }
      
      public function set columns(param1:int) : void
      {
         if(param1 > 0 && param1 != this._gridColumns)
         {
            _gridColumns = param1;
            this.sortItems();
         }
      }
   }
}

