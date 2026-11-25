package core.ui
{
   import flash.display.Sprite;
   
   public class Cursor extends Sprite
   {
      
      public static const CURSOR_DEFAULT:int = 0;
      
      public var cursorId:int;
      
      public function Cursor(param1:int)
      {
         super();
         this.cursorId = param1;
      }
      
      public function play() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}

