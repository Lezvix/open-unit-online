package ui
{
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TipsMenu extends NuclearMenu
   {
      
      private var bgBmp:Bitmap;
      
      public function TipsMenu(tip:String)
      {
         super();
         this.bgBmp = getBmp("RESPAWN_COUNTER_TIPS");
         addChild(this.bgBmp);
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = 13408563;
         format.size = 12;
         var textField:TextField = createTextField(45,52,426,format,tip,128);
         textField.multiline = true;
         textField.wordWrap = true;
         addChild(textField);
      }
      
      public function createTipsMenu() : void
      {
         create(this.bgBmp.width,this.bgBmp.height,true,0,0);
      }
   }
}

