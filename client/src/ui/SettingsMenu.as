package ui
{
   import ui.buttons.TabButton;
   import ui.buttons.NButton;
   import core.loaders.Texts;
   import ui.controls.SoundScroll;
   import net.*;
   import core.display.NSprite;
   import core.ui.BaseButton;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import game.*;
   
   public class SettingsMenu extends NuclearMenu
   {
      
      public static var AVAIBLE_KEYS:Array = new Array(Keyboard.DELETE,Keyboard.DOWN,Keyboard.END,Keyboard.F1,Keyboard.F10,Keyboard.F11,Keyboard.F12,Keyboard.F13,Keyboard.F14,Keyboard.F15,Keyboard.F2,Keyboard.F3,Keyboard.F4,Keyboard.F5,Keyboard.F6,Keyboard.F7,Keyboard.F8,Keyboard.F9,Keyboard.HOME,Keyboard.INSERT,Keyboard.LEFT,Keyboard.PAGE_DOWN,Keyboard.PAGE_UP,Keyboard.RIGHT,Keyboard.UP,Keyboard.SPACE,Keyboard.ENTER,Keyboard.SHIFT,Keyboard.ESCAPE,Keyboard.CONTROL,192);
      
      public static var KEYNAMES:Array = new Array("Delete","Down","End","F1","F10","F11","F12","F13","F14","F15","F2","F3","F4","F5","F6","F7","F8","F9","Home","Insert","Left","Page Down","Page Up","Right","Up","Space","Enter","Shift","Esc","Ctrl","`");
      
      private static var HOTKEY_X:int = 194;
      
      private static var HOTKEY_Y:int = 60;
      
      private static var HOTKEY_WIDTH:int = 292;
      
      private static var HOTKEY_HEIGHT:int = 220;
      
      public static var SETTINGS_WIDTH:int = 507;
      
      public static var SETTINGS_HEIGHT:int = 350;
      
      public static var TAB_HOTKEY:int = 0;
      
      public static var TAB_SOUNDS:int = 1;
      
      public static var TAB_SECURITY:int = 2;
      
      public static var TAB_GAME_SETTINGS:int = 3;
      
      public static var TAB_COUNT:int = 4;
      
      private var ramDL:Bitmap = new NUIComponent.LINE();
      
      private var ramDR:Bitmap = new NUIComponent.RAM_DL();
      
      private var ramSide:Bitmap = new NUIComponent.RAM_DR();
      
      private var ramTop:Bitmap = new NUIComponent.RAM_SIDE();
      
      private var ramUL:Bitmap = new NUIComponent.RAM_TOP();
      
      private var ramUR:Bitmap = new NUIComponent.RAM_UL();
      
      private var ramBottom:Bitmap = new NUIComponent.RAM_UR();
      
      private var selectedTab:int;
      
      private var buttonsBmp:Array;
      
      private var buttonsOverBmp:Array;
      
      private var buttonsPressBmp:Array;
      
      private var emailInput:NTextInput;
      
      private var currentPassInput:NTextInput;
      
      private var nTextInput1:NTextInput;
      
      private var newPassInput:NTextInput;
      
      private var confirmPassInput:NTextInput;
      
      private var eventsAdded:Boolean = false;
      
      private var tabButtons:Array = new Array(SETTINGS_HEIGHT);
      
      public var main:Main;
      
      private var submenu:NUIComponent;
      
      private var keyButtons:Array = new Array(Settings.HOTKEY_COUNT);
      
      private var keyTextFields:Array = new Array(Settings.HOTKEY_COUNT);
      
      public var selectedId:int = -1;
      
      public var emailOk:Bitmap;
      
      public var emailWrong:Bitmap;
      
      public var curPassOk:Bitmap;
      
      public var curPassWrong:Bitmap;
      
      public var newPassOk:Bitmap;
      
      public var newPassWrong:Bitmap;
      
      public var confirmPassOk:Bitmap;
      
      public var confirmPassWrong:Bitmap;
      
      private var soundsCheck:NCheckBox;
      
      private var musicCheck:NCheckBox;
      
      private var radioCheck:NCheckBox;
      
      private var radioTypeChecks:Array;
      
      private var soundsVolume:SoundScroll;
      
      private var musicVolume:SoundScroll;
      
      private var radioVolume:SoundScroll;
      
      public function SettingsMenu(param1:Main)
      {
         var tabIndex:int;
         var tabButton:BaseButton;
         super();
         this.selectedTab = TAB_HOTKEY;
         this.buttonsBmp = new Array(getBmp("HOTKEY"),getBmp("SOUND"),getBmp("SECURITY"),getBmp("GAMEOP_KEY"));
         this.buttonsOverBmp = new Array(getBmp("HOTKEY_OVER"),getBmp("SOUND_OVER"),getBmp("SECURITY_OVER"),getBmp("GAMEOP_KEY_OVER"));
         this.buttonsPressBmp = new Array(getBmp("HOTKEY_PRESS"),getBmp("SOUND_PRESS"),getBmp("SECURITY_PRESS"),getBmp("GAMEOP_KEY_PRESS"));
         this.emailOk = getBmp("RIGHT_CHECK");
         this.curPassOk = getBmp("RIGHT_CHECK");
         this.newPassOk = getBmp("RIGHT_CHECK");
         this.confirmPassOk = getBmp("RIGHT_CHECK");
         this.emailWrong = getBmp("WRONG_CHECK");
         this.curPassWrong = getBmp("WRONG_CHECK");
         this.newPassWrong = getBmp("WRONG_CHECK");
         this.confirmPassWrong = getBmp("WRONG_CHECK");
         this.main = param1;
         fillBg(4,4,SETTINGS_WIDTH - 8,SETTINGS_HEIGHT - 8);
         drawFrame(0,0,SETTINGS_WIDTH,SETTINGS_HEIGHT);
         addDefaultCloseButton(467,15);
         addSimpleTextField(221,22,getString("IDS_SETTINGS"),12,200,18,"left",13408825,true);
         this.tabButtons = new Array();
         tabIndex = 0;
         while(tabIndex < TAB_COUNT)
         {
            if(tabIndex == this.selectedTab)
            {
               tabButton = new NButton(this.barPress,this.buttonsPressBmp[tabIndex],this.buttonsOverBmp[tabIndex],this.buttonsPressBmp[tabIndex],this.buttonsPressBmp[tabIndex]);
            }
            else
            {
               tabButton = new NButton(this.barPress,this.buttonsBmp[tabIndex],this.buttonsOverBmp[tabIndex],this.buttonsPressBmp[tabIndex],this.buttonsBmp[tabIndex]);
            }
            tabButton.x = 21;
            tabButton.y = 51 + 43 * tabIndex;
            tabButton.value = tabIndex;
            this.tabButtons[tabIndex] = tabButton;
            addUIChild(tabButton);
            tabIndex++;
         }
         this.submenu = new NUIComponent();
         addUIChild(this.submenu);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST25,this.onEmailUpdate);
         this.startMenu();
      }
      
      public static function getKeyText(param1:int) : String
      {
         var keyIndex:int = 0;
         if(param1 >= 48 && param1 <= 57 || param1 >= 65 && param1 <= 90)
         {
            return String.fromCharCode(param1);
         }
         if(param1 >= 97 && param1 <= 122)
         {
            return String.fromCharCode(param1 - 97 + 65);
         }
         keyIndex = AVAIBLE_KEYS.indexOf(param1);
         if(keyIndex >= 0)
         {
            return KEYNAMES[keyIndex];
         }
         return "N/A";
      }
      
      private function onEmailUpdate(param1:Array) : void
      {
         if(this.nTextInput1)
         {
            this.nTextInput1.text = param1[1];
         }
      }
      
      public function barPress(param1:Object) : void
      {
         selectedId = -1;
         this.tabButtons[this.selectedTab].upState = this.buttonsBmp[this.tabButtons[this.selectedTab].value];
         param1.upState = this.buttonsOverBmp[param1.value];
         selectedTab = param1.value;
         this.clearAllChilds();
         this.startMenu();
      }
      
      public function createSettingsMenu() : void
      {
         super.create(SETTINGS_WIDTH,SETTINGS_HEIGHT);
      }
      
      private function removeEvents() : void
      {
         if(this.eventsAdded)
         {
            this.emailInput.removeEventListener(Event.CHANGE,this.changeHandler);
            this.currentPassInput.removeEventListener(Event.CHANGE,this.changeHandler);
            this.newPassInput.removeEventListener(Event.CHANGE,this.changeHandler);
            this.confirmPassInput.removeEventListener(Event.CHANGE,this.changeHandler);
            eventsAdded = false;
         }
      }
      
      private function addEvents() : void
      {
         this.emailInput.addEventListener(Event.CHANGE,this.changeHandler);
         this.currentPassInput.addEventListener(Event.CHANGE,this.changeHandler);
         this.newPassInput.addEventListener(Event.CHANGE,this.changeHandler);
         this.confirmPassInput.addEventListener(Event.CHANGE,this.changeHandler);
         eventsAdded = true;
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST25,this.onEmailUpdate);
         this.removeEvents();
         this.clearAllChilds();
         super.dispose();
      }
      
      private function clearAllChilds() : void
      {
         this.submenu.disposeAllChilds();
         this.submenu.graphics.clear();
      }
      
      private function addCheckBox(param1:int, param2:int, param3:Function, param4:int = 0, param5:int = 0) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3,this.submenu,param5);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         this.submenu.addUIChild(checkBox);
         return checkBox;
      }
      
      private function addSoundScroll(param1:int, param2:int, param3:Function) : SoundScroll
      {
         var scroll:SoundScroll = new SoundScroll(SoundScroll.TYPE_HORIZONTAL,param3,getBmp("SLIDER"),null,0,0,0,136,this.submenu);
         scroll.x = param1;
         scroll.y = param2;
         this.submenu.addUIChild(scroll);
         return scroll;
      }
      
      private function createCheckBox(param1:int, param2:int, param3:Function, param4:int = 0, param5:int = -1, param6:int = -1) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         return checkBox;
      }
      
      public function addNBut(param1:int, param2:int, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Function = null, param7:int = 0) : BaseButton
      {
         var button:BaseButton = new NButton(param6,param3,param4,param5,param3);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenu.addUIChild(button);
         return button;
      }
      
      public function addDisplayBut(param1:int, param2:int, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject, param6:Function = null, param7:int = 0) : BaseButton
      {
         var button:BaseButton = new NButton(param6,param3,param4,param5,null);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenu.addUIChild(button);
         return button;
      }
      
      public function createDisplayBut(param1:int, param2:int, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject, param6:Function = null, param7:int = 0) : BaseButton
      {
         var button:BaseButton = new NButton(param6,param3,param4,param5,null);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         return button;
      }
      
      public function startMenu() : void
      {
         switch(this.selectedTab)
         {
            case TAB_HOTKEY:
               this.createHotkeyMenu();
               break;
            case TAB_SOUNDS:
               this.createSoundsMenu();
               break;
            case TAB_SECURITY:
               this.createSecurityMenu();
               break;
            case TAB_GAME_SETTINGS:
               this.doAction742();
               break;
         }
      }
      
      private function drawInk(param1:Object, param2:int, param3:int, param4:int, param5:int) : void
      {
         param1.draw(this.ramUL,param2 + 1,param3 + 1);
         param1.drawTile(this.ramTop,param2 + this.ramUL.width + 1,param3,param4 - this.ramUL.width - this.ramUR.width - 2,this.ramTop.height);
         param1.draw(this.ramUR,param2 + param4 - this.ramUR.width - 1,param3 + 1);
         param1.draw(this.ramSide,param2,param3 + this.ramUL.height + 1);
         param1.draw(this.ramSide,param2 + param4 - this.ramSide.width,param3 + this.ramUR.height + 1);
         param1.drawVLine(param2,param3 + this.ramUL.height + 1 + this.ramSide.height,param5 - this.ramUL.height - this.ramDL.height - 2 - this.ramSide.height,12748580);
         param1.drawVLine(param2 + param4 - this.ramSide.width,param3 + this.ramUR.height + 1 + this.ramSide.height,param5 - this.ramUR.height - this.ramDR.height - 2 - this.ramSide.height,12748580);
         param1.draw(this.ramDL,param2 + 1,param3 + param5 - this.ramDL.height - 1);
         param1.drawTile(this.ramBottom,param2 + this.ramDL.width + 1,param3 + param5 - this.ramBottom.height,param4 - this.ramDL.width - this.ramDR.width - 2,this.ramBottom.height);
         param1.draw(this.ramDR,param2 + param4 - this.ramDR.width - 1,param3 + param5 - this.ramDR.height - 1);
      }
      
      public function handleKeyPress(param1:int) : Boolean
      {
         var keyAccepted:Boolean = true;
         var keyIndex:int;
         var hotkeyIndex:int;
         if(param1 >= 48 && param1 <= 57 || param1 >= 65 && param1 <= 90)
         {
            keyAccepted = true;
         }
         else
         {
            keyIndex = AVAIBLE_KEYS.indexOf(param1);
            if(keyIndex >= 0)
            {
               keyAccepted = true;
            }
         }
         if(keyAccepted)
         {
            hotkeyIndex = 0;
            while(hotkeyIndex < Settings.HOTKEY_COUNT)
            {
               if(Client.settings["key_" + hotkeyIndex] == param1)
               {
                  Client.settings["key_" + hotkeyIndex] = 0;
                  break;
               }
               hotkeyIndex++;
            }
            Client.settings["key_" + this.selectedId] = param1;
         }
         updateBgUI(this.keyButtons[this.selectedId].upState,false,82,16);
         selectedId = -1;
         this.updateKeyTexts();
         return true;
      }
      
      private function handleKeyBtnPress(param1:Object) : void
      {
         if(this.selectedId >= 0)
         {
            updateBgUI(this.keyButtons[this.selectedId].upState,false,82,16);
         }
         selectedId = param1.value;
         updateBgUI(this.keyButtons[this.selectedId].upState,true,82,16);
         this.updateKeyTexts();
      }
      
      private function updateKeyTexts() : void
      {
         var hotkeyIndex:int = 0;
         while(hotkeyIndex < this.keyTextFields.length)
         {
            if(hotkeyIndex == this.selectedId)
            {
               this.keyTextFields[hotkeyIndex].text = "";
            }
            else
            {
               this.keyTextFields[hotkeyIndex].text = getKeyText(this.main.getKey(hotkeyIndex));
            }
            hotkeyIndex++;
         }
      }
      
      private function handleDefaultPress(param1:Object) : void
      {
         selectedId = -1;
         Client.settings.doAction758();
         this.updateKeyTexts();
      }
      
      private function createHotkeyMenu() : void
      {
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 12;
         labelFormat.bold = true;
         keyFormat = new TextFormat();
         keyFormat.font = "Verdana";
         keyFormat.color = 10187041;
         keyFormat.size = 12;
         keyFormat.bold = true;
         keyFormat.align = TextFormatAlign.CENTER;
         this.drawInk(this.submenu,186,52,307,236);
         var keyFormat:TextFormat;
         var scroll:ScrollSprite = new ScrollSprite(HOTKEY_WIDTH,HOTKEY_HEIGHT);
         var hotkeyIndex:int;
         var keyBackground:NSprite;
         var labelBackground:NSprite;
         var labelField:TextField;
         scroll.x = HOTKEY_X;
         scroll.y = HOTKEY_Y;
         this.submenu.addUIChild(scroll);
         hotkeyIndex = 0;
         while(hotkeyIndex < Settings.HOTKEY_COUNT)
         {
            labelBackground = new NSprite();
            updateBgUI(labelBackground,false,190,16);
            labelBackground.x = 0;
            labelBackground.y = hotkeyIndex * 18;
            labelField = createTextField(4,hotkeyIndex * 18 - 2,186,labelFormat,getString("IDS_KEY_" + hotkeyIndex),18);
            scroll.addLine(labelBackground);
            scroll.addLine(labelField);
            keyBackground = new NSprite();
            updateBgUI(keyBackground,false,82,16);
            this.keyTextFields[hotkeyIndex] = createTextField(196,hotkeyIndex * 18 - 2,78,keyFormat,"",18);
            this.keyButtons[hotkeyIndex] = this.createDisplayBut(192,hotkeyIndex * 18,keyBackground,keyBackground,keyBackground,this.handleKeyBtnPress,hotkeyIndex);
            scroll.addContent(this.keyButtons[hotkeyIndex]);
            scroll.addLine(this.keyTextFields[hotkeyIndex]);
            hotkeyIndex++;
         }
         scroll.init(hotkeyIndex * 18);
         this.updateKeyTexts();
         this.addNBut(257,298,getBmp("DEFAULT_KEY"),getBmp("DEFAULT_KEY_OVER"),getBmp("DEFAULT_KEY_PRESS"),this.handleDefaultPress);
      }
      
      private function handleSoundCheck(param1:Object) : void
      {
         Client.settings.enableSounds = !Client.settings.enableSounds;
         this.updateSoundValues();
      }
      
      private function handleMusicCheck(param1:Object) : void
      {
         Client.settings.enableMusic = !Client.settings.enableMusic;
         this.updateSoundValues();
         this.main.world.updateMusic();
      }
      
      private function handleRadioCheck(param1:Object) : void
      {
         if(Client.settings["enableRadio"])
         {
            NuclearChat.instance.updateUserlistText();
         }
         else
         {
            NuclearChat.instance.enableRadio();
         }
         this.updateSoundValues();
      }
      
      public function updateSoundValues() : void
      {
         var radioIndex:int = 0;
         if(this.selectedTab == TAB_SOUNDS)
         {
            this.soundsCheck.checked = Client.settings.enableSounds;
            this.musicCheck.checked = Client.settings.enableMusic;
            this.radioCheck.checked = Client.settings.enableRadio;
            this.soundsVolume.volume = Client.settings.soundVolume;
            this.musicVolume.volume = Client.settings.musicVolume;
            this.radioVolume.volume = Client.settings.radioVolume;
            radioIndex = 0;
            while(radioIndex < this.radioTypeChecks.length)
            {
               this.radioTypeChecks[radioIndex].checked = radioIndex == Client.settings.radioType;
               radioIndex++;
            }
         }
      }
      
      private function handleAutotargetCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.autoTarget = param1.checked;
      }
      
      private function handleTipsCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.tips = param1.checked;
      }
      
      private function handleShowPvPCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.showPvP = param1.checked;
      }
      
      private function handleFixedCameraCheck(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.fixedCamera = param1.checked;
      }
      
      private function handleSoundVolume(param1:Object) : void
      {
         NuclearChat.instance.doAction828(param1.value);
         this.updateSoundValues();
      }
      
      private function doAction941(param1:Object) : void
      {
         Client.settings["soundVolume"] = param1.value;
      }
      
      private function handleMusicVolume(param1:Object) : void
      {
         Client.settings["musicVolume"] = param1.value;
         this.main.world.updateMusicVolume();
      }
      
      private function doAction501(param1:Object) : void
      {
         NuclearChat.instance.doAction187(param1.value);
         this.updateSoundValues();
      }
      
      private function drawSlider(param1:int, param2:int, param3:int) : void
      {
         var leftRail:Bitmap = getBmp("SLIDER_RAIL_LEFT");
         var rightRail:Bitmap = getBmp("SLIDER_RAIL_RIGHT");
         var centerRail:Bitmap = getBmp("SLIDER_RAIL_CENTER");
         this.submenu.draw(leftRail,param1,param2);
         this.submenu.drawTile(centerRail,param1 + leftRail.width,param2,param3 - leftRail.width - rightRail.width,centerRail.height);
         this.submenu.draw(rightRail,param1 + param3 - rightRail.width,param2);
         var tickOffset:int = 4;
         while(tickOffset < param3)
         {
            this.submenu.drawVLine(param1 + tickOffset,param2 + 15,4,15382601);
            tickOffset += 17;
         }
      }
      
      private function createSoundsMenu() : void
      {
         var channelFormat:TextFormat = new TextFormat();
         channelFormat.font = "Regular";
         channelFormat.color = 10187041;
         channelFormat.size = 12;
         channelFormat.align = TextFormatAlign.CENTER;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 12;
         labelFormat.bold = true;
         this.drawSlider(334,73,147);
         this.drawSlider(334,113,147);
         this.drawSlider(334,153,147);
         this.submenu.addChild(createTextField(200,64,150,labelFormat,getString("IDS_SOUND"),18));
         this.submenu.addChild(createTextField(200,104,150,labelFormat,getString("IDS_MUSIC"),18));
         this.submenu.addChild(createTextField(200,144,150,labelFormat,getString("IDS_RADIO"),18));
         this.submenu.addChild(createTextField(200,184,150,labelFormat,getString("IDS_RADIO_CHANNEL"),18));
         soundsCheck = this.addCheckBox(308,67,this.handleSoundCheck);
         musicCheck = this.addCheckBox(308,107,this.handleMusicCheck);
         radioCheck = this.addCheckBox(308,147,this.handleRadioCheck);
         radioTypeChecks = new Array();
         var checkBox:NCheckBox;
         var channelIndex:int = 0;
         while(channelIndex < 3)
         {
            checkBox = this.addCheckBox(339 + channelIndex * 60,192,this.handleSoundVolume,channelIndex,NCheckBox.TYPE_CIRCLE);
            this.radioTypeChecks.push(checkBox);
            this.submenu.addChild(createTextField(295 + channelIndex * 60,207,100,channelFormat,getString("IDS_RADIO_CHANNEL_" + channelIndex),18));
            channelIndex++;
         }
         soundsVolume = this.addSoundScroll(334,66,this.doAction941);
         musicVolume = this.addSoundScroll(334,106,this.handleMusicVolume);
         radioVolume = this.addSoundScroll(334,146,this.doAction501);
         this.updateSoundValues();
      }
      
      private function doAction742() : void
      {
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 12;
         labelFormat.bold = true;
         var rowY:int = 64;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_AUTO_TARGET"),18));
         var checkBox:NCheckBox = this.addCheckBox(460,rowY + 3,this.handleAutotargetCheck);
         checkBox.checked = Client.settings.autoTarget;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_TIPS"),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleTipsCheck);
         checkBox.checked = Client.settings.tips;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_SHOW_PVP"),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleShowPvPCheck);
         checkBox.checked = Client.settings.showPvP;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_FIXED_CAMERA"),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleFixedCameraCheck);
         checkBox.checked = Client.settings.fixedCamera;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_FRIEND_ONLINE_SETTING"),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.doAction579);
         checkBox.checked = Client.settings.showFriendGoesOnline;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,Texts.getString39(),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.doAction718);
         checkBox.checked = Client.settings.hideFoesMessages;
         rowY += 40;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,getString("IDS_CHAT_CHANNELS"),18));
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,_("IDS_CHAT_CHANNEL_" + ChatPanel.GA_SHOW_CLAN),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleRadioVolume,ChatPanel.GA_SHOW_CLAN);
         checkBox.checked = Client.settings["showChannel_" + ChatPanel.GA_SHOW_CLAN];
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,_("IDS_CHAT_CHANNEL_" + ChatPanel.TYPE_2),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleRadioVolume,ChatPanel.TYPE_2);
         checkBox.checked = Client.settings["showChannel_" + ChatPanel.TYPE_2];
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,_("IDS_CHAT_CHANNEL_" + ChatPanel.TYPE_CLAN),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleRadioVolume,ChatPanel.TYPE_CLAN);
         checkBox.checked = Client.settings["showChannel_" + ChatPanel.TYPE_CLAN];
         checkBox.enabled = Client.currentCharacter.clanId > 0;
         rowY += 20;
         this.submenu.addChild(createTextField(200,rowY,250,labelFormat,_("IDS_CHAT_CHANNEL_" + ChatPanel.GA_ADD_CLAN_USERS),18));
         checkBox = this.addCheckBox(460,rowY + 3,this.handleRadioVolume,ChatPanel.GA_ADD_CLAN_USERS);
         checkBox.checked = Client.settings["showChannel_" + ChatPanel.GA_ADD_CLAN_USERS];
      }
      
      private function doAction718(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.hideFoesMessages = param1.checked;
         Client.settings.save();
      }
      
      private function doAction579(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings.showFriendGoesOnline = param1.checked;
      }
      
      private function handleRadioVolume(param1:Object) : void
      {
         param1.checked = !param1.checked;
         Client.settings["showChannel_" + param1.value] = param1.checked;
         Client.settings.save();
         if(param1.checked)
         {
            ChatPanel.instance.doAction103(param1.value);
         }
         else
         {
            ChatPanel.instance.doAction951(param1.value);
         }
      }
      
      private function checkEmail(param1:String) : Boolean
      {
         if(param1.length >= 32)
         {
            return false;
         }
         var charIndex:int = 0;
         while(charIndex < param1.length && param1.charCodeAt(charIndex) != 64)
         {
            if(!(param1.charCodeAt(charIndex) >= 48 && param1.charCodeAt(charIndex) <= 57 || param1.charCodeAt(charIndex) >= 97 && param1.charCodeAt(charIndex) <= 122 || param1.charCodeAt(charIndex) >= 65 && param1.charCodeAt(charIndex) <= 90 || param1.charCodeAt(charIndex) == 45 || param1.charCodeAt(charIndex) == 95 || param1.charCodeAt(charIndex) == 46))
            {
               return false;
            }
            charIndex++;
         }
         if(charIndex < param1.length && charIndex > 0)
         {
            ++charIndex;
            if(charIndex >= param1.length || param1.charCodeAt(charIndex) == 46)
            {
               return false;
            }
            while(charIndex < param1.length && param1.charCodeAt(charIndex) != 46)
            {
               if(!(param1.charCodeAt(charIndex) >= 48 && param1.charCodeAt(charIndex) <= 57 || param1.charCodeAt(charIndex) >= 97 && param1.charCodeAt(charIndex) <= 122 || param1.charCodeAt(charIndex) >= 65 && param1.charCodeAt(charIndex) <= 90 || param1.charCodeAt(charIndex) == 45 || param1.charCodeAt(charIndex) == 95 || param1.charCodeAt(charIndex) == 46))
               {
                  return false;
               }
               charIndex++;
            }
            if(charIndex < param1.length)
            {
               ++charIndex;
               if(charIndex == param1.length)
               {
                  return false;
               }
               while(charIndex < param1.length)
               {
                  if(!(param1.charCodeAt(charIndex) >= 48 && param1.charCodeAt(charIndex) <= 57 || param1.charCodeAt(charIndex) >= 97 && param1.charCodeAt(charIndex) <= 122 || param1.charCodeAt(charIndex) >= 65 && param1.charCodeAt(charIndex) <= 90 || param1.charCodeAt(charIndex) == 45 || param1.charCodeAt(charIndex) == 95 || param1[charIndex] == 46))
                  {
                     return false;
                  }
                  charIndex++;
               }
               return true;
            }
         }
         return false;
      }
      
      private function changeHandler(param1:Event) : void
      {
         this.updateChecks();
      }
      
      private function handleConfirmData(param1:Object) : void
      {
         if(this.currentPassInput.text == "")
         {
            this.main.showNotifyMenu(getString("IDS_NO_PASS"));
         }
         else if(this.currentPassInput.text.length < 8)
         {
            this.main.showNotifyMenu(getString("IDS_LOW_CUR_PASS"));
         }
         else if(this.emailInput.text != "" && !this.checkEmail(this.emailInput.text))
         {
            this.main.showNotifyMenu(getString("IDS_BAD_EMAIL"));
         }
         else if(this.newPassInput.text != "" && this.newPassInput.text.length < 8)
         {
            this.main.showNotifyMenu(getString("IDS_BAD_PASS"));
         }
         else if(this.newPassInput.text != "" && this.confirmPassInput.text != this.newPassInput.text)
         {
            this.main.showNotifyMenu(getString("IDS_BAD_CONFIRM"));
         }
         else
         {
            this.main.socket.sendStr("cs|" + this.currentPassInput.text + "|" + this.emailInput.text + "|" + this.newPassInput.text + "|");
         }
      }
      
      private function updateChecks() : void
      {
         this.emailOk.visible = false;
         this.emailWrong.visible = false;
         this.newPassOk.visible = false;
         this.newPassWrong.visible = false;
         this.confirmPassOk.visible = false;
         this.confirmPassWrong.visible = false;
         if(this.currentPassInput.text != "" && this.currentPassInput.text.length >= 8)
         {
            this.curPassOk.visible = true;
            this.curPassWrong.visible = false;
         }
         else
         {
            this.curPassOk.visible = false;
            this.curPassWrong.visible = true;
         }
         if(this.emailInput.text != "")
         {
            if(this.checkEmail(this.emailInput.text))
            {
               this.emailOk.visible = true;
            }
            else
            {
               this.emailWrong.visible = true;
            }
         }
         if(this.newPassInput.text != "")
         {
            if(this.newPassInput.text.length < 8)
            {
               this.newPassWrong.visible = true;
            }
            else
            {
               this.newPassOk.visible = true;
               if(this.newPassInput.text == this.confirmPassInput.text)
               {
                  this.confirmPassOk.visible = true;
               }
               else
               {
                  this.confirmPassWrong.visible = true;
               }
            }
         }
      }
      
      private function createSecurityMenu() : void
      {
         this.removeEvents();
         this.submenu.addChild(this.emailOk);
         this.submenu.addChild(this.emailWrong);
         this.submenu.addChild(this.curPassOk);
         this.submenu.addChild(this.curPassWrong);
         this.submenu.addChild(this.newPassOk);
         this.submenu.addChild(this.newPassWrong);
         this.submenu.addChild(this.confirmPassOk);
         this.submenu.addChild(this.confirmPassWrong);
         var format10:TextFormat = new TextFormat();
         format10.font = "Verdana";
         format10.color = 13408825;
         format10.size = 10;
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 13408825;
         hintFormat.size = 9;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 11;
         position = new Point(190,47);
         this.submenu.addChild(createTextField(position.x,position.y,150,labelFormat,_("IDS_CUR_PASS"),18));
         position.offset(0,19);
         currentPassInput = createTextInput(position.x,position.y,272);
         this.currentPassInput.displayAsPassword = true;
         this.submenu.addUIChild(this.currentPassInput);
         this.curPassOk.y = this.curPassWrong.y = position.y + 2;
         this.curPassOk.x = this.curPassWrong.x = position.x + this.currentPassInput.width + 3;
         position.offset(0,26);
         this.submenu.addChild(createTextField(position.x,position.y,150,labelFormat,_("IDS_CUR_EMAIL"),18));
         position.offset(0,19);
         nTextInput1 = createTextInput(position.x,position.y,272,Client.currentCharacter.email);
         this.nTextInput1.isValue25 = true;
         this.submenu.addUIChild(this.nTextInput1);
         position.offset(0,26);
         this.submenu.addChild(createTextField(position.x,position.y,150,labelFormat,_("IDS_NEW_EMAIL"),18));
         position.offset(0,19);
         emailInput = createTextInput(position.x,position.y,272);
         this.submenu.addUIChild(this.emailInput);
         this.emailOk.y = this.emailWrong.y = position.y + 2;
         this.emailOk.x = this.emailWrong.x = position.x + this.emailInput.width + 3;
         position.offset(0,26);
         this.submenu.addChild(createTextField(position.x,position.y,150,labelFormat,_("IDS_NEW_PASS"),18));
         position.offset(0,19);
         newPassInput = createTextInput(position.x,position.y,272);
         this.newPassInput.displayAsPassword = true;
         this.submenu.addUIChild(this.newPassInput);
         this.newPassOk.y = this.newPassWrong.y = position.y + 2;
         this.newPassOk.x = this.newPassWrong.x = position.x + this.newPassInput.width + 3;
         position.offset(0,26);
         this.submenu.addChild(createTextField(position.x,position.y,150,labelFormat,_("IDS_CONFIRM_PASS"),18));
         position.offset(0,19);
         confirmPassInput = createTextInput(position.x,position.y,272);
         this.confirmPassInput.displayAsPassword = true;
         this.submenu.addUIChild(this.confirmPassInput);
         this.confirmPassOk.y = this.confirmPassWrong.y = position.y + 2;
         this.confirmPassOk.x = this.confirmPassWrong.x = position.x + this.confirmPassInput.width + 3;
         position.offset(0,73);
         this.submenu.addChild(createTextField(15,position.y,400,hintFormat,_("IDS_LEAVE_FIELD"),18));
         position.offset(199,-10);
         var position:Point;
         var saveButton:TabButton = new TabButton(_("IDS_SAVE"),this.handleConfirmData);
         saveButton.setPos(position.x,position.y);
         this.submenu.addUIChild(saveButton);
         this.addEvents();
         this.updateChecks();
      }
   }
}

