package ui
{
   import flash.text.TextField;
   import game.Client;
   import game.ShopItem;
   
   public class ShopItemsGrid extends ScrollSprite
   {
      
      private static const ITEMS_GRID_CONST1:int = 1;
      
      protected const itemsListList2:Vector.<ShopItemView> = new Vector.<ShopItemView>();
      
      private var lastSelected:int;
      
      private var infoHandler:Function;
      
      private var callback10:Function;
      
      private var _selectHandler:Function;
      
      private var _itemGridFilter:int = 7;
      
      private var textField33:TextField;
      
      public function ShopItemsGrid(param1:int, param2:int, param3:int, param4:Function = null)
      {
         super(param1,param2,16);
         this.lastSelected = param3;
         this.infoHandler = param4;
      }
      
      public function doAction715(param1:Array, param2:Boolean = true) : void
      {
         var index:int = 0;
         var shopItem:ShopItem;
         var itemView:ShopItemView;
         for(; index < param1.length; index++)
         {
            shopItem = param1[index];
            if(this.getItemsList1(shopItem) != null)
            {
               continue;
            }
            itemView = new ShopItemView(shopItem,this.infoHandler,this.style);
            if(this.callback10 != null)
            {
               itemView.mouseDown = this.callback10;
            }
            this.itemsListList2.push(itemView);
            uiContainer.addUIChild(itemView);
            uiContainer.height = Math.max(height,itemView.height);
         }
         if(param2)
         {
            this.sort();
         }
      }
      
      public function get propValue162() : int
      {
         var totalCost:int = 0;
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            totalCost += this.itemsListList2[index].shopitem.cost;
            index++;
         }
         return totalCost;
      }
      
      public function get items() : Vector.<ShopItem>
      {
         var shopItems:Vector.<ShopItem> = new Vector.<ShopItem>(this.itemsListList2.length);
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            shopItems[index] = this.itemsListList2[index].shopitem;
            index++;
         }
         return shopItems;
      }
      
      override public function clear() : void
      {
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            uiContainer.removeUIChild(this.itemsListList2[index]);
            index++;
         }
         this.itemsListList2.splice(0,this.itemsListList2.length);
         this.doAction316();
      }
      
      public function doAction713(param1:Array) : void
      {
         var index:int = 0;
         var itemView:ShopItemView;
         while(index < param1.length)
         {
            itemView = this.getItemsList1(param1[index]);
            if(itemView != null)
            {
               this.itemsListList2.splice(this.itemsListList2.indexOf(itemView),1);
               uiContainer.removeUIChild(itemView);
            }
            index++;
         }
         this.doAction316();
      }
      
      public function sort() : void
      {
         if(this.selectHandler != null)
         {
            this.itemsListList2.sort(this.getInt36);
         }
         this.doAction316();
      }
      
      private function getInt36(param1:ShopItemView, param2:ShopItemView) : int
      {
         return this.selectHandler(param1.shopitem,param2.shopitem);
      }
      
      protected function doAction316() : void
      {
         var visibleCount:int = 0;
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            if(this.itemsListList2[index].shopitem.filter(this.filter))
            {
               this.itemsListList2[index].setPos(ITEMS_GRID_CONST1,ITEMS_GRID_CONST1 + visibleCount * (this.itemsListList2[index].height + ITEMS_GRID_CONST1));
               this.itemsListList2[index].visible = true;
               visibleCount++;
            }
            else
            {
               this.itemsListList2[index].visible = false;
            }
            index++;
         }
         if(visibleCount == 0 && this.filter == ShopItem.PAY_FILTER_COUNT)
         {
            if(this.textField33 == null)
            {
               textField33 = new TextField();
               this.textField33.width = width;
               this.textField33.y = 10;
               this.textField33.wordWrap = true;
               this.textField33.multiline = true;
               this.textField33.defaultTextFormat = NTextFormat.titleFormat;
               this.textField33.text = Client._("IDS_NO_SALES");
               addChild(this.textField33);
            }
            this.textField33.visible = true;
         }
         else if(this.textField33 != null)
         {
            this.textField33.visible = false;
         }
         init(ITEMS_GRID_CONST1 + visibleCount * ((this.itemsListList2.length > 0 ? this.itemsListList2[0].height : 0) + ITEMS_GRID_CONST1),scrollV);
      }
      
      protected function getItemsList1(param1:ShopItem) : ShopItemView
      {
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            if(this.itemsListList2[index].shopitem == param1)
            {
               return this.itemsListList2[index];
            }
            index++;
         }
         return null;
      }
      
      public function get style() : int
      {
         return this.lastSelected;
      }
      
      public function get selectHandler() : Function
      {
         return this._selectHandler;
      }
      
      public function set selectHandler(param1:Function) : void
      {
         if(this._selectHandler != param1)
         {
            _selectHandler = param1;
            this.sort();
         }
      }
      
      public function get filter() : int
      {
         return this._itemGridFilter;
      }
      
      public function set filter(param1:int) : void
      {
         if(this._itemGridFilter != param1)
         {
            _itemGridFilter = param1;
            scrollV = 0;
            this.doAction316();
         }
      }
      
      public function set propValue49(param1:Function) : void
      {
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            this.itemsListList2[index].mouseDown = param1;
            index++;
         }
         callback10 = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         scroll.height = param1;
         maskShape.graphics.clear();
         maskShape.graphics.beginFill(0,0);
         maskShape.graphics.drawRect(0,0,initWidth,param1);
         maskShape.height = param1;
         initHeight = param1;
         var contentBottom:int = 0;
         var index:int = 0;
         while(index < this.itemsListList2.length)
         {
            if(this.itemsListList2[index].visible && this.itemsListList2[index].y > contentBottom)
            {
               contentBottom = this.itemsListList2[index].y + this.itemsListList2[index].height;
            }
            index++;
         }
         init(contentBottom + ITEMS_GRID_CONST1,scrollV);
      }
   }
}

