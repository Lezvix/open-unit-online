package ui
{
   import core.ui.NScrollSprite;
   import core.ui.NScrollBar;
   
   public class ScrollSprite extends NScrollSprite
   {
      
      public function ScrollSprite(param1:int, param2:int, param3:int = 4)
      {
         super(param1,param2,param3);
      }
      
      override protected function createScroll(param1:int) : NScrollBar
      {
         return new NuclearScrollBar(param1);
      }
      
      public function get isMouseOver() : Boolean
      {
         return includesMouse();
      }
      
      override public function get height() : Number
      {
         return scroll.height;
      }
      
      public function clear() : void
      {
         uiContainer.disposeAllChilds();
         init();
      }
      
      override public function set height(param1:Number) : void
      {
         scroll.height = param1;
         maskShape.graphics.clear();
         maskShape.graphics.beginFill(0,0);
         maskShape.graphics.drawRect(0,0,initWidth,param1);
         maskShape.height = param1;
         initHeight = param1;
         init();
      }
   }
}

