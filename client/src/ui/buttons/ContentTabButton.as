package ui.buttons
{
   import flash.display.DisplayObject;
   import ui.NUIComponent;
   
   public class ContentTabButton extends TabButton
   {
      
      public var tabContent:NUIComponent = new NUIComponent();
      
      private var _active:Boolean = false;
      
      public function ContentTabButton(param1:String, param2:Number, param3:Function)
      {
         super(param1,param3,param2,true);
         this.tabContent.disposeOnRemove = false;
      }
      
      public function get Selected() : Boolean
      {
         return this._active;
      }
      
      public function set Selected(param1:Boolean) : void
      {
         if(this._active != param1)
         {
            setCurrentDO(param1 ? displayObject3 : upStateDO);
            _active = param1;
         }
      }
      
      override public function dispose() : void
      {
         this.tabContent.disposeOnRemove = true;
         super.dispose();
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.Selected)
         {
            setCurrentDO(displayObject3);
         }
         else
         {
            super.mouseUpHandler();
         }
      }
      
      override public function mouseOverHandler() : void
      {
         if(!this.Selected)
         {
            super.mouseOverHandler();
         }
      }
      
      override public function mouseOutHandler() : void
      {
         if(!this.Selected)
         {
            super.mouseOutHandler();
         }
      }
      
      override public function mouseDownHandler() : void
      {
         if(!this.Selected && mouseDownCallback3 != null)
         {
            mouseDownCallback3(this);
         }
         super.mouseDownHandler();
      }
   }
}

