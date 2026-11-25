package game.world
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class WorldItem extends Sprite
   {
      
      public static var world:WorldBase;
      
      public static const cMapLevelHeight:int = 85;
      
      public static var cIHHCellSize:int = 8;
      
      public static var cJHCellSize:int = 16;
      
      public static var cICellSize:int = 16;
      
      public static var cJCellSize:int = 32;
      
      public static var cMulFactor:int = 16;
      
      public var depth:int;
      
      public var tx:int;
      
      public var ty:int;
      
      private var _worldItemI:Number;
      
      private var _worldItemJ:Number;
      
      public var lastI:int;
      
      public var lastJ:int;
      
      public var muchLast:Boolean = false;
      
      public var mapLevel:int;
      
      public var intValue180:int = -1;
      
      public var displayObject6:DisplayObject;
      
      public function WorldItem(param1:Sprite)
      {
         super();
         if(param1)
         {
            param1.addChild(this);
         }
      }
      
      public static function doAction301(param1:int, param2:int) : void
      {
         cICellSize = param1;
         cJCellSize = param2;
         cIHHCellSize = cICellSize / 2;
         cJHCellSize = cJCellSize / 2;
      }
      
      public static function getDirection1(param1:int, param2:int) : Direction
      {
         var lowerSlope:Number = 0.57;
         var upperSlope:Number = 1 / lowerSlope;
         var coordinateSum:int = param1 + param2;
         var coordinateDifference:int = param1 - param2;
         var slope:Number = coordinateDifference == 0 ? 100 : Math.abs(coordinateSum / coordinateDifference);
         var direction:Direction = new Direction();
         if(slope < lowerSlope)
         {
            direction.doAction240(coordinateDifference > 0 ? Direction.HIDE_822 : Direction.HIDE_76);
         }
         else if(slope > upperSlope)
         {
            direction.doAction240(coordinateSum > 0 ? Direction.D : Direction.HIDE_852);
         }
         else if(coordinateSum > 0)
         {
            direction.doAction240(coordinateDifference > 0 ? Direction.HIDE_83 : Direction.HIDE_22);
         }
         else
         {
            direction.doAction240(coordinateDifference > 0 ? Direction.HIDE_6 : Direction.HIDE_42);
         }
         return direction;
      }
      
      public static function getCoords(param1:int, param2:int) : NPoint
      {
         return new NPoint((param1 + param2) * cJHCellSize - WorldBase.worldXOfs,(param1 - param2) * cIHHCellSize - WorldBase.worldYOfs);
      }
      
      public static function getNPoint7(param1:Number, param2:Number) : NPoint
      {
         return new NPoint((param1 + param2) * cJHCellSize - WorldBase.worldXOfs - cJHCellSize,(param1 - param2) * cIHHCellSize - WorldBase.worldYOfs);
      }
      
      public static function getIJCoords(param1:Number, param2:Number) : IJPoint
      {
         return new IJPoint(((param2 + WorldBase.worldYOfs) * cMulFactor / cICellSize + (param1 + cJHCellSize + WorldBase.worldXOfs) * cMulFactor / cJCellSize) / cMulFactor,((param1 + cJHCellSize + WorldBase.worldXOfs) * cMulFactor / cJCellSize - (param2 + WorldBase.worldYOfs) * cMulFactor / cICellSize) / cMulFactor);
      }
      
      public static function getInt26(param1:Number, param2:Number) : int
      {
         return ((param1 + cJHCellSize + WorldBase.worldXOfs) * cMulFactor / cJCellSize - (param2 + WorldBase.worldYOfs) * cMulFactor / cICellSize) / cMulFactor;
      }
      
      public static function getSecIJCoords(param1:Number, param2:Number) : IJPoint
      {
         return new IJPoint((param2 + WorldBase.worldYOfs) / cIHHCellSize + (param1 + cJHCellSize / 2 + WorldBase.worldXOfs) / cJHCellSize,(param1 + cJHCellSize + cJHCellSize / 2 + WorldBase.worldXOfs) / cJHCellSize - (param2 + WorldBase.worldYOfs) / cIHHCellSize);
      }
      
      public function preDelete() : void
      {
      }
      
      public function isPlayerNear(param1:*) : int
      {
         if(this.ty > param1.ty)
         {
            return 1;
         }
         if(this.ty < param1.ty)
         {
            return -1;
         }
         return 0;
      }
      
      public function isAlive() : Boolean
      {
         return true;
      }
      
      public function setNotHide(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function get isBackground() : Boolean
      {
         return false;
      }
      
      protected function getInt25(param1:int) : int
      {
         return param1 != 0 ? -param1 : param1;
      }
      
      public function getInt47(param1:Rectangle, param2:WorldItem, param3:int, param4:int) : int
      {
         var otherI:int = param2._worldItemI;
         var otherJ:int = param2._worldItemJ;
         if(otherI + otherJ >= param3 && otherI + otherJ <= param4)
         {
            if(otherI >= param1.y + param1.height || otherJ < param1.x || getInt26(param2.x - 1,param2.y) < param1.x)
            {
               return 1;
            }
            if(param2.muchLast && otherI == param1.y + param1.height - 1 && param2.lastI >= param1.y + param1.height)
            {
               return 1;
            }
            return -1;
         }
         return 0;
      }
      
      public function getInt18(param1:Rectangle, param2:Rectangle, param3:int, param4:int, param5:int, param6:int) : int
      {
         var firstDepth:int = 0;
         var secondDepth:int = 0;
         if(param1.width < 0 || param1.height < 0)
         {
            if(param2.width < 0 || param2.height < 0)
            {
               return 0;
            }
            return 1;
         }
         else if(param2.width < 0 || param2.height < 0)
         {
            return -1;
         }
         if(param5 + 2 <= param4 && param6 >= param3 + 2)
         {
            if(param2.y > param1.y + param1.height || param2.x + param2.width < param1.x)
            {
               return 1;
            }
            if(param1.y > param2.y + param2.height || param1.x + param1.width < param2.x)
            {
               return -1;
            }
            firstDepth = param1.y + param1.height - param1.x;
            secondDepth = param2.y + param2.height - param2.x;
            if(firstDepth < secondDepth)
            {
               return 1;
            }
            if(firstDepth > secondDepth)
            {
               return -1;
            }
         }
         return 0;
      }
      
      public function getInt6(param1:Rectangle, param2:Rectangle, param3:int, param4:int, param5:int, param6:int) : int
      {
         var firstDifference:int = 0;
         var secondDifference:int = 0;
         var step:int = 0;
         var coordinateSum:int = 0;
         if(param1.width < 0 || param1.height < 0)
         {
            if(param2.width < 0 || param2.height < 0)
            {
               return 0;
            }
            return 1;
         }
         else if(param2.width < 0 || param2.height < 0)
         {
            return -1;
         }
         if(param5 + 2 <= param4 && param6 >= param3 + 2)
         {
            firstDifference = param1.y - param1.x;
            secondDifference = 0;
            step = 0;
            coordinateSum = param1.x + param1.y;
            step = 0;
            while(step <= param1.height + param1.width)
            {
               if(coordinateSum >= param2.x + param2.y)
               {
                  if(coordinateSum < param2.x + param2.y + param2.height)
                  {
                     secondDifference = coordinateSum - 2 * param2.x;
                  }
                  else if(coordinateSum <= param2.x + param2.y + param2.height + param2.width)
                  {
                     secondDifference = 2 * (param2.y + param2.height) - coordinateSum;
                  }
                  else
                  {
                     secondDifference = -32000;
                  }
               }
               else
               {
                  secondDifference = -32000;
               }
               if(firstDifference < secondDifference)
               {
                  return 1;
               }
               if(firstDifference == secondDifference)
               {
                  if((param2.height == 0 || param2.width == 0) && (step == 0 && param1.height == 0 || step == param1.height + param1.width && param1.width == 0 && coordinateSum < param2.x + param2.y + param2.height) || param1.height > 0 && param1.width > 0 && (param2.width == 0 && step <= param1.height || param2.height == 0 && step >= param1.height))
                  {
                     return 1;
                  }
               }
               coordinateSum++;
               if(step < param1.height)
               {
                  firstDifference++;
               }
               else
               {
                  firstDifference--;
               }
               step++;
            }
            return -1;
         }
         return 0;
      }
      
      public function set i(param1:Number) : void
      {
         _worldItemI = param1;
      }
      
      public function set j(param1:Number) : void
      {
         _worldItemJ = param1;
      }
      
      public function get i() : Number
      {
         return this._worldItemI;
      }
      
      public function get j() : Number
      {
         return this._worldItemJ;
      }
      
      public function get uid() : String
      {
         throw new Error("Abstract function must be overriden");
      }
      
      public function doAction102() : void
      {
      }
   }
}

