package ui
{
   import ui.controls.NPresentsList;
   import net.NSocket;
   import core.ui.NScrollBar;
   import flash.display.Sprite;
   
   public class PresentsList extends NPresentsList
   {
      
      public function PresentsList(nsocket:NSocket, parentSprite:Sprite, clientObj:Object, charInfo:Object)
      {
         super(nsocket,parentSprite,clientObj,charInfo);
      }
      
      override protected function createScroll(scrollHeight:int) : NScrollBar
      {
         return NuclearMenu.getNScrollBar1(scrollHeight);
      }
      
      override public function dispose() : void
      {
         this.hideHint();
         super.dispose();
      }
      
      override public function mouseMoveHandler() : void
      {
         var i:int = 0;
         var unused:int;
         var hint:String = "";
         if(isOver && dragPresent == null && includesMouse())
         {
            while(i < presentsSprites.length)
            {
               if(presentsSprites[i] != null && mouseX >= i * USER_CELL_WIDTH && mouseX < (i + 1) * USER_CELL_WIDTH && mouseY >= 0 && mouseY < USER_CELL_HEIGHT)
               {
                  hint = texts[i];
                  break;
               }
               i++;
            }
         }
         if(hintText != hint)
         {
            this.hideHint();
            if(hint != "")
            {
               if(client)
               {
                  client.setHint(hint);
               }
               else
               {
                  CharacterInfo.showHint(hint);
               }
               hintText = hint;
            }
         }
      }
      
      private function hideHint() : void
      {
         if(client)
         {
            client.hideHint();
         }
         else
         {
            CharacterInfo.hideHint();
         }
         hintText = "";
      }
      
      override public function mouseOverHandler() : void
      {
         isOver = true;
         this.mouseMoveHandler();
      }
      
      override public function mouseOutHandler() : void
      {
         this.hideHint();
         isOver = false;
      }
      
      override public function mouseUpHandler() : void
      {
         if(dragPresent)
         {
            dragPresent.stopDrag();
            if(!parentMenu.isMouseOver)
            {
               dropId = dragPresent.presentId;
               client.showYesNoMenu(_("IDS_DELETE_PRESENT"),handleDelete);
            }
            dragPresent = null;
            update();
         }
      }
   }
}

