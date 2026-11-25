package game.world
{
   import core.system.StateSystem;
   import core.system.TimerUtil;
   import com.flashdynamix.motion.TweensyZero;
   import core.ui.HintInfo;
   import game.actions.WorldActions;
   import core.effects.TweenEffect;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   
   public class Composition implements IProcessable
   {
      
      public static const COMPOSITION_CONST1:int = 1;
      
      public static const COMPOSITION_CONST2:int = 2;
      
      public static const COMPOSITION_CONST5:int = 0;
      
      public static const COMPOSITION_CONST6:int = 1;
      
      public static const COMPOSITION_CONST3:int = 2;
      
      public static const COMPOSITION_CONST9:int = 3;
      
      private static const COMPOSITION_CONST4:int = 0;
      
      private static const COMPOSITION_CONST8:int = 1;
      
      private static const COMPOSITION_CONST7:int = 2;
      
      private var _id:int;
      
      public var _compositionI:int;
      
      public var _compositionJ:int;
      
      public var type:String;
      
      public var str18:String;
      
      private var _compositionRotation:int;
      
      public var objectGroup1:ObjectGroup;
      
      protected var worldObjectList2:Vector.<WorldObject> = new Vector.<WorldObject>();
      
      private var objectFactory2:ObjectFactory;
      
      public var highlight:int = 0;
      
      protected var world:WorldBase;
      
      private var rect9:Rectangle;
      
      private var _compositionState:int = 0;
      
      protected var intValue62:int;
      
      private var flag114:Boolean;
      
      private var _compositionBlocked:Boolean;
      
      protected var _processing:Boolean;
      
      public var flag42:Boolean;
      
      protected var compositionList4:Vector.<Composition> = new Vector.<Composition>();
      
      public var composition3:Composition = null;
      
      public var compositionList1:Vector.<Composition> = new Vector.<Composition>();
      
      protected var _compositionHidden:Boolean = false;
      
      public var unlocked:Boolean = false;
      
      private var _compositionAlpha:Number = 1;
      
      private var numValue49:Number = 1;
      
      private var flag75:Boolean = true;
      
      private var intValue34:int = 0;
      
      private var intValue5:int = -1;
      
      private var array26:Array = new Array();
      
      private var rect3:Rectangle;
      
      private var obj14:Object;
      
      private var composition2:Composition;
      
      private var intValue140:int;
      
      protected var data:Object;
      
      private var _compositionCursorId:int = 0;
      
      private var flag122:Boolean = true;
      
      private var array39:Array = [];
      
      private var _isOver:Boolean = false;
      
      public function Composition()
      {
         super();
      }
      
      public static function check42(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         var crossProduct:Number = (param3 - param1) * (param6 - param2) - (param4 - param2) * (param5 - param1);
         return Math.abs(crossProduct) < 20;
      }
      
      public static function getNPoint8(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = true) : NPoint
      {
         var denominator:Number = (param8 - param6) * (param3 - param1) - (param7 - param5) * (param4 - param2);
         var firstNumerator:Number = (param7 - param5) * (param2 - param6) - (param8 - param6) * (param1 - param5);
         var secondNumerator:Number = (param3 - param1) * (param2 - param6) - (param4 - param2) * (param1 - param5);
         if(!param9 && (denominator == 0 || firstNumerator == 0 || secondNumerator == 0))
         {
            return null;
         }
         if(denominator == 0)
         {
            return null;
         }
         var firstFraction:Number = firstNumerator / denominator;
         var secondFraction:Number = secondNumerator / denominator;
         if(firstFraction > 1 || secondFraction < -0.04 || secondFraction > 1)
         {
            return null;
         }
         return new NPoint(param1 + firstFraction * (param3 - param1),param2 + firstFraction * (param4 - param2));
      }
      
      public function initComposition(param1:WorldBase, param2:ObjectGroup, param3:ObjectFactory, param4:String, param5:String, param6:Object = null) : void
      {
         var worldObject:WorldObject = null;
         var cell:CellRef = null;
         this.world = param1;
         this.type = param4;
         this.str18 = param5;
         this.objectFactory2 = param3;
         this.objectGroup1 = param2;
         this.data = param6;
         flag42 = param2.flag42;
         rect9 = new Rectangle(param2.rect.x,param2.rect.y,param2.rect.width,param2.rect.height);
         rect3 = new Rectangle(param2.rect.x,param2.rect.y,param2.rect.width,param2.rect.height);
         intValue140 = 0;
         var index:int = 0;
         while(index < param2.objects.length)
         {
            cell = param2.objects[index];
            worldObject = param3.createObject(this,cell.intValue137,cell.intValue110,cell.intValue39,param4,param5);
            if(this.intValue140 < worldObject.mapLevel)
            {
               intValue140 = worldObject.mapLevel;
            }
            this.worldObjectList2.push(worldObject);
            index++;
         }
         this.compositionList1.push(this);
      }
      
      public function get isOver() : Boolean
      {
         return this._isOver;
      }
      
      public function check52(sideId:int, player:WorldEntity) : Boolean
      {
         var cell:Vector.<Composition>;
         var rect:Rectangle;
         var c:Composition;
         if(!player.check58(this))
         {
            try
            {
               rect = this.propValue106;
               switch(sideId)
               {
                  case COMPOSITION_CONST5:
                     cell = this.world.propValue105[rect.y][rect.x - 2];
                     break;
                  case COMPOSITION_CONST6:
                     cell = this.world.propValue105[rect.y + rect.height][rect.x];
                     break;
                  case COMPOSITION_CONST3:
                     cell = this.world.propValue105[rect.y][rect.x + rect.width];
                     break;
                  case COMPOSITION_CONST9:
                     cell = this.world.propValue105[rect.y - 2][rect.x];
                     break;
               }
            }
            catch(e:Error)
            {
               cell = null;
            }
            if(cell != null)
            {
               for each(c in cell)
               {
                  if(!player.check58(c))
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this.world.doAction317(this,param1);
         _id = param1;
      }
      
      public function get isValue41() : Boolean
      {
         return this.flag122;
      }
      
      public function set isValue41(param1:Boolean) : void
      {
         flag122 = param1;
         if(param1 && this.id == 0)
         {
            id = this.world.uintValue17;
            ++this.world.uintValue17;
         }
      }
      
      public function init() : void
      {
      }
      
      public function set cursorId(param1:int) : void
      {
         _compositionCursorId = param1;
      }
      
      public function get cursorId() : int
      {
         return this._compositionCursorId;
      }
      
      public function set managementComposition(param1:Composition) : void
      {
         composition2 = param1;
      }
      
      public function get managementComposition() : Composition
      {
         if(this.composition2 == null)
         {
            return this;
         }
         return this.composition2;
      }
      
      public function set propValue32(param1:Rectangle) : void
      {
         if(this.flag114)
         {
            this.world.doAction40(this);
            rect3 = param1;
            this.world.doAction779(this);
         }
         else
         {
            rect3 = param1;
         }
      }
      
      public function get propValue32() : Rectangle
      {
         return this.rect3;
      }
      
      public function dispose() : void
      {
         TweensyZero.doAction618(this);
         while(this.worldObjectList2.length > 0)
         {
            this.worldObjectList2.pop().unloadMovies();
         }
         while(this.array39.length > 0)
         {
            this.doAction930(this.array39[0]);
         }
      }
      
      public function doAction23(param1:Composition) : void
      {
         rotate = param1.rotate;
      }
      
      public function get rotate() : int
      {
         return this._compositionRotation;
      }
      
      public function set rotate(param1:int) : void
      {
         _compositionRotation = param1;
      }
      
      public function get propValue183() : int
      {
         return 0;
      }
      
      public function doAction473(param1:Object) : void
      {
         this.array26.push(param1);
      }
      
      public function doAction268(param1:Object) : void
      {
         var index:int = this.array26.indexOf(param1);
         if(index >= 0)
         {
            this.array26.splice(index,1);
         }
      }
      
      public function doAction760(param1:Object) : void
      {
         this.doAction473(param1);
         StateSystem.dispatch(WorldActions.WORLD_ADD_TO_UI_LAYER,param1);
         this.array39.push(param1);
      }
      
      public function doAction930(param1:Object) : void
      {
         this.doAction268(param1);
         StateSystem.dispatch(WorldActions.WORLD_REMOVE_FROM_UI_LAYER,param1);
         var index:int = this.array39.indexOf(param1);
         if(index >= 0)
         {
            this.array39.splice(index,1);
         }
      }
      
      public function check9(param1:Object) : Boolean
      {
         return this.array39.indexOf(param1) > -1;
      }
      
      public function get propValue179() : Vector.<Composition>
      {
         return this.compositionList1;
      }
      
      public function get propValue170() : int
      {
         return this.intValue34;
      }
      
      public function set propValue170(param1:int) : void
      {
         intValue34 = param1;
         if(this.flag75)
         {
            this.setDefaultHighlight();
         }
      }
      
      protected function mouseOverHandler() : void
      {
      }
      
      protected function mouseOutHandler() : void
      {
      }
      
      public function get propValue67() : int
      {
         var maxIndex:int = 0;
         var objectIndex:int;
         var index:int = 0;
         while(index < this.worldObjectList2.length)
         {
            objectIndex = this.worldObjectList2[index].maxAnimIdx;
            if(objectIndex > maxIndex)
            {
               maxIndex = objectIndex;
            }
            index++;
         }
         return maxIndex;
      }
      
      public function get soundRepeatId() : String
      {
         return "c_" + this.id;
      }
      
      public function get uid() : String
      {
         return "c_" + this.id;
      }
      
      public function get hasSoundCoords() : Boolean
      {
         return true;
      }
      
      public function get soundX() : int
      {
         return this.propValue42.x;
      }
      
      public function get soundY() : int
      {
         return this.propValue42.y;
      }
      
      public function get propValue137() : int
      {
         return COMPOSITION_CONST1 | COMPOSITION_CONST2;
      }
      
      public function doAction872() : void
      {
      }
      
      public function doAction464() : void
      {
         var composition:Composition = null;
         while(this.compositionList4.length > 0)
         {
            composition = this.compositionList4[0];
            this.doAction852(composition);
            this.world.doAction173(composition);
         }
      }
      
      public function doAction726() : void
      {
      }
      
      public function get hintData() : HintInfo
      {
         return null;
      }
      
      public function set isValue31(param1:Boolean) : void
      {
         flag114 = param1;
      }
      
      public function get isValue31() : Boolean
      {
         return this.flag114;
      }
      
      public function process() : void
      {
      }
      
      public function doAction346(param1:Composition) : void
      {
         this.compositionList4.push(param1);
      }
      
      public function doAction852(param1:Composition) : void
      {
         this.compositionList4.splice(this.compositionList4.indexOf(param1),1);
      }
      
      protected function doAction876() : void
      {
         var cell:CellRef = null;
         var index:int = 0;
         while(index < this.worldObjectList2.length)
         {
            cell = this.objectGroup1.objects[index];
            this.worldObjectList2[index].setPos(this._compositionI + cell.intValue110,this._compositionJ + cell.intValue137);
            index++;
         }
      }
      
      public function doAction486(param1:Composition) : void
      {
         param1.addGroupComposition(this);
         var index:int = 1;
         while(index < this.compositionList1.length)
         {
            param1.addGroupComposition(this.compositionList1[index]);
            this.compositionList1[index].addGroupComposition(param1);
            index++;
         }
         this.addGroupComposition(param1);
      }
      
      public function addGroupComposition(param1:Composition) : void
      {
         this.compositionList1.push(param1);
      }
      
      public function removeGroupComposition(param1:Composition) : void
      {
         this.compositionList1.splice(this.compositionList1.indexOf(param1),1);
      }
      
      public function doAction121(param1:int) : void
      {
         flag75 = false;
         this.setHighlight(param1);
      }
      
      public function doAction83() : void
      {
         flag75 = true;
         this.setHighlight(this.propValue170);
      }
      
      public function doAction823() : void
      {
         _isOver = true;
         this.mouseOverHandler();
      }
      
      public function setSelectedHighlight(param1:int) : void
      {
         this.doAction121(param1);
         if(param1 == WorldObject.HIGHLIGHT_1 && !this._isOver)
         {
            this.doAction823();
         }
      }
      
      public function setDefaultHighlight() : void
      {
         this.doAction83();
         if(this._isOver)
         {
            _isOver = false;
            this.mouseOutHandler();
         }
      }
      
      protected function get propValue164() : int
      {
         return 0;
      }
      
      private function doAction477() : void
      {
         var highlightMask:int = this.propValue137;
         var background:Boolean;
         var index:int = 0;
         while(index < this.worldObjectList2.length)
         {
            background = this.worldObjectList2[index].isBackground;
            if(background && (highlightMask & COMPOSITION_CONST1) != 0 || !background && (highlightMask & COMPOSITION_CONST2) != 0)
            {
               this.worldObjectList2[index].updateHighlight();
            }
            index++;
         }
      }
      
      protected function setHighlight(param1:int) : void
      {
         var highlightMask:int = 0;
         var background:Boolean = false;
         var index:int = 0;
         if(this.highlight != param1)
         {
            this.highlight = param1;
            if(this.intValue5 >= 0)
            {
               clearInterval(this.intValue5);
               intValue5 = -1;
            }
            if(this.propValue164 != 0)
            {
               intValue5 = TimerUtil.setInterval(this.doAction477,this.propValue164);
            }
            highlightMask = this.propValue137;
            index = 0;
            while(index < this.worldObjectList2.length)
            {
               background = this.worldObjectList2[index].isBackground;
               if(background && (highlightMask & COMPOSITION_CONST1) != 0 || !background && (highlightMask & COMPOSITION_CONST2) != 0)
               {
                  this.worldObjectList2[index].setHighlight(param1);
               }
               index++;
            }
         }
      }
      
      public function get maxStateCount() : int
      {
         var maxCount:int = 0;
         var index:int = 0;
         while(index < this.worldObjectList2.length)
         {
            if(maxCount < this.worldObjectList2[index].maxStateCount)
            {
               maxCount = this.worldObjectList2[index].maxStateCount;
            }
            index++;
         }
         return maxCount;
      }
      
      public function set state(param1:int) : void
      {
         _compositionState = param1;
         intValue62 = 0;
         var index:int = 0;
         while(index < this.worldObjectList2.length)
         {
            this.worldObjectList2[index].state = param1;
            if(this.worldObjectList2[index].isAnimatedObject)
            {
               ++this.intValue62;
            }
            index++;
         }
      }
      
      public function get state() : int
      {
         return this._compositionState;
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         var index:int = 0;
         if(this._compositionI != param1 || this._compositionJ != param2)
         {
            index = 0;
            while(index < this.compositionList4.length)
            {
               this.compositionList4[index].setPos(this.compositionList4[index].i + param1 - this._compositionI,this.compositionList4[index].j + param2 - this._compositionJ);
               index++;
            }
            _compositionI = param1;
            _compositionJ = param2;
            this.doAction876();
            this.doAction726();
         }
      }
      
      public function set i(param1:int) : void
      {
         var index:int = 0;
         if(this._compositionI != param1)
         {
            index = 0;
            while(index < this.compositionList4.length)
            {
               this.compositionList4[index].i += param1 - this._compositionI;
               index++;
            }
            _compositionI = param1;
            this.doAction876();
            this.doAction726();
         }
      }
      
      public function set j(param1:int) : void
      {
         var index:int = 0;
         if(this._compositionJ != param1)
         {
            index = 0;
            while(index < this.compositionList4.length)
            {
               this.compositionList4[index].j += param1 - this._compositionJ;
               index++;
            }
            _compositionJ = param1;
            this.doAction876();
            this.doAction726();
         }
      }
      
      public function get i() : int
      {
         return this._compositionI;
      }
      
      public function get j() : int
      {
         return this._compositionJ;
      }
      
      public function doAction379() : void
      {
         --this.intValue62;
         if(this.intValue62 <= 0)
         {
            this.allAnimationOverHandler();
         }
      }
      
      public function allAnimationOverHandler() : void
      {
      }
      
      public function get propValue29() : Rectangle
      {
         return new Rectangle(this.j + this.rect3.x,this.i + this.rect3.y,this.rect3.width,this.rect3.height);
      }
      
      public function get propValue106() : Rectangle
      {
         var bounds:Rectangle = new Rectangle(this.j + this.rect3.x,this.i + this.rect3.y,this.rect3.width,this.rect3.height);
         var unused:int;
         if(bounds.width != 0)
         {
            bounds.x = bounds.x * 2 + 1;
            bounds.width = bounds.width * 2 - 1;
         }
         else
         {
            bounds.x *= 2;
            bounds.width = 1;
         }
         if(bounds.height != 0)
         {
            bounds.y = bounds.y * 2 + 1;
            bounds.height = bounds.height * 2 - 1;
         }
         else
         {
            bounds.y *= 2;
            bounds.height = 1;
         }
         return bounds;
      }
      
      public function onGameEvent(param1:Object) : void
      {
      }
      
      public function set gameState(param1:Object) : void
      {
         propValue110 = param1;
      }
      
      public function doAction934(param1:Object) : void
      {
         if(param1 != null && param1 != this.id)
         {
            id = int(param1);
            if(this.world.uintValue17 <= this.id)
            {
               this.world.uintValue17 = this.id + 1;
            }
         }
      }
      
      public function get propValue110() : Object
      {
         return this.obj14;
      }
      
      public function set propValue110(param1:Object) : void
      {
         obj14 = param1;
         this.doAction934(param1.id);
         blocked = param1.blocked == null ? false : param1.blocked;
         var nextI:int = param1.y == null ? this.i : param1.y;
         var nextJ:int = param1.x == null ? this.j : param1.x;
         rotate = param1.rotate;
         if((this.i != nextI || this.j != nextJ) && this.flag114)
         {
            this.world.doAction40(this);
            this.setPos(nextI,nextJ);
            this.world.doAction779(this);
         }
      }
      
      public function get propValue9() : String
      {
         return "";
      }
      
      public function get propValue22() : int
      {
         return 1;
      }
      
      public function set blocked(param1:Boolean) : void
      {
         if(this.highlight)
         {
            this.setDefaultHighlight();
         }
         _compositionBlocked = param1;
      }
      
      public function get isValue27() : Boolean
      {
         if(!this._processing)
         {
            return true;
         }
         var index:int = 0;
         while(index < this.compositionList1.length)
         {
            if(!this.compositionList1[index].processing)
            {
               return true;
            }
            index++;
         }
         return false;
      }
      
      public function get blocked() : Boolean
      {
         return this._compositionBlocked;
      }
      
      public function get propValue132() : NPoint
      {
         var start:NPoint = WorldItem.getCoords(this._compositionI + this.rect9.y,this._compositionJ + this.rect9.x);
         var end:NPoint = WorldItem.getCoords(this._compositionI + this.rect9.y,this._compositionJ + this.rect9.x + this.rect9.width - 1);
         start.x += (end.x - start.x) / 2 - WorldItem.cJHCellSize / 2;
         start.y += (end.y - start.y) / 2 - WorldItem.cIHHCellSize / 2;
         return start;
      }
      
      public function get propValue8() : NPoint
      {
         var position:NPoint = WorldItem.getCoords(this._compositionI + this.rect9.y,this._compositionJ + this.rect9.x);
         position.x -= WorldItem.cJHCellSize;
         return position;
      }
      
      public function get propValue42() : NPoint
      {
         var start:NPoint = WorldItem.getCoords(this._compositionI + this.rect9.y,this._compositionJ + this.rect9.x);
         var end:NPoint = WorldItem.getCoords(this._compositionI + this.rect9.y + this.rect9.height,this._compositionJ + this.rect9.x + this.rect9.width);
         start.x += (end.x - start.x) / 2 - WorldItem.cJHCellSize;
         start.y += (end.y - start.y) / 2;
         return start;
      }
      
      public function get propValue82() : NPoint
      {
         var position:NPoint = WorldItem.getCoords(this._compositionI,this._compositionJ);
         position.x -= WorldItem.cJHCellSize;
         return position;
      }
      
      public function get propValue113() : int
      {
         var minimumY:int = 0;
         var objectIndex:int = 0;
         var imageIndex:int = 0;
         objectIndex = this.worldObjectList2.length - 1;
         while(objectIndex >= 0)
         {
            imageIndex = this.worldObjectList2[objectIndex].dAnimImgsArray.length - 1;
            while(imageIndex >= 0)
            {
               if(!minimumY || this.worldObjectList2[objectIndex].dAnimImgsArray[imageIndex].y + this.worldObjectList2[objectIndex].y < minimumY)
               {
                  minimumY = this.worldObjectList2[objectIndex].dAnimImgsArray[imageIndex].y + this.worldObjectList2[objectIndex].y;
               }
               imageIndex--;
            }
            imageIndex = this.worldObjectList2[objectIndex].dImgs.length - 1;
            while(imageIndex >= 0)
            {
               if(!minimumY || this.worldObjectList2[objectIndex].dImgs[imageIndex].y + this.worldObjectList2[objectIndex].y < minimumY)
               {
                  minimumY = this.worldObjectList2[objectIndex].dImgs[imageIndex].y + this.worldObjectList2[objectIndex].y;
               }
               imageIndex--;
            }
            objectIndex--;
         }
         return minimumY;
      }
      
      public function get propValue191() : NPoint
      {
         return WorldItem.getNPoint7(this._compositionI + this.rect9.x + this.rect9.height / 2,this._compositionJ + this.rect9.x + this.rect9.width / 2);
      }
      
      public function getInt12(param1:int) : int
      {
         return this._compositionI;
      }
      
      public function getInt24(param1:int) : int
      {
         return this._compositionJ;
      }
      
      public function get isValue34() : Boolean
      {
         if(!this._processing)
         {
            return false;
         }
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList1.length)
         {
            if(!this.compositionList1[compositionIndex].processing)
            {
               return false;
            }
            compositionIndex++;
         }
         return true;
      }
      
      public function get isValue24() : Boolean
      {
         if(this._processing)
         {
            return true;
         }
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList1.length)
         {
            if(this.compositionList1[compositionIndex].processing)
            {
               return false;
            }
            compositionIndex++;
         }
         return true;
      }
      
      public function passebleForPlayer(param1:WorldEntity) : Boolean
      {
         return this.flag42 || param1.mapLevel > this.intValue140;
      }
      
      public function getNPoint3(param1:Number, param2:Number, param3:Number, param4:Number, param5:WorldEntity) : Vector.<NPoint>
      {
         var cellRect:Rectangle = new Rectangle(this.j + this.rect3.x,this.i + this.rect3.y,this.rect3.width,this.rect3.height);
         var corners:Vector.<NPoint> = new Vector.<NPoint>(5);
         corners[0] = WorldItem.getCoords(cellRect.y,cellRect.x);
         corners[1] = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x);
         corners[2] = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x + cellRect.width - 1);
         corners[3] = WorldItem.getCoords(cellRect.y,cellRect.x + cellRect.width - 1);
         var cornerScale:int = param5.propValue72;
         corners[0].x -= WorldItem.cJHCellSize * cornerScale;
         corners[1].y += WorldItem.cIHHCellSize * cornerScale;
         corners[2].x += WorldItem.cJHCellSize * cornerScale;
         corners[3].y -= WorldItem.cIHHCellSize * cornerScale;
         corners[4] = corners[0];
         if(this.check34(param3,param4,corners[0].x,corners[0].y,corners[1].x,corners[1].y,corners[3].x,corners[3].y,corners[2].x,corners[2].y) && this.check34(param3,param4,corners[0].x,corners[0].y,corners[3].x,corners[3].y,corners[1].x,corners[1].y,corners[2].x,corners[2].y))
         {
            return null;
         }
         var nearestEdgeIndex:int = -1;
         var nearestDistanceSquared:int = -1;
         var nearestIntersection:NPoint;
         var intersection:NPoint;
         var distanceSquared:int;
         var intersectionCount:int = 0;
         var edgeIndex:int = 0;
         var currentPoint:NPoint;
         var cornerIndex:int;
         var backwardDistance:int;
         var backwardPath:Vector.<NPoint>;
         var forwardDistance:int;
         var forwardPath:Vector.<NPoint>;
         while(edgeIndex < 4)
         {
            intersection = getNPoint8(param1,param2,param3,param4,corners[edgeIndex].x,corners[edgeIndex].y,corners[edgeIndex + 1].x,corners[edgeIndex + 1].y);
            if(intersection != null)
            {
               distanceSquared = (param1 - intersection.x) * (param1 - intersection.x) + (param2 - intersection.y) * (param2 - intersection.y);
               intersectionCount++;
               if(nearestEdgeIndex == -1 || distanceSquared < nearestDistanceSquared)
               {
                  nearestDistanceSquared = distanceSquared;
                  nearestIntersection = intersection;
                  nearestEdgeIndex = edgeIndex;
               }
            }
            edgeIndex++;
         }
         if(intersectionCount <= 1)
         {
            return new Vector.<NPoint>();
         }
         if(nearestEdgeIndex != -1)
         {
            currentPoint = nearestIntersection;
            cornerIndex = nearestEdgeIndex;
            backwardDistance = 0;
            backwardPath = new Vector.<NPoint>();
            do
            {
               backwardDistance += Math.sqrt((corners[cornerIndex].x - currentPoint.x) * (corners[cornerIndex].x - currentPoint.x) + (corners[cornerIndex].y - currentPoint.y) * (corners[cornerIndex].y - currentPoint.y));
               currentPoint = corners[cornerIndex];
               backwardPath.splice(0,0,currentPoint);
               if(!this.intersects(currentPoint.x,currentPoint.y,param3,param4))
               {
                  backwardDistance += Math.sqrt((param3 - currentPoint.x) * (param3 - currentPoint.x) + (param4 - currentPoint.y) * (param4 - currentPoint.y));
                  break;
               }
               cornerIndex--;
               if(cornerIndex < 0)
               {
                  cornerIndex = 3;
               }
            }
            while(cornerIndex != nearestEdgeIndex);
            currentPoint = nearestIntersection;
            cornerIndex = nearestEdgeIndex + 1;
            forwardDistance = 0;
            forwardPath = new Vector.<NPoint>();
            while(cornerIndex != nearestEdgeIndex)
            {
               forwardDistance += Math.sqrt((corners[cornerIndex].x - currentPoint.x) * (corners[cornerIndex].x - currentPoint.x) + (corners[cornerIndex].y - currentPoint.y) * (corners[cornerIndex].y - currentPoint.y));
               currentPoint = corners[cornerIndex];
               forwardPath.splice(0,0,currentPoint);
               if(!this.intersects(currentPoint.x,currentPoint.y,param3,param4))
               {
                  forwardDistance += Math.sqrt((param3 - currentPoint.x) * (param3 - currentPoint.x) + (param4 - currentPoint.y) * (param4 - currentPoint.y));
                  break;
               }
               ++cornerIndex;
               if(cornerIndex >= corners.length)
               {
                  cornerIndex = 0;
               }
            }
            if(backwardDistance < forwardDistance)
            {
               return backwardPath;
            }
            return forwardPath;
         }
         return new Vector.<NPoint>();
      }
      
      public function intersects(param1:Number, param2:Number, param3:Number, param4:Number, param5:WorldEntity = null) : Boolean
      {
         var cellRect:Rectangle = new Rectangle(this.j + this.rect3.x,this.i + this.rect3.y,this.rect3.width,this.rect3.height);
         var corners:Array = new Array(5);
         corners[0] = WorldItem.getCoords(cellRect.y,cellRect.x);
         corners[1] = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x);
         corners[2] = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x + cellRect.width - 1);
         corners[3] = WorldItem.getCoords(cellRect.y,cellRect.x + cellRect.width - 1);
         corners[0].x -= WorldItem.cJHCellSize;
         corners[1].y += WorldItem.cIHHCellSize;
         corners[2].x += WorldItem.cJHCellSize;
         corners[3].y -= WorldItem.cIHHCellSize;
         corners[4] = corners[0];
         if(this.check34(param1,param2,corners[0].x,corners[0].y,corners[1].x,corners[1].y,corners[3].x,corners[3].y,corners[2].x,corners[2].y) && this.check34(param1,param2,corners[0].x,corners[0].y,corners[3].x,corners[3].y,corners[1].x,corners[1].y,corners[2].x,corners[2].y))
         {
            return true;
         }
         if(this.check34(param3,param4,corners[0].x,corners[0].y,corners[1].x,corners[1].y,corners[3].x,corners[3].y,corners[2].x,corners[2].y) && this.check34(param3,param4,corners[0].x,corners[0].y,corners[3].x,corners[3].y,corners[1].x,corners[1].y,corners[2].x,corners[2].y))
         {
            return true;
         }
         var intersectionCount:int = 0;
         var edgeIndex:int = 0;
         var intersectionType:int;
         while(edgeIndex < 4)
         {
            intersectionType = this.getInt3(param1,param2,param3,param4,corners[edgeIndex].x,corners[edgeIndex].y,corners[edgeIndex + 1].x,corners[edgeIndex + 1].y,param5 && !this.check52(edgeIndex,param5));
            if(intersectionType == COMPOSITION_CONST8)
            {
               intersectionCount++;
            }
            else if(intersectionType == COMPOSITION_CONST7)
            {
               intersectionCount += 2;
            }
            edgeIndex++;
         }
         if(intersectionCount > 1)
         {
            return true;
         }
         return false;
      }
      
      public function get downPoint() : NPoint
      {
         var point:NPoint = WorldItem.getCoords(this.i + this.rect3.y + this.rect3.height - 1,this.j + this.rect3.x);
         point.y += WorldItem.cIHHCellSize;
         return point;
      }
      
      public function lieInRect(param1:Number, param2:Number) : Boolean
      {
         var cellRect:Rectangle = new Rectangle(this.j + this.rect3.x,this.i + this.rect3.y,this.rect3.width,this.rect3.height);
         var leftCorner:NPoint = WorldItem.getCoords(cellRect.y,cellRect.x);
         var bottomCorner:NPoint = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x);
         var rightCorner:NPoint = WorldItem.getCoords(cellRect.y + cellRect.height - 1,cellRect.x + cellRect.width - 1);
         var topCorner:NPoint = WorldItem.getCoords(cellRect.y,cellRect.x + cellRect.width - 1);
         leftCorner.x -= WorldItem.cJHCellSize;
         bottomCorner.y += WorldItem.cIHHCellSize;
         rightCorner.x += WorldItem.cJHCellSize;
         topCorner.y -= WorldItem.cIHHCellSize;
         if(this.check34(param1,param2,leftCorner.x,leftCorner.y,bottomCorner.x,bottomCorner.y,topCorner.x,topCorner.y,rightCorner.x,rightCorner.y) && this.check34(param1,param2,leftCorner.x,leftCorner.y,topCorner.x,topCorner.y,bottomCorner.x,bottomCorner.y,rightCorner.x,rightCorner.y))
         {
            return true;
         }
         return false;
      }
      
      private function check34(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : Boolean
      {
         var firstCrossProduct:Number = (param5 - param3) * (param2 - param4) - (param6 - param4) * (param1 - param3);
         var secondCrossProduct:Number = (param9 - param7) * (param2 - param8) - (param10 - param8) * (param1 - param7);
         if(Math.abs(firstCrossProduct) < 1)
         {
            firstCrossProduct = 0;
         }
         if(Math.abs(secondCrossProduct) < 1)
         {
            secondCrossProduct = 0;
         }
         return firstCrossProduct * secondCrossProduct < 0;
      }
      
      private function getInt3(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false) : int
      {
         var firstStartCross:Number = (param7 - param5) * (param2 - param6) - (param8 - param6) * (param1 - param5);
         var firstEndCross:Number = (param7 - param5) * (param4 - param6) - (param8 - param6) * (param3 - param5);
         var secondStartCross:Number = (param3 - param1) * (param6 - param2) - (param4 - param2) * (param5 - param1);
         var secondEndCross:Number = (param3 - param1) * (param8 - param2) - (param4 - param2) * (param7 - param1);
         if(Math.abs(firstStartCross) < 1)
         {
            firstStartCross = 0;
         }
         if(Math.abs(secondStartCross) < 1)
         {
            secondStartCross = 0;
         }
         if(Math.abs((param8 - param6) * (param3 - param1) - (param7 - param5) * (param4 - param2)) < 1)
         {
            if(param9 && firstStartCross == 0 && firstEndCross == 0 && secondStartCross == 0 && secondEndCross == 0)
            {
               if((param1 == param5 && param2 == param6 || param1 == param7 && param2 == param8) && (param3 == param5 && param4 == param5 || param3 == param7 && param4 == param8))
               {
                  return COMPOSITION_CONST7;
               }
               if(param2 == param4)
               {
                  if((param1 - param5) * (param3 - param5) < 0 || (param1 - param7) * (param3 - param7) < 0)
                  {
                     return COMPOSITION_CONST7;
                  }
               }
               else if((param2 - param6) * (param4 - param6) < 0 || (param2 - param8) * (param4 - param8) < 0)
               {
                  return COMPOSITION_CONST7;
               }
            }
            return COMPOSITION_CONST4;
         }
         if(firstStartCross * firstEndCross <= 0 && (secondStartCross * secondEndCross < 0 || secondStartCross == 0))
         {
            return COMPOSITION_CONST8;
         }
         return COMPOSITION_CONST4;
      }
      
      public function get maxAnimCount() : int
      {
         var maximum:int = 0;
         var objectAnimCount:int;
         var objectIndex:int = 0;
         while(objectIndex < this.worldObjectList2.length)
         {
            objectAnimCount = this.worldObjectList2[objectIndex].maxAnimCount;
            if(objectAnimCount > maximum)
            {
               maximum = objectAnimCount;
            }
            objectIndex++;
         }
         return maximum;
      }
      
      public function doAction85(param1:Vector.<Composition>) : void
      {
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList1.length)
         {
            param1.push(this.compositionList1[compositionIndex]);
            compositionIndex++;
         }
      }
      
      public function doAction262(param1:Array) : void
      {
         var objectIndex:int = 0;
         objectIndex = 0;
         while(objectIndex < this.worldObjectList2.length)
         {
            if(param1.indexOf(this.worldObjectList2[objectIndex]) < 0)
            {
               param1.push(this.worldObjectList2[objectIndex]);
            }
            objectIndex++;
         }
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList4.length)
         {
            objectIndex = 0;
            while(objectIndex < this.compositionList4[compositionIndex].objectItems.length)
            {
               if(param1.indexOf(this.compositionList4[compositionIndex].objectItems[objectIndex]) < 0)
               {
                  param1.push(this.compositionList4[compositionIndex].objectItems[objectIndex]);
               }
               objectIndex++;
            }
            compositionIndex++;
         }
      }
      
      protected function get propValue71() : int
      {
         return 40;
      }
      
      public function check21() : Boolean
      {
         if(int(((this.world.mouseY + this.propValue71 + WorldBase.worldYOfs) * WorldItem.cMulFactor / WorldItem.cICellSize + (this.world.mouseX + WorldItem.cJHCellSize + WorldBase.worldXOfs) * WorldItem.cMulFactor / WorldItem.cJCellSize) / WorldItem.cMulFactor + 1024) - 1024 < this.i + this.rect3.y || int(((this.world.mouseX + WorldItem.cJHCellSize + WorldBase.worldXOfs) * WorldItem.cMulFactor / WorldItem.cJCellSize - (this.world.mouseY + this.propValue71 + WorldBase.worldYOfs) * WorldItem.cMulFactor / WorldItem.cICellSize) / WorldItem.cMulFactor + 1024) - 1024 >= this.j + this.rect3.x + this.rect3.width)
         {
            return true;
         }
         return false;
      }
      
      public function check38(param1:String) : Boolean
      {
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList1.length)
         {
            if(this.compositionList1[compositionIndex].type == param1)
            {
               return true;
            }
            compositionIndex++;
         }
         return false;
      }
      
      public function get groupUnlocked() : Boolean
      {
         var compositionIndex:int = 0;
         while(compositionIndex < this.compositionList1.length)
         {
            if(this.compositionList1[compositionIndex].unlocked)
            {
               return true;
            }
            compositionIndex++;
         }
         return false;
      }
      
      public function set alpha(param1:Number) : void
      {
         var objectIndex:int = 0;
         while(objectIndex < this.worldObjectList2.length)
         {
            this.worldObjectList2[objectIndex].alpha = param1;
            objectIndex++;
         }
      }
      
      public function get propValue158() : Number
      {
         return this.numValue49;
      }
      
      public function set propValue158(param1:Number) : void
      {
         numValue49 = param1;
         _compositionAlpha = this.numValue49;
         alpha = this.getNumber1(this.alpha);
      }
      
      public function doAction948(param1:Number, param2:Number = 0.25, param3:Number = 0, param4:Function = null, param5:Boolean = false) : void
      {
         _compositionAlpha = this.getNumber1(param1);
         if(this._compositionAlpha == this.numValue49 && !param5)
         {
            param2 = 0;
         }
         var objectIndex:int = 0;
         while(objectIndex < this.worldObjectList2.length)
         {
            this.worldObjectList2[objectIndex].animateAlpha(this._compositionAlpha,param2,param3,param4);
            objectIndex++;
         }
      }
      
      private function getNumber1(param1:Number) : Number
      {
         if(this._processing)
         {
            return 0.5;
         }
         if(this._compositionHidden)
         {
            return 0.2;
         }
         return param1;
      }
      
      public function get isHide() : Boolean
      {
         return this._compositionHidden;
      }
      
      public function set isHide(param1:Boolean) : void
      {
         if(param1 != this._compositionHidden)
         {
            _compositionHidden = param1;
            this.doAction948(this.numValue49,0.5,0.2);
         }
      }
      
      public function get processing() : Boolean
      {
         return this._processing;
      }
      
      public function set processing(param1:Boolean) : void
      {
         if(param1 != this._processing)
         {
            _processing = param1;
            this.doAction948(this.numValue49,0);
         }
      }
      
      public function get alpha() : Number
      {
         return this._compositionAlpha;
      }
      
      public function get propValue35() : int
      {
         return 0;
      }
      
      public function doAction138(param1:int) : void
      {
      }
      
      public function getData() : Object
      {
         return null;
      }
      
      public function setData(param1:Object) : void
      {
      }
      
      public function get isValue72() : Boolean
      {
         return true;
      }
      
      public function doAction451(param1:IJPoint) : void
      {
         var offset:NPoint = WorldItem.getCoords(param1.i,param1.j);
         var pointIndex:int = 0;
         while(pointIndex < this.array26.length)
         {
            this.array26[pointIndex].x += offset.x;
            this.array26[pointIndex].y += offset.y;
            pointIndex++;
         }
      }
      
      public function doAction516(param1:TweenEffect) : void
      {
         var objects:Array = new Array();
         var composition:Composition;
         var object:WorldObject;
         for each(composition in this.compositionList1)
         {
            for each(object in composition.objectItems)
            {
               objects.push(object);
            }
         }
         param1.tweenTargets = objects;
      }
      
      public function get propValue155() : Vector.<WorldObject>
      {
         var objects:Vector.<WorldObject> = new Vector.<WorldObject>();
         var composition:Composition;
         var object:WorldObject;
         for each(composition in this.compositionList1)
         {
            for each(object in composition.objectItems)
            {
               objects.push(object);
            }
         }
         return objects;
      }
      
      public function get animationState() : int
      {
         return WorldObject.animateNone;
      }
      
      public function get isValue56() : Boolean
      {
         return true;
      }
      
      public function doAction250() : void
      {
         var objectIndex:int = 0;
         while(objectIndex < this.worldObjectList2.length)
         {
            WorldObject(this.worldObjectList2[objectIndex]).initState();
            objectIndex++;
         }
      }
      
      public function set propValue25(param1:Rectangle) : void
      {
         rect9 = param1;
      }
      
      public function get propValue25() : Rectangle
      {
         return this.rect9;
      }
      
      public function set objectItems(param1:Vector.<WorldObject>) : void
      {
         worldObjectList2 = param1;
      }
      
      public function get objectItems() : Vector.<WorldObject>
      {
         return this.worldObjectList2;
      }
      
      public function get propValue97() : int
      {
         return this.i;
      }
      
      public function get propValue154() : int
      {
         return this.j;
      }
      
      public function doAction623(param1:MovieBitmap) : void
      {
      }
      
      public function doAction496() : void
      {
         var objectIndex:int = 0;
         while(objectIndex < this.objectItems.length)
         {
            TweenEffect.doAction797(this.objectItems[objectIndex]);
            objectIndex++;
         }
      }
      
      public function doAction304() : void
      {
         var objectIndex:int = 0;
         while(objectIndex < this.objectItems.length)
         {
            this.objectItems[objectIndex].filters = [];
            objectIndex++;
         }
      }
      
      public function check7(param1:Composition) : Boolean
      {
         var ownRect:Rectangle = this.propValue106;
         var otherRect:Rectangle = param1.propValue106;
         if(otherRect.y >= ownRect.y + ownRect.height || otherRect.y + otherRect.height <= ownRect.y || otherRect.x >= ownRect.x + ownRect.width || otherRect.x + otherRect.width <= ownRect.x)
         {
            return false;
         }
         return true;
      }
   }
}

