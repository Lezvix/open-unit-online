package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import core.ui.UIComponent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import game.Client;
   
   public class ClanHireMenu extends NuclearMenu
   {
      
      public static const CLAN_HIRE_MENU:int = 0;
      
      public static const CLAN_HIRE_REQUEST:int = 1;
      
      public static const CLAN_NO_HIRE_MENU:int = 2;
      
      public static const CLAN_CURRENT_HIRE_MENU:int = 3;
      
      public static const CLAN_HIRE_MENU_WIDTH:int = 625;
      
      public static const CLAN_HIRE_MENU_HEIGHT:int = 336;
      
      public var mainType:int;
      
      private var type:int;
      
      private var headerTF:TextField;
      
      private var hasHireAccess:Boolean;
      
      private var loginInput:NTextInput;
      
      private var socket:GameSocket;
      
      public var dataLoaded:Boolean;
      
      private var dynamicValue:int;
      
      private var clanHireDeltaCost:int;
      
      private var addHireLogin:String;
      
      private var terminal:Terminal;
      
      private var usersCount:int = 0;
      
      private var requestId:int;
      
      private var infoRequestId:int;
      
      private var scrollSprite:ScrollSprite;
      
      private var infoButton:BaseButton;
      
      private var loginTextField:TextField;
      
      private var anonimCostTF:TextField;
      
      private var totalCostTF:TextField;
      
      private var minKillCostTF:TextField;
      
      private var totalKillsInput:NTextInput;
      
      private var killCostInput:NTextInput;
      
      private var minKillCost:int;
      
      private var hireComission:int;
      
      private var anonimousCost:int = -1;
      
      private var anonimousCheck:NCheckBox;
      
      private var selectedUserId:int = -1;
      
      private var selectedButton:BaseButton;
      
      private var checksArray:Array;
      
      private var submenu:UIComponent;
      
      private var submenuItems:Array = new Array();
      
      public function ClanHireMenu(param1:int, param2:GameSocket, param3:Terminal, param4:Object, param5:Boolean, param6:Boolean)
      {
         var exchangeHelpButton:TextLinkButton;
         super();
         this.mainType = param1;
         this.type = this.type;
         this.socket = param2;
         this.terminal = param3;
         this.hasHireAccess = param5;
         var rightAlignedFormat:TextFormat = new TextFormat();
         rightAlignedFormat.font = "Verdana";
         rightAlignedFormat.color = 13408825;
         rightAlignedFormat.size = 12;
         rightAlignedFormat.align = TextFormatAlign.RIGHT;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         var normalFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 12;
         var smallBoldFormat:TextFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13408825;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         var smallFormat:TextFormat = new TextFormat();
         smallFormat.font = "Verdana";
         smallFormat.color = 13408825;
         smallFormat.size = 10;
         var smallMutedFormat:TextFormat = new TextFormat();
         smallMutedFormat.font = "Verdana";
         smallMutedFormat.color = 10187041;
         smallMutedFormat.size = 10;
         switch(param1)
         {
            case Client.HIRE_TYPE_PRIVATE:
               drawRect(0,0,625,221,13408825);
               drawHLine(4,22,617,13408825);
               this.setHeaders(getString("IDS_HIRE_EXCHANGE"));
               exchangeHelpButton = new TextLinkButton(this.handleExchangeInfo,getString("IDS_EXCHANGE_BUTTON"),150);
               exchangeHelpButton.x = CLAN_HIRE_MENU_WIDTH - 140;
               exchangeHelpButton.y = 3;
               addUIChild(exchangeHelpButton);
               addUIChild(createTextButton(272,230,getString("IDS_NEW_ORDER"),this.newOrderHandler));
               addUIChild(createTextButton(400,230,getString("IDS_MY_ORDERS"),this.myOrdersHandler));
               this.scrollSprite = new ScrollSprite(614,176,4);
               this.scrollSprite.x = 9;
               this.scrollSprite.y = 40;
               addUIChild(this.scrollSprite);
               addChild(createTextField(9,23,112,centeredFormat,getString("IDS_PHIRE_COL_0"),18));
               addChild(createTextField(121,23,116,centeredFormat,getString("IDS_PHIRE_COL_1"),18));
               addChild(createTextField(238,23,140,centeredFormat,getString("IDS_PHIRE_COL_2"),18));
               addChild(createTextField(379,23,126,centeredFormat,getString("IDS_PHIRE_COL_3"),18));
               addChild(createTextField(505,23,90,centeredFormat,getString("IDS_PHIRE_COL_4"),18));
               addChild(createTextField(2,227,200,smallBoldFormat,getString("IDS_PAGES"),18));
               break;
            case Client.HIRE_TYPE_NEW_ORDER:
               drawRect(0,0,625,221,13408825);
               drawHLine(4,22,617,13408825);
               this.setHeaders(getString("IDS_NEW_ORDER"));
               addChild(createTextField(18,30,300,normalFormat,getString("IDS_INPUT_TARGET")));
               addChild(createTextField(18,65,300,normalFormat,getString("IDS_SELECTED_TARGET")));
               this.loginTextField = createTextField(155,65,200,normalFormat,"");
               addChild(this.loginTextField);
               this.infoButton = this.createInfoButton(0,71,0,this);
               this.infoButton.visible = false;
               addUIChild(this.infoButton);
               addChild(createTextField(18,99,300,normalFormat,getString("IDS_KILL_COUNT")));
               addChild(createTextField(18,133,300,normalFormat,getString("IDS_INPUT_KILL_COST")));
               addChild(createTextField(32,152,200,smallBoldFormat,getString("IDS_ANONYM")));
               this.anonimCostTF = createTextField(92,152,300,smallFormat,getString("IDS_ANONYMOUS_COST"));
               addChild(this.anonimCostTF);
               this.totalCostTF = createTextField(18,170,500,smallFormat,getString("IDS_TOTAL_COST"));
               addChild(this.totalCostTF);
               this.minKillCostTF = createTextField(18,187,300,smallMutedFormat,getString("IDS_MIN_KILL_COST"));
               addChild(this.minKillCostTF);
               this.loginInput = createTextInput(162,31,99);
               this.loginInput.maxChars = 16;
               addUIChild(this.loginInput);
               this.totalKillsInput = createTextInput(236,99,99);
               this.totalKillsInput.maxChars = 3;
               this.totalKillsInput.addEventListener(Event.CHANGE,this.handlePrivateHireCost);
               addUIChild(this.totalKillsInput);
               this.killCostInput = createInput(257,132,99);
               this.killCostInput.addEventListener(Event.CHANGE,this.handlePrivateHireCost);
               addUIChild(this.killCostInput);
               this.anonimousCheck = new NCheckBox(this.handleAnonimousCheck,this);
               this.anonimousCheck.x = 18;
               this.anonimousCheck.y = 155;
               addUIChild(this.anonimousCheck);
               addUIChild(createTextButton(284,31,getString("IDS_FIND"),this.findUserHandler));
               addUIChild(createTextButton(1,230,getString("IDS_CONFIRM"),this.acceptNewOrderHandler));
               break;
            case Client.HIRE_TYPE_MY_ORDERS:
               drawRect(0,0,440,221,13408825);
               drawHLine(4,22,432,13408825);
               drawRect(458,0,167,221,13408825);
               drawHLine(462,23,158,13408825);
               this.setHeaders(getString("IDS_MY_HIRES"),getString("IDS_INFORMATION"));
               this.scrollSprite = new ScrollSprite(426,176,4);
               this.scrollSprite.x = 9;
               this.scrollSprite.y = 40;
               addUIChild(this.scrollSprite);
               this.submenu = new UIComponent();
               addUIChild(this.submenu);
               addChild(createTextField(10,23,95,centeredFormat,getString("IDS_PHIRE_COL_1"),18));
               addChild(createTextField(105,23,117,centeredFormat,getString("IDS_PHIRE_COL_2"),18));
               addChild(createTextField(222,23,74,centeredFormat,getString("IDS_PHIRE_COST_SHORT"),18));
               addChild(createTextField(296,23,95,centeredFormat,getString("IDS_PHIRE_COL_4"),18));
               break;
         }
         if(!param6)
         {
            switch(param1)
            {
               case Client.HIRE_TYPE_PRIVATE:
                  param2.sendRemoveHireRequest(0);
                  break;
               case Client.HIRE_TYPE_NEW_ORDER:
                  param2.sendShowHireAddRequest();
                  break;
               case Client.HIRE_TYPE_MY_ORDERS:
                  param2.sendMyHireRequests();
                  break;
               case Client.HIRE_TYPE_CLAN:
                  param2.doAction844(false);
                  break;
            }
         }
         addUIChild(createTextButton(526,230,getString("IDS_BACK"),this.closeBtnHandler));
      }
      
      private function handleExchangeInfo(param1:Object) : void
      {
         showNotifyMenu(getString("IDS_PRIVATE_EX_HELP"));
      }
      
      private function disposeSubmenuItems() : void
      {
         var item:Object = null;
         if(this.submenu)
         {
            while(this.submenu.numChildren > 0)
            {
               this.submenu.removeChildAt(0);
            }
            while(this.submenuItems.length > 0)
            {
               item = this.submenuItems.pop();
               item.dispose();
            }
         }
      }
      
      override public function dispose() : void
      {
         this.disposeSubmenuItems();
         if(this.totalKillsInput)
         {
            this.totalKillsInput.removeEventListener(Event.CHANGE,this.handlePrivateHireCost);
         }
         if(this.killCostInput)
         {
            this.killCostInput.removeEventListener(Event.CHANGE,this.handlePrivateHireCost);
         }
         super.dispose();
      }
      
      private function updatePrivateHireCost() : void
      {
         var totalCost:int = 0;
         if(this.anonimousCost != -1)
         {
            totalCost = int(int(this.killCostInput.text) * int(this.totalKillsInput.text) * (100 + this.hireComission) / 100);
            if(this.anonimousCheck.checked)
            {
               totalCost += this.anonimousCost;
            }
            this.totalCostTF.text = getString("IDS_TOTAL_COST") + " " + totalCost;
         }
      }
      
      private function handlePrivateHireCost(param1:Event) : void
      {
         this.updatePrivateHireCost();
      }
      
      private function handleAnonimousCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
         this.updatePrivateHireCost();
      }
      
      private function acceptNewOrderHandler(param1:Object) : void
      {
         var killCost:int = 0;
         var totalKills:int = 0;
         if(this.anonimousCost != -1)
         {
            killCost = int(this.killCostInput.text);
            totalKills = int(this.totalKillsInput.text);
            if(this.selectedUserId == -1)
            {
               showNotifyMenu(getString("IDS_PHIRE_ERROR_0"));
            }
            else if(this.selectedUserId == Main.UserCharacter.userId)
            {
               showNotifyMenu(getString("IDS_PHIRE_ERROR_1"));
            }
            else if(totalKills > 200)
            {
               showNotifyMenu(getString("IDS_PHIRE_ERROR_2"));
            }
            else if(killCost < this.minKillCost)
            {
               showNotifyMenu(getString("IDS_PHIRE_ERROR_3"));
            }
            else
            {
               this.socket.sendAddPrivateHire(this.selectedUserId,totalKills,killCost,this.anonimousCheck.checked);
            }
         }
      }
      
      private function findUserHandler(param1:Object) : void
      {
         this.socket.sendPrivateHireRequest(this.loginInput.text);
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      private function newOrderHandler(param1:Object) : void
      {
         this.terminal.createMenu(Client.TM_MENU_PRIVATE_NEW_ORDER);
      }
      
      private function myOrdersHandler(param1:Object) : void
      {
         this.terminal.createMenu(Client.TM_MENU_PRIVATE_MY_ORDERS);
      }
      
      public function parsePrivateHireData(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         var boldFormat:TextFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13408825;
         boldFormat.size = 10;
         boldFormat.bold = true;
         var centeredBoldFormat:TextFormat = new TextFormat();
         centeredBoldFormat.font = "Verdana";
         centeredBoldFormat.color = 13408825;
         centeredBoldFormat.size = 10;
         centeredBoldFormat.bold = true;
         centeredBoldFormat.align = TextFormatAlign.CENTER;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 10;
         centeredFormat.align = TextFormatAlign.CENTER;
         var rowBackground:Sprite;
         var label:TextField;
         var button:BaseButton;
         var waitingHireIds:Dictionary = new Dictionary();
         var remainingIds:int = param1[param2];
         param2++;
         while(remainingIds > 0)
         {
            waitingHireIds[int(param1[param2])] = 1;
            param2++;
            remainingIds--;
         }
         curPage = param1[param2];
         pagesCount = param1[param2 + 1];
         var remainingRows:int = param1[param2 + 2];
         param2 += 3;
         var rowIndex:int = 0;
         while(remainingRows > 0)
         {
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,604,16);
            rowBackground.y = rowIndex * 18;
            this.scrollSprite.addLine(rowBackground);
            if(int(param1[param2 + 1]) == 0)
            {
               this.scrollSprite.addLine(createTextField(0,rowIndex * 18,112,centeredBoldFormat,getString("IDS_ANONYM"),18));
            }
            else
            {
               label = createTextField(0,rowIndex * 18,112,centeredBoldFormat,param1[param2 + 2],18);
               this.scrollSprite.addLine(label);
               button = this.createInfoButton((112 + Math.ceil(label.textWidth)) / 2 + 5,rowIndex * 18 + 4,param1[param2 + 1],18);
               this.scrollSprite.addContent(button);
            }
            label = createTextField(112,rowIndex * 18,116,centeredBoldFormat,param1[param2 + 4],18);
            this.scrollSprite.addLine(label);
            button = this.createInfoButton(112 + (116 + Math.ceil(label.textWidth)) / 2 + 5,rowIndex * 18 + 4,param1[param2 + 3],18);
            this.scrollSprite.addContent(button);
            this.scrollSprite.addLine(createTextField(229,rowIndex * 18,140,centeredFormat,param1[param2 + 5],18));
            this.scrollSprite.addLine(createTextField(370,rowIndex * 18,126,centeredFormat,param1[param2 + 6],18));
            if(waitingHireIds[param1[param2].toString()])
            {
               this.scrollSprite.addLine(createTextField(496,rowIndex * 18,90,centeredFormat,getString("IDS_WAITING"),18));
               button = createTextButton(585,rowIndex * 18 + 1,"X",this.handleDeleteHire,param1[param2],BUTTON_SMALL_PLUS,this.scrollSprite);
               this.scrollSprite.addContent(button);
            }
            else
            {
               button = createTextButton(495,rowIndex * 18 + 2,getString("IDS_ACCEPT_HIRE"),this.handleAcceptHire,int(param1[param2]),BUTTON_SMALL_BWIDTH,this.scrollSprite);
               this.scrollSprite.addContent(button);
            }
            rowIndex++;
            param2 += 7;
            remainingRows--;
         }
         this.scrollSprite.init(rowIndex * 18 + 2);
         createPageButtons(this,227,68);
      }
      
      private function handleDeleteHire(param1:Object) : void
      {
         this.socket.sendLeavePrivateHire(param1.value);
      }
      
      private function handleAcceptHire(param1:Object) : void
      {
         this.socket.sendClanHireAccept(param1.value);
      }
      
      private function handleMyHirePress(param1:Object) : void
      {
         if(this.selectedButton)
         {
            updateBgUI(Sprite(this.selectedButton.upState),false,415,16);
         }
         selectedButton = BaseButton(param1);
         updateBgUI(Sprite(param1.upState),true,415,16);
         this.socket.sendPrivateHireJoin(int(this.selectedButton.value));
      }
      
      private function removeMyHireRequest(param1:Object) : void
      {
         this.socket.sendRejectClanHire(param1.value);
      }
      
      public function parseMyHireUsers(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         var boldFormat:TextFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13408825;
         boldFormat.size = 10;
         boldFormat.bold = true;
         var centeredBoldFormat:TextFormat = new TextFormat();
         centeredBoldFormat.font = "Verdana";
         centeredBoldFormat.color = 13408825;
         centeredBoldFormat.size = 10;
         centeredBoldFormat.bold = true;
         centeredBoldFormat.align = TextFormatAlign.CENTER;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 10;
         centeredFormat.align = TextFormatAlign.CENTER;
         selectedButton = null;
         var button:BaseButton;
         var rowBackground:Sprite;
         var label:TextField;
         var remainingRows:int = param1[param2];
         var rowIndex:int = 0;
         param2 += 1;
         while(remainingRows > 0)
         {
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,415,16);
            this.scrollSprite.addLine(rowBackground);
            button = new NButton(this.handleMyHirePress,rowBackground,rowBackground,rowBackground);
            button.x = 0;
            button.y = rowIndex * 18;
            button.value = param1[param2];
            this.scrollSprite.addContent(button);
            label = createTextField(10,rowIndex * 18,200,boldFormat,param1[param2 + 2],18);
            this.scrollSprite.addLine(label);
            button = this.createInfoButton(label.x + Math.ceil(label.textWidth) + 5,rowIndex * 18 + 4,param1[param2 + 1],this.scrollSprite);
            this.scrollSprite.addContent(button);
            this.scrollSprite.addLine(createTextField(95,rowIndex * 18,117,centeredFormat,param1[param2 + 3],18));
            this.scrollSprite.addLine(createTextField(212,rowIndex * 18,74,centeredFormat,param1[param2 + 4],18));
            this.scrollSprite.addLine(createTextField(286,rowIndex * 18,95,centeredFormat,param1[param2 + 5] == 1 ? getString("IDS_HIRE_ACTIVE") : getString("IDS_HIRE_WAITING"),18));
            button = createTextButton(382,rowIndex * 18 + 1,"X",this.removeMyHireRequest,param1[param2],BUTTON_SMALL_PLUS,this.scrollSprite);
            this.scrollSprite.addContent(button);
            rowIndex++;
            remainingRows--;
            param2 += 6;
         }
         this.scrollSprite.init(rowIndex * 18 + 1);
      }
      
      private function handleHireUserCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
      }
      
      public function parseHireUsers(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         this.disposeSubmenuItems();
         checksArray = new Array();
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.align = TextFormatAlign.CENTER;
         var userFormat:TextFormat = new TextFormat();
         userFormat.font = "Verdana";
         userFormat.color = 13408825;
         userFormat.size = 10;
         userFormat.bold = true;
         var detailsFormat:TextFormat = new TextFormat();
         detailsFormat.font = "Verdana";
         detailsFormat.color = 13408825;
         detailsFormat.size = 10;
         infoRequestId = param1[param2];
         var huntStarted:Boolean = int(param1[param2 + 1]) == 1;
         var totalKills:int = param1[param2 + 2];
         var currentKills:int = param1[param2 + 3];
         var remainingUsers:int = param1[param2 + 4];
         var userInfoButton:BaseButton;
         var checkBox:NCheckBox;
         var userLabel:TextField;
         var usersScroll:ScrollSprite = new ScrollSprite(153,136,4);
         usersScroll.x = 466;
         usersScroll.y = 39;
         this.submenuItems.push(usersScroll);
         this.submenu.addUIChild(usersScroll);
         this.submenu.addChild(createTextField(458,23,167,headingFormat,getString("IDS_MY_HIRE_USERS"),18));
         var rowIndex:int = 0;
         param2 += 5;
         while(remainingUsers > 0)
         {
            userLabel = createTextField(12,rowIndex * 18,100,userFormat,param1[param2 + 1],18);
            usersScroll.addLine(userLabel);
            userInfoButton = new NButton(this.handleInfoPress,getBmp("INFO_BTN"),getBmp("INFO_BTN_OVER"),getBmp("INFO_BTN_PRESSED"));
            userInfoButton.y = rowIndex * 18 + 4;
            userInfoButton.x = userLabel.x + userLabel.textWidth + 5;
            userInfoButton.value = param1[param2];
            this.submenuItems.push(userInfoButton);
            usersScroll.addContent(userInfoButton);
            if(!huntStarted)
            {
               checkBox = new NCheckBox(this.handleHireUserCheck,usersScroll);
               checkBox.value = param1[param2];
               checkBox.x = 0;
               checkBox.y = rowIndex * 18 + 2;
               this.submenuItems.push(checkBox);
               this.checksArray.push(checkBox);
               usersScroll.addContent(checkBox);
            }
            remainingUsers--;
            param2 += 2;
            rowIndex++;
         }
         usersScroll.init(rowIndex * 18 + 2);
         if(huntStarted)
         {
            this.submenu.addChild(createTextField(466,183,200,detailsFormat,getString("IDS_CURRENT_KILLS") + " " + currentKills,18));
            this.submenu.addChild(createTextField(466,201,200,detailsFormat,getString("IDS_KILLS_LEFT") + " " + (totalKills - currentKills).toString(),18));
         }
         else
         {
            this.submenu.addUIChild(createTextButtonDirect(466,196,getString("IDS_START_HUNT"),this.startHuntHandler,154,19,1,1,0,0,this.submenu));
         }
      }
      
      private function startHuntHandler(param1:Object) : void
      {
         var selectedCount:int = 0;
         var index:int;
         var selectedIds:String;
         index = 0;
         while(index < this.checksArray.length)
         {
            if(this.checksArray[index].checked)
            {
               selectedCount++;
            }
            index++;
         }
         if(selectedCount > 0)
         {
            selectedIds = "";
            index = 0;
            while(index < this.checksArray.length)
            {
               if(this.checksArray[index].checked)
               {
                  selectedIds += this.checksArray[index].value.toString() + "|";
               }
               index++;
            }
            this.socket.sendStr("hu|" + this.infoRequestId + "|" + selectedCount + "|" + selectedIds);
         }
         else
         {
            showNotifyMenu(getString("IDS_NO_SELECTED_USERS"));
         }
      }
      
      public function parsePrivateHireAdd(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         anonimousCost = param1[param2];
         minKillCost = param1[param2 + 1];
         hireComission = param1[param2 + 2];
         this.anonimCostTF.text = getString("IDS_ANONYMOUS_COST") + " " + this.anonimousCost;
         this.minKillCostTF.text = getString("IDS_MIN_KILL_COST") + " " + this.minKillCost;
         this.updatePrivateHireCost();
      }
      
      public function parsePrivateFindUser(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         this.loginTextField.text = param1[param2];
         this.infoButton.x = this.loginTextField.x + this.loginTextField.textWidth + 5;
         this.infoButton.value = param1[param2 + 1];
         selectedUserId = param1[param2 + 1];
         this.infoButton.visible = true;
      }
      
      public function parseClanHireData(param1:Array, param2:int) : void
      {
         dataLoaded = true;
         usersCount = 0;
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Verdana";
         textFormat.color = 13408825;
         textFormat.size = 12;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.align = TextFormatAlign.RIGHT;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         var centeredBoldFormat:TextFormat = new TextFormat();
         centeredBoldFormat.font = "Verdana";
         centeredBoldFormat.color = 13408825;
         centeredBoldFormat.size = 12;
         centeredBoldFormat.bold = true;
         centeredBoldFormat.align = TextFormatAlign.CENTER;
         var smallBoldFormat:TextFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13408825;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         var smallCenteredBoldFormat:TextFormat = new TextFormat();
         smallCenteredBoldFormat.font = "Verdana";
         smallCenteredBoldFormat.color = 13408825;
         smallCenteredBoldFormat.size = 10;
         smallCenteredBoldFormat.bold = true;
         smallCenteredBoldFormat.align = TextFormatAlign.CENTER;
         var smallCenteredFormat:TextFormat = new TextFormat();
         smallCenteredFormat.font = "Verdana";
         smallCenteredFormat.color = 13408825;
         smallCenteredFormat.size = 10;
         smallCenteredFormat.align = TextFormatAlign.CENTER;
         var remainingRows:int;
         var rowBackground:Sprite;
         var label:TextField;
         var rowRequestId:int;
         var button:BaseButton;
         var positionOrRowIndex:int = 0;
         var secondPosition:int;
         var message:String;
         type = param1[param2];
         switch(this.type)
         {
            case CLAN_HIRE_MENU:
               drawRect(0,0,440,221,13408825);
               drawHLine(4,22,432,13408825);
               drawRect(458,0,167,221,13408825);
               drawHLine(462,23,158,13408825);
               break;
            case CLAN_HIRE_REQUEST:
            case CLAN_NO_HIRE_MENU:
            case CLAN_CURRENT_HIRE_MENU:
               drawRect(0,0,625,221,13408825);
               drawHLine(4,22,617,13408825);
               break;
         }
         switch(this.type)
         {
            case CLAN_HIRE_REQUEST:
               this.setHeaders(getString("IDS_CLAN_HIRE_DEF_HEADER"));
               this.requestId = param1[param2 + 1];
               message = getString("IDS_HREQUEST");
               positionOrRowIndex = message.search("%s");
               message = message.replace("%s",param1[param2 + 2]).replace("%d",param1[param2 + 3]);
               label = createTextField(178,100,268,centeredFormat,message,60);
               label.multiline = true;
               label.wordWrap = true;
               label.setTextFormat(centeredBoldFormat,positionOrRowIndex,positionOrRowIndex + param1[param2 + 2].toString().length);
               addChild(label);
               addUIChild(createTextButton(1,230,getString("IDS_ACCEPT"),this.acceptClanHireRequest));
               addUIChild(createTextButton(128,230,getString("IDS_REJECT"),this.rejectClanHireRequest));
               break;
            case CLAN_NO_HIRE_MENU:
               this.setHeaders(getString("IDS_CLAN_HIRE_DEF_HEADER"));
               label = createTextField(178,100,268,centeredFormat,getString("IDS_NOHIRE_TEXT"),60);
               label.multiline = true;
               label.wordWrap = true;
               addChild(label);
               break;
            case CLAN_CURRENT_HIRE_MENU:
               this.setHeaders(getString("IDS_CLAN_HIRE_DEF_HEADER"));
               message = getString("IDS_CUR_HIRE_TEXT");
               positionOrRowIndex = message.search("%s1");
               message = message.replace("%s1",param1[param2 + 1]);
               secondPosition = message.search("%s2");
               message = message.replace("%s2",this.getTimeStr(param1[param2 + 2]));
               label = createTextField(178,100,268,centeredFormat,message,60);
               label.multiline = true;
               label.wordWrap = true;
               label.setTextFormat(centeredBoldFormat,positionOrRowIndex,positionOrRowIndex + param1[param2 + 1].toString().length);
               label.setTextFormat(centeredBoldFormat,secondPosition,secondPosition + this.getTimeStr(param1[param2 + 2]).length);
               addChild(label);
               if(this.hasHireAccess)
               {
                  addUIChild(createTextButton(1,230,getString("IDS_HIRE_LIST"),this.handleHireListPress));
                  addUIChild(createTextButton(128,230,getString("IDS_REJECT"),this.exitFromClanHire));
               }
               else
               {
                  addUIChild(createTextButton(1,230,getString("IDS_REJECT"),this.exitFromClanHire));
               }
               break;
            case CLAN_HIRE_MENU:
               this.setHeaders(getString("IDS_CLAN_HIRE_HEADER"),getString("IDS_INVITE_HIRE"));
               addChild(createTextField(10,22,95,centeredFormat,getString("IDS_NICK"),18));
               addChild(createTextField(105,22,118,centeredFormat,getString("IDS_CLAN"),18));
               addChild(createTextField(223,22,78,centeredFormat,getString("IDS_STATUS"),18));
               addChild(createTextField(301,22,104,centeredFormat,getString("IDS_TIME_LEFT"),18));
               scrollSprite = new ScrollSprite(426,176,4);
               this.scrollSprite.x = 9;
               this.scrollSprite.y = 40;
               dynamicValue = param1[param2 + 1];
               clanHireDeltaCost = param1[param2 + 2];
               remainingRows = param1[param2 + 3];
               param2 += 4;
               while(remainingRows > 0)
               {
                  rowRequestId = param1[param2];
                  rowBackground = new Sprite();
                  updateBgUI(rowBackground,false,415,16);
                  rowBackground.x = 0;
                  rowBackground.y = positionOrRowIndex * 18;
                  this.scrollSprite.addLine(rowBackground);
                  label = createTextField(10,positionOrRowIndex * 18,200,smallBoldFormat,param1[param2 + 2],18);
                  this.scrollSprite.addLine(label);
                  button = this.createInfoButton(label.x + Math.ceil(label.textWidth) + 5,positionOrRowIndex * 18 + 4,param1[param2 + 1],this.scrollSprite);
                  this.scrollSprite.addContent(button);
                  this.scrollSprite.addLine(createTextField(95,positionOrRowIndex * 18,118,smallCenteredBoldFormat,param1[param2 + 3],18));
                  this.scrollSprite.addLine(createTextField(213,positionOrRowIndex * 18,79,smallCenteredFormat,rowRequestId == 0 ? getString("IDS_HIRE_ACTIVE") : getString("IDS_HIRE_WAITING"),18));
                  this.scrollSprite.addLine(createTextField(291,positionOrRowIndex * 18,104,smallCenteredFormat,rowRequestId == 0 ? this.getTimeStr(param1[param2 + 4]) : "-",18));
                  if(rowRequestId == 0)
                  {
                     button = createTextButton(395,positionOrRowIndex * 18 + 1,"X",this.removeUserById,param1[param2 + 1],BUTTON_SMALL_PLUS);
                  }
                  else
                  {
                     button = createTextButton(395,positionOrRowIndex * 18 + 1,"X",this.removeRequesById,rowRequestId,BUTTON_SMALL_PLUS);
                  }
                  this.scrollSprite.addContent(button);
                  positionOrRowIndex++;
                  param2 += 5;
                  remainingRows--;
                  ++this.usersCount;
               }
               this.scrollSprite.init(positionOrRowIndex * 18 + 1);
               addChild(createTextField(458,34,167,centeredFormat,getString("IDS_INPUT_LOGIN"),18));
               loginInput = createTextInput(492,77,99);
               addUIChild(this.loginInput);
               addUIChild(createTextButton(492,102,getString("IDS_CONFIRM"),this.handleAddClanHire));
               addUIChild(this.scrollSprite);
               break;
         }
      }
      
      private function exitFromClanHire(param1:Object) : void
      {
         this.socket.sendExitFromHire();
      }
      
      private function acceptClanHireRequest(param1:Object) : void
      {
         this.socket.sendAddClanHire(this.requestId);
      }
      
      private function rejectClanHireRequest(param1:Object) : void
      {
         this.socket.sendRemoveHireByUserId(this.requestId);
      }
      
      private function handleHireListPress(param1:Object) : void
      {
         this.socket.doAction844(true);
      }
      
      private function handleAddClanHire(param1:Object) : void
      {
         addHireLogin = this.loginInput.text;
         showWarningMenu(_("IDS_CLAN_HIRE_COST",this.dynamicValue + this.usersCount * this.clanHireDeltaCost),this.processAddClanHire);
      }
      
      private function processAddClanHire(param1:Object) : void
      {
         this.socket.sendCellLogRequest(this.addHireLogin);
      }
      
      private function removeUserById(param1:Object) : void
      {
         this.socket.sendExchangeUpdateRequest(param1.value);
      }
      
      private function removeRequesById(param1:Object) : void
      {
         this.socket.applyExchange(param1.value);
      }
      
      private function getTimeStr(param1:int) : String
      {
         var timeString:String = "";
         if(int(param1 / 86400) < 10)
         {
            timeString += "0";
         }
         timeString += int(param1 / 86400).toString() + getString("IDS_DAY_S") + ":";
         if(int(param1 % 86400 / 3600) < 10)
         {
            timeString += "0";
         }
         timeString += int(param1 % 86400 / 3600).toString() + getString("IDS_HOURS") + ":";
         if(int(param1 % 3600 / 60) < 10)
         {
            timeString += "0";
         }
         timeString += int(param1 % 3600 / 60).toString() + getString("IDS_MINUTES_S");
         return timeString;
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
      
      public function setHeaders(param1:String, param2:String = "") : void
      {
         var headerFormat:TextFormat = new TextFormat();
         headerFormat.font = "Verdana";
         headerFormat.color = 13408825;
         headerFormat.size = 12;
         var centeredHeaderFormat:TextFormat = new TextFormat();
         centeredHeaderFormat.font = "Verdana";
         centeredHeaderFormat.color = 13408825;
         centeredHeaderFormat.size = 12;
         centeredHeaderFormat.align = TextFormatAlign.CENTER;
         headerTF = createTextField(14,3,400,headerFormat,param1,18);
         addChild(this.headerTF);
         if(param2 != "")
         {
            addChild(createTextField(458,3,167,centeredHeaderFormat,param2,18));
         }
      }
      
      override public function createMenu() : void
      {
         create(CLAN_HIRE_MENU_WIDTH,CLAN_HIRE_MENU_HEIGHT,false,0);
      }
      
      private function handlePrivateHirePage(param1:Object) : void
      {
         this.socket.sendRemoveHireRequest(param1.value);
      }
      
      override protected function addPageButton(param1:int, param2:int, param3:int) : int
      {
         var normalFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 10;
         var highlightFormat:TextFormat = new TextFormat();
         highlightFormat.font = "Verdana";
         highlightFormat.color = 10187041;
         highlightFormat.size = 10;
         var upState:Sprite = new Sprite();
         var label:TextField = createTextField(0,0,0,highlightFormat,(param1 + 1).toString(),18);
         label.width = label.textWidth + 3;
         upState.addChild(label);
         var overState:Sprite = new Sprite();
         label = createTextField(0,0,0,normalFormat,(param1 + 1).toString(),18);
         label.width = label.textWidth + 3;
         overState.addChild(label);
         var button:BaseButton = new NButton(this.handlePrivateHirePage,upState,overState,overState);
         button.x = param2;
         button.y = param3;
         button.value = param1;
         addUIChild(button);
         return param2 + label.width + 2;
      }
   }
}

