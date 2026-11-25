package ui.menus
{
   import flash.events.Event;
   import flash.text.TextField;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class InputMenu extends NuclearSprite
   {
      
      private var okClickHandler:Function;
      
      private var cancelClickHandler:Function;
      
      private var input:NTextInput;
      
      public function InputMenu(message:String, okHandler:Function, cancelHandler:Function = null)
      {
         var textField:TextField;
         super(TYPE_INPUT);
         w = 300;
         h = 130;
         this.okClickHandler = okHandler;
         this.cancelClickHandler = cancelHandler;
         textField = createText(25,24,message,NTextFormat.notification,w - 50);
         addChild(textField);
         width = w;
         h = Math.max(h,textField.y + textField.height + 50);
         addButton(w / 2 - 106,h - 45,"OK",this.okClick);
         addButton(w / 2 + 3,h - 45,_("IDS_CANCEL"),this.cancelClick);
         this.input = createTextInput((w - 180) / 2,h - 80,180);
         this.input.maxChars = 16;
         this.input.enterHandler = this.okClick;
         addUIChild(this.input);
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         height = h;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.input.selectAll();
         this.input.focus();
      }
      
      private function okClick(sender:Object = null) : void
      {
         if(this.okClickHandler != null)
         {
            this.okClickHandler(this);
         }
         closeMenu();
      }
      
      private function cancelClick(sender:Object) : void
      {
         if(this.cancelClickHandler != null)
         {
            this.cancelClickHandler(this);
         }
         closeMenu();
      }
      
      public function get inputText() : String
      {
         return this.input.text;
      }
   }
}

