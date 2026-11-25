package core.ui.views
{
   import flash.utils.getTimer;
   
   public class ShopItemList extends TileListView
   {
      
      private var _shopItemScrollIndex:int = 0;
      
      public function ShopItemList()
      {
         super();
      }
      
      override public function clear() : void
      {
         super.clear();
         _shopItemScrollIndex = 0;
      }
      
      private function get propValue62() : int
      {
         return _horizontalScrollingEnabled ? width / columns : height / rows;
      }
      
      private function get propValue51() : int
      {
         return int(uiComponentList1.length / (rows * columns)) * (_horizontalScrollingEnabled ? columns : rows) + uiComponentList1.length % (_horizontalScrollingEnabled ? columns : rows);
      }
      
      private function getInt2(param1:int) : int
      {
         var horizontalIndex:int = 0;
         var verticalIndex:int = 0;
         if(_horizontalScrollingEnabled)
         {
            horizontalIndex = int(param1 / columns) * (columns * rows) + param1 % columns;
            return (this.propValue62 - uiComponentList1[horizontalIndex].width) / 2 - uiComponentList1[horizontalIndex].x;
         }
         verticalIndex = int(param1 / rows) * (columns * rows) + param1 % rows * columns;
         return (this.propValue62 - uiComponentList1[verticalIndex].height) / 2 - uiComponentList1[verticalIndex].y;
      }
      
      public function get propValue192() : int
      {
         return this._shopItemScrollIndex;
      }
      
      public function doAction635(param1:int) : void
      {
         _shopItemScrollIndex = Math.max(0,Math.min(param1,this.propValue51 - 1));
         propValue30 = this.getInt2(this._shopItemScrollIndex);
      }
      
      public function doAction889(param1:int) : void
      {
         _shopItemScrollIndex = Math.max(0,Math.min(param1,this.propValue51 - 1));
         if(_horizontalScrollingEnabled)
         {
            doAction279(this.getInt2(this._shopItemScrollIndex),contentView.y,500);
         }
         else
         {
            doAction279(contentView.x,this.getInt2(this._shopItemScrollIndex),500);
         }
      }
      
      override protected function onDragEnd() : void
      {
         var itemOffset:int = 0;
         scrollDragging = false;
         scrollStartSpeed = (_horizontalScrollingEnabled ? mouseX - point4.x : mouseY - point4.y) / (getTimer() - intValue220);
         if(Math.abs(scrollStartSpeed) < 0.5)
         {
            itemOffset = this.getInt2(this._shopItemScrollIndex) - propValue30;
            if(itemOffset > 0)
            {
               this.doAction889(itemOffset > this.propValue62 / 3 ? this._shopItemScrollIndex + 1 : this._shopItemScrollIndex);
            }
            else
            {
               this.doAction889(Math.abs(itemOffset) > this.propValue62 / 3 ? this._shopItemScrollIndex - 1 : this._shopItemScrollIndex);
            }
         }
         else
         {
            this.doAction889(scrollStartSpeed > 0 ? this._shopItemScrollIndex - 1 : this._shopItemScrollIndex + 1);
         }
      }
      
      public function doAction750() : void
      {
         this.doAction889(this._shopItemScrollIndex + 1);
      }
      
      public function doAction195() : void
      {
         this.doAction889(this._shopItemScrollIndex - 1);
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         param1 > 0 ? this.doAction195() : this.doAction750();
      }
   }
}

