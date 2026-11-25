package core.ui
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class NScrollBar extends UIComponent
   {
      
      public static const SCROLL_VERTICAL:int = 0;
      
      public static const SCROLL_HORIZONTAL:int = 1;
      
      public var scrollOrientation:int = 0;
      
      protected var upBmp:Bitmap;
      
      protected var midBmp:Bitmap;
      
      protected var downBmp:Bitmap;
      
      protected var btnUpBmp:Bitmap;
      
      protected var btnMidBmp:Bitmap;
      
      protected var btnDownBmp:Bitmap;
      
      protected var scrollHeight:int;
      
      protected var scrollPos:int;
      
      protected var maxScrollPos:int;
      
      protected var minScrollPos:int = 0;
      
      public var pageCount:int;
      
      public var scrollChangeHandler:Function = null;
      
      protected var upSprite:Sprite;
      
      private var btnPressed:Boolean = false;
      
      private var mouseStartPos:int;
      
      private var scrollStartV:int;
      
      private var scrollStep:int;
      
      private var realWidth:int;
      
      public var scrollFactor:int = 1;
      
      public function NScrollBar(param1:int, param2:Bitmap, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Bitmap)
      {
         super();
         this.scrollHeight = param1;
         this.upBmp = param2;
         this.midBmp = param3;
         this.downBmp = param4;
         this.btnUpBmp = param5;
         this.btnMidBmp = param6;
         this.btnDownBmp = param7;
         this.upSprite = new Sprite();
         this.doAction458();
         addChild(this.upSprite);
         width = Math.max(param2.width,param3.width,param4.width,param5.width,param6.width,param7.width);
         this.scrollStep = width;
         this.realWidth = param1;
      }
      
      public function updateHeight(param1:int) : void
      {
         scrollHeight = param1;
         this.doAction458();
         realWidth = param1;
      }
      
      public function setHeight(param1:int) : void
      {
         removeChild(this.upBmp);
         removeChild(this.downBmp);
         scrollHeight = param1;
         this.doAction458();
      }
      
      public function setHorizontal() : void
      {
         scrollOrientation = SCROLL_HORIZONTAL;
         rotation = -90;
      }
      
      protected function doAction458() : void
      {
         graphics.clear();
         addChild(this.upBmp);
         if(this.midBmp.bitmapData)
         {
            this.drawBg();
         }
         addChild(this.downBmp);
         this.downBmp.y = this.scrollHeight - this.downBmp.height;
      }
      
      protected function drawBg() : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,(this.upBmp.width - this.midBmp.width) / 2,this.upBmp.height);
         graphics.beginBitmapFill(this.midBmp.bitmapData,matrix);
         graphics.drawRect((this.upBmp.width - this.midBmp.width) / 2,this.upBmp.height,this.midBmp.width,this.scrollHeight - this.upBmp.height - this.downBmp.height);
         graphics.endFill();
      }
      
      protected function drawButton() : void
      {
         var minimumHeight:int = this.btnUpBmp.height + this.btnMidBmp.height + this.btnDownBmp.height;
         var buttonHeight:int;
         var matrix:Matrix;
         this.upSprite.graphics.clear();
         if(this.maxScrollPos > 0)
         {
            this.upSprite.visible = true;
            buttonHeight = this.pageCount * (this.scrollHeight - this.upBmp.height - this.downBmp.height) / (this.maxScrollPos + this.pageCount);
            if(buttonHeight < minimumHeight)
            {
               buttonHeight = minimumHeight;
            }
            this.upSprite.graphics.beginBitmapFill(this.btnUpBmp.bitmapData);
            this.upSprite.graphics.drawRect(0,0,this.btnUpBmp.width,this.btnUpBmp.height);
            this.upSprite.graphics.endFill();
            matrix = new Matrix(1,0,0,1,0,this.btnUpBmp.height);
            this.upSprite.graphics.beginBitmapFill(this.btnMidBmp.bitmapData,matrix);
            this.upSprite.graphics.drawRect(0,this.btnUpBmp.height,this.btnMidBmp.width,buttonHeight - this.btnUpBmp.height - this.btnDownBmp.height);
            this.upSprite.graphics.endFill();
            matrix.ty = buttonHeight - this.btnDownBmp.height;
            this.upSprite.graphics.beginBitmapFill(this.btnDownBmp.bitmapData,matrix);
            this.upSprite.graphics.drawRect(0,buttonHeight - this.btnDownBmp.height,this.btnDownBmp.width,this.btnDownBmp.height);
            this.upSprite.graphics.endFill();
         }
         else
         {
            this.upSprite.visible = false;
         }
      }
      
      public function setScrollProperties(param1:int, param2:int, param3:int, param4:int = 0) : void
      {
         pageCount = param1;
         maxScrollPos = param3;
         if(this.scrollPos > this.maxScrollPos)
         {
            scrollPos = 0;
         }
         this.drawButton();
         this.updateScrollPos();
      }
      
      public function set scrollPosition(param1:int) : void
      {
         this.scrollPos = param1;
         this.updateScrollPos();
      }
      
      protected function updateScrollPos() : void
      {
         this.upSprite.y = this.upBmp.height + int((this.scrollHeight - this.upBmp.height - this.downBmp.height - this.upSprite.height) * this.scrollPos / this.maxScrollPos);
      }
      
      public function get scrollPosition() : int
      {
         return this.scrollPos;
      }
      
      public function get maxScrollPosValue() : int
      {
         return this.maxScrollPos;
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         scrollPos += param1;
         if(this.scrollPos > this.maxScrollPos)
         {
            scrollPos = this.maxScrollPos;
         }
         else if(this.scrollPos < 0)
         {
            scrollPos = 0;
         }
         this.updateScrollPos();
         if(this.scrollChangeHandler != null)
         {
            this.scrollChangeHandler();
         }
      }
      
      override protected function includesMouse() : Boolean
      {
         if(mouseX < this.scrollStep && mouseX >= 0 && mouseY < this.realWidth && mouseY >= 0)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseMoveHandler() : void
      {
         var newScrollPosition:int = 0;
         if(this.btnPressed)
         {
            newScrollPosition = this.scrollStartV + (mouseY - this.mouseStartPos) * this.maxScrollPos / (this.scrollHeight - this.upBmp.height - this.downBmp.height - this.upSprite.height);
            if(newScrollPosition < this.minScrollPos)
            {
               newScrollPosition = this.minScrollPos;
            }
            else if(newScrollPosition > this.maxScrollPos)
            {
               newScrollPosition = this.maxScrollPos;
            }
            if(newScrollPosition != this.scrollPos)
            {
               scrollPos = newScrollPosition;
               this.updateScrollPos();
               if(this.scrollChangeHandler != null)
               {
                  this.scrollChangeHandler();
               }
            }
         }
      }
      
      override public function mouseDownHandler() : void
      {
         if(mouseY < this.upBmp.height)
         {
            scrollPos -= this.scrollFactor;
            if(this.scrollPos < this.minScrollPos)
            {
               scrollPos = this.minScrollPos;
            }
            if(this.scrollChangeHandler != null)
            {
               this.scrollChangeHandler();
            }
            this.updateScrollPos();
         }
         else if(mouseY >= this.scrollHeight - this.downBmp.height)
         {
            scrollPos += this.scrollFactor;
            if(this.scrollPos > this.maxScrollPos)
            {
               scrollPos = this.maxScrollPos;
            }
            if(this.scrollChangeHandler != null)
            {
               this.scrollChangeHandler();
            }
            this.updateScrollPos();
         }
         else if(this.upSprite.visible && this.upSprite.mouseX >= 0 && this.upSprite.mouseY >= 0 && this.upSprite.mouseX < this.upSprite.width && this.upSprite.mouseY < this.upSprite.height)
         {
            btnPressed = true;
            scrollStartV = this.scrollPos;
            mouseStartPos = mouseY;
         }
         super.mouseDownHandler();
      }
      
      override public function mouseUpHandler() : void
      {
         btnPressed = false;
         super.mouseUpHandler();
      }
   }
}

