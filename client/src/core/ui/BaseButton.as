package core.ui
{
   import core.system.TimerUtil;
   import core.events.UIEvents;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   
   public class BaseButton extends UIComponent
   {
      
      public var value:Object;
      
      public var value1:Object;
      
      public var object:Object;
      
      public var object1:Object;
      
      protected var displayObject1:DisplayObject = null;
      
      public var upStateDO:DisplayObject;
      
      public var displayObject3:DisplayObject;
      
      public var displayObject4:DisplayObject;
      
      public var bitmap28:Bitmap;
      
      public var mouseDownCallback3:Function;
      
      public var downHandler:Function = null;
      
      public var upHandler:Function = null;
      
      public var mouseOutCallback:Function = null;
      
      private var over:Boolean = false;
      
      public var isOver:Boolean = false;
      
      public var disableAlpha:Number = 1;
      
      public var textField1:TextField = null;
      
      public var textField2:TextField = null;
      
      public var staticWidth:int = -1;
      
      public var staticHeight:int = -1;
      
      public var intValue16:int = -1;
      
      protected var bitmap20:Bitmap = null;
      
      private var intValue73:int;
      
      public var mouseOverCallback:Function;
      
      public var mouseOutCallback2:Function;
      
      protected var intValue8:int = 0;
      
      protected var intValue57:int = 0;
      
      public function BaseButton(param1:Function, param2:DisplayObject = null, param3:DisplayObject = null, param4:DisplayObject = null, param5:Bitmap = null, param6:String = "")
      {
         super();
         this.hintText = param6;
         this.mouseDownCallback3 = param1;
         this.upStateDO = param2;
         this.displayObject3 = param3;
         this.displayObject4 = param4;
         this.bitmap28 = param5;
         this.setCurrentDO(this.upStateDO);
      }
      
      public function get hintText() : String
      {
         if(propValue147 != null)
         {
            return propValue147.text;
         }
         return null;
      }
      
      public function set hintText(param1:String) : void
      {
         if(param1 != "")
         {
            propValue147 = new HintInfo(param1);
         }
         else
         {
            propValue147 = null;
         }
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,param1,param2);
         graphics.endFill();
         super.setSize(param1,param2);
      }
      
      override public function set childEnabled(param1:Boolean) : void
      {
         if(param1)
         {
            isOver = false;
            selected = false;
            if(this.disableAlpha != 1)
            {
               alpha = 1;
            }
         }
         else
         {
            if(includeMouse())
            {
               isOver = true;
            }
            if(this.disableAlpha != 1)
            {
               alpha = this.disableAlpha;
            }
         }
         super.childEnabled = param1;
      }
      
      override public function get cursorId() : int
      {
         if(selected)
         {
            return this.intValue57;
         }
         if(this.isOver)
         {
            return this.intValue8;
         }
         return Cursor.CURSOR_DEFAULT;
      }
      
      public function get upState() : DisplayObject
      {
         return this.upStateDO;
      }
      
      public function get downState() : DisplayObject
      {
         return this.displayObject4;
      }
      
      public function get overState() : DisplayObject
      {
         return this.displayObject3;
      }
      
      public function set upState(param1:DisplayObject) : void
      {
         if(this.displayObject1 == this.upStateDO)
         {
            this.setCurrentDO(param1);
         }
         upStateDO = param1;
      }
      
      public function set downState(param1:DisplayObject) : void
      {
         if(this.displayObject1 == this.displayObject4)
         {
            this.setCurrentDO(param1);
         }
         displayObject4 = param1;
      }
      
      public function set overState(param1:DisplayObject) : void
      {
         if(this.displayObject1 == this.displayObject3)
         {
            this.setCurrentDO(param1);
         }
         displayObject3 = param1;
      }
      
      public function set propValue13(param1:Bitmap) : void
      {
         bitmap28 = param1;
      }
      
      override public function dispose() : void
      {
         isValue57 = false;
         super.dispose();
      }
      
      override protected function includesMouse() : Boolean
      {
         if(stage != null)
         {
            if(this.staticWidth > 0 && this.staticHeight > 0)
            {
               if(mouseX < this.staticWidth && mouseX >= 0 && mouseY < this.staticHeight && mouseY >= 0)
               {
                  return true;
               }
               return false;
            }
            else
            {
               return super.includesMouse();
            }
         }
         return false;
      }
      
      public function setCurrentDO(param1:DisplayObject) : void
      {
         if(this.displayObject1)
         {
            removeChild(this.displayObject1);
         }
         addChildAt(param1,0);
         displayObject1 = param1;
         width = param1.width;
         height = param1.height;
         if(this.bitmap20)
         {
            setChildIndex(this.bitmap20,getChildIndex(param1));
         }
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.downHandler != null)
         {
            this.downHandler(this);
         }
         selected = true;
         if(this.displayObject4)
         {
            this.setCurrentDO(this.displayObject4);
         }
         super.mouseDownHandler();
      }
      
      protected function doAction127() : void
      {
         if(this.displayObject3 && this.isOver)
         {
            this.setCurrentDO(this.displayObject3);
         }
         else
         {
            this.setCurrentDO(this.upStateDO);
         }
         dispatch(UIEvents.BUTTON_CLICKED,this);
      }
      
      override public function mouseUpHandler() : void
      {
         if(selected && this.upHandler != null)
         {
            this.upHandler(this);
         }
         if(selected && includeMouse())
         {
            if(this.mouseDownCallback3 != null)
            {
               this.mouseDownCallback3(this);
            }
            this.doAction127();
         }
         super.mouseUpHandler();
      }
      
      override public function mouseOverHandler() : void
      {
         isOver = true;
         over = true;
         if(selected && this.displayObject4)
         {
            this.setCurrentDO(this.displayObject4);
         }
         else if(this.displayObject3)
         {
            this.setCurrentDO(this.displayObject3);
         }
         super.mouseOverHandler();
         if(this.mouseOverCallback != null)
         {
            this.mouseOverCallback(this);
         }
      }
      
      override public function mouseOutHandler() : void
      {
         isOver = false;
         if(this.mouseOutCallback != null)
         {
            this.mouseOutCallback(this);
         }
         over = false;
         if(this.upStateDO)
         {
            this.setCurrentDO(this.upStateDO);
         }
         super.mouseOutHandler();
         if(this.mouseOutCallback2 != null)
         {
            this.mouseOutCallback2(this);
         }
      }
      
      public function doAction706(param1:Bitmap, param2:int, param3:int, param4:int) : void
      {
         intValue73 = param4;
         addChild(param1);
         param1.x = param2;
         param1.y = param3;
         bitmap20 = param1;
         param1.visible = false;
      }
      
      public function get isValue57() : Boolean
      {
         return this.intValue16 != -1;
      }
      
      private function doAction291() : void
      {
         this.bitmap20.visible = !this.bitmap20.visible;
      }
      
      public function set isValue57(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.intValue16 == -1)
            {
               intValue16 = TimerUtil.setInterval(this.doAction291,this.intValue73);
               this.bitmap20.visible = true;
            }
         }
         else if(this.intValue16 != -1)
         {
            clearInterval(this.intValue16);
            intValue16 = -1;
            this.bitmap20.visible = false;
         }
      }
   }
}

