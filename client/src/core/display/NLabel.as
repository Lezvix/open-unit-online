package core.display
{
   import core.ui.TextStyle;
   import core.ui.IPositionable;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class NLabel extends TextField implements IPositionable
   {
      
      private const str41:String = "left";
      
      private var maxWidth:int;
      
      private var maxHeight:int;
      
      private var labelMaxLines:int;
      
      private var sourceHtmlText:String;
      
      private var textFormat:TextFormat;
      
      public function NLabel(param1:TextStyle, param2:Boolean = false, param3:String = "left", param4:int = -1, param5:int = -1, param6:int = -1)
      {
         super();
         this.doAction694(param1,param3);
         this.maxWidth = param4;
         this.maxHeight = param5;
         this.labelMaxLines = param6;
         if(param2)
         {
            wordWrap = true;
            this.multiline = true;
         }
         defaultTextFormat = this.textFormat;
      }
      
      public static function getTextFormat1(source:TextFormat) : TextFormat
      {
         var copy:TextFormat = new TextFormat();
         copy.color = source.color;
         copy.font = source.font;
         copy.size = source.size;
         copy.align = source.align;
         copy.bold = source.bold;
         copy.italic = source.italic;
         copy.leading = source.leading;
         return copy;
      }
      
      override public function set y(source:Number) : void
      {
         super.y = source - int(int(defaultTextFormat.size) * 0.3);
      }
      
      override public function get y() : Number
      {
         return super.y + int(int(defaultTextFormat.size) * 0.3);
      }
      
      override public function set text(source:String) : void
      {
         super.text = source.replace(/\<br\/\>/g,"\n");
         this.doAction931();
      }
      
      override public function set htmlText(source:String) : void
      {
         sourceHtmlText = source;
         super.htmlText = this.sourceHtmlText;
         this.doAction931();
         super.htmlText = this.sourceHtmlText;
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2 + int(int(defaultTextFormat.size) * 0.5);
      }
      
      public function doAction16() : void
      {
         this.height = textHeight + int(int(defaultTextFormat.size) * 0.5);
      }
      
      public function doAction940(param1:TextStyle, param2:String = "left") : void
      {
         this.doAction694(param1,param2);
         defaultTextFormat = this.textFormat;
         setTextFormat(this.textFormat);
      }
      
      public function doAction398(param1:TextStyle) : void
      {
         this.doAction694(param1,this.textFormat.align);
         defaultTextFormat = this.textFormat;
         setTextFormat(this.textFormat);
      }
      
      private function doAction694(param1:TextStyle, param2:String) : void
      {
         embedFonts = param1.useEmbeddedFonts;
         textFormat = new TextFormat();
         this.textFormat.color = param1.color;
         this.textFormat.font = param1.fontName;
         this.textFormat.size = param1.size;
         this.textFormat.align = param2;
         this.textFormat.bold = param1.bold;
         this.textFormat.italic = param1.italic;
         this.textFormat.leading = param1.leading;
      }
      
      private function doAction931() : void
      {
         var reduceSize:Function = function():void
         {
            var format:TextFormat = defaultTextFormat;
            format.size = int(format.size) - 1;
            defaultTextFormat = format;
            setTextFormat(format);
         };
         if(this.maxWidth > 0)
         {
            while(textWidth > this.maxWidth)
            {
               reduceSize();
            }
         }
         if(this.maxHeight > 0)
         {
            while(textHeight > this.maxHeight)
            {
               reduceSize();
            }
         }
         if(this.labelMaxLines > 0)
         {
            while(numLines > this.labelMaxLines)
            {
               reduceSize();
            }
         }
      }
      
      public function set propValue11(param1:int) : void
      {
         maxWidth = param1;
         this.doAction931();
      }
      
      public function set propValue124(param1:int) : void
      {
         maxHeight = param1;
         this.doAction931();
      }
      
      public function set propValue26(param1:int) : void
      {
         labelMaxLines = param1;
      }
   }
}

