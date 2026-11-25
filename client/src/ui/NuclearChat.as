package ui
{
   import ui.buttons.*;
   import ui.controls.SoundScroll;
   import net.GameSocket;
   import game.npc.PlayerItem;
   import ui.addons.Addon;
   import ui.menus.*;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import flash.utils.Timer;
   import flash.utils.setInterval;
   import game.*;
   
   public class NuclearChat extends NUIComponent
   {
      
      public static var instance:NuclearChat;
      
      public static const array9:Array = ["15","30","45","60","75"];
      
      private static const HIDE_82:int = 82;
      
      private static const HIDE_TIME:int = 500;
      
      protected var main:Main;
      
      protected var forceAdd:Boolean = false;
      
      protected var _autoChat:Boolean;
      
      protected var _throwAngleIdx:int = 2;
      
      protected var addon1:Addon;
      
      protected var _addonType:int;
      
      protected var nuclearChat:NUIComponent;
      
      protected var nuiComponent13:NUIComponent;
      
      protected var loader1:Loader;
      
      protected var loader3:Loader;
      
      protected var textField25:TextField;
      
      protected var textField4:TextField;
      
      protected var nuiComponent7:NUIComponent;
      
      protected const bitmapList3:Vector.<Bitmap> = new Vector.<Bitmap>(5,true);
      
      protected var ammoType:TextField;
      
      protected var intValue90:int = -1;
      
      protected var intValue81:int = -1;
      
      protected var currentHand:int = 0;
      
      protected const textFieldList1:Vector.<TextField> = new Vector.<TextField>(2,true);
      
      protected const weaponName:Vector.<TextField> = new Vector.<TextField>(2,true);
      
      protected const textFieldList2:Vector.<TextField> = new Vector.<TextField>(2,true);
      
      protected var nuiComponent11:NUIComponent;
      
      protected const nuiComponent19:NUIComponent = new NUIComponent();
      
      protected const shape2:Shape = new Shape();
      
      protected var timer:Timer;
      
      protected var baseOpened:Boolean = false;
      
      protected var autoButton:NButton;
      
      protected var logoutButton:NButton;
      
      protected var combatModeButton:ToggleButton;
      
      protected var inventoryButton:NButton;
      
      protected var radioButton:ToggleButton;
      
      protected const toggleButtonList1:Vector.<ToggleButton> = new Vector.<ToggleButton>(3,true);
      
      protected var radioVolume2:SoundScroll;
      
      protected var stageWidth:int;
      
      protected var stageHeight:int;
      
      public function NuclearChat(param1:Main, param2:int, param3:int)
      {
         var panelBitmap:Bitmap;
         super();
         this.main = param1;
         instance = this;
         panelBitmap = getBmp("WEAPON_PANEL");
         height = panelBitmap.height;
         width = panelBitmap.width;
         draw(panelBitmap);
         this.autoButton = new NButton(this.onMinimizeClick,getBmp("MINIMIZE_BUTTON"),getBmp("MINIMIZE_BUTTON_OVER"),getBmp("MINIMIZE_BUTTON_PRESSED"));
         this.autoButton.setPos(26,-this.autoButton.height);
         addUIChild(this.autoButton);
         this.logoutButton = new NButton(this.onMaximizeClick,getBmp("MAXIMIZE_BUTTON"),getBmp("MAXIMIZE_BUTTON_OVER"),getBmp("MAXIMIZE_BUTTON_PRESSED"));
         this.logoutButton.setPos(26,-this.autoButton.height);
         this.logoutButton.visible = false;
         addUIChild(this.logoutButton);
         this.combatModeButton = new ToggleButton(this.handleAutoButton,getBmp("COMBAT_MODE_BUTTON"),getBmp("COMBAT_MODE_BUTTON_OVER"),getBmp("COMBAT_MODE_BUTTON_PRESSED"),getBmp("COMBAT_MODE_BUTTON_ON"));
         this.combatModeButton.setPos(162,12);
         addUIChild(this.combatModeButton);
         var toggleButton:ToggleButton = new ToggleButton(this.onAutoModeClick,getBmp("AUTO_MODE_BUTTON"),getBmp("AUTO_MODE_BUTTON_OVER"),getBmp("AUTO_MODE_BUTTON_PRESSED"));
         toggleButton.setPos(175,63);
         this._autoChat = Client.settings["autoBattleMode"];
         toggleButton.toggled = this.auto;
         addUIChild(toggleButton);
         var button:NButton = new WeaponPanelButton(_("IDS_CHARACTER"),this.onCharacterClick);
         button.setPos(217,96);
         addUIChild(button);
         this.inventoryButton = new WeaponPanelButton(_("IDS_INVENTORY"),this.handleRadionOn);
         this.inventoryButton.setPos(217,118);
         addUIChild(this.inventoryButton);
         button = new WeaponPanelButton(_("IDS_MAP"),this.onMapClick);
         button.setPos(217,140);
         addUIChild(button);
         button = new WeaponPanelButton(_("IDS_QUESTS"),this.onQuestsClick);
         button.setPos(217,162);
         addUIChild(button);
         var panelColor:uint = 13214013;
         var panelX:int = 25;
         panelY = 10;
         var panelY:int;
         var panelWidth:int = 110;
         sectionHeight = 68;
         this.nuiComponent13 = new NUIComponent();
         this.nuiComponent13.setPos(0,9);
         this.nuiComponent13.visible = false;
         addUIChild(this.nuiComponent13);
         this.nuiComponent13.doAction151(panelX,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuiComponent13.doAction151(panelX + panelWidth,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuiComponent13.doAction487(panelX,panelY + sectionHeight,panelWidth / 2 - 16,panelColor,panelColor,1,0);
         this.nuiComponent13.doAction487(panelX + 1 + panelWidth / 2 + 16,panelY + sectionHeight,panelWidth / 2 - 16,panelColor,panelColor,0);
         this.nuiComponent13.doAction487(panelX + 16,panelY + sectionHeight - 18,panelWidth / 2 - 16,panelColor,panelColor,0);
         this.nuiComponent13.doAction487(panelX + panelWidth / 2,panelY + sectionHeight - 18,panelWidth / 2 - 16,panelColor,panelColor,1,0);
         this.loader3 = new Loader();
         this.nuiComponent13.addChild(this.loader3);
         this.loader3.x = panelX + panelWidth / 2 - 2;
         this.loader3.y = panelY + sectionHeight / 2 - 10;
         this.loader3.contentLoaderInfo.addEventListener(Event.COMPLETE,this.weaponLoadHandler);
         this.loader3.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError2);
         this.textField25 = new TextField();
         this.textField25.defaultTextFormat = new NTextFormat({
            "color":13408563,
            "size":9,
            "letterSpacing":-1
         });
         this.textField25.x = panelX + 2;
         this.textField25.y = panelY + sectionHeight - 18;
         this.textField25.width = panelWidth - 4;
         this.textField25.text = "?";
         this.textField25.height = this.textField25.textHeight + 4;
         this.nuiComponent13.addChild(this.textField25);
         panelY += sectionHeight + 12;
         sectionHeight = 50;
         this.nuiComponent13.doAction151(panelX,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuiComponent13.doAction151(panelX + panelWidth,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuiComponent13.doAction487(panelX,panelY + sectionHeight,panelWidth / 2 - 32,panelColor,panelColor,1,0);
         this.nuiComponent13.doAction487(panelX + 1 + panelWidth / 2 + 32,panelY + sectionHeight,panelWidth / 2 - 32,panelColor,panelColor,0);
         label = new TextField();
         label.defaultTextFormat = new NTextFormat({
            "color":panelColor,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         label.x = panelX;
         label.width = panelWidth;
         label.text = " " + _("IDS_THROW_ANGLE") + " ";
         label.height = label.textHeight + 4;
         label.y = panelY + sectionHeight - label.height / 2;
         this.nuiComponent13.addChild(label);
         this.nuiComponent7 = new NUIComponent();
         this.nuiComponent7.setPos(panelX + 11,panelY + 6);
         this.nuiComponent7.draw(getBmp("ANGLE_AXIS"));
         this.nuiComponent13.addChild(this.nuiComponent7);
         index = 0;
         while(index < 5)
         {
            this.bitmapList3[index] = getBmp("ANGLE_" + 15 * (index + 1));
            this.bitmapList3[index].x = 2;
            this.bitmapList3[index].y = 5;
            this.nuiComponent7.addChild(this.bitmapList3[index]);
            index++;
         }
         var sectionHeight:int;
         var angleValueX:int = panelX + panelWidth / 2 + 4;
         var angleValueWidth:int = panelWidth / 2 - 16;
         this.nuiComponent13.doAction151(angleValueX,this.nuiComponent7.y + 7,this.nuiComponent7.height - 14,panelColor,panelColor,0.5);
         this.nuiComponent13.doAction151(angleValueX + angleValueWidth,this.nuiComponent7.y + 7,this.nuiComponent7.height - 14,panelColor,panelColor,0.5);
         this.nuiComponent13.doAction487(angleValueX,this.nuiComponent7.y + this.nuiComponent7.height - 7,angleValueWidth,panelColor,panelColor);
         this.nuiComponent13.doAction487(angleValueX,this.nuiComponent7.y + 7,angleValueWidth,panelColor,panelColor,0.5,0.5);
         this.textField4 = new TextField();
         this.textField4.defaultTextFormat = new NTextFormat({
            "color":13408563,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         this.textField4.x = angleValueX;
         this.textField4.width = angleValueWidth;
         this.textField4.text = "?";
         this.textField4.height = this.textField4.textHeight + 4;
         this.textField4.y = this.nuiComponent7.y + 7;
         this.nuiComponent13.addChild(this.textField4);
         button = new NButton(this.handleAngleUp,getBmp("ARROW_SMALL_BUTTON"),getBmp("ARROW_SMALL_BUTTON_OVER"),getBmp("ARROW_SMALL_BUTTON_PRESSED"));
         button.rotation = 90;
         button.setPos(angleValueX + angleValueWidth - 3,this.nuiComponent7.y - 5);
         this.nuiComponent13.addUIChild(button);
         button = new NButton(this.handlePrivatePress,getBmp("ARROW_SMALL_BUTTON"),getBmp("ARROW_SMALL_BUTTON_OVER"),getBmp("ARROW_SMALL_BUTTON_PRESSED"));
         button.setPos(angleValueX + 4,this.nuiComponent7.y + this.nuiComponent7.height + 6);
         button.rotation = -90;
         this.nuiComponent13.addUIChild(button);
         panelY += sectionHeight + 12;
         label = new TextField();
         label.defaultTextFormat = new NTextFormat({
            "color":panelColor,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         label.width = panelWidth;
         label.height = 16;
         label.text = _("IDS_CANCEL");
         this.nuiComponent13.drawRect(panelX,panelY,panelWidth,16,panelColor);
         button = new NButton(this.changeAmmoHandler,label);
         button.setPos(panelX,panelY);
         this.nuiComponent13.addUIChild(button);
         this.doAction695();
         panelY = 10;
         sectionHeight = 68;
         this.nuclearChat = new NUIComponent();
         this.nuclearChat.handlesMouse = false;
         this.nuclearChat.setPos(this.nuiComponent13.x,this.nuiComponent13.y);
         addUIChild(this.nuclearChat);
         this.nuclearChat.doAction151(panelX,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuclearChat.doAction151(panelX + panelWidth,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuclearChat.doAction487(panelX,panelY + sectionHeight,panelWidth / 2 - 16,panelColor,panelColor,1,0);
         this.nuclearChat.doAction487(panelX + 1 + panelWidth / 2 + 16,panelY + sectionHeight,panelWidth / 2 - 16,panelColor,panelColor,0);
         this.nuclearChat.doAction487(panelX + 16,panelY + sectionHeight - 18,panelWidth / 2 - 16,panelColor,panelColor,0);
         this.nuclearChat.doAction487(panelX + panelWidth / 2,panelY + sectionHeight - 18,panelWidth / 2 - 16,panelColor,panelColor,1,0);
         button = new NButton(this.onArrowLargeClick,getBmp("ARROW_LARGE_BUTTON"),getBmp("ARROW_LARGE_BUTTON_OVER"),getBmp("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(panelX - 12,panelY + 4);
         this.nuclearChat.addUIChild(button);
         button = new NButton(this.onArrowLargeClick,getBitmap5("ARROW_LARGE_BUTTON"),getBitmap5("ARROW_LARGE_BUTTON_OVER"),getBitmap5("ARROW_LARGE_BUTTON_PRESSED"));
         button.setPos(panelX + panelWidth + 13,panelY + 4);
         this.nuclearChat.addUIChild(button);
         this.loader1 = new Loader();
         this.nuclearChat.addChild(this.loader1);
         this.loader1.x = panelX + panelWidth / 2 - 2;
         this.loader1.y = panelY + sectionHeight / 2 - 10;
         this.loader1.contentLoaderInfo.addEventListener(Event.COMPLETE,this.weaponLoadHandler);
         this.loader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError2);
         index = 0;
         while(index < 2)
         {
            this.weaponName[index] = new TextField();
            this.weaponName[index].defaultTextFormat = new NTextFormat({
               "color":13408563,
               "size":9,
               "letterSpacing":-1
            });
            this.weaponName[index].x = panelX + 2;
            this.weaponName[index].y = panelY + sectionHeight - 18;
            this.weaponName[index].width = panelWidth - 4;
            this.weaponName[index].text = "?";
            this.weaponName[index].visible = false;
            this.weaponName[index].height = this.weaponName[index].textHeight + 4;
            this.nuclearChat.addChild(this.weaponName[index]);
            this.textFieldList2[index] = new TextField();
            this.textFieldList2[index].defaultTextFormat = new NTextFormat({
               "color":13408563,
               "size":9,
               "align":TextFormatAlign.RIGHT,
               "letterSpacing":-1
            });
            this.textFieldList2[index].x = panelX;
            this.textFieldList2[index].y = panelY + sectionHeight - 34;
            this.textFieldList2[index].text = "?";
            this.textFieldList2[index].visible = false;
            this.textFieldList2[index].width = panelWidth - 8;
            this.textFieldList2[index].height = this.textFieldList2[index].textHeight + 4;
            this.nuclearChat.addChild(this.textFieldList2[index]);
            this.textFieldList1[index] = new TextField();
            this.textFieldList1[index].defaultTextFormat = new NTextFormat({
               "color":panelColor,
               "size":9,
               "align":TextFormatAlign.CENTER,
               "letterSpacing":-1
            });
            this.textFieldList1[index].x = panelX;
            this.textFieldList1[index].width = panelWidth;
            this.textFieldList1[index].text = " " + _("IDS_SLOT_" + index) + " ";
            this.textFieldList1[index].height = this.textFieldList1[index].textHeight + 4;
            this.textFieldList1[index].y = panelY + sectionHeight - this.textFieldList1[index].height / 2;
            this.nuclearChat.addChild(this.textFieldList1[index]);
            this.textFieldList1[index].visible = false;
            index++;
         }
         this.nuiComponent19.setPos(panelX + panelWidth - 7,panelY + 3);
         this.nuiComponent19.alpha = 0.7;
         var index:int;
         var ammoBarBitmap:Bitmap = getBmp("AMMO_BAR");
         ammoBarBitmap.x = 0;
         ammoBarBitmap.y = 0;
         this.nuiComponent19.addChild(ammoBarBitmap);
         panelColor = ammoBarBitmap.bitmapData.getPixel(0,0);
         this.nuiComponent19.doAction487(0,0,ammoBarBitmap.width,panelColor,panelColor);
         this.nuiComponent19.doAction487(0,ammoBarBitmap.height - 1,ammoBarBitmap.width,panelColor,panelColor);
         this.nuiComponent19.doAction151(0,0,ammoBarBitmap.height - 1,panelColor,panelColor);
         this.nuiComponent19.doAction151(ammoBarBitmap.width - 1,0,ammoBarBitmap.height - 1,panelColor,panelColor);
         this.nuiComponent19.visible = false;
         ammoBarBitmap.mask = this.shape2;
         this.shape2.x = ammoBarBitmap.x;
         this.shape2.y = ammoBarBitmap.y;
         this.nuclearChat.addChild(this.nuiComponent19);
         this.nuiComponent19.addChild(this.shape2);
         panelY += sectionHeight + 12;
         sectionHeight = 40;
         this.nuclearChat.doAction151(panelX,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuclearChat.doAction151(panelX + panelWidth,panelY,sectionHeight,panelColor,panelColor,0);
         this.nuclearChat.doAction487(panelX,panelY + sectionHeight,panelWidth / 2 - 32,panelColor,panelColor,1,0);
         this.nuclearChat.doAction487(panelX + 1 + panelWidth / 2 + 32,panelY + sectionHeight,panelWidth / 2 - 32,panelColor,panelColor,0);
         label = new TextField();
         label.defaultTextFormat = new NTextFormat({
            "color":panelColor,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         label.x = panelX;
         label.width = panelWidth;
         label.text = " " + _("IDS_FIRE_MODE") + " ";
         label.height = label.textHeight + 4;
         label.y = panelY + sectionHeight - label.height / 2;
         this.nuclearChat.addChild(label);
         this.nuiComponent11 = new NUIComponent();
         this.nuiComponent11.setPos(panelX + 5,panelY);
         this.nuclearChat.addUIChild(this.nuiComponent11);
         panelY += sectionHeight + 10;
         button = new NButton(this.onArrowSmallClick,getBmp("ARROW_SMALL_BUTTON"),getBmp("ARROW_SMALL_BUTTON_OVER"),getBmp("ARROW_SMALL_BUTTON_PRESSED"));
         button.setPos(panelX - 12,panelY - 1);
         button.value = -1;
         this.nuclearChat.addUIChild(button);
         button = new NButton(this.onArrowSmallClick,getBitmap5("ARROW_SMALL_BUTTON"),getBitmap5("ARROW_SMALL_BUTTON_OVER"),getBitmap5("ARROW_SMALL_BUTTON_PRESSED"));
         button.setPos(panelX + panelWidth + 13,panelY - 1);
         this.nuclearChat.addUIChild(button);
         sectionHeight = 30;
         this.ammoType = new TextField();
         this.ammoType.defaultTextFormat = new NTextFormat({
            "color":13408563,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         this.ammoType.multiline = true;
         this.ammoType.wordWrap = true;
         this.ammoType.width = panelWidth;
         this.ammoType.text = "-";
         this.ammoType.height = sectionHeight - 7;
         this.ammoType.y = 7;
         var label:TextField;
         var ammoSprite:Sprite = new Sprite();
         ammoSprite.addChild(this.ammoType);
         ammoSprite.graphics.drawRect(0,0,panelWidth,sectionHeight);
         button = new NButton(this.onArrowSmallClick,ammoSprite);
         button.staticWidth = panelWidth;
         button.staticHeight = sectionHeight;
         button.setPos(panelX,panelY);
         this.nuclearChat.addUIChild(button);
         this.nuclearChat.doAction151(panelX,panelY,sectionHeight,panelColor,panelColor);
         this.nuclearChat.doAction151(panelX + panelWidth,panelY,sectionHeight,panelColor,panelColor);
         this.nuclearChat.doAction487(panelX,panelY + sectionHeight,panelWidth,panelColor,panelColor);
         this.nuclearChat.doAction487(panelX,panelY,panelWidth,panelColor,panelColor);
         this.updateWeapons();
         this.radioButton = new ToggleButton(this.handleRadioButton,getBmp("RADIO_BUTTON"),getBmp("RADIO_BUTTON_OVER"),getBmp("RADIO_BUTTON_PRESSED"));
         this.radioButton.setPos(156,92);
         addUIChild(this.radioButton);
         this.radioButton.toggled = Client.settings["enableRadio"];
         toggleButton = new ToggleButton(this.switchRadioOnButton,getBmp("RADIO_128"),getBmp("RADIO_128_OVER"),getBmp("RADIO_128_PRESSED"));
         toggleButton.value = 0;
         toggleButton.setPos(175,118);
         addUIChild(toggleButton);
         this.toggleButtonList1[0] = toggleButton;
         toggleButton = new ToggleButton(this.switchRadioOnButton,getBmp("RADIO_64"),getBmp("RADIO_64_OVER"),getBmp("RADIO_64_PRESSED"));
         toggleButton.value = 1;
         toggleButton.setPos(175,140);
         addUIChild(toggleButton);
         this.toggleButtonList1[1] = toggleButton;
         toggleButton = new ToggleButton(this.switchRadioOnButton,getBmp("RADIO_AAC"),getBmp("RADIO_AAC_OVER"),getBmp("RADIO_AAC_PRESSED"));
         toggleButton.value = 2;
         toggleButton.setPos(175,162);
         addUIChild(toggleButton);
         this.toggleButtonList1[2] = toggleButton;
         index = 0;
         while(index < this.toggleButtonList1.length)
         {
            this.toggleButtonList1[index].toggled = Client.settings["radioType"] == index;
            index++;
         }
         this.radioVolume2 = new SoundScroll(SoundScroll.TYPE_HORIZONTAL,this.radioVolumeHandler,getBmp("RADIO_VOLUME"),null,Client.settings["radioVolume"],0,0,76);
         this.radioVolume2.setPos(158,83);
         addUIChild(this.radioVolume2);
         this.doAction155(param2,param3);
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.nuclearChat.visible && this.nuclearChat.mouseX >= 25 && this.nuclearChat.mouseY >= 10 && this.nuclearChat.mouseX < 110 && this.nuclearChat.mouseY < 68)
         {
            if(this.main.weaponType[this.currentHand] != InventoryItem.WEAPON_TYPE_NEAR && this.main.weaponType[this.currentHand] != InventoryItem.WEAPON_TYPE_NEAR_USE)
            {
               this.main.useMenuInterval = setInterval(this.main.useMenuTimer,200);
               this.main.useMenuType = UseMenu.TYPE_LOAD;
               this.main.moveUse = true;
            }
         }
      }
      
      override public function tutorHighligt(param1:int) : void
      {
         switch(param1)
         {
            case GameConsts.GAME_CONSTS_CONST2:
               Main.instance.doAction131(this.inventoryButton.x + 2,this.inventoryButton.y + 2,this.inventoryButton.width - 6,this.inventoryButton.height - 5,this,15);
               break;
            case GameConsts.GAME_CONSTS_CONST1:
               Main.instance.doAction131(this.combatModeButton.x,this.combatModeButton.y,this.combatModeButton.width,this.combatModeButton.height,this);
               break;
         }
      }
      
      protected function radioVolumeHandler(param1:SoundScroll) : void
      {
         this.doAction187(param1.value);
         var settingsMenu:SettingsMenu = this.main.getMenu(BaseMenu.TYPE_0) as SettingsMenu;
         if(settingsMenu)
         {
            settingsMenu.updateSoundValues();
         }
      }
      
      public function doAction187(param1:Number) : void
      {
         if(this.radioVolume2.volume != param1)
         {
            this.radioVolume2.volume = param1;
         }
         Client.settings["radioVolume"] = param1;
         this.main.world.updateRadioVolume();
      }
      
      public function setUseSprite(param1:int, param2:String) : void
      {
         this.nuclearChat.visible = false;
         this.nuiComponent13.visible = true;
         if(this.intValue81 != param1)
         {
            intValue81 = param1;
            this.loader3.load(new URLRequest("icons/inv/" + (this.intValue81 == 0 ? "x" : "i" + this.intValue81) + ".png"));
         }
         this.textField25.text = param2;
      }
      
      public function clearInput() : void
      {
         this.nuclearChat.visible = true;
         this.nuiComponent13.visible = false;
      }
      
      protected function switchRadioOnButton(param1:ToggleButton) : void
      {
         this.doAction828(int(param1.value));
         var settingsMenu:SettingsMenu = this.main.getMenu(BaseMenu.TYPE_0) as SettingsMenu;
         if(settingsMenu)
         {
            settingsMenu.updateSoundValues();
         }
      }
      
      public function doAction828(param1:int) : void
      {
         var channelIndex:int = 0;
         while(channelIndex < this.toggleButtonList1.length)
         {
            this.toggleButtonList1[channelIndex].toggled = channelIndex == param1;
            channelIndex++;
         }
         Client.settings["radioType"] = param1;
         if(Client.settings["enableRadio"])
         {
            this.main.world.startRadio();
         }
      }
      
      protected function handleRadioButton(param1:ToggleButton) : void
      {
         if(Client.settings["enableRadio"])
         {
            this.updateUserlistText();
         }
         else
         {
            this.enableRadio();
         }
         var settingsMenu:SettingsMenu = this.main.getMenu(BaseMenu.TYPE_0) as SettingsMenu;
         if(settingsMenu)
         {
            settingsMenu.updateSoundValues();
         }
      }
      
      public function enableRadio() : void
      {
         this.main.world.startRadio();
         this.radioButton.toggleOn();
      }
      
      public function updateUserlistText() : void
      {
         this.main.world.stopRadio();
         this.radioButton.toggleOff();
      }
      
      protected function changeAmmoHandler(param1:NButton) : void
      {
         GameSocket.socket.sendStr("gc");
      }
      
      protected function onArrowSmallClick(param1:NButton) : void
      {
         GameSocket.socket.sendStr("ax" + ((param1.value == -1) ? "|0" : ""));
      }
      
      protected function onArrowLargeClick(param1:NButton) : void
      {
         GameSocket.socket.sendChangeHand(this.currentHand == 0 ? 1 : 0);
      }
      
      protected function onCharacterClick(param1:Object) : void
      {
         var characterMenu:CharacterMenu = this.main.getMenu(BaseMenu.TYPE_19) as CharacterMenu;
         if(characterMenu == null)
         {
            GameSocket.socket.getCharMenu();
         }
         else
         {
            characterMenu.closeMenu();
         }
      }
      
      protected function handleRadionOn(param1:Object) : void
      {
         if(this.main.isTutorial)
         {
            return;
         }
         var inventoryMenu:Inventory = this.main.getMenu(BaseMenu.TYPE_INVENTORY) as Inventory;
         if(inventoryMenu == null)
         {
            GameSocket.socket.getInventory();
         }
         else
         {
            GameSocket.socket.sendStr("ia");
         }
      }
      
      protected function onMapClick(param1:Object) : void
      {
         if(this.main.isTutorial)
         {
            return;
         }
         var mapMenu:MapMenu = this.main.getMenu(BaseMenu.TYPE_11) as MapMenu;
         if(mapMenu == null)
         {
            GameSocket.socket.sendGetMap();
         }
         else
         {
            mapMenu.closeMenu();
         }
      }
      
      protected function onQuestsClick(param1:Object) : void
      {
         if(this.main.isTutorial)
         {
            return;
         }
         var questMenu:QuestLog = this.main.getMenu(BaseMenu.TYPE_BOT_4) as QuestLog;
         if(questMenu == null)
         {
            GameSocket.socket.sendQuestLogRequest();
         }
         else
         {
            questMenu.closeMenu();
         }
      }
      
      public function get baseOpenedValue() : Boolean
      {
         return this.baseOpened;
      }
      
      public function get auto() : Boolean
      {
         return this._autoChat;
      }
      
      protected function onAutoModeClick(param1:ToggleButton) : void
      {
         param1.doAction172();
         _autoChat = param1.toggled;
         Client.settings["autoBattleMode"] = this._autoChat;
      }
      
      protected function handleAutoButton(param1:ToggleButton) : void
      {
         param1.doAction172();
         battleStateOn = param1.toggled;
         Main.instance.checkTutorialSelector(GameConsts.GAME_CONSTS_CONST1);
      }
      
      public function set baseOpenedValue(param1:Boolean) : void
      {
         if(this.baseOpened != param1 && this.timer == null)
         {
            baseOpened = param1;
            this.autoButton.visible = !param1;
            this.logoutButton.visible = param1;
            timer = new Timer(20);
            this.timer.addEventListener(TimerEvent.TIMER,param1 ? this.doAction406 : this.doAction436);
            this.timer.start();
            GameSocket.socket.doAction720();
         }
      }
      
      protected function doAction436(param1:TimerEvent) : void
      {
         y = Math.max(this.stageHeight - height,y - height / (HIDE_TIME / this.timer.delay));
         if(y == this.stageHeight - height)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.doAction436);
            this.timer.stop();
            timer = null;
         }
      }
      
      protected function doAction406(param1:TimerEvent) : void
      {
         y = Math.min(this.stageHeight - HIDE_82,y + height / (HIDE_TIME / this.timer.delay));
         if(y == this.stageHeight - HIDE_82)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.doAction406);
            this.timer.stop();
            timer = null;
         }
      }
      
      protected function onMinimizeClick(param1:Object) : void
      {
         baseOpenedValue = true;
      }
      
      protected function onMaximizeClick(param1:Object) : void
      {
         baseOpenedValue = false;
      }
      
      public function doAction155(param1:int, param2:int) : void
      {
         this.stageWidth = param1;
         this.stageHeight = param2;
         if(this.timer == null)
         {
            y = this.baseOpenedValue ? param2 - HIDE_82 : param2 - height;
         }
      }
      
      public function setFireType(param1:int) : void
      {
         this.main.fireType[this.currentHand] = param1;
         this.doAction182();
      }
      
      public function get throwAngleIdx() : int
      {
         return this._throwAngleIdx;
      }
      
      public function get battleStateOn() : Boolean
      {
         return this.forceAdd;
      }
      
      public function set battleStateOn(param1:Boolean) : void
      {
         if(param1 != this.forceAdd)
         {
            forceAdd = param1;
            if(PlayerItem.selectedTarget)
            {
               PlayerItem.selectedTarget.removeSelectTarget();
               PlayerItem.selectedTarget.addSelectTarget(param1);
            }
            this.combatModeButton.toggled = param1;
            GameSocket.socket.doAction720();
         }
      }
      
      protected function switchBattleState() : void
      {
         if(this.addon1)
         {
            removeChild(this.addon1);
            addon1 = null;
         }
         if(this.addonType > 0)
         {
            addon1 = Addon.create(this.addonType);
            this.addon1.setPos(width - this.addon1.width,84 - this.addon1.height);
            addChild(this.addon1);
         }
         this.main.nuclearWorld.updateAddonLines();
      }
      
      public function handleStateButton(param1:int) : void
      {
         this.main.currentWeapon = param1;
         this.updateWeapons();
      }
      
      public function updateWeapons() : void
      {
         currentHand = this.main.currentWeapon;
         var handIndex:int = 0;
         while(handIndex < 2)
         {
            this.textFieldList1[handIndex].visible = this.weaponName[handIndex].visible = handIndex == this.currentHand;
            handIndex++;
         }
         if(this.intValue90 != this.main.userCharacter.weaponImg[this.currentHand])
         {
            intValue90 = this.main.userCharacter.weaponImg[this.currentHand];
            this.loader1.load(new URLRequest("icons/inv/" + (this.intValue90 == 0 ? "x" : "i" + this.intValue90) + ".png"));
         }
         this.weaponName[this.currentHand].text = this.main.userCharacter.weaponName[this.currentHand] + " ";
         this.doAction182();
         this.updateWeaponAmmo();
      }
      
      protected function doAction182() : void
      {
         this.nuiComponent11.disposeAllChilds();
         this.nuiComponent11.graphics.clear();
         var frameColor:uint = 13214013;
         var buttonWidth:int = 100;
         var buttonHeight:int = 16;
         var label:TextField = new TextField();
         var button:NButton;
         label.defaultTextFormat = new NTextFormat({
            "color":frameColor,
            "size":9,
            "align":TextFormatAlign.CENTER,
            "letterSpacing":-1
         });
         label.width = buttonWidth;
         label.height = buttonHeight;
         switch(this.main.weaponType[this.currentHand])
         {
            case InventoryItem.WEAPON_TYPE_NEAR:
               this.nuiComponent11.drawRect(0,10,buttonWidth,buttonHeight,frameColor);
               label.y = 10;
               label.text = _("IDS_NEAR");
               this.nuiComponent11.addChild(label);
               break;
            case InventoryItem.WEAPON_TYPE_5:
               this.nuiComponent11.drawRect(0,10,buttonWidth,buttonHeight,frameColor);
               label.y = 10;
               label.text = _("IDS_SINGLE_0");
               this.nuiComponent11.addChild(label);
               break;
            case InventoryItem.FIRE_AUTO:
               this.nuiComponent11.drawRect(0,10,buttonWidth,buttonHeight,frameColor);
               label.text = _("IDS_SINGLE_" + this.main.ammoType[this.currentHand]);
               label.y = 10;
               this.nuiComponent11.addChild(label);
               break;
            case InventoryItem.WEAPON_TYPE_2:
               if(this.main.fireType[this.currentHand] == InventoryItem.AMMO_TYPE_NORMAL)
               {
                  this.nuiComponent11.drawRect(0,0,buttonWidth,buttonHeight,frameColor);
               }
               else
               {
                  this.nuiComponent11.doAction487(0,buttonHeight,buttonWidth,frameColor,frameColor);
                  this.nuiComponent11.doAction151(0,0,buttonHeight,frameColor,frameColor,0);
                  this.nuiComponent11.doAction151(buttonWidth,0,buttonHeight,frameColor,frameColor,0);
               }
               label.text = _("IDS_SINGLE_" + this.main.ammoType[this.currentHand]);
               button = new NButton(this.doAction135,label);
               button.value = InventoryItem.AMMO_TYPE_NORMAL;
               this.nuiComponent11.addUIChild(button);
               if(this.main.fireType[this.currentHand] == InventoryItem.TRAUM_HARD)
               {
                  this.nuiComponent11.drawRect(0,18,buttonWidth,buttonHeight,frameColor);
               }
               else
               {
                  this.nuiComponent11.doAction487(0,18,buttonWidth,frameColor,frameColor);
                  this.nuiComponent11.doAction151(0,18,buttonHeight,frameColor,frameColor,1,0);
                  this.nuiComponent11.doAction151(buttonWidth,18,buttonHeight,frameColor,frameColor,1,0);
               }
               label = new TextField();
               label.defaultTextFormat = new NTextFormat({
                  "color":frameColor,
                  "size":9,
                  "align":TextFormatAlign.CENTER,
                  "letterSpacing":-1
               });
               label.width = buttonWidth;
               label.height = buttonHeight;
               label.text = _("IDS_AUTO_" + this.main.ammoType[this.currentHand]);
               button = new NButton(this.doAction135,label);
               button.value = InventoryItem.TRAUM_HARD;
               button.y = 17;
               this.nuiComponent11.addUIChild(button);
               break;
            case InventoryItem.WEAPON_TYPE_AUTO:
               this.nuiComponent11.drawRect(0,10,buttonWidth,buttonHeight,frameColor);
               label.text = _("IDS_AUTO_" + this.main.ammoType[this.currentHand]);
               label.y = 10;
               this.nuiComponent11.addChild(label);
               break;
            case InventoryItem.WEAPON_TYPE_NEAR_USE:
               this.nuiComponent11.drawRect(0,10,buttonWidth,buttonHeight,frameColor);
               label.text = _("IDS_NEAR_USE");
               button = new NButton(this.logoutWarning,label);
               button.y = 10;
               this.nuiComponent11.addUIChild(button);
               break;
         }
      }
      
      protected function logoutWarning(param1:NButton) : void
      {
         this.main.showNotifyMenu(_("IDS_HOWTO_USE_TOOL"));
      }
      
      protected function doAction135(param1:NButton) : void
      {
         if(this.main.weaponType[this.currentHand] == InventoryItem.WEAPON_TYPE_2)
         {
            GameSocket.socket.sendClanChatText(int(param1.value));
         }
      }
      
      protected function weaponLoadHandler(param1:Event) : void
      {
         param1.target.content.x -= param1.target.content.width / 2;
         param1.target.content.y -= param1.target.content.height / 2;
      }
      
      protected function onContentLoaderInfoIoError2(param1:Event) : void
      {
      }
      
      public function updateWeaponAmmo() : void
      {
         var handIndex:int = 0;
         var barHeight:int;
         while(handIndex < 2)
         {
            this.textFieldList2[handIndex].visible = handIndex == this.currentHand;
            handIndex++;
         }
         if(this.main.weaponType[this.currentHand] != InventoryItem.WEAPON_TYPE_NEAR && this.main.weaponType[this.currentHand] != InventoryItem.WEAPON_TYPE_NEAR_USE)
         {
            this.textFieldList2[this.currentHand].text = this.main.weaponCharge[this.currentHand] + "/" + this.main.weaponAmmo[this.currentHand];
            this.nuiComponent19.visible = true;
            barHeight = 47 * this.main.weaponCharge[this.currentHand] / this.main.weaponAmmo[this.currentHand];
            barHeight = Math.max(0,Math.min(barHeight,47));
            this.shape2.graphics.clear();
            this.shape2.graphics.beginFill(0);
            this.shape2.graphics.drawRect(0,47 - barHeight,4,barHeight);
            this.shape2.graphics.endFill();
         }
         else
         {
            this.textFieldList2[this.currentHand].visible = false;
            this.nuiComponent19.visible = false;
         }
         this.ammoType.text = this.main.weaponCurrentAmmo[this.currentHand];
      }
      
      public function handlePrivatePress(param1:Object = null) : void
      {
         if(this.throwAngleIdx > 0)
         {
            --this._throwAngleIdx;
            this.doAction695();
         }
      }
      
      public function handleAngleUp(param1:Object = null) : void
      {
         if(this.throwAngleIdx < array9.length - 1)
         {
            ++this._throwAngleIdx;
            this.doAction695();
         }
      }
      
      protected function doAction695() : void
      {
         var angleIndex:int = 0;
         while(angleIndex < this.bitmapList3.length)
         {
            this.bitmapList3[angleIndex].visible = angleIndex == this._throwAngleIdx;
            angleIndex++;
         }
         this.textField4.text = array9[this._throwAngleIdx] + "°";
      }
      
      public function get addonType() : int
      {
         return this._addonType;
      }
      
      public function set addonType(param1:int) : void
      {
         if(param1 != this._addonType)
         {
            _addonType = param1;
            this.switchBattleState();
         }
      }
      
      public function set addonValue(param1:int) : void
      {
         if(this.addon1 != null)
         {
            this.addon1.value = param1;
         }
      }
   }
}

