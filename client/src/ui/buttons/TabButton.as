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
   
   public class TabButton extends NButton
   {
      
      [Embed(source="/assets/TabButton_IMG_12.png")]
      
      private static const IMG_12:Class;
      
      [Embed(source="/assets/CommonButton_IMG_9.png")]
      
      private static const IMG_9:Class;
      
      [Embed(source="/assets/CommonButton_IMG_11.png")]
      
      private static const IMG_11:Class;
      
      [Embed(source="/assets/TabButton_IMG_35.png")]
      
      private static const IMG_35:Class;
      
      [Embed(source="/assets/TabButton_IMG_20.png")]
      
      private static const IMG_20:Class;
      
      [Embed(source="/assets/TabButton_IMG_7.png")]
      
      private static const IMG_7:Class;
      
      private static const normalLeft:Bitmap = new IMG_12();
      
      private static const overLeft:Bitmap = new IMG_9();
      
      private static const pressedLeft:Bitmap = new IMG_11();
      
      private static const normalCenter:Bitmap = new IMG_35();
      
      private static const overCenter:Bitmap = new IMG_20();
      
      private static const pressedCenter:Bitmap = new IMG_7();
      
      private static const normalRight:Bitmap = new Bitmap(Chat.getBitmapData2(normalLeft.bitmapData));
      
      private static const overRight:Bitmap = new Bitmap(Chat.getBitmapData2(overLeft.bitmapData));
      
      private static const pressedRight:Bitmap = new Bitmap(Chat.getBitmapData2(pressedLeft.bitmapData));
      
      private static const BUTTON_HEIGHT:Number = 26;
      
      private static const MIN_WIDTH:Number = BUTTON_HEIGHT * 4;
      
      public static const AUTO:Number = -1;
      
      public function TabButton(label:String, clickHandler:Function, buttonWidth:Number = -1, flipped:Boolean = false)
      {
         var textField:TextField = new TextField();
         textField.height = BUTTON_HEIGHT;
         textField.defaultTextFormat = new TextFormat("Arial",11,13078565,true,null,null,null,null,TextFormatAlign.CENTER);
         textField.text = label;
         var realWidth:Number = Math.max(MIN_WIDTH,buttonWidth == AUTO ? 40 + textField.textWidth : buttonWidth);
         textField.width = realWidth;
         var normalBmp:Bitmap = this.composeBitmap(normalLeft,normalCenter,normalRight,realWidth);
         var overBmp:Bitmap = this.composeBitmap(overLeft,overCenter,overRight,realWidth);
         var pressedBmp:Bitmap = this.composeBitmap(pressedLeft,pressedCenter,pressedRight,realWidth);
         if(flipped)
         {
            oldBmp = normalBmp;
            normalBmp = new Bitmap(Chat.getBitmapData1(normalBmp.bitmapData));
            oldBmp.bitmapData.dispose();
            oldBmp = overBmp;
            overBmp = new Bitmap(Chat.getBitmapData1(overBmp.bitmapData));
            oldBmp.bitmapData.dispose();
            oldBmp = pressedBmp;
            pressedBmp = new Bitmap(Chat.getBitmapData1(pressedBmp.bitmapData));
            oldBmp.bitmapData.dispose();
         }
         bitmaps(normalBmp.bitmapData);
         bitmaps(overBmp.bitmapData);
         bitmaps(pressedBmp.bitmapData);
         var px:int;
         var py:int;
         var matrix:Matrix = new Matrix(1,0,0,1,0,flipped ? 5 : 4);
         var oldBmp:Bitmap;
         textField.textColor = 13078565;
         normalBmp.bitmapData.draw(textField,matrix);
         px = 5;
         while(px < realWidth - 5)
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
         while(px < realWidth - 5)
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
         while(px < realWidth - 5)
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
      
      private function composeBitmap(left:Bitmap, center:Bitmap, right:Bitmap, bmpWidth:Number) : Bitmap
      {
         var result:Bitmap = new Bitmap(new BitmapData(bmpWidth,BUTTON_HEIGHT,true,0));
         result.bitmapData.copyPixels(left.bitmapData,new Rectangle(0,0,BUTTON_HEIGHT,BUTTON_HEIGHT),new Point(0,0));
         result.bitmapData.copyPixels(right.bitmapData,new Rectangle(0,0,BUTTON_HEIGHT,BUTTON_HEIGHT),new Point(bmpWidth - BUTTON_HEIGHT,0));
         var posX:Number = BUTTON_HEIGHT;
         while(posX < bmpWidth - BUTTON_HEIGHT)
         {
            result.bitmapData.copyPixels(center.bitmapData,new Rectangle(0,0,Math.min(BUTTON_HEIGHT,bmpWidth - BUTTON_HEIGHT - posX),BUTTON_HEIGHT),new Point(posX,0));
            posX += BUTTON_HEIGHT;
         }
         return result;
      }
   }
}

