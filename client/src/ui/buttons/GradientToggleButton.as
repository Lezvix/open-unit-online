package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GradientToggleButton extends ToggleButton
   {
      
      private static const H:int = 18;
      
      private static const MIN_WIDTH:int = H * 4;
      
      private static const EDGE_COLORS:Vector.<uint> = new <uint>[4279769112,4280887327,4282400042,4284241975,4286281030,4288385876,4290424674,4292266349,4293778805,4294896249,4294962031,4294957906,4294622515,4293634338,4292582172,4291202074];
      
      private static const LINE_COLORS:Array = [6638099,6638099,4075020,1051907,657154,1774340,4206347,5586447];
      
      public function GradientToggleButton(clickHandler:Function, label:String, buttonWidth:int = 0)
      {
         var textField:TextField = null;
         textField = new TextField();
         textField.height = H;
         textField.defaultTextFormat = new TextFormat("Verdana",10,11701053,true,null,null,null,null,TextFormatAlign.CENTER);
         textField.text = label;
         textField.y = 1;
         buttonWidth = Math.max(MIN_WIDTH,buttonWidth == 0 ? 40 + textField.textWidth : buttonWidth);
         textField.width = buttonWidth;
         var border:Bitmap = new Bitmap(new BitmapData(buttonWidth,H,true,0));
         border.bitmapData.setVector(new Rectangle(0,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setVector(new Rectangle(buttonWidth - 1,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setPixel32(1,H - 2,4289822234);
         border.bitmapData.setPixel32(buttonWidth - 2,H - 2,4289822234);
         border.bitmapData.fillRect(new Rectangle(2,H - 1,buttonWidth - 4,1),4288573978);
         var normalSprite:Sprite = new Sprite();
         normalSprite.graphics.lineStyle(1);
         var i:int = 0;
         while(i < LINE_COLORS.length)
         {
            this.line(normalSprite,0,1 + i * 2,buttonWidth,LINE_COLORS[i]);
            i++;
         }
         normalSprite.addChild(border);
         normalSprite.addChild(textField);
         bitmaps(border.bitmapData);
         textField = new TextField();
         textField.height = H;
         textField.defaultTextFormat = new TextFormat("Verdana",10,16773228,true,null,null,null,null,TextFormatAlign.CENTER);
         textField.text = label;
         textField.y = 1;
         textField.width = buttonWidth;
         border = new Bitmap(new BitmapData(buttonWidth,H,true,0));
         border.bitmapData.setVector(new Rectangle(0,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setVector(new Rectangle(buttonWidth - 1,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setPixel32(1,H - 2,4289822234);
         border.bitmapData.setPixel32(buttonWidth - 2,H - 2,4289822234);
         border.bitmapData.fillRect(new Rectangle(2,H - 1,buttonWidth - 4,1),4288573978);
         var overSprite:Sprite = new Sprite();
         overSprite.graphics.lineStyle(1);
         i = 0;
         while(i < LINE_COLORS.length)
         {
            this.line(overSprite,0,1 + i * 2,buttonWidth,LINE_COLORS[i]);
            i++;
         }
         overSprite.addChild(border);
         overSprite.addChild(textField);
         bitmaps(border.bitmapData);
         textField = new TextField();
         textField.height = H;
         textField.defaultTextFormat = new TextFormat("Verdana",10,16773228,true,null,null,null,null,TextFormatAlign.CENTER);
         textField.text = label;
         textField.y = 1;
         textField.filters = [new GlowFilter(16761115,0.3,5,5,4,BitmapFilterQuality.HIGH,false)];
         textField.width = buttonWidth;
         border = new Bitmap(new BitmapData(buttonWidth,H,true,0));
         border.bitmapData.setVector(new Rectangle(0,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setVector(new Rectangle(buttonWidth - 1,0,1,H - 2),EDGE_COLORS);
         border.bitmapData.setPixel32(1,H - 2,4289822234);
         border.bitmapData.setPixel32(buttonWidth - 2,H - 2,4289822234);
         border.bitmapData.fillRect(new Rectangle(2,H - 1,buttonWidth - 4,1),4288573978);
         var pressedSprite:Sprite = new Sprite();
         pressedSprite.graphics.lineStyle(1);
         i = 0;
         while(i < LINE_COLORS.length)
         {
            this.line(pressedSprite,0,1 + i * 2,buttonWidth,LINE_COLORS[i]);
            i++;
         }
         pressedSprite.addChild(border);
         pressedSprite.addChild(textField);
         bitmaps(border.bitmapData);
         super(clickHandler,normalSprite,overSprite,pressedSprite,overSprite);
      }
      
      private function line(target:Sprite, posX:int, posY:int, lineWidth:int, color:uint) : void
      {
         var matrix:Matrix = new Matrix();
         matrix.createGradientBox(lineWidth,1,0,posX,posY);
         target.graphics.lineGradientStyle(GradientType.LINEAR,[color,color,color],[0,1,0],[0,127,255],matrix);
         target.graphics.moveTo(posX,posY);
         target.graphics.lineTo(posX + lineWidth,posY);
      }
   }
}

