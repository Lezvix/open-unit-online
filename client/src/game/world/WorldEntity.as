package game.world
{
   import core.resources.SoundManager;
   import core.resources.ResourceManager;
   import core.system.EventListeners;
   import core.ui.HintInfo;
   import core.effects.TweenEffect;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class WorldEntity extends WorldItem implements IAnimated, IFilterable
   {
      
      private static var intValue170:int = 0;
      
      public static const PLAYER_ITEM_CONST2:int = 0;
      
      public static const PLAYER_ITEM_CONST1:int = 1;
      
      public static const WORLD_ENTITY_CONST3:int = 2;
      
      public static const WORLD_ENTITY_CONST4:int = 0;
      
      public static const WORLD_ENTITY_CONST14:int = 1;
      
      public static const WORLD_ENTITY_CONST12:int = 2;
      
      public static const WORLD_ENTITY_CONST17:int = 3;
      
      public static var ANIMATIONS:String = "animations/";
      
      public static const WORLD_ENTITY_CONST11:int = -1;
      
      public static const WORLD_ENTITY_CONST16:int = 0;
      
      public static const WORLD_ENTITY_CONST1:int = 1;
      
      public static const WORLD_ENTITY_CONST7:int = 2;
      
      public static const WORLD_ENTITY_CONST9:int = 0;
      
      public static const WORLD_ENTITY_CONST19:int = 1;
      
      public static const WORLD_ENTITY_CONST8:int = 2;
      
      public static const WORLD_ENTITY_CONST15:int = 3;
      
      public static const WORLD_ENTITY_CONST5:int = 4;
      
      public static const WORLD_ENTITY_CONST18:int = 5;
      
      public static const WORLD_ENTITY_CONST6:int = 0;
      
      public static const WORLD_ENTITY_CONST10:int = 1;
      
      public static const WORLD_ENTITY_CONST2:int = 2;
      
      public static const WORLD_ENTITY_CONST13:int = 3;
      
      public static var animationLoader1:AnimationLoader = new AnimationLoader();
      
      public var intValue22:int = 0;
      
      protected var effect:TweenEffect = null;
      
      private var flag114:Boolean = false;
      
      private var progress:CounterSprite;
      
      public var numValue10:Number;
      
      public var startY:Number;
      
      protected var startTime:int;
      
      protected var intValue10:int;
      
      protected var targetPosition:NPoint;
      
      public var numValue34:Number;
      
      public var numValue31:Number;
      
      public var di:int = 0;
      
      public var dj:int = 0;
      
      public var gameState:int = 0;
      
      public var isValue42:Boolean = true;
      
      protected var movieLoaderList2:Vector.<MovieLoader> = new Vector.<MovieLoader>();
      
      protected var movieLoaderList1:Vector.<MovieLoader> = new Vector.<MovieLoader>();
      
      protected var obj8:Object = null;
      
      public var flag125:Boolean = true;
      
      public var _dir:int = 1;
      
      private var str29:String = "";
      
      private var flag102:Boolean = false;
      
      private var flag86:Boolean = false;
      
      public var composition3:Composition = null;
      
      private var intValue42:int;
      
      private var intValue229:int;
      
      private var obj51:Object;
      
      protected var nPointList1:Vector.<NPoint> = null;
      
      private var array7:Array = null;
      
      private var flag49:Boolean = false;
      
      private var flag111:Boolean = false;
      
      private var _entityHighlight:int = 0;
      
      private var _processing:Boolean = false;
      
      protected var movieContainer:Sprite;
      
      private var _id:int;
      
      public var flag62:Boolean = false;
      
      protected var flag77:Boolean = false;
      
      private var composition1:Composition = null;
      
      private var intValue114:int;
      
      private var intValue4:int;
      
      protected var flag1:Boolean;
      
      private var _useSmoothing:Boolean = false;
      
      private var array57:Array = new Array();
      
      protected var flag46:Boolean = false;
      
      private var movieLoader:MovieLoader = null;
      
      private var movieLoader2:MovieLoader = null;
      
      private var movieLoader1:MovieLoader = null;
      
      protected var numValue6:Number;
      
      protected var numValue40:Number;
      
      private var rect5:Rectangle;
      
      private var flag123:Boolean = false;
      
      private var intValue126:int;
      
      public var lastSortedIdx:int = -1;
      
      private var _entityUnlocked:Boolean = false;
      
      public var intValue228:int;
      
      public var intValue48:int;
      
      public var needSort:Boolean = false;
      
      private var numValue53:Number = 0.00001;
      
      private var ijPoint5:IJPoint;
      
      private var nPoint3:NPoint;
      
      private var intValue195:int = 70;
      
      private var flag134:Boolean = true;
      
      private var intValue107:int;
      
      private var intValue141:int;
      
      private var nPoint1:NPoint = null;
      
      private var intValue3:int;
      
      private var intValue191:int;
      
      public var intValue136:int;
      
      public var intValue105:int;
      
      private var flag33:Boolean = false;
      
      protected var flag121:Boolean;
      
      private var array8:Array;
      
      private var array68:Array;
      
      public function WorldEntity(param1:Sprite)
      {
         super(param1);
         this.intValue195 = this.propValue194;
         this._id = intValue170;
         ++intValue170;
         this.movieContainer = new Sprite();
         addChild(this.movieContainer);
         this.ijPoint5 = new IJPoint(i,j);
      }
      
      protected function set propValue116(param1:NPoint) : void
      {
         nPoint3 = param1;
      }
      
      public function get isValue17() : Boolean
      {
         return this.nPointList1 != null;
      }
      
      public function get movieLoaderValue() : MovieLoader
      {
         return this.movieLoader;
      }
      
      public function doAction226(param1:NPoint) : void
      {
         targetPosition = param1;
         this.doAction428();
      }
      
      public function get targetPositionValue() : NPoint
      {
         return this.targetPosition;
      }
      
      public function set targetPositionValue(param1:NPoint) : void
      {
         targetPosition = param1;
      }
      
      public function get propValue59() : Number
      {
         return this.numValue6;
      }
      
      public function get propValue53() : Number
      {
         return this.numValue40;
      }
      
      public function get useSmoothing() : Boolean
      {
         return this._useSmoothing;
      }
      
      public function set useSmoothing(param1:Boolean) : void
      {
         var loaderIndex:int = 0;
         _useSmoothing = param1;
         loaderIndex = 0;
         while(loaderIndex < this.movieLoaderList2.length)
         {
            this.movieLoaderList2[loaderIndex].useSmoothing = param1;
            loaderIndex++;
         }
         loaderIndex = 0;
         while(loaderIndex < this.movieLoaderList1.length)
         {
            this.movieLoaderList1[loaderIndex].useSmoothing = param1;
            loaderIndex++;
         }
      }
      
      public function get soundRepeatId() : String
      {
         return "p_" + this._id;
      }
      
      public function get speed() : int
      {
         return 100;
      }
      
      public function get hasSoundCoords() : Boolean
      {
         return true;
      }
      
      public function get soundX() : int
      {
         return this.x;
      }
      
      public function get soundY() : int
      {
         return this.y;
      }
      
      protected function doAction500() : void
      {
         SoundManager.doAction288(this);
      }
      
      public function init(param1:Boolean = true) : void
      {
         var layerPalettes:Array = null;
         var firstLayerLoadFailed:Boolean = false;
         var layerIndex:int = 0;
         var loader:MovieLoader = null;
         var animationPath:String = null;
         var loadResult:Boolean = false;
         if(this.isValue12)
         {
            flag33 = false;
            movieLoader = null;
            array7 = this.propValue126;
            layerPalettes = this.palettes;
            firstLayerLoadFailed = false;
            layerIndex = 0;
            while(layerIndex < this.array7.length)
            {
               loader = new MovieLoader(this._useSmoothing);
               if(layerIndex == this.propValue165)
               {
                  movieLoader1 = loader;
               }
               this.array57.push(loader);
               loader.layerId = layerIndex;
               loader.containerFile = this.array7[layerIndex];
               animationPath = ANIMATIONS + this.array7[layerIndex] + ".swf";
               loadResult = loader.load(ResourceManager.sharedInstance.resolveUrl(animationPath),this.doAction6);
               if(!loadResult && layerIndex == 0)
               {
                  firstLayerLoadFailed = true;
               }
               loader.palette = layerPalettes[layerIndex];
               layerIndex++;
            }
            if(param1 && firstLayerLoadFailed)
            {
               this.doAction132();
            }
         }
         else
         {
            animationLoader1.doAction704(this);
         }
      }
      
      public function doAction54(param1:Array) : void
      {
         flag49 = true;
         movieLoader2 = null;
         array7 = param1;
         var layerPalettes:Array = this.palettes;
         var layerIndex:int = 0;
         var loader:MovieLoader;
         var animationPath:String;
         var loadResult:Boolean;
         while(layerIndex < this.array7.length)
         {
            loader = new MovieLoader(this._useSmoothing);
            if(layerIndex == this.propValue165)
            {
               movieLoader1 = loader;
            }
            loader.layerId = layerIndex;
            loader.containerFile = this.array7[layerIndex];
            animationPath = ANIMATIONS + this.array7[layerIndex] + ".swf";
            loadResult = loader.load(ResourceManager.sharedInstance.resolveUrl(animationPath),this.doAction260);
            loader.palette = layerPalettes[layerIndex];
            layerIndex++;
         }
      }
      
      public function get palettes() : Array
      {
         return [0];
      }
      
      public function get isValue12() : Boolean
      {
         return true;
      }
      
      public function get stateAnimation() : String
      {
         return "MOVE_DOWN";
      }
      
      public function get propValue186() : Array
      {
         return null;
      }
      
      public function get propValue126() : Array
      {
         return [""];
      }
      
      public function get isValue47() : Boolean
      {
         return false;
      }
      
      public function get isValue15() : Boolean
      {
         return false;
      }
      
      protected function get propValue189() : Object
      {
         return new Sprite();
      }
      
      public function includesMouse() : Boolean
      {
         var loaderIndex:int = 0;
         if(this.movieLoader != null)
         {
            loaderIndex = 0;
            while(loaderIndex < this.movieLoaderList2.length)
            {
               if(this.movieLoaderList2[loaderIndex].includesMouse())
               {
                  return true;
               }
               loaderIndex++;
            }
         }
         return false;
      }
      
      private function doAction212() : void
      {
         if(this.obj8 != null)
         {
            this.movieContainer.removeChild(DisplayObject(this.obj8));
            EventListeners.removeEventListener(this.obj8,Event.ENTER_FRAME,this.doAction479);
            obj8 = null;
         }
      }
      
      private function set propValue177(param1:Object) : void
      {
         this.doAction212();
         flag125 = true;
         obj8 = param1;
         EventListeners.addEventListener(this.obj8,Event.ENTER_FRAME,this.doAction479);
         this.movieContainer.addChild(DisplayObject(this.obj8));
      }
      
      private function doAction479(param1:Event) : void
      {
         if(this.obj8 is MovieClip && this.obj8.currentFrame == 1)
         {
            if(!this.flag125)
            {
               this.doAction658();
            }
            else
            {
               flag125 = false;
            }
         }
      }
      
      public function get highlight() : int
      {
         return this._entityHighlight;
      }
      
      public function set highlight(param1:int) : void
      {
         this.movieContainer.filters = [];
         _entityHighlight = param1;
         this.updateHighlight(param1);
      }
      
      protected function updateHighlight(param1:int) : void
      {
      }
      
      protected function doAction658() : void
      {
         if(this.state == WORLD_ENTITY_CONST7 && this.flag1)
         {
            this.doAction188();
         }
      }
      
      public function doAction132() : void
      {
         var content:Object = this.propValue189;
         if(content != null)
         {
            propValue177 = content;
         }
      }
      
      protected function doAction505(param1:MovieLoader, param2:int = 0, param3:int = -1) : void
      {
         var transformMatrix:Matrix = null;
         str29 = this.stateAnimation;
         flag102 = this.isValue47;
         flag86 = this.isValue15;
         if(this.isValue12)
         {
            param1.setAnimation(this.str29,param2,param3);
            param1.doAction717(this.flag102,this.flag86);
         }
         else
         {
            obj51 = new param1[this.str29]();
            if(this.flag102 || this.flag86)
            {
               transformMatrix = this.obj51.transform.matrix;
               if(this.flag86)
               {
                  transformMatrix.d = -1;
               }
               if(this.flag102)
               {
                  transformMatrix.a = -1;
               }
               this.obj51.transform.matrix = transformMatrix;
            }
            propValue177 = this.obj51;
         }
         doAction102();
      }
      
      protected function doAction405(param1:Boolean, param2:Boolean) : void
      {
      }
      
      private function get isValue23() : Boolean
      {
         var layerFiles:Array = this.propValue126;
         if(this.array7 == null)
         {
            return false;
         }
         if(this.array7.length != layerFiles.length)
         {
            return true;
         }
         var layerIndex:int = 0;
         while(layerIndex < this.array7.length)
         {
            if(!this.flag46 && this.array7[layerIndex] != layerFiles[layerIndex] || this.flag46 && this.array7.indexOf(layerFiles[layerIndex]) < 0)
            {
               return true;
            }
            layerIndex++;
         }
         return false;
      }
      
      public function doAction867(param1:Boolean = false) : void
      {
         var loaderIndex:int = 0;
         if(this.flag33 && (param1 || this.str29 != this.stateAnimation || this.flag102 != this.isValue47 || this.flag86 != this.isValue15))
         {
            flag62 = true;
            this.doAction212();
            loaderIndex = 0;
            while(loaderIndex < this.movieLoaderList2.length)
            {
               this.doAction505(this.movieLoaderList2[loaderIndex],this.propValue76,this.propValue80);
               loaderIndex++;
            }
            flag62 = false;
            this.doAction405(this.flag102,this.flag86);
            doAction102();
         }
         this.doAction337();
      }
      
      public function doAction917(param1:Object) : void
      {
         this.movieLoaderList2.push(param1);
         this.doAction867();
      }
      
      private function doAction853(param1:MovieLoader, param2:Boolean) : void
      {
         var insertionIndex:int = 0;
         if(this.movieLoaderList2.length == 0)
         {
            if(param2)
            {
               this.movieContainer.addChild(param1);
            }
            this.movieLoaderList2.push(param1);
         }
         else
         {
            insertionIndex = 0;
            while(insertionIndex < this.movieLoaderList2.length && this.movieLoaderList2[insertionIndex].layerId <= param1.layerId)
            {
               insertionIndex++;
            }
            if(param2)
            {
               if(insertionIndex < this.movieLoaderList2.length)
               {
                  this.movieContainer.addChildAt(param1,this.movieContainer.getChildIndex(this.movieLoaderList2[insertionIndex]));
               }
               else
               {
                  this.movieContainer.addChild(param1);
               }
            }
            this.movieLoaderList2.splice(insertionIndex,0,param1);
         }
      }
      
      protected function doAction244() : void
      {
         var loader:MovieLoader = null;
         this.doAction2();
         flag49 = false;
         movieLoader = this.movieLoader2;
         flag33 = true;
         while(this.movieLoaderList1.length > 0)
         {
            loader = this.movieLoaderList1.pop() as MovieLoader;
            this.doAction853(loader,true);
         }
      }
      
      public function doAction260(param1:MovieLoader) : void
      {
         if(param1.useSmoothing != this._useSmoothing)
         {
            param1.useSmoothing = this._useSmoothing;
         }
         if(param1 == this.movieLoader1)
         {
            movieLoader2 = param1;
            this.doAction661();
            this.movieLoaderList1.push(param1);
         }
         else if(!this.flag49)
         {
            this.doAction853(param1,true);
            this.doAction505(param1);
         }
         else
         {
            this.movieLoaderList1.push(param1);
         }
      }
      
      public function get propValue128() : int
      {
         if(this.movieLoader != null)
         {
            return this.movieLoader.propValue128;
         }
         return 0;
      }
      
      public function get animationIdx() : int
      {
         if(this.movieLoader != null)
         {
            return this.movieLoader.animationIdx;
         }
         return 0;
      }
      
      public function getMovieLoader1(param1:int) : MovieLoader
      {
         var loader:MovieLoader = null;
         for each(loader in this.movieLoaderList2)
         {
            if(loader.layerId == param1)
            {
               return loader;
            }
         }
         for each(loader in this.array57)
         {
            if(loader.layerId == param1)
            {
               return loader;
            }
         }
         return null;
      }
      
      private function get isValue7() : Boolean
      {
         if(this.movieLoader == null)
         {
            return false;
         }
         var requiredLayers:Array = this.propValue186;
         var requiredIndex:int;
         var loaderIndex:int;
         if(requiredLayers != null)
         {
            requiredIndex = requiredLayers.length - 1;
            while(requiredIndex >= 0)
            {
               loaderIndex = this.movieLoaderList2.length - 1;
               while(loaderIndex >= 0)
               {
                  if(this.movieLoaderList2[loaderIndex].layerId == requiredLayers[requiredIndex])
                  {
                     break;
                  }
                  loaderIndex--;
               }
               if(loaderIndex < 0)
               {
                  return false;
               }
               requiredIndex--;
            }
         }
         return true;
      }
      
      public function doAction6(param1:MovieLoader) : void
      {
         var pendingIndex:int = this.array57.indexOf(param1);
         if(pendingIndex < 0)
         {
            param1.dispose();
         }
         else
         {
            this.array57.splice(pendingIndex,1);
            if(param1.useSmoothing != this._useSmoothing)
            {
               param1.useSmoothing = this._useSmoothing;
            }
            if(this.flag33)
            {
               this.doAction853(param1,true);
               this.doAction505(param1,this.movieLoader.animationIdx,this.movieLoader.tick);
            }
            else
            {
               flag62 = true;
               this.doAction853(param1,false);
               if(param1 == this.movieLoader1)
               {
                  movieLoader = param1;
                  this.doAction505(param1,this.propValue76,this.propValue80);
               }
               else
               {
                  this.doAction505(param1);
               }
               if(this.isValue7)
               {
                  this.doAction438(this.movieLoaderList2);
               }
               flag62 = false;
            }
            if(param1.layerId == this.propValue165)
            {
               this.doAction337();
            }
         }
      }
      
      public function get propValue76() : int
      {
         return 0;
      }
      
      public function get propValue80() : int
      {
         return -1;
      }
      
      public function doAction438(param1:Vector.<MovieLoader>) : void
      {
         flag33 = true;
         var animationIndex:int = this.movieLoader.animationIdx;
         var animationTick:int = this.movieLoader.tick;
         var loaderIndex:int = 0;
         while(loaderIndex < param1.length)
         {
            param1[loaderIndex].tick = animationTick;
            if(param1[loaderIndex].animationIdx != animationIndex)
            {
               param1[loaderIndex].animationIdx = animationIndex;
               param1[loaderIndex].draw();
            }
            this.movieContainer.addChild(DisplayObject(param1[loaderIndex]));
            loaderIndex++;
         }
         this.doAction867(true);
      }
      
      protected function doAction428() : void
      {
      }
      
      public function doAction55(param1:NPoint, param2:int, param3:Boolean = false) : void
      {
         targetPosition = param1;
         this.doAction257(param2,true,param3);
      }
      
      protected function doAction98(param1:int, param2:int, param3:int, param4:Boolean = false) : void
      {
         targetPosition = getCoords(param1,param2);
         this.doAction257(param3,true,param4);
      }
      
      public function stop() : void
      {
         this.doAction542(this.numValue6,this.numValue40,false);
      }
      
      protected function doAction234() : void
      {
         state = WORLD_ENTITY_CONST16;
      }
      
      protected function doAction333() : void
      {
         if(this.check43())
         {
            if(this.nPoint1.x == this.x && this.nPoint1.y == this.y)
            {
               this.doAction964(null);
               this.doAction325(this.intValue3,this.intValue191);
               return;
            }
            this.doAction964(null);
         }
         if(this.flag77)
         {
            state = WORLD_ENTITY_CONST16;
            this.startEffect(WORLD_ENTITY_CONST19);
         }
         else
         {
            state = WORLD_ENTITY_CONST16;
         }
         ijPoint5 = new IJPoint(this.i,this.j);
      }
      
      public function get propValue7() : IJPoint
      {
         return this.ijPoint5;
      }
      
      public function get sumStart() : int
      {
         var bounds:Rectangle = this.rect;
         return bounds.x + bounds.y - 2;
      }
      
      public function get intValue117() : int
      {
         var bounds:Rectangle = this.rect;
         return bounds.x + bounds.y + bounds.width + bounds.height;
      }
      
      public function get rect() : Rectangle
      {
         return this.rect5;
      }
      
      private function get rect4() : Rectangle
      {
         if(this.isValue47 && !this.isValue15 || !this.isValue47 && this.isValue15)
         {
            return new Rectangle(int(j - this.di / 2),int(i - this.dj / 2),this.di,this.dj);
         }
         return new Rectangle(int(j - this.dj / 2),int(i - this.di / 2),this.dj,this.di);
      }
      
      public function doAction337() : void
      {
         if(this.movieLoader != null)
         {
            di = this.movieLoader.di;
            dj = this.movieLoader.dj;
            if(this.di != 0 || this.dj != 0)
            {
               rect5 = this.rect4;
            }
         }
      }
      
      private function doAction30() : void
      {
         var layerFiles:Array = null;
         var unusedFlag:Boolean = false;
         var loaderIndex:int = 0;
         var layerIndex:int = 0;
         var insertionIndex:int = 0;
         var loader:Object = null;
         if(!this.isValue23)
         {
            layerFiles = this.propValue126;
            unusedFlag = false;
            loaderIndex = 0;
            while(loaderIndex < this.array57.length)
            {
               this.array57[loaderIndex].layerId = layerFiles.indexOf(this.array57[loaderIndex].containerFile);
               loaderIndex++;
            }
            loaderIndex = 0;
            while(loaderIndex < this.movieLoaderList2.length)
            {
               layerIndex = layerFiles.indexOf(this.movieLoaderList2[loaderIndex].containerFile);
               if(this.movieLoaderList2[loaderIndex].layerId != layerIndex)
               {
                  this.movieLoaderList2[loaderIndex].layerId = layerIndex;
                  insertionIndex = 0;
                  while(insertionIndex < loaderIndex && this.movieLoaderList2[insertionIndex].layerId < layerIndex)
                  {
                     insertionIndex++;
                  }
                  if(insertionIndex < loaderIndex)
                  {
                     this.movieContainer.setChildIndex(this.movieLoaderList2[loaderIndex],insertionIndex);
                     loader = this.movieLoaderList2[loaderIndex];
                     this.movieLoaderList2.splice(loaderIndex,1);
                     this.movieLoaderList2.splice(insertionIndex,0,loader);
                  }
               }
               loaderIndex++;
            }
         }
      }
      
      public function get propValue165() : int
      {
         return 0;
      }
      
      public function animate() : void
      {
         var completed:Boolean = false;
         var previousAnimationIndex:int = 0;
         var currentAnimationIndex:int = 0;
         var loaderIndex:int = 0;
         if(this.isValue42 && this.movieLoader != null)
         {
            if(this.flag46)
            {
               this.doAction30();
            }
            previousAnimationIndex = this.movieLoader.animationIdx;
            completed = this.movieLoader.animate();
            currentAnimationIndex = this.movieLoader.animationIdx;
            if(currentAnimationIndex != previousAnimationIndex)
            {
               loaderIndex = 0;
               while(loaderIndex < this.movieLoaderList2.length)
               {
                  if(this.movieLoaderList2[loaderIndex] != this.movieLoader)
                  {
                     this.movieLoaderList2[loaderIndex].updateAnimatioIdx(currentAnimationIndex);
                  }
                  loaderIndex++;
               }
               doAction102();
            }
            if(completed)
            {
               this.doAction658();
            }
         }
      }
      
      public function doAction80(param1:int) : void
      {
         var loaderIndex:int = 0;
         while(loaderIndex < this.movieLoaderList2.length)
         {
            this.movieLoaderList2[loaderIndex].updateAnimatioIdx(param1);
            loaderIndex++;
         }
      }
      
      public function set isValue55(param1:Boolean) : void
      {
         flag111 = param1;
      }
      
      public function get isValue55() : Boolean
      {
         return this.flag111;
      }
      
      protected function get isValue21() : Boolean
      {
         return true;
      }
      
      protected function get isValue18() : Boolean
      {
         return !this.flag123;
      }
      
      public function check28() : Boolean
      {
         var currentTime:int = getTimer();
         var timeCaughtUp:Boolean = true;
         var previousUpdateTime:int = this.intValue126;
         var largeTimeGap:Boolean = false;
         if(currentTime - this.intValue126 > this.intValue195)
         {
            if(!this.isValue18)
            {
               currentTime = this.intValue126 + this.intValue195;
               timeCaughtUp = false;
            }
            else
            {
               largeTimeGap = true;
            }
         }
         intValue126 = currentTime;
         var nextPoint:NPoint;
         var previousSecondaryCell:IJPoint = getSecIJCoords(this.x,this.y);
         var previousI:int = i;
         var previousJ:int = j;
         var previousX:Number = this.x;
         var previousY:Number = this.y;
         numValue6 = previousX;
         numValue40 = previousY;
         var targetCell:IJPoint = getIJCoords(this.targetPosition.x,this.targetPosition.y + 1);
         var moveDuration:Number = this.intValue10 - this.startTime;
         var elapsedTime:int = currentTime - this.startTime;
         var previousEndTime:int = this.intValue10;
         var pathResult:int;
         var newCellRejected:Boolean;
         var cellYOffset:int = 0;
         if(elapsedTime >= moveDuration)
         {
            x = this.targetPosition.x;
            y = this.targetPosition.y;
            i = targetCell.i;
            j = targetCell.j;
            this.doAction709();
            if(this.isValue21 && !this.isValue45)
            {
               newCellRejected = !world.handlePlayerNewCell(this);
            }
            else
            {
               newCellRejected = false;
            }
            if(this.nPointList1 == null && newCellRejected && (this.x != this.numValue10 || this.y != this.startY))
            {
               pathResult = this.getInt8(previousX,previousY);
               if(this.state != WORLD_ENTITY_CONST1)
               {
                  return true;
               }
               if(pathResult == WORLD_ENTITY_CONST14)
               {
                  x = previousX;
                  y = previousY;
                  i = previousI;
                  j = previousJ;
                  if(largeTimeGap)
                  {
                     flag123 = true;
                     intValue126 = previousUpdateTime;
                     return false;
                  }
                  this.targetPosition.x = this.x;
                  this.targetPosition.y = this.y;
                  this.doAction709();
                  this.doAction333();
                  return true;
               }
               else if(pathResult == WORLD_ENTITY_CONST12)
               {
                  x = previousX;
                  y = previousY;
                  this.doAction709();
                  return false;
               }
               if(this.x == this.numValue34 && this.y == this.numValue31)
               {
                  this.doAction333();
                  if(previousI != i || previousJ != j)
                  {
                     this.doAction143();
                     this.doAction867();
                  }
                  return true;
               }
            }
            else
            {
               if(this.x == this.numValue34 && this.y == this.numValue31)
               {
                  this.doAction333();
                  if(previousI != i || previousJ != j)
                  {
                     this.doAction143();
                     this.doAction867();
                  }
                  return true;
               }
               else if(this.nPointList1 != null)
               {
                  if(this.nPointList1.length == 0)
                  {
                     nPointList1 = null;
                     this.doAction325(this.numValue34,this.numValue31,false);
                     if(this.state != WORLD_ENTITY_CONST1)
                     {
                        return true;
                     }
                  }
                  else
                  {
                     nextPoint = this.nPointList1.pop();
                     this.doAction929(nextPoint.x,nextPoint.y);
                  }
                  if(this.state == WORLD_ENTITY_CONST1)
                  {
                     timeAdjustment = this.startTime - previousEndTime;
                     startTime -= timeAdjustment;
                     intValue10 -= timeAdjustment;
                     return false;
                  }
               }
               else
               {
                  this.doAction325(this.numValue34,this.numValue31,false);
                  if(this.state != WORLD_ENTITY_CONST1)
                  {
                     return true;
                  }
               }
            }
         }
         else
         {
            nextX = this.numValue10 + (this.targetPosition.x - this.numValue10) * elapsedTime / moveDuration;
            nextY = this.startY + (this.targetPosition.y - this.startY) * elapsedTime / moveDuration;
            cellYOffset = this.numValue53;
            nextCell = getIJCoords(nextX,nextY + cellYOffset);
            if(this.check8(nextCell))
            {
               x = nextX;
               y = nextY;
               currentCell = getIJCoords(this.x,this.y + cellYOffset);
               i = currentCell.i;
               j = currentCell.j;
               this.doAction709();
            }
            else
            {
               this.doAction542(previousX,previousY);
               return true;
            }
         }
         var currentSecondaryCell:IJPoint = getSecIJCoords(this.x,this.y);
         var timeAdjustment:int;
         var nextX:Number;
         var nextY:Number;
         var nextCell:IJPoint;
         var currentCell:IJPoint;
         if(this.nPointList1 == null && (previousSecondaryCell.i != currentSecondaryCell.i || previousSecondaryCell.j != currentSecondaryCell.j))
         {
            pathResult = this.getInt44(previousX,previousY,cellYOffset);
            if(pathResult == WORLD_ENTITY_CONST17)
            {
               return true;
            }
            if(pathResult == WORLD_ENTITY_CONST12)
            {
               return false;
            }
         }
         if(this.isValue21 && !this.isValue45)
         {
            newCellRejected = !world.handlePlayerNewCell(this);
         }
         else
         {
            newCellRejected = false;
         }
         if(this.nPointList1 == null && newCellRejected && (this.x != this.numValue10 || this.y != this.startY))
         {
            pathResult = this.getInt8(previousX,previousY + cellYOffset);
            if(this.gameState != WORLD_ENTITY_CONST1)
            {
               return true;
            }
            if(pathResult == WORLD_ENTITY_CONST14)
            {
               x = previousX;
               y = previousY;
               i = previousI;
               j = previousJ;
               if(largeTimeGap)
               {
                  flag123 = true;
                  intValue126 = previousUpdateTime;
                  return false;
               }
               this.targetPosition.x = this.x;
               this.targetPosition.y = this.y;
               this.doAction709();
               this.doAction333();
               return true;
            }
            else if(pathResult == WORLD_ENTITY_CONST12)
            {
               x = previousX;
               y = previousY;
               this.doAction709();
               return false;
            }
         }
         if(previousI != i || previousJ != j)
         {
            this.doAction143();
            this.doAction867();
         }
         return timeCaughtUp;
      }
      
      private var _storedX:Number;

      private var _storedY:Number;

      private var flag52:Boolean = false;

      override public function set x(param1:Number) : void
      {
         _storedX = param1;
         super.x = int(param1);
      }
      
      override public function get x() : Number
      {
         return this._storedX;
      }
      
      override public function set y(param1:Number) : void
      {
         _storedY = param1;
         super.y = int(param1);
      }
      
      override public function get y() : Number
      {
         return this._storedY;
      }
      
      public function processState(param1:int) : void
      {
         var currentTime:int = 0;
         switch(this.state)
         {
            case WORLD_ENTITY_CONST1:
               while(!this.check28())
               {
               }
               flag123 = false;
               this.doAction500();
               break;
            case WORLD_ENTITY_CONST7:
               currentTime = getTimer();
               if(this.intValue229 >= 0)
               {
                  if(this.intValue229 <= currentTime)
                  {
                     this.doAction188();
                  }
                  else if(this.progress)
                  {
                     this.progress.propValue27 = currentTime - this.intValue42;
                  }
               }
               break;
         }
      }
      
      public function getInt8(param1:Number, param2:Number) : int
      {
         var nextPoint:NPoint = null;
         if(!this.check41(i / world.MAP_CELL_FACTOR,j / world.MAP_CELL_FACTOR))
         {
            this.stop();
            return WORLD_ENTITY_CONST4;
         }
         nPointList1 = world.passCells(i,j,param1,param2,this.targetPosition.x,this.targetPosition.y,this.x,this.y,this);
         if(this.nPointList1 == null)
         {
            return WORLD_ENTITY_CONST14;
         }
         if(this.nPointList1.length != 0)
         {
            x = param1;
            y = param2;
            this.doAction709();
            nextPoint = this.nPointList1.pop();
            this.doAction929(nextPoint.x,nextPoint.y);
            return WORLD_ENTITY_CONST12;
         }
         return WORLD_ENTITY_CONST4;
      }
      
      public function check58(param1:Composition) : Boolean
      {
         return true;
      }
      
      public function getInt44(param1:Number, param2:Number, param3:int = 0) : int
      {
         var nextPoint:NPoint;
         var currentCell:IJPoint = WorldItem.getSecIJCoords(this.x,this.y);
         var scanCell:IJPoint = new IJPoint(currentCell.i - 1,currentCell.j - 1);
         var composition:Composition;
         var path:Vector.<NPoint>;
         while(scanCell.i <= currentCell.i + 2 && scanCell.j <= currentCell.j + 2)
         {
            composition = world.getNotPassebleComposition(this,scanCell);
            if(composition != null)
            {
               if(!this.check58(composition))
               {
                  this.doAction542(param1,param2,false);
                  return WORLD_ENTITY_CONST17;
               }
               if(this.check50(composition))
               {
                  path = composition.getNPoint3(this.numValue10,this.startY,this.numValue34,this.numValue31,this);
                  if(path == null || path.length == 0)
                  {
                     this.doAction542(param1,param2);
                     return WORLD_ENTITY_CONST14;
                  }
                  if(path.length > 0)
                  {
                     x = param1;
                     y = param2;
                     this.doAction709();
                     nextPoint = path.pop();
                     nPointList1 = path;
                     this.doAction929(nextPoint.x,nextPoint.y);
                     return WORLD_ENTITY_CONST12;
                  }
               }
            }
         }
         return WORLD_ENTITY_CONST4;
      }
      
      protected function check50(param1:Composition) : Boolean
      {
         return true;
      }
      
      public function check8(param1:IJPoint) : Boolean
      {
         return true;
      }
      
      protected function doAction542(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         var currentCell:IJPoint = WorldItem.getIJCoords(this.x,this.y);
         x = param1;
         y = param2;
         this.targetPosition.x = this.x;
         this.targetPosition.y = this.y;
         i = currentCell.i;
         j = currentCell.j;
         this.doAction709();
         if(param3)
         {
            this.doAction333();
         }
         else
         {
            this.doAction234();
         }
      }
      
      public function update() : void
      {
         var animationIndex:int = 0;
         var loaderIndex:int;
         if(this.movieLoader != null && this.movieLoader.str29 == this.stateAnimation)
         {
            animationIndex = this.movieLoader.animationIdx;
         }
         this.doAction2();
         this.init();
         if(this.movieLoader != null)
         {
            loaderIndex = 0;
            while(loaderIndex < this.movieLoaderList2.length)
            {
               this.movieLoaderList2[loaderIndex].setAnimation(this.stateAnimation,animationIndex);
               loaderIndex++;
            }
         }
      }
      
      public function doAction2() : void
      {
         var loader:Object = null;
         this.doAction212();
         if(this.isValue12)
         {
            while(this.movieLoaderList2.length > 0)
            {
               loader = this.movieLoaderList2.pop();
               loader.dispose();
            }
         }
         else
         {
            animationLoader1.doAction703(this);
         }
         while(this.movieContainer.numChildren > 0)
         {
            this.movieContainer.removeChildAt(0);
         }
         array57 = new Array();
      }
      
      public function dispose() : void
      {
         SoundManager.doAction89(this);
         this.doAction2();
         flag121 = true;
      }
      
      protected function doAction709() : void
      {
      }
      
      public function doAction143() : void
      {
      }
      
      public function doAction186() : void
      {
         var position:NPoint = getCoords(i,j);
         x = position.x + cJHCellSize;
         y = position.y;
         numValue6 = this.x;
         numValue40 = this.y;
         this.doAction709();
      }
      
      public function doAction612() : void
      {
         var cell:IJPoint = getIJCoords(this.x,this.y);
         var cellChanged:Boolean = i != cell.i || j != cell.j;
         i = cell.i;
         j = cell.j;
         if(cellChanged)
         {
            this.doAction143();
         }
         this.doAction709();
      }
      
      public function doAction108(param1:NPoint) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         numValue6 = param1.x;
         numValue40 = param1.y;
         this.doAction612();
      }
      
      public function doAction605(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
         numValue6 = param1;
         numValue40 = param2;
         this.doAction612();
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         var cellChanged:Boolean = i != param1 || j != param2;
         i = param1;
         j = param2;
         this.doAction186();
         if(cellChanged)
         {
            this.doAction143();
         }
      }
      
      public function set dir(param1:int) : void
      {
         _dir = param1;
         this.doAction867();
      }
      
      public function get dir() : int
      {
         return this._dir;
      }
      
      public function doAction45(param1:NPoint) : void
      {
         this.doAction325(param1.x,param1.y);
      }
      
      public function doAction909(param1:IJPoint) : void
      {
         this.moveTo(param1.i,param1.j);
      }
      
      protected function get isValue40() : Boolean
      {
         return true;
      }
      
      public function getNPoint5(param1:int, param2:int) : NPoint
      {
         return null;
      }
      
      protected function check43() : Boolean
      {
         return this.nPoint1 != null;
      }
      
      protected function doAction964(param1:NPoint = null) : void
      {
         var targetCell:IJPoint = null;
         if(param1 != null)
         {
            targetCell = getIJCoords(param1.x,param1.y);
            if(!world.cellPassebleFunction(targetCell.i / world.MAP_CELL_FACTOR,targetCell.j / world.MAP_CELL_FACTOR,this))
            {
               nPoint1 = null;
               return;
            }
         }
         nPoint1 = param1;
      }
      
      public function getInt22() : int
      {
         var cellValue:int = world.getCell(i / world.MAP_CELL_FACTOR,j / world.MAP_CELL_FACTOR);
         var sampleX:int;
         var sampleY:int;
         var sampleCell:IJPoint;
         if(cellValue == 0)
         {
            sampleX = this.x - 4;
            while(sampleX <= this.x + 4)
            {
               sampleY = this.y - 4;
               while(sampleY <= this.y + 4)
               {
                  sampleCell = getIJCoords(sampleX,sampleY);
                  cellValue = world.getCell(sampleCell.i / world.MAP_CELL_FACTOR,sampleCell.j / world.MAP_CELL_FACTOR);
                  if(cellValue > 0)
                  {
                     return cellValue;
                  }
                  sampleY += 4;
               }
               sampleX += 4;
            }
         }
         return cellValue;
      }
      
      protected function getNPoint6(param1:int, param2:int) : NPoint
      {
         return null;
      }
      
      public function doAction325(param1:int, param2:int, param3:Boolean = true) : void
      {
         var targetCell:IJPoint = getIJCoords(param1,param2);
         var targetCellValue:int = world.getCell(targetCell.i / world.MAP_CELL_FACTOR,targetCell.j / world.MAP_CELL_FACTOR);
         var currentCellValue:int = this.getInt22();
         if(param3 && mapLevel < 1)
         {
            this.doAction964(this.getNPoint6(currentCellValue,targetCellValue));
            if(this.check43())
            {
               intValue136 = targetCell.i;
               intValue105 = targetCell.j;
               intValue3 = param1;
               intValue191 = param2;
               param1 = this.nPoint1.x;
               param2 = this.nPoint1.y;
               targetCell = getIJCoords(param1,param2);
            }
         }
         var targetLocation:int = world.getLocationIdx(targetCell.i / world.MAP_CELL_FACTOR,targetCell.j / world.MAP_CELL_FACTOR);
         var currentLocation:int = world.getLocationIdx(i / world.MAP_CELL_FACTOR,j / world.MAP_CELL_FACTOR);
         var teleportPoint:NPoint;
         var transitionPoint:NPoint;
         if(targetLocation != -1 && currentLocation != -1 && targetLocation != currentLocation && this.isValue40)
         {
            composition1 = world.getTeleportComposition(this,targetLocation);
            if(this.composition1 != null)
            {
               teleportPoint = this.composition1.propValue132;
               flag77 = true;
               intValue114 = param1;
               intValue4 = param2;
               param1 = teleportPoint.x;
               param2 = teleportPoint.y;
               intValue107 = targetLocation;
               intValue141 = currentLocation;
            }
            else
            {
               transitionPoint = this.getNPoint5(currentLocation,targetLocation);
               if(transitionPoint != null)
               {
                  flag77 = true;
                  intValue114 = param1;
                  intValue4 = param2;
                  param1 = transitionPoint.x;
                  param2 = transitionPoint.y;
                  intValue107 = targetLocation;
                  intValue141 = currentLocation;
               }
               else
               {
                  return;
               }
            }
         }
         else if(param3)
         {
            flag77 = false;
         }
         nPointList1 = null;
         numValue10 = this.x;
         startY = this.y;
         numValue34 = param1;
         numValue31 = param2;
         targetPosition = new NPoint(param1,param2);
         if(this.getInt44(this.x,this.y) == WORLD_ENTITY_CONST4)
         {
            this.doAction929(this.numValue34,this.numValue31);
         }
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         var position:NPoint = getCoords(param1,param2);
         ijPoint5 = new IJPoint(param1,param2);
         this.doAction325(position.x,position.y);
      }
      
      public function doAction806(param1:NPoint) : void
      {
         x += param1.x;
         y += param1.y;
         this.doAction612();
         if(this.targetPosition)
         {
            this.targetPosition.x += param1.x;
            this.targetPosition.y += param1.y;
         }
         numValue10 += param1.x;
         startY += param1.y;
         numValue34 += param1.x;
         numValue31 += param1.y;
         intValue114 += param1.x;
         intValue4 += param1.y;
         intValue3 += param1.x;
         intValue191 += param1.y;
      }
      
      protected function doAction929(param1:int, param2:int) : void
      {
         numValue10 = this.x;
         startY = this.y;
         this.startTime = getTimer();
         intValue126 = this.startTime;
         targetPosition = new NPoint(param1,param2);
         state = WORLD_ENTITY_CONST1;
         var distance:Number = Math.sqrt((this.numValue10 - this.targetPosition.x) * (this.numValue10 - this.targetPosition.x) + (this.startY - this.targetPosition.y) * (this.startY - this.targetPosition.y));
         this.intValue10 = this.startTime + distance * 1000 / this.speed;
      }
      
      public function get state() : int
      {
         return this.gameState;
      }
      
      protected function doAction69() : void
      {
      }
      
      public function set state(param1:int) : void
      {
         if(this.gameState == WORLD_ENTITY_CONST7)
         {
            this.doAction196();
         }
         if(this.intValue22 != WORLD_ENTITY_CONST9 && this.flag134)
         {
            if(this.effect != null)
            {
               this.effect.end();
               this.doAction69();
               this.doAction67();
            }
         }
         gameState = param1;
         switch(this.gameState)
         {
            case WORLD_ENTITY_CONST1:
            case WORLD_ENTITY_CONST7:
               this.doAction428();
               break;
         }
         this.doAction867();
      }
      
      override public function isPlayerNear(param1:*) : int
      {
         if(mapLevel > param1.mapLevel)
         {
            return -1;
         }
         if(mapLevel < param1.mapLevel)
         {
            return 1;
         }
         if(isBackground)
         {
            return 1;
         }
         if(param1.isBackground)
         {
            return -1;
         }
         if(this.di != 0 || this.dj != 0)
         {
            if(WorldEntity(param1).di != 0 || WorldEntity(param1).dj != 0)
            {
               return getInt18(this.rect,WorldEntity(param1).rect,this.sumStart,this.intValue117,WorldEntity(param1).sumStart,WorldEntity(param1).intValue117);
            }
            return getInt47(this.rect,param1,this.sumStart,this.intValue117);
         }
         else if(WorldEntity(param1).di != 0 || WorldEntity(param1).dj != 0)
         {
            return getInt25(getInt47(WorldEntity(param1).rect,this,WorldEntity(param1).sumStart,WorldEntity(param1).intValue117));
         }
         if(i + j >= param1.i + param1.j - 2 && i + j <= param1.i + param1.j + 3)
         {
            if(i - j > param1.i - param1.j)
            {
               return -1;
            }
            if(i - j < param1.i - param1.j)
            {
               return 1;
            }
         }
         return 0;
      }
      
      protected function doAction67() : void
      {
         if(this.effect != null)
         {
            this.effect.removeEndListener(this.doAction508);
            effect = null;
            intValue22 = WORLD_ENTITY_CONST9;
         }
      }
      
      public function startEffect(param1:int) : void
      {
         intValue22 = param1;
         effect = this.getTweenEffect1();
         if(this.effect != null)
         {
            this.effect.addEndListener(this.doAction508);
            this.effect.play(this);
         }
      }
      
      private function doAction508(param1:TweenEffect) : void
      {
         var previousEffect:TweenEffect = this.effect;
         this.doAction17();
         if(previousEffect == this.effect)
         {
            this.effect.removeEndListener(this.doAction508);
            this.doAction69();
            effect = null;
            intValue22 = WORLD_ENTITY_CONST9;
         }
      }
      
      protected function doAction17() : void
      {
         var teleportComposition:Composition = null;
         var teleportPoint:NPoint = null;
         var transitionPoint:NPoint = null;
         switch(this.intValue22)
         {
            case WORLD_ENTITY_CONST19:
               teleportComposition = world.getTeleportComposition(this,this.intValue141,this.composition1);
               if(teleportComposition != null)
               {
                  teleportPoint = teleportComposition.propValue132;
                  teleportPoint.x -= 1;
                  this.doAction108(teleportPoint);
                  this.startEffect(WORLD_ENTITY_CONST8);
               }
               else
               {
                  transitionPoint = this.getNPoint5(this.intValue107,this.intValue141);
                  if(transitionPoint != null)
                  {
                     this.doAction108(transitionPoint);
                     this.startEffect(WORLD_ENTITY_CONST8);
                  }
                  else
                  {
                     flag77 = false;
                  }
               }
               break;
            case WORLD_ENTITY_CONST8:
               flag77 = false;
               this.doAction325(this.intValue114,this.intValue4);
               break;
            case WORLD_ENTITY_CONST5:
               this.doAction108(this.nPoint3);
               this.startEffect(WORLD_ENTITY_CONST18);
               break;
            case WORLD_ENTITY_CONST18:
               this.doAction333();
               break;
         }
      }
      
      protected function getTweenEffect1() : TweenEffect
      {
         return null;
      }
      
      protected function doAction257(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         this.flag1 = param3;
         state = WORLD_ENTITY_CONST7;
         intValue42 = getTimer();
         if(param1 < 0)
         {
            intValue229 = -1;
         }
         else
         {
            intValue229 = this.intValue42 + param1;
         }
         if(param2 && this.isValue16)
         {
            this.doAction700(param1);
         }
      }
      
      protected function get isValue16() : Boolean
      {
         return true;
      }
      
      protected function doAction100(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         intValue42 = getTimer();
         if(param1 < 0)
         {
            intValue229 = -1;
         }
         else
         {
            intValue229 = this.intValue42 + param1;
         }
         if(param2)
         {
            this.doAction700(param1,param3);
         }
      }
      
      protected function doAction188() : void
      {
      }
      
      protected function doAction661() : void
      {
      }
      
      protected function getCounterSprite1(param1:int = 0) : CounterSprite
      {
         return new CounterSprite(param1);
      }
      
      protected function doAction700(param1:int, param2:Boolean = true) : void
      {
         this.doAction196();
         if(param2 || this.progress == null)
         {
            progress = this.getCounterSprite1(param1);
         }
         addChild(this.progress);
         doAction102();
      }
      
      protected function doAction415(param1:int) : void
      {
         if(this.progress)
         {
            this.progress.propValue27 = param1;
            doAction102();
         }
      }
      
      protected function doAction196() : void
      {
         if(this.progress != null)
         {
            removeChild(this.progress);
            progress = null;
            doAction102();
         }
      }
      
      public function get hintData() : HintInfo
      {
         return null;
      }
      
      public function get isValue45() : Boolean
      {
         return false;
      }
      
      public function get processing() : Boolean
      {
         return this._processing;
      }
      
      public function set processing(param1:Boolean) : void
      {
         _processing = param1;
      }
      
      public function get unlocked() : Boolean
      {
         return this._entityUnlocked;
      }
      
      public function set unlocked(param1:Boolean) : void
      {
         _entityUnlocked = param1;
      }
      
      public function doAction592() : void
      {
         flag52 = true;
      }
      
      public function doAction420() : void
      {
         flag52 = false;
      }
      
      protected function get propValue24() : CounterSprite
      {
         return this.progress;
      }
      
      protected function set propValue24(param1:CounterSprite) : void
      {
         progress = param1;
      }
      
      public function get propValue97() : int
      {
         return i;
      }
      
      public function get propValue154() : int
      {
         return j;
      }
      
      override public function get uid() : String
      {
         return "playerItem" + this._id;
      }
      
      public function get propValue72() : int
      {
         return 1;
      }
      
      public function check41(param1:int, param2:int) : Boolean
      {
         return true;
      }
      
      public function get cursorId() : int
      {
         return -1;
      }
      
      protected function get propValue194() : int
      {
         return 70;
      }
      
      public function set isValue60(param1:Boolean) : void
      {
         flag134 = param1;
      }
      
      public function get isValue31() : Boolean
      {
         return this.flag114;
      }
      
      public function set isValue31(param1:Boolean) : void
      {
         flag114 = param1;
      }
      
      public function get _isChildOver() : Boolean
      {
         return this.flag52;
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

