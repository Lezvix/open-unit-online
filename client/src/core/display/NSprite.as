package core.display
{
   import core.ui.IPositionable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class NSprite extends Sprite implements IPositionable
   {
      
      public function NSprite()
      {
         super();
      }
      
      public static function drawRoundRect(param1:Object, param2:int, param3:int, param4:int, param5:int, param6:uint, param7:int = 15, param8:int = 2, param9:uint = 0) : void
      {
         param1.graphics.beginFill(param6);
         param1.graphics.lineStyle(param8,param9);
         param1.graphics.drawRoundRect(param4,param5,param2,param3,param7,param7);
         param1.graphics.endFill();
      }
      
      public static function getBitmap7(source:BitmapData) : Bitmap
      {
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(source.width,0);
         var result:BitmapData = new BitmapData(source.width,source.height,true,0);
         result.draw(source,matrix);
         return new Bitmap(result);
      }
      
      public static function getBitmap1(source:BitmapData) : Bitmap
      {
         var matrix:Matrix = new Matrix();
         matrix.scale(1,-1);
         matrix.translate(0,source.height);
         var result:BitmapData = new BitmapData(source.width,source.height,true,0);
         result.draw(source,matrix);
         return new Bitmap(result);
      }
      
      public function clear() : void
      {
         graphics.clear();
      }
      
      public function doAction141() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function clearAll() : void
      {
         this.clear();
         this.doAction141();
      }
      
      public function dispose() : void
      {
         this.clearAll();
      }
      
      public function fillRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:Number = 1) : void
      {
         graphics.beginFill(param5,param6);
         graphics.drawRect(param1,param2,param3,param4);
         graphics.endFill();
      }
      
      public function drawTile(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function draw(param1:Bitmap, param2:int, param3:int) : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param1.width,param1.height);
         graphics.endFill();
      }
      
      public function doAction344(param1:Bitmap, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false) : void
      {
         graphics.beginBitmapFill(param1.bitmapData,new Matrix(param4 ? -1 : 1,0,0,param5 ? -1 : 1,param2,param3));
         graphics.drawRect(param2,param3,param1.width,param1.height);
         graphics.endFill();
      }
      
      public function doAction336(param1:Bitmap, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:Number) : void
      {
         var matrix:Matrix = new Matrix(param6,0,0,param7,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function drawWithScale(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var scaleX:Number = param4 / param1.width;
         var scaleY:Number = param5 / param1.height;
         var matrix:Matrix = new Matrix(scaleX,0,0,scaleY,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function drawHLine(param1:int, param2:int, param3:int, param4:uint) : void
      {
         graphics.beginFill(param4);
         graphics.drawRect(param1,param2,param3,1);
         graphics.endFill();
      }
      
      public function drawVLine(param1:int, param2:int, param3:int, param4:uint) : void
      {
         graphics.beginFill(param4);
         graphics.drawRect(param1,param2,1,param3);
         graphics.endFill();
      }
      
      public function drawCircle(param1:int, param2:int, param3:int, param4:uint, param5:Number = 1, param6:int = 1) : void
      {
         graphics.lineStyle(param6,param4,param5);
         graphics.drawCircle(param1,param2,param3);
      }
      
      public function doAction363(param1:int, param2:int, param3:int, param4:uint, param5:Number = 1) : void
      {
         graphics.beginFill(param4,param5);
         graphics.drawCircle(param1,param2,param3);
         graphics.endFill();
      }
      
      public function drawRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:Number = 1, param7:int = 1) : void
      {
         graphics.lineStyle(param7,param5,param6);
         graphics.drawRect(param1,param2,param3,param4);
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
   }
}

