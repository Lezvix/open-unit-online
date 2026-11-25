package ui.buttons
{
   import core.resources.Localization;
   import core.ui.BaseButton;
   import core.ui.BaseApplication;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import game.Chat;
   import ui.GameCursor;
   
   public class NButton extends BaseButton
   {
      
      public function NButton(param1:Function, param2:DisplayObject = null, param3:DisplayObject = null, param4:DisplayObject = null, param5:Bitmap = null, param6:String = "")
      {
         super(param1,param2,param3,param4,param5,param6);
         intValue8 = GameCursor.CURSOR_1;
         intValue57 = GameCursor.CURSOR_1;
      }
      
      public static function formatString(param1:String, ... rest) : String
      {
         return Chat.prepareText(rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1));
      }
      
      public static function _(param1:String, ... rest) : String
      {
         return rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1);
      }
      
      override public function mouseOverHandler() : void
      {
         if(hintText)
         {
            BaseApplication.showHint(hintText);
         }
         super.mouseOverHandler();
      }
      
      override protected function includesMouse() : Boolean
      {
         if(stage != null)
         {
            if(staticWidth > 0 && staticHeight > 0)
            {
               return mouseX < staticWidth && mouseX >= 0 && mouseY < staticHeight && mouseY >= 0;
            }
            if(hitTestPoint(stage.mouseX,stage.mouseY))
            {
               return bitmap28 == null || (bitmap28.bitmapData.getPixel32(mouseX,mouseY) >> 24 & 0xFF) > 0;
            }
         }
         return false;
      }
      
      override public function mouseOutHandler() : void
      {
         BaseApplication.hideHint();
         super.mouseOutHandler();
      }
   }
}

