package ui.menus
{
   import ui.buttons.NButton;
   import flash.text.TextField;
   import ui.NCheckBox;
   import ui.NTextFormat;
   
   public class SoberConfirmMenu extends NuclearSprite
   {
      
      private var okCallback:Function;
      
      private var cancelCallback:Function;
      
      private var soberCheckBox:NCheckBox;
      
      private var applyButton:NButton;
      
      public function SoberConfirmMenu(message:String, okHandler:Function, cancelHandler:Function = null)
      {
         var textField:TextField;
         super(TYPE_SOBER_CONFIRM);
         w = 520;
         h = 130;
         this.okCallback = okHandler;
         this.cancelCallback = cancelHandler;
         textField = createText(110,32,message,NTextFormat.notification.left,w - 140);
         addChild(textField);
         width = w;
         h = Math.max(h,textField.y + textField.height + 90);
         var soberLabel:TextField = createText(0,textField.y + textField.height + 18,_("IDS_I_AM_SOBER"),NTextFormat.notification.left,w - 70);
         soberLabel.x = (w - soberLabel.textWidth) / 2 - 10;
         addChild(soberLabel);
         this.soberCheckBox = new NCheckBox(this.onSoberClick);
         this.soberCheckBox.setPos(soberLabel.x + soberLabel.textWidth + 6,soberLabel.y + 3);
         addUIChild(this.soberCheckBox);
         this.applyButton = createButton(w / 2 - 106,h - 45,_("IDS_APPLY"),this.okClickHandler);
         addUIChild(this.applyButton);
         this.applyButton.enabled = false;
         addButton(w / 2 + 3,h - 45,_("IDS_CANCEL"),this.cancelClickHandler);
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         draw(getBmp("WARNING_SIGN"),28,textField.y + (textField.height - 59) / 2);
         height = h;
      }
      
      private function onSoberClick(checkBox:Object) : void
      {
         this.soberCheckBox.checked = !this.soberCheckBox.checked;
         this.applyButton.enabled = this.soberCheckBox.checked;
      }
      
      private function okClickHandler(sender:Object) : void
      {
         if(this.soberCheckBox.checked)
         {
            closeMenu();
            if(this.okCallback != null)
            {
               this.okCallback(this);
            }
         }
      }
      
      private function cancelClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.cancelCallback != null)
         {
            this.cancelCallback(this);
         }
      }
   }
}

