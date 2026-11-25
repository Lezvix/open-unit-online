package game.world
{
   import core.system.StateSystem;
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import core.system.Signal;
   import core.ui.BaseApplication;
   import core.ui.TransparentComponent;
   import core.ui.IPositionable;
   import core.ui.UIComponent;
   import core.ui.NUIController;
   import core.ui.Cursor;
   import game.actions.ObjectActions;
   import game.actions.WorldActions;
   import game.events.PlayerEvents;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   
   public class WorldView extends UIComponent implements IPositionable
   {
      
      public static const FOLLOW_50:int = 50;
      
      private static const FOLLOW_0:int = 0;
      
      private static const FOLLOW_POSITION:int = 1;
      
      private var intValue230:int = 500;
      
      private var intValue219:int = 0;
      
      private var intValue118:int = 0;
      
      private var intValue26:int = 0;
      
      private var intValue128:int = 0;
      
      private var intValue67:int = 0;
      
      private var intValue124:int = 0;
      
      public var world:WorldBase;
      
      private var sprite6:Sprite;
      
      private var sprite10:Sprite;
      
      private var uintValue22:uint;
      
      private var intervalId:int = -1;
      
      protected var flag91:Boolean = false;
      
      protected var flag108:Boolean = false;
      
      protected var numValue38:Number;
      
      protected var numValue2:Number;
      
      protected var numValue3:Number;
      
      protected var numValue18:Number;
      
      private var _highlightedComposition:Composition = null;
      
      protected var rect7:Rectangle = new Rectangle(0,0,0,0);
      
      protected var intValue221:int = -1;
      
      protected var uiComponent2:UIComponent;
      
      public var viewWidth:int;
      
      public var viewHeight:int;
      
      protected var str20:String = null;
      
      public var intValue88:int = 0;
      
      public var intValue125:int = -1;
      
      public var ijPoint4:IJPoint = null;
      
      public var intValue155:int = 0;
      
      protected var flag22:Boolean = false;
      
      protected var flag133:Boolean = false;
      
      public var ijPoint1:IJPoint = null;
      
      public var moveMarker1:MoveMarker;
      
      private var worldEntity3:WorldEntity;
      
      public function WorldView(param1:WorldBase, param2:uint)
      {
         super();
         this.world = param1;
         this.uintValue22 = param2;
         addChild(param1);
         this.uiComponent2 = new TransparentComponent();
         addUIChild(this.uiComponent2);
         this.moveMarker1 = this.getMoveMarker1();
         EventListeners.addEventListener(this,Event.ADDED_TO_STAGE,this.addedToStage);
         addListener(PlayerEvents.START_MOVE_COMPOSITION,this.doAction315);
         addListener(PlayerEvents.START_ROTATE_COMPOSITION,this.doAction636);
         addListener(PlayerEvents.CREATE_MOUSE_COMPOSITION_BY_DATA,this.doAction419);
         addListener(PlayerEvents.REMOVE_COMPOSITION,this.doAction19);
      }
      
      private function doAction389() : void
      {
         width = BaseApplication.stageHeight;
         height = BaseApplication.stageWidth;
      }
      
      public function get propValue5() : int
      {
         return this.intValue230;
      }
      
      public function set propValue5(param1:int) : void
      {
         intValue230 = param1;
      }
      
      protected function getMoveMarker1() : MoveMarker
      {
         return new MoveMarker(this);
      }
      
      public function get propValue127() : int
      {
         return this.uintValue22;
      }
      
      protected function addedToStage(param1:Event) : void
      {
         if(!this.flag133)
         {
            intervalId = TimerUtil.setInterval(this.doAction111,this.uintValue22);
            flag133 = true;
         }
      }
      
      private function doAction315(param1:Signal, param2:Composition) : void
      {
         this.doAction555(param2);
      }
      
      private function doAction636(param1:Signal, param2:Composition, param3:int) : void
      {
         this.getComposition6(param2,param3);
      }
      
      public function get propValue188() : UIComponent
      {
         return this.uiComponent2;
      }
      
      private function doAction419(param1:Signal, param2:Object, param3:Object) : void
      {
         this.doAction13(param2,param3);
      }
      
      protected function doAction13(param1:Object, param2:Object) : void
      {
         this.doAction634();
         param2.item = param1;
         highlightedComposition = this.world.getComposition9(param2,-10,-10);
         this.highlightedComposition.isValue41 = false;
         if(param2.type == ItemSources.STORAGE)
         {
            StateSystem.dispatch(ObjectActions.TRY_UNDUNMP_OBJECT,this.highlightedComposition);
         }
      }
      
      private function doAction19(param1:Signal, param2:Composition) : void
      {
         this.world.doAction173(param2);
      }
      
      public function get propValue73() : String
      {
         return this.str20;
      }
      
      public function set propValue73(param1:String) : void
      {
         str20 = param1;
      }
      
      public function doAction74() : void
      {
         str20 = null;
         intValue125 = -1;
      }
      
      public function get highlightedComposition() : Composition
      {
         return this._highlightedComposition;
      }
      
      public function doAction555(param1:Composition) : void
      {
         this.world.doAction40(param1);
         highlightedComposition = param1;
         ijPoint4 = new IJPoint(param1.i,param1.j);
         ijPoint1 = new IJPoint(param1.i,param1.j);
      }
      
      protected function getComposition6(param1:Composition, param2:int) : Composition
      {
         intValue155 = param1.rotate;
         this.world.doAction40(param1);
         param1 = this.world.getComposition4(param1,param2);
         highlightedComposition = param1;
         flag22 = true;
         ijPoint4 = new IJPoint(param1.i,param1.j);
         ijPoint1 = new IJPoint(param1.i,param1.j);
         return param1;
      }
      
      public function set highlightedComposition(param1:Composition) : void
      {
         flag22 = false;
         ijPoint4 = null;
         ijPoint1 = null;
         str20 = null;
         intValue125 = -1;
         _highlightedComposition = param1;
         WorldObject.highlightedComposition = param1;
      }
      
      override public function dispose() : void
      {
         if(this.intervalId >= 0)
         {
            clearInterval(this.intervalId);
         }
         if(this.world)
         {
            this.world.dispose();
         }
         super.dispose();
      }
      
      protected function doAction617() : void
      {
      }
      
      protected function doAction111() : void
      {
         var distance:Number;
         var duration:int = 0;
         var elapsed:int = 0;
         this.world.process(_isChildOver);
         this.world.sortView();
         switch(this.intValue219)
         {
            case FOLLOW_POSITION:
               distance = Math.sqrt((this.intValue26 - this.intValue67) * (this.intValue26 - this.intValue67) + (this.intValue128 - this.intValue124) * (this.intValue128 - this.intValue124));
               duration = this.getInt17(distance);
               elapsed = getTimer() - this.intValue118;
               if(elapsed >= duration)
               {
                  this.centerCameraDirectOn(this.intValue67,this.intValue124);
                  intValue219 = FOLLOW_0;
                  this.doAction617();
               }
               else
               {
                  this.centerCameraDirectOn(int(this.intValue26 + (this.intValue67 - this.intValue26) * elapsed / duration),int(this.intValue128 + (this.intValue124 - this.intValue128) * elapsed / duration));
               }
               this.uiComponent2.x = this.world.x;
               this.uiComponent2.y = this.world.y;
               this.world.doAction220();
               break;
         }
      }
      
      protected function getInt17(param1:Number) : int
      {
         return param1 * 1000 / this.intValue230;
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         viewWidth = param1;
         viewHeight = param2;
         this.world.doAction71(param1,param2);
         this.doAction269(this.world.x,this.world.y);
         this.uiComponent2.x = this.world.x;
         this.uiComponent2.y = this.world.y;
      }
      
      override public function get width() : Number
      {
         return this.world.viewWidth;
      }
      
      override public function get height() : Number
      {
         return this.world.viewHeight;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1,this.height);
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this.width,param1);
      }
      
      public function set propValue115(param1:Number) : void
      {
         this.world.scaleX = param1;
         this.world.scaleY = param1;
         this.moveMarker1.doAction417(param1,param1);
         this.doAction269(this.world.x,this.world.y);
         this.uiComponent2.scaleX = this.world.scaleX;
         this.uiComponent2.scaleY = this.world.scaleY;
         this.uiComponent2.x = this.world.x;
         this.uiComponent2.y = this.world.y;
         this.world.doAction220();
      }
      
      public function doAction269(param1:int, param2:int) : void
      {
         if(this.rect7.width * this.propValue115 < this.viewWidth)
         {
            this.world.x = int((this.viewWidth - this.rect7.width * this.propValue115) / 2 - this.rect7.x * this.propValue115);
         }
         else
         {
            this.world.x = int(Math.max((-this.rect7.x - this.rect7.width) * this.propValue115 + this.viewWidth,Math.min(-this.rect7.x * this.propValue115,param1)));
         }
         if(this.rect7.height * this.propValue115 < this.viewHeight)
         {
            this.world.y = int((this.viewHeight - this.rect7.height * this.propValue115) / 2 - this.rect7.y * this.propValue115);
         }
         else
         {
            this.world.y = int(Math.max((-this.rect7.y - this.rect7.height) * this.propValue115 + this.viewHeight,Math.min(-this.rect7.y * this.propValue115,param2)));
         }
         this.moveMarker1.moveTo(this.world.x,this.world.y);
      }
      
      public function get propValue115() : Number
      {
         return this.world.scaleX;
      }
      
      protected function doAction741() : void
      {
         this.doAction269(this.numValue3 + mouseX - this.numValue38,this.numValue18 + mouseY - this.numValue2);
         this.uiComponent2.x = this.world.x;
         this.uiComponent2.y = this.world.y;
         this.world.doAction220();
      }
      
      protected function get isValue48() : Boolean
      {
         return true;
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.isValue48)
         {
            intValue219 = FOLLOW_0;
            flag108 = false;
            flag91 = true;
            numValue38 = mouseX;
            numValue2 = mouseY;
            numValue3 = this.world.x;
            numValue18 = this.world.y;
         }
         super.mouseDownHandler();
      }
      
      protected function doAction482() : void
      {
         this.world.doAction779(this.highlightedComposition);
         this.doAction362();
         var composition:Composition = this.highlightedComposition;
         highlightedComposition = null;
         dispatch(PlayerEvents.WORLD_ADD_COMPOSITION,composition);
      }
      
      protected function doAction362() : void
      {
         var offset:IJPoint = null;
         if(this.ijPoint1 != null)
         {
            offset = new IJPoint(this.highlightedComposition.i - this.ijPoint1.i,this.highlightedComposition.j - this.ijPoint1.j);
            this.highlightedComposition.doAction451(offset);
            ijPoint1 = new IJPoint(this.highlightedComposition.i,this.highlightedComposition.j);
         }
      }
      
      override public function mouseUpHandler() : void
      {
         if(selected)
         {
            if(this.check39())
            {
               if(this.isValue3)
               {
                  this.doAction515();
               }
               else if(this.world.worldEntity2 != null)
               {
                  if(!this.world.flag142 || this.world.worldEntity2.unlocked)
                  {
                     this.doAction60();
                  }
               }
               else if(this.world.highlightCompositions != null && this.world.highlightCompositions.length)
               {
                  if(!this.world.highlightCompositions[0].blocked && (!this.world.flag142 || this.world.highlightCompositions[0].groupUnlocked))
                  {
                     this.doAction343();
                  }
               }
               else if(!this.world.flag142)
               {
                  this.doAction64();
               }
            }
            this.doAction939();
         }
         super.mouseUpHandler();
      }
      
      protected function check39() : Boolean
      {
         return _isChildOver && (!this.flag91 || !this.flag108);
      }
      
      public function get isValue3() : Boolean
      {
         return this.highlightedComposition != null;
      }
      
      protected function doAction515() : void
      {
         if(this.highlightedComposition)
         {
            if(this.world.check31(this.highlightedComposition))
            {
               this.doAction482();
            }
         }
      }
      
      public function doAction939() : void
      {
         if(this.flag91)
         {
            this.doAction741();
            flag91 = false;
            flag108 = false;
         }
      }
      
      protected function doAction343() : void
      {
         dispatch(PlayerEvents.COMPOSITION_CLICKED,this.world.highlightCompositions[0]);
      }
      
      protected function doAction60() : void
      {
         dispatch(PlayerEvents.PLAYER_CLICKED,this.world.worldEntity2);
      }
      
      protected function doAction64() : void
      {
         dispatch(WorldActions.WORLD_CONTAINER_CLICK,(mouseX - this.world.x) / this.world.scaleX,(mouseY - this.world.y) / this.world.scaleY);
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      public function doAction457(param1:Boolean) : void
      {
         this.doAction634();
         this.world.dispose();
         this.world.flag142 = param1;
      }
      
      public function doAction247() : void
      {
         var bounds:Rectangle = null;
         var offsetX:int = 0;
         var offsetY:int = 0;
         var cell:IJPoint = null;
         if(this.highlightedComposition != null)
         {
            bounds = this.highlightedComposition.propValue25;
            offsetX = (bounds.x + bounds.y) * WorldItem.cJHCellSize + (bounds.width + bounds.height) * (WorldItem.cJHCellSize / 2);
            offsetY = (bounds.y - bounds.x) * WorldItem.cIHHCellSize - (bounds.height - bounds.width) * (WorldItem.cIHHCellSize / 2);
            cell = WorldItem.getIJCoords((mouseX - this.world.x - offsetX + WorldItem.cJHCellSize) / this.world.scaleX,(mouseY - this.world.y + offsetY) / this.world.scaleY);
            if(this.highlightedComposition.i != cell.i || this.highlightedComposition.j != cell.j)
            {
               this.highlightedComposition.setPos(cell.i,cell.j);
               this.doAction362();
               this.world.doAction746(this.highlightedComposition);
            }
         }
      }
      
      override public function mouseMoveHandler() : void
      {
         this.doAction247();
         if(this.flag91 && !this.flag108 && (Math.abs(mouseX - this.numValue38) >= FOLLOW_50 || Math.abs(mouseY - this.numValue2) >= FOLLOW_50))
         {
            flag108 = true;
         }
         if(this.flag108)
         {
            this.doAction741();
         }
      }
      
      public function doAction634() : void
      {
         var composition:Composition = null;
         this.doAction891();
         if(this.highlightedComposition)
         {
            if(this.ijPoint4 != null)
            {
               composition = this.highlightedComposition;
               composition.setPos(this.ijPoint4.i,this.ijPoint4.j);
               this.doAction362();
               this.world.doAction779(composition);
               ijPoint4 = null;
               highlightedComposition = null;
            }
            else
            {
               this.world.doAction173(this.highlightedComposition);
            }
            highlightedComposition = null;
         }
      }
      
      protected function doAction91() : void
      {
         var offset:IJPoint = null;
         if(this.ijPoint1 != null)
         {
            offset = new IJPoint(this.propValue108.i - this.ijPoint1.i,this.propValue108.j - this.ijPoint1.j);
            this.doAction313(offset);
            ijPoint1 = new IJPoint(this.propValue108.i,this.propValue108.j);
         }
      }
      
      protected function doAction313(param1:IJPoint) : void
      {
      }
      
      public function doAction891() : void
      {
         var entity:WorldEntity = null;
         if(this.propValue108)
         {
            if(this.ijPoint4 != null)
            {
               entity = this.propValue108;
               entity.setPos(this.ijPoint4.i,this.ijPoint4.j);
               this.doAction91();
               this.world.doAction495(entity);
            }
            else
            {
               this.world.doAction871(this.propValue108);
            }
            ijPoint4 = null;
            propValue108 = null;
         }
      }
      
      public function get propValue108() : WorldEntity
      {
         return this.worldEntity3;
      }
      
      public function set propValue108(param1:WorldEntity) : void
      {
         worldEntity3 = param1;
      }
      
      public function doAction851(param1:int) : void
      {
         intValue221 = param1;
         NUIController.sharedController.updateCursor();
      }
      
      public function doAction70() : void
      {
         if(this.intValue221 != -1)
         {
            intValue221 = -1;
            NUIController.sharedController.updateCursor();
         }
      }
      
      public function doAction826(param1:int, param2:int) : void
      {
         this.world.x += param1;
         this.world.y += param2;
         this.uiComponent2.x = this.world.x;
         this.uiComponent2.y = this.world.y;
         this.world.doAction220();
      }
      
      public function centerCameraDirectOn(param1:int, param2:int) : void
      {
         this.doAction269(this.viewWidth / 2 - param1 * this.propValue115,this.viewHeight / 2 - param2 * this.propValue115);
         this.uiComponent2.x = this.world.x;
         this.uiComponent2.y = this.world.y;
         this.world.doAction220();
      }
      
      public function doAction328(param1:Object) : void
      {
      }
      
      override public function get cursorId() : int
      {
         var composition:Composition = null;
         if(this.highlightedComposition != null)
         {
            composition = this.highlightedComposition.managementComposition;
         }
         else if(this.world.highlightCompositions != null && this.world.highlightCompositions.length > 0)
         {
            composition = this.world.highlightCompositions[0].managementComposition;
         }
         if(composition)
         {
            return composition.cursorId;
         }
         return Cursor.CURSOR_DEFAULT;
      }
      
      private function set followMode(param1:int) : void
      {
         intValue219 = param1;
         intValue118 = getTimer();
      }
      
      public function doAction731(param1:int, param2:int) : void
      {
         followMode = FOLLOW_POSITION;
         intValue26 = (this.viewWidth / 2 - this.world.x) / this.propValue115;
         intValue128 = (this.viewHeight / 2 - this.world.y) / this.propValue115;
         intValue67 = param1;
         intValue124 = param2;
      }
      
      public function get isValue58() : Boolean
      {
         return this.intValue219 == FOLLOW_POSITION;
      }
      
      public function get propValue87() : NPoint
      {
         return new NPoint((this.viewWidth / 2 - this.world.x) / this.propValue115,(this.viewHeight / 2 - this.world.y) / this.propValue115);
      }
      
      public function getIJPoint1() : IJPoint
      {
         return WorldItem.getIJCoords(this.getInt41(),this.getInt19());
      }
      
      private function getInt41() : int
      {
         return (mouseX - this.world.x) / this.world.scaleX;
      }
      
      private function getInt19() : int
      {
         return (mouseY - this.world.y) / this.world.scaleY;
      }
   }
}

