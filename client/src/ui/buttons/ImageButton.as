package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ImageButton extends NButton
   {
      
      [Embed(source="/assets/ImageButton_NORMAL2.png")]
      
      private static const NORMAL2:Class;
      
      [Embed(source="/assets/ImageButton_HIDE_12.png")]
      
      private static const OVER2:Class;
      
      [Embed(source="/assets/ImageButton_HIDE_23.png")]
      
      private static const PRESSED2:Class;
      
      private static const NORMAL:Bitmap = new NORMAL2();
      
      private static const OVER:Bitmap = new OVER2();
      
      private static const PRESSED:Bitmap = new PRESSED2();
      
      public function ImageButton(clickHandler:Function, hint:String = "")
      {
         var normalSprite:Sprite = new Sprite();
         normalSprite.graphics.beginBitmapFill(NORMAL.bitmapData);
         normalSprite.graphics.drawRect(0,0,NORMAL.width,NORMAL.height);
         normalSprite.graphics.endFill();
         var overSprite:Sprite = new Sprite();
         overSprite.graphics.beginBitmapFill(OVER.bitmapData);
         overSprite.graphics.drawRect(0,0,OVER.width,OVER.height);
         overSprite.graphics.endFill();
         var pressedSprite:Sprite = new Sprite();
         pressedSprite.graphics.beginBitmapFill(PRESSED.bitmapData);
         pressedSprite.graphics.drawRect(0,0,PRESSED.width,PRESSED.height);
         pressedSprite.graphics.endFill();
         super(clickHandler,normalSprite,overSprite,pressedSprite,null,hint);
      }
   }
}

