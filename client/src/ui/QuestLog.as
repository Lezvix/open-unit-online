package ui
{
   import ui.buttons.*;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import game.Client;
   
   public class QuestLog extends NuclearMenu
   {
      
      private static var QLOG_WIDTH:int = 683;
      
      private static var QLOG_HEIGHT:int = 404;
      
      private static const TAB_QUESTS:int = 0;
      
      private static const TAB_JOB:int = 1;
      
      private static const TAB_FINISHED:int = 2;
      
      private static const TAB_COUNT:int = 3;
      
      private var main:Main;
      
      private var menuName:TextField;
      
      private var questText:TextField;
      
      private var questName:TextField;
      
      private var questScroll:ScrollSprite;
      
      private var logSprite:ScrollSprite;
      
      private var questButtonsText:Array;
      
      private var questTexts:Array;
      
      private var textButtons:Array;
      
      private var placeArray:Array;
      
      private var levelPlaceArray:Array;
      
      private var privateHireArray:Array;
      
      private var ownKillArray:Array;
      
      private var levelQuestButtonsText:Array;
      
      private var levelQuestTexts:Array;
      
      private var finishQuestButtonsText:Array;
      
      private var finishQuestTexts:Array;
      
      private var selectedIdx:int = -1;
      
      private var currentTargetSprite:NUIComponent;
      
      private var selectTargetSprite:NUIComponent;
      
      private var privateHireSprite:NUIComponent;
      
      private var currentTargetText:TextField;
      
      private var currentTargetQuestText:TextField;
      
      private var selectTargetText:TextField;
      
      private var currentTargetBtn:NButton;
      
      private var selectTargetBtn:NButton;
      
      private var removePrivateHireBtn:NButton;
      
      private var questTabButtons:Object = {};
      
      private var selectedTab:int = 0;
      
      public function QuestLog(main:Main)
      {
         this.width = QLOG_WIDTH;
         this.height = QLOG_HEIGHT;
         this.main = main;
         fillBg(4,4,QLOG_WIDTH - 8,QLOG_HEIGHT - 8);
         var vertTile:Bitmap = getBmp("TILE_STATE");
         var horTile:Bitmap = getBmp("INV_QUICK_P_CENTER");
         var tileLeft:Bitmap = getBmp("INV_QUICK_P_LEFT");
         var tileRight:Bitmap = getBmp("INV_QUICK_P_RIGHT");
         var tileNiz:Bitmap = getBmp("QL_NIZ");
         var tileVerh:Bitmap = getBmp("QL_VERH");
         drawTile(vertTile,246,41,vertTile.width,281);
         drawTile(horTile,0,41,QLOG_WIDTH,horTile.height);
         drawTile(horTile,0,322,QLOG_WIDTH,horTile.height);
         drawFrame(0,0,QLOG_WIDTH,QLOG_HEIGHT);
         draw(tileLeft,8,41);
         draw(tileLeft,8,322);
         draw(tileRight,QLOG_WIDTH - 12,41);
         draw(tileRight,QLOG_WIDTH - 12,322);
         draw(tileVerh,246,41);
         draw(tileNiz,246,322);
         draw(bitmap16,296,277);
         draw(bitmap16,164,355);
         function onTabClick(param1:ContentTabButton):void
         {
            questTabButtons[selectedTab].Selected = false;
            param1.Selected = true;
            selectedTab = int(param1.value);
            updateMenu();
         }
         var tabButton:ContentTabButton = new ContentTabButton(_("IDS_QUESTS"),120,onTabClick);
         tabButton.value = TAB_QUESTS;
         tabButton.Selected = true;
         tabButton.setPos(14,13);
         addUIChild(tabButton);
         this.questTabButtons[TAB_QUESTS] = tabButton;
         tabButton = new ContentTabButton(_("IDS_JOBS"),120,onTabClick);
         tabButton.value = TAB_JOB;
         tabButton.setPos(14 + 121,13);
         addUIChild(tabButton);
         this.questTabButtons[TAB_JOB] = tabButton;
         tabButton = new ContentTabButton(_("IDS_COMPLETED"),120,onTabClick);
         tabButton.value = TAB_FINISHED;
         tabButton.setPos(14 + 121 * 2,13);
         addUIChild(tabButton);
         this.questTabButtons[TAB_FINISHED] = tabButton;
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = 13408563;
         format.size = 12;
         format.bold = true;
         format.align = TextFormatAlign.CENTER;
         var tf11:TextFormat = new TextFormat();
         tf11.font = "Verdana";
         tf11.color = 13408563;
         tf11.size = 11;
         var tf11Right:TextFormat = new TextFormat();
         tf11Right.font = "Verdana";
         tf11Right.color = 13408563;
         tf11Right.size = 11;
         tf11Right.align = TextFormatAlign.RIGHT;
         var tf11Bold:TextFormat = new TextFormat();
         tf11Bold.font = "Verdana";
         tf11Bold.color = 13408563;
         tf11Bold.size = 11;
         tf11Bold.bold = true;
         var tf11BoldCenter:TextFormat = new TextFormat();
         tf11BoldCenter.font = "Verdana";
         tf11BoldCenter.color = 13408563;
         tf11BoldCenter.size = 11;
         tf11BoldCenter.bold = true;
         tf11BoldCenter.align = TextFormatAlign.CENTER;
         this.menuName = new TextField();
         this.menuName.defaultTextFormat = format;
         this.menuName.x = 400;
         this.menuName.y = 17;
         this.menuName.width = 200;
         this.menuName.text = getString("IDS_QUEST_LOG");
         addChild(this.menuName);
         this.questName = new TextField();
         this.questName.defaultTextFormat = format;
         this.questName.x = 251;
         this.questName.y = 60;
         this.questName.width = 400;
         this.questName.text = "";
         addChild(this.questName);
         addDefaultCloseButton(643,16);
         this.questScroll = new ScrollSprite(228,255);
         this.questScroll.x = 11;
         this.questScroll.y = 63;
         addUIChild(this.questScroll);
         this.logSprite = new ScrollSprite(396,191);
         this.logSprite.x = 270;
         this.logSprite.y = 81;
         addUIChild(this.logSprite);
         var questFormat:TextFormat = new TextFormat();
         questFormat.font = "Verdana";
         questFormat.color = 13408563;
         questFormat.size = 12;
         questFormat.bold = false;
         questFormat.align = "left";
         questFormat.underline = false;
         this.questText = new TextField();
         this.questText.defaultTextFormat = questFormat;
         this.questText.x = 0;
         this.questText.y = 0;
         this.questText.width = 382;
         this.questText.wordWrap = true;
         this.questText.multiline = true;
         this.logSprite.addLine(this.questText);
         this.logSprite.init();
         this.currentTargetSprite = new NUIComponent();
         this.currentTargetSprite.x = 0;
         this.currentTargetSprite.y = 0;
         addUIChild(this.currentTargetSprite);
         this.currentTargetSprite.visible = false;
         this.currentTargetSprite.addChild(createTextField(0,338,QLOG_WIDTH,tf11BoldCenter,getString("IDS_CURRENT_TARGET"),18));
         this.currentTargetText = createTextField(88,374,250,tf11Bold,"",18);
         this.currentTargetQuestText = createTextField(88,357,250,tf11Bold,"",18);
         this.currentTargetSprite.addChild(this.currentTargetQuestText);
         this.currentTargetSprite.addChild(this.currentTargetText);
         this.currentTargetSprite.addChild(createTextField(20,358,61,tf11Right,getString("IDS_QUEST_NAME"),18));
         this.currentTargetSprite.addChild(createTextField(20,373,51,tf11Right,getString("IDS_OBJECT"),18));
         this.currentTargetBtn = createButton(569,347,0,getBmp("UKAZ_OFF"),getBmp("UKAZ_OFF_OVER"),getBmp("UKAZ_OFF_PRESSED"),this.dropCurrentTarget);
         this.currentTargetBtn.visible = false;
         this.currentTargetSprite.addUIChild(this.currentTargetBtn);
         this.selectTargetSprite = new NUIComponent();
         addUIChild(this.selectTargetSprite);
         this.privateHireSprite = new NUIComponent();
         addUIChild(this.privateHireSprite);
         this.selectTargetSprite.visible = false;
         this.privateHireSprite.visible = false;
         this.selectTargetSprite.addChild(createTextField(272,285,250,tf11,getString("IDS_AVAIBLE_TARGET"),18));
         this.selectTargetText = createTextField(272,302,250,tf11Bold,"",18);
         this.selectTargetSprite.addChild(this.selectTargetText);
         this.selectTargetBtn = createButton(569,283,0,getBmp("UKAZ_ON"),getBmp("UKAZ_ON_OVER"),getBmp("UKAZ_ON_PRESSED"),this.selectTargetHandler);
         this.selectTargetBtn.visible = false;
         this.selectTargetBtn.enabled = false;
         this.selectTargetSprite.addUIChild(this.selectTargetBtn);
         this.removePrivateHireBtn = createButton(569,283,0,getBmp("HIRE_CANCEL"),getBmp("HIRE_CANCEL_OVER"),getBmp("HIRE_CANCEL_PRESSED"),this.removePrivateHire);
         this.removePrivateHireBtn.visible = false;
         this.removePrivateHireBtn.enabled = false;
         this.privateHireSprite.addUIChild(this.removePrivateHireBtn);
      }
      
      private function removePrivateHire(button:Object) : void
      {
         this.main.socket.sendLeavePrivateHire(button.value);
      }
      
      private function updateMenu() : void
      {
         switch(this.selectedTab)
         {
            case TAB_QUESTS:
               this.addButtons(this.questButtonsText);
               break;
            case TAB_JOB:
               this.addButtons(this.levelQuestButtonsText);
               break;
            case TAB_FINISHED:
               this.addButtons(this.finishQuestButtonsText);
               break;
         }
      }
      
      private function dropCurrentTarget(sender:Object) : void
      {
         this.main.resetQuestTarget();
         this.updateCurrentTarget();
      }
      
      private function selectTargetHandler(sender:Object) : void
      {
         if(this.selectedIdx >= 0)
         {
            Client.settings["selectedI"] = -1;
            Client.settings["selectedJ"] = -1;
            Client.settings["selectedLev"] = -1;
            switch(this.selectedTab)
            {
               case TAB_QUESTS:
                  this.main.selectQuestTarget(this.placeArray[this.selectedIdx].questId);
                  break;
               case TAB_JOB:
                  this.main.selectQuestTarget(this.levelPlaceArray[this.selectedIdx].questId);
                  break;
            }
            this.updateCurrentTarget();
         }
      }
      
      private function updateCurrentTarget() : void
      {
         var questIndex:int = 0;
         this.currentTargetBtn.visible = false;
         this.currentTargetBtn.enabled = false;
         this.currentTargetSprite.visible = false;
         this.removePrivateHireBtn.visible = false;
         this.removePrivateHireBtn.enabled = false;
         this.privateHireSprite.visible = false;
         questIndex = 0;
         while(questIndex < this.placeArray.length)
         {
            if(this.placeArray[questIndex].questId == Client.settings["questId"])
            {
               if(this.placeArray[questIndex].placeI != 0 || this.placeArray[questIndex].placeJ != 0)
               {
                  this.currentTargetText.text = this.placeArray[questIndex].placeName;
                  this.currentTargetQuestText.text = this.questButtonsText[questIndex];
                  this.currentTargetSprite.visible = true;
                  this.currentTargetBtn.visible = true;
                  this.currentTargetBtn.enabled = true;
               }
               return;
            }
            questIndex++;
         }
         questIndex = 0;
         while(questIndex < this.levelPlaceArray.length)
         {
            if(this.levelPlaceArray[questIndex].questId == Client.settings["questId"])
            {
               if(this.levelPlaceArray[questIndex].placeI != 0 || this.levelPlaceArray[questIndex].placeJ != 0)
               {
                  this.currentTargetText.text = this.levelPlaceArray[questIndex].placeName;
                  this.currentTargetQuestText.text = this.levelQuestButtonsText[questIndex];
                  this.currentTargetSprite.visible = true;
                  this.currentTargetBtn.visible = true;
                  this.currentTargetBtn.enabled = true;
               }
               return;
            }
            questIndex++;
         }
      }
      
      public function createQuestLog(fields:Array) : void
      {
         var playerLogin:String = this.main.userCharacter.login;
         var entryCount:int = fields[1];
         textButtons = new Array();
         questButtonsText = new Array();
         questTexts = new Array();
         placeArray = new Array();
         levelQuestButtonsText = new Array();
         levelQuestTexts = new Array();
         levelPlaceArray = new Array();
         privateHireArray = new Array();
         finishQuestButtonsText = new Array();
         finishQuestTexts = new Array();
         ownKillArray = new Array();
         var remainingDetails:int;
         var fieldIndex:int = 2;
         while(entryCount > 0)
         {
            this.questButtonsText.push(fields[fieldIndex + 1].replace("*НИК*",playerLogin));
            this.questTexts.push(fields[fieldIndex + 2].replace("*НИК*",playerLogin));
            this.placeArray.push({
               "questId":int(fields[fieldIndex]),
               "placeName":fields[fieldIndex + 3],
               "placeI":int(fields[fieldIndex + 4]),
               "placeJ":int(fields[fieldIndex + 5]),
               "placeLev":int(fields[fieldIndex + 6])
            });
            remainingDetails = fields[fieldIndex + 7];
            fieldIndex += 8;
            while(remainingDetails > 0)
            {
               fieldIndex += 2;
               remainingDetails--;
            }
            entryCount--;
         }
         entryCount = fields[fieldIndex];
         fieldIndex++;
         while(entryCount > 0)
         {
            this.levelQuestButtonsText.push(fields[fieldIndex + 1].replace("*НИК*",playerLogin));
            this.levelQuestTexts.push(fields[fieldIndex + 2].replace("*НИК*",playerLogin));
            this.levelPlaceArray.push({
               "questId":int(fields[fieldIndex]),
               "placeName":fields[fieldIndex + 3],
               "placeI":int(fields[fieldIndex + 4]),
               "placeJ":int(fields[fieldIndex + 5]),
               "placeLev":int(fields[fieldIndex + 6])
            });
            fieldIndex += 7;
            entryCount--;
         }
         entryCount = fields[fieldIndex];
         fieldIndex++;
         while(entryCount > 0)
         {
            descriptionId = fields[fieldIndex + 1];
            description = _("FQD_" + descriptionId);
            if(description)
            {
               this.finishQuestButtonsText.push(fields[fieldIndex]);
               this.finishQuestTexts.push(description);
            }
            fieldIndex += 2;
            entryCount--;
         }
         entryCount = fields[fieldIndex];
         fieldIndex++;
         while(entryCount > 0)
         {
            this.questButtonsText.push(getString("IDS_QL_PRIVATE_HIRE").replace("%s",fields[fieldIndex + 2]));
            this.questTexts.push(getString("IDS_QL_PRIVATE_HIRE_DESC").replace("%s1",fields[fieldIndex + 2]).replace("%s2",fields[fieldIndex + 3]).replace("%s3",fields[fieldIndex + 4]));
            this.privateHireArray.push({
               "requestId":int(fields[fieldIndex]),
               "userId":int(fields[fieldIndex + 1]),
               "userLogin":fields[fieldIndex + 2]
            });
            fieldIndex += 5;
            entryCount--;
         }
         var unused:String;
         var usersById:Dictionary = new Dictionary();
         entryCount = fields[fieldIndex];
         fieldIndex++;
         while(entryCount > 0)
         {
            usersById[int(fields[fieldIndex])] = {
               "userId":int(fields[fieldIndex]),
               "userLogin":fields[fieldIndex + 1]
            };
            fieldIndex += 2;
            entryCount--;
         }
         entryCount = 0;
         var userNames:String = "";
         var user:Object;
         var descriptionId:int;
         var description:String;
         for each(user in usersById)
         {
            if(userNames != "")
            {
               userNames += ", ";
            }
            userNames += user.userLogin;
            this.ownKillArray.push(user);
            entryCount++;
         }
         if(entryCount > 0)
         {
            this.questButtonsText.push(getString("IDS_QL_YOUR_KILL"));
            this.questTexts.push(getString("IDS_QL_YOUR_KILL_DESC").replace("%s",userNames));
         }
         this.updateMenu();
         this.updateCurrentTarget();
      }
      
      private function drawThinFrame(posX:int, posY:int, frameWidth:int, frameHeight:int) : void
      {
         var tile01:Bitmap = getBmp("TILE_01");
         var tile02:Bitmap = getBmp("TILE_02");
         var tile03:Bitmap = getBmp("TILE_03");
         var tile04:Bitmap = getBmp("TILE_04");
         var tile05:Bitmap = getBmp("TILE_05");
         var tile06:Bitmap = getBmp("TILE_06");
         var tile07:Bitmap = getBmp("TILE_07");
         var tile08:Bitmap = getBmp("TILE_08");
         draw(tile01,posX,posY);
         drawTile(tile02,posX + tile01.width,posY,frameWidth - tile01.width - tile03.width,tile02.height);
         draw(tile03,posX + frameWidth - tile01.width * 2,posY);
         drawTile(tile04,posX + frameWidth - tile01.width - tile03.width,posY + tile03.height,tile04.width,frameHeight - tile05.height);
         draw(tile05,posX + frameWidth - tile01.width * 2,posY + frameHeight);
         drawTile(tile06,posX,posY + frameHeight,frameWidth - tile01.width - tile03.width,tile02.height);
         draw(tile07,posX,posY + frameHeight);
         drawTile(tile08,posX,posY + tile01.height,tile08.width,frameHeight - tile01.height);
      }
      
      public function addButtons(titles:Array) : void
      {
         var oldButton:TextLinkButton;
         var rowY:int;
         var questIndex:int;
         for each(oldButton in this.textButtons)
         {
            this.questScroll.uiContainer.removeUIChild(oldButton);
         }
         textButtons = new Array();
         this.questName.text = "";
         this.questText.text = "";
         this.logSprite.init(-1);
         this.selectTargetBtn.visible = false;
         this.selectTargetBtn.enabled = false;
         this.selectTargetSprite.visible = false;
         this.removePrivateHireBtn.visible = false;
         this.removePrivateHireBtn.enabled = false;
         this.privateHireSprite.visible = false;
         selectedIdx = -1;
         rowY = 0;
         questIndex = 0;
         while(questIndex < titles.length)
         {
            var questButton:TextLinkButton = new TextLinkButton(this.textButtonHandler,titles[questIndex],215,12);
            questButton.value = questIndex;
            questButton.x = 7;
            questButton.y = rowY;
            rowY += questButton.height - 3;
            this.textButtons.push(questButton);
            this.questScroll.addContent(questButton);
            questIndex++;
         }
         this.questScroll.init(rowY);
      }
      
      private function textButtonHandler(button:Object) : void
      {
         switch(this.selectedTab)
         {
            case TAB_QUESTS:
               this.selectTargetBtn.visible = false;
               this.selectTargetSprite.visible = false;
               this.selectTargetBtn.enabled = false;
               this.questName.text = this.questButtonsText[button.value];
               this.questText.text = this.questTexts[button.value];
               this.questText.height = this.questText.textHeight + 5;
               this.logSprite.init(this.questText.height + this.questText.y);
               selectedIdx = button.value;
               if(this.selectedIdx >= this.placeArray.length)
               {
                  if(this.selectedIdx < this.placeArray.length + this.privateHireArray.length)
                  {
                     this.removePrivateHireBtn.visible = true;
                     this.privateHireSprite.visible = true;
                     this.removePrivateHireBtn.enabled = true;
                     this.removePrivateHireBtn.value = this.privateHireArray[this.selectedIdx - this.placeArray.length].requestId;
                  }
               }
               else
               {
                  this.removePrivateHireBtn.visible = false;
                  this.removePrivateHireBtn.enabled = false;
                  this.privateHireSprite.visible = false;
                  if(this.placeArray[this.selectedIdx].placeI != 0 || this.placeArray[this.selectedIdx].placeJ != 0)
                  {
                     this.selectTargetText.text = this.placeArray[this.selectedIdx].placeName;
                     this.selectTargetBtn.visible = true;
                     this.selectTargetSprite.visible = true;
                     this.selectTargetBtn.enabled = true;
                  }
                  else
                  {
                     this.selectTargetBtn.visible = false;
                     this.selectTargetSprite.visible = false;
                     this.selectTargetBtn.enabled = false;
                  }
               }
               break;
            case TAB_JOB:
               this.removePrivateHireBtn.visible = false;
               this.removePrivateHireBtn.enabled = false;
               this.privateHireSprite.visible = false;
               this.questName.text = this.levelQuestButtonsText[button.value];
               this.questText.text = this.levelQuestTexts[button.value];
               this.questText.height = this.questText.textHeight + 5;
               this.logSprite.init(this.questText.height + this.questText.y);
               selectedIdx = button.value;
               if(this.levelPlaceArray[this.selectedIdx].placeI != 0 || this.levelPlaceArray[this.selectedIdx].placeJ != 0)
               {
                  this.selectTargetText.text = this.levelPlaceArray[this.selectedIdx].placeName;
                  this.selectTargetBtn.visible = true;
                  this.selectTargetBtn.enabled = true;
                  this.selectTargetSprite.visible = true;
               }
               else
               {
                  this.selectTargetBtn.visible = false;
                  this.selectTargetSprite.visible = false;
                  this.selectTargetBtn.enabled = false;
               }
               break;
            case TAB_FINISHED:
               this.questName.text = this.finishQuestButtonsText[button.value];
               this.questText.text = this.finishQuestTexts[button.value];
               this.questText.height = this.questText.textHeight + 5;
               this.logSprite.init(this.questText.height + this.questText.y);
               this.removePrivateHireBtn.visible = false;
               this.removePrivateHireBtn.enabled = false;
               this.privateHireSprite.visible = false;
               this.selectTargetBtn.visible = false;
               this.selectTargetSprite.visible = false;
               this.selectTargetBtn.enabled = false;
               break;
         }
      }
   }
}

