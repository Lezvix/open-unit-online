package core.ui
{
   import core.system.StateSystem;
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import core.system.Signal;
   import core.system.NativeEvents;
   import core.events.SceneMouseEvents;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.utils.clearInterval;
   
   public class BaseApplication extends SizedSprite
   {
      
      private static const DRAW_MODE_0:int = 0;
      
      private static const DRAW_MODE_2D:int = 1;
      
      private static const DRAW_MODE_3D_DIFFUSE:int = 2;
      
      private static const DRAW_MODE_3D_SPECULAR_GLOSS:int = 3;
      
      public static var hintSprite:Sprite;

      public static var app:BaseApplication;

      protected var _uiContainer:UIComponent;
      
      private var flag72:Boolean = false;
      
      private var intervalId:uint = 0;
      
      private var uintValue16:uint;
      
      protected var obj50:Object;
      
      protected var _fullscreen:Boolean = false;
      
      public var flag83:Boolean = false;
      
      private var flag117:Boolean = false;
      
      private var intValue63:int = 0;
      
      public function BaseApplication()
      {
         super();
         this.doAction548();
         mouseEnabled = false;
         mouseChildren = false;
         app = this;
         this.uintValue16 = TimerUtil.setInterval(doAction493,10000);
         EventListeners.addEventListener(this,Event.ADDED_TO_STAGE,this.addedToStage);
         StateSystem.addListener(NativeEvents.NL_SET_FULLSCREEN,this.doAction327);
      }
      
      public static function get fullscreen() : Boolean
      {
         return app.fullscreen;
      }
      
      public static function get uiContainer() : UIComponent
      {
         return app.uiContainer;
      }
      
      public static function get stageWidth() : int
      {
         return app.stageWidth;
      }
      
      public static function get stageHeight() : int
      {
         return app.stageHeight;
      }
      
      private static function doAction493() : void
      {
         try
         {
            new Error();
         }
         catch(e:*)
         {
         }
      }
      
      public static function showHint(param1:String) : void
      {
         hideHint();
         app.setHint(param1);
      }
      
      public static function moveHint() : void
      {
         if(hintSprite)
         {
            hintSprite.x = app.mouseX;
            hintSprite.y = app.mouseY - hintSprite.height;
         }
      }
      
      public static function hideHint() : void
      {
         if(hintSprite != null)
         {
            app.removeChild(hintSprite);
            hintSprite = null;
         }
      }
      
      protected function doAction548() : void
      {
         new StateSystem();
      }
      
      private function doAction327(param1:Signal, param2:Boolean) : void
      {
         fullscreen = param2;
      }
      
      public function get uiContainer() : UIComponent
      {
         return this._uiContainer;
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         StateSystem.dispatch(KeyboardEvent.KEY_DOWN,param1);
      }
      
      public function errorHandler() : void
      {
         flag83 = true;
      }
      
      public function get stageWidth() : int
      {
         return stage.stageWidth;
      }
      
      public function get stageHeight() : int
      {
         return stage.stageHeight;
      }
      
      protected function addedToStage(param1:Event) : void
      {
         NUIController.sharedController.setCursorBounds(this.stageWidth,this.stageHeight);
         EventListeners.removeEventListener(this,Event.ADDED_TO_STAGE,this.addedToStage);
         EventListeners.addEventListener(stage,FullScreenEvent.FULL_SCREEN,this.doAction280);
         EventListeners.addEventListener(stage,Event.RESIZE,this.doAction155);
         this.doAction820();
      }
      
      protected function doAction820() : void
      {
         if(!this.flag117)
         {
            EventListeners.addEventListener(stage,KeyboardEvent.KEY_DOWN,this.onKeyDown);
            flag117 = true;
         }
      }
      
      protected function doAction817() : void
      {
         if(this.flag117)
         {
            EventListeners.removeEventListener(stage,KeyboardEvent.KEY_DOWN,this.onKeyDown);
            flag117 = false;
         }
      }
      
      protected function resizeHandler() : void
      {
         StateSystem.dispatch(NativeEvents.RESIZE,this.stageWidth,this.stageHeight);
         NUIController.sharedController.setCursorBounds(this.stageWidth,this.stageHeight);
      }
      
      private function doAction155(param1:Event) : void
      {
         this.resizeHandler();
      }
      
      private function doAction280(param1:FullScreenEvent) : void
      {
         this.doAction318(param1.fullScreen);
         StateSystem.dispatch(NativeEvents.NL_FULLSCREEN,param1.fullScreen);
      }
      
      protected function doAction318(param1:Boolean) : void
      {
         _fullscreen = param1;
      }
      
      public function set fullscreen(param1:Boolean) : void
      {
         if(param1)
         {
            stage.displayState = StageDisplayState.FULL_SCREEN;
         }
         else
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
         _fullscreen = param1;
      }
      
      public function get fullscreen() : Boolean
      {
         return this._fullscreen;
      }
      
      public function setHint(param1:String) : void
      {
      }
      
      public function mouseDownHandler() : void
      {
         this.dispatch(SceneMouseEvents.MOUSE_DOWN);
      }
      
      public function mouseUpHandler() : void
      {
         this.dispatch(SceneMouseEvents.MOUSE_UP);
      }
      
      public function mainMoveHandler(param1:UIElement) : void
      {
         this.dispatch(SceneMouseEvents.UI_MOUSE_DOWN,param1);
      }
      
      public function mouseMoveHandler() : void
      {
         if(hintSprite)
         {
            moveHint();
         }
      }
      
      protected function set propValue131(param1:uint) : void
      {
         if(param1 > 0)
         {
            intervalId = TimerUtil.setInterval(this.doAction56,param1);
            flag72 = true;
         }
         else if(this.flag72)
         {
            clearInterval(this.intervalId);
            flag72 = false;
         }
      }
      
      public function get propValue88() : Object
      {
         return this.getObject5();
      }
      
      protected function getObject5() : Object
      {
         if(this.obj50 != null && this.obj50.application != null && this.obj50.application.parameters != null)
         {
            return this.obj50.application.parameters;
         }
         var parameters:Object = stage.loaderInfo.parameters;
         var count:int = 0;
         var key:String;
         for(key in parameters)
         {
            count++;
         }
         if(count == 0)
         {
            return this.getObject9();
         }
         return parameters;
      }
      
      protected function getObject9() : Object
      {
         return new Object();
      }
      
      protected function doAction56() : void
      {
      }
      
      protected function getObject4() : Object
      {
         return this.obj50;
      }
      
      public function dispose() : void
      {
         if(stage != null)
         {
            this.doAction817();
            EventListeners.removeEventListener(stage,FullScreenEvent.FULL_SCREEN,this.doAction280);
            EventListeners.removeEventListener(stage,Event.RESIZE,this.doAction155);
         }
      }
      
      protected function getState(param1:Class) : Object
      {
         return StateSystem.system.getState(param1);
      }
      
      protected function dispatch(param1:String, ... rest) : void
      {
         StateSystem.dispatch.apply(null,[param1].concat(rest));
      }
      
      protected function addListener(param1:String, param2:Function) : void
      {
         StateSystem.addListener(param1,param2);
      }
      
      protected function removeListener(param1:String, param2:Function) : void
      {
         StateSystem.removeListener(param1,param2);
      }
      
      protected function doAction174(param1:Signal, ... rest) : void
      {
         StateSystem.doAction174.apply(null,[param1].concat(rest));
      }
   }
}

