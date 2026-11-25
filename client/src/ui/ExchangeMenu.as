package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ExchangeMenu extends NuclearMenu
   {
      
      public static var EX_MENU_WIDTH:int = 625;
      
      public static var EX_MENU_HEIGHT:int = 336;
      
      private static const EXCHANGE_COMISSION:Number = 0.1;
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var scrollSprite:ScrollSprite;
      
      private var selectedSlot:int;
      
      private var itemButtons:Array;
      
      private var pageButtonsSprite:Sprite;
      
      private var downSpriteButtons:Array;
      
      private var downMenuSprite:NUIComponent;
      
      private var gameMoney:int;
      
      private var goldMoney:int;
      
      private var ownYear:int;
      
      private var ownMonth:int;
      
      private var ownDay:int;
      
      private var ownGoldMoney:int;
      
      private var ownGameMoney:int;
      
      private var adminCourse:int;
      
      private var adminGoldMoney:int;
      
      private var adminGameMoney:int;
      
      private var gameMoneyTF:NTextInput;
      
      private var goldMoneyTF:NTextInput;
      
      private var credsTF:NTextInput;
      
      private var gmTF:NTextInput;
      
      private var resultGmTF:NTextInput;
      
      private var itemData:Array;
      
      public function ExchangeMenu(param1:GameSocket, param2:Terminal, param3:Object)
      {
         super();
         this.socket = param1;
         this.terminal = param2;
         this.itemButtons = new Array();
         this.pageButtonsSprite = new Sprite();
         this.downSpriteButtons = new Array();
         this.downMenuSprite = new NUIComponent();
         var rightAlignedFormat:TextFormat = new TextFormat();
         rightAlignedFormat.font = "Verdana";
         rightAlignedFormat.color = 13408825;
         rightAlignedFormat.size = 12;
         rightAlignedFormat.align = TextFormatAlign.RIGHT;
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 10;
         var smallBoldFormat:TextFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13408825;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         var centeredLabelFormat:TextFormat = new TextFormat();
         centeredLabelFormat.font = "Verdana";
         centeredLabelFormat.color = 13408825;
         centeredLabelFormat.size = 10;
         centeredLabelFormat.align = TextFormatAlign.CENTER;
         drawRect(0,0,625,151,13408825);
         drawHLine(4,22,617,13408825);
         drawRect(0,169,625,51,13408825);
         addChild(createTextField(14,3,400,headingFormat,getString("IDS_EXCHANGE"),18));
         addChild(createTextField(21,23,200,labelFormat,getString("IDS_NICK"),18));
         addChild(createTextField(129,23,96,centeredLabelFormat,getString("IDS_ENDS"),18));
         addChild(createTextField(214,23,116,centeredLabelFormat,getString("IDS_EX_CREDS"),18));
         addChild(createTextField(330,23,116,centeredLabelFormat,getString("IDS_EX_GM"),18));
         addChild(createTextField(435,23,96,centeredLabelFormat,getString("IDS_COURSE"),18));
         this.scrollSprite = new ScrollSprite(614,110,4);
         this.scrollSprite.x = 9;
         this.scrollSprite.y = 40;
         addUIChild(this.scrollSprite);
         var unusedTextField:TextField;
         var helpButton:TextLinkButton = new TextLinkButton(this.handleExchangeInfo,getString("IDS_EXCHANGE_BUTTON"),150);
         helpButton.x = EX_MENU_WIDTH - 140;
         helpButton.y = 3;
         addUIChild(helpButton);
         addUIChild(createTextButton(526,230,getString("IDS_BACK"),this.closeBtnHandler));
         addChild(createTextField(5,231,200,headingFormat,getString("IDS_DEPOD_MONEY"),18));
         addChild(createTextField(286,231,60,headingFormat,getString("IDS_GAME_MONEY"),18));
         addChild(createTextField(426,231,60,headingFormat,getString("IDS_CREDS"),18));
         this.gameMoneyTF = createInput(181,231,100,16);
         addUIChild(this.gameMoneyTF);
         this.goldMoneyTF = createInput(321,231,100,16);
         addUIChild(this.goldMoneyTF);
         param1.sendExchangeStartRequest();
         addChild(this.pageButtonsSprite);
         addUIChild(this.downMenuSprite);
      }
      
      private function handleExchangeInfo(param1:Object) : void
      {
         showNotifyMenu(getString("IDS_EXCHANGE_HELP"));
      }
      
      private function updateMoney() : void
      {
         this.gameMoneyTF.text = this.gameMoney.toString();
         this.goldMoneyTF.text = this.goldMoney.toString();
      }
      
      override public function createMenu() : void
      {
         create(EX_MENU_WIDTH,EX_MENU_HEIGHT,false,0);
      }
      
      override public function dispose() : void
      {
         this.disposeItemsButtons();
         this.disposeDownButtons();
         super.dispose();
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      private function disposeItemsButtons() : void
      {
         var button:Object = null;
         while(this.itemButtons.length > 0)
         {
            button = this.itemButtons.pop();
            button.dispose();
         }
         this.scrollSprite.clear();
         while(this.pageButtonsSprite.numChildren > 0)
         {
            this.pageButtonsSprite.removeChildAt(0);
         }
      }
      
      private function disposeDownButtons() : void
      {
         var button:Object = null;
         while(this.downSpriteButtons.length > 0)
         {
            button = this.downSpriteButtons.pop();
            button.dispose();
         }
         this.downMenuSprite.disposeAllChilds();
      }
      
      public function parseCreateMenu(param1:Array) : void
      {
         this.disposeItemsButtons();
         gameMoney = param1[1];
         goldMoney = param1[2];
         ownYear = param1[3];
         ownMonth = param1[4];
         ownDay = param1[5];
         ownGoldMoney = param1[6];
         ownGameMoney = param1[7];
         adminCourse = param1[8];
         adminGameMoney = param1[9];
         adminGoldMoney = param1[10];
         this.parseMenuItems(param1,11);
         this.createDownMenu();
         this.updateMoney();
      }
      
      private function getDateStr(param1:int, param2:int, param3:int) : String
      {
         var formattedDate:String = "";
         if(param3 < 10)
         {
            formattedDate += "0";
         }
         formattedDate += param3.toString() + "/";
         if(param2 + 1 < 10)
         {
            formattedDate += "0";
         }
         formattedDate += (param2 + 1).toString() + "/";
         if(param1 % 10 < 10)
         {
            formattedDate += "0";
         }
         formattedDate += (param1 % 10).toString();
         return formattedDate;
      }
      
      private function createDownMenu() : void
      {
         this.disposeDownButtons();
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.align = TextFormatAlign.RIGHT;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         if(this.ownYear == 0)
         {
            this.downMenuSprite.addChild(createTextField(16,173,50,labelFormat,getString("IDS_EXCH_BUY"),18));
            this.downMenuSprite.addChild(createTextField(16,197,400,labelFormat,getString("IDS_COMMISION"),18));
            this.downMenuSprite.addChild(createTextField(169,173,100,labelFormat,getString("IDS_CREDS_FOR"),18));
            this.downMenuSprite.addChild(createTextField(356,173,50,labelFormat,getString("IDS_GAME_MONEY"),18));
            this.downMenuSprite.addChild(createTextField(356,197,50,labelFormat,getString("IDS_GAME_MONEY"),18));
            credsTF = createInput(66,173,100,7);
            this.downMenuSprite.addUIChild(this.credsTF);
            gmTF = createInput(252,173,100,9);
            this.gmTF.allHandler = this.handleGMKeyDown;
            this.downMenuSprite.addUIChild(this.gmTF);
            resultGmTF = createInput(252,197,100,9);
            this.downMenuSprite.addUIChild(this.resultGmTF);
            this.downMenuSprite.addUIChild(createTextButton(489,195,getString("IDS_ADD_EXCH"),this.handleSendExchange,0,BUTTON_BIG));
         }
         else
         {
            this.downMenuSprite.addChild(createTextField(10,173,400,labelFormat,getString("IDS_YOUR_EXCH_ACTIVE") + " " + this.getDateStr(this.ownYear,this.ownMonth,this.ownDay),18));
            this.downMenuSprite.addChild(createTextField(10,196,400,labelFormat,getString("IDS_EXCH_DESC"),18));
            this.downMenuSprite.addChild(createTextField(314,196,50,labelFormat,getString("IDS_CR_FOR"),18));
            this.downMenuSprite.addChild(createTextField(458,196,50,labelFormat,getString("IDS_GAME_MONEY"),18));
            this.downMenuSprite.addUIChild(createInput(212,196,100,20,this.ownGoldMoney));
            this.downMenuSprite.addUIChild(createInput(355,196,100,20,this.ownGameMoney));
            this.downMenuSprite.addUIChild(createTextButton(489,195,getString("IDS_DEL_EXCH"),this.handleDelExchange,0,BUTTON_BIG));
         }
      }
      
      public function parseExchangeAdded(param1:Array) : void
      {
         gameMoney = param1[1];
         ownYear = param1[2];
         ownMonth = param1[3];
         ownDay = param1[4];
         ownGoldMoney = param1[5];
         ownGameMoney = param1[6];
         this.createDownMenu();
         this.updateMoney();
      }
      
      private function handleDelExchange(param1:Object) : void
      {
         this.socket.sendDeleteFromExchange();
         gameMoney += this.ownGameMoney;
         ownYear = 0;
         ownMonth = 0;
         ownDay = 0;
         ownGameMoney = 0;
         ownGoldMoney = 0;
         this.createDownMenu();
         this.updateMoney();
      }
      
      private function handleSendExchange(param1:Object) : void
      {
         var gameAmount:int = int(this.gmTF.text);
         var amountWithCommission:int = this.getInt15(gameAmount);
         var credits:int = int(this.credsTF.text);
         if(credits == 0)
         {
            showNotifyMenu(getString("IDS_EXCH_ERROR_0"));
            return;
         }
         if(amountWithCommission == 0)
         {
            showNotifyMenu(getString("IDS_EXCH_ERROR_1"));
            return;
         }
         if(int(gameAmount * 100 / credits) < this.adminCourse)
         {
            showNotifyMenu(getString("IDS_COURSE_WARN_0") + " " + this.adminCourse / 100 + " " + getString("IDS_COURSE_WARN_1") + " " + credits + " " + getString("IDS_COURSE_WARN_2") + " " + int(Math.ceil(credits * this.adminCourse / 100)) + getString("IDS_COURSE_WARN_3"));
            return;
         }
         this.socket.sendAddToExchange(credits,amountWithCommission);
      }
      
      private function getInt15(param1:int) : int
      {
         return int(Math.ceil(param1 + param1 * EXCHANGE_COMISSION));
      }
      
      private function getInt27(param1:int) : int
      {
         return int(Math.ceil(param1 / (1 + EXCHANGE_COMISSION)));
      }
      
      protected function handleGMKeyDown(param1:Event) : void
      {
         var gameAmount:int = int(this.gmTF.text);
         this.resultGmTF.text = this.getInt15(gameAmount).toString();
      }
      
      private function handleInfoPress(param1:Object) : void
      {
         this.socket.getCharInfo(param1.value);
      }
      
      private function createInfoButton(param1:int, param2:int, param3:int, param4:Object) : BaseButton
      {
         var button:BaseButton = new ImageButton(this.handleInfoPress);
         button.y = param2;
         button.x = param1;
         button.value = param3;
         this.itemButtons.push(button);
         return button;
      }
      
      public function parseMenuItems(param1:Array, param2:int) : void
      {
         this.disposeItemsButtons();
         itemData = new Array();
         var nameFormat:TextFormat = new TextFormat();
         nameFormat.font = "Verdana";
         nameFormat.color = 13408825;
         nameFormat.size = 10;
         nameFormat.bold = true;
         var centerFormat:TextFormat = new TextFormat();
         centerFormat.font = "Verdana";
         centerFormat.color = 13408825;
         centerFormat.size = 10;
         centerFormat.align = TextFormatAlign.CENTER;
         var smallFormat:TextFormat = new TextFormat();
         smallFormat.font = "Verdana";
         smallFormat.color = 13408825;
         smallFormat.size = 10;
         pagesCount = param1[param2];
         curPage = param1[param2 + 1];
         var rowBackground:Sprite;
         var nameField:TextField;
         var offer:Object;
         var button:BaseButton;
         var remainingOffers:int = param1[param2 + 2];
         param2 += 3;
         var rowIndex:int = 0;
         var gameAmount:int;
         var includeAdminOffer:Boolean = curPage == 0;
         while(remainingOffers > 0 || includeAdminOffer)
         {
            if(includeAdminOffer)
            {
               offer = {
                  "id":0,
                  "year":120,
                  "month":0,
                  "day":1,
                  "userId":0,
                  "userLogin":getString("IDS_ADMINISTRATION"),
                  "goldMoney":this.adminGoldMoney,
                  "gameMoney":this.getInt15(this.adminGameMoney)
               };
               includeAdminOffer = false;
            }
            else
            {
               offer = {
                  "id":int(param1[param2]),
                  "year":int(param1[param2 + 1]),
                  "month":int(param1[param2 + 2]),
                  "day":int(param1[param2 + 3]),
                  "userId":int(param1[param2 + 4]),
                  "userLogin":param1[param2 + 5],
                  "goldMoney":int(param1[param2 + 6]),
                  "gameMoney":int(param1[param2 + 7])
               };
               remainingOffers--;
               param2 += 8;
            }
            this.itemData.push(offer);
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,607,16);
            rowBackground.y = rowIndex * 18;
            this.scrollSprite.addLine(rowBackground);
            nameField = createTextField(12,rowIndex * 18,200,nameFormat,offer.userLogin,18);
            this.scrollSprite.addLine(nameField);
            if(offer.userId != 0)
            {
               button = this.createInfoButton(nameField.x + Math.ceil(nameField.textWidth) + 5,rowIndex * 18 + 4,offer.userId,this.scrollSprite);
               this.scrollSprite.addContent(button);
            }
            gameAmount = this.getInt27(offer.gameMoney);
            this.scrollSprite.addLine(createTextField(120,rowIndex * 18,96,centerFormat,this.getDateStr(offer.year,offer.month,offer.day),18));
            this.scrollSprite.addLine(createTextField(205,rowIndex * 18,116,centerFormat,offer.goldMoney.toString(),18));
            this.scrollSprite.addLine(createTextField(321,rowIndex * 18,116,centerFormat,gameAmount.toString(),18));
            this.scrollSprite.addLine(createTextField(426,rowIndex * 18,96,centerFormat,(int(gameAmount / offer.goldMoney * 100) / 100).toString(),18));
            if(offer.userId != Main.UserCharacter.userId)
            {
               button = createTextButton(500,2 + rowIndex * 18,getString("IDS_EXCH_BUY_CREDS"),this.buySlot,rowIndex,BUTTON_SMALL_BWIDTH,this.scrollSprite);
               this.scrollSprite.addContent(button);
            }
            rowIndex++;
         }
         this.scrollSprite.init(rowIndex * 18);
         addChild(createTextField(5,153,200,nameFormat,getString("IDS_PAGES"),18));
         createPageButtons(this.pageButtonsSprite,153,70);
      }
      
      private function handleBuySlot(param1:Object) : void
      {
         if(this.goldMoney < this.itemData[this.selectedSlot].goldMoney)
         {
            showNotifyMenu(getString("IDS_GPAY_ERROR_0"));
            return;
         }
         this.socket.sendUnlockCell(this.itemData[this.selectedSlot].id);
         goldMoney -= this.itemData[this.selectedSlot].goldMoney;
         gameMoney += this.getInt27(this.itemData[this.selectedSlot].gameMoney);
         this.updateMoney();
      }
      
      private function buySlot(param1:Object) : void
      {
         selectedSlot = param1.value;
         var gameAmount:int = this.getInt27(this.itemData[param1.value].gameMoney);
         showWarningMenu(formatString("IDS_EXCH_WARN",this.itemData[param1.value].goldMoney,gameAmount),this.handleBuySlot);
      }
      
      private function pageHandler(param1:Object) : void
      {
         this.socket.sendExtendCell(param1.value);
      }
      
      override protected function addPageButton(param1:int, param2:int, param3:int) : int
      {
         var normalFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 10;
         var alternateFormat:TextFormat = new TextFormat();
         alternateFormat.font = "Verdana";
         alternateFormat.color = 10187041;
         alternateFormat.size = 10;
         var normalSprite:Sprite = new Sprite();
         var pageLabel:TextField = createTextField(0,0,0,alternateFormat,(param1 + 1).toString(),18);
         pageLabel.width = pageLabel.textWidth + 3;
         normalSprite.addChild(pageLabel);
         var alternateSprite:Sprite = new Sprite();
         pageLabel = createTextField(0,0,0,normalFormat,(param1 + 1).toString(),18);
         pageLabel.width = pageLabel.textWidth + 3;
         alternateSprite.addChild(pageLabel);
         var pageButton:BaseButton = new NButton(this.pageHandler,normalSprite,alternateSprite,alternateSprite);
         pageButton.x = param2;
         pageButton.y = param3;
         pageButton.value = param1;
         this.itemButtons.push(pageButton);
         addUIChild(pageButton);
         return param2 + pageLabel.width + 2;
      }
   }
}

