package ui
{
   import core.ui.TextStyle;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class NTextFormat extends TextFormat
   {
      
      public static const login:NTextFormat = new NTextFormat({
         "size":12,
         "align":TextFormatAlign.CENTER
      });
      
      public static const titleFormat:NTextFormat = new NTextFormat({
         "color":13408825,
         "size":12,
         "bold":true,
         "align":TextFormatAlign.CENTER
      });
      
      public static const plain:NTextFormat = new NTextFormat();
      
      public static const notification:NTextFormat = new NTextFormat({
         "size":11,
         "align":TextFormatAlign.CENTER
      });
      
      public static const normal:NTextFormat = new NTextFormat({"color":13408825});
      
      public static const input:NTextFormat = new NTextFormat({"color":13408825});
      
      public function NTextFormat(param1:Object = null)
      {
         if(param1 == null)
         {
            param1 = {};
         }
         super("Verdana","size" in param1 ? param1.size : 10,"color" in param1 ? param1.color : 10187041,"bold" in param1 ? param1.bold : false,"italic" in param1 ? param1.italic : false,null,null,null,param1.align);
         if("letterSpacing" in param1)
         {
            letterSpacing = param1.letterSpacing;
         }
      }
      
      public function derive(param1:Object = null) : NTextFormat
      {
         if(param1 == null)
         {
            param1 = {};
         }
         return new NTextFormat({
            "size":("size" in param1 ? param1.size : size),
            "color":("color" in param1 ? param1.color : color),
            "bold":("bold" in param1 ? param1.bold : bold),
            "italic":("italic" in param1 ? param1.italic : italic),
            "align":("align" in param1 ? param1.align : align),
            "letterSpacing":("letterSpacing" in param1 ? param1.letterSpacing : letterSpacing)
         });
      }
      
      public function get strong() : NTextFormat
      {
         return this.derive({"bold":true});
      }
      
      public function setSize(param1:Number) : NTextFormat
      {
         return this.derive({"size":param1});
      }
      
      public function get propValue12() : NTextFormat
      {
         return this.derive({"bold":false});
      }
      
      public function get right() : NTextFormat
      {
         return this.derive({"align":TextFormatAlign.RIGHT});
      }
      
      public function get left() : NTextFormat
      {
         return this.derive({"align":TextFormatAlign.LEFT});
      }
      
      public function get center() : NTextFormat
      {
         return this.derive({"align":TextFormatAlign.CENTER});
      }
      
      public function getTextStyle2() : TextStyle
      {
         return new TextStyle(font,uint(size),uint(color),Boolean(bold),Boolean(italic));
      }
   }
}

