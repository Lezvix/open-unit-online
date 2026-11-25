package core.ui
{
   import core.resources.ResourceManager;
   import core.system.StateSystem;
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import core.system.Signal;
   import core.events.PositionEvents;
   import com.flashdynamix.motion.TweensyZero;
   import debug.Assert;
   import core.effects.TweenEffect;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.getQualifiedClassName;
   import mx.utils.GraphicsUtil;
   
   public class UIElement extends SizedSprite implements IPositionable
   {
      
      public static const UIELEMENT_CONST1:int = 0;
      
      public static const UIELEMENT_CONST2:int = 1;
      
      private static var intValue196:int = 0;
      
      public static var uiPackId:int = -1;
      
      public var uiParent:UIComponent = null;
      
      private var rect2:Rectangle = null;
      
      public var flag119:Boolean = false;
      
      public var addedToUITree:Boolean = false;
      
      private var array11:Array = null;
      
      private var array4:Array = null;
      
      private var array53:Array = null;
      
      public var disposeOnRemove:Boolean = true;
      
      private var array63:Array = new Array();
      
      private var array1:Array = new Array();
      
      private var array19:Array = new Array();
      
      private var array36:Array = new Array();
      
      private var array18:Array = new Array();
      
      private var array42:Array = new Array();
      
      private var array22:Array = new Array();
      
      private var array115:Array = new Array();
      
      private var array105:Array = new Array();
      
      private var actionSignals:Object = new Object();
      
      private var numValue9:Number;
      
      private var numValue44:Number;
      
      private var numValue28:Number;
      
      private var numValue51:Number;
      
      private var initWidth:Number;
      
      private var initHeight:Number;
      
      private var numValue56:Number;
      
      public var _isChildOver:Boolean = false;
      
      public var selected:Boolean = false;
      
      public var isUIVisible:Boolean = true;
      
      public var isEnabled:Boolean = true;
      
      public var flag138:int = 3;
      
      protected var intValue91:int = 3;
      
      private var processInterval:int = -1;
      
      private var hintInfo1:HintInfo = null;
      
      public var handlesMouse:Boolean = true;
      
      private var _storedX:Number = 0;
      
      private var _storedY:Number = 0;
      
      private var obj56:Object;
      
      private var _uiElementUid:String = null;
      
      private var _alwaysReturnItemById:Boolean = false;
      
      private var displayObject7:DisplayObject;
      
      private var bitmapData5:BitmapData = null;
      
      private var cachedBounds:Rectangle;
      
      public function UIElement()
      {
         super();
         this._uiElementUid = intValue196.toString();
         ++intValue196;
      }
      
      public static function getBitmap6(param1:String) : Bitmap
      {
         var bitmap:Bitmap = null;
         if(uiPackId >= 0)
         {
            bitmap = ResourceManager.sharedInstance.getBmp(uiPackId,param1);
         }
         else
         {
            bitmap = ResourceManager.sharedInstance.getBitmap2(param1);
         }
         return bitmap;
      }
      
      public function get className() : String
      {
         var qualifiedName:String = getQualifiedClassName(this);
         var separator:int = qualifiedName.indexOf("::");
         if(separator != -1)
         {
            qualifiedName = qualifiedName.substr(separator + 2);
         }
         return qualifiedName;
      }
      
      public function doAction305() : void
      {
         if(this.bitmapData5 != null)
         {
            this.bitmapData5.dispose();
            bitmapData5 = null;
         }
         cachedBounds = getBounds(this);
         if(this.cachedBounds.width > 0 && this.cachedBounds.height > 0)
         {
            bitmapData5 = new BitmapData(this.cachedBounds.width,this.cachedBounds.height,true,0);
            this.bitmapData5.draw(this,new Matrix(1,0,0,1,-this.cachedBounds.x,-this.cachedBounds.y));
         }
      }
      
      private function get isValue4() : Boolean
      {
         if(mouseX >= this.cachedBounds.x && mouseY >= this.cachedBounds.y && mouseX < this.cachedBounds.right && mouseY < this.cachedBounds.bottom && (this.bitmapData5.getPixel32(mouseX - this.cachedBounds.x,mouseY - this.cachedBounds.y) >> 24 & 0xFF) > 0)
         {
            return true;
         }
         return false;
      }
      
      public function get alwaysReturnItemById() : Boolean
      {
         return this._alwaysReturnItemById;
      }
      
      public function set alwaysReturnItemById(param1:Boolean) : void
      {
         _alwaysReturnItemById = param1;
      }
      
      public function get uid() : String
      {
         return this._uiElementUid;
      }
      
      public function set uid(param1:String) : void
      {
         _uiElementUid = param1;
      }
      
      public function get propValue47() : Array
      {
         return TweensyZero.getArray14(this);
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = int(param1);
         _storedX = param1;
         this.doAction360(PositionEvents.POSITION_CHANGED);
      }
      
      override public function get x() : Number
      {
         return this._storedX;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = int(param1);
         _storedY = param1;
         this.doAction360(PositionEvents.POSITION_CHANGED);
      }
      
      override public function get y() : Number
      {
         return this._storedY;
      }
      
      public function doAction184(param1:Number, param2:Number) : void
      {
         super.x = param1;
         super.y = param2;
      }
      
      public function set maskSprite(param1:DisplayObject) : void
      {
         displayObject7 = param1;
      }
      
      public function get maskSprite() : DisplayObject
      {
         return this.displayObject7;
      }
      
      public function get collisionRect() : Rectangle
      {
         return this.rect2;
      }
      
      public function set collisionRect(param1:Rectangle) : void
      {
         rect2 = param1;
      }
      
      public function set propValue176(param1:DisplayObject) : void
      {
         mask = param1;
         maskSprite = param1;
      }
      
      private function doAction801(param1:DisplayObject) : void
      {
         collisionRect = new Rectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function get propValue176() : DisplayObject
      {
         return mask;
      }
      
      protected function getState(param1:Class) : Object
      {
         return StateSystem.system.getState(param1);
      }
      
      protected function dispatch(param1:String, ... rest) : void
      {
         StateSystem.dispatch.apply(null,[param1].concat(rest));
      }
      
      protected function doAction174(param1:Signal, ... rest) : void
      {
         StateSystem.doAction174.apply(null,[param1].concat(rest));
      }
      
      public function doAction149(param1:String, param2:Function) : void
      {
         var signal:Signal = this.actionSignals[param1];
         if(signal == null)
         {
            signal = new Signal(param1);
            this.actionSignals[param1] = signal;
         }
         signal.addListener(param2);
      }
      
      public function doAction911(param1:String, param2:Function) : void
      {
         var signal:Signal = this.actionSignals[param1];
         if(signal != null)
         {
            signal.removeListener(param2);
            if(signal.hasNoListeners)
            {
               delete this.actionSignals[param1];
            }
         }
      }
      
      protected function doAction360(param1:String, ... rest) : void
      {
         var signal:Signal = null;
         if(this.actionSignals != null)
         {
            signal = this.actionSignals[param1];
            if(signal != null)
            {
               signal.dispatch.apply(null,rest);
            }
         }
      }
      
      protected function doAction905(param1:Signal, ... rest) : void
      {
         var signal:Signal = null;
         if(this.actionSignals != null)
         {
            signal = this.actionSignals[param1.id];
            if(signal != null)
            {
               signal.doAction174.apply(null,[param1].concat(rest));
            }
         }
      }
      
      public function addListener(param1:String, param2:Function) : void
      {
         this.array105.push({
            "id":param1,
            "handler":param2
         });
         StateSystem.system.addListener(param1,param2);
      }
      
      public function removeListener(param1:String, param2:Function) : void
      {
         var index:int = 0;
         while(index < this.array105.length)
         {
            if(this.array105[index].id == param1 && this.array105[index].handler == param2)
            {
               this.array105.splice(index,1);
            }
            else
            {
               index++;
            }
         }
         StateSystem.system.removeListener(param1,param2);
      }
      
      private function doAction857() : void
      {
         if(this.processInterval >= 0)
         {
            clearInterval(this.processInterval);
         }
      }
      
      public function get processIntervalValue() : int
      {
         return this.processInterval;
      }
      
      public function set processIntervalValue(param1:int) : void
      {
         this.doAction857();
         if(param1 > 0)
         {
            processInterval = TimerUtil.setInterval(this.process,param1);
         }
      }
      
      protected function process() : void
      {
      }
      
      public function bitmaps(param1:Object) : void
      {
         if(this.array53 == null)
         {
            array53 = new Array();
         }
         this.array53.push(param1);
      }
      
      public function get propValue147() : HintInfo
      {
         return this.hintInfo1;
      }
      
      public function set propValue147(param1:HintInfo) : void
      {
         hintInfo1 = param1;
         if(this.hintInfo1)
         {
            this.hintInfo1.owner = this;
         }
      }
      
      public function hasUIParent(param1:UIElement) : Boolean
      {
         var ancestor:UIElement = this.uiParent;
         while(ancestor != null)
         {
            if(param1 == ancestor)
            {
               return true;
            }
            ancestor = ancestor.uiParent;
         }
         return false;
      }
      
      public function get handlesMove() : Boolean
      {
         return false;
      }
      
      public function get handlesWheel() : Boolean
      {
         return false;
      }
      
      public function get cursorId() : int
      {
         return Cursor.CURSOR_DEFAULT;
      }
      
      public function get hintData() : HintInfo
      {
         return this.hintInfo1;
      }
      
      public function includeMouse() : Boolean
      {
         if((this.maskSprite == null || this.maskSprite.mouseX < this.maskSprite.width && this.maskSprite.mouseX >= 0 && this.maskSprite.mouseY < this.maskSprite.height && this.maskSprite.mouseY >= 0) && (this.rect2 == null || mouseX < this.rect2.width + this.rect2.x && mouseX >= this.rect2.x && mouseY < this.rect2.height + this.rect2.y && mouseY >= this.rect2.y) && this.includesMouse())
         {
            return true;
         }
         return false;
      }
      
      public function fillRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:Number = 1) : void
      {
         graphics.beginFill(param5,param6);
         graphics.drawRect(param1,param2,param3,param4);
         graphics.endFill();
      }
      
      public function drawTile(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function draw(param1:Bitmap, param2:int = 0, param3:int = 0) : void
      {
         var matrix:Matrix = new Matrix(1,0,0,1,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param1.width,param1.height);
         graphics.endFill();
      }
      
      public function drawHLine(param1:int, param2:int, param3:int, param4:uint) : void
      {
         graphics.beginFill(param4);
         graphics.drawRect(param1,param2,param3,1);
         graphics.endFill();
      }
      
      public function drawVLine(param1:int, param2:int, param3:int, param4:uint) : void
      {
         graphics.beginFill(param4);
         graphics.drawRect(param1,param2,1,param3);
         graphics.endFill();
      }
      
      public function drawRect(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:Number = 1, param7:int = 1) : void
      {
         graphics.lineStyle(param7,param5,param6);
         graphics.drawRect(param1,param2,param3,param4);
      }
      
      public function doAction336(param1:Bitmap, param2:int, param3:int, param4:int, param5:int, param6:Number, param7:Number) : void
      {
         var matrix:Matrix = new Matrix(param6,0,0,param7,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function drawWithScale(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var horizontalScale:Number = param4 / param1.width;
         var verticalScale:Number = param5 / param1.height;
         var matrix:Matrix = new Matrix(horizontalScale,0,0,verticalScale,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function doAction850(param1:Bitmap, param2:Rectangle, param3:Rectangle, param4:Boolean = false) : void
      {
         var resultBitmap:BitmapData = new BitmapData(param2.width,param2.height,true,0);
         var sourceY:Array = [0,param3.top,param3.bottom,param1.height];
         var sourceX:Array = [0,param3.left,param3.right,param1.width];
         var targetY:Array = [0,param3.top,param2.height - (param1.height - param3.bottom),param2.height];
         var targetX:Array = [0,param3.left,param2.width - (param1.width - param3.right),param2.width];
         var sourceRect:Rectangle;
         var targetRect:Rectangle;
         var sliceMatrix:Matrix = new Matrix();
         var column:int = 0;
         while(column < 3)
         {
            row = 0;
            while(row < 3)
            {
               sourceRect = new Rectangle(sourceX[column],sourceY[row],sourceX[column + 1] - sourceX[column],sourceY[row + 1] - sourceY[row]);
               targetRect = new Rectangle(targetX[column],targetY[row],targetX[column + 1] - targetX[column],targetY[row + 1] - targetY[row]);
               sliceMatrix.identity();
               sliceMatrix.a = targetRect.width / sourceRect.width;
               sliceMatrix.d = targetRect.height / sourceRect.height;
               sliceMatrix.tx = targetRect.x - sourceRect.x * sliceMatrix.a;
               sliceMatrix.ty = targetRect.y - sourceRect.y * sliceMatrix.d;
               resultBitmap.draw(param1,sliceMatrix,null,null,targetRect,param4);
               row++;
            }
            column++;
         }
         var fillMatrix:Matrix = new Matrix(1,0,0,1,param2.x,param2.y);
         var row:int;
         graphics.beginBitmapFill(resultBitmap,fillMatrix);
         graphics.drawRect(param2.x,param2.y,param2.width,param2.height);
         graphics.endFill();
      }
      
      public function doAction433(param1:Bitmap, param2:int, param3:int, param4:Number, param5:Boolean = false) : void
      {
         var scaledWidth:int = param1.bitmapData.width * param4;
         var scaledHeight:int = param1.bitmapData.height * param4;
         var matrix:Matrix = new Matrix(param4,0,0,param4,param2,param3);
         graphics.beginBitmapFill(param1.bitmapData,matrix,true,param5);
         graphics.drawRect(param2,param3,scaledWidth,scaledHeight);
         graphics.endFill();
      }
      
      public function doAction344(param1:Bitmap, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false) : void
      {
         graphics.beginBitmapFill(param1.bitmapData,new Matrix(param4 ? -1 : 1,0,0,param5 ? -1 : 1,param2,param3));
         graphics.drawRect(param2,param3,param1.width,param1.height);
         graphics.endFill();
      }
      
      public function doAction754(param1:Bitmap, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false, param7:Boolean = false) : void
      {
         graphics.beginBitmapFill(param1.bitmapData,new Matrix(param6 ? -1 : 1,0,0,param7 ? -1 : 1,param2,param3));
         graphics.drawRect(param2,param3,param4,param5);
         graphics.endFill();
      }
      
      public function drawCircle(param1:int, param2:int, param3:int, param4:uint, param5:Number = 1, param6:int = 1) : void
      {
         graphics.lineStyle(param6,param4,param5);
         graphics.drawCircle(param1,param2,param3);
      }
      
      public function doAction363(param1:int, param2:int, param3:int, param4:uint, param5:Number = 1) : void
      {
         graphics.beginFill(param4,param5);
         graphics.drawCircle(param1,param2,param3);
         graphics.endFill();
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function set propValue161(param1:Object) : void
      {
         obj56 = param1;
      }
      
      public function get propValue161() : Object
      {
         return this.obj56;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      protected function includesMouse() : Boolean
      {
         if(this.handlesMouse && stage != null && hitTestPoint(stage.mouseX,stage.mouseY,true) && (this.bitmapData5 == null || this.isValue4))
         {
            return true;
         }
         return false;
      }
      
      protected var mouseDownCallback4:Function;

      public function onChildMouseDown(param1:Function) : void
      {
         mouseDownCallback4 = param1;
      }
      
      public function mouseDownHandler() : void
      {
         var index:int = 0;
         selected = true;
         if(this.array19.length > 0)
         {
            this.doAction261();
            index = 0;
            while(index < this.array19.length)
            {
               if(!this.array19[index].isPlaying)
               {
                  this.array19[index].play();
               }
               index++;
            }
         }
         if(this.mouseDownCallback4 != null)
         {
            this.mouseDownCallback4();
         }
      }
      
      private function doAction26(param1:Array) : void
      {
         var index:int = 0;
         while(index < param1.length)
         {
            if(!param1[index].isPlaying)
            {
               param1[index].play();
            }
            index++;
         }
      }
      
      private function doAction762(param1:Array) : void
      {
         var needsPlay:Boolean = false;
         var index:int = 0;
         while(index < param1.length)
         {
            if(!param1[index].isPlaying)
            {
               needsPlay = true;
            }
            index++;
         }
         if(needsPlay)
         {
            this.doAction154();
            index = 0;
            while(index < param1.length)
            {
               param1[index].play(this,true);
               index++;
            }
         }
         else
         {
            index = 0;
            while(index < this.array63.length)
            {
               param1[index].reverse();
               index++;
            }
         }
      }
      
      protected function doAction784(param1:Object, param2:String, param3:Function) : void
      {
         this.array115.push({
            "target":param1,
            "type":param2,
            "handler":param3
         });
         EventListeners.addEventListener(param1,param2,param3);
      }
      
      public function mouseUpHandler() : void
      {
         var unused:int = 0;
         selected = false;
         if(this.array36.length > 0)
         {
            this.doAction261();
            this.doAction26(this.array36);
         }
         else if(this.array19.length > 0)
         {
            this.doAction762(this.array19);
         }
      }
      
      public function get isChildOver() : Boolean
      {
         return this._isChildOver;
      }
      
      public function check27(param1:DisplayObject) : Boolean
      {
         var ancestor:DisplayObjectContainer = this.parent;
         while(ancestor != null)
         {
            if(ancestor == param1)
            {
               return true;
            }
            ancestor = ancestor.parent;
         }
         return false;
      }
      
      public function mouseOverHandler() : void
      {
         _isChildOver = true;
         if(this.array63.length > 0)
         {
            this.doAction261();
            this.doAction411();
            this.doAction26(this.array63);
         }
      }
      
      public function mouseOutHandler() : void
      {
         var unused:int = 0;
         _isChildOver = false;
         if(this.array1.length > 0)
         {
            this.doAction261();
            this.doAction26(this.array1);
         }
         else if(this.array63.length > 0)
         {
            this.doAction762(this.array63);
         }
      }
      
      public function mouseWheelHandler(param1:int) : void
      {
      }
      
      public function mouseMoveHandler() : void
      {
      }
      
      public function doAction688(param1:TweenEffect) : void
      {
         NUIController.sharedController.updateMousePos();
      }
      
      public function handleAddedToUITree() : void
      {
         addedToUITree = true;
         if(visible || !this.isUIVisible)
         {
            NUIController.sharedController.addItem(this,this.uiParent);
            flag119 = true;
         }
         if(this.array42.length > 0)
         {
            this.doAction261();
            this.doAction26(this.array42);
         }
      }
      
      public function get isValue61() : Boolean
      {
         return this.array22.length > 0;
      }
      
      public function handleRemovedFromUITree() : void
      {
         uiParent = null;
         addedToUITree = false;
         if(this.flag119)
         {
            NUIController.sharedController.removeItem(this);
            flag119 = false;
         }
         if(this.array22.length > 0)
         {
            this.doAction261();
            this.doAction26(this.array22);
         }
      }
      
      public function doAction953() : void
      {
         if(!this.isValue61)
         {
            childEnabled = true;
            if(this.disposeOnRemove)
            {
               this.dispose();
            }
         }
      }
      
      protected function doAction928() : void
      {
         var index:int = 0;
         if(this.array11 != null)
         {
            index = 0;
            while(index < this.array11.length)
            {
               this.array11[index].bitmapData.dispose();
               index++;
            }
         }
         array11 = null;
         if(this.array4 != null)
         {
            while(this.array4.length > 0)
            {
               this.doAction652(this.array4.pop());
            }
         }
         array4 = null;
      }
      
      public function dispose() : void
      {
         var index:int = 0;
         var eventListener:Object = null;
         var signalListener:Object = null;
         if(this.bitmapData5 != null)
         {
            this.bitmapData5.dispose();
            bitmapData5 = null;
         }
         this.doAction261();
         this.doAction857();
         this.doAction928();
         if(this.array53 != null)
         {
            index = 0;
            while(index < this.array53.length)
            {
               this.array53[index].dispose();
               index++;
            }
         }
         array53 = null;
         while(this.array115.length > 0)
         {
            eventListener = this.array115.pop();
            EventListeners.removeEventListener(eventListener.target,eventListener.type,eventListener.handler);
         }
         while(this.array105.length > 0)
         {
            signalListener = this.array105.pop();
            StateSystem.system.removeListener(signalListener.id,signalListener.handler);
         }
         graphics.clear();
      }
      
      public function set childVisible(param1:Boolean) : void
      {
         if(param1)
         {
            intValue91 = this.intValue91 & 1 | 2;
         }
         else
         {
            intValue91 &= 1;
         }
         isUIVisible = this.intValue91 == 3;
      }
      
      public function set childEnabled(param1:Boolean) : void
      {
         if(param1)
         {
            flag138 = this.flag138 & 1 | 2;
         }
         else
         {
            flag138 &= 1;
         }
         isEnabled = this.flag138 == 3;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            flag138 = 3;
         }
         else
         {
            flag138 = 0;
         }
         childEnabled = param1;
         isEnabled = this.flag138 == 3;
      }
      
      public function get isValue43() : Boolean
      {
         return (this.flag138 & 1) == 1;
      }
      
      public function get enabled() : Boolean
      {
         return this.isEnabled;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1)
         {
            intValue91 |= 1;
         }
         else
         {
            intValue91 &= 2;
         }
         isUIVisible = this.intValue91 == 3;
         super.visible = param1;
      }
      
      public function getBmp(param1:String) : Bitmap
      {
         var bitmap:Bitmap = null;
         if(uiPackId >= 0)
         {
            bitmap = ResourceManager.sharedInstance.getBmp(uiPackId,param1);
         }
         else
         {
            bitmap = ResourceManager.sharedInstance.getBitmap2(param1);
         }
         if(this.array11 == null)
         {
            array11 = new Array();
         }
         this.array11.push(bitmap);
         return bitmap;
      }
      
      public function getBitmap3(param1:BitmapData, param2:int = 0) : Bitmap
      {
         var matrix:Matrix = new Matrix();
         if(param2 == UIELEMENT_CONST1)
         {
            matrix.scale(-1,1);
            matrix.translate(param1.width,0);
         }
         else
         {
            matrix.scale(1,-1);
            matrix.translate(0,param1.height);
         }
         var bitmapData:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         bitmapData.draw(param1,matrix);
         var bitmap:Bitmap = new Bitmap(bitmapData);
         this.array11.push(bitmap);
         return bitmap;
      }
      
      public function getPackBitmap1(param1:String, param2:Object = null) : Bitmap
      {
         Assert.isTrue(uiPackId != -1);
         var packBitmap:Bitmap = ResourceManager.sharedInstance.getPackBitmap1(uiPackId,param1,param2);
         if(this.array4 == null)
         {
            array4 = new Array();
         }
         this.array4.push(packBitmap);
         return new Bitmap(packBitmap.bitmapData);
      }
      
      public function doAction652(param1:PackBitmap) : void
      {
         ResourceManager.sharedInstance.doAction652(param1);
      }
      
      private function doAction411() : void
      {
         numValue9 = this.x;
         numValue44 = this.y;
         numValue28 = scaleX;
         numValue51 = scaleY;
         initWidth = width;
         initHeight = height;
         numValue56 = rotation;
      }
      
      private function doAction154() : void
      {
         x = this.numValue9;
         y = this.numValue44;
         scaleX = this.numValue28;
         scaleY = this.numValue51;
         width = this.initWidth;
         height = this.initHeight;
         rotation = this.numValue56;
      }
      
      public function doAction261() : void
      {
         var index:int = 0;
         while(index < this.array18.length)
         {
            this.array18[index].end();
            index++;
         }
      }
      
      public function doAction357() : void
      {
         var effects:Array = TweensyZero.getArray14(this);
         var effect:Object;
         for each(effect in effects)
         {
            effect.end();
         }
      }
      
      public function doAction644() : void
      {
         TweensyZero.doAction797(this);
      }
      
      private function doAction654(param1:Event) : void
      {
         this.doAction261();
      }
      
      public function doAction660(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array42.push(param1);
         this.array18.push(param1);
         param1.addEndListener(this.doAction688);
      }
      
      public function doAction107(param1:TweenEffect) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         childEnabled = true;
         if(this.disposeOnRemove)
         {
            this.dispose();
         }
      }
      
      public function doAction502(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array18.push(param1);
         this.array22.push(param1);
         param1.addEndListener(this.doAction107);
      }
      
      public function doAction570(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array19.push(param1);
         this.array18.push(param1);
      }
      
      public function doAction276(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array36.push(param1);
         this.array18.push(param1);
      }
      
      public function doAction906(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array63.push(param1);
         this.array18.push(param1);
      }
      
      public function doAction412(param1:TweenEffect) : void
      {
         param1.instance = this;
         this.array1.push(param1);
         this.array18.push(param1);
      }
      
      protected function doAction141() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function get isValue32() : Boolean
      {
         var effect:Object = null;
         for each(effect in this.array42)
         {
            if(effect.isPlaying)
            {
               return false;
            }
         }
         return true;
      }
      
      public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null, param9:String = null, param10:Array = null, param11:Object = null) : void
      {
         var targetGraphics:Graphics = graphics;
         var diameter:Number;
         var alphas:Array;
         var gradientMatrix:Matrix;
         var innerRadius:Object;
         if(!param3 || !param4)
         {
            return;
         }
         if(param6 !== null)
         {
            if(param6 is Array)
            {
               if(param7 is Array)
               {
                  alphas = param7 as Array;
               }
               else
               {
                  alphas = [param7,param7];
               }
               if(!param10)
               {
                  param10 = [0,255];
               }
               gradientMatrix = null;
               if(param8)
               {
                  if(param8 is Matrix)
                  {
                     gradientMatrix = Matrix(param8);
                  }
                  else
                  {
                     gradientMatrix = new Matrix();
                     if(param8 is Number)
                     {
                        gradientMatrix.createGradientBox(param3,param4,Number(param8) * Math.PI / 180,param1,param2);
                     }
                     else
                     {
                        gradientMatrix.createGradientBox(param8.w,param8.h,param8.r,param8.x,param8.y);
                     }
                  }
               }
               if(param9 == GradientType.RADIAL)
               {
                  targetGraphics.beginGradientFill(GradientType.RADIAL,param6 as Array,alphas,param10,gradientMatrix);
               }
               else
               {
                  targetGraphics.beginGradientFill(GradientType.LINEAR,param6 as Array,alphas,param10,gradientMatrix);
               }
            }
            else
            {
               targetGraphics.beginFill(Number(param6),Number(param7));
            }
         }
         if(!param5)
         {
            targetGraphics.drawRect(param1,param2,param3,param4);
         }
         else if(param5 is Number)
         {
            diameter = Number(param5) * 2;
            targetGraphics.drawRoundRect(param1,param2,param3,param4,diameter,diameter);
         }
         else
         {
            GraphicsUtil.drawRoundRectComplex(targetGraphics,param1,param2,param3,param4,param5.tl,param5.tr,param5.bl,param5.br);
         }
         if(param11)
         {
            innerRadius = param11.r;
            if(innerRadius is Number)
            {
               diameter = Number(innerRadius) * 2;
               targetGraphics.drawRoundRect(param11.x,param11.y,param11.w,param11.h,diameter,diameter);
            }
            else
            {
               GraphicsUtil.drawRoundRectComplex(targetGraphics,param11.x,param11.y,param11.w,param11.h,innerRadius.tl,innerRadius.tr,innerRadius.bl,innerRadius.br);
            }
         }
         if(param6 !== null)
         {
            targetGraphics.endFill();
         }
      }
      
      public function doAction954() : void
      {
         if(this.uiParent && !this.uiParent.includeMouse())
         {
            this.uiParent.doAction954();
         }
      }
      
      public function get hasSoundCoords() : Boolean
      {
         return false;
      }
      
      public function get soundRepeatId() : String
      {
         return "ui_" + this._uiElementUid;
      }
   }
}

