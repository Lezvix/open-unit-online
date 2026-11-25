package ui.menus
{
   import flash.text.TextField;
   import ui.NTextFormat;
   
   public class ConfirmMenu extends NuclearSprite
   {
      
      private var okCallback:Function;
      
      private var cancelCallback:Function;
      
      public function ConfirmMenu(message:String, okHandler:Function, cancelHandler:Function = null)
      {
         var textField:TextField;
         super(TYPE_CONFIRM);
         w = 300;
         h = 130;
         this.okCallback = okHandler;
         this.cancelCallback = cancelHandler;
         textField = createText(25,24,message,NTextFormat.notification,w - 50);
         addChild(textField);
         width = w;
         h = Math.max(h,textField.y + textField.height + 50);
         addButton(w / 2 - 106,h - 45,"OK",this.okClickHandler);
         addButton(w / 2 + 3,h - 45,_("IDS_CANCEL"),this.cancelClickHandler);
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         height = h;
      }
      
      protected function okClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.okCallback != null)
         {
            this.okCallback(this);
         }
      }
      
      protected function cancelClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.cancelCallback != null)
         {
            this.cancelCallback(this);
         }
      }
   }
}

