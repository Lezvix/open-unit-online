package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.Chat;
   
   public class CommonButton extends NButton
   {
      
      [Embed(source="/assets/TabButton_IMG_12.png")]
      
      private static const IMG_12:Class;
      
      [Embed(source="/assets/CommonButton_IMG_9.png")]
      
      private static const IMG_9:Class;
      
      [Embed(source="/assets/CommonButton_IMG_11.png")]
      
      private static const IMG_11:Class;
      
      private static const normalLeft:Bitmap = new IMG_12();
      
      private static const overLeft:Bitmap = new IMG_9();
      
      private static const pressedLeft:Bitmap = new IMG_11();
      
      private static const normalRight:Bitmap = new Bitmap(Chat.getBitmapData2(normalLeft.bitmapData));
      
      private static const overRight:Bitmap = new Bitmap(Chat.getBitmapData2(overLeft.bitmapData));
      
      private static const pressedRight:Bitmap = new Bitmap(Chat.getBitmapData2(pressedLeft.bitmapData));
      
      private static const BUTTON_HEIGHT:Number = 26;
      
      private static const WIDTH:Number = BUTTON_HEIGHT * 2;
      
      public function CommonButton(label:String, clickHandler:Function)
      {
         var textField:TextField = new TextField();
         textField.height = BUTTON_HEIGHT;
         textField.defaultTextFormat = new TextFormat("Arial",11,13078565,true,null,null,null,null,TextFormatAlign.CENTER);
         textField.text = label;
         textField.width = WIDTH;
         var normalBmp:Bitmap = this.composeBitmap(normalLeft,normalRight);
         var overBmp:Bitmap = this.composeBitmap(overLeft,overRight);
         var pressedBmp:Bitmap = this.composeBitmap(pressedLeft,pressedRight);
         var px:int;
         var py:int;
         var matrix:Matrix = new Matrix(1,0,0,1,0,4);
         textField.textColor = 13078565;
         normalBmp.bitmapData.draw(textField,matrix);
         px = 5;
         while(px < WIDTH - 5)
         {
            py = 4;
            while(py < BUTTON_HEIGHT - 4)
            {
               if(normalBmp.bitmapData.getPixel(px,py) == 13078565)
               {
                  normalBmp.bitmapData.setPixel(px,py,14266157);
               }
               py += 2;
            }
            px++;
         }
         textField.textColor = 16776066;
         textField.filters = [new GlowFilter(14266157,0.25,5,5,3,BitmapFilterQuality.HIGH,false,true)];
         overBmp.bitmapData.draw(textField,matrix);
         textField.filters = null;
         overBmp.bitmapData.draw(textField,matrix);
         px = 5;
         while(px < WIDTH - 5)
         {
            py = 4;
            while(py < BUTTON_HEIGHT - 4)
            {
               if(overBmp.bitmapData.getPixel(px,py) == 16776066)
               {
                  overBmp.bitmapData.setPixel(px,py,16776350);
               }
               py += 2;
            }
            px++;
         }
         textField.textColor = 15841094;
         pressedBmp.bitmapData.draw(textField,matrix);
         px = 5;
         while(px < WIDTH - 5)
         {
            py = 4;
            while(py < BUTTON_HEIGHT - 4)
            {
               if(pressedBmp.bitmapData.getPixel(px,py) == 15841094)
               {
                  pressedBmp.bitmapData.setPixel(px,py,16174677);
               }
               py += 2;
            }
            px++;
         }
         super(clickHandler,normalBmp,overBmp,pressedBmp);
      }
      
      private function composeBitmap(left:Bitmap, right:Bitmap) : Bitmap
      {
         var result:Bitmap = new Bitmap(new BitmapData(WIDTH,BUTTON_HEIGHT,true,0));
         result.bitmapData.copyPixels(left.bitmapData,new Rectangle(0,0,BUTTON_HEIGHT,BUTTON_HEIGHT),new Point(0,0));
         result.bitmapData.copyPixels(right.bitmapData,new Rectangle(0,0,BUTTON_HEIGHT,BUTTON_HEIGHT),new Point(WIDTH - BUTTON_HEIGHT,0));
         bitmaps(result.bitmapData);
         return result;
      }
   }
}

