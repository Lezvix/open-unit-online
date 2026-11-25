package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import game.Chat;
   import game.DefaultsProxy;
   import ui.*;
   
   public class NewsMenu extends TerminalSubmenu
   {
      
      private var warsScroll:ScrollSprite;
      
      private var newsScroll:ScrollSprite;
      
      private var pageButtons:Vector.<NButton> = new Vector.<NButton>();
      
      private var sealButton:NButton;
      
      public function NewsMenu()
      {
         super(TM_MENU_CLAN_23);
         drawWindow("D:\\" + _("IDS_WARS"),0,0,320,225);
         this.warsScroll = new ScrollSprite(300,185);
         this.warsScroll.setPos(10,32);
         addUIChild(this.warsScroll);
         drawWindow("C:\\" + _("IDS_LATEST_NEWS"),329,0,296,225);
         this.newsScroll = new ScrollSprite(276,165);
         this.newsScroll.setPos(339,32);
         addUIChild(this.newsScroll);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST12,this.onWars);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST6,this.onNews);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST27,this.updateSealButton);
         GameSocket.socket.send(Commands.COMMANDS_CONST12);
         GameSocket.socket.send(Commands.COMMANDS_CONST6,0);
         this.updateSealButton();
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST12,this.onWars);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST6,this.onNews);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST27,this.updateSealButton);
         super.dispose();
      }
      
      private function onNews(fields:Array) : void
      {
         var button:NButton;
         var offset:int;
         var page:int;
         var lastPage:int;
         var eventCount:int;
         var eventsByDate:DefaultsProxy;
         this.newsScroll.clear();
         for each(button in this.pageButtons)
         {
            removeUIChild(button);
         }
         pageButtons = new Vector.<NButton>();
         offset = 1;
         page = fields[offset++];
         lastPage = fields[offset++];
         eventCount = fields[offset++];
         eventsByDate = new DefaultsProxy([]);
         while(eventCount > 0)
         {
            eventType = fields[offset++];
            eventTime = fields[offset++];
            dateStr = Chat.getString32(eventTime);
            eventArgs = Chat.filter(fields.slice(offset,offset + 4));
            offset += 4;
            eventsByDate[dateStr].push(getString11("IDS_POLITIC_EVENT_" + eventType,eventArgs));
            eventCount--;
         }
         var posY:int = 0;
         var eventType:int;
         var eventTime:int;
         var dateStr:String;
         var eventArgs:Array;
         var header:SelectableButton;
         var textField:TextField;
         var i:int;
         for(dateStr in eventsByDate)
         {
            header = new SelectableButton({
               "width":this.newsScroll.width - 16,
               "y":posY
            });
            header.addLabel(dateStr,TextFormatAlign.CENTER);
            this.newsScroll.addLine(header);
            posY += 29;
            textField = createText(0,posY,"",NTextFormat.plain,this.newsScroll.width - 16);
            i = 0;
            while(i < eventsByDate[dateStr].length)
            {
               textField.appendText(i + 1 + ". " + eventsByDate[dateStr][i] + "\n\n");
               i++;
            }
            textField.height = textField.textHeight + 5;
            posY += textField.height;
            this.newsScroll.addLine(textField);
         }
         this.newsScroll.init(posY);
         button = new TextLinkButton(Chat.doAction936,"" + (page + 1),30);
         button.setPos(this.newsScroll.x + this.newsScroll.width / 2 - 15,this.newsScroll.y + this.newsScroll.height);
         addUIChild(button);
         button.enabled = false;
         this.pageButtons.push(button);
         if(page > 0)
         {
            button = new TextLinkButton(this.onPageClick,"«",30);
            button.hintText = _("IDS_FIRST_PAGE");
            button.setPos(this.pageButtons[0].x - 60,this.pageButtons[0].y);
            button.value = 0;
            addUIChild(button);
            this.pageButtons.push(button);
            button = new TextLinkButton(this.onPageClick,"" + page,30);
            button.setPos(this.pageButtons[0].x - 30,this.pageButtons[0].y);
            button.value = page - 1;
            addUIChild(button);
            this.pageButtons.push(button);
         }
         if(lastPage > page)
         {
            button = new TextLinkButton(this.onPageClick,"" + (page + 2),30);
            button.setPos(this.pageButtons[0].x + 30,this.pageButtons[0].y);
            button.value = page + 1;
            addUIChild(button);
            this.pageButtons.push(button);
            button = new TextLinkButton(this.onPageClick,"»",30);
            button.hintText = _("IDS_LAST_PAGE");
            button.setPos(this.pageButtons[0].x + 60,this.pageButtons[0].y);
            button.value = lastPage;
            addUIChild(button);
            this.pageButtons.push(button);
         }
      }
      
      private function onPageClick(button:NButton) : void
      {
         GameSocket.socket.send(Commands.COMMANDS_CONST6,button.value);
      }
      
      private function updateSealButton(data:Array = null) : void
      {
         if(this.sealButton)
         {
            removeUIChild(this.sealButton);
            sealButton = null;
         }
         if(Main.UserCharacter.isValue65)
         {
            if(Main.UserCharacter.isValue8)
            {
               sealButton = createTerminalButton(338,234,_("IDS_UNSEAL_CLAN"),function(sender:Object):void
               {
                  showModal(new QuestionMenu(_("IDS_CLAN_UNSEAL_CONFIRMATION"),function(param1:Object):void
                  {
                     GameSocket.socket.send(Commands.COMMANDS_CONST19);
                  }));
               },180);
            }
            else
            {
               sealButton = createTerminalButton(358,234,_("IDS_SEAL_CLAN"),function(sender:Object):void
               {
                  showModal(new SoberConfirmMenu(_("IDS_CLAN_SEAL_CONFIRMATION"),function(param1:Object):void
                  {
                     GameSocket.socket.send(Commands.COMMANDS_CONST35);
                  }));
               },160);
            }
            addUIChild(this.sealButton);
         }
      }
      
      private function onWars(fields:Array) : void
      {
         this.warsScroll.clear();
         var offset:int = 1;
         var warCount:int = fields[offset++];
         var textField:TextField = createText(0,0,"",NTextFormat.plain,this.warsScroll.width);
         var number:int = 1;
         while(warCount > 0)
         {
            textField.appendText(number++ + ". " + fields[offset++] + " vs. " + fields[offset++] + "\n\n");
            warCount--;
         }
         textField.height = textField.textHeight + 5;
         this.warsScroll.addLine(textField);
      }
   }
}

