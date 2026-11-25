package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import ui.NTextFormat;
   
   public class ChannelTabButton extends ChannelButton
   {
      
      [Embed(source="/assets/ChannelTabButton_IMG_12.png")]
      
      private static const IMG_12:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_9.png")]
      
      private static const IMG_9:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_11.png")]
      
      private static const IMG_11:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_35.png")]
      
      private static const IMG_35:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_20.png")]
      
      private static const IMG_20:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_7.png")]
      
      private static const IMG_7:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_17.png")]
      
      private static const IMG_17:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_19.png")]
      
      private static const IMG_19:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_8.png")]
      
      private static const IMG_8:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_25.png")]
      
      private static const IMG_25:Class;
      
      [Embed(source="/assets/ChannelTabButton_IMG_16.png")]
      
      private static const IMG_16:Class;
      
      private static const normalLeft:Bitmap = new IMG_12();
      
      private static const overLeft:Bitmap = new IMG_9();
      
      private static const pressedLeft:Bitmap = new IMG_11();
      
      private static const normalCenter:Bitmap = new IMG_35();
      
      private static const overCenter:Bitmap = new IMG_20();
      
      private static const pressedCenter:Bitmap = new IMG_7();
      
      private static const normalRight:Bitmap = new IMG_17();
      
      private static const overRight:Bitmap = new IMG_19();
      
      private static const pressedRight:Bitmap = new IMG_8();
      
      private static const notifyIcon:Bitmap = new IMG_25();
      
      private static const notifyIconOver:Bitmap = new IMG_16();
      
      private static const BUTTON_HEIGHT:Number = 18;
      
      private static const MIN_WIDTH:Number = 80;
      
      public static const AUTO:Number = -1;
      
      private static const NORMAL:int = 0;
      
      private static const OVER:int = 1;
      
      private static const PRESSED:int = 2;
      
      protected const normalStates:Vector.<Bitmap> = new Vector.<Bitmap>(3);
      
      protected const notifyStates:Vector.<Bitmap> = new Vector.<Bitmap>(3);
      
      public function ChannelTabButton(clickHandler:Function, channel:int, label:String, closeBtn:NButton, buttonWidth:Number = -1)
      {
         var textField:TextField = new TextField();
         textField.height = BUTTON_HEIGHT;
         textField.defaultTextFormat = new NTextFormat({
            "size":11,
            "color":14659647,
            "bold":true
         });
         textField.text = label;
         var realWidth:Number = Math.max(MIN_WIDTH,buttonWidth == AUTO ? textField.textWidth + (closeBtn == null ? 30 : 50) : buttonWidth);
         textField.width = realWidth;
         this.normalStates[NORMAL] = this.composeBitmap(normalLeft,normalCenter,normalRight,realWidth);
         this.normalStates[OVER] = this.composeBitmap(overLeft,overCenter,overRight,realWidth);
         this.normalStates[PRESSED] = this.composeBitmap(pressedLeft,pressedCenter,pressedRight,realWidth);
         this.notifyStates[NORMAL] = this.composeBitmap(normalLeft,normalCenter,normalRight,realWidth);
         this.notifyStates[OVER] = this.composeBitmap(overLeft,overCenter,overRight,realWidth);
         this.notifyStates[PRESSED] = this.composeBitmap(pressedLeft,pressedCenter,pressedRight,realWidth);
         var iconRect:Rectangle = new Rectangle(0,0,notifyIcon.width,notifyIcon.height);
         var iconPos:Point = new Point(2,1);
         this.notifyStates[NORMAL].bitmapData.copyPixels(notifyIcon.bitmapData,iconRect,iconPos,null,null,true);
         this.notifyStates[OVER].bitmapData.copyPixels(notifyIconOver.bitmapData,iconRect,iconPos,null,null,true);
         this.notifyStates[PRESSED].bitmapData.copyPixels(notifyIconOver.bitmapData,iconRect,iconPos,null,null,true);
         var matrix:Matrix = new Matrix(1,0,0,1,3,1);
         this.normalStates[NORMAL].bitmapData.draw(textField,matrix,null,null,null,true);
         this.normalStates[PRESSED].bitmapData.draw(textField,matrix,null,null,null,true);
         textField.textColor = 14668985;
         this.normalStates[OVER].bitmapData.draw(textField,matrix,null,null,null,true);
         matrix = new Matrix(1,0,0,1,16,1);
         textField.textColor = 14659647;
         this.notifyStates[NORMAL].bitmapData.draw(textField,matrix,null,null,null,true);
         this.notifyStates[PRESSED].bitmapData.draw(textField,matrix,null,null,null,true);
         textField.textColor = 14668985;
         this.notifyStates[OVER].bitmapData.draw(textField,matrix,null,null,null,true);
         super(clickHandler,channel,label,closeBtn,this.normalStates[NORMAL],this.normalStates[OVER],this.normalStates[PRESSED],this.normalStates[OVER]);
      }
      
      protected function applyStates(states:Vector.<Bitmap>) : void
      {
         if(upState != states[NORMAL])
         {
            upState = states[NORMAL];
            overState = states[OVER];
            downState = states[PRESSED];
         }
      }
      
      override public function set x(value:Number) : void
      {
         super.x = value;
         if(closeChannelButton != null)
         {
            closeChannelButton.x = value + width - closeChannelButton.width - 2;
         }
      }
      
      override public function set y(value:Number) : void
      {
         super.y = value;
         if(closeChannelButton != null)
         {
            closeChannelButton.y = value + 1;
         }
      }
      
      override public function setNotification() : void
      {
         this.applyStates(this.notifyStates);
      }
      
      override public function resetNotification() : void
      {
         this.applyStates(this.normalStates);
      }
      
      private function composeBitmap(left:Bitmap, center:Bitmap, right:Bitmap, bmpWidth:Number) : Bitmap
      {
         var result:Bitmap = new Bitmap(new BitmapData(bmpWidth,BUTTON_HEIGHT,true,0));
         result.bitmapData.copyPixels(left.bitmapData,new Rectangle(0,0,left.width,BUTTON_HEIGHT),new Point(0,0));
         result.bitmapData.copyPixels(right.bitmapData,new Rectangle(0,0,right.width,BUTTON_HEIGHT),new Point(bmpWidth - right.width,0));
         var posX:Number = left.width;
         while(posX < bmpWidth - right.width)
         {
            result.bitmapData.copyPixels(center.bitmapData,new Rectangle(0,0,Math.min(center.width,bmpWidth - right.width - posX),BUTTON_HEIGHT),new Point(posX,0));
            posX += center.width;
         }
         bitmaps(result.bitmapData);
         return result;
      }
   }
}

