package core.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BmpTextField extends Bitmap
   {
      
      protected var sourceBitmap:BitmapData;
      
      protected var letters:String;
      
      protected var text:String;
      
      protected var letterSpacing:int;
      
      private var letterPos:Array = new Array();
      
      public function BmpTextField(fieldWidth:int, fieldHeight:int, bitmap:Bitmap, letters:String, letterSpacing:int = 0)
      {
         var pixel:uint;
         super(new BitmapData(fieldWidth,fieldHeight));
         this.letterSpacing = letterSpacing;
         this.sourceBitmap = bitmap.bitmapData;
         this.letters = letters;
         this.letterPos.push(0);
         var column:int = 0;
         while(column < this.sourceBitmap.width)
         {
            pixel = this.sourceBitmap.getPixel32(column,0);
            if((pixel >> 16 & 0xFF) == 255 && (pixel & 0xFF) == 255)
            {
               this.letterPos.push(column + 1);
            }
            column++;
         }
      }
      
      public function setText(value:String) : void
      {
         if(value != this.text)
         {
            this.text = value;
            this.draw();
         }
      }
      
      private function draw() : void
      {
         bitmapData.fillRect(new Rectangle(0,0,width,height),0);
         var letterIndex:int = 0;
         var letterWidth:int;
         var posX:int = 0;
         var textIndex:int = 0;
         while(textIndex < this.text.length)
         {
            letterIndex = 0;
            while(letterIndex < this.letters.length && this.letters.charAt(letterIndex) != this.text.charAt(textIndex))
            {
               letterIndex++;
            }
            if(letterIndex < this.letters.length)
            {
               if(letterIndex == this.letters.length - 1)
               {
                  letterWidth = this.sourceBitmap.width - this.letterPos[letterIndex];
               }
               else
               {
                  letterWidth = this.letterPos[letterIndex + 1] - this.letterPos[letterIndex] - 1;
               }
               bitmapData.copyPixels(this.sourceBitmap,new Rectangle(this.letterPos[letterIndex],0,letterWidth,this.sourceBitmap.height),new Point(posX,0));
               posX += letterWidth + this.letterSpacing;
            }
            textIndex++;
         }
      }
   }
}

