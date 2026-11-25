package core.ui.views
{
   import core.resources.ResourceManager;
   import core.ui.UIElement;
   import flash.display.Bitmap;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class Picture extends UIElement
   {
      
      public static const PICTURE_CONST6:int = 0;
      
      public static const PICTURE_CONST12:int = 1;
      
      public static const PICTURE_CONST10:int = 2;
      
      public static const LEFT:int = 3;
      
      public static const CENTER:int = 4;
      
      public static const RIGHT:int = 5;
      
      public static const PICTURE_CONST4:int = 6;
      
      public static const PICTURE_CONST11:int = 7;
      
      public static const PICTURE_CONST8:int = 8;
      
      public static const PICTURE_CONST9:int = 9;
      
      public static const PICTURE_CONST1:int = 10;
      
      public static const PICTURE_CONST5:int = 11;
      
      public static const PICTURE_CONST3:int = 12;
      
      public static const PICTURE_CONST7:int = 13;
      
      public static const PICTURE_CONST2:int = 14;
      
      private var _bitmap:Bitmap;
      
      private var _flipHorizontally:Boolean = false;
      
      private var _flipVertically:Boolean = false;
      
      private var _leftPadding:int;
      
      private var _rightPadding:int;
      
      private var _topPadding:int;
      
      private var _bottomPadding:int;
      
      private var intValue192:int;
      
      private var flag43:Boolean;
      
      public function Picture(param1:Boolean = true)
      {
         super();
         this.flag43 = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         if(numValue39 != param1)
         {
            super.width = param1;
            this.doAction316();
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_height != param1)
         {
            super.height = param1;
            this.doAction316();
         }
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
         if(numValue39 != param1 || _height != param2)
         {
            super.setActualSize(param1,param2);
            this.doAction316();
         }
      }
      
      public function get flipHorizontaly() : Boolean
      {
         return this._flipHorizontally;
      }
      
      public function get flipVerticaly() : Boolean
      {
         return this._flipVertically;
      }
      
      public function set flipHorizontaly(param1:Boolean) : void
      {
         if(this._flipHorizontally != param1)
         {
            _flipHorizontally = param1;
            this.doAction316();
         }
      }
      
      public function set flipVerticaly(param1:Boolean) : void
      {
         if(this._flipVertically != param1)
         {
            _flipVertically = param1;
            this.doAction316();
         }
      }
      
      public function get leftPadding() : int
      {
         return this._leftPadding;
      }
      
      public function set leftPadding(param1:int) : void
      {
         if(this._leftPadding != param1)
         {
            _leftPadding = param1;
            this.doAction316();
         }
      }
      
      public function get rightPadding() : int
      {
         return this._rightPadding;
      }
      
      public function set rightPadding(param1:int) : void
      {
         if(this._rightPadding != param1)
         {
            _rightPadding = param1;
            this.doAction316();
         }
      }
      
      public function get topPadding() : int
      {
         return this._topPadding;
      }
      
      public function set topPadding(param1:int) : void
      {
         if(this._topPadding != param1)
         {
            _topPadding = param1;
            this.doAction316();
         }
      }
      
      public function get bottomPadding() : int
      {
         return this._bottomPadding;
      }
      
      public function set bottomPadding(param1:int) : void
      {
         if(this._bottomPadding != param1)
         {
            _bottomPadding = param1;
            this.doAction316();
         }
      }
      
      public function get mode() : int
      {
         return this.intValue192;
      }
      
      public function set mode(param1:int) : void
      {
         if(this.intValue192 != param1)
         {
            intValue192 = param1;
            this.doAction316();
         }
      }
      
      public function get isValue28() : Boolean
      {
         return this.flag43;
      }
      
      public function set isValue28(param1:Boolean) : void
      {
         if(this.flag43 != param1)
         {
            flag43 = param1;
            this.doAction316();
         }
      }
      
      public function doAction439(param1:int, param2:int, param3:int, param4:int) : void
      {
         _leftPadding = param4;
         _rightPadding = param2;
         _topPadding = param1;
         _bottomPadding = param3;
         this.doAction316();
      }
      
      public function doAction549(param1:String) : void
      {
         this.doAction585(param1);
         this.doAction316();
      }
      
      public function doAction631(param1:Bitmap) : void
      {
         this.doAction492();
         _bitmap = param1;
         this.doAction316();
      }
      
      public function clear() : void
      {
         this.doAction549(null);
      }
      
      private function doAction492() : void
      {
         if(this._bitmap)
         {
            this._bitmap.bitmapData.dispose();
            _bitmap = null;
         }
      }
      
      private function doAction585(id:String) : void
      {
         this.doAction492();
         if(id)
         {
            try
            {
               _bitmap = ResourceManager.sharedInstance.getBmp(uiPackId,id);
            }
            catch(err:Error)
            {
               trace(err);
            }
         }
      }
      
      override public function dispose() : void
      {
         this.doAction492();
         super.dispose();
      }
      
      public function doAction316() : void
      {
         var bitmapWidth:int;
         var bitmapHeight:int;
         var remainingWidth:int;
         var centerX:int;
         var remainingHeight:int;
         var centerY:int;
         var scaledWidth:int;
         var scaledHeight:int;
         var scale:Number;
         graphics.clear();
         if(this._bitmap && width > 0 && height > 0)
         {
            bitmapWidth = this._bitmap.width;
            bitmapHeight = this._bitmap.height;
            remainingWidth = width - bitmapWidth;
            centerX = remainingWidth / 2;
            remainingHeight = height - bitmapHeight;
            centerY = remainingHeight / 2;
            switch(this.intValue192)
            {
               case PICTURE_CONST6:
                  this.draw(this._bitmap);
                  break;
               case PICTURE_CONST12:
                  this.draw(this._bitmap,centerX,0);
                  break;
               case PICTURE_CONST10:
                  this.draw(this._bitmap,remainingWidth,0);
                  break;
               case LEFT:
                  this.draw(this._bitmap,0,centerY);
                  break;
               case CENTER:
                  this.draw(this._bitmap,centerX,centerY);
                  break;
               case RIGHT:
                  this.draw(this._bitmap,remainingWidth,centerY);
                  break;
               case PICTURE_CONST4:
                  this.draw(this._bitmap,0,remainingHeight);
                  break;
               case PICTURE_CONST11:
                  this.draw(this._bitmap,centerX,remainingHeight);
                  break;
               case PICTURE_CONST8:
                  this.draw(this._bitmap,remainingWidth,remainingHeight);
                  break;
               case PICTURE_CONST7:
                  this.drawTile(this._bitmap,0,0,width,height);
                  break;
               case PICTURE_CONST2:
                  if(!this._leftPadding && !this._rightPadding && !this._topPadding && !this._bottomPadding)
                  {
                     this.drawWithScale(this._bitmap,0,0,width,height);
                  }
                  else
                  {
                     this.doAction886(this._bitmap);
                  }
                  break;
               case PICTURE_CONST9:
                  this.drawWithScale(this._bitmap,0,0,width,height);
                  break;
               case PICTURE_CONST1:
                  scale = height / bitmapHeight;
                  scaledWidth = scale * bitmapWidth;
                  this.drawWithScale(this._bitmap,(width - scaledWidth) / 2,0,scaledWidth,height);
                  break;
               case PICTURE_CONST5:
                  scale = width / bitmapWidth;
                  scaledHeight = scale * bitmapHeight;
                  this.drawWithScale(this._bitmap,0,(height - scaledHeight) / 2,width,scaledHeight);
                  break;
               case PICTURE_CONST3:
                  scale = height / bitmapHeight;
                  scaledWidth = scale * bitmapWidth;
                  if(scaledWidth > width)
                  {
                     scale = width / bitmapWidth;
                     scaledHeight = scale * bitmapHeight;
                     this.drawWithScale(this._bitmap,0,(height - scaledHeight) / 2,width,scaledHeight);
                  }
                  else
                  {
                     this.drawWithScale(this._bitmap,(width - scaledWidth) / 2,0,scaledWidth,height);
                  }
                  break;
               default:
                  break;
            }
         }
      }
      
      private function doAction886(param1:Bitmap) : void
      {
         var innerRect:Rectangle = new Rectangle();
         innerRect.left = Math.max(this._leftPadding,0);
         innerRect.top = Math.max(this._topPadding,0);
         innerRect.width = Math.min(param1.width - innerRect.left,param1.width - innerRect.left - Math.max(this._rightPadding,0));
         innerRect.height = Math.min(param1.height - innerRect.top,param1.height - innerRect.top - Math.max(this._bottomPadding,0));
         doAction850(param1,new Rectangle(0,0,width,height),innerRect,this.flag43);
      }
      
      override public function drawTile(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var tileWidth:int = param1.width + this._leftPadding + this._rightPadding;
         var tileHeight:int = param1.height + this._topPadding + this._bottomPadding;
         var columnCount:int = tileWidth > 0 ? param4 / tileWidth : 0;
         var rowCount:int = tileHeight > 0 ? param5 / tileHeight : 0;
         if(rowCount == 0 || columnCount == 0)
         {
            return;
         }
         var startX:int = param2 + this._leftPadding + (param4 - columnCount * tileWidth) / 2;
         var startY:int = param3 + this._topPadding + (param5 - rowCount * tileHeight) / 2;
         var matrix:Matrix = new Matrix(this._flipHorizontally ? -1 : 1,0,0,this._flipVertically ? -1 : 1);
         var row:int = 0;
         var column:int;
         while(row < rowCount)
         {
            column = 0;
            while(column < columnCount)
            {
               matrix.tx = startX + column * tileWidth;
               matrix.ty = startY + row * tileHeight;
               graphics.beginBitmapFill(param1.bitmapData,matrix);
               graphics.drawRect(matrix.tx,matrix.ty,param1.width,param1.height);
               column++;
            }
            row++;
         }
         graphics.endFill();
      }
      
      override public function draw(param1:Bitmap, param2:int = 0, param3:int = 0) : void
      {
         doAction344(param1,param2,param3,this._flipHorizontally,this._flipVertically);
      }
      
      override public function drawWithScale(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var horizontalScale:Number = param4 / param1.width;
         if(this._flipHorizontally)
         {
            horizontalScale = -horizontalScale;
         }
         var verticalScale:Number = param5 / param1.height;
         if(this._flipVertically)
         {
            verticalScale = -verticalScale;
         }
         var matrix:Matrix = new Matrix(horizontalScale,0,0,verticalScale,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix,true,this.flag43);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
   }
}

