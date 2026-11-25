package core.ui.views
{
   import flash.utils.getTimer;
   
   public class TileListView extends ListView
   {
      
      private var _gridRows:int = 1;
      
      private var _gridColumns:int = 1;
      
      private var _tilePageIndex:int = 0;
      
      public function TileListView()
      {
         super();
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         _gridRows = Math.max(1,param1.rows);
         _gridColumns = Math.max(1,param1.columns);
      }
      
      override protected function sortItemsHorizontally(param1:int = 0) : void
      {
         param1 = 0;
         var row:int = 0;
         var column:int = 0;
         var page:int = 0;
         var cellWidth:int = width / this._gridColumns;
         var cellHeight:int = height / this._gridRows;
         var index:int = param1;
         while(index < uiComponentList1.length)
         {
            uiComponentList1[index].x = int((column + page * this._gridColumns) * cellWidth + spacing * page + (cellWidth - uiComponentList1[index].width) / 2);
            uiComponentList1[index].y = int(row * cellHeight + (cellHeight - uiComponentList1[index].height) / 2);
            column += 1;
            if(column == this._gridColumns)
            {
               column = 0;
               row += 1;
               if(row == this._gridRows)
               {
                  row = 0;
                  page += 1;
               }
            }
            index++;
         }
      }
      
      override protected function sortItemsVertically(param1:int = 0) : void
      {
         param1 = 0;
         var row:int = 0;
         var column:int = 0;
         var page:int = 0;
         var cellWidth:int = width / this._gridColumns;
         var cellHeight:int = height / this._gridRows;
         var index:int = param1;
         while(index < uiComponentList1.length)
         {
            uiComponentList1[index].x = int(column * cellWidth + (cellWidth - uiComponentList1[index].width) / 2);
            uiComponentList1[index].y = int((row + page * this._gridRows) * cellHeight + spacing * page + (cellHeight - uiComponentList1[index].height) / 2);
            column += 1;
            if(column == this._gridColumns)
            {
               column = 0;
               row += 1;
               if(row == this._gridRows)
               {
                  row = 0;
                  page += 1;
               }
            }
            index++;
         }
      }
      
      override public function set horizontalScrollingEnabled(param1:Boolean) : void
      {
         if(_horizontalScrollingEnabled != param1)
         {
            this.doAction302(0);
            super.horizontalScrollingEnabled = param1;
         }
      }
      
      override public function set verticalScrollingEnabled(param1:Boolean) : void
      {
         if(_verticalScrollingEnabled != param1)
         {
            this.doAction302(0);
            super.verticalScrollingEnabled = param1;
         }
      }
      
      protected function get propValue30() : int
      {
         return _horizontalScrollingEnabled ? contentView.x : contentView.y;
      }
      
      protected function set propValue30(param1:int) : void
      {
         if(_horizontalScrollingEnabled)
         {
            contentView.x = param1;
            contentView.y = 0;
         }
         else
         {
            contentView.y = param1;
            contentView.x = 0;
         }
      }
      
      override public function clear() : void
      {
         super.clear();
         _tilePageIndex = 0;
      }
      
      protected function get size() : int
      {
         return _horizontalScrollingEnabled ? width : height;
      }
      
      protected function getInt11(param1:int) : int
      {
         return -param1 * (this.size + spacing);
      }
      
      public function get propValue46() : int
      {
         return Math.max(1,1 + int((uiComponentList1.length - 1) / (this._gridRows * this._gridColumns)));
      }
      
      public function get propValue181() : int
      {
         return this._tilePageIndex;
      }
      
      public function doAction302(param1:int) : void
      {
         _tilePageIndex = Math.max(0,Math.min(param1,this.propValue46 - 1));
         propValue30 = this.getInt11(this._tilePageIndex);
      }
      
      public function doAction251(param1:int) : void
      {
         _tilePageIndex = Math.max(0,Math.min(param1,this.propValue46 - 1));
         if(_horizontalScrollingEnabled)
         {
            doAction279(this.getInt11(this._tilePageIndex),contentView.y,1000);
         }
         else
         {
            doAction279(contentView.x,this.getInt11(this._tilePageIndex),1000);
         }
      }
      
      override protected function onDragEnd() : void
      {
         var pageOffset:int = 0;
         scrollDragging = false;
         scrollStartSpeed = (_horizontalScrollingEnabled ? mouseX - point4.x : mouseY - point4.y) / (getTimer() - intValue220);
         if(Math.abs(scrollStartSpeed) < 0.5)
         {
            pageOffset = this.getInt11(this._tilePageIndex) - this.propValue30;
            if(pageOffset > 0)
            {
               this.doAction251(pageOffset > this.size / 3 ? this._tilePageIndex + 1 : this._tilePageIndex);
            }
            else
            {
               this.doAction251(Math.abs(pageOffset) > this.size / 3 ? this._tilePageIndex - 1 : this._tilePageIndex);
            }
         }
         else
         {
            this.doAction251(scrollStartSpeed > 0 ? this._tilePageIndex - 1 : this._tilePageIndex + 1);
         }
      }
      
      public function doAction597() : void
      {
         this.doAction251(this._tilePageIndex + 1);
      }
      
      public function doAction914() : void
      {
         this.doAction251(this._tilePageIndex - 1);
      }
      
      override protected function onDragBegin() : void
      {
         if(this.propValue46 > 1)
         {
            super.onDragBegin();
         }
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
            sortItems();
            this.doAction302(0);
         }
      }
      
      public function set columns(param1:int) : void
      {
         if(param1 > 0 && param1 != this._gridColumns)
         {
            _gridColumns = param1;
            sortItems();
            this.doAction302(0);
         }
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         param1 > 0 ? this.doAction914() : this.doAction597();
      }
   }
}

