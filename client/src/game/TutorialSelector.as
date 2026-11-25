package game
{
   import core.display.NSprite;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   
   public class TutorialSelector extends NSprite
   {
      
      private static const TUTORIAL_SELECTOR_CONST1:uint = 4914962;
      
      private static const TUTORIAL_SELECTOR_CONST2:uint = 30;
      
      private static const array97:Array = [new GlowFilter(50944,0.3,8,8,5,BitmapFilterQuality.HIGH)];
      
      private var numValue39:Number;
      
      private var _height:Number;
      
      private var numValue15:Number;
      
      private var numValue41:Number;
      
      private var glowTimer:Timer;
      
      private var intValue80:int;
      
      private var numValue54:Number;
      
      public function TutorialSelector(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         setPos(param1,param2);
         this.numValue39 = this.numValue15 = param3;
         this._height = this.numValue41 = param4;
         this.intValue80 = param5;
         this.numValue54 = 2 * this.intValue80 / TUTORIAL_SELECTOR_CONST2;
         this.glowTimer = new Timer(TUTORIAL_SELECTOR_CONST2);
         this.glowTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.glowTimer.start();
         filters = array97;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         clear();
         if(this.numValue39 <= this.numValue15)
         {
            numValue39 = this.numValue15 + this.intValue80 * 2;
            _height = this.numValue41 + this.intValue80 * 2;
         }
         else
         {
            numValue39 -= this.numValue54;
            _height -= this.numValue54;
         }
         graphics.lineStyle(2,TUTORIAL_SELECTOR_CONST1);
         graphics.drawRoundRect(int((this.numValue15 - this.numValue39) / 2),int((this.numValue41 - this._height) / 2),int(this.numValue39),int(this._height),8,8);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.glowTimer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this.glowTimer.stop();
      }
   }
}

