package com.junkbyte.console
{
   import flash.text.StyleSheet;
   
   public class ConsoleStyle
   {
      
      public var menuFont:String = "Arial";
      
      public var menuFontSize:int = 12;
      
      public var str10:String = "Verdana";
      
      public var traceFontSize:int = 11;
      
      public var backgroundColor:uint;
      
      public var numValue24:Number = 0.9;
      
      public var controlColor:uint = 10027008;
      
      public var controlSize:uint = 5;
      
      public var commandLineColor:uint = 1092096;
      
      public var highColor:uint = 16777215;
      
      public var uintValue6:uint = 12632256;
      
      public var uintValue2:uint = 12632256;
      
      public var uintValue23:uint = 16746496;
      
      public var uintValue14:uint = 14505216;
      
      public var uintValue29:uint = 16777215;
      
      public var uintValue7:uint = 39372;
      
      public var priority0:uint = 3831610;
      
      public var priority1:uint = 4495684;
      
      public var priority2:uint = 7846775;
      
      public var priority3:uint = 10539168;
      
      public var priority4:uint = 14085846;
      
      public var priority5:uint = 15329769;
      
      public var priority6:uint = 16768477;
      
      public var priority7:uint = 16755370;
      
      public var priority8:uint = 16742263;
      
      public var priority9:uint = 16720418;
      
      public var priority10:uint = 16720418;
      
      public var priorityC1:uint = 39372;
      
      public var priorityC2:uint = 16746496;
      
      public var topMenu:Boolean = true;
      
      public var showCommandLineScope:Boolean = true;
      
      public var maxChannelsInMenu:int = 7;
      
      public var intValue15:int = 3;
      
      public var intValue86:int = 10;
      
      public function ConsoleStyle()
      {
         super();
         this.css = new StyleSheet();
      }
      
      public function doAction224() : void
      {
         backgroundColor = 16777215;
         controlColor = 16724787;
         commandLineColor = 6736896;
         highColor = 0;
         uintValue6 = 3355443;
         uintValue2 = 4473924;
         uintValue23 = 13373696;
         uintValue14 = 8917248;
         uintValue29 = 0;
         uintValue7 = 26282;
         priority0 = 4497476;
         priority1 = 3379251;
         priority2 = 2258722;
         priority3 = 1135889;
         priority4 = 13056;
         priority5 = 0;
         priority6 = 6684672;
         priority7 = 10027008;
         priority8 = 12255232;
         priority9 = 14483456;
         priority10 = 14483456;
         priorityC1 = 39372;
         priorityC2 = 16737792;
      }
      
      public function doAction120() : void
      {
         traceFontSize = 13;
         menuFontSize = 14;
      }
      
      private var css:StyleSheet;

      public function updateStyleSheet() : void
      {
         this.css.setStyle("high",{
            "color":this.hesh(this.highColor),
            "fontFamily":this.menuFont,
            "fontSize":this.menuFontSize,
            "display":"inline"
         });
         this.css.setStyle("low",{
            "color":this.hesh(this.uintValue6),
            "fontFamily":this.menuFont,
            "fontSize":this.menuFontSize - 2,
            "display":"inline"
         });
         this.css.setStyle("menu",{
            "color":this.hesh(this.uintValue23),
            "display":"inline"
         });
         this.css.setStyle("menuHi",{
            "color":this.hesh(this.uintValue14),
            "display":"inline"
         });
         this.css.setStyle("chs",{
            "color":this.hesh(this.uintValue29),
            "fontSize":this.menuFontSize,
            "leading":"2",
            "display":"inline"
         });
         this.css.setStyle("ch",{
            "color":this.hesh(this.uintValue7),
            "display":"inline"
         });
         this.css.setStyle("tt",{
            "color":this.hesh(this.uintValue23),
            "fontFamily":this.menuFont,
            "fontSize":this.menuFontSize,
            "textAlign":"center"
         });
         this.css.setStyle("r",{
            "textAlign":"right",
            "display":"inline"
         });
         this.css.setStyle("p",{
            "fontFamily":this.str10,
            "fontSize":this.traceFontSize
         });
         this.css.setStyle("p0",{
            "color":this.hesh(this.priority0),
            "display":"inline"
         });
         this.css.setStyle("p1",{
            "color":this.hesh(this.priority1),
            "display":"inline"
         });
         this.css.setStyle("p2",{
            "color":this.hesh(this.priority2),
            "display":"inline"
         });
         this.css.setStyle("p3",{
            "color":this.hesh(this.priority3),
            "display":"inline"
         });
         this.css.setStyle("p4",{
            "color":this.hesh(this.priority4),
            "display":"inline"
         });
         this.css.setStyle("p5",{
            "color":this.hesh(this.priority5),
            "display":"inline"
         });
         this.css.setStyle("p6",{
            "color":this.hesh(this.priority6),
            "display":"inline"
         });
         this.css.setStyle("p7",{
            "color":this.hesh(this.priority7),
            "display":"inline"
         });
         this.css.setStyle("p8",{
            "color":this.hesh(this.priority8),
            "display":"inline"
         });
         this.css.setStyle("p9",{
            "color":this.hesh(this.priority9),
            "display":"inline"
         });
         this.css.setStyle("p10",{
            "color":this.hesh(this.priority10),
            "fontWeight":"bold",
            "display":"inline"
         });
         this.css.setStyle("p-1",{
            "color":this.hesh(this.priorityC1),
            "display":"inline"
         });
         this.css.setStyle("p-2",{
            "color":this.hesh(this.priorityC2),
            "display":"inline"
         });
         this.css.setStyle("logs",{
            "color":this.hesh(this.uintValue2),
            "display":"inline"
         });
      }
      
      public function get styleSheet() : StyleSheet
      {
         return this.css;
      }
      
      private function hesh(param1:Number) : String
      {
         return "#" + param1.toString(16);
      }
   }
}

