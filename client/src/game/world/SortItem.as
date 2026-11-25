package game.world
{
   import flash.geom.Rectangle;
   
   public class SortItem
   {
      
      public var depthSortIndex:int;
      
      public var px1:int;
      
      public var px2:int;
      
      public var projectedDepth:int;
      
      public var wh:int;
      
      public var height:int;
      
      public var width:int;
      
      public var i:int;
      
      public var j:int;
      
      public var background:Boolean;
      
      public var depthSorted:Boolean;
      
      public var hasDegenerateBounds:Boolean;
      
      public var flag9:Boolean;
      
      public var object:WorldObject;
      
      public var conflictObject:SortItem;
      
      public function SortItem(worldObject:WorldObject)
      {
         var bounds:Rectangle = null;
         super();
         this.object = worldObject;
         bounds = worldObject.rect;
         this.px1 = bounds.y + bounds.x;
         this.px2 = bounds.y + bounds.x + bounds.height + bounds.width;
         this.projectedDepth = bounds.y - bounds.x;
         this.i = bounds.y;
         this.j = bounds.x;
         this.height = bounds.height;
         this.width = bounds.width;
         this.wh = -bounds.width + bounds.height;
         this.background = bounds.width < 0 || bounds.height < 0;
         this.hasDegenerateBounds = bounds.width == 0 || bounds.height == 0;
         this.flag9 = false;
      }
      
      public function isItemCrossedWith(param1:SortItem) : Boolean
      {
         return param1.px1 < this.px2 && param1.px2 > this.px1;
      }
      
      public function check48(other:SortItem) : Boolean
      {
         var thisDepth:int = this.projectedDepth;
         var otherStart:int = other.px1;
         var otherEnd:int = other.px2;
         var otherDepth:int = other.projectedDepth;
         var intersection:int = 0;
         var thisStart:int = 0;
         var thisHeight:int = this.height;
         var unused:Boolean = false;
         if(otherStart >= this.px1 && otherStart <= this.px2)
         {
            intersection = otherStart;
            thisStart = this.px1;
         }
         else if(otherEnd >= this.px1 && otherEnd <= this.px2)
         {
            intersection = otherEnd;
            thisStart = this.px1;
            otherDepth += other.wh;
         }
         else if(this.px1 > otherStart && this.px1 < otherEnd)
         {
            return !other.check48(this);
         }
         if(intersection <= thisStart + thisHeight)
         {
            thisDepth += intersection - thisStart;
         }
         else
         {
            thisDepth += thisHeight - (intersection - (thisStart + thisHeight));
         }
         return thisDepth > otherDepth;
      }
   }
}

