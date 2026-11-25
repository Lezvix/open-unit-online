package ui
{
   import core.ui.NUIController;
   
   public class GameUIController extends NUIController
   {
      
      public function GameUIController(param1:Main)
      {
         super(param1,param1.mouseDownHandler,param1.mouseUpHandler,param1.mouseMoveHandler,param1.mainMoveHandler);
         sharedController = this;
      }
      
      override public function updateCursor() : void
      {
         if(cursorManager)
         {
            if(overItemValue)
            {
               cursorManager.cursorId = overItemValue.cursorId;
               cursorManager.hintData = overItemValue.hintData;
            }
            else
            {
               cursorManager.hintData = null;
            }
            cursorManager.updateCursor();
         }
      }
   }
}

