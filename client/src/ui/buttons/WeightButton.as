package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import game.Client;
   import ui.NTextFormat;
   
   public class WeightButton extends NButton
   {
      
      protected var maxValue:Number = 1;
      
      protected var currentValue:Number = 0;
      
      protected var warnPercent:Number;
      
      protected var showPercent:Boolean;
      
      protected var tf:TextField = new TextField();
      
      public function WeightButton(weight:Number, maxWeight:Number, warnLevel:Number = 100, showIcon:Boolean = false)
      {
         var sprite:Sprite = new Sprite();
         var icon:Bitmap;
         sprite.addChild(getBmp("MASS_BG"));
         if(showIcon)
         {
            icon = getBmp("MASS_ICON");
            icon.x = 8;
            icon.y = 4;
            sprite.addChild(icon);
         }
         this.tf.defaultTextFormat = NTextFormat.normal.center.derive({"letterSpacing":-1});
         this.tf.x = showIcon ? 14 : 4;
         this.tf.width = 98 - (showIcon ? 14 : 4);
         this.tf.height = 17;
         sprite.addChild(this.tf);
         this.warnPercent = warnLevel;
         this.currentValue = weight;
         this.maxValue = maxWeight;
         this.showPercent = Client.settings.showMassInPercent;
         super(this.onClick,sprite);
         this.update();
      }
      
      protected function onClick(sender:Object) : void
      {
         showPercent = !this.showPercent;
         Client.settings.showMassInPercent = this.showPercent;
         Client.settings.save();
         this.update();
         mouseOverHandler();
      }
      
      protected function update() : void
      {
         var percent:Number = this.current * 100 / this.maxValueValue;
         this.tf.textColor = percent < this.warnPercent ? uint(NTextFormat.normal.color) : 16731648;
         var percentStr:String = Math.round(percent * 100) / 100 + "%";
         var weightStr:String = Math.round(this.current / 10) / 100 + " / " + Math.round(this.maxValueValue / 10) / 100;
         if(this.showPercent)
         {
            this.tf.text = percentStr;
            hintText = weightStr;
         }
         else
         {
            this.tf.text = weightStr;
            hintText = percentStr;
         }
      }
      
      public function get current() : Number
      {
         return this.currentValue;
      }
      
      public function set current(value:Number) : void
      {
         currentValue = value;
         this.update();
      }
      
      public function get maxValueValue() : Number
      {
         return this.maxValue;
      }
      
      public function set maxValueValue(value:Number) : void
      {
         maxValue = value;
         this.update();
      }
   }
}

