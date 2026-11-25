package core.ui.views
{
   import core.ui.BaseButton;
   import core.ui.UIComponent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class ButtonView extends BaseButton
   {
      
      protected static const BUTTON_VIEW_CONST5:int = 4;
      
      protected static const BUTTON_VIEW_CONST4:int = 0;
      
      protected static const BUTTON_VIEW_CONST2:int = 1;
      
      protected static const BUTTON_VIEW_CONST3:int = 2;
      
      protected static const BUTTON_VIEW_CONST1:int = 3;
      
      protected const pictureList1:Vector.<Picture> = new Vector.<Picture>(BUTTON_VIEW_CONST5,true);
      
      private var _clickHandler:Function;
      
      private var _pressShift:int;
      
      private var childrenShiftedForPress:Boolean;
      
      public function ButtonView()
      {
         super(this.onClick,new Sprite());
         drawViewBackground = true;
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         _pressShift = param1.pressShift;
         var index:int = 0;
         var picture:Picture;
         while(index < BUTTON_VIEW_CONST5)
         {
            if(param1.images[index])
            {
               picture = new Picture();
               picture.width = width;
               picture.height = height;
               picture.flipHorizontaly = param1.flipHorizontaly;
               picture.flipVerticaly = param1.flipVerticaly;
               picture.doAction439(param1.topPadding,param1.rightPadding,param1.bottomPadding,param1.leftPadding);
               picture.mode = param1.mode;
               picture.doAction549(param1.images[index]);
               this.pictureList1[index] = picture;
            }
            index++;
         }
         if(this.pictureList1[BUTTON_VIEW_CONST4])
         {
            upState = this.pictureList1[BUTTON_VIEW_CONST4];
         }
         overState = this.pictureList1[BUTTON_VIEW_CONST2];
         downState = this.pictureList1[BUTTON_VIEW_CONST3];
      }
      
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != this.enabled)
         {
            super.enabled = param1;
            if(this.pictureList1[BUTTON_VIEW_CONST1])
            {
               this.setCurrentDO(param1 ? upState : this.pictureList1[BUTTON_VIEW_CONST1]);
               this.reshape();
            }
         }
      }
      
      override public function setCurrentDO(param1:DisplayObject) : void
      {
         if(param1 != displayObject1)
         {
            if(displayObject1)
            {
               removeChild(displayObject1);
            }
            addChildAt(param1,0);
            displayObject1 = param1;
            doAction305();
            if(bitmap20)
            {
               setChildIndex(bitmap20,getChildIndex(param1));
            }
         }
      }
      
      override public function reshape(param1:Rectangle = null) : void
      {
         super.reshape(param1);
         var index:int = 0;
         while(index < BUTTON_VIEW_CONST5)
         {
            if(this.pictureList1[index])
            {
               this.pictureList1[index].setActualSize(width,height);
            }
            index++;
         }
         childrenShiftedForPress = false;
         doAction305();
      }
      
      override protected function _addView(param1:UIComponent) : void
      {
         addChild(param1);
      }
      
      protected function onClick(param1:Object) : void
      {
         if(this._clickHandler != null)
         {
            this._clickHandler(this);
         }
      }
      
      private function shift() : void
      {
         var index:int = 0;
         if(!this.childrenShiftedForPress)
         {
            childrenShiftedForPress = true;
            index = 0;
            while(index < uiComponentList2.length)
            {
               uiComponentList2[index].y += this._pressShift;
               index++;
            }
         }
      }
      
      private function unshift() : void
      {
         var index:int = 0;
         if(this.childrenShiftedForPress)
         {
            childrenShiftedForPress = false;
            index = 0;
            while(index < uiComponentList2.length)
            {
               uiComponentList2[index].y -= this._pressShift;
               index++;
            }
         }
      }
      
      override public function mouseDownHandler() : void
      {
         this.shift();
         super.mouseDownHandler();
      }
      
      override public function mouseUpHandler() : void
      {
         this.unshift();
         super.mouseUpHandler();
      }
      
      override public function mouseOutHandler() : void
      {
         this.unshift();
         super.mouseOutHandler();
      }
      
      public function get clickHandler() : Function
      {
         return this._clickHandler;
      }
      
      public function set clickHandler(param1:Function) : void
      {
         _clickHandler = param1;
      }
      
      public function get pressShift() : int
      {
         return this._pressShift;
      }
      
      public function set pressShift(param1:int) : void
      {
         _pressShift = param1;
      }
   }
}

