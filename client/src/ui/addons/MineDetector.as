package ui.addons
{
   import flash.display.Bitmap;
   
   public class MineDetector extends Addon
   {
      
      public static const SIGNAL_NONE:int = 0;
      
      public static const SIGNAL_WEAK:int = 1;
      
      public static const SIGNAL_STRONG:int = 2;
      
      protected var bitmap35:Bitmap;
      
      protected var redLed:Bitmap;
      
      public function MineDetector()
      {
         super(MINE_DETECTOR_0);
         var body:Bitmap = getBmp("MINED0_BODY");
         this.bitmap35 = getBmp("MINED0_YELLOW");
         this.redLed = getBmp("MINED0_RED");
         addChild(this.bitmap35);
         addChild(this.redLed);
         this.bitmap35.visible = false;
         this.redLed.visible = false;
         this.bitmap35.x = 28;
         this.bitmap35.y = 56;
         this.redLed.x = 28;
         this.redLed.y = 92;
         draw(body);
         width = body.width;
         height = body.height;
      }
      
      override public function update() : void
      {
         switch(value)
         {
            case SIGNAL_NONE:
               this.redLed.visible = false;
               this.bitmap35.visible = false;
               break;
            case SIGNAL_WEAK:
               this.bitmap35.visible = true;
               this.redLed.visible = false;
               break;
            case SIGNAL_STRONG:
               this.bitmap35.visible = false;
               this.redLed.visible = true;
               break;
         }
      }
   }
}

