package game.world
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MovieLoader extends Sprite
   {
      
      private static const MOVIE_LOADER_CONST1:int = 2;
      
      private static var movies:Object = new Object();
      
      private static var array51:Array = new Array();
      
      private static var intValue123:int = 0;
      
      private static var point2:Point = new Point(0,0);
      
      private var onLoad:Function;
      
      private var _useSmoothing:Boolean = false;
      
      public var str29:String = "";
      
      private var bitmap:Bitmap = null;
      
      private var fillRect:Rectangle;
      
      private var bitmapData:BitmapData = null;
      
      private var array124:Array = null;
      
      private var obj64:Object = null;
      
      private var _movieAnimationIndex:int;
      
      private var _movieTick:int = 0;
      
      private var swf:Object;
      
      private var matrix:Matrix;
      
      private var matrix17:Matrix;
      
      private var matrix16:Matrix;
      
      private var matrix18:Matrix;
      
      private var flag80:Boolean = false;
      
      private var flag120:Boolean = false;
      
      public var layerId:int;
      
      public var containerFile:String;
      
      private var _moviePalette:int;
      
      private var movie:Object = null;
      
      private var flag107:Boolean = true;
      
      public function MovieLoader(param1:Boolean = false)
      {
         super();
         this._useSmoothing = param1;
      }
      
      public static function unloadMovies() : void
      {
         var movie:Object = null;
         for each(movie in movies)
         {
            if(movie.swf != null && movie.swf.loaded)
            {
               movie.swf.unload();
            }
         }
      }
      
      public static function doAction627(url:String, onLoad:Function) : void
      {
         var loadComplete:Function;
         loadComplete = function(param1:AvatarLoader):void
         {
            completeHandler(param1);
            onLoad();
         };
         var movie:Object = movies[url];
         if(movie == null || movie.swf == null)
         {
            if(movie == null)
            {
               movie = {
                  "swf":null,
                  "movies":new Array(),
                  "url":url
               };
               movies[url] = movie;
            }
            else
            {
               array51.splice(array51.indexOf(url),0);
            }
            movie.swf = new AvatarLoader(url,loadComplete,loadNext);
            ++intValue123;
         }
         else if(!movie.swf.loaded)
         {
            movie.swf.completeHandler = loadComplete;
         }
         else
         {
            onLoad();
         }
      }
      
      public static function doAction418(param1:String, param2:Function) : void
      {
         var movie:Object = movies[param1];
         if(movie == null)
         {
            movie = {
               "swf":null,
               "movies":new Array(),
               "url":param1
            };
            movie.swf = new AvatarLoader(param1,globalCompleteHandler,loadNext);
            movie.swf.globalCompleteHandler = param2;
            ++intValue123;
            movies[param1] = movie;
         }
         else if(movie.swf != null && movie.swf.loaded && param2 != null)
         {
            param2(movie.swf);
         }
      }
      
      private static function globalCompleteHandler(param1:AvatarLoader) : void
      {
         completeHandler(param1);
         if(param1.globalCompleteHandler != null)
         {
            param1.globalCompleteHandler(param1);
         }
      }
      
      private static function loadNext(param1:AvatarLoader) : void
      {
         var url:String = null;
         var movie:Object = null;
         if(array51.length > 0)
         {
            url = array51.pop();
            movie = movies[url];
            movie.swf = new AvatarLoader(url,completeHandler,loadNext);
         }
         else
         {
            --intValue123;
         }
      }
      
      private static function completeHandler(param1:AvatarLoader) : void
      {
         var url:String = param1.url;
         var movie:Object = movies[url];
         var waitingMovies:Array = new Array();
         var waitingMovie:MovieLoader;
         for each(waitingMovie in movie.movies)
         {
            waitingMovies.push(waitingMovie);
         }
         for each(waitingMovie in waitingMovies)
         {
            waitingMovie.doAction568(param1);
         }
         loadNext(param1);
      }
      
      public function get di() : int
      {
         return this.obj64 ? this.obj64.di : 0;
      }
      
      public function get dj() : int
      {
         return this.obj64 ? this.obj64.dj : 0;
      }
      
      public function set useSmoothing(param1:Boolean) : void
      {
         _useSmoothing = param1;
         if(this.bitmap != null)
         {
            this.bitmap.smoothing = param1;
         }
      }
      
      public function get useSmoothing() : Boolean
      {
         return this._useSmoothing;
      }
      
      public function get tick() : int
      {
         return this._movieTick;
      }
      
      public function set tick(param1:int) : void
      {
         _movieTick = param1;
      }
      
      public function set animationIdx(param1:int) : void
      {
         _movieAnimationIndex = param1;
      }
      
      public function get animationIdx() : int
      {
         return this._movieAnimationIndex;
      }
      
      public function load(param1:String, param2:Function) : Boolean
      {
         this.onLoad = param2;
         movie = movies[param1];
         if(this.movie == null)
         {
            movie = {
               "swf":null,
               "movies":new Array(),
               "url":param1
            };
            this.movie.movies.push(this);
            if(intValue123 < MOVIE_LOADER_CONST1)
            {
               this.movie.swf = new AvatarLoader(param1,completeHandler,loadNext);
               ++intValue123;
            }
            else
            {
               array51.splice(0,0,param1);
            }
            movies[param1] = this.movie;
            return false;
         }
         else
         {
            this.movie.movies.push(this);
            if(this.movie.swf != null && this.movie.swf.loaded)
            {
               this.doAction568(this.movie.swf);
               return true;
            }
            return false;
         }
      }
      
      public function doAction568(param1:AvatarLoader) : void
      {
         swf = param1.content;
         var frameBitmap:BitmapData = new BitmapData(this.swf.maxWidth,this.swf.maxHeight,true,0);
         fillRect = new Rectangle(0,0,frameBitmap.width,frameBitmap.height);
         bitmap = new Bitmap(frameBitmap);
         this.bitmap.smoothing = this._useSmoothing;
         addChild(this.bitmap);
         matrix = transform.matrix;
         matrix17 = this.matrix.clone();
         this.matrix17.a = -1;
         matrix16 = this.matrix.clone();
         this.matrix16.d = -1;
         matrix18 = this.matrix.clone();
         this.matrix18.a = -1;
         this.matrix18.d = -1;
         this.bitmapData = param1.bitmapData;
         this.onLoad(this);
      }
      
      public function dispose() : void
      {
         if(this.movie)
         {
            this.movie.movies.splice(this.movie.movies.indexOf(this),1);
         }
         if(this.bitmap)
         {
            this.bitmap.bitmapData.dispose();
         }
      }
      
      public function includesMouse() : Boolean
      {
         var alpha:int = 0;
         if(this.bitmap != null && this.bitmap.mouseY >= 0 && this.bitmap.mouseY < this.bitmap.height && this.bitmap.mouseX >= 0 && this.bitmap.mouseX < this.bitmap.width)
         {
            alpha = this.bitmap.bitmapData.getPixel32(this.bitmap.mouseX,this.bitmap.mouseY) >> 24 & 0xFF;
            if(alpha > 15)
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateAnimatioIdx(param1:int) : void
      {
         this._movieAnimationIndex = param1;
         this.draw();
      }
      
      public function get propValue128() : int
      {
         if(this.array124 == null)
         {
            return 0;
         }
         return this.array124.length;
      }
      
      public function animate() : Boolean
      {
         var completed:Boolean = false;
         if(this.array124 != null)
         {
            if(this.array124.length > 1)
            {
               --this._movieTick;
               if(this._movieTick <= 0)
               {
                  ++this._movieAnimationIndex;
                  if(this._movieAnimationIndex >= this.array124.length)
                  {
                     _movieAnimationIndex = 0;
                     completed = true;
                  }
                  if(this.array124[this._movieAnimationIndex].rt != 0)
                  {
                     _movieTick = this.array124[this._movieAnimationIndex].t + int(Math.random() * this.array124[this._movieAnimationIndex].rt);
                  }
                  else
                  {
                     _movieTick = this.array124[this._movieAnimationIndex].t;
                  }
                  this.draw();
               }
            }
            else if(this.flag107)
            {
               completed = true;
            }
         }
         if(completed)
         {
            flag107 = false;
         }
         return completed;
      }
      
      public function draw() : void
      {
         if(this.array124 == null)
         {
            return;
         }
         var frame:Object = this.array124[this._movieAnimationIndex];
         var palette:Object;
         var colorTransform:ColorTransform;
         this.bitmap.bitmapData.fillRect(this.fillRect,16777215);
         if(frame)
         {
            if(frame.x != null)
            {
               this.bitmap.bitmapData.copyPixels(this.bitmapData,new Rectangle(frame.x,frame.y,frame.w,frame.h),point2);
               this.bitmap.x = -frame.ox;
               this.bitmap.y = -frame.oy;
               if(this._moviePalette > 0)
               {
                  palette = this.swf.palFilters[this._moviePalette - 1];
                  colorTransform = new ColorTransform(palette.mr,palette.mg,palette.mb,palette.ma,palette.or,palette.og,palette.ob,palette.oa);
                  this.bitmap.bitmapData.colorTransform(new Rectangle(0,0,this.bitmap.width,this.bitmap.height),colorTransform);
               }
            }
         }
      }
      
      public function setAnimation(param1:String, param2:int = 0, param3:int = -1) : void
      {
         flag107 = true;
         str29 = param1;
         obj64 = this.swf.getData(param1);
         if(this.obj64 != null)
         {
            array124 = this.obj64.frames;
            this._movieAnimationIndex = param2;
            if(param3 < 0)
            {
               if(this.array124 != null && this.array124[param2] != null && this.array124[param2].t != null)
               {
                  this._movieTick = this.array124[param2].t;
               }
            }
            else
            {
               this._movieTick = param3 % this.array124.length;
            }
            this.draw();
         }
         else
         {
            array124 = null;
            this.bitmap.bitmapData.fillRect(this.fillRect,16777215);
         }
      }
      
      public function set palette(param1:int) : void
      {
         _moviePalette = param1;
         if(this.array124 != null)
         {
            this.draw();
         }
      }
      
      public function get palette() : int
      {
         return this._moviePalette;
      }
      
      public function doAction717(param1:Boolean, param2:Boolean) : void
      {
         flag80 = param1;
         flag120 = param2;
         this.doAction323();
      }
      
      public function set isValue30(param1:Boolean) : void
      {
         flag80 = param1;
         this.doAction323();
      }
      
      public function set isValue11(param1:Boolean) : void
      {
         flag120 = param1;
         this.doAction323();
      }
      
      private function doAction323() : void
      {
         if(this.flag120)
         {
            if(this.flag80)
            {
               transform.matrix = this.matrix18;
            }
            else
            {
               transform.matrix = this.matrix16;
            }
         }
         else if(this.flag80)
         {
            transform.matrix = this.matrix17;
         }
         else
         {
            transform.matrix = this.matrix;
         }
      }
      
      public function get propValue149() : Bitmap
      {
         return this.bitmap;
      }
   }
}

