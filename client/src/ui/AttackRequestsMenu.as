package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.World;
   
   public class AttackRequestsMenu extends NuclearMenu
   {
      
      public static const ATTACK_AS_DEFAULT:int = 0;
      
      public static const ATTACK_AS_ATTACKER:int = 1;
      
      public static const ATTACK_AS_DEFENDER:int = 2;
      
      public static const ATTACK_AS_SPECTATOR:int = 3;
      
      public static const LOCATIONS_MENU_WIDTH:int = 625;
      
      public static const LOCATIONS_MENU_HEIGHT:int = 336;
      
      private static const LOCATIONS_X:int = 9;
      
      private static const LOCATIONS_Y:int = 34;
      
      private static const LOCATIONS_WIDTH:int = 422;
      
      private static const LOCATIONS_HEIGHT:int = 154;
      
      private var locations:Dictionary = new Dictionary();
      
      private var selectedLocation:Object = null;
      
      private var selectedSide:int = -1;
      
      private var currentLocation:Object = null;
      
      private var currentSide:int = -1;
      
      private var socket:GameSocket;
      
      private var locScrollSprite:ScrollSprite;
      
      private var participantsList:ScrollSprite;
      
      private var checksLabels:Array = new Array();
      
      private var locationsButtons:Array = new Array();
      
      private var participantsButtons:Array;
      
      private var selectedParticipant:int = -1;
      
      private var timeInterval:int = -1;
      
      private var canSpectate:Boolean = false;
      
      private var removeUserBtn:BaseButton;
      
      public var dataLoaded:Boolean = false;
      
      public function AttackRequestsMenu(param1:GameSocket, param2:Terminal, param3:Object, param4:Boolean)
      {
         super();
         dragable = false;
         this.socket = param1;
         var titleFormat:TextFormat = new TextFormat("Verdana",12,13408825);
         var labelFormat:TextFormat = new TextFormat("Verdana",10,13408825);
         drawRect(0,0,440,221,13408825);
         drawHLine(4,22,432,13408825);
         drawHLine(4,199,432,13408825);
         drawRect(458,0,167,221,13408825);
         drawHLine(462,23,158,13408825);
         if(!param4)
         {
            param1.sendAvaibleZonesRequest();
         }
         addChild(createTextField(14,3,200,titleFormat,"C:\\" + _("IDS_ATTACK_REQUESTS"),18));
         addChild(createTextField(470,4,150,labelFormat,_("IDS_PARTICIPANTS"),18));
         addUIChild(createTextButton(0,233,_("IDS_ATTACK_CONNECT"),this.doAction796));
         addUIChild(createTextButton(115,233,_("IDS_ATTACK_REJECT"),this.attackRejectHandler));
         if(Main.UserCharacter.isValue6)
         {
            this.removeUserBtn = createTextButton(411,233,_("IDS_REMOVE_USER"),this.removeUserBtnHandler);
            this.removeUserBtn.enabled = false;
            addUIChild(this.removeUserBtn);
            this.removeUserBtn.visible = false;
         }
         this.locScrollSprite = new ScrollSprite(LOCATIONS_WIDTH,LOCATIONS_HEIGHT,4);
         this.locScrollSprite.x = LOCATIONS_X;
         this.locScrollSprite.y = LOCATIONS_Y;
         this.participantsList = new ScrollSprite(150,180,4);
         this.participantsList.x = 466;
         this.participantsList.y = 32;
         addUIChild(this.participantsList);
         addUIChild(this.locScrollSprite);
         addUIChild(createTextButton(526,233,_("IDS_BACK"),this.closeBtnHandler));
      }
      
      private static function createInfoButton(param1:int, param2:int, param3:int) : NButton
      {
         var button:UserInfoButton = new UserInfoButton(param3);
         button.y = param2;
         button.x = param1;
         return button;
      }
      
      private function removeUserBtnHandler(param1:Object) : void
      {
         this.socket.sendAttackReject(param1.value);
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         this.closeHandler();
      }
      
      private function doAction796(param1:Object) : void
      {
         var location:Object = null;
         if(this.selectedLocation)
         {
            location = this.selectedLocation;
            switch(this.selectedSide)
            {
               case ATTACK_AS_ATTACKER:
                  if(location.participants[0].currentCount >= location.participants[0].maxCount)
                  {
                     showNotifyMenu(_("IDS_TOO_MANY_PARTICIPANTS"));
                  }
                  else if(this.currentLocation == location && this.currentSide == ATTACK_AS_ATTACKER)
                  {
                     showNotifyMenu(_("IDS_JOINED_ALREADY"));
                  }
                  else
                  {
                     this.socket.doAction567(location.id,ATTACK_AS_ATTACKER);
                  }
                  break;
               case ATTACK_AS_DEFENDER:
                  if(location.participants[1].currentCount >= location.participants[1].maxCount)
                  {
                     showNotifyMenu(_("IDS_TOO_MANY_PARTICIPANTS"));
                  }
                  else if(this.currentLocation == location && this.currentSide == ATTACK_AS_DEFENDER)
                  {
                     showNotifyMenu(_("IDS_JOINED_ALREADY"));
                  }
                  else
                  {
                     this.socket.doAction567(location.id,ATTACK_AS_DEFENDER);
                  }
                  break;
               case ATTACK_AS_DEFAULT:
                  if(Main.UserCharacter.clanId == location.attackingClanId || Main.UserCharacter.hireClanId == location.attackingClanId && Main.UserCharacter.clanId != location.ownerClanId)
                  {
                     if(location.participants[0].currentCount >= location.participants[0].maxCount)
                     {
                        showNotifyMenu(_("IDS_TOO_MANY_PARTICIPANTS"));
                     }
                     else if(this.currentLocation == location && this.currentSide == ATTACK_AS_ATTACKER)
                     {
                        showNotifyMenu(_("IDS_JOINED_ALREADY"));
                     }
                     else
                     {
                        this.socket.doAction567(location.id,ATTACK_AS_ATTACKER);
                     }
                  }
                  else if(Main.UserCharacter.clanId != 0 && Main.UserCharacter.clanId == location.ownerClanId || Main.UserCharacter.hireClanId != 0 && Main.UserCharacter.hireClanId == location.ownerClanId)
                  {
                     if(location.participants[1].currentCount < location.participants[1].maxCount)
                     {
                        this.socket.doAction567(location.id,ATTACK_AS_DEFENDER);
                     }
                     else if(this.currentLocation == location && this.currentSide == ATTACK_AS_DEFENDER)
                     {
                        showNotifyMenu(_("IDS_JOINED_ALREADY"));
                     }
                     else
                     {
                        showNotifyMenu(_("IDS_TOO_MANY_PARTICIPANTS"));
                     }
                  }
                  break;
               case ATTACK_AS_SPECTATOR:
                  if(this.currentLocation == location && this.currentSide == ATTACK_AS_SPECTATOR)
                  {
                     showNotifyMenu(_("IDS_JOINED_ALREADY"));
                  }
                  else if(this.canSpectate)
                  {
                     this.socket.doAction567(location.id,ATTACK_AS_SPECTATOR);
                  }
                  break;
               default:
                  break;
            }
         }
         else
         {
            showNotifyMenu(_("IDS_SELECT_ATTACK"));
         }
      }
      
      private function attackRejectHandler(param1:Object) : void
      {
         if(this.currentLocation)
         {
            this.socket.sendAttackReject();
         }
         else
         {
            showNotifyMenu(_("IDS_NO_REQUEST"));
         }
      }
      
      override public function createMenu() : void
      {
         create(LOCATIONS_MENU_WIDTH,LOCATIONS_MENU_HEIGHT,false,0);
      }
      
      override public function closeHandler() : void
      {
         this.socket.sendExitZonesRequest();
         super.closeHandler();
      }
      
      private function attackZonePressHandler(param1:Object) : void
      {
         var location:Object = this.locations[param1.value];
         selectedLocation = location;
         selectedSide = param1.value1;
         var buttonIndex:int = 0;
         while(buttonIndex < this.locationsButtons.length)
         {
            if(param1.value == this.locationsButtons[buttonIndex].value && this.selectedSide == this.locationsButtons[buttonIndex].value1)
            {
               updateBgUI(this.locationsButtons[buttonIndex].upState,true,390,16);
               updateBgUI(this.checksLabels[buttonIndex],true,16,16);
            }
            else
            {
               updateBgUI(this.locationsButtons[buttonIndex].upState,false,390,16);
               updateBgUI(this.checksLabels[buttonIndex],false,16,16);
            }
            buttonIndex++;
         }
         this.participantsList.clear();
         participantsButtons = new Array();
         selectedParticipant = -1;
         if(this.removeUserBtn)
         {
            this.removeUserBtn.enabled = false;
            this.removeUserBtn.visible = location.type == World.ATTACK_CLAN_ZONE && (location.ownerClanId == Main.UserCharacter.clanId || location.attackingClanId == Main.UserCharacter.clanId);
         }
         rowY = -2;
         var rowY:int;
         var labelFormat:TextFormat = new TextFormat("Verdana",10,13408825);
         var nameField:TextField;
         var infoButton:BaseButton;
         var participantButton:BaseButton;
         var rowSprite:Sprite;
         var participant:Object;
         this.participantsList.addLine(createTextField(0,rowY,138,labelFormat,_("IDS_ZONE_ATTACKERS",location.participants[0].currentCount,location.participants[0].maxCount),18));
         for each(participant in location.participants[0].items)
         {
            rowY += 19;
            rowSprite = new Sprite();
            nameField = createTextField(3,0,138,labelFormat,participant.userName + "[" + participant.level + "]",18);
            rowSprite.addChild(nameField);
            updateBgUI(rowSprite,false,138,18);
            participantButton = new NButton(this.nameClickHandler,rowSprite,rowSprite,rowSprite);
            participantButton.y = rowY;
            this.participantsButtons.push(participantButton);
            participantButton.value1 = ATTACK_AS_ATTACKER;
            participantButton.value = participant.userID;
            infoButton = createInfoButton(nameField.x + Math.ceil(nameField.textWidth) + 5,rowY + 4,participant.userID);
            this.participantsList.addContent(participantButton);
            this.participantsList.addContent(infoButton);
         }
         if(location.type != World.ATTACK_PVE)
         {
            rowY += 19;
            this.participantsList.addLine(createTextField(0,rowY,150,labelFormat,_("IDS_ZONE_DEFENDERS",location.participants[1].currentCount,location.participants[1].maxCount),18));
            for each(participant in location.participants[1].items)
            {
               rowY += 19;
               rowSprite = new Sprite();
               nameField = createTextField(3,0,138,labelFormat,participant.userName + "[" + participant.level + "]",18);
               rowSprite.addChild(nameField);
               updateBgUI(rowSprite,false,138,18);
               participantButton = new NButton(this.nameClickHandler,rowSprite,rowSprite,rowSprite);
               participantButton.y = rowY;
               this.participantsButtons.push(participantButton);
               participantButton.value1 = ATTACK_AS_DEFENDER;
               participantButton.value = participant.userID;
               infoButton = createInfoButton(nameField.x + Math.ceil(nameField.textWidth) + 5,rowY + 4,participant.userID);
               this.participantsList.addContent(participantButton);
               this.participantsList.addContent(infoButton);
            }
         }
         rowY += 19;
         this.participantsList.addLine(createTextField(0,rowY,150,labelFormat,_("IDS_ZONE_SPECTATORS",location.participants[2].currentCount),18));
         for each(participant in location.participants[2].items)
         {
            rowY += 19;
            rowSprite = new Sprite();
            nameField = createTextField(3,0,138,labelFormat,participant.userName + "[" + participant.level + "]",18);
            rowSprite.addChild(nameField);
            updateBgUI(rowSprite,false,138,18);
            participantButton = new NButton(this.nameClickHandler,rowSprite,rowSprite,rowSprite);
            participantButton.y = rowY;
            this.participantsButtons.push(participantButton);
            participantButton.value1 = ATTACK_AS_SPECTATOR;
            participantButton.value = participant.userID;
            infoButton = createInfoButton(nameField.x + Math.ceil(nameField.textWidth) + 5,rowY + 4,participant.userID);
            this.participantsList.addContent(participantButton);
            this.participantsList.addContent(infoButton);
         }
         this.participantsList.init(rowY + 19);
      }
      
      private function nameClickHandler(param1:Object) : void
      {
         if(this.selectedParticipant != -1)
         {
            updateBgUI(this.participantsButtons[this.selectedParticipant].upStateDO,false,138,18);
         }
         selectedParticipant = this.participantsButtons.indexOf(param1);
         updateBgUI(param1.upStateDO,true,138,18);
         if(this.removeUserBtn && this.selectedLocation)
         {
            this.removeUserBtn.enabled = Main.UserCharacter.isValue6 && (param1.value1 == ATTACK_AS_ATTACKER && Main.UserCharacter.clanId == this.selectedLocation.attackingClanId || param1.value1 == ATTACK_AS_DEFENDER && Main.UserCharacter.clanId == this.selectedLocation.ownerClanId);
            this.removeUserBtn.value = param1.value;
         }
      }
      
      private function addRequestButton(param1:int, param2:Object, param3:int, param4:String) : void
      {
         var rowSprite:Sprite = new Sprite();
         var checkSprite:Sprite = new Sprite();
         updateBgUI(checkSprite,false,16,16);
         checkSprite.x = 0;
         checkSprite.y = param1;
         this.locScrollSprite.addLine(checkSprite);
         this.checksLabels.push(checkSprite);
         if(this.currentLocation == param2 && (this.currentSide == param3 || param2.type == World.ATTACK_CLAN_ZONE && this.currentSide == ATTACK_AS_ATTACKER))
         {
            checkBitmap = getBmp("MARK_CHECK");
            checkBitmap.x = 3;
            checkBitmap.y = param1 + 3;
            this.locScrollSprite.addLine(checkBitmap);
         }
         var labelFormat:TextFormat = new TextFormat("Verdana",12,13408825);
         var rightFormat:TextFormat = new TextFormat("Verdana",12,13408825);
         rightFormat.align = TextFormatAlign.RIGHT;
         var nameField:TextField = createTextField(23,param1 - 2,400,labelFormat,param4,18);
         var timerField:TextField = createTextField(195,param1 - 2,210,rightFormat,"",18);
         updateBgUI(rowSprite,false,390,16,nameField);
         var requestButton:BaseButton = new NButton(this.attackZonePressHandler,rowSprite,rowSprite,rowSprite);
         var checkBitmap:Bitmap;
         var clanButton:ClanIconButton;
         this.locationsButtons.push(requestButton);
         requestButton.value = param2.id;
         requestButton.value1 = param3;
         requestButton.x = 18;
         requestButton.y = param1;
         requestButton.textField1 = nameField;
         requestButton.textField2 = timerField;
         this.locScrollSprite.addContent(requestButton);
         if(param2.type == World.ATTACK_CLAN_ZONE)
         {
            clanButton = new ClanIconButton({
               "id":param2.attackingClanId,
               "name":param2.attackingClanName
            });
            clanButton.x = nameField.x + nameField.textWidth + 2;
            clanButton.y = param1 + 2;
            this.locScrollSprite.addContent(clanButton);
            if(param2.ownerClanId && param2.ownerClanId != 0)
            {
               this.locScrollSprite.addLine(createTextField(nameField.x + nameField.textWidth + 19,param1 - 2,100,labelFormat,"vs",18));
               clanButton = new ClanIconButton({
                  "id":param2.ownerClanId,
                  "name":param2.ownerClanName
               });
               clanButton.x = nameField.x + nameField.textWidth + 39;
               clanButton.y = param1 + 2;
               this.locScrollSprite.addContent(clanButton);
            }
            else
            {
               this.locScrollSprite.addLine(createTextField(nameField.x + nameField.textWidth + 19,param1 - 2,100,labelFormat,"vs NPC",18));
            }
         }
         this.locScrollSprite.addLine(nameField);
         this.locScrollSprite.addLine(timerField);
      }
      
      public function attackRequestsUpdate() : void
      {
         this.locScrollSprite.clear();
         locationsButtons = new Array();
         checksLabels = new Array();
         var rowY:int = 0;
         var location:Object;
         var button:BaseButton;
         for each(location in this.locations)
         {
            switch(location.type)
            {
               case World.ATTACK_CLAN_ZONE:
                  this.addRequestButton(rowY,location,ATTACK_AS_DEFAULT,location.zoneName + ":");
                  rowY += 18;
                  if(this.canSpectate)
                  {
                     this.addRequestButton(rowY,location,ATTACK_AS_SPECTATOR,_("IDS_SPECTATORS"));
                     rowY += 18;
                  }
                  break;
               case World.ATTACK_PVP:
                  this.addRequestButton(rowY,location,ATTACK_AS_ATTACKER,_("IDS_ATTACKERS") + " " + location.eventName + " " + location.curAttackers + "/" + location.maxAttackers + " vs " + location.curDefenders + "/" + location.maxDefenders);
                  rowY += 18;
                  this.addRequestButton(rowY,location,ATTACK_AS_DEFENDER,_("IDS_DEFENDERS") + " " + location.eventName + " " + location.curAttackers + "/" + location.maxAttackers + " vs " + location.curDefenders + "/" + location.maxDefenders);
                  rowY += 18;
                  if(this.canSpectate)
                  {
                     this.addRequestButton(rowY,location,ATTACK_AS_SPECTATOR,_("IDS_SPECTATORS") + " " + location.eventName + " " + location.curAttackers + "/" + location.maxAttackers + " vs " + location.curDefenders + "/" + location.maxDefenders);
                     rowY += 18;
                  }
                  break;
               case World.ATTACK_PVE:
                  this.addRequestButton(rowY,location,ATTACK_AS_ATTACKER,_("IDS_ATTACKERS") + " " + location.eventName + " " + location.curAttackers + "/" + location.maxAttackers + " vs NPC");
                  rowY += 18;
                  if(this.canSpectate)
                  {
                     this.addRequestButton(rowY,location,ATTACK_AS_SPECTATOR,_("IDS_SPECTATORS") + " " + location.eventName + " " + location.curAttackers + "/" + location.maxAttackers + " vs NPC");
                     rowY += 18;
                  }
                  break;
            }
         }
         if(this.selectedLocation)
         {
            for each(button in this.locationsButtons)
            {
               if(button.value == this.selectedLocation.id && button.value1 == this.selectedSide)
               {
                  this.attackZonePressHandler(button);
                  break;
               }
            }
         }
         this.locScrollSprite.init(rowY);
         this.timerHandler();
      }
      
      private function timerHandler() : void
      {
         var location:Object;
         var secondsLeft:int;
         var currentTime:int = getTimer();
         var button:BaseButton;
         for each(button in this.locationsButtons)
         {
            location = this.locations[button.value];
            secondsLeft = Math.max(0,(int(location.getTime) + int(location.timeLeft * 1000) - currentTime) / 1000);
            button.textField2.text = "";
            if(int(secondsLeft / 3600) < 10)
            {
               button.textField2.appendText("0");
            }
            button.textField2.appendText(int(secondsLeft / 3600) + ":");
            if(int(secondsLeft / 60) % 60 < 10)
            {
               button.textField2.appendText("0");
            }
            button.textField2.appendText(int(secondsLeft / 60) % 60 + ":");
            if(secondsLeft % 60 < 10)
            {
               button.textField2.appendText("0");
            }
            button.textField2.appendText(String(secondsLeft % 60));
         }
      }
      
      public function parseLocationsList(param1:Array, param2:int) : int
      {
         canSpectate = param1[param2++] == 1;
         currentSide = param1[param2] == "" ? -1 : int(param1[param2]);
         param2++;
         var currentLocationId:int = param1[param2++];
         var locationCount:int = param1[param2++];
         var currentTime:int = getTimer();
         var locationId:int;
         var locationType:int;
         var location:Object;
         var locationIndex:int = 0;
         var sideIndex:int;
         var participantIndex:int;
         while(locationIndex < locationCount)
         {
            locationId = param1[param2++];
            locationType = param1[param2++];
            location = this.locations[locationId];
            if(!location)
            {
               this.locations[locationId] = location = {};
            }
            location.id = locationId;
            location.type = locationType;
            switch(locationType)
            {
               case World.ATTACK_CLAN_ZONE:
                  location.zoneName = param1[param2++];
                  location.zoneI = param1[param2++];
                  location.zoneJ = param1[param2++];
                  location.ownerClanId = param1[param2++];
                  location.ownerClanName = param1[param2++];
                  location.ownerClanUrl = param1[param2++];
                  location.attackingClanId = param1[param2++];
                  location.attackingClanName = param1[param2++];
                  location.attackingClanUrl = param1[param2++];
                  location.timeLeft = param1[param2++];
                  location.getTime = currentTime;
                  location.participants = [{},{},{}];
                  break;
               case World.ATTACK_PVE:
               case World.ATTACK_PVP:
                  location.eventName = param1[param2++];
                  location.curAttackers = param1[param2++];
                  location.curDefenders = param1[param2++];
                  location.maxAttackers = param1[param2++];
                  location.maxDefenders = param1[param2++];
                  location.minLevel = param1[param2++];
                  location.maxLevel = param1[param2++];
                  location.timeLeft = param1[param2++];
                  location.getTime = currentTime;
                  location.participants = [{},{},{}];
                  break;
            }
            sideIndex = 0;
            while(sideIndex < 3)
            {
               location.participants[sideIndex].currentCount = int(param1[param2++]);
               location.participants[sideIndex].maxCount = int(param1[param2++]);
               location.participants[sideIndex].items = new Array();
               participantIndex = 0;
               while(participantIndex < location.participants[sideIndex].currentCount)
               {
                  location.participants[sideIndex].items.push({
                     "userID":int(param1[param2++]),
                     "userName":param1[param2++],
                     "level":int(param1[param2++]),
                     "clanID":int(param1[param2++])
                  });
                  participantIndex++;
               }
               sideIndex++;
            }
            locationIndex++;
         }
         currentLocation = this.locations[currentLocationId];
         this.attackRequestsUpdate();
         dataLoaded = true;
         if(this.timeInterval == -1)
         {
            timeInterval = setInterval(this.timerHandler,1000);
         }
         return param2;
      }
      
      public function updateLocation(param1:Array) : void
      {
         var currentTime:int = getTimer();
         var fieldIndex:int = 1;
         var locationId:int = param1[fieldIndex++];
         var locationType:int = param1[fieldIndex++];
         var location:Object = this.locations[locationId];
         if(!location)
         {
            this.locations[locationId] = location = {};
         }
         location.id = locationId;
         location.type = locationType;
         switch(locationType)
         {
            case World.ATTACK_CLAN_ZONE:
               location.zoneName = param1[fieldIndex++];
               location.zoneI = param1[fieldIndex++];
               location.zoneJ = param1[fieldIndex++];
               location.ownerClanId = param1[fieldIndex++];
               location.ownerClanName = param1[fieldIndex++];
               location.ownerClanUrl = param1[fieldIndex++];
               location.attackingClanId = param1[fieldIndex++];
               location.attackingClanName = param1[fieldIndex++];
               location.attackingClanUrl = param1[fieldIndex++];
               location.timeLeft = param1[fieldIndex++];
               location.getTime = currentTime;
               location.participants = [{},{},{}];
               break;
            case World.ATTACK_PVE:
            case World.ATTACK_PVP:
               location.eventName = param1[fieldIndex++];
               location.curAttackers = param1[fieldIndex++];
               location.curDefenders = param1[fieldIndex++];
               location.maxAttackers = param1[fieldIndex++];
               location.maxDefenders = param1[fieldIndex++];
               location.minLevel = param1[fieldIndex++];
               location.maxLevel = param1[fieldIndex++];
               location.timeLeft = param1[fieldIndex++];
               location.getTime = currentTime;
               location.participants = [{},{},{}];
               break;
         }
         var sideIndex:int = 0;
         var participantIndex:int;
         while(sideIndex < 3)
         {
            location.participants[sideIndex].currentCount = int(param1[fieldIndex++]);
            location.participants[sideIndex].maxCount = int(param1[fieldIndex++]);
            location.participants[sideIndex].items = new Array();
            participantIndex = 0;
            while(participantIndex < location.participants[sideIndex].currentCount)
            {
               location.participants[sideIndex].items.push({
                  "userID":int(param1[fieldIndex++]),
                  "userName":param1[fieldIndex++],
                  "level":int(param1[fieldIndex++]),
                  "clanID":int(param1[fieldIndex++])
               });
               participantIndex++;
            }
            sideIndex++;
         }
         this.attackRequestsUpdate();
      }
      
      public function removeLocation(param1:Array) : void
      {
         var locationId:int = param1[1];
         if(this.selectedLocation && this.selectedLocation.id == locationId)
         {
            selectedLocation = null;
            selectedSide = -1;
            this.participantsList.clear();
         }
         if(this.currentLocation && this.currentLocation.id == locationId)
         {
            currentLocation = null;
            currentSide = -1;
         }
         if(this.locations[locationId])
         {
            delete this.locations[locationId];
         }
         this.attackRequestsUpdate();
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

