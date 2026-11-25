package ui
{
   import core.display.NSprite;
   import core.ui.UIElement;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class NCombo extends UIElement
   {
      
      public static var COMBO_WIDTH:int = 82;
      
      public static var COMBO_HEIGHT:int = 12;
      
      [Embed(source="/assets/NCombo_TRINGLE.png")]
      
      public static var TRINGLE:Class;
      
      public var value:int;
      
      public var object:Object;
      
      public var object1:Object;
      
      public var selItem:int = 0;
      
      public var lastSelectedItem:int = 0;
      
      private var curSelected:int = 0;
      
      private var _active:Boolean = false;
      
      private var changeHandler:Function;
      
      private var tf10:TextFormat;
      
      private var textField:TextField;
      
      private var upSprite:NSprite;
      
      private var startY:int;
      
      public var items:Array = new Array();
      
      public var isOver:Boolean = false;
      
      private var scrollSprite:ScrollSprite = null;
      
      private var tringle:Bitmap;
      
      public function NCombo(listSprite:NSprite, onChange:Function, comboValue:int, unused:Object = null)
      {
         super();
         this.changeHandler = onChange;
         this.value = comboValue;
         this.upSprite = listSprite;
         listSprite.visible = false;
         this.tf10 = new TextFormat();
         this.tf10.font = "Verdana";
         this.tf10.color = 13408825;
         this.tf10.size = 10;
         drawRect(0,0,COMBO_WIDTH,COMBO_HEIGHT,13408825);
         this.tringle = new TRINGLE();
         this.tringle.x = 70;
         this.tringle.y = 4;
         addChild(this.tringle);
         this.textField = new TextField();
         this.textField.selectable = false;
         this.textField.wordWrap = false;
         this.textField.width = COMBO_WIDTH - 2;
         this.textField.height = 14;
         this.textField.x = 1;
         this.textField.y = -2;
         this.textField.defaultTextFormat = this.tf10;
         addChild(this.textField);
      }
      
      public function setScrollSprite(scroll:ScrollSprite) : void
      {
         startY = this.upSprite.y;
         this.scrollSprite = scroll;
      }
      
      public function set selectedItem(index:int) : void
      {
         this.textField.text = this.items[index].toString();
         selItem = index;
      }
      
      public function get selectedItem() : int
      {
         return this.selItem;
      }
      
      public function addItem(item:String) : void
      {
         this.items.push(item);
      }
      
      override public function dispose() : void
      {
         this.tringle.bitmapData.dispose();
         super.dispose();
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override protected function includesMouse() : Boolean
      {
         if(visible)
         {
            if(this._active)
            {
               if(this.upSprite.mouseX >= 0 && this.upSprite.mouseX < COMBO_WIDTH && this.upSprite.mouseY >= 0 && this.upSprite.mouseY < COMBO_HEIGHT * this.items.length)
               {
                  return true;
               }
            }
            else if(mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateUpBG() : void
      {
         this.upSprite.graphics.clear();
         this.upSprite.fillRect(0,0,COMBO_WIDTH,COMBO_HEIGHT * this.items.length,0);
         this.upSprite.fillRect(0,COMBO_HEIGHT * this.curSelected,COMBO_WIDTH,COMBO_HEIGHT,4602143);
         this.upSprite.drawRect(0,0,COMBO_WIDTH,COMBO_HEIGHT * this.items.length,13408825);
      }
      
      private function showUpSprite() : void
      {
         var itemText:TextField;
         _active = true;
         if(this.scrollSprite != null)
         {
            this.upSprite.y = this.startY - this.scrollSprite.scrollV;
         }
         curSelected = this.selectedItem;
         while(this.upSprite.numChildren)
         {
            this.upSprite.removeChildAt(0);
         }
         this.upSprite.visible = true;
         this.updateUpBG();
         var i:int = 0;
         while(i < this.items.length)
         {
            itemText = new TextField();
            itemText.selectable = false;
            itemText.wordWrap = false;
            itemText.height = 14;
            itemText.width = COMBO_WIDTH - 2;
            itemText.defaultTextFormat = this.tf10;
            itemText.x = 1;
            itemText.y = i * COMBO_HEIGHT - 2;
            itemText.text = this.items[i];
            this.upSprite.addChild(itemText);
            i++;
         }
      }
      
      public function hideUpSprite() : void
      {
         this.upSprite.visible = false;
         _active = false;
      }
      
      override public function mouseDownHandler() : void
      {
         this.showUpSprite();
      }
      
      override public function mouseOverHandler() : void
      {
         isOver = true;
         this.processSelected();
      }
      
      override public function mouseOutHandler() : void
      {
         isOver = false;
         this.processSelected();
      }
      
      public function processSelected() : void
      {
         var prevSelected:int = 0;
         if(this._active && this.includesMouse())
         {
            prevSelected = this.curSelected;
            curSelected = this.upSprite.mouseY / COMBO_HEIGHT;
            if(prevSelected != this.curSelected)
            {
               this.updateUpBG();
            }
         }
      }
      
      override public function mouseUpHandler() : void
      {
         if(this._active)
         {
            if(this.includesMouse() && this.curSelected != this.selectedItem)
            {
               this.hideUpSprite();
               lastSelectedItem = this.selectedItem;
               selectedItem = this.curSelected;
               this.changeHandler(this);
            }
            else
            {
               this.hideUpSprite();
            }
         }
      }
      
      override public function mouseMoveHandler() : void
      {
         this.processSelected();
      }
   }
}

