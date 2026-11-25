package ui
{
   import game.npc.PlayerItem;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class PlayerPreview extends Sprite
   {
      
      private var _previewPlayer:PlayerItem;
      
      private var glowTimer:Timer = new Timer(50);
      
      public function PlayerPreview(param1:int)
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this._previewPlayer = PlayerItem.create(param1);
         addChild(this._previewPlayer);
         this.glowTimer.addEventListener(TimerEvent.TIMER,this.onGlowTimerTimer);
         this.glowTimer.start();
         this._previewPlayer.play();
      }
      
      private function onGlowTimerTimer(param1:TimerEvent) : void
      {
         this._previewPlayer.animate();
      }
      
      public function dispose() : void
      {
         this.glowTimer.removeEventListener(TimerEvent.TIMER,this.onGlowTimerTimer);
         this.glowTimer.stop();
         removeChild(this._previewPlayer);
         this._previewPlayer.dispose();
         _previewPlayer = null;
      }
      
      public function get previewPlayer() : PlayerItem
      {
         return this._previewPlayer;
      }
   }
}

