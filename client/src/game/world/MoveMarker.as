package game.world
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class MoveMarker
   {
      
      private var sprite5:Sprite;
      
      private var sprite3:Sprite;
      
      public function MoveMarker(param1:Sprite)
      {
         super();
         this.sprite5 = param1;
         this.sprite3 = new Sprite();
         this.sprite3.mouseChildren = this.sprite3.mouseEnabled = false;
         this.sprite3.cacheAsBitmap = true;
      }
      
      public static function doAction514(graphics:Graphics, i:Number, j:Number, color:int, alpha:Number) : void
      {
         var point:NPoint = WorldItem.getNPoint7(i,j);
         graphics.beginFill(color,alpha);
         graphics.drawCircle(point.x,point.y,2);
      }
      
      public static function doAction811(graphics:Graphics, bounds:Rectangle, lineColor:uint = 16711680, fillColor:uint = 65280, fillAlpha:Number = 0, inset:int = 0, lineWidth:int = 1) : void
      {
         var point:NPoint = null;
         if(fillAlpha > 0)
         {
            graphics.beginFill(fillColor,fillAlpha);
         }
         graphics.lineStyle(lineWidth,lineColor,1);
         point = WorldItem.getNPoint7(bounds.y,bounds.x);
         graphics.moveTo(point.x,point.y);
         point = WorldItem.getNPoint7(bounds.y + bounds.height,bounds.x);
         point.x -= inset;
         point.y -= inset;
         graphics.lineTo(point.x,point.y);
         point = WorldItem.getNPoint7(bounds.y + bounds.height,bounds.x + bounds.width);
         point.x -= 2 * inset;
         graphics.lineTo(point.x,point.y);
         point = WorldItem.getNPoint7(bounds.y,bounds.x + bounds.width);
         point.x -= inset;
         point.y += inset;
         graphics.lineTo(point.x,point.y);
         point = WorldItem.getNPoint7(bounds.y,bounds.x);
         graphics.lineTo(point.x,point.y);
         if(fillAlpha > 0)
         {
            graphics.endFill();
         }
      }
      
      public static function doAction208(graphics:Graphics, bounds:Rectangle, lineColor:uint = 16711680, fillColor:uint = 65280, fillAlpha:Number = 0, inset:int = 0, lineWidth:int = 1) : void
      {
         if(fillAlpha > 0)
         {
            graphics.beginFill(fillColor,fillAlpha);
         }
         graphics.lineStyle(lineWidth,lineColor,1);
         var offset:int = 0;
         while(offset <= bounds.height)
         {
            doAction532(graphics,bounds.x,bounds.y + offset);
            doAction31(graphics,bounds.x + bounds.width,bounds.y + offset);
            offset++;
         }
         offset = 0;
         while(offset <= bounds.width)
         {
            doAction532(graphics,bounds.x + offset,bounds.y);
            doAction31(graphics,bounds.x + offset,bounds.y + bounds.height);
            offset++;
         }
         if(fillAlpha > 0)
         {
            graphics.endFill();
         }
      }
      
      public static function doAction31(graphics:Graphics, x:int, y:int) : void
      {
         var point:NPoint = null;
         point = WorldItem.getNPoint7(y,x);
         graphics.lineTo(point.x,point.y);
      }
      
      public static function doAction532(graphics:Graphics, x:int, y:int) : void
      {
         var point:NPoint = null;
         point = WorldItem.getNPoint7(y,x);
         graphics.moveTo(point.x,point.y);
      }
      
      public function doAction564(param1:Number, param2:Number, param3:int = 16711680, param4:Number = 1) : void
      {
      }
      
      public function doAction177(param1:Rectangle, param2:int = 16711680, param3:int = 65280, param4:Number = 0) : void
      {
      }
      
      public function doAction862(param1:Rectangle, param2:uint = 0) : void
      {
      }
      
      public function clear() : void
      {
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
      }
      
      public function doAction417(param1:Number, param2:Number) : void
      {
      }
      
      public function get propValue168() : Sprite
      {
         return this.sprite3;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(this.sprite3)
         {
            this.sprite3.visible = param1;
         }
      }
      
      public function get visible() : Boolean
      {
         return this.sprite3 && this.sprite3.visible;
      }
   }
}

