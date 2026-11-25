package game.world
{
   import flash.utils.getTimer;
   
   public class DepthSorter
   {
      
      private var errorMessage:String;
      
      private var worldObjectList1:Vector.<WorldObject>;
      
      public var sortedItems:Array;
      
      public var backgroundSortItems:Array;
      
      public var array123:Array;
      
      private var objects:Array;
      
      private var cache:Vector.<ListNode>;
      
      private var lastLinkBySortItemIndex:Array;
      
      private var linkedSortItemCount:int;
      
      private var intValue158:int;
      
      private var lastI:int;
      
      private var depthSortPhase:int;
      
      public var depthSortComplete:Boolean;
      
      private var depthSortActive:Boolean;
      
      private var unsortedItemCount:int;
      
      public var sortTime:int = 20;
      
      public function DepthSorter()
      {
         super();
         this.sortedItems = new Array();
         this.backgroundSortItems = new Array();
         this.objects = new Array();
         this.cache = new Vector.<ListNode>();
         this.lastLinkBySortItemIndex = new Array();
         this.array123 = new Array();
         this.linkedSortItemCount = 0;
         this.intValue158 = 0;
         this.depthSortPhase = 0;
         this.lastI = 0;
         this.depthSortComplete = false;
         this.depthSortActive = false;
      }
      
      public function check49(item:SortItem) : Boolean
      {
         var cachedItem:SortItem = null;
         var index:int = 0;
         while(index < this.linkedSortItemCount)
         {
            cachedItem = this.cache[index].item;
            if(this.check19(cachedItem,item))
            {
               if(!cachedItem.object.composition.isValue31)
               {
                  errorMessage = "Композиция находится в кэше сортировки, однако уже удалена из мира : " + cachedItem.object.composition.objectGroup1.id.toString() + ". Composition id " + cachedItem.object.composition.id;
                  return false;
               }
               if(!item.object.composition.isValue31)
               {
                  errorMessage = "Композиция находится в кэше сортировки, однако уже удалена из мира : " + item.object.composition.objectGroup1.id.toString() + ". Composition1 id " + item.object.composition.id;
                  return false;
               }
               if(cachedItem == item)
               {
                  errorMessage = "Композиции равны!!!";
                  return false;
               }
               this.cache[index].item.conflictObject = item;
               errorMessage += "Внимание!!!! Присутствуют композиции c пересекающиеся физикой.\n" + "Композиция 1: " + cachedItem.object.composition.objectGroup1.id.toString() + ". Композиция 2: " + item.object.composition.objectGroup1.id.toString() + "\n Rect 1: " + WorldObject(this.cache[index].item.object).rect.toString() + ". Rect 2: " + WorldObject(item.object).rect.toString() + "\n" + ". Composition1 id: " + cachedItem.object.composition.id + "\n" + ". Composition2 id: " + item.object.composition.id + "\n";
               return true;
            }
            index++;
         }
         return false;
      }
      
      public function check19(first:SortItem, second:SortItem) : Boolean
      {
         var unused:int = 0;
         var firstTop:int = first.i;
         var firstLeft:int = first.j;
         var firstBottom:int = first.i + first.height;
         var firstRight:int = first.j + first.width;
         var secondTop:int = second.i;
         var secondLeft:int = second.j;
         var secondBottom:int = second.i + second.height;
         var secondRight:int = second.j + second.width;
         return firstLeft < secondRight && secondLeft < firstRight && firstTop < secondBottom && secondTop < firstBottom;
      }
      
      public function check22(param1:SortItem, param2:SortItem) : Boolean
      {
         if(param2.width == 0)
         {
            if(param2.i < param1.i + param1.height && param2.i + param2.height > param1.i + param1.height)
            {
               return param2.j > param1.j && param2.j < param1.j + param1.width;
            }
         }
         else if(param1.i < param2.i + param2.height && param1.i + param1.height > param2.i + param2.height)
         {
            return param1.j > param2.j && param1.j < param2.j + param2.width;
         }
         return false;
      }
      
      public function doAction912() : void
      {
         var newNode:ListNode = new ListNode();
         newNode.item = this.objects[this.linkedSortItemCount];
         newNode.item.depthSortIndex = this.linkedSortItemCount;
         newNode.item.depthSorted = false;
         if(newNode.item.hasDegenerateBounds)
         {
         }
         this.cache[this.linkedSortItemCount] = newNode;
         this.lastLinkBySortItemIndex[this.linkedSortItemCount] = newNode;
         var index:int = 0;
         var link:ListNode;
         while(index < this.linkedSortItemCount)
         {
            if(this.objects[index].isItemCrossedWith(newNode.item))
            {
               link = new ListNode();
               link = new ListNode();
               link.item = newNode.item;
               if(!newNode.item.check48(this.objects[index]))
               {
                  link.item = this.objects[index];
                  this.lastLinkBySortItemIndex[this.linkedSortItemCount].next = link;
                  this.lastLinkBySortItemIndex[this.linkedSortItemCount] = link;
               }
               else
               {
                  this.lastLinkBySortItemIndex[index].next = link;
                  this.lastLinkBySortItemIndex[index] = link;
               }
            }
            index++;
         }
         ++this.linkedSortItemCount;
      }
      
      public function doAction780(param1:SortItem) : void
      {
         if(param1.background)
         {
            this.backgroundSortItems.push(param1);
         }
         else if(!this.check49(param1))
         {
            this.objects.push(param1);
            this.doAction912();
         }
      }
      
      public function doAction685() : void
      {
         if(!this.depthSortActive)
         {
            return;
         }
         if(this.depthSortComplete)
         {
            return;
         }
         var startTime:int = getTimer();
         ++this.depthSortStepCount;
         if(this.depthSortPhase == 0)
         {
            if(this.lastI == 0)
            {
               errorMessage = "";
            }
            while(this.lastI < this.worldObjectList1.length)
            {
               this.doAction780(new SortItem(this.worldObjectList1[this.worldObjectList1.length - this.lastI - 1]));
               ++this.lastI;
               if(getTimer() - startTime > this.sortTime)
               {
                  return;
               }
            }
            if(this.errorMessage != "")
            {
            }
            this.intValue158 = this.objects.length;
            depthSortPhase = 1;
         }
         else
         {
            this.sort();
         }
         if(this.depthSortComplete)
         {
            this.depthSortActive = false;
         }
      }
      
      private var depthSortStepCount:int = 0;

      public function doAction442(param1:Vector.<WorldObject>) : void
      {
         this.sortedItems = new Array();
         this.backgroundSortItems = [];
         this.objects = [];
         this.array123 = [];
         this.linkedSortItemCount = 0;
         this.worldObjectList1 = param1;
         this.depthSortActive = true;
         depthSortStepCount = 0;
      }
      
      public function sort() : void
      {
         var startTime:int = getTimer();
         var previousIndex:int;
         var index:int;
         var node:ListNode;
         var item:SortItem;
         var currentNode:ListNode;
         var ready:Boolean;
         var lastItem:SortItem;
         var linkedItem:SortItem;
         depthSortActive = true;
         if(this.depthSortPhase == 1)
         {
            this.sortedItems = new Array();
            previousIndex = 0;
            unsortedItemCount = this.objects.length;
            depthSortPhase = 2;
         }
         while(this.unsortedItemCount > 0)
         {
            for(index = 0; index < this.objects.length; index++)
            {
               if(getTimer() - startTime > this.sortTime)
               {
                  return;
               }
               node = this.cache[index];
               item = node.item;
               if(item.depthSorted)
               {
                  continue;
               }
               currentNode = node;
               ready = true;
               lastItem = this.lastLinkBySortItemIndex[index].item;
               if(!lastItem.depthSorted)
               {
                  if(lastItem.check48(item))
                  {
                     ready = false;
                     previousIndex = index;
                     index = lastItem.depthSortIndex - 1;
                     continue;
                  }
               }
               ready = true;
               while(currentNode != null)
               {
                  linkedItem = currentNode.item;
                  if(!linkedItem.depthSorted)
                  {
                     if(linkedItem.check48(item))
                     {
                        ready = false;
                        previousIndex = index;
                        index = linkedItem.depthSortIndex - 1;
                        break;
                     }
                  }
                  currentNode = currentNode.next;
               }
               if(ready)
               {
                  if(item.conflictObject != null)
                  {
                     if(item.projectedDepth < item.conflictObject.projectedDepth)
                     {
                        this.sortedItems.unshift(item.conflictObject);
                        this.sortedItems.unshift(item);
                     }
                     else
                     {
                        this.sortedItems.unshift(item);
                        this.sortedItems.unshift(item.conflictObject);
                     }
                  }
                  else
                  {
                     this.sortedItems.unshift(item);
                  }
                  item.depthSorted = true;
                  --this.unsortedItemCount;
                  index = previousIndex - 1;
               }
            }
         }
         this.depthSortComplete = true;
      }
   }
}

