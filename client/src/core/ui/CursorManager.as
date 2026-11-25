package core.ui
{
   import game.world.WorldBase;
   import flash.display.Sprite;
   import flash.ui.Mouse;
   
   public class CursorManager
   {
      
      public static var sharedInstance:CursorManager;
      
      private var uiElement2:UIElement;
      
      private var cursorContainer:Sprite;
      
      private var cursor1:Cursor = null;
      
      private var hintInfo2:HintInfo = null;
      
      private var cursorsById:Object = new Object();
      
      protected var hint:CursorLayer = null;
      
      private var currentHintOwner:Object = null;
      
      private var flag138:Boolean = true;
      
      public function CursorManager(param1:UIElement, param2:CursorLayer)
      {
         super();
         sharedInstance = this;
         this.hint = param2;
         param2.visible = false;
         this.uiElement2 = param1;
         this.cursorContainer = new Sprite();
         param1.addChild(this.cursorContainer);
         this.cursorContainer.addChild(param2);
      }
      
      protected function getCursor1(param1:int) : Cursor
      {
         throw new Error("createCursor must be overrided");
      }
      
      public function doAction533(param1:int) : void
      {
         this.doAction460(this.getCursor1(param1));
      }
      
      public function doAction460(param1:Cursor) : void
      {
         if(this.cursorsById[param1.cursorId])
         {
            this.cursorsById[param1.cursorId].dispose();
         }
         this.cursorsById[param1.cursorId] = param1;
      }
      
      public function set cursorId(param1:int) : void
      {
         if(param1 >= 0 && this.cursor1 != this.cursorsById[param1] || param1 < 0 && this.cursor1 != null)
         {
            if(this.cursor1)
            {
               this.cursor1.stop();
               this.cursorContainer.removeChild(this.cursor1);
               if(this.cursorsById[param1] == null)
               {
                  Mouse.show();
               }
            }
            else if(this.cursorsById[param1] && this.flag138)
            {
               Mouse.hide();
            }
            if(param1 >= 0)
            {
               cursor1 = this.cursorsById[param1];
            }
            else
            {
               cursor1 = null;
            }
            if(this.cursor1)
            {
               this.cursorContainer.addChild(this.cursor1);
               this.cursor1.play();
            }
         }
      }
      
      private function doAction214() : void
      {
         this.hint.x = -this.hint.width;
         this.hint.y = -this.hint.height;
      }
      
      public function set hintData(param1:HintInfo) : void
      {
         if(this.hint && (this.hintInfo2 == null && param1 != null || this.hintInfo2 && !this.hintInfo2.check44(param1)))
         {
            hintInfo2 = param1;
            if(param1 != null)
            {
               this.hint.setData(param1,this.currentHintOwner != param1.owner);
               this.doAction214();
               this.hint.visible = true;
            }
            else
            {
               this.hint.visible = false;
            }
         }
         if(param1 == null)
         {
            currentHintOwner = null;
         }
         else
         {
            currentHintOwner = param1.owner;
         }
      }
      
      public function get cursorId() : int
      {
         if(this.cursor1 != null)
         {
            return this.cursor1.cursorId;
         }
         return -1;
      }
      
      private function set enabled(param1:Boolean) : void
      {
         flag138 = param1;
         if(this.flag138)
         {
            this.cursorContainer.visible = true;
            if(this.cursor1 != null)
            {
               Mouse.hide();
            }
         }
         else
         {
            this.cursorContainer.visible = false;
            if(this.cursor1 != null)
            {
               Mouse.show();
            }
         }
      }
      
      public function updateCursor() : void
      {
         var stageChild:Object = null;
         var childCount:int = 0;
         var index:int = 0;
         var cursorEnabled:Boolean = false;
         if(this.uiElement2.stage.numChildren > 1)
         {
            childCount = this.uiElement2.stage.numChildren;
            index = 1;
            cursorEnabled = true;
            while(index < childCount && cursorEnabled)
            {
               stageChild = this.uiElement2.stage.getChildAt(index);
               if(stageChild && stageChild.stage && stageChild.hitTestPoint(stageChild.stage.mouseX,stageChild.stage.mouseY,true))
               {
                  cursorEnabled = false;
               }
               index++;
            }
            if(this.flag138 != cursorEnabled)
            {
               enabled = cursorEnabled;
            }
         }
         else if(!this.flag138)
         {
            enabled = true;
         }
         this.cursorContainer.x = WorldBase.forcedMouseX < 0 ? this.uiElement2.mouseX : WorldBase.forcedMouseX;
         this.cursorContainer.y = WorldBase.forcedMouseY < 0 ? this.uiElement2.mouseY : WorldBase.forcedMouseY;
      }
      
      public function get mouseX() : int
      {
         return this.uiElement2.mouseX;
      }
      
      public function get mouseY() : int
      {
         return this.uiElement2.mouseY;
      }
      
      public function get currentCursor() : Cursor
      {
         return this.cursor1;
      }
   }
}

