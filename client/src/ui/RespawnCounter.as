package ui
{
   import core.display.BmpTextField;
   import flash.display.Bitmap;
   import flash.utils.getTimer;
   
   public class RespawnCounter extends NuclearMenu
   {
      
      private var bgBmp:Bitmap;
      
      private var targetTime:int;
      
      private var updateInterval:int;
      
      protected var clockTextField:BmpTextField;
      
      private var timeStr:String;
      
      private var tipText:String;
      
      public function RespawnCounter(tenthsOfSecond:int)
      {
         super();
         this.tipText = this.tipText;
         this.targetTime = getTimer() + tenthsOfSecond * 100;
         this.bgBmp = getBmp("RESPAWN_COUNTER");
         addChild(this.bgBmp);
         this.clockTextField = new BmpTextField(85,25,getBmp("CLOCK_FONT")," 0123456789.:",3);
         this.clockTextField.x = 118;
         this.clockTextField.y = 93;
         addChild(this.clockTextField);
         processIntervalValue = 500;
         this.process();
      }
      
      override protected function process() : void
      {
         var secondsLeft:int = (this.targetTime - getTimer()) / 1000;
         if(secondsLeft < 0)
         {
            secondsLeft = 0;
         }
         if(secondsLeft / 60 < 10)
         {
            timeStr = "0" + int(secondsLeft / 60).toString();
         }
         else
         {
            timeStr = int(secondsLeft / 60).toString();
         }
         if(getTimer() % 1000 < 500)
         {
            timeStr += ":";
         }
         else
         {
            timeStr += ".";
         }
         if(int(secondsLeft % 60) < 10)
         {
            timeStr += "0" + int(secondsLeft % 60).toString();
         }
         else
         {
            timeStr += int(secondsLeft % 60).toString();
         }
         this.clockTextField.setText(this.timeStr);
      }
      
      public function createRespawnCounter() : void
      {
         create(this.bgBmp.width,this.bgBmp.height,true,0,0);
      }
   }
}

