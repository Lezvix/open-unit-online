package ui
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LevelsBar extends Sprite
   {
      
      private static const WIDTH:int = 16;
      
      private static const HEIGHT:int = 132;
      
      private static const colorOk:uint = 13408563;
      
      private static const colorAbnormal:uint = 16731648;
      
      private var paramValue:int = -1;
      
      private var paramValueCriticalPoint:int;
      
      private var paramMaxValue:int;
      
      private var paramValueTF:TextField;
      
      public function LevelsBar(label:String, value:int, criticalPoint:int, maxValue:int)
      {
         super();
         this.paramValueCriticalPoint = criticalPoint;
         this.paramMaxValue = maxValue;
         var format:TextFormat = new TextFormat("Verdana",8,colorOk);
         var labelField:TextField;
         format.align = TextFormatAlign.CENTER;
         this.paramValueTF = new TextField();
         this.paramValueTF.selectable = false;
         this.paramValueTF.defaultTextFormat = format;
         this.paramValueTF.width = WIDTH;
         this.paramValueTF.height = 16;
         this.paramValueTF.alpha = 0.4;
         addChild(this.paramValueTF);
         format = new TextFormat("Verdana",8,colorOk);
         format.align = TextFormatAlign.CENTER;
         labelField = new TextField();
         labelField.selectable = false;
         labelField.defaultTextFormat = format;
         labelField.width = WIDTH;
         labelField.text = label;
         labelField.height = 16;
         labelField.y = HEIGHT - 16;
         labelField.alpha = 0.4;
         addChild(labelField);
         width = WIDTH;
         height = HEIGHT;
         scaleX = 1;
         scaleY = 1;
         this.Value = value;
      }
      
      public function get Value() : int
      {
         return this.paramValue;
      }
      
      public function set Value(value:int) : void
      {
         var level:int = 0;
         if(this.paramValue != value)
         {
            paramValue = Math.max(0,Math.min(value,this.paramMaxValue));
            graphics.clear();
            graphics.lineStyle(1,colorOk,0.4);
            level = 0;
            while(level <= value && level < this.paramValueCriticalPoint)
            {
               graphics.moveTo(0,HEIGHT - 16 - level);
               graphics.lineTo(WIDTH,HEIGHT - 16 - level);
               level += 2;
            }
            if(value >= this.paramValueCriticalPoint)
            {
               graphics.lineStyle(1,colorAbnormal,0.4);
               while(level <= value)
               {
                  graphics.moveTo(0,HEIGHT - 16 - level);
                  graphics.lineTo(WIDTH,HEIGHT - 16 - level);
                  level += 2;
               }
            }
            this.paramValueTF.text = String(value);
            this.paramValueTF.y = HEIGHT - 28 - level;
            this.paramValueTF.textColor = (value >= this.paramValueCriticalPoint) ? colorAbnormal : colorOk;
         }
      }
   }
}

