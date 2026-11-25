package
{
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import ui.GameUIController;
   
   [SWF(width="500", height="375", backgroundColor="#000000", frameRate="60")]
   public class unit extends Sprite
   {
      
      public function unit()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.stageFocusRect = false;
         var mainClient:Main = new Main();
         var uiController:GameUIController = new GameUIController(mainClient);
         addChild(uiController);
         addChild(mainClient);
         mainClient.init();
         try
         {
            ExternalInterface.addCallback("resize",mainClient.doAction841);
            mainClient.flag60 = true;
         }
         catch(e:*)
         {
         }
         uiController.doAction157();
         mainClient.doAction157();
      }
   }
}

