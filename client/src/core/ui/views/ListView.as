package core.ui.views
{
   public class ListView extends ScrollView
   {
      
      private var _listSpacing:int;
      
      private var _scrollFactor:int = 30;
      
      public function ListView()
      {
         super();
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         _verticalScrollingEnabled = !_horizontalScrollingEnabled;
         _listSpacing = param1.spacing;
      }
      
      override public function set horizontalScrollingEnabled(param1:Boolean) : void
      {
         if(_horizontalScrollingEnabled != param1)
         {
            super.horizontalScrollingEnabled = param1;
            _verticalScrollingEnabled = !param1;
            this.sortItems();
         }
      }
      
      override public function set verticalScrollingEnabled(param1:Boolean) : void
      {
         if(_verticalScrollingEnabled != param1)
         {
            super.verticalScrollingEnabled = param1;
            _horizontalScrollingEnabled = !param1;
            this.sortItems();
         }
      }
      
      override protected function sortItems(param1:int = 0) : void
      {
         if(_horizontalScrollingEnabled)
         {
            this.sortItemsHorizontally(param1);
         }
         else
         {
            this.sortItemsVertically(param1);
         }
      }
      
      protected function sortItemsHorizontally(param1:int = 0) : void
      {
         var nextX:int = param1 > 0 ? uiComponentList1[param1 - 1].x + uiComponentList1[param1 - 1].width + this._listSpacing : 0;
         var index:int = param1;
         while(index < uiComponentList1.length)
         {
            uiComponentList1[index].x = nextX;
            uiComponentList1[index].y = int((height - uiComponentList1[index].height) / 2);
            nextX += this._listSpacing + uiComponentList1[index].width;
            index++;
         }
      }
      
      protected function sortItemsVertically(param1:int = 0) : void
      {
         var nextY:int = param1 > 0 ? uiComponentList1[param1 - 1].y + uiComponentList1[param1 - 1].height + this._listSpacing : 0;
         var index:int = param1;
         while(index < uiComponentList1.length)
         {
            uiComponentList1[index].y = nextY;
            uiComponentList1[index].x = int((width - uiComponentList1[index].width) / 2);
            nextY += this._listSpacing + uiComponentList1[index].height;
            index++;
         }
      }
      
      public function get spacing() : int
      {
         return this._listSpacing;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         if(_horizontalScrollingEnabled)
         {
            doAction279(contentView.x + param1 * this._scrollFactor,contentView.y,300);
         }
         else
         {
            doAction279(contentView.x,contentView.y + param1 * this._scrollFactor,300);
         }
      }
      
      public function set spacing(param1:int) : void
      {
         if(param1 > 0 && param1 != this._listSpacing)
         {
            _listSpacing = param1;
            this.sortItems();
         }
      }
      
      public function get scrollFactor() : int
      {
         return this._scrollFactor;
      }
      
      public function set scrollFactor(param1:int) : void
      {
         _scrollFactor = param1;
      }
   }
}

