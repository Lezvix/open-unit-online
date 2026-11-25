package core.ui
{
   import core.system.StateSystem;
   import core.system.EventListeners;
   import core.system.Signal;
   import core.events.UIEvents;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class NUIController extends SizedSprite
   {
      
      public static var sharedController:NUIController;
      
      protected var uiItems:Vector.<UIElement> = new Vector.<UIElement>();
      
      protected var moveItems:Vector.<UIElement> = new Vector.<UIElement>();
      
      protected var wheelItems:Vector.<UIElement> = new Vector.<UIElement>();
      
      protected var mainDownHandler:Function = null;
      
      protected var mainUpHandler:Function = null;
      
      protected var updateMousePosCallback:Function = null;
      
      protected var mainMoveHandler:Function = null;
      
      public var gameStarted:Boolean = false;
      
      private var i:int;
      
      private var j:int;
      
      private var overItem:UIElement = null;
      
      private var curOver:UIElement = null;
      
      private var cursorBoundsWidth:int;
      
      private var cursorBoundsHeight:int;
      
      public var cursorManager:CursorManager = null;
      
      private var idx:int;
      
      private var cursorUpdatesEnabled:Boolean = true;
      
      public function NUIController(param1:BaseApplication, param2:Function, param3:Function = null, param4:Function = null, param5:Function = null)
      {
         super();
         this.mainDownHandler = param2;
         this.mainUpHandler = param3;
         this.updateMousePosCallback = param4;
         this.mainMoveHandler = param5;
         this.doAction836();
      }
      
      public static function getUIElement1(param1:String) : UIElement
      {
         return sharedController.getUIElement1(param1);
      }
      
      public function get isValue46() : Boolean
      {
         return this.cursorUpdatesEnabled;
      }
      
      public function get overItemValue() : UIElement
      {
         return this.overItem;
      }
      
      private function doAction836() : void
      {
         EventListeners.addEventListener(this,MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         EventListeners.addEventListener(this,MouseEvent.MOUSE_UP,this.mouseUpHandler);
         EventListeners.addEventListener(this,Event.ENTER_FRAME,this.doAction804);
         EventListeners.addEventListener(this,MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
         EventListeners.addEventListener(this,MouseEvent.MOUSE_OUT,this.mouseOutHandler);
      }
      
      private function removeListeners() : void
      {
         EventListeners.removeEventListener(this,MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         EventListeners.removeEventListener(this,MouseEvent.MOUSE_UP,this.mouseUpHandler);
         EventListeners.removeEventListener(this,Event.ENTER_FRAME,this.doAction804);
         EventListeners.removeEventListener(this,MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
         EventListeners.removeEventListener(this,MouseEvent.MOUSE_OUT,this.mouseOutHandler);
      }
      
      public function doAction157() : void
      {
         StateSystem.addListener(UIEvents.UI_EVENT_STAGE_OUT,this.doAction192);
         StateSystem.addListener(UIEvents.UI_EVENT_STAGE_IN,this.doAction185);
         StateSystem.addListener(UIEvents.UI_EVENT_PAUSE_HANDLING,this.doAction88);
         StateSystem.addListener(UIEvents.UI_EVENT_UNPAUSE_HANDLING,this.doAction553);
      }
      
      private function doAction88(param1:Signal) : void
      {
         this.removeListeners();
         this.doAction122();
      }
      
      protected function doAction122() : void
      {
      }
      
      protected function doAction729() : void
      {
      }
      
      private function doAction192(param1:Signal) : void
      {
         cursorUpdatesEnabled = false;
         this.removeListeners();
         this.mouseOutHandler(null);
      }
      
      private function doAction185(param1:Signal) : void
      {
         cursorUpdatesEnabled = true;
         this.removeListeners();
         this.doAction836();
         this.updateCursor();
      }
      
      private function doAction553(param1:Signal) : void
      {
         this.removeListeners();
         this.doAction836();
         this.doAction729();
      }
      
      private function doAction183() : void
      {
         if(this.cursorUpdatesEnabled)
         {
            this.updateCursor();
         }
      }
      
      public function setCursorBounds(boundsWidth:int, boundsHeight:int) : void
      {
         cursorBoundsWidth = boundsWidth;
         cursorBoundsHeight = boundsHeight;
         graphics.clear();
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,boundsWidth,boundsHeight);
         graphics.endFill();
      }
      
      public function clearAll() : void
      {
         wheelItems = new Vector.<UIElement>();
         moveItems = new Vector.<UIElement>();
         uiItems = new Vector.<UIElement>();
      }
      
      public function addItem(param1:UIElement, param2:UIComponent = null) : void
      {
         if(param2)
         {
            if(this.uiItems.indexOf(param1) >= 0)
            {
               throw new Error("Adding added UI Item");
            }
            param1.uiParent = param2;
            if(param1.handlesWheel)
            {
               idx = this.wheelItems.indexOf(param2);
               if(this.idx >= 0)
               {
                  while(this.idx < this.wheelItems.length - 1 && this.wheelItems[this.idx + 1].hasUIParent(param2))
                  {
                     ++this.idx;
                  }
                  this.wheelItems.splice(this.idx + 1,0,param1);
               }
               else if(this.wheelItems.length > 0)
               {
                  i = 1;
                  while(this.i < this.wheelItems.length && (!this.wheelItems[this.i - 1].hasUIParent(param2) || this.wheelItems[this.i].hasUIParent(param2)))
                  {
                     ++this.i;
                  }
                  this.wheelItems.splice(this.i,0,param1);
               }
               else
               {
                  this.wheelItems.push(param1);
               }
            }
            if(param1.handlesMove)
            {
               idx = this.moveItems.indexOf(param2);
               if(this.idx >= 0)
               {
                  while(this.idx < this.moveItems.length - 1 && this.moveItems[this.idx + 1].hasUIParent(param2))
                  {
                     ++this.idx;
                  }
                  this.moveItems.splice(this.idx + 1,0,param1);
               }
               else if(this.moveItems.length > 0)
               {
                  i = 1;
                  while(this.i < this.moveItems.length && (!this.moveItems[this.i - 1].hasUIParent(param2) || this.moveItems[this.i].hasUIParent(param2)))
                  {
                     ++this.i;
                  }
                  this.moveItems.splice(this.i,0,param1);
               }
               else
               {
                  this.moveItems.push(param1);
               }
            }
            idx = this.uiItems.indexOf(param2);
            if(this.idx >= 0)
            {
               while(this.idx < this.uiItems.length - 1 && this.uiItems[this.idx + 1].hasUIParent(param2))
               {
                  ++this.idx;
               }
               this.uiItems.splice(this.idx + 1,0,param1);
            }
            else
            {
               this.uiItems.push(param1);
            }
         }
         else
         {
            if(param1.handlesWheel)
            {
               this.wheelItems.push(param1);
            }
            if(param1.handlesMove)
            {
               this.moveItems.push(param1);
            }
            this.uiItems.push(param1);
         }
      }
      
      public function doAction768(param1:UIComponent, param2:UIElement, param3:int) : void
      {
         var index:int = 0;
         index = this.uiItems.indexOf(param2);
         if(index > -1)
         {
            this.uiItems.splice(index,1);
         }
         index = this.uiItems.indexOf(param1);
         if(index > -1)
         {
            this.uiItems.splice(index + 1 + param3,0,param2);
         }
         else
         {
            this.uiItems.push(param2);
         }
      }
      
      public function removeItem(param1:Object) : void
      {
         if(param1.handlesWheel)
         {
            i = 0;
            while(this.i < this.wheelItems.length)
            {
               if(this.wheelItems[this.i] == param1)
               {
                  this.wheelItems.splice(this.i,1);
                  break;
               }
               ++this.i;
            }
         }
         if(param1.handlesMove)
         {
            i = 0;
            while(this.i < this.moveItems.length)
            {
               if(this.moveItems[this.i] == param1)
               {
                  this.moveItems.splice(this.i,1);
                  break;
               }
               ++this.i;
            }
         }
         i = 0;
         while(this.i < this.uiItems.length)
         {
            if(this.uiItems[this.i] == param1)
            {
               this.uiItems.splice(this.i,1);
               break;
            }
            ++this.i;
         }
         if(this.overItem == param1)
         {
            param1.mouseOutHandler();
            this.doAction440(UIElement(param1));
            overItem = null;
         }
         this.updateCursor();
      }
      
      private function processOver() : void
      {
         var item:UIElement = null;
         curOver = null;
         j = this.uiItems.length - 1;
         while(this.j >= 0)
         {
            item = this.uiItems[this.j];
            if(item.isUIVisible && item.isEnabled && item.includeMouse())
            {
               curOver = item;
               return;
            }
            --this.j;
         }
      }
      
      private function doAction662() : void
      {
         var previousItem:UIElement = null;
         var currentItem:UIElement = null;
         do
         {
            this.processOver();
            if(this.curOver != this.overItem)
            {
               previousItem = this.overItem;
               currentItem = this.curOver;
               overItem = this.curOver;
               if(previousItem != null)
               {
                  previousItem.mouseOutHandler();
               }
               if(this.curOver != null && currentItem == this.curOver)
               {
                  this.curOver.mouseOverHandler();
               }
               this.doAction440(previousItem);
            }
         }
         while(this.curOver != this.overItem);
      }
      
      private function doAction440(param1:UIElement) : void
      {
         if(param1 != null)
         {
            if(param1 is UIComponent && !param1.isChildOver)
            {
               UIComponent(param1).doAction954();
            }
            else if(param1.uiParent && !param1.uiParent.isChildOver)
            {
               param1.uiParent.doAction954();
            }
         }
      }
      
      private function mouseWheelHandler(event:MouseEvent) : void
      {
         var item:UIElement = null;
         j = this.wheelItems.length - 1;
         while(this.j >= 0)
         {
            item = this.wheelItems[this.j];
            if(item.isUIVisible && item.isEnabled && item.includeMouse())
            {
               item.mouseWheelHandler(event.delta);
               this.doAction662();
               return;
            }
            --this.j;
         }
      }
      
      public function updateMousePos() : void
      {
         var item:UIElement = null;
         this.doAction662();
         j = this.moveItems.length - 1;
         while(this.j >= 0)
         {
            item = this.moveItems[this.j];
            if(item.isUIVisible && item.isEnabled)
            {
               item.mouseMoveHandler();
            }
            --this.j;
         }
         if(this.updateMousePosCallback != null && this.gameStarted)
         {
            this.updateMousePosCallback();
         }
         this.updateCursor();
      }
      
      private function doAction804(param1:Event) : void
      {
         this.updateMousePos();
      }
      
      private function mouseDownHandler(event:MouseEvent) : void
      {
         var item:UIElement = null;
         j = this.uiItems.length - 1;
         while(this.j >= 0)
         {
            item = this.uiItems[this.j];
            if(item.isUIVisible && item.isEnabled && item.includeMouse())
            {
               item.mouseDownHandler();
               this.updateCursor();
               if(this.mainMoveHandler != null)
               {
                  this.mainMoveHandler(item);
               }
               return;
            }
            --this.j;
         }
         stage.focus = this;
         if(this.mainDownHandler != null && this.gameStarted)
         {
            this.mainDownHandler();
         }
         this.updateCursor();
      }
      
      public function getUIElement1(param1:String) : UIElement
      {
         j = this.uiItems.length - 1;
         while(this.j >= 0)
         {
            if(this.uiItems[this.j].uid == param1 && (this.uiItems[this.j].isUIVisible || this.uiItems[this.j].alwaysReturnItemById))
            {
               return this.uiItems[this.j];
            }
            --this.j;
         }
         return null;
      }
      
      private function mouseUpHandler(event:MouseEvent) : void
      {
         var item:UIElement = null;
         j = 0;
         while(this.j < this.uiItems.length)
         {
            item = this.uiItems[this.j];
            if(item.isUIVisible && item.isEnabled)
            {
               item.mouseUpHandler();
            }
            ++this.j;
         }
         if(this.mainUpHandler != null && this.gameStarted)
         {
            this.mainUpHandler();
         }
         this.updateCursor();
      }
      
      private function mouseOutHandler(event:MouseEvent) : void
      {
         var item:UIElement = null;
         if(this.overItem != null)
         {
            item = this.overItem;
            overItem = null;
            item.mouseOutHandler();
            this.doAction440(item);
         }
         j = 0;
         while(this.j < this.uiItems.length)
         {
            item = this.uiItems[this.j];
            if(item.isUIVisible && item.isEnabled)
            {
               item.mouseUpHandler();
            }
            ++this.j;
         }
         if(this.mainUpHandler != null && this.gameStarted)
         {
            this.mainUpHandler();
         }
         if(this.cursorManager)
         {
            this.cursorManager.cursorId = -1;
            this.cursorManager.hintData = null;
            this.cursorManager.updateCursor();
         }
      }
      
      public function updateCursor() : void
      {
         if(this.cursorManager && mouseX >= 0 && mouseY >= 0 && mouseX < this.cursorBoundsWidth && mouseY < this.cursorBoundsHeight)
         {
            if(this.overItem)
            {
               this.cursorManager.cursorId = this.overItem.cursorId;
               this.cursorManager.hintData = this.overItem.hintData;
            }
            else
            {
               this.cursorManager.cursorId = Cursor.CURSOR_DEFAULT;
               this.cursorManager.hintData = null;
            }
            this.cursorManager.updateCursor();
         }
      }
   }
}

