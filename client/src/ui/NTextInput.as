package ui
{
   import core.system.EventListeners;
   import core.ui.ChatTextField;
   import flash.events.KeyboardEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   
   public class NTextInput extends ChatTextField
   {
      
      public var onKeyDown:Function = null;
      
      public var allHandler:Function = null;
      
      public var enterHandler:Function = null;
      
      protected var _textInputBorder:Boolean = true;
      
      protected var _textInputBorderColor:uint = 3156252;
      
      protected var _textInputBackground:Boolean = true;
      
      protected var _textInputBackgroundColor:uint = 2172187;
      
      protected var str25:String = "";
      
      protected var flag48:Boolean = true;
      
      protected var flag136:Boolean = false;
      
      public function NTextInput(param1:int, param2:NTextFormat)
      {
         super(param1,param2.getTextStyle2(),param2.align);
         this.restrict = "";
         textField.setPos(4,5);
         this.height = 20;
      }
      
      override public function get text() : String
      {
         return this.flag48 ? super.text : "";
      }
      
      override public function set text(param1:String) : void
      {
         if(!this.flag48)
         {
            this.doAction854();
         }
         super.text = param1;
      }
      
      override public function get cursorId() : int
      {
         return textField.selectable ? GameCursor.CURSOR_3 : GameCursor.CURSOR_DEFAULT;
      }
      
      public function showPlaceholder(param1:String) : void
      {
         flag48 = false;
         textField.transform.colorTransform = new ColorTransform(0.6,0.6,0.6);
         textField.text = param1;
         if(this.flag136)
         {
            textField.displayAsPassword = false;
         }
         onClick = this.doAction374;
      }
      
      protected function doAction374(param1:NTextInput) : void
      {
         if(!this.flag48)
         {
            this.doAction854();
         }
      }
      
      public function doAction854() : void
      {
         textField.text = "";
         flag48 = true;
         textField.transform.colorTransform = new ColorTransform();
         if(this.flag136)
         {
            displayAsPassword = true;
         }
      }
      
      protected function doAction730() : void
      {
         graphics.clear();
         if(this.border)
         {
            graphics.lineStyle(1,this.borderColor);
         }
         if(this.background)
         {
            graphics.beginFill(this.backgroundColor);
         }
         if(this.border || this.background)
         {
            graphics.drawRect(0,0,width,height);
            graphics.endFill();
         }
      }
      
      public function set isValue25(param1:Boolean) : void
      {
         textField.type = param1 ? TextFieldType.DYNAMIC : TextFieldType.INPUT;
      }
      
      public function get isValue25() : Boolean
      {
         return textField.type == TextFieldType.DYNAMIC;
      }
      
      public function get restrict() : String
      {
         return textField.restrict;
      }
      
      public function set restrict(param1:String) : void
      {
         textField.restrict = param1 + "^#|";
      }
      
      public function doAction463() : void
      {
         restrict = "0123456789";
      }
      
      public function get maxChars() : int
      {
         return textField.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         textField.maxChars = param1;
      }
      
      public function get caretIndex() : int
      {
         return textField.caretIndex;
      }
      
      public function set caretIndex(param1:int) : void
      {
         textField.setSelection(param1,param1);
      }
      
      public function appendText(param1:String) : void
      {
         textField.appendText(param1);
      }
      
      override public function set width(param1:Number) : void
      {
         textField.width = param1 - textField.x;
         super.width = param1;
         this.doAction730();
      }
      
      override public function set height(param1:Number) : void
      {
         textField.height = param1 - 1;
         super.height = param1;
         this.doAction730();
      }
      
      public function get displayAsPassword() : Boolean
      {
         return textField.displayAsPassword;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         if(this.flag48)
         {
            textField.displayAsPassword = param1;
         }
         flag136 = param1;
      }
      
      public function get border() : Boolean
      {
         return this._textInputBorder;
      }
      
      public function set border(param1:Boolean) : void
      {
         _textInputBorder = param1;
         this.doAction730();
      }
      
      public function get borderColor() : uint
      {
         return this._textInputBorderColor;
      }
      
      public function get background() : Boolean
      {
         return this._textInputBackground;
      }
      
      public function set background(param1:Boolean) : void
      {
         _textInputBackground = param1;
         this.doAction730();
      }
      
      public function get backgroundColor() : uint
      {
         return this._textInputBackgroundColor;
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         _textInputBackgroundColor = param1;
         this.doAction730();
      }
      
      public function set borderColor(param1:uint) : void
      {
         _textInputBorderColor = param1;
         this.doAction730();
      }
      
      private function doAction771(param1:KeyboardEvent) : void
      {
         if(!this.flag48)
         {
            this.doAction854();
         }
         if(this.enterHandler != null && param1.keyCode == Keyboard.ENTER)
         {
            this.enterHandler(this);
         }
         if(this.onKeyDown != null)
         {
            this.onKeyDown(param1);
         }
      }
      
      private function doAction75(param1:KeyboardEvent) : void
      {
         if(this.allHandler != null)
         {
            this.allHandler(param1);
         }
      }
      
      override public function handleAddedToUITree() : void
      {
         EventListeners.addEventListener(textField,KeyboardEvent.KEY_DOWN,this.doAction771);
         EventListeners.addEventListener(textField,KeyboardEvent.KEY_UP,this.doAction75);
         super.handleAddedToUITree();
      }
      
      override public function handleRemovedFromUITree() : void
      {
         EventListeners.removeEventListener(textField,KeyboardEvent.KEY_DOWN,this.doAction771);
         EventListeners.removeEventListener(textField,KeyboardEvent.KEY_UP,this.doAction75);
         super.handleRemovedFromUITree();
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         textField.setSelection(param1,param2);
      }
      
      public function get wordWrap() : Boolean
      {
         return textField.wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         textField.wordWrap = param1;
      }
      
      public function get multiline() : Boolean
      {
         return textField.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         textField.multiline = param1;
      }
      
      override protected function onMouseDown() : void
      {
      }
      
      public function selectAll() : void
      {
         this.setSelection(0,this.text.length);
      }
      
      public function moveCaretToEnd() : void
      {
         this.setSelection(this.text.length,this.text.length);
      }
      
      public function focus() : void
      {
         if(stage != null)
         {
            stage.focus = textField;
         }
      }
   }
}

