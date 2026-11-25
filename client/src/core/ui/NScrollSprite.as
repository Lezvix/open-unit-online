package core.ui
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NScrollSprite extends UIComponent
   {
      
      public var uiContainer:UIComponent;
      
      public var maskShape:Sprite;
      
      public var scroll:NScrollBar;
      
      public var scrollFactorVal:int;
      
      public var maxScroll:int;
      
      public var scrollV:int;
      
      public var onScroll:Function = null;
      
      protected var initWidth:int;
      
      protected var initHeight:int;
      
      public function NScrollSprite(param1:int, param2:int, param3:int = 4)
      {
         super();
         this.initWidth = param1;
         this.initHeight = param2;
         this.uiContainer = new UIComponent();
         this.maskShape = new Sprite();
         this.maskShape.x = 0;
         this.maskShape.y = 0;
         this.maskShape.graphics.clear();
         this.maskShape.graphics.beginFill(0,0);
         this.maskShape.graphics.drawRect(0,0,param1,param2);
         this.maskShape.width = param1;
         this.maskShape.height = param2;
         this.uiContainer.graphics.clear();
         this.uiContainer.graphics.beginFill(0,0);
         this.uiContainer.graphics.drawRect(0,0,param1,param2);
         this.uiContainer.graphics.endFill();
         this.uiContainer.propValue176 = this.maskShape;
         this.doAction209();
         this.scrollV = 0;
         this.maxScroll = 0;
         addUIChild(this.uiContainer);
         addChild(this.maskShape);
         this.width = param1;
         this.height = param2;
         this.scrollFactor = param3;
         addUIChild(this.scroll);
      }
      
      protected function createScroll(param1:int) : NScrollBar
      {
         return null;
      }
      
      public function clearSprite() : void
      {
         disposeAllChilds();
         this.uiContainer.graphics.clear();
         this.uiContainer.graphics.beginFill(0,0);
         this.uiContainer.graphics.drawRect(0,0,this.initWidth,this.initHeight);
         this.uiContainer.graphics.endFill();
      }
      
      public function get scrollFactor() : int
      {
         return this.scrollFactorVal;
      }
      
      public function set scrollFactor(param1:int) : void
      {
         scrollFactorVal = param1;
         this.scroll.scrollFactor = this.scrollFactorVal;
      }
      
      public function init(param1:int = -1, param2:int = 0, param3:Boolean = true) : void
      {
         if(param1 == -1)
         {
            maxScroll = Math.max(this.uiContainer.height - this.maskShape.height,0);
         }
         else
         {
            maxScroll = Math.max(param1 - this.maskShape.height,0);
         }
         if(param2 > this.maxScroll)
         {
            param2 = this.maxScroll;
         }
         scrollV = param2;
         this.uiContainer.y = -this.scrollV;
         this.scroll.setScrollProperties(this.maskShape.height,0,this.maxScroll);
         this.scroll.scrollPosition = param2;
         if(param3)
         {
            this.uiContainer.graphics.beginFill(0,0);
            this.uiContainer.graphics.drawRect(0,0,this.uiContainer.width,this.uiContainer.height);
            this.uiContainer.graphics.endFill();
         }
      }
      
      override protected function includesMouse() : Boolean
      {
         if(mouseX < this.maskShape.width && mouseX >= 0 && mouseY < this.maskShape.height && mouseY >= 0)
         {
            return true;
         }
         return false;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         param1 *= this.scrollFactor;
         if(param1 > 0 && this.scrollV > 0)
         {
            param1 = Math.min(this.scrollV,param1);
            scrollV -= param1;
            this.uiContainer.y += param1;
            this.scroll.scrollPosition -= param1;
         }
         if(param1 < 0 && this.scrollV < this.maxScroll)
         {
            param1 = Math.max(this.scrollV - this.maxScroll,param1);
            scrollV -= param1;
            this.uiContainer.y += param1;
            this.scroll.scrollPosition -= param1;
         }
         if(this.onScroll != null)
         {
            this.onScroll();
         }
      }
      
      protected function handleScroll() : void
      {
         scrollV = this.scroll.scrollPosition;
         this.uiContainer.y = -this.scroll.scrollPosition;
         if(this.onScroll != null)
         {
            this.onScroll();
         }
      }
      
      public function addContent(param1:UIElement) : void
      {
         this.uiContainer.addUIChild(param1);
         this.uiContainer.height = Math.max(height,param1.height);
         this.init();
      }
      
      public function addLine(param1:DisplayObject) : void
      {
         this.uiContainer.addChild(param1);
         this.uiContainer.height = Math.max(height,param1.height);
         this.init();
      }
      
      protected function doAction209() : void
      {
         scroll = this.createScroll(this.initHeight);
         this.scroll.scrollChangeHandler = this.handleScroll;
         this.scroll.x = this.initWidth - 7;
         this.scroll.y = 0;
      }
   }
}

