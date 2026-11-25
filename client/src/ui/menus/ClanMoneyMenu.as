package ui.menus
{
   import ui.buttons.NButton;
   import net.*;
   import flash.text.TextField;
   import ui.ScrollSprite;
   import ui.NTextFormat;
   
   public class ClanMoneyMenu extends TerminalSubmenu
   {
      
      private var moneyText:TextField;
      
      private var durationButtons:Array;
      
      private var logText:TextField;
      
      private var logScroll:ScrollSprite;
      
      public function ClanMoneyMenu()
      {
         var durationButtonClick:Function;
         durationButtonClick = function(button:NButton):void
         {
            var i:int = 0;
            while(i < durationButtons.length)
            {
               durationButtons[i].enabled = false;
               i++;
            }
            GameSocket.socket.send(Commands.COMMANDS_CONST9,button.value);
         };
         super(TM_MENU_CLAN_9);
         drawWindow(_("IDS_DEPOD_CLAN_MONEY"),0,0,W,225);
         this.moneyText = addTextLabel(4,2,"?",NTextFormat.titleFormat.propValue12.right,W - 8);
         this.logScroll = new ScrollSprite(W - 12,165,8);
         this.logScroll.setPos(4,54);
         addUIChild(this.logScroll);
         this.logText = createText(2,0,"",NTextFormat.plain,this.logScroll.width - 10);
         this.logScroll.addLine(this.logText);
         this.durationButtons = LogDuration.LIST.map(function(duration:*, index:int, list:Array):*
         {
            var buttonWidth:int = 100;
            var buttonGap:int = 8;
            var buttonX:* = (W - (list.length * buttonWidth + (list.length - 1) * buttonGap)) / 2 + index * (buttonWidth + buttonGap);
            var button:* = createTerminalButton(buttonX,31,_(LogDuration.getLabel(duration)),durationButtonClick,buttonWidth);
            button.value = duration;
            addUIChild(button);
            return button;
         });
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST2,this.onClanMoney);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST9,this.onClanMoneyLog);
         GameSocket.socket.send(Commands.COMMANDS_CONST9,LogDuration.DAY);
         GameSocket.socket.send(Commands.COMMANDS_CONST2);
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST2,this.onClanMoney);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST9,this.onClanMoneyLog);
         super.dispose();
      }
      
      private function onClanMoney(fields:Array) : void
      {
         this.moneyText.text = formatString("IDS_MONEY_TEMPLATE",fields[1]);
      }
      
      private function onClanMoneyLog(fields:Array) : void
      {
         var values:Array = [];
         var i:int = 0;
         while(i < 13)
         {
            values[i] = 0;
            i++;
         }
         i = 1;
         while(i < fields.length - 1)
         {
            values[int(fields[i])] = int(fields[i + 1]);
            i += 2;
         }
         values.unshift("IDS_CLAN_ACCOUNT_LOG");
         this.logText.text = formatString.apply(null,values);
         this.logText.height = this.logText.textHeight + 4;
         this.logScroll.init(this.logText.height);
         i = 0;
         while(i < this.durationButtons.length)
         {
            this.durationButtons[i].enabled = true;
            i++;
         }
      }
   }
}

class LogDuration
{
   
   public static const DAY:int = 0;
   
   public static const WEEK:int = 1;
   
   public static const MONTH:int = 2;
   
   public static const LIST:Array = [DAY,WEEK,MONTH];
   
   public function LogDuration()
   {
      super();
   }
   
   public static function getLabel(duration:int) : String
   {
      switch(duration)
      {
         case DAY:
            return "IDS_DAY";
         case WEEK:
            return "IDS_WEEK";
         case MONTH:
            return "IDS_MONTH";
         default:
            throw new Error();
      }
   }
}
