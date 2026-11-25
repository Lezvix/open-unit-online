package game.world
{
   import core.resources.SoundManager;
   import core.ui.NUIController;
   import game.compositions.GameComposition;
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class WorldBase extends Sprite
   {
      
      public static var intValue121:int = 0;
      
      public static var OFFSET_CHANGE_1:int = 1;
      
      public static var worldXOfs:int = 0;
      
      public static var worldYOfs:int = 0;
      
      public static const OFFSET_CHANGE_X:int = 16384;
      
      public static const OFFSET_DELTA_X:int = 2000;
      
      public static const OFFSET_CHANGE_Y:int = 16384;
      
      public static const OFFSET_DELTA_Y:int = 2000;
      
      public static const OFFSET_DELTA_100:int = 100;
      
      public static var cMaxCameraXDelta:int = 100;
      
      public static var cMaxCameraYDelta:int = 100;
      
      public static const MAX_LOAD_50:int = 50;
      
      public static const MAX_LOAD_TIME:uint = 5;
      
      public static var loadObjectsFirst:WorldObject = null;
      
      public static var worldObject1:WorldObject = null;
      
      public static var objectFactory1:ObjectFactory = null;
      
      public static var forcedMouseX:int = -1;
      
      public static var forcedMouseY:int = -1;
      
      private static const COMPOSITION_CONST4:int = 0;
      
      private static const WORLD_BASE_CONST2:int = 1;
      
      private static const COMPOSITION_CONST8:int = 2;
      
      private static const WORLD_BASE_CONST1:int = 3;
      
      private static const WORLD_BASE_CONST3:int = 4;
      
      public var MAP_CELL_FACTOR:int;
      
      public var players:Vector.<WorldEntity> = new Vector.<WorldEntity>();
      
      protected var objects:Vector.<WorldObject> = new Vector.<WorldObject>();
      
      protected var tempObjects:Vector.<WorldObject> = new Vector.<WorldObject>();
      
      protected var effectObjects:Vector.<EffectObject> = new Vector.<EffectObject>();
      
      protected var compositionsById:Object = new Object();
      
      private var compositionList2:Vector.<Composition> = new Vector.<Composition>();
      
      public var intValue95:int = OFFSET_CHANGE_1;
      
      public var mapWidth:int = 0;
      
      public var mapHeight:int = 0;
      
      public var followPosition:NPoint = new NPoint(0,0);
      
      private var MAX_BG_COUNT:int = 600;
      
      public var hideItem:WorldObject = null;
      
      public var sortObj:Boolean = false;
      
      public var hideItems:Array = new Array();
      
      public var flag44:Boolean = false;
      
      public var s:int = 0;
      
      public var e:int = 0;
      
      public var intValue218:int = 0;
      
      public var worldEntity1:WorldEntity;
      
      private var lastPlayerX:int = -32000;
      
      private var lastPlayerY:int = -32000;
      
      public var worldView:WorldView;
      
      public var viewWidth:int;
      
      public var viewHeight:int;
      
      protected var vectorVectorjList1:Vector.<Vector.<Vector.<Composition>>>;
      
      private var indexedPathNodesByCell:Array;
      
      private var pathSearchNodesByCell:Array;
      
      public var highlightCompositions:Vector.<Composition> = null;
      
      public var compositionList3:Vector.<Composition> = new Vector.<Composition>();
      
      public var hideCompositions:Vector.<Composition> = new Vector.<Composition>();
      
      public var worldEntity2:WorldEntity = null;
      
      public var uintValue17:uint = 1;
      
      public var deltaTime:int = 0;
      
      public var lastTime:int = 0;
      
      public var flag142:Boolean = false;
      
      public var worldBackgroundCount:int = 0;
      
      public var terrainGrid:Array;
      
      public var terrainRegionIds:Array = null;
      
      protected var terrainColumnCount:int;
      
      protected var terrainRowCount:int;
      
      private var array30:Array = null;
      
      private var compositionSearchType:String = null;
      
      protected var compositionSearchI:int;
      
      protected var compositionSearchJ:int;
      
      private var regionFloodFillQueue:Array;
      
      private var nextTerrainRegionId:int;
      
      public var cellPassebleFunction:Function;
      
      private var depthSorter:DepthSorter;
      
      private var flag12:Boolean;
      
      private var flag7:Boolean;
      
      private var flag99:Boolean;
      
      private var flag27:Boolean;
      
      private var array29:Array = new Array();
      
      private var intValue74:int = 0;
      
      private var targetTerrainType:int;
      
      public function WorldBase(view:WorldView, cellFactor:int = 2)
      {
         flag7 = true;
         flag12 = false;
         this.MAP_CELL_FACTOR = cellFactor;
         this.worldView = view;
         super();
         WorldItem.world = this;
         this.initObjectItemManager();
         this.cellPassebleFunction = this.onCellPasseble;
         this.depthSorter = new DepthSorter();
      }
      
      public static function check34(pointX:Number, pointY:Number, firstStartX:Number, firstStartY:Number, firstEndX:Number, firstEndY:Number, secondStartX:Number, secondStartY:Number, secondEndX:Number, secondEndY:Number) : Boolean
      {
         var firstCross:Number = (firstEndX - firstStartX) * (pointY - firstStartY) - (firstEndY - firstStartY) * (pointX - firstStartX);
         var secondCross:Number = (secondEndX - secondStartX) * (pointY - secondStartY) - (secondEndY - secondStartY) * (pointX - secondStartX);
         if(Math.abs(firstCross) < 1)
         {
            firstCross = 0;
         }
         if(Math.abs(secondCross) < 1)
         {
            secondCross = 0;
         }
         return firstCross * secondCross < 0;
      }
      
      public function canHighlightObject(param1:WorldObject) : Boolean
      {
         return this.worldEntity2 == null || param1.isPlayerNear(this.worldEntity2) < 0;
      }
      
      public function doAction927(param1:Composition) : void
      {
         this.array29.push(param1);
      }
      
      protected function initObjectItemManager() : void
      {
         if(objectFactory1 == null)
         {
            objectFactory1 = new ObjectFactory(this);
         }
         else
         {
            objectFactory1.world = this;
         }
      }
      
      public function getComposition10(param1:int, param2:int) : Composition
      {
         var compositions:Vector.<Composition> = null;
         if(param1 >= 0 && param2 >= 0 && param1 < this.vectorVectorjList1.length && param2 < this.vectorVectorjList1[param1].length)
         {
            compositions = this.vectorVectorjList1[param1][param2];
            if(compositions != null)
            {
               return compositions[0];
            }
         }
         return null;
      }
      
      public function get propValue105() : Vector.<Vector.<Vector.<Composition>>>
      {
         return this.vectorVectorjList1;
      }
      
      private function enqueueTerrainRegionCell(cellI:int, cellJ:int) : void
      {
         if(cellI >= 0 && cellJ >= 0 && cellI < this.mapHeight / this.MAP_CELL_FACTOR && cellJ < this.mapWidth / this.MAP_CELL_FACTOR && this.terrainRegionIds[cellI][cellJ] == null && !this.cellPassebleFunction(cellI,cellJ,null))
         {
            this.terrainRegionIds[cellI][cellJ] = this.nextTerrainRegionId;
            this.regionFloodFillQueue.push({
               "i":cellI,
               "j":cellJ
            });
         }
      }
      
      public function buildTerrainRegions() : void
      {
         var row:int = 0;
         var column:int = 0;
         var cell:Object = null;
         nextTerrainRegionId = 0;
         terrainRegionIds = new Array();
         row = 0;
         while(row < this.mapHeight / this.MAP_CELL_FACTOR)
         {
            this.terrainRegionIds.push(new Array());
            column = 0;
            while(column < this.mapWidth / this.MAP_CELL_FACTOR)
            {
               this.terrainRegionIds[row].push(null);
               column++;
            }
            row++;
         }
         row = 0;
         while(row < this.mapHeight / this.MAP_CELL_FACTOR)
         {
            column = 0;
            while(column < this.mapWidth / this.MAP_CELL_FACTOR)
            {
               if(this.terrainRegionIds[row][column] == null)
               {
                  regionFloodFillQueue = new Array();
                  this.enqueueTerrainRegionCell(row,column);
                  while(this.regionFloodFillQueue.length > 0)
                  {
                     cell = this.regionFloodFillQueue[0];
                     this.regionFloodFillQueue.splice(0,1);
                     this.enqueueTerrainRegionCell(cell.i + 1,cell.j);
                     this.enqueueTerrainRegionCell(cell.i,cell.j + 1);
                     this.enqueueTerrainRegionCell(cell.i - 1,cell.j);
                     this.enqueueTerrainRegionCell(cell.i,cell.j - 1);
                  }
                  ++this.nextTerrainRegionId;
               }
               column++;
            }
            row++;
         }
      }
      
      public function loadTerrainGrid(gridBytes:ByteArray, compressed:Boolean = true) : void
      {
         terrainGrid = [];
         if(compressed)
         {
            gridBytes.uncompress();
         }
         gridBytes.position = 0;
         terrainColumnCount = gridBytes.readInt();
         terrainRowCount = gridBytes.readInt();
         var row:int = 0;
         var column:int;
         while(row < this.terrainRowCount)
         {
            this.terrainGrid.push([]);
            column = 0;
            while(column < this.terrainColumnCount)
            {
               this.terrainGrid[row].push(gridBytes.readInt());
               column++;
            }
            row++;
         }
         this.doAction144(this.terrainColumnCount * this.MAP_CELL_FACTOR,this.terrainRowCount * this.MAP_CELL_FACTOR);
      }
      
      public function getComposition2(param1:int) : Composition
      {
         var result:Composition = null;
         var composition:Composition = null;
         for each(composition in this.compositionsById)
         {
            if(composition.id == param1)
            {
               return composition;
            }
         }
         return result;
      }
      
      public function getEntityTerrainType(entity:WorldEntity) : int
      {
         return this.terrainGrid[int(entity.i / this.MAP_CELL_FACTOR)][int(entity.j / this.MAP_CELL_FACTOR)];
      }
      
      public function addWorldBackground(background:DisplayObject) : void
      {
         if(contains(background))
         {
            throw new Error("World is already containing this background!");
         }
         addChildAt(background,this.worldBackgroundCount);
         ++this.worldBackgroundCount;
      }
      
      public function removeWorldBackground(background:DisplayObject) : void
      {
         removeChild(background);
         --this.worldBackgroundCount;
      }
      
      public function doAction144(param1:int, param2:int) : void
      {
         var row:int = 0;
         var column:int = 0;
         this.mapHeight = param2;
         this.mapWidth = param1;
         vectorVectorjList1 = new Vector.<Vector.<Vector.<Composition>>>(param2 * 2);
         indexedPathNodesByCell = new Array(int(param2 / this.MAP_CELL_FACTOR));
         pathSearchNodesByCell = new Array(int(param2 / this.MAP_CELL_FACTOR));
         row = 0;
         while(row < param2 * 2)
         {
            this.vectorVectorjList1[row] = new Vector.<Vector.<Composition>>(param1 * 2);
            column = 0;
            while(column < param1 * 2)
            {
               this.vectorVectorjList1[row][column] = null;
               column++;
            }
            row++;
         }
         row = 0;
         while(row < param2 / this.MAP_CELL_FACTOR)
         {
            this.indexedPathNodesByCell[row] = new Array(int(param1 / this.MAP_CELL_FACTOR));
            this.pathSearchNodesByCell[row] = new Array(int(param1 / this.MAP_CELL_FACTOR));
            column = 0;
            while(column < param1 / this.MAP_CELL_FACTOR)
            {
               this.indexedPathNodesByCell[row][column] = new Array();
               this.pathSearchNodesByCell[row][column] = null;
               column++;
            }
            row++;
         }
      }
      
      public function doAction220() : void
      {
         SoundManager.doAction119((this.worldView.viewWidth / 2 - x) / scaleX,(this.worldView.viewHeight / 2 - y) / scaleY);
      }
      
      public function getNPoint1(player:WorldEntity) : NPoint
      {
         var curPos:IJPoint = WorldItem.getSecIJCoords(player.x,player.y);
         var cell:Vector.<Composition>;
         var k:int;
         try
         {
            cell = this.vectorVectorjList1[curPos.i][curPos.j];
         }
         catch(e:Error)
         {
            cell = null;
         }
         if(cell != null)
         {
            k = 0;
            while(k < cell.length)
            {
               if(cell[k].lieInRect(player.x,player.y))
               {
                  return cell[k].downPoint;
               }
               k++;
            }
         }
         return new NPoint(player.x,player.y);
      }
      
      public function getNotPassebleComposition(player:WorldEntity, curPos:IJPoint) : Composition
      {
         var pos:IJPoint = WorldItem.getSecIJCoords(player.x,player.y);
         if(player.isValue45)
         {
            curPos.i = pos.i + 3;
            curPos.j = pos.j + 3;
            return null;
         }
         var pos1:IJPoint = WorldItem.getIJCoords(player.x,player.y);
         var cell:Vector.<Composition>;
         var k:int;
         while(curPos.i <= pos.i + 2)
         {
            while(curPos.j <= pos.j + 2)
            {
               try
               {
                  cell = this.vectorVectorjList1[curPos.i][curPos.j];
               }
               catch(err:Error)
               {
                  cell = null;
               }
               if(curPos.i >= 0 && cell != null)
               {
                  k = 0;
                  while(k < cell.length)
                  {
                     if(!cell[k].passebleForPlayer(player) && cell[k].intersects(player.numValue10,player.startY,player.numValue34,player.numValue31,player))
                     {
                        ++curPos.j;
                        return cell[k];
                     }
                     k++;
                  }
               }
               ++curPos.j;
            }
            curPos.j = pos.j - 1;
            ++curPos.i;
         }
         return null;
      }
      
      private function check36(i:int, j:int, c:Composition, player:WorldEntity) : Boolean
      {
         var ic:int = i - 1;
         var jc:int;
         var cell:Vector.<Composition>;
         var k:int;
         while(ic <= i + 1)
         {
            jc = j - 1;
            while(jc < j + 1)
            {
               try
               {
                  cell = this.vectorVectorjList1[ic][jc];
               }
               catch(err:Error)
               {
                  cell = null;
               }
               if(cell != null)
               {
                  while(k < cell.length)
                  {
                     if(cell[k] != c && !player.check58(cell[k]))
                     {
                        return true;
                     }
                     k++;
                  }
               }
               jc++;
            }
            ic++;
         }
         return false;
      }
      
      public function getComposition4(param1:Composition, param2:int) : Composition
      {
         param1.rotate = param2;
         var composition:Composition = this.getComposition14(param1,param1.propValue9,param1.type,param1.str18,param1.getData());
         composition.doAction23(param1);
         return composition;
      }
      
      public function getComposition8(param1:Composition, param2:Object, param3:int = 0) : Composition
      {
         throw new Error("not implemented");
      }
      
      public function getComposition14(param1:Composition, param2:String, param3:String, param4:String = null, param5:Object = null) : Composition
      {
         var wasInWorld:Boolean = param1.isValue31;
         if(wasInWorld)
         {
            this.doAction173(param1);
         }
         else
         {
            this.doAction535(param1);
         }
         var replacement:Composition = this.getComposition5(param1.j,param1.i,param2,param3,param4,param5);
         replacement.id = param1.id;
         replacement.composition3 = param1.composition3;
         if(wasInWorld)
         {
            this.doAction779(replacement);
         }
         var index:int = 0;
         while(index < param1.compositionList1.length)
         {
            if(param1.compositionList1[index] != param1)
            {
               param1.compositionList1[index].removeGroupComposition(param1);
               replacement.addGroupComposition(param1.compositionList1[index]);
               param1.compositionList1[index].addGroupComposition(replacement);
            }
            index++;
         }
         return replacement;
      }
      
      protected function check33(param1:int, param2:Composition) : Boolean
      {
         return true;
      }
      
      public function handlePlayerNewCell(param1:WorldEntity) : Boolean
      {
         return this.cellPassebleFunction(param1.i / this.MAP_CELL_FACTOR,param1.j / this.MAP_CELL_FACTOR,param1);
      }
      
      public function onCellPasseble(param1:int, param2:int, param3:WorldEntity = null) : Boolean
      {
         return true;
      }
      
      public function check25(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function check18(param1:int, param2:int, param3:Composition = null) : Boolean
      {
         return true;
      }
      
      public function getCell(param1:int, param2:int) : int
      {
         try
         {
            return this.terrainGrid[param1][param2];
         }
         catch(e:Error)
         {
         }
         return -1;
      }
      
      public function check31(param1:Composition) : Boolean
      {
         var row:int = 0;
         var column:int = 0;
         var bounds:Rectangle = param1.propValue106;
         row = bounds.y;
         while(row < bounds.y + bounds.height)
         {
            column = bounds.x;
            while(column < bounds.x + bounds.width)
            {
               if(row < 0 || row >= this.mapHeight * 2 || column < 0 || column >= this.mapWidth * 2 || this.vectorVectorjList1[row][column] != null)
               {
                  return false;
               }
               column++;
            }
            row++;
         }
         var cellFactor:int = 2 * this.MAP_CELL_FACTOR;
         row = bounds.y / cellFactor;
         while(row < (bounds.y + bounds.height) / cellFactor)
         {
            column = bounds.x / cellFactor;
            while(column < (bounds.x + bounds.width) / cellFactor)
            {
               if(row < 0 || column < 0 || column >= this.terrainColumnCount || row >= this.terrainRowCount || !this.check33(this.terrainGrid[row][column],param1) || !this.check18(row,column,param1))
               {
                  return false;
               }
               column++;
            }
            row++;
         }
         return true;
      }
      
      public function getComposition11(param1:Composition) : Vector.<Composition>
      {
         var bounds:Rectangle = param1.propValue106;
         var result:Vector.<Composition> = this.getComposition1(bounds);
         return result;
      }
      
      public function getComposition1(param1:Rectangle) : Vector.<Composition>
      {
         var result:Vector.<Composition> = new Vector.<Composition>();
         var composition:Composition;
         var row:int;
         var column:int;
         var groupIndex:int;
         var cellIndex:int;
         row = param1.y;
         while(row < param1.y + param1.height)
         {
            column = param1.x;
            while(column < param1.x + param1.width)
            {
               if(row >= 0 && row < this.mapHeight * 2 && column >= 0 && column < this.mapWidth * 2 && this.vectorVectorjList1[row][column] != null)
               {
                  cellIndex = 0;
                  while(cellIndex < this.vectorVectorjList1[row][column].length)
                  {
                     composition = this.vectorVectorjList1[row][column][cellIndex].managementComposition;
                     groupIndex = 0;
                     while(groupIndex < composition.compositionList1.length)
                     {
                        if(result.indexOf(composition.compositionList1[groupIndex]) < 0)
                        {
                           result.push(composition.compositionList1[groupIndex]);
                        }
                        groupIndex++;
                     }
                     cellIndex++;
                  }
               }
               column++;
            }
            row++;
         }
         return result;
      }
      
      public function getComposition16(compositionId:int) : Composition
      {
         return this.compositionsById[compositionId];
      }
      
      private function getInt14(param1:Composition) : int
      {
         if(param1.type == this.compositionSearchType)
         {
            return int.MAX_VALUE - (param1.i - this.compositionSearchI) * (param1.i - this.compositionSearchI) - (param1.j - this.compositionSearchJ) * (param1.j - this.compositionSearchJ);
         }
         return 0;
      }
      
      private function getInt34(param1:Composition) : int
      {
         if(param1.type == this.compositionSearchType)
         {
            return 1;
         }
         return 0;
      }
      
      private function getInt7(param1:Composition) : int
      {
         if(param1.type == this.compositionSearchType)
         {
            return Math.random() * (int.MAX_VALUE - 1) + 1;
         }
         return 0;
      }
      
      public function getArray7(param1:Function) : Array
      {
         var result:Array = new Array();
         var composition:Composition;
         for each(composition in this.compositionsById)
         {
            if(!composition.isValue34 && param1(composition))
            {
               result.push(composition);
            }
         }
         return result;
      }
      
      public function getComposition13(itemId:String) : Composition
      {
         var filter:Function;
         filter = function(param1:GameComposition):int
         {
            if(param1.item.id == itemId)
            {
               return 1;
            }
            return 0;
         };
         return this.getComposition15(filter);
      }
      
      public function getArray1(itemId:String) : Array
      {
         var filter:Function;
         filter = function(param1:GameComposition):Boolean
         {
            if(param1.item.id == itemId)
            {
               return true;
            }
            return false;
         };
         return this.getArray7(filter);
      }
      
      public function getComposition3(param1:String) : Composition
      {
         compositionSearchType = param1;
         return this.getComposition15(this.getInt34);
      }
      
      public function getArray12(param1:String) : Array
      {
         compositionSearchType = param1;
         return this.getArray8(this.getInt34);
      }
      
      public function findNearestCompositionOfType(originI:int, originJ:int, compositionType:String) : Composition
      {
         compositionSearchType = compositionType;
         compositionSearchI = originI;
         compositionSearchJ = originJ;
         return this.getComposition15(this.getInt14);
      }
      
      public function getComposition12(param1:String) : Composition
      {
         compositionSearchType = param1;
         return this.getComposition15(this.getInt7);
      }
      
      protected function getString35(param1:WorldEntity, param2:int, param3:Composition) : String
      {
         return "";
      }
      
      public function getTeleportComposition(param1:WorldEntity, param2:int, param3:Composition = null) : Composition
      {
         return this.findNearestCompositionOfType(param1.i,param1.j,this.getString35(param1,param2,param3));
      }
      
      public function getNPoint6(param1:int, param2:int) : NPoint
      {
         return null;
      }
      
      public function doAction408(param1:int) : void
      {
         var composition:Composition = null;
         for each(composition in this.compositionsById)
         {
            composition.doAction138(param1);
         }
      }
      
      public function check29(param1:Function) : Boolean
      {
         var key:String = null;
         var composition:Composition = null;
         for(key in this.compositionsById)
         {
            composition = this.compositionsById[key];
            if(param1(composition))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getComposition15(param1:Function) : Composition
      {
         var bestScore:int = 0;
         var score:int;
         var bestComposition:Composition = null;
         var key:String;
         var composition:Composition;
         for(key in this.compositionsById)
         {
            composition = this.compositionsById[key];
            score = param1(composition);
            if(score > 0 && bestScore < score)
            {
               bestScore = score;
               bestComposition = composition;
            }
         }
         return bestComposition;
      }
      
      public function getArray5(param1:Function, param2:int, param3:int, param4:int) : Array
      {
         param2 *= 2;
         param3 *= 2;
         param4 *= 2;
         var radiusSquared:int = param4 * param4;
         var result:Array = new Array();
         var composition:Composition;
         var row:int = param2 - param4;
         var column:int;
         while(row <= param2 + param4)
         {
            column = param3 - param4;
            while(column <= param3 + param4)
            {
               if(row >= 0 && row < this.mapHeight * 2 && column >= 0 && column < this.mapWidth * 2 && this.vectorVectorjList1[row][column] != null && (row - param2) * (row - param2) + (column - param3) * (column - param3) <= radiusSquared)
               {
                  for each(composition in this.vectorVectorjList1[row][column])
                  {
                     if(result.indexOf(composition) < 0 && param1(composition))
                     {
                        result.push(composition);
                     }
                  }
               }
               column++;
            }
            row++;
         }
         return result;
      }
      
      public function getArray8(param1:Function) : Array
      {
         var result:Array = new Array();
         var key:String;
         var composition:Composition;
         for(key in this.compositionsById)
         {
            composition = this.compositionsById[key];
            if(param1(composition))
            {
               result.push(composition);
            }
         }
         return result;
      }
      
      public function doAction779(param1:Composition) : void
      {
         var row:int = 0;
         var column:int = 0;
         var bounds:Rectangle = param1.propValue106;
         row = bounds.y;
         while(row < bounds.y + bounds.height)
         {
            column = bounds.x;
            while(column < bounds.x + bounds.width)
            {
               if(this.vectorVectorjList1[row][column] == null)
               {
                  this.vectorVectorjList1[row][column] = new Vector.<Composition>();
               }
               this.vectorVectorjList1[row][column].push(param1);
               column++;
            }
            row++;
         }
         param1.isValue31 = true;
         if(param1.id != 0)
         {
            this.compositionsById[param1.id] = param1;
         }
         else
         {
            this.compositionList2.push(param1);
         }
      }
      
      public function doAction495(param1:WorldEntity) : void
      {
         param1.isValue31 = true;
      }
      
      public function doAction317(param1:Composition, param2:int) : void
      {
         var index:int = 0;
         if(this.compositionsById[param1.id])
         {
            delete this.compositionsById[param1.id];
         }
         if(param1.id == 0)
         {
            index = this.compositionList2.indexOf(param1);
            if(index >= 0)
            {
               this.compositionList2.splice(index,1);
            }
         }
         if(param2 != 0)
         {
            this.compositionsById[param2] = param1;
         }
      }
      
      public function doAction40(composition:Composition) : void
      {
         var i:int;
         var j:int;
         var index:int;
         var cell:Vector.<Composition>;
         var rect:Rectangle = composition.propValue106;
         var idx:int;
         i = rect.y;
         while(i < rect.y + rect.height)
         {
            j = rect.x;
            while(j < rect.x + rect.width)
            {
               try
               {
                  cell = this.vectorVectorjList1[i][j];
               }
               catch(e:Error)
               {
                  cell = null;
               }
               if(cell != null)
               {
                  index = cell.indexOf(composition);
                  if(index >= 0)
                  {
                     cell.splice(index,1);
                     if(cell.length == 0)
                     {
                        this.vectorVectorjList1[i][j] = null;
                     }
                  }
               }
               j++;
            }
            i++;
         }
         composition.isValue31 = false;
         if(this.compositionsById[composition.id])
         {
            delete this.compositionsById[composition.id];
         }
         else
         {
            idx = this.compositionList2.indexOf(composition);
            if(idx >= 0)
            {
               this.compositionList2.splice(idx,1);
            }
         }
      }
      
      public function doAction173(param1:Composition) : void
      {
         if(this.highlightCompositions != null && this.highlightCompositions.indexOf(param1) >= 0)
         {
            this.highlightCompositions.splice(this.highlightCompositions.indexOf(param1),1);
         }
         if(param1.isValue31)
         {
            this.doAction40(param1);
         }
         param1.doAction464();
         this.doAction535(param1);
      }
      
      private function doAction535(param1:Composition) : void
      {
         var index:int = 0;
         var itemIndex:int = param1.objectItems.length - 1;
         while(itemIndex >= 0)
         {
            removeChild(param1.objectItems[itemIndex]);
            index = this.tempObjects.indexOf(param1.objectItems[itemIndex]);
            if(index >= 0)
            {
               this.tempObjects.splice(index,1);
            }
            index = this.objects.indexOf(param1.objectItems[itemIndex]);
            if(index >= 0)
            {
               this.objects.splice(index,1);
            }
            if(this.array30 != null)
            {
               index = this.array30.indexOf(param1.objectItems[itemIndex]);
               if(index >= 0)
               {
                  this.array30.splice(index,1);
               }
            }
            itemIndex--;
         }
         param1.dispose();
         param1.objectItems = new Vector.<WorldObject>();
      }
      
      public function doAction71(param1:int, param2:int) : void
      {
         viewHeight = param2;
         viewWidth = param1;
      }
      
      public function updateOfsX(param1:int) : void
      {
         var offset:int = worldXOfs - param1;
         var index:uint;
         var count:uint = this.objects.length;
         index = 0;
         while(index < count)
         {
            this.objects[index].x += offset;
            index++;
         }
         count = this.tempObjects.length;
         index = 0;
         while(index < count)
         {
            this.tempObjects[index].x += offset;
            index++;
         }
         index = 0;
         while(index < this.players.length)
         {
            this.players[index].x += offset;
            index++;
         }
         x -= offset;
         worldXOfs = param1;
      }
      
      public function updateOfsY(param1:int) : void
      {
         var offset:int = worldYOfs - param1;
         var index:uint;
         var count:uint = this.objects.length;
         index = 0;
         while(index < count)
         {
            this.objects[index].y += offset;
            index++;
         }
         count = this.tempObjects.length;
         index = 0;
         while(index < count)
         {
            this.tempObjects[index].y += offset;
            index++;
         }
         index = 0;
         while(index < this.players.length)
         {
            this.players[index].y += offset;
            index++;
         }
         y -= offset;
         worldYOfs = param1;
      }
      
      public function doAction562(param1:int, param2:int, param3:int, param4:int, param5:BitmapData) : void
      {
         var cellI:int = 0;
         var cellJ:int = 0;
         var position:NPoint = null;
         var matrix:Matrix = new Matrix();
         matrix.tx = -WorldItem.cJHCellSize;
         matrix.ty = -WorldItem.cIHHCellSize;
         cellI = param1;
         while(cellI < param4)
         {
            cellJ = param2;
            while(cellJ < param3)
            {
               position = WorldItem.getCoords(cellI,cellJ);
               if((cellI + cellJ) % 2 == 0)
               {
                  graphics.beginBitmapFill(param5,matrix);
               }
               else
               {
                  graphics.beginBitmapFill(param5);
               }
               graphics.drawRect(position.x - WorldItem.cJHCellSize,position.y - WorldItem.cIHHCellSize,WorldItem.cJCellSize,WorldItem.cICellSize);
               graphics.endFill();
               cellJ++;
            }
            cellI++;
         }
      }
      
      public function addPlayer(param1:WorldEntity) : void
      {
         param1.dir = WorldEntity.WORLD_ENTITY_CONST6;
         this.players.push(param1);
         addChild(param1);
      }
      
      public function check3(param1:Object) : Boolean
      {
         var count:uint = this.hideItems.length;
         var index:uint = 0;
         while(index < count)
         {
            if(param1 == this.hideItems[index])
            {
               return true;
            }
            index++;
         }
         return false;
      }
      
      public function createObject() : WorldObject
      {
         return new WorldObject(this);
      }
      
      public function getWorldObject1(param1:int, param2:int, param3:int, param4:String, param5:String) : WorldObject
      {
         var worldObject:WorldObject = objectFactory1.createObject(null,param1,param2,param3,param4,param5);
         this.doAction480(worldObject);
         sortObj = true;
         return worldObject;
      }
      
      public function getComposition9(param1:Object, param2:int = -10, param3:int = -10, param4:int = 0) : Composition
      {
         throw new Error("not implemented");
      }
      
      public function getWorldEntity2(param1:Object, param2:int = -10, param3:int = -10, param4:int = 0) : WorldEntity
      {
         throw new Error("not implemented");
      }
      
      public function getWorldEntity1(param1:Object, param2:IJPoint = null, param3:int = undefined) : WorldEntity
      {
         throw new Error("not implemented");
      }
      
      public function getObjectGroup1(param1:String) : ObjectGroup
      {
         return objectFactory1.getObjectGroup1(param1);
      }
      
      public function getComposition5(param1:int, param2:int, param3:String, param4:String, param5:String = null, param6:Object = null) : Composition
      {
         var composition:Composition = objectFactory1.getComposition18(param1,param2,param3,param4,param5,param6);
         var index:int = 0;
         while(index < composition.objectItems.length)
         {
            this.doAction480(composition.objectItems[index]);
            index++;
         }
         composition.doAction872();
         sortObj = true;
         return composition;
      }
      
      public function doAction746(param1:Composition) : void
      {
         sortObj = true;
         if(this.array30 == null)
         {
            array30 = new Array();
         }
         param1.doAction262(this.array30);
      }
      
      public function doAction480(param1:WorldObject) : void
      {
         this.tempObjects.push(param1);
      }
      
      public function processWorld(param1:int) : void
      {
      }
      
      public function process(param1:Boolean) : void
      {
         deltaTime = getTimer() - this.lastTime;
         lastTime = getTimer();
         this.processWorld(this.deltaTime);
         var previousEntity:WorldEntity = this.worldEntity2;
         worldEntity2 = null;
         var entity:WorldEntity;
         var index:int = 0;
         var playerCount:int = this.players.length;
         while(index < this.players.length)
         {
            entity = this.players[index];
            entity.animate();
            if(entity.isValue55)
            {
               this.doAction871(entity);
            }
            else
            {
               entity.processState(this.deltaTime);
               if(entity.isValue55)
               {
                  this.doAction871(entity);
               }
               else
               {
                  if(this.worldView.highlightedComposition == null && entity.includesMouse())
                  {
                     worldEntity2 = entity;
                  }
                  index++;
               }
            }
         }
         flag44 = false;
         var previousHidden:Vector.<Composition> = this.hideCompositions;
         hideCompositions = new Vector.<Composition>();
         var previousHighlighted:Vector.<Composition> = this.compositionList3;
         compositionList3 = new Vector.<Composition>();
         highlightCompositions = null;
         var worldObject:WorldObject;
         var globalMouse:Point = new Point();
         globalMouse.x = forcedMouseX < 0 ? stage.mouseX : forcedMouseX;
         globalMouse.y = forcedMouseY < 0 ? stage.mouseY : forcedMouseY;
         var localMouse:Point = new Point();
         index = this.objects.length - 1;
         while(index >= 0)
         {
            worldObject = this.objects[index];
            localMouse = worldObject.globalToLocal(globalMouse);
            worldObject.process(localMouse.x,localMouse.y,globalMouse.x,globalMouse.y);
            index--;
         }
         if(NUIController.sharedController.overItemValue != this.worldView)
         {
            highlightCompositions = null;
            worldEntity2 = null;
            hideCompositions = new Vector.<Composition>();
         }
         index = 0;
         while(index < previousHidden.length)
         {
            if(this.hideCompositions.indexOf(previousHidden[index]) < 0)
            {
               previousHidden[index].isHide = false;
            }
            index++;
         }
         index = 0;
         while(index < this.hideCompositions.length)
         {
            this.hideCompositions[index].isHide = true;
            index++;
         }
         param1 = this.worldView._isChildOver;
         if(this.highlightCompositions != null)
         {
            worldEntity2 = null;
         }
         if(previousEntity != this.worldEntity2)
         {
            if(previousEntity != null)
            {
               previousEntity.highlight = WorldEntity.PLAYER_ITEM_CONST2;
               previousEntity.doAction420();
            }
            if(this.worldEntity2 != null)
            {
               this.worldEntity2.highlight = WorldEntity.PLAYER_ITEM_CONST1;
               this.worldEntity2.doAction592();
            }
         }
         if(param1 && this.highlightCompositions != null)
         {
            index = 0;
            while(index < this.highlightCompositions.length)
            {
               this.doAction824(this.highlightCompositions[index]);
               index++;
            }
         }
         if(this.highlightCompositions != null)
         {
            index = 0;
            while(index < this.highlightCompositions.length)
            {
               this.compositionList3.push(this.highlightCompositions[index]);
               index++;
            }
         }
         index = 0;
         while(index < previousHighlighted.length)
         {
            if(!param1 || this.compositionList3.indexOf(previousHighlighted[index]) < 0)
            {
               previousHighlighted[index].setDefaultHighlight();
            }
            index++;
         }
         index = this.array29.length - 1;
         while(index >= 0)
         {
            this.doAction173(this.array29.pop() as Composition);
            index--;
         }
         this.processEffects();
         this.doAction578();
      }
      
      protected function doAction824(param1:Composition) : void
      {
         var index:int = 0;
         if(param1.managementComposition != this.worldView.highlightedComposition)
         {
            param1.setSelectedHighlight(WorldObject.HIGHLIGHT_1);
         }
         else if(this.check31(param1.managementComposition))
         {
            param1.setSelectedHighlight(WorldObject.HIGHLIGHT_5);
         }
         else
         {
            param1.setSelectedHighlight(WorldObject.HIGHLIGHT_2);
            compositionList3 = this.getComposition11(param1.managementComposition);
            index = 0;
            while(index < this.compositionList3.length)
            {
               this.compositionList3[index].setSelectedHighlight(WorldObject.HIGHLIGHT_3);
               index++;
            }
         }
      }
      
      private function doAction578() : void
      {
         var composition:Composition = null;
         for each(composition in this.compositionsById)
         {
            composition.process();
         }
      }
      
      public function deleteAll() : void
      {
         var compositions:Vector.<Composition> = new Vector.<Composition>();
         var unusedComposition:Composition;
         var key:String;
         var worldObject:WorldObject;
         var effect:EffectObject;
         for(key in this.compositionsById)
         {
            compositions.push(this.compositionsById[key]);
         }
         while(compositions.length > 0)
         {
            this.doAction173(compositions.pop());
         }
         while(this.compositionList2.length > 0)
         {
            this.doAction173(this.compositionList2[0]);
         }
         while(this.tempObjects.length > 0)
         {
            worldObject = this.tempObjects.pop();
            if(worldObject.parent != null)
            {
               removeChild(worldObject);
            }
            worldObject.unloadMovies();
            worldObject.preDelete();
         }
         while(this.objects.length > 0)
         {
            worldObject = this.objects.pop();
            if(worldObject.parent != null)
            {
               removeChild(worldObject);
            }
            worldObject.unloadMovies();
            worldObject.preDelete();
         }
         while(this.effectObjects.length > 0)
         {
            effect = this.effectObjects.pop();
            removeChild(effect);
         }
         while(this.players.length > 0)
         {
            this.doAction871(this.players[0]);
         }
         this.doAction43();
      }
      
      public function doAction43() : void
      {
         while(this.worldBackgroundCount > 0)
         {
            removeChildAt(0);
            --this.worldBackgroundCount;
         }
      }
      
      public function doAction932(param1:WorldEntity) : void
      {
         if(param1.parent != null)
         {
            removeChild(param1);
         }
         var index:int = this.players.indexOf(param1);
         if(index >= 0)
         {
            this.players.splice(this.players.indexOf(param1),1);
         }
      }
      
      public function doAction871(param1:WorldEntity) : void
      {
         param1.dispose();
         this.doAction932(param1);
      }
      
      private function doAction191() : void
      {
         var unusedArray1:Array = new Array();
         var unusedArray2:Array = new Array();
         var unusedArray3:Array = new Array();
         var unusedArray4:Array = new Array();
         var unusedInt:int;
         depthSorter = new DepthSorter();
         this.depthSorter.doAction442(this.objects);
      }
      
      private function sortObjects() : void
      {
         var comparison:int = 0;
         var index:int = 0;
         var objectIndex:int = 0;
         var worldObject:WorldObject = null;
         var insertionIndex:int = 0;
         var followingObject:WorldObject = null;
         var entity:WorldEntity = null;
         if(this.array30 != null)
         {
            index = 0;
            while(index < this.array30.length)
            {
               objectIndex = this.objects.indexOf(this.array30[index]);
               if(objectIndex >= 0 && this.tempObjects.indexOf(this.array30[index]) < 0)
               {
                  this.tempObjects.push(this.array30[index]);
                  this.objects.splice(objectIndex,1);
               }
               index++;
            }
            array30 = null;
         }
         while(this.tempObjects.length > 0)
         {
            worldObject = this.tempObjects.pop();
            followingObject = null;
            index = 0;
            while(followingObject == null && index < this.objects.length)
            {
               comparison = worldObject.getInt10(this.objects[index]);
               if(comparison == 1 || comparison == 0 && worldObject.ijVal < this.objects[index].ijVal)
               {
                  followingObject = this.objects[index];
                  insertionIndex = index;
               }
               index++;
            }
            if(followingObject)
            {
               setChildIndex(worldObject,this.worldBackgroundCount + insertionIndex);
               this.objects.splice(insertionIndex,0,worldObject);
            }
            else
            {
               setChildIndex(worldObject,this.worldBackgroundCount + this.objects.length);
               this.objects.push(worldObject);
            }
            if(worldObject.width != -1)
            {
               for each(entity in this.players)
               {
                  if(worldObject.mapLevel == entity.mapLevel)
                  {
                     if(entity.di == 0 && entity.dj == 0)
                     {
                        if(worldObject.sumStart <= entity.i + entity.j && worldObject.intValue117 >= entity.i + entity.j)
                        {
                           entity.needSort = true;
                        }
                     }
                     else if(worldObject.intValue117 >= entity.sumStart && worldObject.sumStart <= entity.intValue117)
                     {
                        entity.needSort = true;
                     }
                  }
               }
            }
         }
      }
      
      public function sortView() : void
      {
         var sortStartedAt:int = getTimer();
         var sortFlag:Boolean;
         var objectsResorted:Boolean;
         var playerIndex:int;
         var scanIndex:int;
         var unusedEntity1:WorldEntity;
         var unusedEntity2:WorldEntity;
         var temporaryValue:int;
         var unusedObject:Object;
         var comparison:int;
         var player:WorldEntity;
         var visibleCount:int;
         var movedCount:int;
         var sortedObjectIndex:int;
         var unusedIndex:int;
         var childIndex:int;
         var displayedObject:WorldObject;
         var objectIndex:int;
         var sortedIndex:int;
         var swappedObject:WorldObject;
         var insertionIndex:int;
         var nearbyObjectIndex:int;
         var worldObject:WorldObject;
         var objectComparison:int;
         var playerDisplayIndex:int;
         var objectDisplayIndex:int;
         var pendingPlayers:Vector.<WorldEntity>;
         if(this.intValue95 == OFFSET_CHANGE_1)
         {
            if(this.sortObj)
            {
               this.sortObjects();
               if(this.worldView.highlightedComposition == null)
               {
                  this.doAction191();
               }
               sortObj = false;
               flag7 = true;
            }
            sortFlag = true;
            objectsResorted = false;
            if(this.depthSorter != null)
            {
               this.depthSorter.sortTime = Math.max(5,Math.min(20,(this.worldView.propValue127 - (getTimer() - this.intValue74)) * 3 / 4));
               this.depthSorter.doAction685();
               if(this.depthSorter.depthSortComplete)
               {
                  objectsResorted = true;
                  this.depthSorter.depthSortComplete = false;
                  sortedObjectIndex = 0;
                  unusedIndex = 0;
                  for(childIndex = 0; childIndex < this.numChildren; childIndex++)
                  {
                     if(this.getChildAt(childIndex) is WorldObject)
                     {
                        displayedObject = WorldObject(this.getChildAt(childIndex));
                        if(displayedObject.rect.width == -1)
                        {
                           continue;
                        }
                        if(this.depthSorter.sortedItems[sortedObjectIndex] != null)
                        {
                           if(displayedObject != SortItem(this.depthSorter.sortedItems[sortedObjectIndex]).object && displayedObject.parent != null && this.depthSorter.sortedItems[sortedObjectIndex].object.parent != null)
                           {
                              this.swapChildren(displayedObject,this.depthSorter.sortedItems[sortedObjectIndex].object);
                              objectIndex = this.objects.indexOf(displayedObject);
                              sortedIndex = this.objects.indexOf(this.depthSorter.sortedItems[sortedObjectIndex].object);
                              swappedObject = this.objects[objectIndex];
                              this.objects[objectIndex] = this.depthSorter.sortedItems[sortedObjectIndex].object;
                              this.objects[sortedIndex] = swappedObject;
                           }
                        }
                        sortedObjectIndex++;
                     }
                  }
                  flag27 = true;
               }
            }
            intValue74 = getTimer();
            if(this.worldView.highlightedComposition == null)
            {
               if(!this.flag7)
               {
                  flag99 = true;
                  flag27 = false;
                  this.doAction191();
                  sortFlag = false;
               }
               flag7 = true;
            }
            else
            {
               flag7 = false;
            }
            hideItem = null;
            this.hideItems.length = 0;
            visibleCount = this.players.length;
            movedCount = 0;
            while(visibleCount > 0 && !this.players[visibleCount - 1].visible)
            {
               visibleCount--;
            }
            playerIndex = 0;
            while(playerIndex < visibleCount)
            {
               player = this.players[playerIndex];
               if(!player.visible)
               {
                  this.players.splice(playerIndex,1);
                  this.players.push(player);
                  player.intValue228 = int.MIN_VALUE;
                  player.intValue48 = int.MIN_VALUE;
                  visibleCount--;
               }
               else if(player.intValue228 != int(player.x) || player.intValue48 != int(player.y))
               {
                  scanIndex = 0;
                  while(scanIndex < playerIndex && this.players[scanIndex].isPlayerNear(player) >= 0)
                  {
                     scanIndex++;
                  }
                  if(scanIndex < playerIndex)
                  {
                     temporaryValue = playerIndex;
                     while(temporaryValue > scanIndex)
                     {
                        this.players[temporaryValue] = this.players[temporaryValue - 1];
                        temporaryValue--;
                     }
                     this.players[scanIndex] = player;
                     playerIndex++;
                  }
                  else
                  {
                     insertionIndex = playerIndex;
                     scanIndex = playerIndex + 1;
                     while(scanIndex < visibleCount && (temporaryValue = this.players[scanIndex].isPlayerNear(player)) >= 0)
                     {
                        if(temporaryValue > 0)
                        {
                           insertionIndex = scanIndex;
                        }
                        scanIndex++;
                     }
                     if(insertionIndex > playerIndex)
                     {
                        temporaryValue = playerIndex;
                        while(temporaryValue < insertionIndex)
                        {
                           this.players[temporaryValue] = this.players[temporaryValue + 1];
                           temporaryValue++;
                        }
                        this.players[insertionIndex] = player;
                     }
                     else
                     {
                        playerIndex++;
                     }
                  }
                  player.intValue228 = player.x;
                  player.intValue48 = player.y;
                  player.needSort = true;
                  movedCount++;
               }
               else
               {
                  playerIndex++;
               }
            }
            playerIndex = visibleCount - 1;
            while(playerIndex >= 0)
            {
               if(objectsResorted || this.players[playerIndex].needSort)
               {
                  nearbyObjectIndex = -1;
                  if(this.players[playerIndex].lastSortedIdx == -1 || this.players[playerIndex].lastSortedIdx >= this.objects.length)
                  {
                     scanIndex = this.objects.length - 1;
                     while(scanIndex >= 0)
                     {
                        worldObject = WorldObject(this.objects[scanIndex]);
                        if(worldObject.isPlayerNear(this.players[playerIndex]) > 0)
                        {
                           nearbyObjectIndex = scanIndex;
                           break;
                        }
                        scanIndex--;
                     }
                  }
                  else
                  {
                     scanIndex = this.players[playerIndex].lastSortedIdx;
                     while(scanIndex < this.objects.length)
                     {
                        objectComparison = WorldObject(this.objects[scanIndex]).isPlayerNear(this.players[playerIndex]);
                        if(objectComparison > 0)
                        {
                           nearbyObjectIndex = scanIndex;
                        }
                        if(objectComparison < 0)
                        {
                           break;
                        }
                        scanIndex++;
                     }
                     if(nearbyObjectIndex < 0)
                     {
                        scanIndex = this.players[playerIndex].lastSortedIdx - 1;
                        while(scanIndex >= 0)
                        {
                           if(WorldObject(this.objects[scanIndex]).isPlayerNear(this.players[playerIndex]) > 0)
                           {
                              nearbyObjectIndex = scanIndex;
                              break;
                           }
                           scanIndex--;
                        }
                     }
                  }
                  if(nearbyObjectIndex == -1)
                  {
                     this.players[playerIndex].lastSortedIdx = -1;
                     if(this.objects.length > 0 && getChildIndex(this.players[playerIndex]) > getChildIndex(this.objects[0]))
                     {
                        setChildIndex(this.players[playerIndex],getChildIndex(this.objects[0]));
                     }
                  }
                  else
                  {
                     playerDisplayIndex = getChildIndex(this.players[playerIndex]);
                     objectDisplayIndex = getChildIndex(this.objects[nearbyObjectIndex]);
                     this.players[playerIndex].lastSortedIdx = nearbyObjectIndex;
                     if(playerDisplayIndex > objectDisplayIndex + 1)
                     {
                        setChildIndex(this.players[playerIndex],objectDisplayIndex + 1);
                     }
                     else if(playerDisplayIndex < objectDisplayIndex)
                     {
                        setChildIndex(this.players[playerIndex],objectDisplayIndex);
                     }
                  }
               }
               playerIndex--;
            }
            if(objectsResorted || movedCount > visibleCount / 2)
            {
               playerIndex = 0;
               while(playerIndex < this.players.length - 1)
               {
                  scanIndex = playerIndex + 1;
                  while(scanIndex < this.players.length)
                  {
                     comparison = this.players[playerIndex].isPlayerNear(this.players[scanIndex]);
                     if(comparison == -1 && getChildIndex(this.players[playerIndex]) < getChildIndex(this.players[scanIndex]))
                     {
                        setChildIndex(this.players[playerIndex],getChildIndex(this.players[scanIndex]));
                     }
                     if(comparison == 1 && getChildIndex(this.players[playerIndex]) > getChildIndex(this.players[scanIndex]))
                     {
                        setChildIndex(this.players[scanIndex],getChildIndex(this.players[playerIndex]));
                     }
                     scanIndex++;
                  }
                  playerIndex++;
               }
            }
            else
            {
               playerIndex = 0;
               pendingPlayers = new Vector.<WorldEntity>();
               while(playerIndex < visibleCount)
               {
                  player = this.players[playerIndex];
                  if(player.needSort)
                  {
                     player.needSort = false;
                     scanIndex = 0;
                     while(scanIndex < visibleCount)
                     {
                        if(scanIndex != playerIndex)
                        {
                           comparison = player.isPlayerNear(this.players[scanIndex]);
                           if(comparison == -1 && getChildIndex(player) < getChildIndex(this.players[scanIndex]))
                           {
                              setChildIndex(player,getChildIndex(this.players[scanIndex]));
                           }
                           if(comparison == 1 && getChildIndex(player) > getChildIndex(this.players[scanIndex]))
                           {
                              if(!this.players[scanIndex].needSort && pendingPlayers.indexOf(this.players[scanIndex]) < 0)
                              {
                                 pendingPlayers.push(this.players[scanIndex]);
                              }
                              setChildIndex(this.players[scanIndex],getChildIndex(player));
                           }
                        }
                        scanIndex++;
                     }
                  }
                  playerIndex++;
               }
               for each(player in pendingPlayers)
               {
                  player.needSort = false;
                  scanIndex = 0;
                  while(scanIndex < visibleCount)
                  {
                     if(this.players[scanIndex] != player)
                     {
                        comparison = player.isPlayerNear(this.players[scanIndex]);
                        if(comparison == -1 && getChildIndex(player) < getChildIndex(this.players[scanIndex]))
                        {
                           setChildIndex(player,getChildIndex(this.players[scanIndex]));
                        }
                        if(comparison == 1 && getChildIndex(player) > getChildIndex(this.players[scanIndex]))
                        {
                           setChildIndex(this.players[scanIndex],getChildIndex(player));
                        }
                     }
                     scanIndex++;
                  }
               }
            }
         }
      }
      
      public function getLocationIdx(param1:int, param2:int) : int
      {
         return 0;
      }
      
      public function startEffect(param1:int, param2:int, param3:int, param4:int) : void
      {
      }
      
      public function processEffects() : void
      {
         var count:uint = this.effectObjects.length;
         var index:int = 0;
         while(index < count)
         {
            if(this.effectObjects[index].isAlive())
            {
               this.effectObjects[index].process();
            }
            else
            {
               this.delEffect(index);
            }
            index++;
         }
      }
      
      public function delEffect(param1:int) : void
      {
         this.effectObjects[param1].free();
         removeChild(this.effectObjects[param1]);
         var index:int = param1;
         var lastIndex:int = this.effectObjects.length - 1;
         while(index < lastIndex)
         {
            this.effectObjects[index] = this.effectObjects[index + 1];
            index++;
         }
         this.effectObjects.length = this.effectObjects.length - 1;
      }
      
      public function playSound(param1:int, param2:int, param3:int) : void
      {
      }
      
      public function dispose() : void
      {
         this.deleteAll();
      }
      
      private var pendingQueue:Array = new Array();

      private var pathSearchQueue:Array = new Array();

      private var visitedIndexedPathNodes:Array = new Array();

      private var visitedPathSearchNodes:Array = new Array();

      private var curObj:Object;

      private var pathNode:Object;

      private var pathStartRegionId:int;

      private var worldEntity4:WorldEntity;

      private function doAction870(param1:int, param2:int, param3:int, param4:IJPoint = null) : void
      {
         var node:Object = null;
         if(param1 >= 0 && param1 < this.mapHeight / this.MAP_CELL_FACTOR && param2 >= 0 && param2 < this.mapWidth / this.MAP_CELL_FACTOR && !this.check45(param1,param2,param1,param2,param3) && this.indexedPathNodesByCell[param1][param2][param3] == null && (param4 == null || param4.j >= 0 && param4.j < this.mapWidth / this.MAP_CELL_FACTOR && param4.i >= 0 && param4.i < this.mapHeight / this.MAP_CELL_FACTOR && this.check45(param4.i,param4.j,this.curObj.i,this.curObj.j,this.curObj.idx)))
         {
            node = {
               "i":param1,
               "j":param2,
               "idx":param3,
               "predI":this.curObj.i,
               "predJ":this.curObj.j,
               "predIdx":this.curObj.idx,
               "includeInPath":param4 != null
            };
            this.indexedPathNodesByCell[node.i][node.j][node.idx] = node;
            this.pendingQueue.push(node);
            this.visitedIndexedPathNodes.push(node);
         }
      }
      
      public function getNPoint2(param1:int, param2:int, param3:int) : NPoint
      {
         var position:NPoint = WorldItem.getCoords(param1 * this.MAP_CELL_FACTOR,param2 * this.MAP_CELL_FACTOR);
         switch(param3)
         {
            case 0:
               return new NPoint(position.x - WorldItem.cJHCellSize,position.y);
            case 1:
               return new NPoint(position.x + (this.MAP_CELL_FACTOR - 1) * WorldItem.cJHCellSize,position.y - this.MAP_CELL_FACTOR * WorldItem.cIHHCellSize);
            case 2:
               return new NPoint(position.x - WorldItem.cJHCellSize + this.MAP_CELL_FACTOR * WorldItem.cJCellSize,position.y);
            case 3:
               return new NPoint(position.x + (this.MAP_CELL_FACTOR - 1) * WorldItem.cJHCellSize,position.y + this.MAP_CELL_FACTOR * WorldItem.cIHHCellSize);
         }
         return null;
      }
      
      private function getInt3(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : int
      {
         var firstCross:Number = (param7 - param5) * (param2 - param6) - (param8 - param6) * (param1 - param5);
         if((param8 - param6) * (param3 - param1) - (param7 - param5) * (param4 - param2) == 0)
         {
            if(Math.abs(firstCross) < 1)
            {
               if(((param5 - param1) * (param7 - param1) > 0 || (param6 - param2) * (param8 - param2) > 0) && ((param1 - param5) * (param3 - param5) > 0 || (param2 - param6) * (param4 - param6) > 0))
               {
                  return WORLD_BASE_CONST1;
               }
               if((param1 == param5 && param2 == param6 || param1 == param7 && param2 == param8) && (param3 == param5 && param4 == param5 || param3 == param7 && param4 == param8))
               {
                  return WORLD_BASE_CONST3;
               }
               if(param2 == param4)
               {
                  if((param1 - param5) * (param3 - param5) < 0 || (param1 - param7) * (param3 - param7) < 0)
                  {
                     return WORLD_BASE_CONST3;
                  }
                  return WORLD_BASE_CONST1;
               }
               else
               {
                  if((param2 - param6) * (param4 - param6) < 0 || (param2 - param8) * (param4 - param8) < 0)
                  {
                     return WORLD_BASE_CONST3;
                  }
                  return WORLD_BASE_CONST1;
               }
            }
            else
            {
               return WORLD_BASE_CONST1;
            }
         }
         var secondCross:Number = (param7 - param5) * (param4 - param6) - (param8 - param6) * (param3 - param5);
         var thirdCross:Number = (param3 - param1) * (param6 - param2) - (param4 - param2) * (param5 - param1);
         var fourthCross:Number = (param3 - param1) * (param8 - param2) - (param4 - param2) * (param7 - param1);
         if((Math.abs(firstCross) < 1 || Math.abs(secondCross) < 1) && thirdCross * fourthCross <= 0)
         {
            return WORLD_BASE_CONST2;
         }
         if((Math.abs(thirdCross) < 1 || Math.abs(fourthCross) < 1) && firstCross * secondCross <= 0)
         {
            return WORLD_BASE_CONST2;
         }
         if(firstCross * secondCross < 0 && thirdCross * fourthCross < 0)
         {
            return COMPOSITION_CONST8;
         }
         return COMPOSITION_CONST4;
      }
      
      private function getObject10(param1:int, param2:int, param3:int) : Object
      {
         var result:Object = {"coord":this.getNPoint2(param1,param2,param3)};
         var neighborI:int = param1;
         var neighborJ:int = param2;
         switch(param3)
         {
            case 0:
               neighborI--;
               break;
            case 1:
               neighborJ++;
               break;
            case 2:
               neighborI++;
               break;
            case 3:
               neighborJ--;
               break;
         }
         if(neighborI < 0 || neighborJ < 0 || neighborI >= this.mapHeight / this.MAP_CELL_FACTOR || neighborJ >= this.mapWidth / this.MAP_CELL_FACTOR || !this.cellPassebleFunction(neighborI,neighborJ,this.worldEntity4))
         {
            result.parentIsPasseble = false;
         }
         else
         {
            result.parentIsPasseble = true;
         }
         return result;
      }
      
      private function check16(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Boolean
      {
         var corners:Array = new Array();
         var index:int;
         var intersections:int = 0;
         var intersectionType:int;
         index = 0;
         while(index < 4)
         {
            corners.push(this.getObject10(param1,param2,index));
            index++;
         }
         corners.push(corners[0]);
         index = 0;
         while(index < 4)
         {
            intersectionType = this.getInt3(param3,param4,param5,param6,corners[index].coord.x,corners[index].coord.y,corners[index + 1].coord.x,corners[index + 1].coord.y);
            if(intersectionType == COMPOSITION_CONST8 || intersectionType == WORLD_BASE_CONST3 && (!corners[index].parentIsPasseble || this.cellPassebleFunction(param1,param2,this.worldEntity4)))
            {
               return true;
            }
            if(intersectionType == WORLD_BASE_CONST2)
            {
               if(param3 == corners[index].coord.x && param4 == corners[index].coord.y || param3 == corners[index + 1].coord.x && param4 == corners[index + 1].coord.y || param5 == corners[index].coord.x && param6 == corners[index].coord.y || param5 == corners[index + 1].coord.x && param6 == corners[index + 1].coord.y)
               {
                  intersections++;
               }
               else
               {
                  intersections += 2;
               }
            }
            index++;
         }
         if(intersections >= 4)
         {
            return true;
         }
         return false;
      }
      
      private function doAction410(param1:int, param2:int) : void
      {
         var node:Object = null;
         if(param1 >= 0 && param2 >= 0 && param1 < this.mapHeight / this.MAP_CELL_FACTOR && param2 < this.mapWidth / this.MAP_CELL_FACTOR && this.pathSearchNodesByCell[param1][param2] == null)
         {
            node = {
               "i":param1,
               "j":param2,
               "startCell":false
            };
            this.pathSearchQueue.push(node);
            this.visitedPathSearchNodes.push(node);
            this.pathSearchNodesByCell[param1][param2] = node;
         }
      }
      
      private function check46(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var previousCorner:NPoint;
         var currentCorner:NPoint = this.getNPoint2(param1,param1,0);
         var index:int;
         index = 0;
         while(index < 4)
         {
            previousCorner = currentCorner;
            currentCorner = this.getNPoint2(param1,param1,(index + 1) % 4);
            if(Composition.check42(previousCorner.x,previousCorner.y,currentCorner.x,currentCorner.y,param3,param4))
            {
               return true;
            }
            index++;
         }
         return false;
      }
      
      private function check20(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         pathSearchQueue = new Array();
         var startPosition:NPoint = this.getNPoint2(param1,param2,param3);
         if(startPosition.x == param4 && startPosition.y == param5)
         {
            return false;
         }
         var node:Object = {
            "i":param1,
            "j":param2,
            "startCell":true
         };
         this.pathSearchQueue.push(node);
         this.pathSearchNodesByCell[param1][param2] = node;
         this.visitedPathSearchNodes.push(node);
         var result:Boolean = false;
         while(this.pathSearchQueue.length > 0)
         {
            pathNode = this.pathSearchQueue.shift();
            if(this.pathNode.startCell || this.check16(this.pathNode.i,this.pathNode.j,startPosition.x,startPosition.y,param4,param5))
            {
               if(this.pathNode.startCell || this.check45(this.pathNode.i,this.pathNode.j,param1,param2,param3) || this.terrainRegionIds != null && this.terrainRegionIds[this.pathNode.i][this.pathNode.j] != this.pathStartRegionId)
               {
                  this.doAction410(this.pathNode.i,this.pathNode.j + 1);
                  this.doAction410(this.pathNode.i + 1,this.pathNode.j);
                  this.doAction410(this.pathNode.i + 1,this.pathNode.j + 1);
                  this.doAction410(this.pathNode.i,this.pathNode.j - 1);
                  this.doAction410(this.pathNode.i - 1,this.pathNode.j);
                  this.doAction410(this.pathNode.i - 1,this.pathNode.j - 1);
                  this.doAction410(this.pathNode.i - 1,this.pathNode.j + 1);
                  this.doAction410(this.pathNode.i + 1,this.pathNode.j - 1);
               }
               else
               {
                  result = true;
                  break;
               }
            }
            if(this.pathNode.startCell && this.check16(this.pathNode.i,this.pathNode.j,startPosition.x,startPosition.y,param4,param5))
            {
               result = true;
               break;
            }
         }
         while(this.visitedPathSearchNodes.length > 0)
         {
            node = this.visitedPathSearchNodes.pop();
            this.pathSearchNodesByCell[node.i][node.j] = null;
         }
         return result;
      }
      
      public function check45(param1:int, param2:int, param3:int = -1, param4:int = -1, param5:int = -1) : Boolean
      {
         var heightInCells:int = 0;
         var widthInCells:int = 0;
         if(param1 >= 0 && param1 < this.mapHeight / this.MAP_CELL_FACTOR && param2 >= 0 && param2 < this.mapWidth / this.MAP_CELL_FACTOR && this.cellPassebleFunction(param1,param2,this.worldEntity4))
         {
            if(this.check25(param1,param2) && param5 >= 0)
            {
               switch(param5)
               {
                  case 0:
                     param3--;
                     param4--;
                     break;
                  case 1:
                     param3--;
                     break;
                  case 3:
                     param4--;
                     break;
               }
               heightInCells = this.mapHeight / this.MAP_CELL_FACTOR;
               widthInCells = this.mapWidth / this.MAP_CELL_FACTOR;
               param1 = param3;
               while(param1 <= param3 + 1)
               {
                  param2 = param4;
                  while(param2 <= param4 + 1)
                  {
                     if(param1 >= 0 && param1 < heightInCells && param2 >= 0 && param2 < widthInCells && this.terrainGrid[param1][param2] == this.targetTerrainType)
                     {
                        return false;
                     }
                     param2++;
                  }
                  param1++;
               }
               return true;
            }
            else
            {
               return true;
            }
         }
         return false;
      }
      
      private function getNumber8(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var firstDistanceSquared:Number = (param1 - param3) * (param1 - param3) + (param2 - param4) * (param2 - param4);
         var secondDistanceSquared:Number = (param1 - param5) * (param1 - param5) + (param2 - param6) * (param2 - param6);
         var segmentLengthSquared:Number = (param3 - param5) * (param3 - param5) + (param4 - param6) * (param4 - param6);
         var projectionSquared:Number = (secondDistanceSquared - firstDistanceSquared + segmentLengthSquared) / segmentLengthSquared * (secondDistanceSquared - firstDistanceSquared + segmentLengthSquared) / 4;
         return Math.sqrt(secondDistanceSquared - projectionSquared);
      }
      
      public function passCells(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:WorldEntity) : Vector.<NPoint>
      {
         var path:Vector.<NPoint> = this.getNPoint4(param1,param2,param3,param4,param5,param6,param9);
         var startCellI:int;
         var startCellJ:int;
         var targetCell:IJPoint;
         if(path == null)
         {
            startCellI = param1 / this.MAP_CELL_FACTOR;
            startCellJ = param2 / this.MAP_CELL_FACTOR;
            targetCell = WorldItem.getIJCoords(param7,param8);
            if(targetCell.i / this.MAP_CELL_FACTOR < startCellI && param1 > 0)
            {
               path = this.getNPoint4(param1 - 1,param2,param3,param4,param5,param6,param9);
            }
            else if(targetCell.j / this.MAP_CELL_FACTOR > startCellJ && param2 < this.mapWidth - 1)
            {
               path = this.getNPoint4(param1,param2 + 1,param3,param4,param5,param6,param9);
            }
            else if(WorldItem.getIJCoords(param7 - 1,param8).j / this.MAP_CELL_FACTOR < startCellJ && param2 > 0)
            {
               path = this.getNPoint4(param1,param2 - 1,param3,param4,param5,param6,param9);
            }
         }
         return path;
      }
      
      private function get propValue109() : int
      {
         return 30;
      }
      
      private function getNPoint4(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:WorldEntity) : Vector.<NPoint>
      {
         worldEntity4 = param7;
         var startCoords:IJPoint = WorldItem.getIJCoords(param3,param4);
         param1 /= this.MAP_CELL_FACTOR;
         param2 /= this.MAP_CELL_FACTOR;
         if(this.terrainRegionIds != null)
         {
            pathStartRegionId = this.terrainRegionIds[param1][param2];
         }
         else
         {
            pathStartRegionId = 0;
         }
         var targetCoords:IJPoint = WorldItem.getIJCoords(param5,param6);
         var targetCell:IJPoint = new IJPoint(targetCoords.i / this.MAP_CELL_FACTOR,targetCoords.j / this.MAP_CELL_FACTOR);
         if(!this.cellPassebleFunction(targetCoords.i / this.MAP_CELL_FACTOR,targetCoords.j / this.MAP_CELL_FACTOR,this.worldEntity4))
         {
            return null;
         }
         targetTerrainType = this.terrainGrid[int(targetCoords.i / this.MAP_CELL_FACTOR)][int(targetCoords.j / this.MAP_CELL_FACTOR)];
         pendingQueue = new Array();
         var nearestEdgeDistance:int = 32000;
         var edgeDistance:int;
         var edgeIndex:int;
         var nearestEdgeIndex:int = -1;
         var path:Vector.<NPoint> = null;
         var cellCorners:Vector.<NPoint> = new Vector.<NPoint>();
         cornerIndex = 0;
         while(cornerIndex < 4)
         {
            cellCorners.push(this.getNPoint2(param1,param2,cornerIndex));
            cornerIndex++;
         }
         cellCorners.push(cellCorners[0]);
         var cornerIndex:int;
         var intersection:NPoint;
         var neighborPassable:Boolean;
         var unusedFlag:Boolean;
         var cellOffset:int = 1;
         var pathPoint:NPoint;
         var node:Object;
         var closestNode:Object;
         var closestDistanceSquared:int;
         var remainingSearchSteps:int;
         var distanceSquared:int;
         edgeIndex = 0;
         while(edgeIndex < 4)
         {
            switch(edgeIndex)
            {
               case 0:
                  neighborPassable = this.check45(param1 - cellOffset,param2);
                  break;
               case 1:
                  neighborPassable = this.check45(param1,param2 + cellOffset);
                  break;
               case 2:
                  neighborPassable = this.check45(param1 + cellOffset,param2);
                  break;
               case 3:
                  neighborPassable = this.check45(param1,param2 - cellOffset);
                  break;
            }
            if(neighborPassable)
            {
               intersection = Composition.getNPoint8(cellCorners[edgeIndex].x,cellCorners[edgeIndex].y,cellCorners[edgeIndex + 1].x,cellCorners[edgeIndex + 1].y,param3,param4,param5,param6);
               if(intersection == null && Composition.check42(cellCorners[edgeIndex].x,cellCorners[edgeIndex].y,cellCorners[edgeIndex + 1].x,cellCorners[edgeIndex + 1].y,param3,param4))
               {
                  intersection = new NPoint(param3,param4);
                  if((param5 - cellCorners[edgeIndex].x) * (param5 - cellCorners[edgeIndex + 1].x) <= 0 && (param6 - cellCorners[edgeIndex].y) * (param6 - cellCorners[edgeIndex + 1].y) <= 0 && Composition.check42(cellCorners[edgeIndex].x,cellCorners[edgeIndex].y,cellCorners[edgeIndex + 1].x,cellCorners[edgeIndex + 1].y,param5,param6))
                  {
                     path = new Vector.<NPoint>();
                     path.push(new NPoint(param5,param6));
                     return path;
                  }
               }
               if(intersection != null)
               {
                  if(intersection.x == param5 && intersection.y == param6)
                  {
                     path = new Vector.<NPoint>();
                  }
                  else
                  {
                     edgeDistance = (param3 - intersection.x) * (param3 - intersection.x) + (param4 - intersection.y) * (param4 - intersection.y);
                     if(edgeDistance < nearestEdgeDistance)
                     {
                        nearestEdgeDistance = edgeDistance;
                        nearestEdgeIndex = edgeIndex;
                     }
                  }
               }
            }
            edgeIndex++;
         }
         if(nearestEdgeIndex < 0 && check34(param3,param4,cellCorners[0].x,cellCorners[0].y,cellCorners[1].x,cellCorners[1].y,cellCorners[3].x,cellCorners[3].y,cellCorners[2].x,cellCorners[2].y) && check34(param3,param4,cellCorners[0].x,cellCorners[0].y,cellCorners[3].x,cellCorners[3].y,cellCorners[1].x,cellCorners[1].y,cellCorners[2].x,cellCorners[2].y))
         {
            edgeIndex = 0;
            while(edgeIndex < 4)
            {
               switch(edgeIndex)
               {
                  case 0:
                     neighborPassable = this.check45(param1 - cellOffset,param2);
                     break;
                  case 1:
                     neighborPassable = this.check45(param1,param2 + cellOffset);
                     break;
                  case 2:
                     neighborPassable = this.check45(param1 + cellOffset,param2);
                     break;
                  case 3:
                     neighborPassable = this.check45(param1,param2 - cellOffset);
                     break;
               }
               if(neighborPassable)
               {
                  edgeDistance = this.getNumber8(param3,param4,cellCorners[edgeIndex].x,cellCorners[edgeIndex].y,cellCorners[edgeIndex + 1].x,cellCorners[edgeIndex + 1].x);
                  if(edgeDistance < nearestEdgeDistance)
                  {
                     nearestEdgeDistance = edgeDistance;
                     nearestEdgeIndex = edgeIndex;
                  }
               }
               edgeIndex++;
            }
         }
         if(nearestEdgeIndex >= 0)
         {
            node = {
               "i":param1,
               "j":param2,
               "idx":nearestEdgeIndex,
               "predI":null,
               "predJ":null,
               "predIdx":null,
               "includeInPath":true
            };
            this.indexedPathNodesByCell[node.i][node.j][node.idx] = node;
            this.pendingQueue.push(node);
            this.visitedIndexedPathNodes.push(node);
            node = {
               "i":param1,
               "j":param2,
               "idx":(nearestEdgeIndex + 1) % 4,
               "predI":null,
               "predJ":null,
               "predIdx":null,
               "includeInPath":true
            };
            this.indexedPathNodesByCell[node.i][node.j][node.idx] = node;
            this.pendingQueue.push(node);
            this.visitedIndexedPathNodes.push(node);
            closestNode = null;
            closestDistanceSquared = int.MAX_VALUE;
            remainingSearchSteps = 0;
            while(this.pendingQueue.length > 0)
            {
               if(remainingSearchSteps > 0)
               {
                  remainingSearchSteps--;
                  if(remainingSearchSteps == 0)
                  {
                     break;
                  }
               }
               curObj = this.pendingQueue.shift();
               if(!this.check20(this.curObj.i,this.curObj.j,this.curObj.idx,param5,param6))
               {
                  distanceSquared = (this.curObj.i - targetCell.i) * (this.curObj.i - targetCell.i) + (this.curObj.j - targetCell.j) * (this.curObj.j - targetCell.j);
                  if(closestDistanceSquared > distanceSquared)
                  {
                     closestNode = this.curObj;
                     closestDistanceSquared = distanceSquared;
                     remainingSearchSteps = this.propValue109;
                  }
                  continue;
               }
               switch(this.curObj.idx)
               {
                  case 0:
                     this.doAction870(this.curObj.i,this.curObj.j,1,new IJPoint(this.curObj.i - 1,this.curObj.j));
                     this.doAction870(this.curObj.i,this.curObj.j,3,new IJPoint(this.curObj.i,this.curObj.j - 1));
                     this.doAction870(this.curObj.i - 1,this.curObj.j,3);
                     this.doAction870(this.curObj.i - 1,this.curObj.j - 1,2);
                     this.doAction870(this.curObj.i,this.curObj.j - 1,1);
                     break;
                  case 1:
                     this.doAction870(this.curObj.i,this.curObj.j,0,new IJPoint(this.curObj.i - 1,this.curObj.j));
                     this.doAction870(this.curObj.i,this.curObj.j,2,new IJPoint(this.curObj.i,this.curObj.j + 1));
                     this.doAction870(this.curObj.i - 1,this.curObj.j,2);
                     this.doAction870(this.curObj.i - 1,this.curObj.j + 1,3);
                     this.doAction870(this.curObj.i,this.curObj.j + 1,0);
                     break;
                  case 2:
                     this.doAction870(this.curObj.i,this.curObj.j,3,new IJPoint(this.curObj.i + 1,this.curObj.j));
                     this.doAction870(this.curObj.i,this.curObj.j,1,new IJPoint(this.curObj.i,this.curObj.j + 1));
                     this.doAction870(this.curObj.i + 1,this.curObj.j,1);
                     this.doAction870(this.curObj.i + 1,this.curObj.j + 1,0);
                     this.doAction870(this.curObj.i,this.curObj.j + 1,3);
                     break;
                  case 3:
                     this.doAction870(this.curObj.i,this.curObj.j,2,new IJPoint(this.curObj.i + 1,this.curObj.j));
                     this.doAction870(this.curObj.i,this.curObj.j,0,new IJPoint(this.curObj.i,this.curObj.j - 1));
                     this.doAction870(this.curObj.i + 1,this.curObj.j,0);
                     this.doAction870(this.curObj.i + 1,this.curObj.j - 1,1);
                     this.doAction870(this.curObj.i,this.curObj.j - 1,2);
                     break;
               }
            }
            if(closestNode != null)
            {
               path = new Vector.<NPoint>();
               if(!param7.check41(closestNode.i,closestNode.j))
               {
                  param7.stop();
               }
               else
               {
                  pathPoint = this.getNPoint2(closestNode.i,closestNode.j,closestNode.idx);
                  path.push(pathPoint);
                  node = closestNode;
                  while(node.predIdx != null)
                  {
                     node = this.indexedPathNodesByCell[node.predI][node.predJ][node.predIdx];
                     if(node.includeInPath)
                     {
                        if(!param7.check41(node.i,node.j))
                        {
                           path = new Vector.<NPoint>();
                           param7.stop();
                           break;
                        }
                        else
                        {
                           pathPoint = this.getNPoint2(node.i,node.j,node.idx);
                           path.push(pathPoint);
                        }
                     }
                  }
               }
            }
            while(this.visitedIndexedPathNodes.length > 0)
            {
               node = this.visitedIndexedPathNodes.pop();
               this.indexedPathNodesByCell[node.i][node.j][node.idx] = null;
            }
         }
         if(path != null && path.length > 0 && path[0].x == param3 && path[0].y == param4)
         {
            path.splice(0,1);
            if(path.length > 0)
            {
               return null;
            }
         }
         return path;
      }
      
      public function doAction109(param1:WorldEntity, param2:Function) : void
      {
         var playerIndex:int = 0;
         while(playerIndex < this.players.length)
         {
            if(this.players[playerIndex] != param1)
            {
               param2(this.players[playerIndex]);
            }
            playerIndex++;
         }
      }
      
      public function check10(param1:int, param2:int) : Boolean
      {
         return param1 < 0 || param2 < 0 || param1 >= this.mapHeight / this.MAP_CELL_FACTOR || param2 >= this.mapWidth / this.MAP_CELL_FACTOR;
      }
      
      public function update() : void
      {
      }
   }
}

