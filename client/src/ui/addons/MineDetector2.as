package ui.addons
{
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.utils.getTimer;
   
   public class MineDetector2 extends Addon
   {
      
      public static const SIGNAL_NONE:int = 0;
      
      public static const SIGNAL_WEAK:int = 1;
      
      public static const SIGNAL_STRONG:int = 2;
      
      protected static const LAMP_POSITIONS:Array = [{
         "x":64,
         "y":94
      },{
         "x":32,
         "y":81
      },{
         "x":97,
         "y":81
      },{
         "x":19,
         "y":48
      },{
         "x":110,
         "y":48
      },{
         "x":64,
         "y":2
      },{
         "x":32,
         "y":16
      },{
         "x":97,
         "y":16
      }];
      
      protected var ledBitmap:Bitmap;
      
      protected var needle:Shape;
      
      public function MineDetector2()
      {
         var body:Bitmap;
         super(MINE_DETECTOR_1);
         body = getBmp("MINED1_BODY");
         this.ledBitmap = getBmp("MINED1_LAMP_GLOW");
         this.ledBitmap.visible = false;
         addChild(this.ledBitmap);
         this.needle = new Shape();
         this.needle.graphics.lineStyle(1,16777215,0.3);
         this.needle.graphics.beginFill(0,0.5);
         this.needle.graphics.drawRect(0,-41,2,30);
         this.needle.graphics.endFill();
         this.needle.graphics.lineStyle();
         this.needle.graphics.beginFill(16224039,0.7);
         this.needle.graphics.drawRect(0,-41,2,16);
         this.needle.graphics.endFill();
         this.needle.graphics.beginFill(0,0);
         this.needle.graphics.drawRect(0,-11,2,11);
         this.needle.graphics.endFill();
         this.needle.x = 74;
         this.needle.y = 73;
         addChild(this.needle);
         draw(body);
         width = body.width;
         height = body.height;
         processIntervalValue = 40;
      }
      
      override public function update() : void
      {
         var direction:int = value >> 16;
         var signal:int = value & 0xFFFF;
         if(direction == 0 || signal == SIGNAL_NONE)
         {
            this.ledBitmap.visible = false;
         }
         else
         {
            this.ledBitmap.x = LAMP_POSITIONS[direction - 1].x;
            this.ledBitmap.y = LAMP_POSITIONS[direction - 1].y;
            blinkPhase = getTimer() % 1250;
            if(blinkPhase < 250)
            {
               this.ledBitmap.visible = false;
            }
            else
            {
               this.ledBitmap.visible = true;
               if(blinkPhase < 500)
               {
                  this.ledBitmap.alpha = 1;
               }
               else
               {
                  this.ledBitmap.alpha = (1250 - blinkPhase) / 750;
               }
            }
         }
         var targetAngle:int = 0;
         var blinkPhase:int;
         switch(signal)
         {
            case SIGNAL_NONE:
               targetAngle = -45;
               break;
            case SIGNAL_WEAK:
               targetAngle = 0;
               break;
            case SIGNAL_STRONG:
               targetAngle = 45;
               break;
         }
         if(targetAngle > this.needle.rotation)
         {
            this.needle.rotation = Math.min(this.needle.rotation + 3,targetAngle);
         }
         else if(targetAngle < this.needle.rotation)
         {
            this.needle.rotation = Math.max(this.needle.rotation - 3,targetAngle);
         }
      }
   }
}

