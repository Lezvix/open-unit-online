package core.ui.views
{
   import core.ui.UIComponent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class ScrollView extends ContainerView
   {
      
      private static const SCROLL_VIEW_CONST1:Number = 5;
      
      protected var contentView:UIComponent;
      
      protected var configuredScrollDeceleration:Number = 0.001;
      
      protected var _horizontalScrollingEnabled:Boolean = true;
      
      protected var _verticalScrollingEnabled:Boolean = true;
      
      protected const point4:Point = new Point();
      
      protected const _speed:Point = new Point();
      
      protected var activeScrollDeceleration:Number;
      
      protected var scrollStartSpeed:Number;
      
      protected var scrollAnimationActive:Boolean = false;
      
      protected var scrollDragging:Boolean = false;
      
      protected var intValue220:int;
      
      protected var scrollAnimationEndTime:int;
      
      public function ScrollView()
      {
         super();
         this.clear();
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         configuredScrollDeceleration = Math.max(0.001,param1.deceleration);
         _horizontalScrollingEnabled = param1.horizontalScrollingEnabled;
         _verticalScrollingEnabled = param1.verticalScrollingEnabled;
      }
      
      override public function addView(param1:UIComponent) : void
      {
         super.addView(param1);
         param1.onChildMouseDown(this.mouseDownHandler);
      }
      
      override public function add(param1:UIComponent) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         uiComponentList1.push(param1);
         this.contentView.addView(param1);
         sortItems(uiComponentList1.length - 1);
         return true;
      }
      
      override public function reshape(param1:Rectangle = null) : void
      {
         super.reshape(param1);
         this.contentView.reshape();
      }
      
      override protected function _redraw() : void
      {
         graphics.clear();
         var alpha:Number = (propValue119 >> 24 & 0xFF) / 255;
         var color:uint = propValue119 & 0xFFFFFF;
         fillRect(0,0,width,height,color,alpha);
      }
      
      override public function clear() : void
      {
         uiComponentList1.splice(0,uiComponentList1.length);
         if(this.contentView)
         {
            removeUIChild(this.contentView);
         }
         contentView = new UIComponent();
         this.contentView.onChildMouseDown(this.mouseDownHandler);
         addUIChild(this.contentView);
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      public function get verticalScrollingEnabled() : Boolean
      {
         return this._verticalScrollingEnabled;
      }
      
      public function set verticalScrollingEnabled(param1:Boolean) : void
      {
         _verticalScrollingEnabled = param1;
      }
      
      public function get horizontalScrollingEnabled() : Boolean
      {
         return this._horizontalScrollingEnabled;
      }
      
      public function set horizontalScrollingEnabled(param1:Boolean) : void
      {
         _horizontalScrollingEnabled = param1;
      }
      
      public function doAction279(param1:int, param2:int, param3:int) : void
      {
         scrollDragging = false;
         scrollAnimationActive = false;
         var deltaX:int = param1 - this.contentView.x;
         var deltaY:int = param2 - this.contentView.y;
         var distance:Number = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
         if(Math.abs(distance) < 1)
         {
            return;
         }
         this.point4.x = this.contentView.x;
         this.point4.y = this.contentView.y;
         scrollStartSpeed = 2 * distance / param3;
         activeScrollDeceleration = this.scrollStartSpeed / param3;
         this._speed.x = this.scrollStartSpeed * (param1 - this.point4.x) / distance;
         this._speed.y = this.scrollStartSpeed * (param2 - this.point4.y) / distance;
         intValue220 = getTimer();
         scrollAnimationEndTime = this.intValue220 + this.scrollStartSpeed / this.activeScrollDeceleration;
         scrollAnimationActive = true;
      }
      
      protected function onDragBegin() : void
      {
         if(this._horizontalScrollingEnabled || this._verticalScrollingEnabled)
         {
            this.point4.x = mouseX;
            this.point4.y = mouseY;
            scrollDragging = true;
            scrollAnimationActive = false;
         }
      }
      
      protected function doAction776() : void
      {
         var currentMouseX:int = mouseX;
         var currentMouseY:int = mouseY;
         intValue220 = getTimer();
         if(this._horizontalScrollingEnabled)
         {
            this.contentView.x += currentMouseX - this.point4.x;
         }
         if(this._verticalScrollingEnabled)
         {
            this.contentView.y += currentMouseY - this.point4.y;
         }
         this.point4.x = currentMouseX;
         this.point4.y = currentMouseY;
      }
      
      protected function onDragEnd() : void
      {
         scrollDragging = false;
         var time:int = getTimer();
         var elapsed:int = time - this.intValue220;
         this._speed.x = this._horizontalScrollingEnabled ? (mouseX - this.point4.x) / elapsed : 0;
         this._speed.y = this._verticalScrollingEnabled ? (mouseY - this.point4.y) / elapsed : 0;
         scrollStartSpeed = Math.min(SCROLL_VIEW_CONST1,this._speed.length);
         if(this.scrollStartSpeed > 0)
         {
            this.point4.x = this.contentView.x;
            this.point4.y = this.contentView.y;
            intValue220 = time;
            activeScrollDeceleration = this.configuredScrollDeceleration;
            scrollAnimationEndTime = time + this.scrollStartSpeed / this.activeScrollDeceleration;
            scrollAnimationActive = true;
         }
      }
      
      override public function mouseMoveHandler() : void
      {
         super.mouseMoveHandler();
         if(this.scrollDragging)
         {
            this.doAction776();
         }
         else if(this.scrollAnimationActive)
         {
            this.doAction186();
         }
      }
      
      override public function getById(param1:String) : UIComponent
      {
         return super.getById(param1) || this.contentView.getById(param1);
      }
      
      override public function mouseDownHandler() : void
      {
         super.mouseDownHandler();
         this.onDragBegin();
      }
      
      override public function mouseUpHandler() : void
      {
         super.mouseUpHandler();
         if(this.scrollDragging)
         {
            this.onDragEnd();
         }
      }
      
      protected function doAction186() : void
      {
         var time:int = Math.min(this.scrollAnimationEndTime,getTimer());
         var elapsed:int = time - this.intValue220;
         var distance:Number = elapsed * (this.scrollStartSpeed - this.activeScrollDeceleration * elapsed / 2);
         if(this._speed.x != 0)
         {
            this.contentView.x = int(this.point4.x + distance * this._speed.x / this.scrollStartSpeed);
         }
         if(this._speed.y != 0)
         {
            this.contentView.y = int(this.point4.y + distance * this._speed.y / this.scrollStartSpeed);
         }
         if(time >= this.scrollAnimationEndTime)
         {
            scrollAnimationActive = false;
         }
      }
   }
}

