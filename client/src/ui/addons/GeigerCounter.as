package ui.addons
{
   import flash.display.Bitmap;
   
   public class GeigerCounter extends Addon
   {
      
      public static const GEIGER_COUNTER_CONST1:int = 0;
      
      public static const GEIGER_COUNTER_CONST2:int = 1;
      
      public static const GEIGER_COUNTER_CONST3:int = 2;
      
      protected var greenLed:Bitmap;
      
      protected var redLed:Bitmap;
      
      public function GeigerCounter()
      {
         super(GEIGER_COUNTER);
         var body:Bitmap = getBmp("GEIGER_COUNTER");
         this.greenLed = getBmp("RADIATION_GREEN_LED");
         this.redLed = getBmp("RADIATION_RED_LED");
         addChild(this.greenLed);
         addChild(this.redLed);
         this.greenLed.visible = false;
         this.redLed.visible = false;
         this.greenLed.x = 31;
         this.greenLed.y = 71;
         this.redLed.x = 11;
         this.redLed.y = 71;
         draw(body);
         width = body.width + 2;
         height = body.height;
         processIntervalValue = 1000;
      }
      
      override public function update() : void
      {
         switch(value)
         {
            case GEIGER_COUNTER_CONST1:
               this.redLed.visible = false;
               this.greenLed.visible = true;
               break;
            case GEIGER_COUNTER_CONST2:
               this.redLed.visible = !this.redLed.visible;
               this.greenLed.visible = false;
               break;
            case GEIGER_COUNTER_CONST3:
               this.redLed.visible = true;
               this.greenLed.visible = false;
               break;
         }
      }
   }
}

