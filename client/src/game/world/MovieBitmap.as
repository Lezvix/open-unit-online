package game.world
{
   import core.resources.ResourcePack;
   import social.SocialApi;
   import core.system.EventListeners;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MovieBitmap extends Bitmap implements IFilterable
   {
      
      protected static var firstMovies:Object = new Object();
      
      protected static var loadedMovies:Object = new Object();
      
      protected static var lastMovies:Object = new Object();
      
      protected static var packageLoader:Object = new Object();
      
      public static const MOVIE_BITMAP_CONST2:int = 0;
      
      public static const MOVIE_BITMAP_CONST4:int = 1;
      
      public static const MOVIE_BITMAP_CONST1:int = 2;
      
      public static const MOVIE_BITMAP_CONST5:int = 3;
      
      public static const MOVIE_BITMAP_CONST3:int = 4;
      
      private var _movieBitmapLoaded:Boolean = false;
      
      public var nextMov:MovieBitmap;
      
      public var prevMov:MovieBitmap;
      
      protected var packageId:int;
      
      protected var libruaryId:int;
      
      public var animationCount:int;
      
      public var curAnim:int;
      
      protected var curFrame:int;
      
      protected var curFramesLeft:int;
      
      public var bitmap:Bitmap;
      
      public var type:int;
      
      public var str27:String;
      
      public var str3:String;
      
      protected var animationNums:Vector.<int> = null;
      
      protected var animationTimes:Vector.<int> = null;
      
      protected var createAnim:Boolean = false;
      
      protected var highlight:int = WorldObject.HIGHLIGHT_SELECTED;
      
      protected var intValue66:int = WorldObject.HIGHLIGHT_SELECTED;
      
      private var parentObject:WorldObject;
      
      private var intValue25:int = 0;
      
      private var intList3:Vector.<int>;
      
      private var flag47:Boolean = true;
      
      private var array8:Array;
      
      private var array68:Array;
      
      public function MovieBitmap(param1:WorldObject)
      {
         super();
         this.parentObject = param1;
         param1.addChild(this);
         this.prevMov = null;
         this.nextMov = null;
         this.bitmap = null;
         this.curAnim = 0;
         this.curFrame = 0;
      }
      
      private static function doAction320(param1:int, param2:String) : void
      {
         packageLoader[param1] = new PackageLoader(param1,param2);
         EventListeners.addEventListener(packageLoader[param1].contentLoaderInfo,Event.COMPLETE,movieLoaded);
         loadedMovies[param1] = null;
         firstMovies[param1] = null;
         lastMovies[param1] = null;
      }
      
      public static function init(param1:int, param2:String) : void
      {
      }
      
      public static function doAction790(param1:ResourcePack) : void
      {
         var packId:int = int(param1.packContext);
         if(!packageLoader[packId])
         {
            doAction320(packId,"");
         }
         loadedMovies[packId] = packageLoader[packId];
         packageLoader[packId].resourceBundle = param1;
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
         EventListeners.removeEventListener(loader,Event.COMPLETE,movieLoaded);
      }
      
      public static function doAction136() : void
      {
         var loader:PackageLoader = null;
         for each(loader in packageLoader)
         {
            EventListeners.removeEventListener(loader.contentLoaderInfo,Event.COMPLETE,movieLoaded);
         }
         for each(loader in loadedMovies)
         {
            loader.unload();
         }
         packageLoader = null;
         loadedMovies = null;
      }
      
      public function get stateCount() : int
      {
         return this.intList3.length;
      }
      
      public function get currentFrame() : int
      {
         return this.curFrame;
      }
      
      public function get animationIdx() : int
      {
         var stateStart:int = 0;
         if(this.intValue25 > 0)
         {
            stateStart = this.intList3[this.intValue25 - 1];
         }
         else
         {
            stateStart = 0;
         }
         return this.curAnim - stateStart;
      }
      
      public function get loaded() : Boolean
      {
         return this._movieBitmapLoaded;
      }
      
      public function processLoaded() : void
      {
         var stateStart:int = 0;
         _movieBitmapLoaded = true;
         bitmap = loadedMovies[this.packageId].getImage(this.libruaryId);
         if(this.intValue25 > 0)
         {
            stateStart = this.intList3[this.intValue25 - 1];
         }
         else
         {
            stateStart = 0;
         }
         curAnim = stateStart + this.parentObject.propValue35;
         this.draw();
         this.parentObject.doAction623(this);
         if(this.highlight != WorldObject.HIGHLIGHT_SELECTED)
         {
            this.setHightlight(this.highlight);
         }
      }
      
      public function setVals(param1:int, param2:int, param3:int, param4:String, param5:String, param6:int, param7:Vector.<int>, param8:Vector.<int>, param9:Boolean, param10:Vector.<int>) : void
      {
         packageId = param1;
         libruaryId = param2;
         this.str27 = param4;
         this.str3 = param5;
         this.type = param3;
         intList3 = param10;
         if(param6 > 0)
         {
            animationCount = param6;
         }
         else
         {
            animationCount = 1;
         }
         animationNums = param7;
         animationTimes = param8;
         if(this.animationTimes.length > 0)
         {
            curFramesLeft = this.animationTimes[0];
         }
         this.createAnim = param9;
      }
      
      public function get propValue3() : int
      {
         return this.bitmap.width / this.animationCount;
      }
      
      public function get propValue139() : int
      {
         return this.bitmap.height;
      }
      
      public function load() : void
      {
         _movieBitmapLoaded = false;
         if(loadedMovies[this.packageId])
         {
            this.processLoaded();
         }
         else if(lastMovies[this.packageId])
         {
            lastMovies[this.packageId].nextMov = this;
            prevMov = lastMovies[this.packageId];
            lastMovies[this.packageId] = this;
         }
         else if(packageLoader[this.packageId])
         {
            lastMovies[this.packageId] = this;
            firstMovies[this.packageId] = this;
         }
         else
         {
            doAction320(this.packageId,SocialApi.api.propValue145 + "res/");
            PackageLoader(packageLoader[this.packageId]).loadPackage();
            lastMovies[this.packageId] = this;
            firstMovies[this.packageId] = this;
         }
      }
      
      public function free() : void
      {
         if(this.prevMov && this.nextMov)
         {
            this.prevMov.nextMov = this.nextMov;
            this.nextMov.prevMov = this.prevMov;
         }
         if(firstMovies[this.packageId] == this)
         {
            firstMovies[this.packageId] = this.nextMov;
         }
         if(lastMovies[this.packageId] == this)
         {
            lastMovies[this.packageId] = this.prevMov;
         }
         if(this.bitmap)
         {
            loadedMovies[this.packageId].unloadImage(this.libruaryId);
            bitmap = null;
         }
         if(bitmapData)
         {
            bitmapData.dispose();
            bitmapData = null;
         }
      }
      
      public function animate(param1:Boolean, param2:Boolean) : Boolean
      {
         var previousFrame:int = 0;
         var stateStart:int = 0;
         if(this.flag47)
         {
            if(this.bitmap != null && (this.animationCount > 1 || this.intList3.length > 0))
            {
               previousFrame = this.curFrame;
               if(this.animationNums)
               {
                  --this.curFramesLeft;
                  if(this.curFramesLeft <= 0)
                  {
                     if(param2)
                     {
                        if(this.intList3.length > 0)
                        {
                           stateStart = 0;
                           if(this.intValue25 > 0)
                           {
                              stateStart = this.intList3[this.intValue25 - 1];
                           }
                           if(this.curAnim > stateStart)
                           {
                              --this.curAnim;
                           }
                           else if(param1)
                           {
                              curAnim = this.intList3[this.intValue25] - 1;
                           }
                           else
                           {
                              flag47 = false;
                              this.parentObject.doAction379();
                           }
                        }
                        else if(param1 || this.curAnim > 0)
                        {
                           --this.curAnim;
                           if(this.curAnim < 0)
                           {
                              curAnim = this.animationNums.length - 1;
                           }
                        }
                     }
                     else if(this.intList3.length > 0)
                     {
                        if(this.curAnim < this.intList3[this.intValue25] - 1)
                        {
                           ++this.curAnim;
                        }
                        else if(param1)
                        {
                           if(this.intValue25 < 1)
                           {
                              curAnim = 0;
                           }
                           else
                           {
                              curAnim = this.intList3[this.intValue25 - 1];
                           }
                        }
                        else
                        {
                           flag47 = false;
                           this.parentObject.doAction379();
                        }
                     }
                     else if(param1 || this.curAnim < this.animationNums.length - 1)
                     {
                        ++this.curAnim;
                        if(this.curAnim >= this.animationNums.length)
                        {
                           curAnim = 0;
                        }
                     }
                     if(this.animationTimes.length > this.curAnim)
                     {
                        curFramesLeft = this.animationTimes[this.curAnim];
                        curFrame = this.animationNums[this.curAnim];
                     }
                     else
                     {
                        curFramesLeft = 0;
                        curFrame = 0;
                     }
                  }
               }
               else
               {
                  if(param2)
                  {
                     if(param1 || this.curAnim > 0)
                     {
                        --this.curAnim;
                        if(this.curAnim < 0)
                        {
                           curAnim = this.animationCount - 1;
                        }
                     }
                  }
                  else if(param1 || this.curAnim < this.animationCount - 1)
                  {
                     ++this.curAnim;
                     if(this.curAnim >= this.animationCount)
                     {
                        curAnim = 0;
                     }
                  }
                  curFrame = this.curAnim;
               }
               if(previousFrame != this.curFrame)
               {
                  this.updateHighlight(true);
                  return true;
               }
            }
         }
         return false;
      }
      
      public function draw() : void
      {
         if(this.bitmap == null)
         {
            return;
         }
         intValue66 = this.highlight;
         var frameWidth:int = this.bitmap.width / this.animationCount;
         var frameBitmap:BitmapData;
         if(bitmapData)
         {
            if(this.curFrame >= 0 && this.curFrame < this.animationCount)
            {
               visible = true;
               bitmapData.copyPixels(this.bitmap.bitmapData,new Rectangle(frameWidth * this.curFrame,0,frameWidth,this.bitmap.height),new Point(0,0));
            }
            else
            {
               visible = false;
            }
         }
         else if(this.curFrame >= 0 && this.curFrame < this.animationCount)
         {
            visible = true;
            frameBitmap = new BitmapData(frameWidth,this.bitmap.height);
            frameBitmap.copyPixels(this.bitmap.bitmapData,new Rectangle(frameWidth * this.curFrame,0,frameWidth,this.bitmap.height),new Point(0,0));
            bitmapData = frameBitmap;
         }
         else
         {
            visible = false;
         }
      }
      
      protected function highlightEffect(param1:int) : void
      {
      }
      
      public function highlightNeedRedraw(param1:int) : Boolean
      {
         return false;
      }
      
      public function updateHighlight(param1:Boolean) : void
      {
         if(param1 || this.highlightNeedRedraw(this.intValue66))
         {
            this.draw();
         }
         if(bitmapData)
         {
            filters = null;
            if(this.highlight != WorldObject.HIGHLIGHT_SELECTED)
            {
               this.highlightEffect(this.highlight);
            }
            intValue66 = this.highlight;
         }
      }
      
      public function setHightlight(param1:int) : void
      {
         highlight = param1;
         this.updateHighlight(false);
      }
      
      public function startStateAnimation(param1:int, param2:Boolean) : void
      {
         intValue25 = Math.max(0,Math.min(param1,this.intList3.length - 1));
         flag47 = true;
         if(param2)
         {
            if(this.intValue25 >= 0)
            {
               curAnim = this.intList3[this.intValue25] - 1;
            }
            else
            {
               curAnim = 0;
            }
         }
         else if(this.intValue25 > 0)
         {
            curAnim = this.intList3[this.intValue25 - 1];
         }
         else
         {
            curAnim = 0;
         }
         if(this.animationTimes.length > this.curAnim)
         {
            curFramesLeft = this.animationTimes[this.curAnim];
            curFrame = this.animationNums[this.curAnim];
         }
         else
         {
            curFramesLeft = 0;
            curFrame = 0;
         }
         this.updateHighlight(true);
      }
      
      override public function set filters(param1:Array) : void
      {
         array8 = param1;
         this.doAction38();
      }
      
      public function set propValue172(param1:Array) : void
      {
         array68 = param1;
         this.doAction38();
      }
      
      private function doAction38() : void
      {
         if(this.array68)
         {
            super.filters = this.array8 ? this.array8.concat(this.array68) : this.array68;
         }
         else
         {
            super.filters = this.array8;
         }
      }
   }
}

