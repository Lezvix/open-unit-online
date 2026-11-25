package ui.menus
{
   import ui.buttons.NButton;
   import ui.buttons.SelectableButton;
   import net.*;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import ui.*;
   
   public class ClanWarsMenu extends TerminalSubmenu
   {
      
      private var declarableClans:Dictionary;
      
      private var clanDropDown:DropDown;
      
      private var declareWarButton:NButton;
      
      private var warsScroll:ScrollSprite;
      
      private var clanList:RowList;
      
      private var peaceRequestPrice:int;
      
      private var peaceAcceptPrice:int;
      
      private var peaceRequestHours:int;
      
      private var indemnityBase:int;
      
      private var indemnityPerLocation:int;
      
      private var warInfoText:TextField;
      
      private var surrenderButton:NButton;
      
      private var peaceRequestButton:NButton;
      
      private var peaceInfoText:TextField;
      
      private var acceptPeaceButton:NButton;
      
      private var rejectPeaceButton:NButton;
      
      private var indemnityButton:NButton;
      
      public function ClanWarsMenu()
      {
         var onWarDeclareClick:Function = null;
         var onWarClanSelectionChange:Function = null;
         this.declarableClans = new Dictionary();
         onWarDeclareClick = function(sender:Object):void
         {
            if(clanDropDown.SelectedKey != 0 && clanDropDown.SelectedKey in declarableClans)
            {
               showModal(new QuestionMenu(_("IDS_WAR_DECLARATION_WARNING",declarableClans[clanDropDown.SelectedKey]),function():void
               {
                  declareWarButton.enabled = false;
                  GameSocket.socket.send(Commands.FRIENDS_0j,clanDropDown.SelectedKey);
               }));
            }
         };
         onWarClanSelectionChange = function(param1:SelectableButton):void
         {
            var clan:Object = null;
            clearWarInfo();
            if(param1.Selected)
            {
               clan = param1.value;
               GameSocket.socket.send(Commands.COMMANDS_CONST21,clan.id);
            }
         };
         super(TM_MENU_CLAN_25);
         drawWindow("C:\\" + _("IDS_WAR_DECLARATION"),410,0,215,225);
         this.clanDropDown = new DropDown(195,null,this.onClanSelect);
         this.clanDropDown.setPos(420,32);
         this.declareWarButton = createTerminalButton(this.clanDropDown.x + 30,this.clanDropDown.y + 31,_("IDS_DECLARE_WAR"),onWarDeclareClick,this.clanDropDown.width - 60);
         addUIChild(this.declareWarButton);
         drawWindow("C:\\" + _("IDS_CURRENT_WARS"),0,0,400,225);
         this.warsScroll = new ScrollSprite(200,154,8);
         this.warsScroll.setPos(10,32);
         addUIChild(this.warsScroll);
         this.clanList = new RowList(187,onWarClanSelectionChange);
         this.warsScroll.addContent(this.clanList);
         this.warsScroll.init(this.clanList.height);
         this.warsScroll.visible = false;
         this.peaceRequestButton = createTerminalButton(this.warsScroll.x,this.warsScroll.y + this.warsScroll.height + 12,_("IDS_WAR_REQUEST_PEACE"),this.onPeaceRequestClick,120);
         this.peaceRequestButton.visible = false;
         addUIChild(this.peaceRequestButton);
         this.indemnityButton = createTerminalButton(this.peaceRequestButton.x + this.peaceRequestButton.width + 10,this.peaceRequestButton.y,_("IDS_INDEMNITY"),this.onIndemnityClick,120);
         this.indemnityButton.visible = false;
         addUIChild(this.indemnityButton);
         this.surrenderButton = createTerminalButton(this.indemnityButton.x + this.indemnityButton.width + 10,this.indemnityButton.y,_("IDS_WAR_SURRENDER"),this.onSurrenderClick,120);
         this.surrenderButton.visible = false;
         addUIChild(this.surrenderButton);
         this.acceptPeaceButton = createTerminalButton(this.warsScroll.x,this.indemnityButton.y,_("IDS_ACCEPT"),this.onAcceptPeaceClick,120);
         this.acceptPeaceButton.visible = false;
         addUIChild(this.acceptPeaceButton);
         this.rejectPeaceButton = createTerminalButton(this.acceptPeaceButton.x + this.acceptPeaceButton.width + 10,this.acceptPeaceButton.y,_("IDS_REJECT"),this.onRejectPeaceClick,120);
         this.rejectPeaceButton.visible = false;
         addUIChild(this.rejectPeaceButton);
         this.warInfoText = createText(215,this.warsScroll.y,"",NTextFormat.plain,180);
         addChild(this.warInfoText);
         this.peaceInfoText = createText(215,this.warsScroll.y + 60,"",NTextFormat.plain,180);
         addChild(this.peaceInfoText);
         addUIChild(this.clanDropDown);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST21,this.onWarInfo);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST16,this.onWarsList);
         GameSocket.socket.send(Commands.COMMANDS_CONST16);
      }
      
      private function onClanSelect(dropDown:Object) : void
      {
         this.declareWarButton.enabled = true;
      }
      
      private function onIndemnityClick(sender:Object) : void
      {
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var clan:Object = this.clanList.getRowValue(selected);
         showConfirm(formatString("IDS_INDEMNITY_NOTIFICATION",clan.name,this.indemnityBase,this.indemnityPerLocation),function(param1:Object):void
         {
            clearWarInfo();
            GameSocket.socket.send(Commands.COMMANDS_CONST4,clan.id);
         });
      }
      
      private function onAcceptPeaceClick(sender:Object) : void
      {
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var clan:Object = this.clanList.getRowValue(selected);
         showConfirm(formatString("IDS_PEACE_REQUEST_ACCEPT_NOTIFICATION",clan.name,this.peaceAcceptPrice),function(param1:Object):void
         {
            clearWarInfo();
            GameSocket.socket.send(Commands.COMMANDS_CONST17,clan.id);
         });
      }
      
      private function onRejectPeaceClick(sender:Object) : void
      {
         this.clearWarInfo();
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var clan:Object = this.clanList.getRowValue(selected);
         GameSocket.socket.send(Commands.COMMANDS_CONST13,clan.id);
      }
      
      private function onPeaceRequestClick(sender:Object) : void
      {
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var clan:Object = this.clanList.getRowValue(selected);
         showConfirm(formatString("IDS_WAR_REQUEST_PEACE_NOTIFICATION",clan.name,this.peaceRequestPrice,this.peaceRequestHours),function(param1:Object):void
         {
            clearWarInfo();
            GameSocket.socket.send(Commands.COMMANDS_CONST20,clan.id);
         });
      }
      
      private function onSurrenderClick(sender:Object) : void
      {
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var clan:Object = this.clanList.getRowValue(selected);
         showConfirm(formatString("IDS_WAR_SURRENDER_NOTIFICATION",clan.name),function(param1:Object):void
         {
            clearWarInfo();
            GameSocket.socket.send(Commands.COMMANDS_CONST34,clan.id);
         });
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST21,this.onWarInfo);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST16,this.onWarsList);
         super.dispose();
      }
      
      private function onWarsList(fields:Array) : void
      {
         declarableClans = new Dictionary();
         var offset:int = 1;
         var declarePrice:int = fields[offset++];
         addText(this.clanDropDown.x,this.declareWarButton.y + 25,formatString("IDS_WAR_DECLARATION_TIP",declarePrice),NTextFormat.normal.center,this.clanDropDown.width);
         setChildIndex(this.clanDropDown,numChildren - 1);
         peaceRequestPrice = fields[offset++];
         peaceAcceptPrice = fields[offset++];
         peaceRequestHours = fields[offset++];
         indemnityBase = fields[offset++];
         indemnityPerLocation = fields[offset++];
         var clanCount:int = fields[offset++];
         var unused:int = 0;
         var clan:Object;
         this.warInfoText.text = "";
         this.clanList.clear();
         while(clanCount > 0)
         {
            clan = {
               "id":fields[offset++],
               "name":fields[offset++]
            };
            if(Main.UserCharacter.check26(clan.id))
            {
               this.clanList.addRow(clan.name,"",clan);
            }
            else if(Main.UserCharacter.clanId != clan.id)
            {
               this.declarableClans[clan.id] = clan.name;
            }
            clanCount--;
         }
         this.clanDropDown.selectedValue = this.declarableClans;
         this.warsScroll.visible = this.clanList.totalRows > 0;
         this.warsScroll.init(this.clanList.height);
         this.declareWarButton.enabled = true;
      }
      
      private function clearWarInfo() : void
      {
         this.surrenderButton.visible = false;
         this.peaceRequestButton.visible = false;
         this.acceptPeaceButton.visible = false;
         this.rejectPeaceButton.visible = false;
         this.indemnityButton.visible = false;
         this.warInfoText.text = "";
         this.peaceInfoText.text = "";
      }
      
      private function showWarInfo(war:Object) : void
      {
         this.clearWarInfo();
         this.warInfoText.text = formatString("IDS_WAR_INFO_TEMPLATE",war.yourPoints,war.enemyPoints,war.startDate);
         this.warInfoText.height = this.warInfoText.textHeight + 4;
         if(war.state == WarState.NORMAL)
         {
            this.surrenderButton.visible = true;
            this.peaceRequestButton.visible = true;
            this.indemnityButton.visible = true;
         }
         else if(war.state == WarState.PEACE_REQUESTED)
         {
            if(war.request.clan.id == war.clan.id)
            {
               this.peaceInfoText.text = formatString("IDS_PEACE_REQUEST_RECEIVED",this.peaceRequestHours);
               this.acceptPeaceButton.visible = true;
               this.rejectPeaceButton.visible = true;
            }
            else
            {
               this.peaceInfoText.text = _("IDS_PEACE_REQUEST_SENT");
            }
            this.peaceInfoText.height = this.peaceInfoText.textHeight + 4;
         }
      }
      
      private function onWarInfo(fields:Array) : void
      {
         var selected:int = this.clanList.selectedRow;
         if(selected == -1)
         {
            return;
         }
         var offset:int = 1;
         var clanId:int = fields[offset++];
         var selectedClan:Object = this.clanList.getRowValue(selected);
         if(selectedClan.id != clanId)
         {
            return;
         }
         var war:Object = {"clan":selectedClan};
         war.startDate = int(fields[offset++]);
         war.enemyPoints = Number(fields[offset++]);
         war.yourPoints = Number(fields[offset++]);
         war.state = int(fields[offset++]);
         if(war.state == WarState.PEACE_REQUESTED)
         {
            war.request = {
               "clan":{"id":int(fields[offset++])},
               "date":int(fields[offset++]),
               "lifetime":int(fields[offset++])
            };
         }
         this.showWarInfo(war);
      }
   }
}

class WarState
{
   
   public static const NORMAL:int = 0;
   
   public static const PEACE_REQUESTED:int = 1;
   
   public static const TERMINATED:int = 2;
   
   public function WarState()
   {
      super();
   }
}
