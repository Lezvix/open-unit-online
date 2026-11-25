package core.display
{
   import core.ui.TextStyle;
   import core.ui.IPositionable;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class InkText extends Sprite implements IPositionable
   {
      
      private const str41:String = "left";
      
      private var textFields:Array = new Array();
      
      private var flag90:Boolean;
      
      public function InkText(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         var textField:TextField;
         super();
         this.flag90 = param4;
         var index:int = 0;
         while(index < 5)
         {
            textField = new TextField();
            textField.background = false;
            textField.border = false;
            textField.multiline = false;
            textField.selectable = false;
            textField.wordWrap = param3;
            if(param4)
            {
               textField.autoSize = TextFieldAutoSize.LEFT;
            }
            if(param1 != -1)
            {
               textField.width = param1;
            }
            if(param2 != -1)
            {
               textField.height = param2;
            }
            this.textFields[index] = textField;
            addChild(textField);
            index++;
         }
         this.textFields[0].x = -1;
         this.textFields[1].x = 1;
         this.textFields[2].y = -1;
         this.textFields[3].y = 1;
         if(param1 != -1)
         {
            this.width = param1;
         }
         if(param2 != -1)
         {
            this.height = param2;
         }
      }
      
      public function updateWidth() : void
      {
         var index:int = 0;
         while(index < 5)
         {
            this.textFields[index].width = Math.ceil(this.textFields[index].textWidth);
            index++;
         }
         width = this.textWidth;
      }
      
      public function set text(param1:String) : void
      {
         var index:int = 0;
         while(index < 5)
         {
            this.textFields[index].text = param1;
            index++;
         }
      }
      
      public function get text() : String
      {
         return this.textFields[0].text;
      }
      
      public function setTextFormat(param1:TextStyle, param2:uint, param3:String = "left") : void
      {
         var outlineFormat:TextFormat = new TextFormat();
         outlineFormat.color = param2;
         outlineFormat.font = param1.fontName;
         outlineFormat.size = param1.size;
         outlineFormat.align = param3;
         outlineFormat.bold = param1.bold;
         outlineFormat.italic = param1.italic;
         var textFormat:TextFormat = new TextFormat();
         textFormat.color = param1.color;
         textFormat.font = param1.fontName;
         textFormat.size = param1.size;
         textFormat.align = param3;
         textFormat.bold = param1.bold;
         textFormat.italic = param1.italic;
         var index:int = 0;
         while(index < 5)
         {
            this.textFields[index].embedFonts = param1.useEmbeddedFonts;
            if(index < 4)
            {
               this.textFields[index].defaultTextFormat = outlineFormat;
            }
            else
            {
               this.textFields[index].defaultTextFormat = textFormat;
            }
            index++;
         }
      }
      
      public function get textWidth() : int
      {
         return Math.ceil(this.textFields[0].textWidth + 2);
      }
      
      public function get textHeight() : int
      {
         return Math.ceil(this.textFields[0].textHeight + 2);
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
   }
}

