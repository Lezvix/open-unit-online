package ui.menus
{
   import core.system.EventListeners;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import ui.NTextFormat;
   
   public class NotifyMenu extends NuclearSprite
   {
      
      protected var okCallback:Function;
      
      public function NotifyMenu(message:String, okHandler:Function = null, menuWidth:int = -1)
      {
         var textField:TextField;
         super(TYPE_NOTIFY);
         w = 300;
         h = 130;
         this.okCallback = okHandler;
         menuWidth = Math.max(menuWidth,w);
         textField = createText(25,24,message,NTextFormat.notification,menuWidth - 50);
         addChild(textField);
         while(textField.height > menuWidth - 100)
         {
            menuWidth *= 1.2;
            textField.width = menuWidth - 50;
            textField.height = textField.textHeight + 5;
         }
         this.width = menuWidth;
         h = Math.max(h,textField.y + textField.height + 50);
         addButton((menuWidth - 104) / 2,h - 45,"OK",this.okClickHandler);
         fillBg(4,4,menuWidth - 8,h - 8);
         drawFrame(0,0,menuWidth,h);
         height = h;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         EventListeners.addEventListener(this,KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      override public function dispose() : void
      {
         EventListeners.removeEventListener(this,KeyboardEvent.KEY_DOWN,this.onKeyDown);
         super.dispose();
      }
      
      private function onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE)
         {
            event.stopImmediatePropagation();
            this.okClickHandler(null);
         }
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.focus = this;
      }
      
      protected function okClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.okCallback != null)
         {
            this.okCallback(this);
         }
      }
   }
}

