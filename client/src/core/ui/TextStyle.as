package core.ui
{
   public class TextStyle
   {
      
      public var fontName:String;
      
      public var useEmbeddedFonts:Boolean = false;
      
      public var size:uint;
      
      public var color:uint = 0;
      
      public var bold:Boolean = false;
      
      public var italic:Boolean = false;
      
      private var _leading:int;
      
      public function TextStyle(typeface:String = "", fontSize:uint = 12, fontColor:uint = 0, useBold:Boolean = false, useItalic:Boolean = false, embedFont:Boolean = false, lineLeading:int = 0)
      {
         super();
         this.fontName = typeface;
         this.size = fontSize;
         this.color = fontColor;
         this.bold = useBold;
         this.italic = useItalic;
         this.useEmbeddedFonts = embedFont;
         this.leading = lineLeading;
      }
      
      public function set leading(lineLeading:int) : void
      {
         _leading = lineLeading;
      }
      
      public function get leading() : int
      {
         return this._leading;
      }
   }
}

