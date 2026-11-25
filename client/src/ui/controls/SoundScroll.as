package ui.controls
{
   import core.ui.UIElement;
   import flash.display.DisplayObject;
   import ui.GameCursor;
   
   public class SoundScroll extends UIElement
   {
      
      public static const TYPE_VERTICAL:int = 0;
      
      public static const TYPE_HORIZONTAL:int = 1;
      
      public var value:Number;
      
      public var upDO:DisplayObject;
      
      public var backgroundDO:DisplayObject;
      
      public var changeHandler:Function;
      
      private var _active:Boolean = false;
      
      private var over:Boolean = false;
      
      private var type:int;
      
      private var upOfs1:int;
      
      private var upMin2:int;
      
      private var upMax2:int;
      
      private var startMousePos:int;
      
      private var startValue:Number;
      
      public function SoundScroll(param1:int, param2:Function, param3:DisplayObject, param4:DisplayObject, param5:Number, param6:int, param7:int, param8:int, param9:Object = null)
      {
         super();
         this.changeHandler = param2;
         this.value = param5;
         this.type = param1;
         this.upDO = param3;
         this.backgroundDO = param4;
         this.upOfs1 = param6;
         this.upMin2 = param7;
         this.upMax2 = param8;
         if(param1 == TYPE_VERTICAL)
         {
            param3.x = param6;
         }
         else
         {
            param3.y = param6;
         }
         this.updateUpSprite();
         if(param4)
         {
            addChild(param4);
         }
         addChild(param3);
      }
      
      public function set volume(param1:Number) : void
      {
         value = param1;
         this.updateUpSprite();
      }
      
      public function get volume() : Number
      {
         return this.value;
      }
      
      private function updateUpSprite() : void
      {
         if(this.type == TYPE_VERTICAL)
         {
            this.upDO.y = this.upMin2 + (this.upMax2 - this.upMin2) * this.value;
         }
         else
         {
            this.upDO.x = this.upMin2 + (this.upMax2 - this.upMin2) * this.value;
         }
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && this.upDO.mouseX < this.upDO.width && this.upDO.mouseX >= 0 && this.upDO.mouseY < height && this.upDO.mouseY >= 0;
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.type == TYPE_VERTICAL)
         {
            startMousePos = mouseY;
         }
         else
         {
            startMousePos = mouseX;
         }
         startValue = this.value;
         _active = true;
      }
      
      override public function get cursorId() : int
      {
         return GameCursor.CURSOR_1;
      }
      
      override public function mouseUpHandler() : void
      {
         _active = false;
      }
      
      override public function mouseOverHandler() : void
      {
         over = true;
      }
      
      override public function mouseOutHandler() : void
      {
         over = false;
      }
      
      override public function mouseMoveHandler() : void
      {
         if(this._active)
         {
            if(this.type == TYPE_VERTICAL)
            {
               value = Math.min(1,Math.max(0,this.startValue + (mouseY - this.startMousePos) / (this.upMax2 - this.upMin2)));
            }
            else
            {
               value = Math.min(1,Math.max(0,this.startValue + (mouseX - this.startMousePos) / (this.upMax2 - this.upMin2)));
            }
            this.updateUpSprite();
            this.changeHandler(this);
         }
      }
   }
}

