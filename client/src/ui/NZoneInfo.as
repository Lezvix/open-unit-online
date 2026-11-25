package ui
{
   import core.loaders.Texts;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class NZoneInfo extends TextField
   {
      
      private static const STATUS_COLORS:Array = [16759654,16318721,6750068,16759654,6750068];
      
      private static const TEXT_FILTERS:Array = [new GlowFilter(0,0.5,1.1,1.1,8,BitmapFilterQuality.HIGH)];
      
      private static const SHOW_TIME:int = 9000;
      
      private static const FADE_TIME:int = 1000;
      
      private var hideTimer:Timer;
      
      private var fadeStart:int;
      
      public function NZoneInfo()
      {
         super();
         width = 300;
         selectable = false;
         multiline = true;
         wordWrap = true;
         filters = TEXT_FILTERS;
         this.hideTimer = new Timer(SHOW_TIME,1);
         this.hideTimer.addEventListener(TimerEvent.TIMER,this.onHideTimer);
      }
      
      public function update(zoneName:String, description:String, status:int, owner:String) : void
      {
         htmlText = "<p align=\"center\">" + "<font face=\"Verdana\" size=\"14\" color=\"#ffbb66\">" + "<font size=\"18\">" + zoneName + "</font>" + "<br>" + "<br>" + description + "<br>" + (owner ? Texts.getString41(owner) + "<br>" : "") + "<br><font color=\"#" + STATUS_COLORS[status].toString(16) + "\">" + Texts.getString17(status) + "</font>" + "</font>" + "</p>";
         this.stopFade();
         alpha = 1;
         height = textHeight + 4;
         visible = true;
         this.hideTimer.reset();
         this.hideTimer.start();
      }
      
      private function onHideTimer(event:TimerEvent) : void
      {
         this.startFade();
      }
      
      private function startFade() : void
      {
         fadeStart = getTimer();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function stopFade() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function hide() : void
      {
         this.stopFade();
         visible = false;
      }
      
      private function onEnterFrame(event:Event) : void
      {
         var elapsed:int = getTimer() - this.fadeStart;
         if(elapsed > FADE_TIME)
         {
            this.hide();
         }
         else
         {
            alpha = 1 - elapsed / FADE_TIME;
         }
      }
   }
}

