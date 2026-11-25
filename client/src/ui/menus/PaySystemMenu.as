package ui.menus
{
   import ui.buttons.NButton;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class PaySystemMenu extends TitledMenu
   {
      
      public static const PAY_SYSTEMS_COUNT:int = 2;
      
      public function PaySystemMenu()
      {
         super(TYPE_PAY_SYSTEM,_("IDS_SELECT_PAYSYSTEM"),320,175);
         var i:int = 0;
         var button:NButton;
         while(i < PAY_SYSTEMS_COUNT)
         {
            button = new NButton(this.onPaySystemClick,getBmp("PAY_SYSTEM_" + i));
            button.value = i;
            button.setPos(47 + i * 125,47);
            addUIChild(button);
            i++;
         }
      }
      
      private function onPaySystemClick(button:NButton) : void
      {
         navigateToURL(new URLRequest(_("IDS_PAY_URL_" + button.value,Main.UserCharacter.name)),"_blank");
         closeMenu();
      }
   }
}

