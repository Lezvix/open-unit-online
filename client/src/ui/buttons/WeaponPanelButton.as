package ui.buttons
{
   import flash.display.Bitmap;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import ui.NTextFormat;
   
   public class WeaponPanelButton extends NButton
   {
      
      public function WeaponPanelButton(label:String, clickHandler:Function)
      {
         var textField:TextField = new TextField();
         textField.height = 20;
         textField.width = 90;
         textField.defaultTextFormat = new NTextFormat({
            "size":11,
            "color":12883515,
            "bold":true,
            "align":TextFormatAlign.CENTER
         });
         textField.text = label.toLocaleUpperCase();
         var normalBmp:Bitmap = getBmp("WEAPON_PANEL_BUTTON");
         var overBmp:Bitmap = getBmp("WEAPON_PANEL_BUTTON_OVER");
         var pressedBmp:Bitmap = getBmp("WEAPON_PANEL_BUTTON_PRESSED");
         var matrix:Matrix;
         matrix = new Matrix(1,0,0,1,0,1);
         normalBmp.bitmapData.draw(textField,matrix);
         textField.textColor = 16765023;
         overBmp.bitmapData.draw(textField,matrix);
         textField.textColor = 16777215;
         textField.filters = [new GlowFilter(16765023,0.5,5,5,3,BitmapFilterQuality.HIGH,false,true)];
         pressedBmp.bitmapData.draw(textField,matrix);
         textField.filters = null;
         pressedBmp.bitmapData.draw(textField,matrix);
         super(clickHandler,normalBmp,overBmp,pressedBmp);
      }
   }
}

