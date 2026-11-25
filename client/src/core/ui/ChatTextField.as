package core.ui
{
   import core.system.EventListeners;
   import flash.events.KeyboardEvent;
   import flash.text.TextFieldType;
   
   public class ChatTextField extends NTextField
   {
      
      public static const CHAT_TEXT_FIELD_CONST2:uint = 0;
      
      public static const CHAT_TEXT_FIELD_CONST1:uint = 1;
      
      private const str41:String = "left";
      
      private var _chatTextType:uint = 0;
      
      public function ChatTextField(param1:int, param2:TextStyle, param3:String = "left")
      {
         super(param2,false,param3);
         textField.type = TextFieldType.INPUT;
         textField.maxChars = param1;
      }
      
      public function get text() : String
      {
         return textField.text;
      }
      
      public function set text(param1:String) : void
      {
         textField.text = param1;
      }
      
      public function get type() : uint
      {
         return this._chatTextType;
      }
      
      public function set type(param1:uint) : void
      {
         _chatTextType = param1;
         switch(param1)
         {
            case CHAT_TEXT_FIELD_CONST1:
               textField.restrict = "0123456789";
               break;
            default:
               textField.restrict = "";
               break;
         }
      }
      
      override public function handleAddedToUITree() : void
      {
         EventListeners.addEventListener(textField,KeyboardEvent.KEY_DOWN,this.doAction563);
         super.handleAddedToUITree();
      }
      
      override public function handleRemovedFromUITree() : void
      {
         EventListeners.removeEventListener(textField,KeyboardEvent.KEY_DOWN,this.doAction563);
         super.handleRemovedFromUITree();
      }
      
      private function doAction563(param1:KeyboardEvent) : void
      {
         if(!textField.multiline && param1.keyCode == KeyCodes.ENTER)
         {
            this.doAction963();
         }
         param1.stopPropagation();
      }
      
      protected function doAction963() : void
      {
      }
      
      override protected function onMouseDown() : void
      {
         if(BaseApplication.app.fullscreen)
         {
            BaseApplication.app.fullscreen = false;
         }
      }
   }
}

