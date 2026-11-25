package game.world
{
   import core.effects.FadeEffect;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   import flash.utils.getTimer;
   
   public class WorldObject extends WorldItem
   {
      
      public static const HIGHLIGHT_SELECTED:int = 0;
      
      public static const HIGHLIGHT_1:int = 1;
      
      public static const HIGHLIGHT_2:int = 2;
      
      public static const HIGHLIGHT_3:int = 3;
      
      public static const HIGHLIGHT_5:int = 5;
      
      public static const HIGHLIGHT_6:int = 6;
      
      public static var highlightedComposition:Composition = null;
      
      public static var HIGHLIGHT_20:int = 20;
      
      public static const animateNone:int = 0;
      
      public static const animateForward:int = 1;
      
      public static const animateBackward:int = 2;
      
      public static const WORLD_OBJECT_CONST1:int = 0;
      
      public static const WORLD_OBJECT_CONST2:int = 1;
      
      public static const WORLD_OBJECT_CONST3:int = 2;
      
      public static const HIDE_3:int = 3;
      
      public static const HIDE_4:int = 4;
      
      public static const HIDE_5:int = 5;
      
      public static const HIDE_ADVERTIZE:int = 6;
      
      public var locationArea1:LocationArea;
      
      public var id:int;
      
      public var rect1:Rectangle;
      
      public var rect8:Rectangle;
      
      public var rect:Rectangle;
      
      public var hideRect:Rectangle;
      
      public var bgRect:Rectangle;
      
      public var sumStart:int;
      
      public var intValue117:int;
      
      private var movieBitmapList1:Vector.<MovieBitmap>;
      
      private var movieBitmapList2:Vector.<MovieBitmap>;
      
      public var type:String;
      
      public var str18:String;
      
      public var isSpecialItem:Boolean;
      
      public var highlight:int = 0;
      
      public var animationState:int;
      
      public var cycled:Boolean = true;
      
      public var flag15:Boolean = false;
      
      public var canObjHide:Boolean = false;
      
      public var intValue148:int = 0;
      
      public var flag118:Boolean = false;
      
      public var worldObject2:WorldObject = null;
      
      public var intVal1:int;
      
      public var intVal2:int;
      
      public var intVal3:int;
      
      public var nextTime:int;
      
      private var _worldObjectState:int = 0;
      
      private var intValue62:int;
      
      public var composition:Composition;
      
      public var intValue226:int;
      
      private var intValue101:int = 2147483647;
      
      private var intValue87:int = 2147483647;
      
      private var intValue129:int = 0;
      
      private var intValue79:int = 0;
      
      public function WorldObject(param1:Sprite)
      {
         super(param1);
      }
      
      public function unloadMovies() : void
      {
         var movie:MovieBitmap = null;
         flag118 = true;
         while(this.movieBitmapList1.length > 0)
         {
            movie = this.movieBitmapList1.pop();
            movie.free();
            movie = null;
         }
         movieBitmapList1 = null;
         movieBitmapList2 = null;
      }
      
      public function doAction623(param1:MovieBitmap) : void
      {
         if(this.intValue101 + this.intValue129 < param1.x + param1.propValue3)
         {
            intValue129 = param1.x + param1.propValue3 - this.intValue101;
         }
         if(this.intValue87 + this.intValue79 < param1.y + param1.propValue139)
         {
            intValue79 = param1.y + param1.propValue139 - this.intValue87;
         }
         this.composition.doAction623(param1);
         doAction102();
      }
      
      public function initState() : void
      {
      }
      
      public function doAction646(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         movieBitmapList1 = new Vector.<MovieBitmap>();
         movieBitmapList2 = new Vector.<MovieBitmap>();
         depth = param3;
         id = param1;
         mapLevel = param2;
         this.type = param4;
         this.str18 = param5;
         this.state = this.state;
         this.initState();
      }
      
      public function check24(param1:uint) : Boolean
      {
         if(this.flag118)
         {
            return true;
         }
         while(getTimer() < param1 && this.intValue148 < this.movieBitmapList1.length)
         {
            this.movieBitmapList1[this.intValue148].load();
            ++this.intValue148;
         }
         if(this.intValue148 >= this.movieBitmapList1.length)
         {
            return true;
         }
         return false;
      }
      
      public function getMovieBitmap1() : MovieBitmap
      {
         return new MovieBitmap(this);
      }
      
      public function doAction204(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String, param7:String, param8:int, param9:Vector.<int>, param10:Vector.<int>, param11:Vector.<int>) : void
      {
         var movie:MovieBitmap = this.getMovieBitmap1();
         if(param1 < this.intValue101)
         {
            intValue101 = param1;
         }
         if(param2 < this.intValue87)
         {
            intValue87 = param2;
         }
         movie.x = param1;
         movie.y = param2;
         movie.setVals(param3,param4,param5,param6,param7,param8,param9,param10,param8 > 0,param11);
         movie.load();
         this.movieBitmapList1.push(movie);
         if(param8 > 0)
         {
            this.movieBitmapList2.push(movie);
         }
      }
      
      public function setPos(param1:int, param2:int, param3:Rectangle = null, param4:Rectangle = null) : void
      {
         i = param1;
         j = param2;
         if(param3 != null)
         {
            rect1 = param3;
         }
         if(param4 != null)
         {
            rect8 = param4;
         }
         rect = new Rectangle(this.rect1.x,this.rect1.y,this.rect1.width,this.rect1.height);
         hideRect = new Rectangle(this.rect8.x,this.rect8.y,this.rect8.width,this.rect8.height);
         if(this.rect.width != -1)
         {
            this.rect.x += j;
            this.rect.y += i;
         }
         if(this.hideRect.width != -1)
         {
            canObjHide = true;
            this.hideRect.x += j;
            this.hideRect.y += i;
         }
         sumStart = this.rect.x + this.rect.y - 2;
         intValue117 = this.rect.x + this.rect.y + this.rect.width + this.rect.height;
         var position:NPoint = getCoords(i,j);
         x = position.x;
         y = position.y - mapLevel * cMapLevelHeight;
      }
      
      override public function get isBackground() : Boolean
      {
         return this.rect.width < 0 || this.rect.height < 0;
      }
      
      public function getInt10(param1:WorldObject) : int
      {
         return getInt6(this.rect,param1.rect,this.sumStart,this.intValue117,param1.sumStart,param1.intValue117);
      }
      
      public function get ijVal() : int
      {
         return this.rect.y + this.rect.height - 1 - this.rect.x;
      }
      
      override public function isPlayerNear(param1:*) : int
      {
         if(this.rect.width == -1)
         {
            if(mapLevel <= param1.mapLevel)
            {
               return 1;
            }
            return -1;
         }
         else if(mapLevel > param1.mapLevel)
         {
            return -1;
         }
         if(mapLevel < param1.mapLevel)
         {
            return 1;
         }
         if(param1.isBackground)
         {
            return -1;
         }
         if(WorldEntity(param1).di != 0 || WorldEntity(param1).dj != 0)
         {
            return getInt6(this.rect,WorldEntity(param1).rect,this.sumStart,this.intValue117,WorldEntity(param1).sumStart,WorldEntity(param1).intValue117);
         }
         return getInt47(this.rect,param1,this.sumStart,this.intValue117);
      }
      
      public function containsInBg(param1:*) : Boolean
      {
         if(param1.i >= this.bgRect.y && param1.i < this.bgRect.y + this.bgRect.height && param1.j >= this.bgRect.x && param1.j < this.bgRect.x + this.bgRect.width)
         {
            return true;
         }
         return false;
      }
      
      public function containsInHide(param1:*) : Boolean
      {
         if(param1.i >= this.hideRect.y && param1.i < this.hideRect.y + this.hideRect.height && param1.j >= this.hideRect.x && param1.j < this.hideRect.x + this.hideRect.width)
         {
            return true;
         }
         return false;
      }
      
      public function containsObjectInBg(param1:WorldObject) : Boolean
      {
         if(param1.rect.width == -1 && param1.bgRect.y + param1.bgRect.height / 2 >= this.bgRect.y && param1.bgRect.y + param1.bgRect.height / 2 < this.bgRect.y + this.bgRect.height && param1.bgRect.x + param1.bgRect.width / 2 >= this.bgRect.x && param1.bgRect.x + param1.bgRect.width / 2 < this.bgRect.x + this.bgRect.width || param1.rect.y >= this.bgRect.y && param1.rect.y + param1.rect.height <= this.bgRect.y + this.bgRect.height && param1.rect.x >= this.bgRect.x && param1.rect.x + param1.rect.width <= this.bgRect.x + this.bgRect.width)
         {
            return true;
         }
         return false;
      }
      
      public function check4(param1:WorldObject) : Boolean
      {
         if(param1.rect.width == -1 && param1.hideRect.y + param1.hideRect.height / 2 >= this.hideRect.y && param1.hideRect.y + param1.hideRect.height / 2 < this.hideRect.y + this.hideRect.height && param1.hideRect.x + param1.hideRect.width / 2 >= this.hideRect.x && param1.hideRect.x + param1.hideRect.width / 2 < this.hideRect.x + this.hideRect.width || param1.rect.y >= this.hideRect.y && param1.rect.y + param1.rect.height <= this.hideRect.y + this.hideRect.height && param1.rect.x >= this.hideRect.x && param1.rect.x + param1.rect.width <= this.hideRect.x + this.hideRect.width)
         {
            return true;
         }
         return false;
      }
      
      public function process(param1:int, param2:int, param3:int, param4:int) : void
      {
         var index:int;
         if(this.animationState != animateNone)
         {
            index = 0;
            while(index < this.movieBitmapList2.length)
            {
               this.movieBitmapList2[index].animate(this.cycled,this.animationState == animateBackward);
               index++;
            }
         }
         var localX:int = param1;
         var localY:int = param2;
         var bitmapData:BitmapData;
         var highlightable:Boolean;
         var sideCheck:Boolean;
         var highlightMask:int;
         var highlighted:Vector.<Composition>;
         var movie:MovieBitmap;
         var pixelAlpha:int;
         if(highlightedComposition == this.composition && this.composition.isValue72 && world.highlightCompositions == null)
         {
            world.highlightCompositions = this.composition.propValue179;
         }
         if(localX >= this.intValue101 && localY >= this.intValue87 && localX < this.intValue129 && localY < this.intValue79 && this.isSpecialItem)
         {
            highlightable = this.composition.isValue72;
            sideCheck = this.composition.check21();
            if(highlightable || sideCheck)
            {
               highlightMask = this.composition.propValue137;
               highlighted = world.highlightCompositions;
               if(highlightable && highlighted != null)
               {
                  return;
               }
               if((this.isBackground && (highlightMask & Composition.COMPOSITION_CONST1) != 0 || !this.isBackground && (highlightMask & Composition.COMPOSITION_CONST2) != 0) && this.composition.isValue27)
               {
                  if(hitTestPoint(param3,param4))
                  {
                     index = 0;
                     while(index < this.movieBitmapList1.length)
                     {
                        movie = this.movieBitmapList1[index];
                        if(movie.visible)
                        {
                           if(movie.bitmapData != null)
                           {
                              bitmapData = movie.bitmapData;
                           }
                           else if(movie.bitmap != null)
                           {
                              bitmapData = movie.bitmap.bitmapData;
                           }
                           if(bitmapData != null)
                           {
                              pixelAlpha = bitmapData.getPixel32(localX - movie.x,localY - movie.y) >> 24 & 0xFF;
                              if(pixelAlpha > 1)
                              {
                                 if(sideCheck)
                                 {
                                    this.composition.doAction85(world.hideCompositions);
                                 }
                                 else if(highlightedComposition == null && world.canHighlightObject(this))
                                 {
                                    world.highlightCompositions = this.composition.propValue179;
                                 }
                              }
                           }
                        }
                        index++;
                     }
                  }
               }
            }
         }
      }
      
      public function updateHighlight() : void
      {
         var index:int = 0;
         index = 0;
         while(index < this.movieBitmapList1.length)
         {
            this.movieBitmapList1[index].updateHighlight(false);
            index++;
         }
      }
      
      public function setHighlight(param1:int) : void
      {
         var index:int = 0;
         if(this.highlight != param1)
         {
            this.highlight = param1;
            index = 0;
            while(index < this.movieBitmapList1.length)
            {
               this.movieBitmapList1[index].setHightlight(param1);
               index++;
            }
            doAction102();
         }
      }
      
      public function set state(param1:int) : void
      {
         intValue62 = this.movieBitmapList2.length;
         var index:int = 0;
         while(index < this.movieBitmapList2.length)
         {
            if(this.movieBitmapList2[index].stateCount <= 0 || this.movieBitmapList2[index].animationCount <= 1)
            {
               --this.intValue62;
            }
            index++;
         }
         this.initState();
         _worldObjectState = param1;
         this.startStateAnimation();
      }
      
      public function get state() : int
      {
         return this._worldObjectState;
      }
      
      public function startStateAnimation() : void
      {
         var index:int = 0;
         while(index < this.movieBitmapList2.length)
         {
            this.movieBitmapList2[index].startStateAnimation(this._worldObjectState,this.animationState == animateBackward);
            index++;
         }
      }
      
      public function doAction379() : void
      {
         --this.intValue62;
         if(this.intValue62 <= 0)
         {
            this.composition.doAction379();
         }
      }
      
      public function get isAnimatedObject() : Boolean
      {
         return this.movieBitmapList2.length > 0;
      }
      
      public function get maxAnimIdx() : int
      {
         var maxIndex:int = 0;
         var index:int = 0;
         while(index < this.movieBitmapList2.length)
         {
            if(this.movieBitmapList2[index].animationIdx > maxIndex)
            {
               maxIndex = this.movieBitmapList2[index].animationIdx;
            }
            index++;
         }
         return maxIndex;
      }
      
      public function get maxAnimCount() : int
      {
         var maxCount:int = 1;
         var index:int = 0;
         while(index < this.movieBitmapList2.length)
         {
            if(this.movieBitmapList2[index].animationCount > maxCount)
            {
               maxCount = this.movieBitmapList2[index].animationCount;
            }
            index++;
         }
         return maxCount;
      }
      
      public function get maxStateCount() : int
      {
         var maxCount:int = 1;
         var index:int = 0;
         while(index < this.movieBitmapList2.length)
         {
            if(this.movieBitmapList2[index].stateCount > maxCount)
            {
               maxCount = this.movieBitmapList2[index].stateCount;
            }
            index++;
         }
         return maxCount;
      }
      
      public function animateAlpha(value:Number, duration:Number, delay:Number, onComplete:Function) : void
      {
         var fade:FadeEffect;
         var complete:Function;
         complete = function():void
         {
            fade.removeEndListener(complete);
            onComplete();
         };
         fade = new FadeEffect(this);
         fade.propValue171 = value;
         fade.duration = duration;
         fade.numValue50 = delay;
         if(onComplete != null)
         {
            fade.addEndListener(complete);
         }
         fade.play();
      }
      
      override public function get transform() : Transform
      {
         return super.transform;
      }
      
      override public function set alpha(param1:Number) : void
      {
         super.alpha = param1;
      }
      
      public function get propValue35() : int
      {
         return this.composition.propValue35;
      }
      
      public function doAction684(param1:int) : void
      {
      }
      
      public function get dAnimImgsArray() : Vector.<MovieBitmap>
      {
         return this.movieBitmapList2;
      }
      
      public function get dImgs() : Vector.<MovieBitmap>
      {
         return this.movieBitmapList1;
      }
      
      override public function get uid() : String
      {
         return "objectItem" + this.id.toString();
      }
      
      override public function set filters(param1:Array) : void
      {
         super.filters = param1;
      }
   }
}

