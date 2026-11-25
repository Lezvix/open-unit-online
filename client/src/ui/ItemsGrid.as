package ui
{
   import debug.Assert;
   import flash.text.TextField;
   import game.InventoryItem;
   import game.IListenable;
   
   public class ItemsGrid extends ScrollSprite implements IListenable
   {
      
      private static const ITEMS_GRID_CONST1:int = 1;
      
      protected const itemsListList2:Vector.<ItemsList> = new Vector.<ItemsList>();
      
      private var columns:int;
      
      private var lastSelected:int = ItemsList.STYLE_LARGE;
      
      private var infoHandler:Function;
      
      private var repairClickHandler:Function;
      
      private var unpackHandler:Function;
      
      private var callback10:Function;
      
      private var _selectHandler:Function;
      
      private var _itemGridFilter:int = 7;
      
      private var flag88:Boolean = false;
      
      private var textField36:TextField = null;
      
      public function ItemsGrid(param1:int, param2:int = 4, param3:Boolean = false)
      {
         Assert.isTrue(param2 > 0);
         super(ItemsList.LARGE_WIDTH * param2 + ITEMS_GRID_CONST1 * (param2 + 1) + 12,param1,20);
         this.columns = param2;
         this.flag88 = param3;
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         param1 = param1 * (ItemsList.STYLE_HEIGHTS[this.style] + ITEMS_GRID_CONST1) / Math.abs(param1);
         if(param1 > 0 && scrollV > 0)
         {
            param1 = Math.min(scrollV,param1);
            scrollV -= param1;
            uiContainer.y += param1;
            scroll.scrollPosition -= param1;
         }
         if(param1 < 0 && scrollV < maxScroll)
         {
            param1 = Math.max(scrollV - maxScroll,param1);
            scrollV -= param1;
            uiContainer.y += param1;
            scroll.scrollPosition -= param1;
         }
         if(onScroll != null)
         {
            onScroll();
         }
      }
      
      protected function check15(param1:InventoryItem) : Boolean
      {
         var itemView:ItemsList = this.getItemsList1(param1);
         if(itemView == null)
         {
            param1.addChangeListener(this.doAction79);
            itemView = new ItemsList(param1,this.style);
            if(this.infoHandler != null)
            {
               itemView.showInfoButton(this.infoHandler);
            }
            if(this.repairClickHandler != null)
            {
               itemView.showRepairButton(this.repairClickHandler);
            }
            if(this.unpackHandler != null)
            {
               itemView.showUnpackButton(this.unpackHandler);
            }
            if(this.callback10 != null)
            {
               itemView.mouseDown = this.callback10;
            }
            this.itemsListList2.push(itemView);
            uiContainer.addUIChild(itemView);
            uiContainer.height = Math.max(height,itemView.height);
         }
         else
         {
            if(itemView.item.isExpendable)
            {
               itemView.item.count += param1.count;
            }
            return false;
         }
         return true;
      }
      
      protected function doAction79(param1:Object) : void
      {
         if(param1.property == "count")
         {
            this.dispatchChange("itemsWeight");
            this.dispatchChange("itemsPrice");
         }
      }
      
      public function addItem(param1:InventoryItem) : void
      {
         if(this.check15(param1))
         {
            this.sort();
            this.dispatchChange("itemsWeight");
            this.dispatchChange("itemsPrice");
         }
      }
      
      public function doAction888(param1:*, param2:Boolean = true) : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            uiContainer.removeUIChild(this.itemsListList2[itemIndex]);
            itemIndex++;
         }
         this.itemsListList2.splice(0,this.itemsListList2.length);
         this.doAction715(param1,param2);
      }
      
      public function doAction715(param1:*, param2:Boolean = true) : void
      {
         var item:InventoryItem = null;
         for each(item in param1)
         {
            this.check15(item);
         }
         if(param2)
         {
            this.sort();
         }
         this.dispatchChange("itemsWeight");
         this.dispatchChange("itemsPrice");
      }
      
      override public function clear() : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            uiContainer.removeUIChild(this.itemsListList2[itemIndex]);
            itemIndex++;
         }
         this.itemsListList2.splice(0,this.itemsListList2.length);
         this.doAction316();
         this.dispatchChange("itemsWeight");
         this.dispatchChange("itemsPrice");
      }
      
      protected function check59(param1:InventoryItem) : Boolean
      {
         var itemView:ItemsList = this.getItemsList1(param1);
         if(itemView == null)
         {
            return false;
         }
         itemView.item.removeChangeListener(this.doAction79);
         this.itemsListList2.splice(this.itemsListList2.indexOf(itemView),1);
         uiContainer.removeUIChild(itemView);
         return true;
      }
      
      public function removeItem(param1:InventoryItem) : void
      {
         if(this.check59(param1))
         {
            this.doAction316();
            this.dispatchChange("itemsWeight");
            this.dispatchChange("itemsPrice");
         }
      }
      
      public function doAction713(param1:*) : void
      {
         var item:InventoryItem = null;
         for each(item in param1)
         {
            this.check59(item);
         }
         this.doAction316();
         this.dispatchChange("itemsWeight");
         this.dispatchChange("itemsPrice");
      }
      
      public function sort() : void
      {
         if(this.selectHandler != null)
         {
            this.itemsListList2.sort(this.getInt36);
         }
         this.doAction316();
      }
      
      private function getInt36(param1:ItemsList, param2:ItemsList) : int
      {
         return this.selectHandler(param1.item,param2.item);
      }
      
      protected function doAction316() : void
      {
         var row:int = 0;
         var column:int = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(column == this.columns)
            {
               column = 0;
               row++;
            }
            if(this.itemsListList2[itemIndex].item.filter(this.filter))
            {
               this.itemsListList2[itemIndex].setPos(ITEMS_GRID_CONST1 + column * (this.itemsListList2[itemIndex].width + ITEMS_GRID_CONST1),ITEMS_GRID_CONST1 + row * (this.itemsListList2[itemIndex].height + ITEMS_GRID_CONST1));
               this.itemsListList2[itemIndex].visible = true;
               column++;
            }
            else
            {
               this.itemsListList2[itemIndex].visible = false;
            }
            itemIndex++;
         }
         init(ITEMS_GRID_CONST1 + (row + 1) * ((this.itemsListList2.length > 0 ? this.itemsListList2[0].height : 0) + ITEMS_GRID_CONST1),scrollV);
         if(this.flag88 && row == 0 && column == 0)
         {
            if(this.textField36 == null)
            {
               textField36 = new TextField();
               this.textField36.defaultTextFormat = NTextFormat.plain.center;
               this.textField36.x = 0;
               this.textField36.y = height >> 1;
               this.textField36.text = NUIComponent._("IDS_EMPTY");
               this.textField36.width = width;
               this.textField36.height = this.textField36.textHeight + 5;
               addChild(this.textField36);
            }
            if(!this.textField36.visible)
            {
               this.textField36.visible = true;
            }
         }
         else if(this.textField36 != null && this.textField36.visible)
         {
            this.textField36.visible = false;
         }
      }
      
      public function getItemsList1(param1:InventoryItem) : ItemsList
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(this.itemsListList2[itemIndex].item == param1 || this.itemsListList2[itemIndex].item.isExpendable && this.itemsListList2[itemIndex].item.itemId == param1.itemId)
            {
               return this.itemsListList2[itemIndex];
            }
            itemIndex++;
         }
         return null;
      }
      
      public function get style() : int
      {
         return this.lastSelected;
      }
      
      public function set style(param1:int) : void
      {
         var itemIndex:int = 0;
         if(this.lastSelected != param1)
         {
            lastSelected = param1;
            itemIndex = 0;
            while(itemIndex < this.itemsListList2.length)
            {
               this.itemsListList2[itemIndex].style = param1;
               itemIndex++;
            }
            this.doAction316();
         }
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
      
      public function doAction795() : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            this.itemsListList2[itemIndex].hideInfoButton();
            itemIndex++;
         }
         infoHandler = null;
      }
      
      public function doAction808(param1:Function) : void
      {
         var itemIndex:int = 0;
         if(this.infoHandler != param1)
         {
            itemIndex = 0;
            while(itemIndex < this.itemsListList2.length)
            {
               this.itemsListList2[itemIndex].showInfoButton(param1);
               itemIndex++;
            }
            infoHandler = param1;
         }
      }
      
      public function doAction21() : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            this.itemsListList2[itemIndex].hideRepairButton();
            itemIndex++;
         }
         repairClickHandler = null;
      }
      
      public function doAction93(param1:Function) : void
      {
         var itemIndex:int = 0;
         if(this.repairClickHandler != param1)
         {
            itemIndex = 0;
            while(itemIndex < this.itemsListList2.length)
            {
               this.itemsListList2[itemIndex].showRepairButton(param1);
               itemIndex++;
            }
            repairClickHandler = param1;
         }
      }
      
      public function doAction51() : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            this.itemsListList2[itemIndex].hideUnpackButton();
            itemIndex++;
         }
         unpackHandler = null;
      }
      
      public function doAction606(param1:Function) : void
      {
         var itemIndex:int = 0;
         if(this.unpackHandler != param1)
         {
            itemIndex = 0;
            while(itemIndex < this.itemsListList2.length)
            {
               this.itemsListList2[itemIndex].showUnpackButton(param1);
               itemIndex++;
            }
            unpackHandler = param1;
         }
      }
      
      public function set propValue49(param1:Function) : void
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            this.itemsListList2[itemIndex].mouseDown = param1;
            itemIndex++;
         }
         callback10 = param1;
      }
      
      public function get itemsWeight() : Number
      {
         var totalWeight:Number = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            totalWeight += this.itemsListList2[itemIndex].item.weight * this.itemsListList2[itemIndex].item.count;
            itemIndex++;
         }
         return totalWeight;
      }
      
      public function getFirstItem() : InventoryItem
      {
         return this.getInventoryItem1(-3);
      }
      
      public function getInventoryItem1(param1:int) : InventoryItem
      {
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(this.itemsListList2[itemIndex].item.itemId == param1)
            {
               return this.itemsListList2[itemIndex].item;
            }
            itemIndex++;
         }
         return null;
      }
      
      public function getInt31(param1:int) : int
      {
         var totalCount:int = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(this.itemsListList2[itemIndex].item.itemId == param1)
            {
               totalCount += this.itemsListList2[itemIndex].item.count;
            }
            itemIndex++;
         }
         return totalCount;
      }
      
      public function get itemsPrice() : int
      {
         var totalPrice:int = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            totalPrice += this.itemsListList2[itemIndex].item.price * this.itemsListList2[itemIndex].item.count;
            itemIndex++;
         }
         return totalPrice;
      }
      
      public function getInt1(param1:int, param2:int) : int
      {
         var priceFactor:Number = InventoryItem.getNumber7(param1 - param2);
         var totalPrice:int = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(this.itemsListList2[itemIndex].item.type == InventoryItem.TYPE_MONEY)
            {
               totalPrice += this.itemsListList2[itemIndex].item.price * this.itemsListList2[itemIndex].item.count;
            }
            else
            {
               totalPrice += Math.ceil(this.itemsListList2[itemIndex].item.price * this.itemsListList2[itemIndex].item.count * priceFactor);
            }
            itemIndex++;
         }
         return totalPrice;
      }
      
      public function get propValue107() : int
      {
         var totalPrice:int = 0;
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            if(this.itemsListList2[itemIndex].item.hasDurability)
            {
               totalPrice += this.itemsListList2[itemIndex].item.price * this.itemsListList2[itemIndex].item.count * this.itemsListList2[itemIndex].item.tear / 100;
            }
            else
            {
               totalPrice += this.itemsListList2[itemIndex].item.price * this.itemsListList2[itemIndex].item.count;
            }
            itemIndex++;
         }
         return totalPrice;
      }
      
      public function get propValue75() : int
      {
         return this.itemsListList2.length;
      }
      
      public function get items() : Vector.<InventoryItem>
      {
         var result:Vector.<InventoryItem> = new Vector.<InventoryItem>(this.propValue75);
         var itemIndex:int = 0;
         while(itemIndex < this.itemsListList2.length)
         {
            result[itemIndex] = this.itemsListList2[itemIndex].item;
            itemIndex++;
         }
         return result;
      }
      
      public function getArray3(param1:Function) : Array
      {
         var result:Array = [];
         var itemIndex:int;
         if(param1 != null)
         {
            itemIndex = 0;
            while(itemIndex < this.itemsListList2.length)
            {
               result.push(param1(this.itemsListList2[itemIndex]));
               itemIndex++;
            }
         }
         return result;
      }
      
      public function addChangeListener(param1:Function) : void
      {
         if(param1 == null || this.listeners.indexOf(param1) != -1)
         {
            return;
         }
         this.listeners.push(param1);
      }
      
      public function removeChangeListener(param1:Function) : void
      {
         var listenerIndex:int = this.listeners.indexOf(param1);
         if(listenerIndex != -1)
         {
            this.listeners.splice(listenerIndex,1);
         }
      }
      
      protected const listeners:Vector.<Function> = new Vector.<Function>();

      protected function dispatchChange(param1:String) : void
      {
         var eventData:Object = {"property":param1};
         var listener:Function;
         for each(listener in this.listeners)
         {
            listener(eventData);
         }
      }
   }
}

