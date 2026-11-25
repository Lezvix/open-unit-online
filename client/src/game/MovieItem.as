package game
{
   import game.world.WorldObject;
   import game.world.MovieBitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MovieItem extends MovieBitmap
   {
      
      protected static const colorTransform3:ColorTransform = new ColorTransform(2,2,2);
      
      private static var PACKAGES_COUNT:int = 300;
      
      public function MovieItem(param1:WorldObject)
      {
         super(param1);
      }
      
      public static function init() : void
      {
         var index:int = 0;
         while(index < PACKAGES_COUNT)
         {
            packageLoader[index] = new PackageLoader(index);
            packageLoader[index].contentLoaderInfo.addEventListener(Event.COMPLETE,movieLoaded);
            loadedMovies[index] = null;
            firstMovies[index] = null;
            lastMovies[index] = null;
            index++;
         }
      }
      
      public static function movieLoaded(param1:Event) : void
      {
         var loader:PackageLoader = PackageLoader(param1.target.loader);
         var packId:uint = loader.packageId;
         var movie:MovieBitmap;
         loadedMovies[packId] = loader;
         if(firstMovies[packId])
         {
            movie = firstMovies[packId];
            while(movie)
            {
               movie.processLoaded();
               movie = movie.nextMov;
            }
         }
         loader.removeEventListener(Event.COMPLETE,movieLoaded);
      }
      
      override protected function highlightEffect(param1:int) : void
      {
         if(param1 == WorldObject.HIGHLIGHT_1)
         {
            bitmapData.colorTransform(new Rectangle(0,0,bitmapData.width,bitmapData.height),colorTransform3);
         }
      }
      
      override public function highlightNeedRedraw(param1:int) : Boolean
      {
         return param1 != highlight;
      }
      
      public var animationString:String;

      public var hide:int;

      override public function processLoaded() : void
      {
         bitmap = loadedMovies[packageId].getImage(libruaryId);
         this.draw();
      }
      
      public function doAction199(param1:int, param2:int, param3:int, param4:String, param5:Boolean) : void
      {
         packageId = param1;
         libruaryId = param2;
         if(param3 > 0)
         {
            animationCount = param3;
         }
         else
         {
            animationCount = 1;
         }
         this.animationString = param4;
         this.createAnim = param5;
      }
      
      override public function load() : void
      {
         var frameDuration:int = 0;
         var position:int = 0;
         if(loadedMovies[packageId])
         {
            this.processLoaded();
         }
         else if(lastMovies[packageId])
         {
            lastMovies[packageId].nextMov = this;
            prevMov = lastMovies[packageId];
            lastMovies[packageId] = this;
         }
         else
         {
            PackageLoader(packageLoader[packageId]).loadPackage();
            lastMovies[packageId] = this;
            firstMovies[packageId] = this;
         }
         if(this.animationString.length > 0)
         {
            animationNums = new Vector.<int>();
            animationTimes = new Vector.<int>();
            position = 0;
            while(position < this.animationString.length)
            {
               if(this.animationString.charAt(position) >= "a")
               {
                  animationNums.push(int(this.animationString.charCodeAt(position)) - 85);
               }
               else if(this.animationString.charAt(position) >= "A")
               {
                  animationNums.push(int(this.animationString.charCodeAt(position)) - 27);
               }
               else
               {
                  animationNums.push(int(this.animationString.charCodeAt(position)) - 48);
               }
               if(this.animationString.charAt(position + 1) >= "a")
               {
                  frameDuration = int(this.animationString.charCodeAt(position + 1)) - 85 << 6;
               }
               else if(this.animationString.charAt(position + 1) >= "A")
               {
                  frameDuration = int(this.animationString.charCodeAt(position + 1)) - 27 << 6;
               }
               else
               {
                  frameDuration = int(this.animationString.charCodeAt(position + 1)) - 48 << 6;
               }
               if(this.animationString.charAt(position + 2) >= "a")
               {
                  frameDuration |= int(this.animationString.charCodeAt(position + 2)) - 85;
               }
               else if(this.animationString.charAt(position + 2) >= "A")
               {
                  frameDuration |= int(this.animationString.charCodeAt(position + 2)) - 27;
               }
               else
               {
                  frameDuration |= int(this.animationString.charCodeAt(position + 2)) - 48;
               }
               animationTimes.push(frameDuration);
               position += 3;
            }
            curFramesLeft = animationTimes[0];
         }
      }
      
      override public function animate(param1:Boolean, param2:Boolean) : Boolean
      {
         var previousFrame:int = 0;
         if(bitmap != null && animationCount > 1)
         {
            previousFrame = curFrame;
            if(animationNums)
            {
               --curFramesLeft;
               if(curFramesLeft <= 0)
               {
                  if(param2)
                  {
                     if(param1 || curAnim > 0)
                     {
                        --curAnim;
                        if(curAnim < 0)
                        {
                           curAnim = animationNums.length - 1;
                        }
                     }
                  }
                  else if(param1 || curAnim < animationNums.length - 1)
                  {
                     ++curAnim;
                     if(curAnim >= animationNums.length)
                     {
                        curAnim = 0;
                     }
                  }
                  curFramesLeft = animationTimes[curAnim];
                  curFrame = animationNums[curAnim];
               }
            }
            else
            {
               if(param2)
               {
                  if(param1 || curAnim > 0)
                  {
                     --curAnim;
                     if(curAnim < 0)
                     {
                        curAnim = animationCount - 1;
                     }
                  }
               }
               else if(param1 || curAnim < animationCount - 1)
               {
                  ++curAnim;
                  if(curAnim >= animationCount)
                  {
                     curAnim = 0;
                  }
               }
               curFrame = curAnim;
            }
            if(previousFrame != curFrame)
            {
               updateHighlight(true);
               return true;
            }
         }
         return false;
      }
      
      override public function draw() : void
      {
         var frameWidth:int = bitmap.width / animationCount;
         if(!bitmapData)
         {
            bitmapData = new BitmapData(frameWidth,bitmap.height);
         }
         if(curFrame < animationCount)
         {
            bitmapData.copyPixels(bitmap.bitmapData,new Rectangle(frameWidth * curFrame,0,frameWidth,bitmap.height),new Point(0,0));
            visible = true;
         }
         else
         {
            visible = false;
         }
         intValue66 = highlight;
      }
      
      public function startAnimation() : void
      {
         curAnim = 0;
      }
      
      public function setLastAnim() : void
      {
         if(animationNums)
         {
            curAnim = animationNums.length - 1;
         }
         else
         {
            curAnim = animationCount - 1;
         }
      }
   }
}

