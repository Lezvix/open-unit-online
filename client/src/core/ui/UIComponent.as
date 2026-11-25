package core.ui
{
   import core.ui.views.ViewTypes;
   import core.ui.views.ViewFactory;
   import core.ui.views.Size;
   import core.ui.base.ILayoutItem;
   import core.ui.base.NotificationData;
   import debug.Assert;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UIComponent extends UIElement implements ILayoutItem
   {
      
      private var uiElementList1:Vector.<UIElement> = new Vector.<UIElement>();
      
      private var notificationData1:NotificationData;
      
      private var _backgroundColor:uint;
      
      private var _viewId:String = "";
      
      protected const uiComponentList2:Vector.<UIComponent> = new Vector.<UIComponent>();
      
      private var _viewRotation:Number = 0;
      
      private const _bindingPoint:Point = new Point();
      
      private var _viewAlignment:int;
      
      private const size2:Size = new Size();
      
      private const size1:Size = new Size();
      
      private var _clipToViewRect:Boolean = false;
      
      protected var drawViewBackground:Boolean;
      
      public function UIComponent(param1:Boolean = false)
      {
         super();
         this.drawViewBackground = param1;
      }
      
      final public function doAction600(param1:Object) : void
      {
         this.size2.width = param1.minWidth;
         this.size2.height = param1.minHeight;
         this.size1.width = param1.maxWidth;
         this.size1.height = param1.maxHeight;
         _viewAlignment = param1.alignment;
         x = param1.rect.x;
         y = param1.rect.y;
         numValue39 = param1.rect.width;
         _height = param1.rect.height;
         this._bindingPoint.x = param1.bindingPoint.x;
         this._bindingPoint.y = param1.bindingPoint.y;
         _viewRotation = param1.rotateAngle;
         _backgroundColor = param1.backgroundColor;
         _viewId = param1.id;
         clipedToRect = param1.clipedToRect;
         if(param1.type != ViewTypes.EXTERNAL)
         {
            this._initView(param1);
         }
      }
      
      protected function _initView(param1:Object) : void
      {
      }
      
      override public function get rotation() : Number
      {
         return this._viewRotation;
      }
      
      override public function set rotation(param1:Number) : void
      {
         if(param1 >= 360)
         {
            param1 -= 360 * int(param1 / 360);
         }
         else if(param1 < 0)
         {
            param1 += 360 * (1 + int(-param1 / 360));
         }
         if(this._viewRotation != param1)
         {
            _viewRotation = param1;
            this.doAction115();
         }
      }
      
      private function doAction115() : void
      {
         var matrix:Matrix = null;
         if(this._bindingPoint)
         {
            matrix = new Matrix(1,0,0,1,this._bindingPoint.x,this._bindingPoint.y);
            matrix.rotate(this._viewRotation / 180 * Math.PI);
            matrix.translate(x - this._bindingPoint.x,y - this._bindingPoint.y);
            transform.matrix = matrix;
         }
      }
      
      public function set bindingPoint(param1:Point) : void
      {
         if(this._bindingPoint.x != param1.x || this._bindingPoint.y != param1.y)
         {
            this._bindingPoint.x = param1.x;
            this._bindingPoint.y = param1.y;
            this.reshape();
         }
      }
      
      public function get bindingPoint() : Point
      {
         return this._bindingPoint.clone();
      }
      
      public function set alignment(param1:int) : void
      {
         if(this._viewAlignment != param1)
         {
            _viewAlignment = param1;
            this.reshape();
         }
      }
      
      public function get alignment() : int
      {
         return this._viewAlignment;
      }
      
      public function set propValue119(param1:uint) : void
      {
         if(this._backgroundColor != param1)
         {
            _backgroundColor = param1;
            this._redraw();
         }
      }
      
      override public function set width(param1:Number) : void
      {
         if(numValue39 != param1)
         {
            this.reshape(new Rectangle(x,y,param1,height));
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_height != param1)
         {
            this.reshape(new Rectangle(x,y,width,param1));
         }
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
         if(numValue39 != param1 || _height != param2)
         {
            this.reshape(new Rectangle(x,y,param1,param2));
         }
      }
      
      public function get propValue119() : uint
      {
         return this._backgroundColor;
      }
      
      public function set min(param1:Size) : void
      {
         if(this.size2.width != param1.width || this.size2.height != param1.height)
         {
            this.size2.width = param1.width;
            this.size2.height = param1.height;
            this.reshape();
         }
      }
      
      public function get min() : Size
      {
         return this.size2.clone();
      }
      
      public function set max(param1:Size) : void
      {
         if(this.size1.width != param1.width || this.size1.height != param1.height)
         {
            this.size1.width = param1.width;
            this.size1.height = param1.height;
            this.reshape();
         }
      }
      
      public function get max() : Size
      {
         return this.size1.clone();
      }
      
      public function set viewId(param1:String) : void
      {
         _viewId = param1;
      }
      
      public function get viewId() : String
      {
         return this._viewId;
      }
      
      protected function appendTo(param1:UIComponent) : void
      {
         param1.addUIChild(this);
      }
      
      protected function _addView(param1:UIComponent) : void
      {
         param1.appendTo(this);
      }
      
      public function addView(param1:UIComponent) : void
      {
         var index:int = this.uiComponentList2.indexOf(param1);
         if(index == -1)
         {
            this.uiComponentList2.push(param1);
            this._addView(param1);
         }
      }
      
      override public function onChildMouseDown(param1:Function) : void
      {
         super.onChildMouseDown(param1);
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].onChildMouseDown(param1);
            index++;
         }
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var index:int = 0;
         if(param1 is UIComponent)
         {
            index = this.uiComponentList2.indexOf(param1 as UIComponent);
            if(index >= 0)
            {
               this.uiComponentList2.splice(index,1);
            }
         }
         return super.removeChild(param1);
      }
      
      public function getById(param1:String) : UIComponent
      {
         var index:int = 0;
         var child:UIComponent = null;
         if(param1)
         {
            if(this.viewId == param1)
            {
               return this;
            }
            index = 0;
            while(index < this.uiComponentList2.length)
            {
               child = this.uiComponentList2[index].getById(param1);
               if(child != null)
               {
                  return child;
               }
               index++;
            }
         }
         return null;
      }
      
      public function reshape(param1:Rectangle = null) : void
      {
         var index:int = 0;
         var child:UIComponent = null;
         var childBounds:Rectangle = null;
         if(param1 == null)
         {
            param1 = new Rectangle(x,y,width,height);
         }
         if(this.uiComponentList2)
         {
            index = 0;
            while(index < this.uiComponentList2.length)
            {
               child = this.uiComponentList2[index];
               childBounds = ViewFactory.getRectangle1(this,child,param1);
               child.reshape(childBounds);
               index++;
            }
         }
         x = param1.x;
         y = param1.y;
         numValue39 = param1.width;
         _height = param1.height;
         this.doAction414();
         this._redraw();
         this.doAction115();
      }
      
      protected function _redraw() : void
      {
         var alphaByte:int = 0;
         var color:uint = 0;
         if(this.drawViewBackground)
         {
            graphics.clear();
            alphaByte = this.propValue119 >> 24 & 0xFF;
            if(alphaByte > 0)
            {
               color = this.propValue119 & 0xFFFFFF;
               fillRect(0,0,width,height,color,alphaByte / 255);
            }
         }
      }
      
      protected function doAction202() : void
      {
         graphics.lineStyle(1,16763904);
         graphics.drawRect(0,0,width,height);
      }
      
      protected function check23(param1:UIElement) : Boolean
      {
         return this.uiElementList1.indexOf(param1) >= 0;
      }
      
      public function addUIChild(param1:UIElement) : void
      {
         if(this.check23(param1))
         {
            return;
         }
         if(collisionRect != null)
         {
            param1.collisionRect = collisionRect;
         }
         if(maskSprite != null)
         {
            param1.maskSprite = maskSprite;
         }
         this.uiElementList1.push(param1);
         addChild(param1);
         if(addedToUITree)
         {
            param1.uiParent = this;
            param1.handleAddedToUITree();
         }
         if(!enabled)
         {
            param1.childEnabled = (flag138 & 2) != 0;
            param1.flag138 = flag138 & 2 | 1;
            param1.isEnabled = isEnabled;
         }
         if(!isUIVisible)
         {
            param1.childVisible = (intValue91 & 2) != 0;
         }
         if(mouseDownCallback4 != null)
         {
            param1.onChildMouseDown(mouseDownCallback4);
         }
      }
      
      public function removeUIChild(param1:UIElement) : void
      {
         var index:int = this.uiElementList1.indexOf(param1);
         if(index >= 0)
         {
            this.uiElementList1.splice(index,1);
         }
         else
         {
            throw new Error("Попытка удалить компонент не добавленый в контейнер");
         }
         if(!param1.isValue61)
         {
            this.removeChild(param1);
         }
         if(addedToUITree)
         {
            param1.handleRemovedFromUITree();
            param1.doAction953();
         }
         param1.onChildMouseDown(null);
      }
      
      public function doAction539(param1:int) : void
      {
         var child:UIElement = null;
         if(param1 > -1)
         {
            child = this.uiElementList1.splice(param1,1)[0];
         }
         else
         {
            throw new Error("Попытка удалить компонент не добавленый в контейнер");
         }
         if(!child.isValue61)
         {
            this.removeChild(child);
         }
         if(addedToUITree)
         {
            child.handleRemovedFromUITree();
            child.doAction953();
         }
         child.onChildMouseDown(null);
      }
      
      override public function handleAddedToUITree() : void
      {
         Assert.isTrue(!addedToUITree);
         super.handleAddedToUITree();
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].uiParent = this;
            this.uiElementList1[index].handleAddedToUITree();
            index++;
         }
      }
      
      override public function get isChildOver() : Boolean
      {
         var index:int = this.uiElementList1.length - 1;
         while(index >= 0)
         {
            if(this.uiElementList1[index].isChildOver)
            {
               return true;
            }
            index--;
         }
         return _isChildOver;
      }
      
      override public function handleRemovedFromUITree() : void
      {
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].handleRemovedFromUITree();
            index++;
         }
         super.handleRemovedFromUITree();
      }
      
      override public function set maskSprite(param1:DisplayObject) : void
      {
         super.maskSprite = param1;
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].maskSprite = param1;
            index++;
         }
      }
      
      override public function set collisionRect(param1:Rectangle) : void
      {
         super.collisionRect = param1;
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].collisionRect = param1;
            index++;
         }
      }
      
      override public function set childEnabled(param1:Boolean) : void
      {
         super.childEnabled = param1;
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].childEnabled = param1;
            index++;
         }
      }
      
      override public function set childVisible(param1:Boolean) : void
      {
         super.childVisible = param1;
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].childVisible = param1;
            index++;
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].childVisible = param1;
            index++;
         }
      }
      
      public function disposeAllChilds() : void
      {
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.removeChild(this.uiElementList1[index]);
            if(addedToUITree)
            {
               this.uiElementList1[index].handleRemovedFromUITree();
            }
            index++;
         }
         uiElementList1 = new Vector.<UIElement>();
         doAction141();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var index:int = 0;
         while(index < this.uiElementList1.length)
         {
            this.uiElementList1[index].dispose();
            index++;
         }
      }
      
      private var array39:Array = [];

      public function doAction760(param1:Object) : void
      {
         this.addUIChild(param1 as UIElement);
         this.array39.push(param1);
      }
      
      public function doAction930(param1:Object) : void
      {
         var index:int = this.array39.indexOf(param1);
         if(index >= 0)
         {
            this.array39.splice(index,1);
            this.removeUIChild(param1 as UIElement);
         }
      }
      
      public function get propValue23() : NotificationData
      {
         return this.notificationData1;
      }
      
      public function set propValue23(param1:NotificationData) : void
      {
         notificationData1 = param1;
      }
      
      public function setSelectedHighlight(param1:int) : void
      {
      }
      
      public function get isValue31() : Boolean
      {
         return parent != null;
      }
      
      public function get propValue18() : String
      {
         return "";
      }
      
      public function set isValue9(param1:Boolean) : void
      {
      }
      
      public function get clipedToRect() : Boolean
      {
         return this._clipToViewRect;
      }
      
      public function set clipedToRect(param1:Boolean) : void
      {
         if(this._clipToViewRect != param1)
         {
            _clipToViewRect = param1;
            if(param1)
            {
               if(!propValue176)
               {
                  addChild(propValue176 = new Sprite());
               }
               this.doAction414();
            }
            else
            {
               propValue176 = null;
            }
         }
      }
      
      private function doAction414() : void
      {
         var mask:Sprite = null;
         if(this.clipedToRect)
         {
            if(propValue176)
            {
               mask = propValue176 as Sprite;
               mask.graphics.beginFill(0,0);
               mask.graphics.drawRect(0,0,width,height);
               mask.graphics.endFill();
            }
         }
      }
      
      public function doAction27(param1:Function) : void
      {
         this.uiElementList1.sort(param1);
         var index:int = 0;
         var child:UIElement;
         while(index < this.uiElementList1.length)
         {
            child = this.uiElementList1[index];
            setChildIndex(child,index);
            NUIController.sharedController.doAction768(this,child,index);
            index++;
         }
      }
   }
}

