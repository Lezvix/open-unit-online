package ui
{
   import ui.buttons.*;
   import core.system.EventListeners;
   import core.ui.UIComponent;
   import core.ui.NUIController;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class DropDown extends UIComponent
   {
      
      [Embed(source="/assets/NCombo_TRINGLE.png")]
      
      public static var TRINGLE:Class;
      
      private var w:Number = 160;
      
      private const data:Vector.<Object> = new Vector.<Object>();
      
      private var _selectedKey:int = int.MIN_VALUE;
      
      private var changeHandler:Function = null;
      
      private var _maxVisibleRows:int;
      
      private var header:SelectableButton;
      
      private var list:UIComponent = new UIComponent();
      
      private var scroll:ScrollSprite = null;
      
      private var triangle:Bitmap;
      
      public function DropDown(dropWidth:Number, values:*, onChange:Function, selectedKey:int = 0, maxRows:int = 7)
      {
         super();
         this.w = dropWidth;
         this._maxVisibleRows = maxRows;
         this.header = new SelectableButton({
            "clickHandler":this.onHeaderClick,
            "width":dropWidth
         });
         this.header.addLabel("-",TextFormatAlign.CENTER);
         this.changeHandler = onChange;
         this.width = this.w;
         height = 19;
         this.scaleX = 1;
         this.scaleY = 1;
         this.triangle = new TRINGLE();
         this.header.addBitmap(this.triangle,this.w - this.triangle.width - 4,8);
         addUIChild(this.header);
         this.list.y = 20;
         addUIChild(this.list);
         this.selectedValue = values;
         this.SelectedKey = selectedKey;
         EventListeners.addEventListener(NUIController.sharedController,MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      protected function onMouseDown(event:MouseEvent) : void
      {
         if(this.isOpened && !this.includesMouse())
         {
            isOpened = false;
         }
      }
      
      protected function onHeaderClick(sender:Object) : void
      {
         isOpened = !this.isOpened;
      }
      
      override public function dispose() : void
      {
         EventListeners.removeEventListener(NUIController.sharedController,MouseEvent.MOUSE_DOWN,this.onMouseDown);
         isOpened = false;
         this.triangle.bitmapData.dispose();
         super.dispose();
      }
      
      protected function onItemClick(button:Object) : void
      {
         SelectedKey = button.value;
         isOpened = button.Selected = false;
         if(this.changeHandler != null)
         {
            this.changeHandler(this);
         }
      }
      
      public function get SelectedKey() : int
      {
         return this._selectedKey;
      }
      
      public function get selectedLabel() : Object
      {
         var i:int = 0;
         while(i < this.data.length)
         {
            if(this.data[i].key == this._selectedKey)
            {
               return this.data[i].value;
            }
            i++;
         }
         return null;
      }
      
      public function set SelectedKey(key:int) : void
      {
         var i:int = 0;
         if(this._selectedKey != key)
         {
            _selectedKey = key;
            i = 0;
            while(i < this.data.length)
            {
               if(this.data[i].key == key)
               {
                  this.header.getLabel(0).text = String(this.data[i].value);
                  break;
               }
               i++;
            }
         }
      }
      
      protected function rebuildList() : void
      {
         isOpened = false;
         this.list.disposeAllChilds();
         if(this.data.length > this.maxVisibleRows)
         {
            if(this.scroll == null)
            {
               scroll = new ScrollSprite(this.w - 5,this.maxVisibleRows * 19 + 1);
            }
            this.scroll.y = 6;
            this.list.addUIChild(this.scroll);
         }
         else
         {
            scroll = null;
         }
         var i:int = 0;
         var button:SelectableButton;
         while(i < this.data.length)
         {
            button = new SelectableButton({
               "y":i * 19,
               "clickHandler":this.onItemClick,
               "width":(this.scroll == null ? this.w : this.w - 19)
            });
            button.value = this.data[i].key;
            button.addLabel(String(this.data[i].value),TextFormatAlign.CENTER);
            this.scroll == null ? this.list.addUIChild(button) : this.scroll.addContent(button);
            i++;
         }
         if(this.scroll == null)
         {
            this.list.height = i * 19;
            this.list.width = this.w;
         }
         else
         {
            this.list.height = this.scroll.y + this.scroll.height;
            this.list.width = this.w;
            this.scroll.init(i * 19 + 2);
         }
         this.list.graphics.clear();
         this.list.fillRect(0,1,this.list.width,this.list.height,1776411);
         isOpened = true;
         isOpened = false;
         SelectedKey = this.data[0].key;
      }
      
      public function set selectedValue(values:*) : void
      {
         this.data.splice(0,this.data.length);
         _selectedKey = int.MIN_VALUE;
         var empty:Boolean = true;
         var key:*;
         if(values)
         {
            for(key in values)
            {
               this.data.push({
                  "key":key,
                  "value":values[key]
               });
               empty = false;
            }
         }
         if(empty)
         {
            this.data.push({
               "key":0,
               "value":"-"
            });
         }
         this.rebuildList();
      }
      
      public function get isOpened() : Boolean
      {
         return this.list.visible;
      }
      
      public function set isOpened(value:Boolean) : void
      {
         if(this.list.visible != value)
         {
            this.list.visible = value;
            this.list.enabled = value;
            if(!value)
            {
               this.header.Selected = value;
            }
         }
      }
      
      public function get maxVisibleRows() : int
      {
         return this._maxVisibleRows;
      }
      
      public function set maxVisibleRows(value:int) : void
      {
         _maxVisibleRows = value;
      }
      
      override protected function includesMouse() : Boolean
      {
         return mouseX < width && mouseX >= 0 && mouseY < height + (this.isOpened ? this.list.height : 0) && mouseY >= 0;
      }
   }
}

