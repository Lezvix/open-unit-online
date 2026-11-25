package ui
{
   import core.ui.NScrollBar;
   
   public class NuclearScrollBar extends NScrollBar
   {
      
      [Embed(source="/assets/NuclearScrollBar_IMG_3.png")]
      
      private static const IMG_3:Class;
      
      [Embed(source="/assets/NuclearScrollBar_IMG_23.png")]
      
      private static const IMG_23:Class;
      
      [Embed(source="/assets/NuclearScrollBar_IMG_22.png")]
      
      private static const IMG_22:Class;
      
      [Embed(source="/assets/NuclearScrollBar_IMG_13.png")]
      
      private static const IMG_13:Class;
      
      [Embed(source="/assets/NuclearScrollBar_IMG_18.png")]
      
      private static const IMG_18:Class;
      
      [Embed(source="/assets/NuclearScrollBar_IMG_33.png")]
      
      private static const IMG_33:Class;
      
      public function NuclearScrollBar(param1:int)
      {
         super(param1,new IMG_33(),new IMG_18(),new IMG_13(),new IMG_23(),new IMG_3(),new IMG_22());
      }
      
      override public function dispose() : void
      {
         upBmp.bitmapData.dispose();
         midBmp.bitmapData.dispose();
         downBmp.bitmapData.dispose();
         btnUpBmp.bitmapData.dispose();
         btnMidBmp.bitmapData.dispose();
         btnDownBmp.bitmapData.dispose();
         super.dispose();
      }
      
      override public function get cursorId() : int
      {
         return GameCursor.CURSOR_1;
      }
      
      override public function set height(param1:Number) : void
      {
         updateHeight(param1);
         drawButton();
         updateScrollPos();
         super.height = param1;
      }
   }
}

