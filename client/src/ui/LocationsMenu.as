package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.Chat;
   import mx.utils.StringUtil;
   
   public class LocationsMenu extends NuclearMenu
   {
      
      public static const ATTACK_AS_DEFAULT:int = 0;
      
      public static const ATTACK_AS_ATTACKER:int = 1;
      
      public static const ATTACK_AS_DEFENDER:int = 2;
      
      public static const ATTACK_AS_SPECTATOR:int = 3;
      
      public static var LOCATIONS_MENU_WIDTH:int = 625;
      
      public static var LOCATIONS_MENU_HEIGHT:int = 336;
      
      public static var TYPE_QUEST_LOCATIONS:int = 0;
      
      public static var TYPE_ATTACK_ZONES:int = 1;
      
      public static var TYPE_ATTACK_REQUESTS:int = 2;
      
      private static const LOCATIONS_X:int = 9;
      
      private static const LOCATIONS_Y:int = 34;
      
      private static const LOCATIONS_WIDTH:int = 422;
      
      private static const LOCATIONS_HEIGHT:int = 154;
      
      private static const LOCATIONS_ATTACK_HEIGHT:int = 82;
      
      private static var RIGHT_SCROLL_X:int = 9;
      
      private static var RIGHT_SCROLL_Y:int = 173;
      
      private static var RIGHT_SCROLL_WIDTH:int = 422;
      
      private static var RIGHT_SCROLL_HEIGHT:int = 70;
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var locationIds:Array;
      
      private var attackAs:Array;
      
      private var timeVals:Array;
      
      private var zones:Array;
      
      private var questIds:Array;
      
      private var eventTexts:Array;
      
      private var checks:Array;
      
      private var type:int;
      
      private var selAttackId:int = -1;
      
      private var selAttackAs:int = -1;
      
      private var locScrollSprite:ScrollSprite;
      
      private var participantsList:ScrollSprite;
      
      private var rightScrollSprite:ScrollSprite;
      
      private var locButtons:Array;
      
      private var rightButtons:Array;
      
      private var participantsButtons:Array;
      
      private var selectedLoc:int = -1;
      
      private var selectedRight:int = -1;
      
      private var selectedParticipant:int = -1;
      
      private var timeInterval:int = -1;
      
      public var dataLoaded:Boolean = false;
      
      private var canSpectator:Boolean = false;
      
      private var checkedId:int = -1;
      
      private var curAttackAs:int;
      
      private var zoneCount:int;
      
      private var locationsData:Array;
      
      public var requestButtons:Array;
      
      private var auctionMinDelta:int;
      
      private var auctionTimeField:TextField;
      
      private var auctionMoneyField:TextField;
      
      private var auctionMoneyInput:NTextInput;
      
      private var setAuctionButton:BaseButton;
      
      private var auctionInfoText:TextField;
      
      private var clanAuctionZoneId:int;
      
      private var zoneInfoText:TextField;
      
      private var removeUserBtn:BaseButton;
      
      public function LocationsMenu(param1:GameSocket, param2:Terminal, param3:Object, param4:int, param5:Boolean)
      {
         super();
         dragable = false;
         this.type = param4;
         this.socket = param1;
         this.terminal = param2;
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13408825;
         titleFormat.size = 12;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 10;
         switch(param4)
         {
            case TYPE_QUEST_LOCATIONS:
               drawRect(0,0,440,221,13408825);
               drawHLine(4,22,432,13408825);
               drawHLine(4,199,432,13408825);
               drawRect(458,0,167,221,13408825);
               drawHLine(462,23,158,13408825);
               if(!param5)
               {
                  param1.sendLocationsRequest();
               }
               addChild(createTextField(14,3,200,titleFormat,"C:\\" + getString("IDS_QUEST_LOCATIONS"),18));
               addChild(createTextField(474,5,150,labelFormat,getString("IDS_INFO_NA"),18));
               addUIChild(createTextButton(0,230,getString("IDS_GOTO"),this.gotoHandler));
               this.locScrollSprite = new ScrollSprite(LOCATIONS_WIDTH,LOCATIONS_HEIGHT,4);
               this.locScrollSprite.x = LOCATIONS_X;
               this.locScrollSprite.y = LOCATIONS_Y;
               break;
            case TYPE_ATTACK_ZONES:
               drawRect(0,0,440,123,13408825);
               drawHLine(4,22,432,13408825);
               drawRect(0,139,440,111,13408825);
               drawHLine(4,161,432,13408825);
               drawRect(458,0,167,221,13408825);
               drawHLine(462,23,158,13408825);
               if(!param5)
               {
                  param1.sendAttackZonesRequest();
               }
               addChild(createTextField(14,3,200,titleFormat,"C:\\" + getString("IDS_ATTACK_ZONES"),18));
               addChild(createTextField(14,142,200,titleFormat,getString("IDS_ATTACK_ZONE_INFO"),18));
               addChild(createTextField(474,5,150,titleFormat,getString("IDS_AUCTION_INFO"),18));
               this.locScrollSprite = new ScrollSprite(LOCATIONS_WIDTH,LOCATIONS_ATTACK_HEIGHT,4);
               this.locScrollSprite.x = LOCATIONS_X;
               this.locScrollSprite.y = LOCATIONS_Y;
               break;
         }
         addUIChild(this.locScrollSprite);
         addUIChild(createTextButton(526,233,getString("IDS_BACK"),this.closeBtnHandler));
         if(param4 == TYPE_ATTACK_ZONES)
         {
            this.rightScrollSprite = new ScrollSprite(RIGHT_SCROLL_WIDTH,RIGHT_SCROLL_HEIGHT,4);
            this.rightScrollSprite.x = RIGHT_SCROLL_X;
            this.rightScrollSprite.y = RIGHT_SCROLL_Y;
            addUIChild(this.rightScrollSprite);
            this.zoneInfoText = createTextField(0,0,LOCATIONS_WIDTH - 20,titleFormat,"",18,true);
            this.rightScrollSprite.addLine(this.zoneInfoText);
         }
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         this.closeHandler();
      }
      
      private function gotoHandler(param1:Object) : void
      {
         if(this.selectedLoc != -1)
         {
            this.socket.sendStr("sl|" + this.questIds[this.selectedLoc] + "|" + this.locationIds[this.selectedLoc]);
         }
         else
         {
            showNotifyMenu(getString("IDS_GOTO_ERROR"));
         }
      }
      
      private function auctionZoneHandler(param1:Object) : void
      {
         if(this.clanAuctionZoneId > 0)
         {
            showNotifyMenu(StringUtil.substitute(getString("IDS_CLAN_AUCTION_ERROR"),this.auctionMinDelta));
            return;
         }
         if(int(this.auctionMoneyInput.text) >= this.zones[this.selectedLoc].money + this.auctionMinDelta)
         {
            this.socket.sendAuctionRequest(this.zones[this.selectedLoc].zoneId,int(this.auctionMoneyInput.text));
         }
         else
         {
            showNotifyMenu(formatString("IDS_AUCTION_ERROR",this.auctionMinDelta));
         }
      }
      
      override public function createMenu() : void
      {
         create(LOCATIONS_MENU_WIDTH,LOCATIONS_MENU_HEIGHT,false,0);
      }
      
      override public function closeHandler() : void
      {
         if(this.type == TYPE_ATTACK_REQUESTS)
         {
            this.socket.sendExitZonesRequest();
         }
         super.closeHandler();
      }
      
      private function selectLocation(param1:int) : void
      {
         if(this.selectedLoc != -1)
         {
            updateBgUI(this.locButtons[this.selectedLoc].upState,false,408,16,this.locButtons[this.selectedLoc].textField1);
         }
         selectedLoc = param1;
         updateBgUI(this.locButtons[this.selectedLoc].upState,true,408,16,this.locButtons[this.selectedLoc].textField1);
         if(this.type != TYPE_QUEST_LOCATIONS)
         {
            this.updateAuction(true);
         }
      }
      
      private function locationPressHandler(param1:Object) : void
      {
         this.selectLocation(param1.value);
      }
      
      private function createInfoButton(param1:int, param2:int, param3:int, param4:Object) : BaseButton
      {
         var button:BaseButton = new NButton(this.handleInfoPress,getBmp("INFO_BTN"),getBmp("INFO_BTN_OVER"),getBmp("INFO_BTN_PRESSED"));
         button.y = param2;
         button.x = param1;
         button.value = param3;
         return button;
      }
      
      private function handleInfoPress(param1:Object) : void
      {
         this.socket.getCharInfo(param1.value);
      }
      
      private function rightPressHandler(param1:Object) : void
      {
         if(this.selectedRight != -1)
         {
            updateBgUI(this.rightButtons[this.selectedRight].upState,false,140,16,this.rightButtons[this.selectedRight].textField1);
         }
         selectedRight = param1.value;
         updateBgUI(this.rightButtons[this.selectedRight].upState,true,140,16,this.rightButtons[this.selectedRight].textField1);
      }
      
      public function drawAuctionButtons() : void
      {
         drawHLine(470,77,143,13408825);
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.align = TextFormatAlign.RIGHT;
         var centerFormat:TextFormat = new TextFormat();
         centerFormat.font = "Verdana";
         centerFormat.color = 13408825;
         centerFormat.size = 12;
         centerFormat.align = TextFormatAlign.CENTER;
         addChild(createTextField(457,41,167,centerFormat,getString("IDS_AUCTION_END"),18));
         addChild(createTextField(457,83,167,centerFormat,getString("IDS_CURRENT_BIT"),18));
         auctionTimeField = createTextField(457,54,167,centerFormat,"",18);
         addChild(this.auctionTimeField);
         auctionMoneyField = createTextField(457,102,167,centerFormat,"",18);
         addChild(this.auctionMoneyField);
         auctionMoneyInput = createInput(467,140,147,8);
         addUIChild(this.auctionMoneyInput);
         auctionInfoText = createTextField(462,140,157,centerFormat,"",80,true);
         addChild(this.auctionInfoText);
         setAuctionButton = createTextButton(490,169,getString("IDS_MAKE_BIT"),this.auctionZoneHandler,0,0,null,100,37,12);
         addUIChild(this.setAuctionButton);
         timeInterval = setInterval(this.attackTimerHandler,1000);
      }
      
      public function updateAuction(param1:Boolean = false) : void
      {
         var zone:Object = this.zones[this.selectedLoc];
         var secondsLeft:int = (zone.leftTime * 1000 - getTimer() + zone.curTime) / 1000;
         if(secondsLeft <= 0)
         {
            this.auctionTimeField.text = _("IDS_AUCTION_FINISHED");
         }
         else
         {
            this.auctionTimeField.text = Chat.getString56(secondsLeft);
         }
         this.auctionMoneyField.text = formatString("IDS_MONEY_TEMPLATE",zone.money);
         if(this.clanAuctionZoneId >= 0 || zone.deleted)
         {
            this.auctionInfoText.visible = true;
            this.auctionMoneyInput.visible = false;
            this.setAuctionButton.visible = false;
            this.setAuctionButton.isEnabled = false;
         }
         else
         {
            this.auctionInfoText.visible = false;
            this.auctionMoneyInput.visible = true;
            this.setAuctionButton.visible = true;
            this.setAuctionButton.isEnabled = true;
         }
         if(this.clanAuctionZoneId == zone.zoneId)
         {
            this.auctionInfoText.text = getString("IDS_AUCTION_YOUR_MAX_BIT");
         }
         else if(this.clanAuctionZoneId >= 0)
         {
            this.auctionInfoText.text = getString("IDS_CLAN_AUCTION_ERROR");
         }
         else if(zone.deleted)
         {
            this.auctionInfoText.text = getString("IDS_AUCTION_FINISHED");
         }
         else if(param1)
         {
            if(zone.money > 0)
            {
               this.auctionMoneyInput.text = (zone.money + this.auctionMinDelta).toString();
            }
            else
            {
               this.auctionMoneyInput.text = zone.startMoney.toString();
            }
         }
         var previousTextHeight:int = this.zoneInfoText.textHeight;
         this.zoneInfoText.text = "";
         this.zoneInfoText.appendText(formatString("IDS_LOCATION_NAME",zone.zoneName));
         this.zoneInfoText.appendText("\n" + formatString("IDS_LOCATION_REWARD",zone.reward));
         this.zoneInfoText.appendText("\n" + formatString("IDS_LOCATION_LAST_BID",zone.money));
         this.zoneInfoText.appendText("\n" + formatString("IDS_LOCATION_OWNER",zone.ownerClanName));
         this.zoneInfoText.appendText("\n" + formatString("IDS_ZONE_TYPE",zone.type));
         this.zoneInfoText.appendText("\n" + formatString("IDS_ZONE_ASSIGNMENT",zone.type));
         if(previousTextHeight != this.zoneInfoText.textHeight)
         {
            this.zoneInfoText.height = this.zoneInfoText.textHeight + 6;
            this.rightScrollSprite.init(this.zoneInfoText.textHeight + 6);
         }
      }
      
      public function parseDeleteAuction(param1:Array) : void
      {
         var zoneId:int = param1[1];
         var zoneIndex:int = 0;
         while(zoneIndex < this.zones.length)
         {
            if(this.zones[zoneIndex].zoneId == zoneId)
            {
               this.zones[zoneIndex].deleted = true;
               if(this.clanAuctionZoneId == this.zones[zoneIndex].zoneId)
               {
                  clanAuctionZoneId = -1;
               }
               if(zoneIndex == this.selectedLoc)
               {
                  this.updateAuction();
               }
               return;
            }
            zoneIndex++;
         }
      }
      
      public function updateAuctionData(param1:Array) : void
      {
         var zoneId:int = param1[1];
         var bidAmount:int = param1[2];
         var secondsLeft:int = param1[3];
         var isClanBid:Boolean = param1[4] == "1";
         if(isClanBid)
         {
            clanAuctionZoneId = zoneId;
         }
         else if(this.clanAuctionZoneId == zoneId)
         {
            clanAuctionZoneId = -1;
         }
         var zoneIndex:int = 0;
         while(zoneIndex < this.zones.length)
         {
            if(this.zones[zoneIndex].zoneId == zoneId)
            {
               this.zones[zoneIndex].money = bidAmount;
               this.zones[zoneIndex].leftTime = secondsLeft;
               this.zones[zoneIndex].curTime = getTimer();
               this.zones[zoneIndex].deleted = false;
               if(zoneIndex == this.selectedLoc)
               {
                  this.updateAuction();
               }
               return;
            }
            zoneIndex++;
         }
      }
      
      public function parseAttackZones(param1:Array, param2:int) : int
      {
         dataLoaded = true;
         zones = new Array();
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         var centerFormat:TextFormat = new TextFormat();
         centerFormat.font = "Verdana";
         centerFormat.color = 13408825;
         centerFormat.size = 12;
         centerFormat.align = TextFormatAlign.CENTER;
         locButtons = new Array();
         rightButtons = new Array();
         locationIds = new Array();
         questIds = new Array();
         selectedLoc = -1;
         selectedRight = -1;
         var zoneIndex:int = 0;
         auctionMinDelta = param1[param2];
         clanAuctionZoneId = param1[param2 + 1];
         var rowSprite:Sprite;
         var zoneButton:BaseButton;
         var zoneLabel:TextField;
         var remainingZones:int = param1[param2 + 2];
         param2 += 3;
         var currentTime:int = getTimer();
         var zone:Object;
         var ownerClanId:int;
         var clanButton:ClanIconButton;
         if(remainingZones > 0)
         {
            this.drawAuctionButtons();
         }
         while(remainingZones > 0)
         {
            zone = {
               "zoneId":int(param1[param2]),
               "money":int(param1[param2 + 10]),
               "type":int(param1[param2 + 2]),
               "curTime":currentTime,
               "leftTime":int(param1[param2 + 11]),
               "deleted":false,
               "ownerClanName":param1[param2 + 7],
               "zoneName":param1[param2 + 1],
               "reward":int(param1[param2 + 5])
            };
            this.zones.push(zone);
            if(param1[param2 + 9] == "0")
            {
               zone.startMoney = zone.money;
               zone.money = 0;
            }
            rowSprite = new Sprite();
            zoneLabel = createTextField(5,zoneIndex * 18 - 2,400,labelFormat,param1[param2 + 1] + " (" + getString("IDS_COORDS") + ": " + param1[param2 + 3] + ", " + param1[param2 + 4] + ")",18);
            updateBgUI(rowSprite,false,408,16,zoneLabel);
            zoneButton = new NButton(this.locationPressHandler,rowSprite,rowSprite,rowSprite);
            zoneButton.value = zoneIndex;
            zoneButton.x = 0;
            zoneButton.y = zoneIndex * 18;
            zoneButton.textField1 = zoneLabel;
            this.locButtons.push(zoneButton);
            this.locScrollSprite.addContent(zoneButton);
            this.locScrollSprite.addLine(zoneLabel);
            ownerClanId = param1[param2 + 6];
            if(ownerClanId != 0)
            {
               clanButton = new ClanIconButton({
                  "id":ownerClanId,
                  "name":param1[param2 + 7]
               });
               clanButton.x = 387;
               clanButton.y = zoneIndex * 18 + 2;
               this.locScrollSprite.addContent(clanButton);
            }
            zoneIndex++;
            this.locationIds.push(int(param1[param2]));
            param2 += 12;
            remainingZones--;
         }
         if(zoneIndex > 0)
         {
            this.selectLocation(0);
         }
         this.locScrollSprite.init(zoneIndex * 18);
         return param2;
      }
      
      public function attackTimerHandler() : void
      {
         this.updateAuction();
      }
      
      public function timerHandler() : void
      {
         var currentTime:int = getTimer();
         var secondsLeft:int;
         var timeText:String;
         var timerIndex:int = 0;
         while(timerIndex < this.timeVals.length)
         {
            timeText = "";
            secondsLeft = Math.max(0,(this.timeVals[timerIndex] - currentTime) / 1000);
            if(int(secondsLeft / 3600) < 10)
            {
               timeText += "0";
            }
            timeText += int(secondsLeft / 3600) + ":";
            if(int(secondsLeft / 60) % 60 < 10)
            {
               timeText += "0";
            }
            timeText += int(secondsLeft / 60) % 60 + ":";
            if(secondsLeft % 60 < 10)
            {
               timeText += "0";
            }
            timeText += secondsLeft % 60;
            this.eventTexts[timerIndex].text = timeText;
            timerIndex++;
         }
      }
      
      public function parseLocations(param1:Array, param2:int) : int
      {
         dataLoaded = true;
         locationIds = new Array();
         questIds = new Array();
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         locButtons = new Array();
         locationIds = new Array();
         questIds = new Array();
         selectedLoc = -1;
         var locationIndex:int = 0;
         var rowSprite:Sprite;
         var locationButton:BaseButton;
         var locationLabel:TextField;
         while(param2 < param1.length - 1)
         {
            rowSprite = new Sprite();
            locationLabel = createTextField(5,locationIndex * 18 - 2,400,labelFormat,param2.toString() + ". " + param1[param2 + 2] + " (" + getString("IDS_QUEST") + ": " + param1[param2 + 3] + ")",18);
            updateBgUI(rowSprite,false,408,16,locationLabel);
            locationButton = new NButton(this.locationPressHandler,rowSprite,rowSprite,rowSprite);
            locationButton.value = locationIndex;
            locationButton.x = 0;
            locationButton.y = locationIndex * 18;
            locationButton.textField1 = locationLabel;
            this.locButtons.push(locationButton);
            this.locScrollSprite.addContent(locationButton);
            this.locScrollSprite.addLine(locationLabel);
            locationIndex++;
            this.locationIds.push(int(param1[param2]));
            this.questIds.push(int(param1[param2 + 1]));
            param2 += 4;
         }
         this.locScrollSprite.init(locationIndex * 18);
         return param2;
      }
      
      protected function addTextButton(param1:int, param2:int, param3:String) : TextLinkButton
      {
         var button:TextLinkButton = new TextLinkButton(this.clickHandler,param3,100);
         button.value = this.questIds.length;
         button.x = param1;
         button.y = param2;
         addUIChild(button);
         return button;
      }
      
      public function clickHandler(param1:Object) : void
      {
         var locationIndex:int = param1.value;
         this.socket.sendStr("sl|" + this.questIds[locationIndex] + "|" + this.locationIds[locationIndex]);
      }
      
      override public function dispose() : void
      {
         if(this.timeInterval != -1)
         {
            clearInterval(this.timeInterval);
         }
         super.dispose();
      }
   }
}

