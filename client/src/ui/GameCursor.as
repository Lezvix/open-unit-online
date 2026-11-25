package ui
{
   import core.ui.Cursor;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class GameCursor extends Cursor
   {
      
      public static const CURSOR_DEFAULT:int = Cursor.CURSOR_DEFAULT;
      
      public static const CURSOR_1:int = 1;
      
      public static const CURSOR_2:int = 2;
      
      public static const CURSOR_3:int = 3;
      
      public function GameCursor(param1:int)
      {
         super(param1);
      }
      
      override public function play() : void
      {
         switch(cursorId)
         {
            case CURSOR_1:
               Mouse.cursor = MouseCursor.BUTTON;
               break;
            case CURSOR_2:
               Mouse.cursor = MouseCursor.HAND;
               break;
            case CURSOR_3:
               Mouse.cursor = MouseCursor.IBEAM;
               break;
            case CURSOR_DEFAULT:
            default:
               Mouse.cursor = MouseCursor.AUTO;
               break;
         }
         Mouse.show();
      }
      
      override public function stop() : void
      {
         Mouse.cursor = MouseCursor.AUTO;
         Mouse.show();
      }
      
      override public function dispose() : void
      {
         Mouse.cursor = MouseCursor.AUTO;
         Mouse.show();
         super.dispose();
      }
   }
}

