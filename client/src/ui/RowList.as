package ui
{
   import ui.buttons.SelectableButton;
   import core.ui.UIComponent;
   import flash.text.TextFormatAlign;
   
   public class RowList extends UIComponent
   {
      
      private const rows:Vector.<SelectableButton> = new Vector.<SelectableButton>();
      
      private var onRowClick:Function;
      
      private var rowSpacing:int;
      
      public function RowList(width:int, onRowClick:Function = null, rowSpacing:int = 2, singleSelectionMode:Boolean = true)
      {
         super();
         this.rowSpacing = rowSpacing;
         if(singleSelectionMode && onRowClick != null)
         {
            this.onRowClick = function(param1:SelectableButton):void
            {
               deselectOthers(param1);
               onRowClick(param1);
            };
         }
         else
         {
            this.onRowClick = onRowClick;
         }
         this.width = width;
      }
      
      protected function deselectOthers(except:SelectableButton = null) : void
      {
         var row:SelectableButton = null;
         for each(row in this.rows)
         {
            if(row != except)
            {
               row.Selected = false;
            }
         }
      }
      
      public function selectRow(index:int) : void
      {
         this.rows[index].Selected = true;
      }
      
      public function deselectRow(index:int) : void
      {
         this.rows[index].Selected = false;
      }
      
      public function get totalRows() : int
      {
         return this.rows.length;
      }
      
      public function addRow(label:Object, value:Object = "", rowValue:Object = null, disabled:Boolean = false) : void
      {
         var row:SelectableButton = new SelectableButton({
            "y":(20 + this.rowSpacing) * this.totalRows,
            "width":width
         });
         row.addLabel(label.toString());
         row.addLabel(value.toString(),TextFormatAlign.RIGHT);
         this.rows.push(row);
         row.value = rowValue;
         if(this.onRowClick == null || disabled)
         {
            row.Enabled = false;
         }
         else
         {
            row.clickHandler = this.onRowClick;
         }
         addUIChild(row);
         height = (20 + this.rowSpacing) * this.totalRows;
      }
      
      public function addCenteredRow(label:Object = "", rowValue:Object = null, disabled:Boolean = false) : void
      {
         var row:SelectableButton = new SelectableButton({
            "y":(20 + this.rowSpacing) * this.totalRows,
            "width":width
         });
         row.addLabel(label.toString(),TextFormatAlign.CENTER);
         this.rows.push(row);
         row.value = rowValue;
         if(this.onRowClick == null || disabled)
         {
            row.Enabled = false;
         }
         else
         {
            row.clickHandler = this.onRowClick;
         }
         addUIChild(row);
         height = (20 + this.rowSpacing) * this.totalRows;
      }
      
      public function getRow(index:int) : SelectableButton
      {
         return this.rows[index];
      }
      
      public function getRowValue(index:int) : Object
      {
         return this.rows[index].value;
      }
      
      public function getData(index:int, column:int) : String
      {
         return this.rows[index].getLabel(column).text;
      }
      
      public function setData(index:int, column:int, value:Object) : void
      {
         this.rows[index].getLabel(column).text = value.toString();
      }
      
      public function setRowColor(index:int, color:uint) : void
      {
         this.rows[index].getLabel(0).textColor = color;
         this.rows[index].getLabel(1).textColor = color;
      }
      
      public function setRowHint(index:int, hint:String) : void
      {
         this.rows[index].hint = hint;
         this.rows[index].Enabled = true;
         if(!this.rows[index].clickHandler)
         {
            this.rows[index].clickHandler = this.onHintRowClick;
         }
      }
      
      private function onHintRowClick(row:SelectableButton) : void
      {
         row.Selected = false;
      }
      
      public function clear() : void
      {
         while(this.rows.length > 0)
         {
            removeUIChild(this.rows.pop());
         }
         height = 0;
      }
      
      public function deselectAll() : void
      {
         this.deselectOthers();
      }
      
      public function removeRow(index:int) : void
      {
         var i:int = index + 1;
         while(i < this.rows.length)
         {
            this.rows[i].y -= 20 + this.rowSpacing;
            i++;
         }
         this.rows.splice(index,1);
         height = (20 + this.rowSpacing) * this.totalRows;
      }
      
      public function get selectedRows() : Vector.<int>
      {
         var result:Vector.<int> = new Vector.<int>();
         var i:int = 0;
         while(i < this.rows.length)
         {
            if(this.rows[i].Selected)
            {
               result.push(i);
            }
            i++;
         }
         return result;
      }
      
      public function get selectedRow() : int
      {
         var i:int = 0;
         while(i < this.rows.length)
         {
            if(this.rows[i].Selected)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
   }
}

