package ui
{
   import core.ui.CursorLayer;
   import core.ui.CursorManager;
   import core.ui.Cursor;
   import core.ui.UIElement;
   
   public class GameCursorManager extends CursorManager
   {
      
      public function GameCursorManager(param1:UIElement)
      {
         super(param1,new CursorLayer());
         doAction460(new GameCursor(Cursor.CURSOR_DEFAULT));
         doAction460(new GameCursor(GameCursor.CURSOR_1));
         doAction460(new GameCursor(GameCursor.CURSOR_2));
         doAction460(new GameCursor(GameCursor.CURSOR_3));
      }
      
      override public function updateCursor() : void
      {
      }
   }
}

