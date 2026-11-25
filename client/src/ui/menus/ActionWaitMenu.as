package ui.menus
{
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import ui.ProgressBar;
   import ui.NTextFormat;
   
   public class ActionWaitMenu extends NuclearSprite
   {
      
      private var endtime:int;
      
      private var progress:ProgressBar;
      
      public function ActionWaitMenu(params:Object)
      {
         var textField:TextField = null;
         super(TYPE_ACTION_WAIT);
         w = 300;
         h = 130;
         textField = createText(25,24,_("IDS_ACTION_WAITING_" + params.action,params.username),NTextFormat.notification,w - 50);
         addChild(textField);
         width = w;
         this.progress = new ProgressBar(w - 60,params.seconds * 1000,params.seconds * 1000);
         this.progress.setPos(30,textField.y + textField.height + 10);
         addChild(this.progress);
         h = Math.max(h,this.progress.y + this.progress.height + 40);
         addButton(w / 2 - 53,h - 45,_("IDS_CANCEL"),this.cancelCallback);
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         height = h;
         this.endtime = getTimer() + params.seconds * 1000;
         processIntervalValue = 40;
      }
      
      override protected function process() : void
      {
         this.progress.current = this.endtime - getTimer();
         if(this.progress.current <= 0)
         {
            this.cancelCallback(null);
         }
      }
      
      protected function cancelCallback(sender:Object) : void
      {
         closeMenu();
         GameSocket.socket.sendActionLeave();
      }
   }
}

