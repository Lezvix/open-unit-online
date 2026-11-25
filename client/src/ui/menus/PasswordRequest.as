package ui.menus
{
   import flash.events.Event;
   import ui.NCheckBox;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class PasswordRequest extends TitledMenu
   {
      
      private var okClickHandler:Function;
      
      private var cancelClickHandler:Function;
      
      private var showPasswordCheckBox:NCheckBox;
      
      private var passwordTextfield:NTextInput;
      
      private var _autoClose:Boolean = true;
      
      public function PasswordRequest(okHandler:Function, cancelHandler:Function = null)
      {
         super(TYPE_PASSWORD,_("IDS_EMPTY_PASS"),248,140,false);
         this.okClickHandler = okHandler;
         this.cancelClickHandler = cancelHandler;
         this.showPasswordCheckBox = new NCheckBox(this.showPasswordCheckboxClick);
         this.showPasswordCheckBox.x = 69;
         this.showPasswordCheckBox.y = 72;
         this.showPasswordCheckBox.checked = false;
         addUIChild(this.showPasswordCheckBox);
         addTextLabel(84,70,_("IDS_SHOW_PASS"),NTextFormat.plain,100);
         this.passwordTextfield = createTextInput(39,45,170);
         this.passwordTextfield.maxChars = 64;
         this.passwordTextfield.enterHandler = this.okClick;
         this.passwordTextfield.displayAsPassword = true;
         addUIChild(this.passwordTextfield);
         addButton(127,98,_("IDS_CANCEL"),this.cancelClick);
         addButton(18,98,"OK",this.okClick);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public function get autoClose() : Boolean
      {
         return this._autoClose;
      }
      
      public function set autoClose(value:Boolean) : void
      {
         _autoClose = value;
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.passwordTextfield.selectAll();
         this.passwordTextfield.focus();
      }
      
      private function showPasswordCheckboxClick(checkBox:NCheckBox) : void
      {
         this.passwordTextfield.displayAsPassword = checkBox.checked;
         checkBox.checked = !checkBox.checked;
         this.passwordTextfield.text = this.passwordTextfield.text;
      }
      
      private function okClick(sender:Object = null) : void
      {
         if(this.okClickHandler != null)
         {
            this.okClickHandler(this);
         }
         if(this.autoClose)
         {
            closeMenu();
         }
      }
      
      public function clear() : void
      {
         this.passwordTextfield.text = "";
         this.passwordTextfield.focus();
      }
      
      private function cancelClick(sender:Object) : void
      {
         if(this.cancelClickHandler != null)
         {
            this.cancelClickHandler(this);
         }
         if(this.autoClose)
         {
            closeMenu();
         }
      }
      
      public function get Password() : String
      {
         return this.passwordTextfield.text;
      }
   }
}

