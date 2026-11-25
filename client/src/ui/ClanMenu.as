package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.display.NSprite;
   import core.ui.BaseButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.Stat;
   
   public class ClanMenu extends NuclearMenu
   {
      
      public static const USER_PRIVATE:int = 0;
      
      public static const USER_HEAD:int = 1;
      
      public static const USER_VC_HEAD:int = 2;
      
      public static const USER_ATTACK_HEAD:int = 3;
      
      public static const USER_TREASURER:int = 4;
      
      public static const USER_OFFICER:int = 5;
      
      public static const USER_SNIPER:int = 6;
      
      public static const USER_TANK:int = 7;
      
      public static const USER_STORM_TROOPER:int = 8;
      
      public static const USER_ARTISAN:int = 9;
      
      public static const USER_JOURNALIST:int = 10;
      
      public static const USER_SCOUT:int = 11;
      
      public static const USER_RECRUITER:int = 12;
      
      public static const USER_DIPLOMAT:int = 13;
      
      public static const USER_EXPLORATOR:int = 14;
      
      public static const POSITIONS_COUNT:int = 15;
      
      public static var CLAN_MENU_WIDTH:int = 625;
      
      public static var CLAN_MENU_HEIGHT:int = 336;
      
      public static var TYPE_DUES_OWNER:int = 0;
      
      public static var TYPE_DUES:int = 1;
      
      public static var TYPE_CONTROL_OWNER:int = 2;
      
      public static var TYPE_CONTROL:int = 3;
      
      public static var TYPE_MONEY:int = 4;
      
      private var positionsCount:Array;
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var type:int;
      
      private var dueInput:NTextInput;
      
      private var monthDueInput:NTextInput;
      
      private var loginInput:NTextInput;
      
      private var monthDueText:TextField;
      
      private var currentClanMoney:int = 0;
      
      private var curMonth:int;
      
      private var month1Text:TextField;
      
      private var month2Text:TextField;
      
      private var headerTF:TextField;
      
      private var scrollSprite:ScrollSprite;
      
      private var rightScroll:ScrollSprite;
      
      public var dataLoaded:Boolean = false;
      
      private var userIdToDelete:int;
      
      private var clanId:int = 0;
      
      private var selectedCombo:NCombo;
      
      private var lastSelectedIdx:int;
      
      private var curSelectedIdx:int;
      
      public function ClanMenu(param1:GameSocket, param2:Terminal, param3:Object, param4:int, param5:Boolean)
      {
         var positionIndex:int;
         super();
         dragable = false;
         this.type = param4;
         this.socket = param1;
         this.terminal = param2;
         this.positionsCount = new Array(POSITIONS_COUNT);
         positionIndex = 0;
         while(positionIndex < POSITIONS_COUNT)
         {
            this.positionsCount[positionIndex] = 0;
            positionIndex++;
         }
         drawRect(0,0,440,225,13408825);
         drawHLine(4,22,432,13408825);
         drawRect(458,0,167,225,13408825);
         drawHLine(462,23,158,13408825);
         var normalFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 12;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         var rightAlignedFormat:TextFormat = new TextFormat();
         var label:TextField;
         var rowBackground:Sprite;
         rightAlignedFormat.font = "Verdana";
         rightAlignedFormat.color = 13408825;
         rightAlignedFormat.size = 12;
         rightAlignedFormat.align = TextFormatAlign.RIGHT;
         switch(param4)
         {
            case TYPE_DUES:
            case TYPE_DUES_OWNER:
               this.setHeaders(getString("IDS_CLAN_DUES"),getString("IDS_CLAN_MONTH_DUE"));
               this.dueInput = createInput(123,231,99);
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,138,16);
               rowBackground.x = 475;
               rowBackground.y = 82;
               addChild(rowBackground);
               this.monthDueText = createTextField(458,80,167,centeredFormat,"-",18);
               addChild(this.monthDueText);
               this.dueInput.text = "0";
               addUIChild(this.dueInput);
               addUIChild(createTextButton(231,231,"+",this.handleDueAdd,0,BUTTON_SIGN));
               addUIChild(createTextButton(259,231,"-",this.handleDueSub,0,BUTTON_SIGN));
               addUIChild(createTextButton(341,231,getString("IDS_TRANSLATE"),this.handleTranslatePress));
               label = createTextField(488,38,113,centeredFormat,getString("IDS_CURRENT_DUE"),40);
               label.multiline = true;
               label.wordWrap = true;
               addChild(label);
               addChild(createTextField(4,232,150,normalFormat,getString("IDS_DO_DUE"),18));
               this.month1Text = createTextField(131,22,96,centeredFormat,"",18);
               this.month2Text = createTextField(305,22,96,centeredFormat,"",18);
               addChild(this.month1Text);
               addChild(this.month2Text);
               this.scrollSprite = new ScrollSprite(426,176,4);
               this.scrollSprite.x = 9;
               this.scrollSprite.y = 40;
               addUIChild(this.scrollSprite);
               if(param4 == TYPE_DUES_OWNER)
               {
                  this.monthDueInput = createInput(493,147,99);
                  addUIChild(this.monthDueInput);
                  addUIChild(createTextButton(493,182,getString("IDS_APPLY"),this.handleMonthDueAccept));
                  label = createTextField(488,107,113,centeredFormat,getString("IDS_SET_NEW_VALUE"),40);
                  label.multiline = true;
                  label.wordWrap = true;
                  addChild(label);
               }
               if(!param5)
               {
                  param1.sendDueRequest();
               }
               break;
            case TYPE_CONTROL:
            case TYPE_CONTROL_OWNER:
               this.setHeaders(getString("IDS_CLAN_STRUCT"),param4 == TYPE_CONTROL ? getString("IDS_CLAN_OWN_INVITE") : getString("IDS_CLAN_INVITE"));
               this.scrollSprite = new ScrollSprite(426,176,4);
               this.scrollSprite.x = 9;
               this.scrollSprite.y = 40;
               addUIChild(this.scrollSprite);
               addChild(createTextField(0,22,96,centeredFormat,getString("IDS_NICK"),18));
               if(param4 == TYPE_CONTROL_OWNER)
               {
                  this.rightScroll = new ScrollSprite(142,66,4);
                  this.rightScroll.x = 472;
                  this.rightScroll.y = 150;
                  addUIChild(this.rightScroll);
                  this.loginInput = createTextInput(492,77,99);
                  this.loginInput.maxChars = 16;
                  addUIChild(this.loginInput);
                  addUIChild(createTextButton(492,102,getString("IDS_CONFIRM"),this.handleAddClanUser));
                  label = createTextField(491,28,106,centeredFormat,getString("IDS_INPUT_CLAN_LOGIN"),60);
                  label.multiline = true;
                  label.wordWrap = true;
                  addChild(label);
                  addChild(createTextField(189,22,96,centeredFormat,getString("IDS_POSITION"),18));
                  addChild(createTextField(492,131,99,centeredFormat,getString("IDS_CANDIDATES"),18));
               }
               else
               {
                  addChild(createTextField(305,22,96,centeredFormat,getString("IDS_POSITION"),18));
               }
               if(!param5)
               {
                  param1.sendClanControlRequest();
               }
               break;
         }
         addUIChild(createTextButton(526,234,getString("IDS_BACK"),this.closeBtnHandler));
      }
      
      private function handleAddClanUser(param1:Object) : void
      {
         this.socket.doAction263(this.loginInput.text);
      }
      
      private function handleTranslatePress(param1:Object) : void
      {
         this.socket.doAction298(int(this.dueInput.text));
      }
      
      private function handleMonthDueAccept(param1:Object) : void
      {
         this.monthDueText.text = this.monthDueInput.text;
         this.socket.setDue(int(this.monthDueInput.text));
      }
      
      public function parseDue(param1:Array) : void
      {
         dataLoaded = true;
         var nameFormat:TextFormat = new TextFormat();
         nameFormat.font = "Verdana";
         nameFormat.color = 13408825;
         nameFormat.size = 10;
         nameFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         curMonth = param1[1];
         this.month1Text.text = getString("IDS_MONTH_" + (this.curMonth % 12).toString());
         this.month2Text.text = getString("IDS_MONTH_" + ((this.curMonth + 1) % 12).toString());
         this.headerTF.text = getString("IDS_CLAN_DUES_MONEY") + " " + param1[2];
         this.monthDueText.text = param1[3];
         var remainingRows:int = param1[4];
         var fieldIndex:int = 5;
         var rowBackground:Sprite;
         var rowIndex:int = 0;
         var nameField:TextField;
         var infoButton:BaseButton;
         while(remainingRows > 0)
         {
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,415,16);
            rowBackground.x = 0;
            rowBackground.y = rowIndex * 18;
            this.scrollSprite.addLine(rowBackground);
            nameField = createTextField(10,rowIndex * 18,200,nameFormat,param1[fieldIndex],18);
            this.scrollSprite.addLine(nameField);
            infoButton = this.createInfoButton(nameField.x + Math.ceil(nameField.textWidth) + 5,rowIndex * 18 + 4,param1[fieldIndex + 1],this.scrollSprite);
            this.scrollSprite.addContent(infoButton);
            this.scrollSprite.addLine(createTextField(122,rowIndex * 18 - 2,96,centeredFormat,param1[fieldIndex + 2],18));
            this.scrollSprite.addLine(createTextField(296,rowIndex * 18 - 2,96,centeredFormat,param1[fieldIndex + 3],18));
            fieldIndex += 4;
            rowIndex++;
            remainingRows--;
         }
         this.scrollSprite.init(rowIndex * 18);
      }
      
      public function parseClanControl(param1:Array) : void
      {
         dataLoaded = true;
         var nameFormat:TextFormat = new TextFormat();
         nameFormat.font = "Verdana";
         nameFormat.color = 13408825;
         nameFormat.size = 10;
         nameFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         this.headerTF.text = getString("IDS_CLAN_STRUCT_MONEY") + " " + param1[1];
         var rowBackground:Sprite;
         var comboPopup:NSprite;
         var remainingRows:int = param1[2];
         var fieldIndex:int = 3;
         var positionIndex:int;
         var rowIndex:int = 0;
         var label:TextField;
         var button:BaseButton;
         var positionCombo:NCombo;
         var positionId:int;
         while(remainingRows > 0)
         {
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,415,16);
            rowBackground.x = 0;
            rowBackground.y = rowIndex * 18;
            this.scrollSprite.addLine(rowBackground);
            label = createTextField(4,rowIndex * 18,100,nameFormat,param1[fieldIndex],18);
            this.scrollSprite.addLine(label);
            button = this.createInfoButton(label.x + Math.ceil(label.textWidth) + 5,rowIndex * 18 + 4,param1[fieldIndex + 1],this.scrollSprite);
            this.scrollSprite.addContent(button);
            positionId = param1[fieldIndex + 2];
            this.positionsCount[positionId]++;
            if(this.type == TYPE_CONTROL_OWNER && Main.UserCharacter.hasAccess(Stat.GA_DELETE_CLAN_USERS))
            {
               if(int(param1[fieldIndex + 3]) == 1 && positionId != USER_HEAD && (positionId != USER_VC_HEAD || Main.UserCharacter.hasAccess(Stat.GA_HEAD_ACCESS)))
               {
                  label = createTextField(180,rowIndex * 18 - 2,96,centeredFormat,getString("IDS_CLAN_POSITION_" + positionId),18);
                  label.visible = false;
                  this.scrollSprite.addLine(label);
                  comboPopup = new NSprite();
                  positionCombo = new NCombo(comboPopup,this.clanPositionChange,param1[fieldIndex + 1],this.scrollSprite);
                  positionCombo.object = param1[fieldIndex];
                  positionCombo.object1 = label;
                  positionCombo.x = 185;
                  positionCombo.y = rowIndex * 18 + 2;
                  positionIndex = 0;
                  while(positionIndex < POSITIONS_COUNT)
                  {
                     positionCombo.addItem(getString("IDS_CLAN_POSITION_" + positionIndex));
                     positionIndex++;
                  }
                  positionCombo.selectedItem = positionId;
                  comboPopup.x = this.scrollSprite.x + positionCombo.x;
                  comboPopup.y = this.scrollSprite.y + positionCombo.y;
                  positionCombo.setScrollSprite(this.scrollSprite);
                  this.scrollSprite.addContent(positionCombo);
                  addChild(comboPopup);
               }
               else
               {
                  this.scrollSprite.addLine(createTextField(180,rowIndex * 18 - 2,96,centeredFormat,getString("IDS_CLAN_POSITION_" + positionId),18));
               }
               if(positionId != USER_HEAD)
               {
                  if(Main.UserCharacter.userId == param1[fieldIndex + 1])
                  {
                     button = createTextButton(342,rowIndex * 18 + 2,getString("IDS_LEAVE_CLAN"),this.leaveClanHandler,param1[fieldIndex + 1],BUTTON_SMALL,this.scrollSprite);
                  }
                  else
                  {
                     button = createTextButton(342,rowIndex * 18 + 2,getString("IDS_REMOVE_USER"),this.removeUserHandler,param1[fieldIndex + 1],BUTTON_SMALL,this.scrollSprite);
                  }
                  button.object = param1[fieldIndex];
                  this.scrollSprite.addContent(button);
               }
            }
            else
            {
               this.scrollSprite.addLine(createTextField(180,rowIndex * 18 - 2,96,centeredFormat,getString("IDS_CLAN_POSITION_" + positionId),18));
               if(Main.UserCharacter.userId == param1[fieldIndex + 1])
               {
                  button = createTextButton(342,rowIndex * 18 + 2,getString("IDS_LEAVE_CLAN"),this.leaveClanHandler,param1[fieldIndex + 1],BUTTON_SMALL,this.scrollSprite);
                  button.object = param1[fieldIndex];
                  this.scrollSprite.addContent(button);
               }
            }
            fieldIndex += 4;
            rowIndex++;
            remainingRows--;
         }
         this.scrollSprite.init(rowIndex * 18 + 2);
         if(this.type == TYPE_CONTROL_OWNER)
         {
            remainingRows = param1[fieldIndex];
            fieldIndex++;
            rowIndex = 0;
            while(remainingRows > 0)
            {
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,130,16);
               rowBackground.x = 0;
               rowBackground.y = rowIndex * 18;
               this.rightScroll.addLine(rowBackground);
               label = createTextField(4,rowIndex * 18,100,nameFormat,param1[fieldIndex],18);
               this.rightScroll.addLine(label);
               button = this.createInfoButton(label.x + Math.ceil(label.textWidth) + 5,rowIndex * 18 + 4,param1[fieldIndex + 1],this.rightScroll);
               this.rightScroll.addContent(button);
               button = createTextButton(110,rowIndex * 18 + 1,"X",this.removeUserFromRequests,param1[fieldIndex + 1],BUTTON_SMALL_PLUS,this.rightScroll);
               this.rightScroll.addContent(button);
               fieldIndex += 2;
               rowIndex++;
               remainingRows--;
            }
            this.rightScroll.init(rowIndex * 18 + 1);
         }
      }
      
      private function removeUserFromRequests(param1:Object) : void
      {
         this.socket.sendAddClanUser(param1.value);
      }
      
      private function deleteUserConfirm(param1:Object) : void
      {
         this.socket.processDue(this.userIdToDelete);
      }
      
      private function removeUserHandler(param1:Object) : void
      {
         userIdToDelete = param1.value;
         showWarningMenu(_("IDS_CLAN_CICK_WARNING",param1.object),this.deleteUserConfirm);
      }
      
      private function leaveClanHandler(param1:Object) : void
      {
         userIdToDelete = param1.value;
         showWarningMenu(_("IDS_CLAN_LEAVE_WARNING"),this.deleteUserConfirm);
      }
      
      private function handleClanHeadChange(param1:Object) : void
      {
         this.positionsCount[this.lastSelectedIdx]--;
         this.positionsCount[this.curSelectedIdx]++;
         this.selectedCombo.selectedItem = this.curSelectedIdx;
         this.selectedCombo.visible = false;
         this.selectedCombo.object1.text = this.selectedCombo.items[this.selectedCombo.selectedItem];
         this.selectedCombo.object1.visible = true;
         this.socket.setUserPosition(this.selectedCombo.value,this.curSelectedIdx);
      }
      
      private function clanPositionChange(param1:Object) : void
      {
         var positionCombo:NCombo = NCombo(param1);
         switch(positionCombo.selectedItem)
         {
            case USER_HEAD:
               if(Main.UserCharacter.hasAccess(Stat.GA_HEAD_ACCESS))
               {
                  selectedCombo = positionCombo;
                  curSelectedIdx = positionCombo.selectedItem;
                  lastSelectedIdx = positionCombo.lastSelectedItem;
                  showWarningMenu(_("IDS_CLAN_HEAD_CHANGE_WARNING",positionCombo.object),this.handleClanHeadChange);
               }
               else
               {
                  showNotifyMenu(getString("IDS_NO_ACCESS"));
               }
               positionCombo.selectedItem = positionCombo.lastSelectedItem;
               break;
            case USER_VC_HEAD:
               if(Main.UserCharacter.hasAccess(Stat.GA_HEAD_ACCESS))
               {
                  if(this.positionsCount[positionCombo.selectedItem] < 2)
                  {
                     this.positionsCount[positionCombo.lastSelectedItem]--;
                     this.positionsCount[positionCombo.selectedItem]++;
                     positionCombo.visible = false;
                     positionCombo.object1.text = positionCombo.items[positionCombo.selectedItem];
                     positionCombo.object1.visible = true;
                     this.socket.setUserPosition(positionCombo.value,positionCombo.selectedItem);
                  }
                  else
                  {
                     showNotifyMenu(getString("IDS_POSITIONS_LIMIT"));
                     positionCombo.selectedItem = positionCombo.lastSelectedItem;
                  }
               }
               else
               {
                  showNotifyMenu(getString("IDS_NO_ACCESS"));
                  positionCombo.selectedItem = positionCombo.lastSelectedItem;
               }
               break;
            case USER_ATTACK_HEAD:
               if(this.positionsCount[positionCombo.selectedItem] < 1)
               {
                  this.positionsCount[positionCombo.lastSelectedItem]--;
                  this.positionsCount[positionCombo.selectedItem]++;
                  positionCombo.visible = false;
                  positionCombo.object1.text = positionCombo.items[positionCombo.selectedItem];
                  positionCombo.object1.visible = true;
                  this.socket.setUserPosition(positionCombo.value,positionCombo.selectedItem);
               }
               else
               {
                  showNotifyMenu(getString("IDS_POSITIONS_LIMIT"));
                  positionCombo.selectedItem = positionCombo.lastSelectedItem;
               }
               break;
            default:
               this.positionsCount[positionCombo.lastSelectedItem]--;
               this.positionsCount[positionCombo.selectedItem]++;
               positionCombo.visible = false;
               positionCombo.object1.text = positionCombo.items[positionCombo.selectedItem];
               positionCombo.object1.visible = true;
               this.socket.setUserPosition(positionCombo.value,positionCombo.selectedItem);
               break;
         }
      }
      
      private function createInfoButton(param1:int, param2:int, param3:int, param4:Object) : BaseButton
      {
         var button:BaseButton = new ImageButton(this.handleInfoPress);
         button.y = param2;
         button.x = param1;
         button.value = param3;
         return button;
      }
      
      private function handleInfoPress(param1:Object) : void
      {
         this.socket.getCharInfo(param1.value);
      }
      
      public function clanAddAccept(param1:Object) : void
      {
         this.socket.clanAddAccept(param1.value);
      }
      
      public function clanAddReject(param1:Object) : void
      {
         this.socket.clanAddReject(param1.value);
      }
      
      public function parseClanRequest(param1:Array) : void
      {
         var nameFormat:TextFormat = null;
         var centeredBoldFormat:TextFormat = null;
         var centeredFormat:TextFormat = null;
         var invitationText:String = null;
         var clanNameStart:int = 0;
         var clanNameEnd:int = 0;
         var rowBackground:Sprite = null;
         var remainingRows:int = 0;
         var fieldIndex:int = 0;
         var rowIndex:int = 0;
         var label:TextField = null;
         var infoButton:BaseButton = null;
         dataLoaded = true;
         if(param1.length > 2)
         {
            nameFormat = new TextFormat();
            nameFormat.font = "Verdana";
            nameFormat.color = 13408825;
            nameFormat.size = 10;
            nameFormat.bold = true;
            centeredBoldFormat = new TextFormat();
            centeredBoldFormat.font = "Verdana";
            centeredBoldFormat.color = 13408825;
            centeredBoldFormat.size = 12;
            centeredBoldFormat.bold = true;
            centeredBoldFormat.align = TextFormatAlign.CENTER;
            centeredFormat = new TextFormat();
            centeredFormat.font = "Verdana";
            centeredFormat.color = 13408825;
            centeredFormat.size = 12;
            centeredFormat.align = TextFormatAlign.CENTER;
            invitationText = getString("IDS_CLAN") + " ";
            clanNameStart = invitationText.length;
            invitationText += "\"" + param1[2] + "\"";
            clanNameEnd = invitationText.length;
            invitationText += " " + getString("IDS_CLAN_TEXT_INVITE");
            label = createTextField(470,54,142,centeredFormat,invitationText,60);
            label.setTextFormat(centeredBoldFormat,clanNameStart,clanNameEnd);
            label.multiline = true;
            label.wordWrap = true;
            addChild(label);
            addUIChild(createTextButton(492,133,getString("IDS_CLAN_ACCEPT"),this.clanAddAccept,param1[1]));
            addUIChild(createTextButton(492,165,getString("IDS_CLAN_REJECT"),this.clanAddReject,param1[1]));
            clanId = param1[1];
            remainingRows = param1[3];
            fieldIndex = 4;
            rowIndex = 0;
            while(remainingRows > 0)
            {
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,415,16);
               rowBackground.x = 0;
               rowBackground.y = rowIndex * 18;
               this.scrollSprite.addLine(rowBackground);
               label = createTextField(4,rowIndex * 18,100,nameFormat,param1[fieldIndex],18);
               this.scrollSprite.addLine(label);
               infoButton = this.createInfoButton(label.x + Math.ceil(label.textWidth) + 5,rowIndex * 18 + 4,param1[fieldIndex + 1],this.scrollSprite);
               this.scrollSprite.addContent(infoButton);
               this.scrollSprite.addLine(createTextField(296,rowIndex * 18 - 2,96,centeredFormat,getString("IDS_CLAN_POSITION_" + param1[fieldIndex + 2]),18));
               fieldIndex += 3;
               rowIndex++;
               remainingRows--;
            }
            this.scrollSprite.init(rowIndex * 18);
         }
      }
      
      private function handleDueAdd(param1:Object) : void
      {
         var dueAmount:int = int(this.dueInput.text);
         if(dueAmount < 999999)
         {
            this.dueInput.text = (dueAmount + 1).toString();
         }
      }
      
      private function handleDueSub(param1:Object) : void
      {
         var dueAmount:int = int(this.dueInput.text);
         if(dueAmount > 0)
         {
            this.dueInput.text = (dueAmount - 1).toString();
         }
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      public function setHeaders(param1:String, param2:String) : void
      {
         var headerFormat:TextFormat = new TextFormat();
         headerFormat.font = "Verdana";
         headerFormat.color = 13408825;
         headerFormat.size = 12;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         headerTF = createTextField(14,3,400,headerFormat,param1,18);
         addChild(this.headerTF);
         addChild(createTextField(458,3,167,centeredFormat,param2,18));
      }
      
      override public function createMenu() : void
      {
         create(CLAN_MENU_WIDTH,CLAN_MENU_HEIGHT,false,0);
      }
   }
}

