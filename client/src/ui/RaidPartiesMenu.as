package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import ui.menus.PasswordRequest;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class RaidPartiesMenu extends NuclearMenu
   {
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var partiesScrollSprite:ScrollSprite;
      
      private var membersScrollSprite:ScrollSprite;
      
      private var partiesData:Dictionary = new Dictionary();
      
      private var partiesButtons:Array;
      
      private var selectedPartyButton:SelectableButton = null;
      
      private var selectedMemberButton:SelectableButton = null;
      
      private var startRaidButton:BaseButton;
      
      private var baseButton1:BaseButton;
      
      private var leaveRaidButton:BaseButton;
      
      private var kickMemberButton:BaseButton;
      
      private var passwordRequest:PasswordRequest;
      
      public function RaidPartiesMenu(param1:GameSocket, param2:Terminal, param3:Object, param4:Boolean)
      {
         super();
         dragable = false;
         this.socket = param1;
         this.terminal = param2;
         var titleFormat:TextFormat = getTextFormat({
            "size":12,
            "color":13408825
         });
         drawRect(0,0,410,225,13408825);
         drawHLine(4,22,402,13408825);
         drawHLine(4,206,402,13408825);
         drawRect(419,0,206,225,13408825);
         drawHLine(423,22,197,13408825);
         if(!param4)
         {
            param1.sendRaidPartiesRequest();
         }
         addChild(createTextField(6,2,300,titleFormat,"C:\\" + getString("IDS_TERM_ICO_22"),18));
         addChild(createTextField(425,2,150,titleFormat,getString("IDS_PARTICIPANTS"),18));
         this.baseButton1 = createTextButton(0,234,getString("IDS_ATTACK_CONNECT"),this.joinRaidClickHandler);
         addUIChild(this.baseButton1);
         this.leaveRaidButton = createTextButton(0,234,getString("IDS_LEAVE_CLAN"),this.leaveRaidClickHandler);
         addUIChild(this.leaveRaidButton);
         this.startRaidButton = createTextButton(0,234,getString("IDS_START_RAID"),this.startRaidClickHandler);
         addUIChild(this.startRaidButton);
         this.kickMemberButton = createTextButton(418,234,getString("IDS_REMOVE_USER"),this.kickMemberClick);
         addUIChild(this.kickMemberButton);
         this.partiesScrollSprite = new ScrollSprite(392,167,7);
         this.partiesScrollSprite.x = 9;
         this.partiesScrollSprite.y = 32;
         addUIChild(this.partiesScrollSprite);
         this.membersScrollSprite = new ScrollSprite(188,185,7);
         this.membersScrollSprite.x = 427;
         this.membersScrollSprite.y = 32;
         addUIChild(this.membersScrollSprite);
         addUIChild(createTextButton(526,234,getString("IDS_BACK"),this.closeBtnHandler));
      }
      
      private function kickMemberClick(param1:Object) : void
      {
         var party:Object = null;
         if(this.selectedPartyButton && this.selectedMemberButton)
         {
            party = this.partiesData[this.selectedPartyButton.value];
            if(party && this.isLeaderOf(party))
            {
               this.socket.sendRaidPartyMemberLeave(this.selectedMemberButton.value.id);
            }
         }
      }
      
      private function joinRaidClickHandler(param1:Object) : void
      {
         var party:Object = null;
         if(this.selectedPartyButton)
         {
            party = this.partiesData[this.selectedPartyButton.value];
            if(party)
            {
               if(party.members.length >= party.maxMembers)
               {
                  showNotifyMenu(getString("IDS_TOO_MANY_PARTICIPANTS"));
                  return;
               }
               if(party.passwordSet && this.passwordRequest == null)
               {
                  passwordRequest = new PasswordRequest(this.onPasswordEntered);
                  this.passwordRequest.x = (625 - this.passwordRequest.width) / 2;
                  this.passwordRequest.y = (336 - this.passwordRequest.height) / 2;
                  addUIChild(this.passwordRequest);
                  return;
               }
               this.socket.sendJoinRaid(party.id,"");
            }
         }
      }
      
      private function onPasswordEntered(param1:PasswordRequest) : void
      {
         if(this.selectedPartyButton)
         {
            this.socket.sendJoinRaid(this.selectedPartyButton.value,param1.Password);
            passwordRequest = null;
         }
      }
      
      private function leaveRaidClickHandler(param1:Object) : void
      {
         this.socket.sendRaidPartyMemberLeave(Main.UserCharacter.userId);
      }
      
      private function startRaidClickHandler(param1:Object) : void
      {
         this.startRaidButton.enabled = false;
         this.leaveRaidButton.enabled = false;
         this.socket.sendStartRaid();
      }
      
      public function parseData(param1:Array) : void
      {
         partiesData = new Dictionary();
         Main.UserCharacter.raidPartyId = 0;
         var fieldIndex:int = 1;
         var remainingParties:int = param1[fieldIndex++];
         var party:Object;
         var memberIndex:int;
         while(remainingParties > 0)
         {
            party = {
               "id":int(param1[fieldIndex++]),
               "name":param1[fieldIndex++],
               "passwordSet":int(param1[fieldIndex++]) == 1,
               "members":new Array(int(param1[fieldIndex++])),
               "maxMembers":int(param1[fieldIndex++])
            };
            memberIndex = 0;
            while(memberIndex < party.members.length)
            {
               party.members[memberIndex] = {
                  "name":param1[fieldIndex++],
                  "level":int(param1[fieldIndex++]),
                  "id":int(param1[fieldIndex++])
               };
               if(Main.UserCharacter.userId == party.members[memberIndex].id)
               {
                  Main.UserCharacter.raidPartyId = party.id;
               }
               memberIndex++;
            }
            this.partiesData[party.id] = party;
            remainingParties--;
         }
         this.drawPartiesList();
      }
      
      public function parseUpdateData(param1:Array) : void
      {
         var fieldIndex:int = 1;
         var partyId:int = param1[fieldIndex++];
         var party:Object = this.partiesData[partyId];
         var index:int;
         var partyButton:SelectableButton;
         Main.UserCharacter.raidPartyId = 0;
         if(party)
         {
            fieldIndex += 2;
            party.members = new Array(int(param1[fieldIndex++]));
            fieldIndex += 1;
            index = 0;
            while(index < party.members.length)
            {
               party.members[index] = {
                  "name":param1[fieldIndex++],
                  "level":int(param1[fieldIndex++]),
                  "id":int(param1[fieldIndex++])
               };
               if(Main.UserCharacter.userId == party.members[index].id)
               {
                  Main.UserCharacter.raidPartyId = partyId;
               }
               index++;
            }
            index = 0;
            while(index < this.partiesScrollSprite.uiContainer.numChildren)
            {
               partyButton = this.partiesScrollSprite.uiContainer.getChildAt(index) as SelectableButton;
               if((partyButton) && partyButton.value == partyId)
               {
                  partyButton.getLabel(1).text = party.members.length + "/" + party.maxMembers;
                  break;
               }
               index++;
            }
            if(this.selectedPartyButton && this.selectedPartyButton.value == partyId)
            {
               this.partyClickHandler(this.selectedPartyButton);
            }
         }
         else
         {
            party = {
               "id":partyId,
               "name":param1[fieldIndex++],
               "passwordSet":int(param1[fieldIndex++]) == 1,
               "members":new Array(int(param1[fieldIndex++])),
               "maxMembers":int(param1[fieldIndex++])
            };
            index = 0;
            while(index < party.members.length)
            {
               party.members[index] = {
                  "name":param1[fieldIndex++],
                  "level":int(param1[fieldIndex++]),
                  "id":int(param1[fieldIndex++])
               };
               if(Main.UserCharacter.userId == party.members[index].id)
               {
                  Main.UserCharacter.raidPartyId = partyId;
               }
               index++;
            }
            this.partiesData[partyId] = party;
            this.newPartyButton(party);
            this.partiesScrollSprite.init(this.partiesScrollSprite.uiContainer.numChildren * 21 - 1);
         }
      }
      
      private function updateMembersList() : void
      {
         var selectedMemberId:int = this.selectedMemberButton ? this.selectedMemberButton.value.id : 0;
         var scrollPosition:int = this.membersScrollSprite.scrollV;
         var party:Object;
         var member:Object;
         selectedMemberButton = null;
         this.membersScrollSprite.clear();
         if(this.selectedPartyButton)
         {
            party = this.partiesData[this.selectedPartyButton.value];
            for each(member in party.members)
            {
               this.newMemberButton(member,selectedMemberId == member.id || selectedMemberId == 0 && Main.UserCharacter.userId == member.id);
            }
         }
         this.membersScrollSprite.init(this.partiesScrollSprite.uiContainer.numChildren / 2 * 21 - 1,scrollPosition);
      }
      
      private function newPartyButton(param1:Object, param2:Boolean = false) : SelectableButton
      {
         var rowIndex:int = this.partiesScrollSprite.uiContainer.numChildren;
         var button:SelectableButton = new SelectableButton({
            "y":21 * rowIndex,
            "width":378,
            "clickHandler":this.partyClickHandler
         });
         button.addLabel(param1.members[0].name + "[" + param1.members[0].level + "] - " + param1.name);
         button.addLabel(param1.members.length + "/" + param1.maxMembers,TextFormatAlign.RIGHT);
         button.getLabel(0).width = button.getLabel(0).width - 18;
         button.getLabel(0).x = button.getLabel(0).x + 18;
         button.value = param1.id;
         if(param1.passwordSet)
         {
            button.addBitmap(getBmp("LOCKED_ICON"),1,1);
         }
         this.partiesScrollSprite.addContent(button);
         if(param2)
         {
            button.Selected = true;
            this.partyClickHandler(button);
         }
         return button;
      }
      
      private function newMemberButton(param1:Object, param2:Boolean = false) : SelectableButton
      {
         var rowIndex:int = this.membersScrollSprite.uiContainer.numChildren / 2;
         var button:SelectableButton = new SelectableButton({
            "y":21 * rowIndex,
            "width":174,
            "clickHandler":this.memberClickHandler
         });
         button.addLabel(param1.name + "[" + param1.level + "]");
         button.value = param1;
         this.membersScrollSprite.addContent(button);
         if(param2)
         {
            button.Selected = true;
            this.memberClickHandler(button);
         }
         var infoButton:BaseButton = new ImageButton(this.playerInfoClick);
         infoButton.y = button.y + 6;
         infoButton.x = button.getLabel(0).textWidth + 8;
         infoButton.value = param1.id;
         this.membersScrollSprite.addContent(infoButton);
         return button;
      }
      
      private function playerInfoClick(param1:Object) : void
      {
         this.socket.getCharInfo(param1.value);
      }
      
      private function memberClickHandler(param1:SelectableButton) : void
      {
         if(this.selectedMemberButton != null)
         {
            this.selectedMemberButton.Selected = false;
         }
         param1.Selected = true;
         selectedMemberButton = param1;
      }
      
      public function parseRemoveData(param1:Array) : void
      {
         var partyId:int = param1[1];
         if(partyId in this.partiesData)
         {
            if(this.selectedPartyButton && this.selectedPartyButton.value == partyId)
            {
               selectedPartyButton = null;
            }
            if(this.isMemberOf(this.partiesData[partyId]))
            {
               Main.UserCharacter.raidPartyId = 0;
            }
            delete this.partiesData[partyId];
            this.drawPartiesList();
         }
      }
      
      private function drawPartiesList() : void
      {
         var selectedPartyId:int = this.selectedPartyButton ? this.selectedPartyButton.value : 0;
         var scrollPosition:int = this.partiesScrollSprite.scrollV;
         var party:Object;
         this.startRaidButton.enabled = this.startRaidButton.visible = false;
         this.leaveRaidButton.enabled = this.leaveRaidButton.visible = false;
         this.baseButton1.enabled = this.baseButton1.visible = false;
         this.kickMemberButton.enabled = this.kickMemberButton.visible = false;
         selectedPartyButton = null;
         this.partiesScrollSprite.clear();
         this.membersScrollSprite.clear();
         for each(party in this.partiesData)
         {
            this.newPartyButton(party,selectedPartyId == party.id || selectedPartyId == 0 && this.isMemberOf(party));
         }
         this.partiesScrollSprite.init(this.partiesScrollSprite.uiContainer.numChildren * 21 - 1,scrollPosition);
      }
      
      private function isMemberOf(param1:Object) : Boolean
      {
         return Main.UserCharacter.raidPartyId == param1.id;
      }
      
      private function isLeaderOf(param1:Object) : Boolean
      {
         return Main.UserCharacter.userId == param1.members[0].id;
      }
      
      private function partyClickHandler(param1:SelectableButton) : void
      {
         if(this.passwordRequest && this.selectedPartyButton != param1)
         {
            this.passwordRequest.closeMenu();
            passwordRequest = null;
         }
         if(this.selectedPartyButton != null && this.selectedPartyButton != param1)
         {
            this.selectedPartyButton.Selected = false;
         }
         param1.Selected = true;
         var party:Object = this.partiesData[param1.value];
         selectedPartyButton = param1;
         this.kickMemberButton.enabled = this.kickMemberButton.visible = this.isLeaderOf(party);
         if(this.isMemberOf(party))
         {
            this.baseButton1.enabled = this.baseButton1.visible = false;
            if(this.isLeaderOf(party))
            {
               this.startRaidButton.enabled = this.startRaidButton.visible = true;
               this.leaveRaidButton.x = 110;
            }
            else
            {
               this.startRaidButton.enabled = this.startRaidButton.visible = false;
               this.leaveRaidButton.x = 0;
            }
            this.leaveRaidButton.enabled = this.leaveRaidButton.visible = true;
         }
         else
         {
            this.startRaidButton.enabled = this.startRaidButton.visible = false;
            this.leaveRaidButton.enabled = this.leaveRaidButton.visible = false;
            this.baseButton1.enabled = this.baseButton1.visible = true;
         }
         this.updateMembersList();
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      override public function dispose() : void
      {
         this.socket.sendStopObserveRaidParties();
         if(Main.UserCharacter.raidPartyId > 0)
         {
            this.socket.sendRaidPartyMemberLeave(Main.UserCharacter.userId);
         }
         if(this.passwordRequest)
         {
            this.passwordRequest.closeMenu();
            passwordRequest = null;
         }
         super.dispose();
      }
      
      override public function createMenu() : void
      {
         create(625,336,false);
      }
      
      public function removeMenu(param1:Object) : void
      {
      }
   }
}

