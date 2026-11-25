package ui.controls
{
   import net.NSocket;
   import core.ui.NScrollBar;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import ui.NUIComponent;
   
   public class NPresentsList extends NUIComponent
   {
      
      public var presents:Array;
      
      public var scrollV:int;
      
      protected const USER_CELL_HEIGHT:int = 60;
      
      protected const USER_CELL_WIDTH:int = 90;
      
      public var presentsContainers:Array;
      
      public var presentsSprites:Array;
      
      public var presentsTexts:Array;
      
      public var rows:int;
      
      private var matrix:Matrix = new Matrix();
      
      private var scroll:NScrollBar;
      
      public var texts:Array = new Array(3);
      
      public var container:int;
      
      protected var hintText:String = "";
      
      private var socket:NSocket;
      
      private var topSprite:Sprite;
      
      protected var parentMenu:Object;
      
      protected var dragPresent:PresentItem = null;
      
      protected var dropId:int = 0;
      
      protected var dropIdx:int = 0;
      
      protected var client:Object;
      
      protected var isOver:Boolean = false;
      
      public function NPresentsList(nsocket:NSocket, dragLayer:Sprite, menu:Object, clientObj:Object)
      {
         super();
         this.socket = nsocket;
         this.topSprite = dragLayer;
         this.parentMenu = menu;
         this.client = clientObj;
      }
      
      public function create(visibleCells:int = 1) : void
      {
         mouseChildren = false;
         this.rows = visibleCells;
         presentsContainers = new Array(visibleCells);
         presentsSprites = new Array(visibleCells);
         presentsTexts = new Array(visibleCells);
         presents = new Array();
         scroll = this.createScroll(visibleCells * this.USER_CELL_WIDTH);
         this.scroll.scrollChangeHandler = this.handleScroll;
         this.matrix.createGradientBox(this.USER_CELL_WIDTH / 2,this.USER_CELL_HEIGHT / 2,Math.PI / 2);
         this.drawContainers(this.USER_CELL_WIDTH,this.USER_CELL_HEIGHT);
         width = this.USER_CELL_WIDTH * visibleCells;
         this.scroll.setHorizontal();
         this.scroll.x = 0;
         this.scroll.y = this.USER_CELL_HEIGHT;
         addUIChild(this.scroll);
         container = 0;
      }
      
      protected function createScroll(scrollWidth:int) : NScrollBar
      {
         return null;
      }
      
      public function addPresent(present:PresentItem) : void
      {
         this.presents.push(present);
      }
      
      public function disposePresents() : void
      {
         var i:int = 0;
         while(i < this.presents.length)
         {
            this.presents[i].dispose();
            i++;
         }
         presents = new Array();
      }
      
      override public function dispose() : void
      {
         this.scroll.dispose();
         this.disposePresents();
         super.dispose();
      }
      
      override protected function includesMouse() : Boolean
      {
         if(stage != null && mouseX < this.width && mouseX >= 0 && mouseY < this.USER_CELL_HEIGHT && mouseY >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function drawContainers(cellWidth:int, cellHeight:int) : void
      {
         var i:int = 0;
         var cell:Sprite;
         i = 0;
         while(i < this.rows)
         {
            cell = new Sprite();
            cell.x = i * cellWidth;
            cell.y = 0;
            cell.graphics.beginFill(0,0);
            cell.graphics.drawRect(0,0,cellWidth,cellHeight);
            cell.graphics.endFill();
            this.presentsContainers[i] = cell;
            addChild(cell);
            i++;
         }
      }
      
      public function get maxScrollV() : int
      {
         if(this.numRows - this.rows > 0)
         {
            return this.numRows - this.rows;
         }
         return 0;
      }
      
      protected function handleScroll() : void
      {
         scrollV = this.scroll.scrollPosition;
         this.update();
      }
      
      public function setVals() : void
      {
         if(this.scrollV > this.maxScrollV)
         {
            scrollV = this.maxScrollV;
         }
         this.scroll.setScrollProperties(this.rows,0,this.maxScrollV);
         this.scroll.scrollPosition = this.scrollV;
      }
      
      public function get numRows() : int
      {
         return this.presents.length;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      public function update() : void
      {
         var unused1:int = 0;
         var unused2:int = 0;
         var unused3:int = 0;
         var i:int = 0;
         while(i < this.rows)
         {
            if(this.presents[i + this.scrollV] != null)
            {
               if(this.presentsSprites[i] != null && this.presentsContainers[i].contains(this.presentsSprites[i]))
               {
                  this.presentsContainers[i].removeChild(this.presentsSprites[i]);
               }
               this.presentsSprites[i] = this.presents[i + this.scrollV].loaderSprite;
               this.texts[i] = this.presents[i + this.scrollV].presentText;
               this.presentsContainers[i].addChild(this.presentsSprites[i]);
            }
            else if(this.presentsSprites[i] != null)
            {
               if(this.presentsContainers[i].contains(this.presentsSprites[i]))
               {
                  this.presentsContainers[i].removeChild(this.presentsSprites[i]);
               }
               this.presentsSprites[i] = null;
            }
            i++;
         }
         dispatchEvent(new Event(Event.SCROLL));
      }
      
      override public function mouseWheelHandler(delta:int) : void
      {
         if(delta > 0 && this.scrollV - 1 >= 0)
         {
            scrollV -= delta / 3;
            if(this.scrollV < 0)
            {
               scrollV = 0;
            }
            this.scroll.scrollPosition = this.scrollV;
            this.update();
         }
         if(delta < 0 && this.scrollV + 1 <= this.maxScrollV)
         {
            scrollV -= delta / 3;
            if(this.scrollV > this.maxScrollV)
            {
               scrollV = this.maxScrollV;
            }
            this.scroll.scrollPosition = this.scrollV;
            this.update();
         }
      }
      
      override public function mouseDownHandler() : void
      {
         var i:int;
         var present:PresentItem = null;
         if(this.client.userCharacter.userId == this.parentMenu.character.userId && this.dragPresent == null && this.includesMouse())
         {
            i = 0;
            while(i < this.presentsSprites.length)
            {
               if(this.presentsSprites[i] != null && mouseX >= i * this.USER_CELL_WIDTH && mouseX < (i + 1) * this.USER_CELL_WIDTH && mouseY >= 0 && mouseY < this.USER_CELL_HEIGHT)
               {
                  present = this.presents[i + this.scrollV];
                  if(present.type == PresentItem.PT_DEFAULT && present.presentId != 0)
                  {
                     dragPresent = present;
                     dropIdx = i + this.scrollV;
                     this.topSprite.x = this.x + this.presentsContainers[i].x;
                     this.topSprite.y = this.y + this.presentsContainers[i].y;
                     this.dragPresent.startDrag(this.topSprite);
                     return;
                  }
               }
               i++;
            }
         }
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      public function handleDelete(sender:Object) : void
      {
         this.socket.sendStr("dp|" + this.dropId);
         this.presents[this.dropIdx].dispose();
         this.presents.splice(this.dropIdx,1);
         this.setVals();
         this.update();
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.dragPresent)
         {
            this.dragPresent.stopDrag();
            if(!this.parentMenu.includesMouse())
            {
               dropId = this.dragPresent.presentId;
            }
            dragPresent = null;
            this.update();
         }
      }
   }
}

