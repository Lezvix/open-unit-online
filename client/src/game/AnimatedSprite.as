package game
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.ImageDecodingPolicy;
   import flash.system.LoaderContext;
   
   public class AnimatedSprite extends Sprite
   {
      
      private static const animationMoviesByName:Object = {};
      
      private static const loadQueue:Array = [];
      
      private static const ANIMATED_SPRITE_CONST2:int = 2;
      
      private static var requests_:int = 0;
      
      protected static const point5:Point = new Point();
      
      private static const ANIMATED_SPRITE_CONST3:int = 192;
      
      private static const ANIMATED_SPRITE_CONST4:int = ANIMATED_SPRITE_CONST3 >> 1;
      
      private static const ANIMATED_SPRITE_CONST1:int = 256;
      
      private static const ANIMATED_SPRITE_CONST5:int = ANIMATED_SPRITE_CONST1 >> 1;
      
      protected static const rect:Rectangle = new Rectangle();
      
      protected static const point1:Point = new Point();
      
      protected static const matrix:Matrix = new Matrix();
      
      private static const bitmapData1:BitmapData = new BitmapData(ANIMATED_SPRITE_CONST3,ANIMATED_SPRITE_CONST1);
      
      private const objectList4:Vector.<Object> = new Vector.<Object>();
      
      protected const bitmapData2:BitmapData = new BitmapData(ANIMATED_SPRITE_CONST3,ANIMATED_SPRITE_CONST1,true,0);
      
      protected const drawRect:Rectangle = new Rectangle();
      
      private var animationPlaying:Boolean;
      
      private var default2:String = "DEFAULT";
      
      private var _animationFrameIndex:int = 0;
      
      private var animationFrameCount:int = 0;
      
      public function AnimatedSprite()
      {
         var bitmap:Bitmap;
         super();
         bitmap = new Bitmap(this.bitmapData2);
         bitmap.x = -ANIMATED_SPRITE_CONST4;
         bitmap.y = -ANIMATED_SPRITE_CONST5;
         addChild(bitmap);
      }
      
      private static function doAction608(name:String, cb:Function) : void
      {
         var i:int;
         var complete:Function;
         complete = function(param1:Event):void
         {
            param1.target.removeEventListener(Event.COMPLETE,complete);
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR,fail);
            _loadOk(name);
            requests_ = requests_ - 1;
            loadNext();
         };
         var fail:Function = function(param1:IOErrorEvent):void
         {
            param1.target.removeEventListener(Event.COMPLETE,complete);
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR,fail);
            _loadFail(name);
            requests_ = requests_ - 1;
            loadNext();
         };
         i = loadQueue.length;
         while(i > 0)
         {
            var job:Object = loadQueue[--i];
            if(job.name == name)
            {
               job.callbacks.push(cb);
               return;
            }
         }
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,fail);
         loadQueue.push({
            "callbacks":[cb],
            "loader":loader,
            "name":name,
            "loading":false
         });
         loadNext();
      }
      
      private static function loadNext() : void
      {
         var index:int = 0;
         var job:Object = null;
         var context:LoaderContext = null;
         if(requests_ < ANIMATED_SPRITE_CONST2)
         {
            index = loadQueue.length;
            while(index > 0)
            {
               job = loadQueue[--index];
               if(!job.loading)
               {
                  job.loading = true;
                  requests_ += 1;
                  context = new LoaderContext();
                  context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
                  job.loader.load(new URLRequest("animations/" + job.name + ".swf"),context);
                  return;
               }
            }
         }
      }
      
      private static function _loadOk(param1:String) : void
      {
         var index:int = loadQueue.length;
         var job:Object;
         var content:*;
         var callbacks:Array;
         while(index > 0)
         {
            job = loadQueue[--index];
            if(job.name == param1)
            {
               loadQueue.splice(index,1);
               content = job.loader.content;
               animationMoviesByName[param1] = {
                  "bitmap":new content.BITMAP().bitmapData,
                  "data":content
               };
               job.loader.unloadAndStop();
               callbacks = job.callbacks;
               index = callbacks.length;
               while(index > 0)
               {
                  callbacks[--index](param1);
               }
               return;
            }
         }
      }
      
      private static function _loadFail(param1:String) : void
      {
         var index:int = loadQueue.length;
         var job:Object;
         var callbacks:Array;
         while(index > 0)
         {
            job = loadQueue[--index];
            if(job.name == param1)
            {
               loadQueue.splice(index,1);
               callbacks = job.callbacks;
               index = callbacks.length;
               while(index > 0)
               {
                  callbacks[--index](param1);
               }
               return;
            }
         }
      }
      
      private static function doAction249(param1:Object, param2:int) : void
      {
         if(param1.palette != param2)
         {
            doAction499(param1,param2);
         }
      }
      
      private static function doAction499(param1:Object, param2:int) : void
      {
         var paletteFilters:Array = null;
         var palette:Object = null;
         param1.palette = param2;
         if(param1.loaded)
         {
            if(param2 == 0)
            {
               if(param1.transform)
               {
                  delete param1.transform;
               }
            }
            else
            {
               paletteFilters = animationMoviesByName[param1.name].data.palFilters;
               if(param2 < 0 || param2 > paletteFilters.length)
               {
                  param1.palette = 0;
                  if(param1.transform)
                  {
                     delete param1.transform;
                  }
               }
               else
               {
                  palette = paletteFilters[param2 - 1];
                  param1.transform = new ColorTransform(palette.mr,palette.mg,palette.mb,palette.ma,palette.or,palette.og,palette.ob,palette.oa);
               }
            }
         }
      }
      
      public function play(param1:int = 0) : void
      {
         if(!this.animationPlaying)
         {
            animationPlaying = true;
            _animationFrameIndex = Math.max(0,param1);
            this.animate();
         }
      }
      
      public function stop() : void
      {
         if(this.animationPlaying)
         {
            animationPlaying = false;
         }
      }
      
      public function get isValue42() : Boolean
      {
         return this.animationPlaying;
      }
      
      public function set animationName(param1:String) : void
      {
         if(this.default2 != param1)
         {
            default2 = param1;
            _animationFrameIndex = 0;
            animationFrameCount = 0;
         }
      }
      
      public function includesMouse() : Boolean
      {
         return this.drawRect.contains(mouseX + ANIMATED_SPRITE_CONST4,mouseY + ANIMATED_SPRITE_CONST5);
      }
      
      public function get animationName() : String
      {
         return this.default2;
      }
      
      public function animate() : void
      {
         if(!this.animationPlaying || this.objectList4.length == 0)
         {
            return;
         }
         if(this.drawRect.width > 0)
         {
            this.bitmapData2.fillRect(this.drawRect,0);
         }
         this.drawRect.x = ANIMATED_SPRITE_CONST3;
         this.drawRect.y = ANIMATED_SPRITE_CONST1;
         this.drawRect.width = 0;
         this.drawRect.height = 0;
         var index:int = 0;
         var layer:Object;
         var movie:Object;
         var animation:Object;
         var frameData:Object;
         for(; index < this.objectList4.length; index++)
         {
            layer = this.objectList4[index];
            if(!layer.loaded)
            {
               continue;
            }
            movie = animationMoviesByName[layer.name];
            animation = movie.data.getData(this.default2);
            if(animation == null)
            {
               continue;
            }
            if(animation.frames.length > this.animationFrameCount)
            {
               animationFrameCount = animation.frames.length;
            }
            if(this._animationFrameIndex >= animation.frames.length)
            {
               continue;
            }
            frameData = animation.frames[this._animationFrameIndex];
            if(frameData.w > 0 && frameData.h > 0 && frameData.ox > -2000000000)
            {
               rect.x = frameData.x;
               rect.y = frameData.y;
               rect.width = frameData.w;
               rect.height = frameData.h;
               point1.x = ANIMATED_SPRITE_CONST4 - frameData.ox;
               point1.y = ANIMATED_SPRITE_CONST5 - frameData.oy;
               if(layer.palette == 0)
               {
                  this.bitmapData2.copyPixels(movie.bitmap,rect,point1,null,null,true);
               }
               else
               {
                  bitmapData1.copyPixels(movie.bitmap,rect,point5);
                  rect.x = rect.y = 0;
                  bitmapData1.colorTransform(rect,layer.transform);
                  this.bitmapData2.copyPixels(bitmapData1,rect,point1,null,null,true);
               }
               if(point1.x < this.drawRect.x)
               {
                  this.drawRect.x = point1.x;
               }
               if(point1.y < this.drawRect.y)
               {
                  this.drawRect.y = point1.y;
               }
               if(point1.x + rect.width > this.drawRect.width)
               {
                  this.drawRect.width = point1.x + rect.width;
               }
               if(point1.y + rect.height > this.drawRect.height)
               {
                  this.drawRect.height = point1.y + rect.height;
               }
            }
         }
         if(this.drawRect.width != 0)
         {
            this.drawRect.width -= this.drawRect.x;
            this.drawRect.height -= this.drawRect.y;
         }
         if(this._animationFrameIndex >= this.animationFrameCount - 1)
         {
            this.animationCompleted();
         }
         else
         {
            ++this._animationFrameIndex;
         }
      }
      
      protected function animationCompleted() : void
      {
         _animationFrameIndex = 0;
      }
      
      public function get frame() : int
      {
         return this._animationFrameIndex;
      }
      
      public function set frame(param1:int) : void
      {
         _animationFrameIndex = param1;
      }
      
      public function get frames() : int
      {
         return this.animationFrameCount;
      }
      
      public function getInt38(param1:String, param2:int = 0) : int
      {
         var index:int = 0;
         while(index < this.objectList4.length)
         {
            if(this.objectList4[index].name == param1)
            {
               doAction249(this.objectList4[index],param2);
               return index;
            }
            index++;
         }
         var layer:Object = {
            "name":param1,
            "palette":param2
         };
         if(param1 in animationMoviesByName)
         {
            layer.loaded = true;
            doAction499(layer,param2);
         }
         else
         {
            layer.loaded = false;
            doAction608(param1,this.doAction9);
         }
         this.objectList4.push(layer);
         return this.objectList4.length - 1;
      }
      
      public function doAction285(param1:Array, param2:Array) : void
      {
         if(param1 == null || param2 == null || param1.length != param2.length)
         {
            throw new Error();
         }
         var index:int = 0;
         var layerIndex:int;
         while(index < param1.length)
         {
            layerIndex = this.getInt38(param1[index],param2[index]);
            if(index != layerIndex)
            {
               this.objectList4.splice(index,0,this.objectList4.splice(layerIndex,1)[0]);
            }
            index++;
         }
         if(index < this.objectList4.length)
         {
            this.objectList4.splice(index,int.MAX_VALUE);
         }
      }
      
      private function doAction9(param1:String) : void
      {
         var index:int = 0;
         var layer:Object;
         while(index < this.objectList4.length)
         {
            layer = this.objectList4[index];
            if(layer.name == param1)
            {
               if(param1 in animationMoviesByName)
               {
                  layer.loaded = true;
                  doAction499(layer,layer.palette);
               }
               else
               {
                  this.objectList4.splice(index,1);
               }
               return;
            }
            index++;
         }
      }
      
      public function dispose() : void
      {
         this.stop();
         this.bitmapData2.dispose();
      }
   }
}

