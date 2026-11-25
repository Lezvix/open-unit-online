package ui
{
   import ui.buttons.NButton;
   import core.ui.BaseApplication;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class ProgressBar extends NButton
   {
      
      [Embed(source="/assets/ProgressBar_IMG_6.png")]
      
      private static const IMG_6:Class;
      
      private static const BAR_BITMAP:Bitmap = new IMG_6();
      
      private static const LOW_COLOR:ColorTransform = new ColorTransform(1,0.7,0.7,1,50);
      
      private static const NORMAL_COLOR:ColorTransform = new ColorTransform();
      
      protected var w:int;
      
      protected var currentValue:Number;
      
      protected var maxValue:Number;
      
      protected var warnValue:Number;
      
      protected var sprite:Sprite = new Sprite();
      
      protected var hintFunction:Function = null;
      
      public function ProgressBar(barWidth:int, value:Number, maxVal:Number, hint:* = null, clickHandler:Function = null, warnLevel:int = 0)
      {
         this.w = barWidth;
         this.currentValue = value;
         this.maxValue = maxVal;
         this.warnValue = warnLevel;
         this.sprite.graphics.drawRect(0,0,this.w,BAR_BITMAP.height);
         this.sprite.height = BAR_BITMAP.height;
         var background:Sprite = new Sprite();
         background.graphics.drawRect(0,0,this.w,BAR_BITMAP.height);
         background.width = this.w;
         background.addChild(this.sprite);
         if(hint is Function)
         {
            this.hintFunction = hint;
         }
         super(clickHandler,background,null,null,null,hint is String ? hint : "");
         if(clickHandler != null || hint)
         {
            intValue8 = intValue57 = GameCursor.CURSOR_1;
         }
         this.update();
      }
      
      protected function updateHint() : void
      {
         if(this.hintFunction != null)
         {
            hintText = this.hintFunction(this.currentValue,this.maxValue);
            if(isOver)
            {
               BaseApplication.showHint(hintText);
            }
         }
      }
      
      protected function update() : void
      {
         this.sprite.graphics.clear();
         if(this.currentValue > 0)
         {
            this.sprite.graphics.beginBitmapFill(BAR_BITMAP.bitmapData);
            this.sprite.graphics.drawRect(0,0,this.w * this.currentValue / this.maxValue,BAR_BITMAP.height);
            this.sprite.graphics.endFill();
            if(this.warnValue > 0)
            {
               this.sprite.transform.colorTransform = this.currentValue > this.warnValue ? NORMAL_COLOR : LOW_COLOR;
            }
         }
         this.updateHint();
      }
      
      public function updateValues(value:Number, maxVal:Number, warnLevel:Number = 0) : void
      {
         if(this.currentValue != value || this.maxValue != maxVal || this.warnValue != warnLevel)
         {
            maxValue = maxVal;
            currentValue = Math.min(value,maxVal);
            warnValue = warnLevel;
            this.update();
         }
      }
      
      public function get current() : Number
      {
         return this.currentValue;
      }
      
      public function set current(value:Number) : void
      {
         if(this.currentValue != value)
         {
            currentValue = Math.min(value,this.maxValue);
            this.update();
         }
      }
      
      public function get maxValueValue() : Number
      {
         return this.maxValue;
      }
      
      public function set maxValueValue(value:Number) : void
      {
         if(this.maxValue != value)
         {
            maxValue = value;
            currentValue = Math.min(this.currentValue,this.maxValue);
            this.update();
         }
      }
   }
}

