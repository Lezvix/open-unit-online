package core.ui
{
   import core.display.NLabel;
   
   public class NTextField extends UIElement
   {
      
      private const str41:String = "left";
      
      private var nlabel:NLabel;
      
      private var isSelecting:Boolean = false;
      
      public var onScroll:Function = null;
      
      private var startIdx:int;
      
      private var endIdx:int;
      
      public var onClick:Function = null;
      
      public function NTextField(param1:TextStyle, param2:Boolean = false, param3:String = "left")
      {
         super();
         this.nlabel = new NLabel(param1,param2,param3);
         addChild(this.nlabel);
      }
      
      public function get textField() : NLabel
      {
         return this.nlabel;
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         this.nlabel.scrollV -= param1;
      }
      
      override public function mouseMoveHandler() : void
      {
         if(this.isSelecting)
         {
            this.updateMousePos();
         }
      }
      
      protected function onMouseDown() : void
      {
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.onClick != null)
         {
            this.onClick(this);
         }
         var restoreFocus:Boolean = false;
         var lineIndex:int;
         if(this.nlabel.selectable)
         {
            startIdx = this.nlabel.getCharIndexAtPoint(mouseX,mouseY);
            if(this.startIdx != -1)
            {
               endIdx = this.startIdx;
               this.nlabel.setSelection(this.startIdx,this.endIdx);
               isSelecting = true;
            }
            else
            {
               lineIndex = this.nlabel.getLineIndexAtPoint(mouseX,mouseY);
               if(lineIndex != -1)
               {
                  startIdx = this.nlabel.getLineOffset(lineIndex) + this.nlabel.getLineLength(lineIndex);
                  if(this.startIdx >= 0)
                  {
                     endIdx = this.startIdx;
                     this.nlabel.setSelection(this.startIdx,this.endIdx);
                     isSelecting = true;
                  }
                  else
                  {
                     this.nlabel.setSelection(this.nlabel.text.length,this.nlabel.text.length);
                  }
               }
               else
               {
                  this.nlabel.setSelection(this.nlabel.text.length,this.nlabel.text.length);
               }
            }
            stage.focus = this.nlabel;
            restoreFocus = true;
         }
         this.onMouseDown();
         if(restoreFocus && stage.focus != this.nlabel)
         {
            stage.focus = this.nlabel;
         }
         super.mouseDownHandler();
      }
      
      private function updateMousePos() : void
      {
         var lineIndex:int = 0;
         endIdx = this.nlabel.getCharIndexAtPoint(mouseX,mouseY);
         if(this.endIdx == -1)
         {
            lineIndex = this.nlabel.getLineIndexAtPoint(mouseX,mouseY);
            if(lineIndex != -1)
            {
               endIdx = this.nlabel.getLineOffset(lineIndex) + this.nlabel.getLineLength(lineIndex);
               if(this.endIdx < 0)
               {
                  endIdx = this.nlabel.text.length;
               }
            }
            else
            {
               endIdx = this.nlabel.text.length;
            }
         }
         this.nlabel.setSelection(this.startIdx,this.endIdx);
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.isSelecting)
         {
            this.updateMousePos();
            isSelecting = false;
         }
         super.mouseUpHandler();
      }
   }
}

