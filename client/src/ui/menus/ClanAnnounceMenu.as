package ui.menus
{
   import net.*;
   import flash.text.TextField;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class ClanAnnounceMenu extends TerminalSubmenu
   {
      
      private var message:TextField;
      
      public function ClanAnnounceMenu()
      {
         var input:NTextInput;
         super(TM_MENU_CLAN_26);
         drawWindow(_("IDS_CLAN_ANNOUNCE_MENU"),0,0,W,225);
         if(Main.UserCharacter.isValue6)
         {
            input = new NTextInput(512,NTextFormat.notification.left);
            this.message = input.textField;
            input.wordWrap = true;
            input.multiline = true;
            input.x = 10;
            input.width = W - 20;
            input.y = 31;
            input.height = 185;
            addTerminalButton(418,234,_("IDS_SAVE"),function(param1:Object):void
            {
               GameSocket.socket.send(Commands.COMMANDS_CONST3,message.text,"");
            });
            addUIChild(input);
         }
         else
         {
            this.message = addText(10,31,"",NTextFormat.notification.left,W - 20);
            this.message.height = 185;
         }
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST38,this.doAction76);
         GameSocket.socket.send(Commands.COMMANDS_CONST38);
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST38,this.doAction76);
         super.dispose();
      }
      
      private function doAction76(param1:Array) : void
      {
         this.message.text = param1[1];
      }
   }
}

