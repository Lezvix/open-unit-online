package ui
{
   import core.resources.Localization;
   import core.ui.UIComponent;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.geom.Matrix;
   import game.Chat;
   
   public class NUIComponent extends UIComponent
   {
      
      [Embed(source="/assets/NUIComponent_FRAME_LEFT_TOP2.png")]
      
      private static const FRAME_LEFT_TOP2:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_RIGHT_TOP2.png")]
      
      private static const FRAME_RIGHT_TOP2:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_TOP2.png")]
      
      private static const FRAME_TOP2:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_TOP.png")]
      
      private static const FRAME_TOP:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_LEFT.png")]
      
      private static const FRAME_LEFT:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_LEFT_BOTTOM2.png")]
      
      private static const FRAME_LEFT_BOTTOM2:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_LEFT_BOTTOM.png")]
      
      private static const FRAME_LEFT_BOTTOM:Class;
      
      [Embed(source="/assets/NUIComponent_FRAME_BOTTOM.png")]
      
      private static const FRAME_BOTTOM:Class;
      
      [Embed(source="/assets/NUIComponent_IMG_10.png")]
      
      private static var IMG_10:Class;
      
      [Embed(source="/assets/NUIComponent_LINE.png")]
      
      public static var LINE:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_DL.png")]
      
      public static var RAM_DL:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_DR.png")]
      
      public static var RAM_DR:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_SIDE.png")]
      
      public static var RAM_SIDE:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_TOP.png")]
      
      public static var RAM_TOP:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_UL.png")]
      
      public static var RAM_UL:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_UR.png")]
      
      public static var RAM_UR:Class;
      
      [Embed(source="/assets/ItemSlot_IMG_2.png")]
      
      private static const RAM_BOTTOM:Class;
      
      protected static const frameLeftTop:Bitmap = new FRAME_LEFT_TOP2();
      
      protected static const frameLeft:Bitmap = new FRAME_TOP();
      
      protected static const frameLeftBottom:Bitmap = new FRAME_LEFT_BOTTOM2();
      
      protected static const frameTop:Bitmap = new FRAME_TOP2();
      
      protected static const frameBottom:Bitmap = new FRAME_LEFT_BOTTOM();
      
      protected static const frameRightTop:Bitmap = new FRAME_RIGHT_TOP2();
      
      protected static const frameRight:Bitmap = new FRAME_LEFT();
      
      protected static const frameRightBottom:Bitmap = new FRAME_BOTTOM();
      
      protected static const slotBmp:Bitmap = new RAM_BOTTOM();
      
      protected static var bitmap16:Bitmap = new IMG_10();
      
      public function NUIComponent()
      {
         super();
      }
      
      public static function formatString(param1:String, ... rest) : String
      {
         return Chat.prepareText(rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1));
      }
      
      public static function _(param1:String, ... rest) : String
      {
         return rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1);
      }
      
      public static function getString11(param1:String, param2:Array) : String
      {
         return _.apply(null,[param1].concat(param2));
      }
      
      protected static function getString29(param1:String, ... rest) : String
      {
         var localizedText:String = rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1);
         return localizedText.charAt(0).toLocaleUpperCase() + localizedText.slice(1);
      }
      
      public function get isMouseOver() : Boolean
      {
         return includesMouse();
      }
      
      public function tutorHighligt(param1:int) : void
      {
      }
      
      public function fillBg(param1:int, param2:int, param3:int, param4:int, param5:Number = 1) : void
      {
         graphics.beginFill(1776411,param5);
         graphics.drawRect(param1,param2,param3,param4);
         graphics.endFill();
      }
      
      override public function drawRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:Number = 1, param7:int = 1) : void
      {
         super.drawRect(param1,param2,param3,param4,param5,param6,param7);
         graphics.lineStyle();
      }
      
      override public function drawHLine(param1:int, param2:int, param3:int, param4:uint) : void
      {
         super.drawHLine(param1,param2,param3,param4);
         graphics.lineStyle();
      }
      
      public function drawFrame(param1:int, param2:int, param3:int, param4:int) : void
      {
         draw(frameLeftTop,param1,param2);
         drawTile(frameLeft,param1,param2 + frameLeftTop.height,frameLeft.width,param4 - frameLeftTop.height - frameLeftBottom.height);
         draw(frameLeftBottom,param1,param2 + param4 - frameLeftBottom.height);
         drawTile(frameTop,param1 + frameLeftTop.width,param2,param3 - frameLeftTop.width - frameRightTop.width,frameTop.height);
         draw(frameRightTop,param1 + param3 - frameRightTop.width,param2);
         drawTile(frameRight,param1 + param3 - frameRight.width,param2 + frameRightTop.height,frameRight.width,param4 - frameRightTop.height - frameRightBottom.height);
         drawTile(frameBottom,param1 + frameLeftBottom.width,param2 + param4 - frameBottom.height,param3 - frameLeftBottom.width - frameRightBottom.width,frameBottom.height);
         draw(frameRightBottom,param1 + param3 - frameRightBottom.width,param2 + param4 - frameRightBottom.height);
      }
      
      public function doAction151(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:Number = 1, param7:Number = 1) : void
      {
         var gradientMatrix:Matrix = new Matrix();
         gradientMatrix.createGradientBox(1,param3,Math.PI / 2,param1,param2);
         graphics.lineStyle();
         graphics.beginGradientFill(GradientType.LINEAR,[param4,param5],[param6,param7],[0,255],gradientMatrix);
         graphics.drawRect(param1,param2,1,param3);
         graphics.endFill();
      }
      
      public function getBitmap5(param1:String) : Bitmap
      {
         var bitmap:Bitmap = getBmp(param1);
         bitmap.scaleX = -1;
         return bitmap;
      }
      
      public function doAction289(param1:int, param2:int, param3:int, param4:int, param5:uint) : void
      {
         graphics.lineStyle(1,param5);
         graphics.moveTo(param1,param2);
         graphics.lineTo(param3,param4);
         graphics.lineStyle();
      }
      
      public function doAction487(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:Number = 1, param7:Number = 1) : void
      {
         var gradientMatrix:Matrix = new Matrix();
         gradientMatrix.createGradientBox(param3,1,0,param1,param2);
         graphics.lineStyle();
         graphics.beginGradientFill(GradientType.LINEAR,[param4,param5],[param6,param7],[0,255],gradientMatrix);
         graphics.drawRect(param1,param2,param3,1);
         graphics.endFill();
      }
      
      public function doAction53(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:Number = 1, param7:Number = 1) : void
      {
         this.doAction487(param1,param2,param3 / 2,param4,param5,param6,param7);
         this.doAction487(param1 + param3 / 2,param2,param3 / 2,param5,param4,param7,param6);
      }
      
      public function doAction297(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:Number = 1, param7:Number = 1) : void
      {
         this.doAction151(param1,param2,param3 / 2,param4,param5,param6,param7);
         this.doAction151(param1,param2 + param3 / 2,param3 / 2,param5,param4,param7,param6);
      }
      
      public function ndrawRoundRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:int) : void
      {
         graphics.lineStyle(1,param5);
         graphics.drawRoundRect(param1,param2,param3,param4,param6 * 2,param6 * 2);
      }
   }
}

