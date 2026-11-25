package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.Chat;
   
   public class RaidLocationsMenu extends NuclearMenu
   {
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var locScrollSprite:ScrollSprite;
      
      private var timeInterval:int = -1;
      
      private var locationsData:Array = new Array();
      
      private var locationsButtons:Array;
      
      private var selectedLocation:SelectableButton = null;
      
      private var startRaidButton:BaseButton;
      
      private var descriptionText:TextField;
      
      private var setPasswordCheckbox:NCheckBox;
      
      private var passwordTextfield:NTextInput;
      
      public function RaidLocationsMenu(param1:GameSocket, param2:Terminal, param3:Object, param4:Boolean)
      {
         super();
         dragable = false;
         this.socket = param1;
         this.terminal = param2;
         var headingFormat:TextFormat = getTextFormat({
            "size":12,
            "color":13408825
         });
         bodyFormat = getTextFormat({"color":13408825});
         drawRect(0,0,410,225,13408825);
         drawHLine(4,22,402,13408825);
         drawHLine(4,206,402,13408825);
         drawRect(419,0,206,225,13408825);
         drawHLine(423,22,197,13408825);
         if(!param4)
         {
            param1.sendRaidLocationsRequest();
         }
         addChild(createTextField(6,2,300,headingFormat,"C:\\" + getString("IDS_TERM_ICO_21"),18));
         addChild(createTextField(425,2,150,headingFormat,getString("IDS_DESCRIPTION"),18));
         this.startRaidButton = createTextButton(0,234,getString("IDS_INIT_RAID"),this.startRaidClickHandler);
         addUIChild(this.startRaidButton);
         this.setPasswordCheckbox = new NCheckBox(this.setPasswordCheckboxClick);
         this.setPasswordCheckbox.x = 110;
         this.setPasswordCheckbox.y = 238;
         this.setPasswordCheckbox.checked = false;
         addUIChild(this.setPasswordCheckbox);
         var bodyFormat:TextFormat;
         var passwordLabel:TextField = createTextField(125,236,150,bodyFormat,getString("IDS_SET_PASS"),18);
         addChild(passwordLabel);
         this.passwordTextfield = createTextInput(passwordLabel.x + passwordLabel.textWidth + 7,235,150);
         this.passwordTextfield.maxChars = 20;
         this.passwordTextfield.backgroundColor = 2172187;
         this.passwordTextfield.borderColor = 3156252;
         this.passwordTextfield.height = 18;
         this.passwordTextfield.visible = false;
         this.passwordTextfield.displayAsPassword = true;
         addUIChild(this.passwordTextfield);
         this.locScrollSprite = new ScrollSprite(392,167,7);
         this.locScrollSprite.x = 9;
         this.locScrollSprite.y = 32;
         addUIChild(this.locScrollSprite);
         this.descriptionText = createTextField(425,25,194,bodyFormat,"",180,true);
         addChild(this.descriptionText);
         addUIChild(createTextButton(526,234,getString("IDS_BACK"),this.closeBtnHandler));
      }
      
      private function setPasswordCheckboxClick(param1:NCheckBox) : void
      {
         param1.checked = !param1.checked;
         this.passwordTextfield.visible = param1.checked;
         if(param1.checked)
         {
            stage.focus = this.passwordTextfield;
            this.passwordTextfield.setSelection(this.passwordTextfield.text.length,this.passwordTextfield.text.length);
         }
      }
      
      private function startRaidClickHandler(param1:Object) : void
      {
         if(this.selectedLocation && this.raidCanBeStarted(this.selectedLocation.value))
         {
            this.socket.sendInitRaid(this.selectedLocation.value.id,this.setPasswordCheckbox.checked ? this.passwordTextfield.text : "");
         }
         this.startRaidButton.enabled = false;
      }
      
      public function parseData(param1:Array) : void
      {
         locationsData = new Array();
         var fieldIndex:int = 1;
         var remainingLocations:int = param1[fieldIndex++];
         var currentTimeSeconds:int = getTimer() / 1000;
         while(remainingLocations > 0)
         {
            this.locationsData.push({
               "id":int(param1[fieldIndex++]),
               "name":param1[fieldIndex++],
               "minLevel":int(param1[fieldIndex++]),
               "maxLevel":int(param1[fieldIndex++]),
               "maxMembers":int(param1[fieldIndex++]),
               "cooldown":int(param1[fieldIndex++]),
               "waittime":currentTimeSeconds + int(param1[fieldIndex++])
            });
            remainingLocations--;
         }
         this.drawLocationsList();
      }
      
      private function raidCanBeStarted(param1:Object) : Boolean
      {
         return param1.waittime <= getTimer() / 1000 && param1.minLevel <= Main.UserCharacter.level && param1.maxLevel >= Main.UserCharacter.level;
      }
      
      private function drawLocationsList() : void
      {
         var locationButton:SelectableButton;
         if(this.timeInterval != -1)
         {
            clearInterval(this.timeInterval);
         }
         locationsButtons = new Array();
         this.locScrollSprite.clear();
         var rowIndex:int = 0;
         var statusText:String;
         var currentTimeSeconds:int = getTimer() / 1000;
         var cooldownExpired:Boolean = false;
         var hasWaitingLocations:Boolean = false;
         var location:Object;
         for each(location in this.locationsData)
         {
            cooldownExpired = location.waittime <= currentTimeSeconds;
            locationButton = new SelectableButton({
               "y":rowIndex * 21,
               "width":378,
               "clickHandler":this.locationClickHandler
            });
            statusText = location.name;
            statusText += statusText.charAt(statusText.length - 1) == "." ? " " : ". ";
            statusText += getString("IDS_STATUS") + ": ";
            if(Main.UserCharacter.level > location.maxLevel)
            {
               statusText += getString("IDS_HIGH_LEVEL");
            }
            else if(Main.UserCharacter.level < location.minLevel)
            {
               statusText += getString("IDS_RAID_LOW_LEVEL");
            }
            else if(cooldownExpired)
            {
               statusText += getString("IDS_AVAILABLE");
            }
            else
            {
               statusText += getString("IDS_WAITING");
               hasWaitingLocations = true;
               locationButton.addLabel(Chat.secondsToStr(location.waittime - currentTimeSeconds),TextFormatAlign.RIGHT);
            }
            locationButton.addLabel(statusText);
            locationButton.value = location;
            this.locationsButtons.push(locationButton);
            this.locScrollSprite.addContent(locationButton);
            if(rowIndex == 0)
            {
               locationButton.Selected = true;
               this.locationClickHandler(locationButton);
            }
            rowIndex++;
         }
         this.locScrollSprite.init(rowIndex * 21 - 1);
         if(hasWaitingLocations)
         {
            timeInterval = setInterval(this.onTimer,1000);
         }
      }
      
      public function onTimer() : void
      {
         var currentTimeSeconds:int = getTimer() / 1000;
         var locationButton:SelectableButton;
         var countdownLabel:TextField;
         for each(locationButton in this.locationsButtons)
         {
            if(locationButton.getLabel(1) == null)
            {
               continue;
            }
            if(locationButton.value.waittime <= currentTimeSeconds)
            {
               countdownLabel = locationButton.getLabel(0);
               if(countdownLabel && countdownLabel.text)
               {
                  this.drawLocationsList();
                  return;
               }
            }
            else
            {
               locationButton.getLabel(0).text = Chat.secondsToStr(locationButton.value.waittime - currentTimeSeconds);
            }
         }
      }
      
      override public function dispose() : void
      {
         if(this.timeInterval != -1)
         {
            clearInterval(this.timeInterval);
         }
         super.dispose();
      }
      
      private function locationClickHandler(param1:SelectableButton) : void
      {
         if(this.selectedLocation != null)
         {
            this.selectedLocation.Selected = false;
         }
         param1.Selected = true;
         var location:Object = param1.value;
         selectedLocation = param1;
         this.startRaidButton.enabled = this.raidCanBeStarted(location);
         this.descriptionText.text = Chat.prepareText(_("IDS_RAID_LOC_DESCR",location.minLevel,location.maxLevel,location.maxMembers,location.cooldown));
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      override public function createMenu() : void
      {
         create(625,336,false);
      }
   }
}

