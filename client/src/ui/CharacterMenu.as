package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.ui.BaseButton;
   import core.ui.UIElement;
   import events.*;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.*;
   
   public class CharacterMenu extends NuclearMenu
   {
      
      private static const ramDL:Bitmap = new LINE();
      
      private static const ramDR:Bitmap = new RAM_DL();
      
      private static const ramSide:Bitmap = new RAM_DR();
      
      private static const ramTop:Bitmap = new RAM_SIDE();
      
      private static const ramUL:Bitmap = new RAM_TOP();
      
      private static const ramUR:Bitmap = new RAM_UL();
      
      private static const ramBottom:Bitmap = new RAM_UR();
      
      public static var PERK_SELECT_X:int = 80;
      
      public static var PERK_SELECT_Y:int = 116;
      
      public static var PERK_SELECT_WIDTH:int = 365;
      
      public static var PERK_SELECT_HEIGHT:int = 74;
      
      public static var CHAR_TYPE_CUSTOM:int = 0;
      
      public static var CHAR_TYPE_LIGHT:int = 1;
      
      public static var CHAR_TYPE_RIFLEMAN:int = 2;
      
      public static var CHAR_TYPE_HEAVY:int = 3;
      
      public static var OWN_PERK_SELECT_X:int = 103;
      
      public static var OWN_PERK_SELECT_Y:int = 261;
      
      public static var OWN_PERK_SELECT_WIDTH:int = 334;
      
      public static var OWN_PERK_SELECT_HEIGHT:int = 110;
      
      public static var TRAUM_WIDTH:int = 334;
      
      public static var TRAUM_HEIGHT:int = 90;
      
      public static var LOCATIONS_MENU_WIDTH:int = 800;
      
      public static var LOCATIONS_MENU_HEIGHT:int = 500;
      
      public static var MALE_AVATARS_COUNT:int = 15;
      
      public static var FEMALE_AVATARS_COUNT:int = 9;
      
      public static const BATTLE_SKILLS_COUNT:int = 4;
      
      public static const PEACE_SKILLS_COUNT:int = 4;
      
      public static const CALCULATED_HP:int = 0;
      
      public static const CALCULATED_WEIGHT:int = 1;
      
      public static const CALCULATED_HANDS_DAMAGE:int = 2;
      
      public static const CALCULATED_CRITICAL_PROB:int = 3;
      
      public static const CALCULATED_RADIATION_STABILITY:int = 4;
      
      public static const CALCULATED_EVADE_PROBABILITY:int = 5;
      
      public static const CALCULATED_SKILL_POINTS:int = 6;
      
      public static const CALCULATED_COUNT:int = 7;
      
      public static const TAB_MAIN:int = 0;
      
      public static const TAB_STAT:int = 1;
      
      public static const TAB_SKILL:int = 2;
      
      public static const TAB_PERK:int = 3;
      
      public static const TAB_COUNT:int = 4;
      
      public static var AVATAR_GROUPS_COUNT:Array = new Array(4,2);
      
      public static var AVATAR_IN_GROUP:int = 4;
      
      public static var PRIORITY_BATTLE_SKILL_COUNT:int = 2;
      
      public static var PRIORITY_PEACE_SKILL_COUNT:int = 2;
      
      public static var INFO_MENU_WIDTH:int = 236;
      
      public static var INFO_MENU_HEIGHT:int = 314;
      
      public static var MENU_WIDTH:int = 658;
      
      public static var MENU_HEIGHT:int = 427;
      
      private static var AVATAR_Y_COORD:Array = new Array(94,155);
      
      private static var AVATAR_WIDTH:int = 43;
      
      private static var AVATAR_HEIGHT:int = 57;
      
      private static var SELECTOR_OFS_X:int = 3;
      
      private static var SELECTOR_OFS_Y:int = 4;
      
      public var data:Array;
      
      private var traumButtons:Array;
      
      private var traumSpriteButtons:Array;
      
      private var traumUID:int = 0;
      
      private var nextButton:BaseButton;
      
      private var previousBar:int = 100500;
      
      private var curApear:int = 0;
      
      private var tabButtons:Array = new Array(TAB_COUNT);
      
      private var submenu:NUIComponent;
      
      private var submenuItems:Array = new Array();
      
      private var textMenu:UIElement;
      
      private var city:NTextInput;
      
      private var country:NTextInput;
      
      private var about:NTextInput;
      
      private var nameTF:NTextInput;
      
      private var messageTF:TextField;
      
      private var textField27:TextField;
      
      private var array3:Array = new Array();
      
      private var array103:Array = new Array();
      
      private var notPressedBmp:Array;
      
      private var pressedBmp:Array;
      
      private var overBmp:Array;
      
      private var array119:Array = new Array();
      
      private var array62:Array = new Array();
      
      private var doneBmp:Array;
      
      private var nextBmp:Array;
      
      private var avatars:Array = new Array();
      
      private var gameBitmap1:GameBitmap;
      
      private var array84:Array = new Array();
      
      private var statLabels:Array = new Array(Character.STAT_COUNT);
      
      private var statCounts:Array = new Array(Character.STAT_COUNT);
      
      private var statsAvaible:int = 0;
      
      private var maxStats:int = 0;
      
      public var typeText:TextField;
      
      private var avaloader:Loader;
      
      public var menu:NuclearMenu;
      
      public var character:Character;
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var selectedTab:int;
      
      private var rectSprites:Array;
      
      private var avatarButtons:Array;
      
      private var avatarSelector:Bitmap;
      
      private var selectedAvatar:int = -1;
      
      private var charTypeSelector:Bitmap;
      
      private var selectedCharType:int = 0;
      
      private var enabledTab:int = 0;
      
      private var errorMessage:String = "";
      
      private var battleSkillCheck:Array;
      
      private var peaceSkillCheck:Array;
      
      private var battleSkillBtn:Array;
      
      private var peaceSkillBtn:Array;
      
      private var battleSkillCheckBool:Array = new Array(BATTLE_SKILLS_COUNT);
      
      private var peaceSkillCheckBool:Array = new Array(PEACE_SKILLS_COUNT);
      
      private var calculatedParams:Array;
      
      private var statBtn:Array;
      
      private var main:Main;
      
      private var infoMenu:NUIComponent = null;
      
      private var infoMenuItems:Array = new Array();
      
      private var perkScrollSprite:ScrollSprite;
      
      private var ownPerkScrollSprite:ScrollSprite;
      
      private var traumScrollSprite:ScrollSprite;
      
      private var avaiblePerks:Array;
      
      private var avaiblePerksBool:Array = new Array(Character.MAX_PERK_COUNT);
      
      private var avaiblePerksCheck:Array;
      
      private var perks:Array;
      
      private var statsCountTF:TextField;
      
      private var isCharCreate:Boolean;
      
      private var skillCount:Array = new Array(Character.CUR_SKILL_COUNT);
      
      private var canConfirm:Boolean = false;
      
      public function CharacterMenu(param1:Main, param2:Character, param3:Boolean = false, param4:Array = null, param5:int = 0)
      {
         super();
         this.avatarSelector = getBmp("AVA_RAMKA");
         this.charTypeSelector = getBmp("CHAR_SELECTED");
         this.notPressedBmp = new Array(getBmp("MAIN_BUTTON"),getBmp("STAT_BUTTON"),getBmp("UMEN_BUTTON"),getBmp("PERK_BUTTON"));
         this.pressedBmp = new Array(getBmp("MAIN_BUTTON_PRESSED"),getBmp("STAT_BUTTON_PRESSED"),getBmp("UMEN_BUTTON_PRESSED"),getBmp("PERK_BUTTON_PRESSED"));
         this.overBmp = new Array(getBmp("MAIN_BUTTON_OVER"),getBmp("STAT_BUTTON_OVER"),getBmp("UMEN_BUTTON_OVER"),getBmp("PERK_BUTTON_OVER"));
         this.doneBmp = new Array(getBmp("DONE_BUTTON"),getBmp("DONE_BUTTON_OVER"),getBmp("DONE_BUTTON_PRESSED"));
         this.nextBmp = new Array(getBmp("NEXT_BUTTON"),getBmp("NEXT_BUTTON_OVER"),getBmp("NEXT_BUTTON_PRESSED"));
         this.isCharCreate = param3;
         this.character = param2;
         this.main = param1;
         this.dragable = !this.isCharCreate;
         this.socket = param1.socket;
         this.terminal = this.terminal;
         var backgroundBitmap:Bitmap = getBmp("STATS_MENU_BACK");
         graphics.beginFill(1776411,1);
         graphics.drawRect(4,4,MENU_WIDTH - 8,MENU_HEIGHT - 4);
         graphics.endFill();
         draw(backgroundBitmap,16,59);
         drawFrame(0,0,MENU_WIDTH,MENU_HEIGHT + 4);
         if(this.isCharCreate)
         {
            this.initCreateCharacterValues();
         }
         else
         {
            this.initMenuCharacterValues();
         }
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13408825;
         titleFormat.size = 12;
         titleFormat.bold = true;
         var messageFormat:TextFormat = new TextFormat();
         messageFormat.font = "Verdana";
         messageFormat.color = 10187041;
         messageFormat.size = 10;
         messageFormat.bold = false;
         if(this.isCharCreate)
         {
            this.typeText = createTextField(237,12,200,titleFormat,getString("IDS_CHAR_CREATION"));
            this.messageTF = createTextField(23,386,530,messageFormat,getString("IDS_DESCRIPTION_0"));
         }
         else
         {
            this.typeText = createTextField(274,12,200,titleFormat,getString("IDS_CHAR_WINDOW"));
            this.messageTF = createTextField(23,386,530,messageFormat,getString("IDS_DESCRIPTION_GM_0"));
         }
         addChild(this.typeText);
         this.messageTF.wordWrap = true;
         addChild(this.messageTF);
         this.selectedTab = TAB_MAIN;
         var index:int = 0;
         var tabX:int = 17;
         var skillSprite:Sprite;
         var extraSprite:Sprite;
         index = 0;
         while(index < TAB_COUNT)
         {
            if(index == this.selectedTab)
            {
               this.tabButtons[index] = addNewButton(tabX,33,this.overBmp[index],this.overBmp[index],this.pressedBmp[index],this.barPress,index);
            }
            else
            {
               this.tabButtons[index] = addNewButton(tabX,33,this.notPressedBmp[index],this.overBmp[index],this.pressedBmp[index],this.barPress,index);
            }
            this.tabButtons[index].disableAlpha = 0.5;
            tabX += 158;
            index++;
         }
         index = 0;
         while(index <= Character.SKILL_COUNT)
         {
            skillSprite = new Sprite();
            skillSprite.graphics.beginFill(2762011);
            skillSprite.graphics.drawRect(0,0,14,14);
            skillSprite.graphics.endFill();
            skillSprite.width = 14;
            skillSprite.height = 14;
            this.array119.push(skillSprite);
            index++;
         }
         index = 0;
         while(index <= 3)
         {
            extraSprite = new Sprite();
            extraSprite.graphics.beginFill(2762011);
            extraSprite.graphics.drawRect(0,0,14,14);
            extraSprite.graphics.endFill();
            extraSprite.width = 14;
            extraSprite.height = 14;
            this.array119.push(extraSprite);
            index++;
         }
         this.submenu = new NUIComponent();
         this.submenu.x = 200;
         this.submenu.width = 0;
         this.submenu.height = 0;
         this.submenu.visible = true;
         addUIChild(this.submenu);
         if(this.isCharCreate)
         {
            this.nextButton = addNewButton(543,389,this.nextBmp[0],this.nextBmp[1],this.nextBmp[2],this.nextUI,-1);
         }
         else
         {
            this.nextButton = addNewButton(543,389,this.doneBmp[0],this.doneBmp[1],this.doneBmp[2],this.applyChange,-1);
         }
         this.enableTabs();
         this.gameBitmap1 = new GameBitmap();
         addChild(this.gameBitmap1);
         this.gameBitmap1.setPos(89,96);
         this.startMenu();
         this.loadAppearance();
         if(!this.isCharCreate)
         {
            processIntervalValue = 5000;
         }
         UnitEventDispatcher.instance.addListener(EventType.EffectAdded,this.onEffectChanged);
         UnitEventDispatcher.instance.addListener(EventType.EffectUpdated,this.onEffectChanged);
         UnitEventDispatcher.instance.addListener(EventType.EffectRemoved,this.onEffectChanged);
      }
      
      private function onEffectChanged(param1:Object) : void
      {
         if(this.selectedTab == TAB_MAIN)
         {
            this.setTraums();
         }
      }
      
      override protected function process() : void
      {
         if(this.selectedTab == TAB_MAIN)
         {
            this.onEffectChanged(null);
         }
      }
      
      public function setNextButton() : void
      {
         this.nextButton.upState = this.nextBmp[0];
         this.nextButton.overState = this.nextBmp[1];
         this.nextButton.downState = this.nextBmp[2];
      }
      
      public function setDoneButton() : void
      {
         this.nextButton.upState = this.doneBmp[0];
         this.nextButton.overState = this.doneBmp[1];
         this.nextButton.downState = this.doneBmp[2];
      }
      
      public function createCreateCharacter() : void
      {
         create(MENU_WIDTH,MENU_HEIGHT);
      }
      
      public function createCharacterMenu(param1:Boolean = true, param2:uint = 1776411, param3:Number = 1) : void
      {
         create(MENU_WIDTH,MENU_HEIGHT,param1,param2,param3);
         addDefaultCloseButton(618,12);
      }
      
      override public function dispose() : void
      {
         UnitEventDispatcher.instance.removeListener(EventType.EffectAdded,this.onEffectChanged);
         UnitEventDispatcher.instance.removeListener(EventType.EffectUpdated,this.onEffectChanged);
         UnitEventDispatcher.instance.removeListener(EventType.EffectRemoved,this.onEffectChanged);
         this.gameBitmap1.dispose();
         this.clearAllChilds();
         super.dispose();
      }
      
      private function clearAllChilds() : void
      {
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         this.submenu.disposeAllChilds();
         traumScrollSprite = null;
         this.submenu.graphics.clear();
      }
      
      public function doAction831() : void
      {
      }
      
      private function addCheckBox(param1:int, param2:int, param3:Function, param4:int = 0) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         this.submenuItems.push(checkBox);
         this.submenu.addUIChild(checkBox);
         return checkBox;
      }
      
      private function createCheckBox(param1:int, param2:int, param3:Function, param4:int = 0, param5:int = -1, param6:int = -1) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         this.submenuItems.push(checkBox);
         return checkBox;
      }
      
      public function addNBut(param1:int, param2:int, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Function = null, param7:int = 0) : NButton
      {
         var button:NButton = new NButton(param6,param3,param4,param5,param3);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      public function addDisplayBut(param1:int, param2:int, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject, param6:Function = null, param7:int = 0) : NButton
      {
         var button:NButton = new NButton(param6,param3,param4,param5,null);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      public function createDisplayBut(param1:int, param2:int, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject, param6:Function = null, param7:int = 0, param8:String = "") : NButton
      {
         var button:NButton = new NButton(param6,param3,param4,param5,null,param8);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenuItems.push(button);
         return button;
      }
      
      public function startMenu() : void
      {
         switch(this.selectedTab)
         {
            case TAB_MAIN:
               this.createAvatarMenu();
               break;
            case TAB_STAT:
               this.createCharCreateStatsMenu();
               break;
            case TAB_SKILL:
               this.createCharSkillsMenu();
               break;
            case TAB_PERK:
               this.createCharPerkMenu();
               break;
         }
         if(this.isCharCreate)
         {
            this.messageTF.text = getString("IDS_DESCRIPTION_" + this.selectedTab);
         }
         else
         {
            this.messageTF.text = getString("IDS_DESCRIPTION_GM_" + this.selectedTab);
         }
         if(this.isCharCreate)
         {
            if(this.selectedTab == TAB_COUNT - 1)
            {
               this.nextButton.upState = this.doneBmp[0];
               this.nextButton.overState = this.doneBmp[1];
               this.nextButton.downState = this.doneBmp[2];
            }
            else
            {
               this.nextButton.upState = this.nextBmp[0];
               this.nextButton.overState = this.nextBmp[1];
               this.nextButton.downState = this.nextBmp[2];
            }
         }
      }
      
      public function doAction598(param1:int) : void
      {
         if(param1 != this.selectedTab)
         {
            this.barPress(this.tabButtons[param1]);
         }
      }
      
      public function barPress(param1:Object) : void
      {
         this.tabButtons[this.selectedTab].upState = this.notPressedBmp[this.tabButtons[this.selectedTab].value];
         param1.upState = this.overBmp[param1.value];
         selectedTab = param1.value;
         this.clearAllChilds();
         this.startMenu();
      }
      
      public function initMenuCharacterValues() : void
      {
         var skillIndex:int = 0;
         statsAvaible = 0;
         selectedAvatar = this.character.avatarImg % 1000;
         curApear = this.character.images[Character.APPEARANCE_IDX] % 1000;
         skillIndex = 0;
         while(skillIndex < BATTLE_SKILLS_COUNT)
         {
            if(this.character.prioritySkills >> skillIndex & 1)
            {
               this.battleSkillCheckBool[skillIndex] = true;
            }
            skillIndex++;
         }
         skillIndex = 0;
         while(skillIndex < PEACE_SKILLS_COUNT)
         {
            if(this.character.prioritySkills >> skillIndex + BATTLE_SKILLS_COUNT & 1)
            {
               this.peaceSkillCheckBool[skillIndex] = true;
            }
            skillIndex++;
         }
      }
      
      public function initCreateCharacterValues() : void
      {
         var statIndex:int = 0;
         maxStats = Character.START_STAT_AVAIBLE;
         statsAvaible = Character.START_STAT_AVAIBLE;
         statIndex = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            this.character.stats[statIndex] = Character.START_STAT_VAL;
            statIndex++;
         }
         this.character.avaiblePerks = 15;
         this.character.perks = 0;
      }
      
      private function createCharCreateStatsMenu() : void
      {
         statBtn = new Array();
         calculatedParams = new Array();
         var rowY:int = 99;
         if(this.isCharCreate)
         {
            pointsBackground = new Sprite();
            updateBgUI(pointsBackground,false,334,16);
            pointsBackground.x = 85;
            pointsBackground.y = 210;
            this.submenu.addChild(pointsBackground);
         }
         if(this.isCharCreate)
         {
            this.submenu.draw(bitmap16,98,205);
         }
         else
         {
            this.submenu.draw(bitmap16,98,215);
         }
         this.submenu.draw(bitmap16,78,380);
         var index:int;
         var valueFormat:TextFormat = new TextFormat();
         valueFormat.font = "Verdana";
         valueFormat.align = TextFormatAlign.CENTER;
         valueFormat.color = 13408825;
         valueFormat.size = 12;
         valueFormat.bold = true;
         var button:BaseButton;
         var statFormat:TextFormat = new TextFormat();
         statFormat.font = "Verdana";
         statFormat.color = 10187041;
         statFormat.size = 12;
         statFormat.bold = true;
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,334,16);
            button = this.addDisplayBut(85,rowY - 4,rowBackground,rowBackground,rowBackground,this.handleStatBtnPress,index);
            this.statBtn.push(button);
            button.staticHeight = 16;
            button.staticWidth = 260;
            this.statLabels[index] = createTextField(93,rowY - 5,200,statFormat,getString("IDS_STAT_" + index) + ":");
            this.submenu.addChild(this.statLabels[index]);
            if(this.isCharCreate)
            {
               this.statCounts[index] = createTextField(359,rowY - 5,40,valueFormat);
            }
            else
            {
               this.statCounts[index] = createTextField(373,rowY - 5,40,valueFormat);
            }
            button.textField1 = this.statLabels[index];
            this.submenu.addChild(this.statCounts[index]);
            if(this.isCharCreate)
            {
               this.addDecButton(350,rowY - 6,this.handleDecStatButton,index);
               this.addAddButton(392,rowY - 6,this.handleAddStatButton,index);
            }
            rowY += 18;
            index++;
         }
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.align = TextFormatAlign.CENTER;
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.bold = true;
         var secondaryFormat:TextFormat = new TextFormat();
         var label:TextField;
         var pointsBackground:Sprite;
         var rowBackground:Sprite;
         secondaryFormat.font = "Verdana";
         secondaryFormat.color = 10187041;
         secondaryFormat.size = 12;
         index = 0;
         while(index < CALCULATED_COUNT)
         {
            this.submenu.addChild(createTextField(99,251 + index * 18,250,secondaryFormat,getString("IDS_SEC_PARAM_" + index.toString())));
            label = createTextField(365,251 + index * 18,60,centeredFormat);
            this.submenu.addChild(label);
            this.calculatedParams.push(label);
            index++;
         }
         if(this.isCharCreate)
         {
            statsCountTF = createTextField(361,208,40,valueFormat);
            this.submenu.addChild(this.statsCountTF);
            this.submenu.addChild(createTextField(95,208,332,headingFormat,getString("IDS_STAT_ADD") + ":"));
         }
         this.submenu.addChild(createTextField(151,231,220,headingFormat,getString("IDS_SEC_PARAMS")));
         if(this.isCharCreate)
         {
            this.submenu.addChild(createTextField(158,68,220,headingFormat,getString("IDS_MAIN_PARAMS")));
         }
         else
         {
            this.submenu.addChild(createTextField(158,66,220,headingFormat,getString("IDS_MAIN_PARAMS")));
         }
         this.updateCharacterLabels();
      }
      
      private function updateAvatarSprites() : void
      {
         var avatarIndex:int = 0;
         if(this.isCharCreate)
         {
            avatarIndex = 0;
            while(avatarIndex < AVATAR_GROUPS_COUNT[this.character.sex] * AVATAR_IN_GROUP)
            {
               if(int(avatarIndex / AVATAR_IN_GROUP) == this.curApear)
               {
                  this.rectSprites[avatarIndex].visible = false;
               }
               else
               {
                  this.rectSprites[avatarIndex].visible = true;
               }
               avatarIndex++;
            }
         }
      }
      
      private function updateSelector() : void
      {
         if(this.selectedAvatar == -1)
         {
            this.avatarSelector.visible = false;
         }
         else if(this.isCharCreate)
         {
            this.avatarSelector.visible = true;
            this.avatarSelector.x = this.rectSprites[this.selectedAvatar].x - SELECTOR_OFS_X;
            this.avatarSelector.y = this.rectSprites[this.selectedAvatar].y - SELECTOR_OFS_Y;
         }
      }
      
      private function selectCharType(param1:Object) : void
      {
         selectedCharType = param1.value;
         this.updateCharTypeSelector();
         this.createInfoMenu(getString("IDS_CHAR_TYPE_" + this.selectedCharType),getString("IDS_CHAR_DESC_" + this.selectedCharType));
         this.enableTabs();
      }
      
      private function updateCharTypeSelector() : void
      {
         this.charTypeSelector.x = 59 + this.selectedCharType * 96;
         if(this.selectedCharType == CHAR_TYPE_CUSTOM)
         {
            this.setNextButton();
         }
         else
         {
            this.setDoneButton();
         }
      }
      
      private function addCharTypeButton(param1:int, param2:int, param3:int) : void
      {
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 9;
         labelFormat.align = TextFormatAlign.CENTER;
         var typeBitmap:Bitmap = getBmp("CHAR_TYPE_" + param3);
         var button:NButton = new NButton(this.selectCharType,typeBitmap,typeBitmap,typeBitmap);
         button.x = param1;
         button.y = param2;
         button.value = param3;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         this.submenu.addChild(createTextField(param1,param2 + 121,typeBitmap.width,labelFormat,getString("IDS_CHAR_TYPE_" + param3),18));
      }
      
      private function createAvatarMenu() : void
      {
         rectSprites = new Array();
         avatarButtons = new Array();
         var groupIndex:int = 0;
         var avatarIndex:int = 0;
         var unusedInt:int = 0;
         var avatarY:int = 0;
         this.submenu.graphics.clear();
         if(this.isCharCreate)
         {
            this.submenu.draw(bitmap16,98,217);
         }
         var avatarX:int;
         var overlay:Sprite;
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.bold = true;
         centeredFormat.align = TextFormatAlign.CENTER;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 12;
         labelFormat.bold = false;
         var smallFormat:TextFormat = new TextFormat();
         var label:TextField;
         var referralButton:ImageButton;
         var referralInput:NTextInput;
         var inputValue:String;
         smallFormat.font = "Verdana";
         smallFormat.color = 13408825;
         smallFormat.size = 10;
         smallFormat.bold = false;
         if(this.isCharCreate)
         {
            groupIndex = 0;
            while(groupIndex < AVATAR_GROUPS_COUNT[this.character.sex])
            {
               avatarIndex = 0;
               while(avatarIndex < AVATAR_IN_GROUP)
               {
                  avatarX = 59 + avatarIndex % 2 * 47 + groupIndex * 96 + (4 - AVATAR_GROUPS_COUNT[this.character.sex]) * 48;
                  avatarY = AVATAR_Y_COORD[int(avatarIndex / 2)];
                  this.avatarButtons.push(this.addAvatar(avatarX,avatarY,this.avatarSelect,(this.character.sex + 1) * 1000 + groupIndex * AVATAR_IN_GROUP + avatarIndex));
                  overlay = new Sprite();
                  overlay.graphics.beginFill(0,0.6);
                  overlay.graphics.drawRect(0,0,AVATAR_WIDTH,AVATAR_HEIGHT);
                  overlay.graphics.endFill();
                  overlay.x = avatarX;
                  overlay.y = avatarY;
                  this.rectSprites.push(overlay);
                  this.submenu.addChild(overlay);
                  avatarIndex++;
               }
               groupIndex++;
            }
            this.submenu.addChild(this.avatarSelector);
            this.updateSelector();
            this.updateAvatarSprites();
            label = createTextField(59,67,380,centeredFormat,getString("IDS_SELECT_AVATAR") + ":");
            this.submenu.addChild(label);
         }
         else
         {
            label = createTextField(0,60,550,centeredFormat,getString("IDS_TRAUMS_EFFECTS"));
            this.submenu.addChild(label);
            this.setTraums();
         }
         if(this.isCharCreate)
         {
            this.submenu.addChild(createTextField(59,219,380,centeredFormat,getString("IDS_ENTER_CHAR_TYPE") + ":"));
            groupIndex = 0;
            while(groupIndex < 4)
            {
               this.addCharTypeButton(59 + 96 * groupIndex,235,groupIndex);
               groupIndex++;
            }
            this.charTypeSelector.y = 235;
            this.submenu.addChild(this.charTypeSelector);
            this.addNBut(-128,211,getBmp("LEFT_ARROW"),getBmp("LEFT_ARROW_OVER"),getBmp("LEFT_ARROW_PRESSED"),this.apearenceChange,-1);
            this.addNBut(-16,211,getBmp("RIGHT_ARROW"),getBmp("RIGHT_ARROW_OVER"),getBmp("RIGHT_ARROW_PRESSED"),this.apearenceChange,1);
            this.updateCharTypeSelector();
         }
         else
         {
            referralButton = new ImageButton(this.handleShowReferal);
            referralButton.setPos(152,184);
            this.submenu.addUIChild(referralButton);
            this.submenu.addChild(createTextField(164,180,200,headingFormat,getString("IDS_YOUR_REF"),18));
            referralInput = createTextInput(133,205,311,"http://unit-online.ru/?r=" + this.character.userId);
            referralInput.isValue25 = true;
            this.submenu.addUIChild(referralInput);
            this.submenu.addChild(createTextField(152,226,220,headingFormat,getString("IDS_ENTER_INFO") + ":"));
            inputValue = "";
            this.submenu.addChild(createTextField(83,247,70,labelFormat,getString("IDS_NAME") + ":"));
            this.submenu.addChild(createTextField(69,269,70,labelFormat,getString("IDS_CITY") + ":"));
            this.submenu.addChild(createTextField(60,292,70,labelFormat,getString("IDS_COUNTRY") + ":"));
            if(this.nameTF)
            {
               inputValue = this.nameTF.text;
            }
            else
            {
               inputValue = this.character.fullName;
            }
            nameTF = createTextInput(133,250,311,inputValue);
            this.nameTF.maxChars = 24;
            this.submenu.addUIChild(this.nameTF);
            if(this.city)
            {
               inputValue = this.city.text;
            }
            else
            {
               inputValue = this.character.city;
            }
            city = createTextInput(133,272,311,inputValue);
            this.city.maxChars = 24;
            this.submenu.addUIChild(this.city);
            if(this.country)
            {
               inputValue = this.country.text;
            }
            else
            {
               inputValue = this.character.country;
            }
            country = createTextInput(133,294,311,inputValue);
            this.country.maxChars = 24;
            this.submenu.addUIChild(this.country);
            label = createTextField(64,317,70,labelFormat,getString("IDS_ABOUT"));
            this.submenu.addChild(label);
            if(this.about)
            {
               inputValue = this.about.text;
            }
            else
            {
               inputValue = this.character.about;
            }
            about = createTextInput(133,317,311,inputValue);
            this.about.multiline = true;
            this.about.wordWrap = true;
            this.about.height = 60;
            this.about.text = inputValue;
            this.submenu.addUIChild(this.about);
         }
      }
      
      private function handleShowReferal(param1:Object) : void
      {
         this.socket.sendReferalMenu();
      }
      
      public function setTraums() : void
      {
         var scroll:int = 0;
         if(this.traumScrollSprite)
         {
            scroll = this.traumScrollSprite.scrollV;
            this.submenu.removeUIChild(this.traumScrollSprite);
            traumScrollSprite = null;
         }
         traumScrollSprite = new ScrollSprite(TRAUM_WIDTH,TRAUM_HEIGHT,1);
         this.traumScrollSprite.x = PERK_SELECT_X + 16;
         this.traumScrollSprite.y = 84;
         this.submenu.addUIChild(this.traumScrollSprite);
         var lightNegativeTf:TextFormat = new TextFormat("Verdana",11,10187041,true);
         lightNegativeTf.leftMargin = 2;
         var severeNegativeTf:TextFormat = new TextFormat("Verdana",11,16737792,true);
         severeNegativeTf.leftMargin = 2;
         var positiveTf:TextFormat = new TextFormat("Verdana",11,4882995,true);
         positiveTf.leftMargin = 2;
         var lightNegativeTimeTf:TextFormat = new TextFormat("Verdana",8,10187041);
         lightNegativeTimeTf.align = "right";
         var severeNegativeTimeTf:TextFormat = new TextFormat("Verdana",8,16737792);
         severeNegativeTimeTf.align = "right";
         var positiveTimeTf:TextFormat = new TextFormat("Verdana",8,4882995);
         positiveTimeTf.align = "right";
         var darkTfNotBold:TextFormat = new TextFormat("Verdana",10,10187041);
         var ownPerkId:int = 0;
         var healBtn:BaseButton;
         var button:BaseButton;
         var sprite:Sprite;
         var textField:TextField;
         var timeTextField:TextField;
         var i:int = 0;
         traumButtons = new Array();
         traumSpriteButtons = new Array();
         var now:int = new Date().valueOf() / 1000;
         var timestr:String;
         var textFmt:TextFormat;
         var timeFmt:TextFormat;
         var effects:Array = [];
         var effect:Object;
         for each(effect in Main.UserCharacter.Effects)
         {
            effects.push(effect);
         }
         effects.sort(function(param1:Object, param2:Object):int
         {
            if(param1.type != param2.type)
            {
               if(param1.type == Effect.SEVERE_TRAUMA || param2.type == Effect.SEVERE_TRAUMA)
               {
                  return param1.type == Effect.SEVERE_TRAUMA ? -1 : 1;
               }
               else if(param1.type == Effect.LIGHT_TRAUMA || param2.type == Effect.LIGHT_TRAUMA)
               {
                  return param1.type == Effect.LIGHT_TRAUMA ? -1 : 1;
               }
               else
               {
                  return param1.type < param2.type ? -1 : 1;
               }
            }
            else
            {
               return param1.uid < param2.uid ? -1 : 1;
            }
         });
         for each(effect in effects)
         {
            if(effect.type == Effect.LIGHT_TRAUMA || effect.type == Effect.SEVERE_TRAUMA)
            {
               healBtn = createButton(0,i * 18,effect.uid,getBmp("CURE_BUTTON"),getBmp("CURE_BUTTON_OVER"),getBmp("CURE_BUTTON_PRESSED"),this.handleTraumPressed);
               this.submenuItems.push(healBtn);
               this.traumButtons.push(healBtn);
               this.traumScrollSprite.addContent(healBtn);
            }
            switch(effect.type)
            {
               case Effect.IRRADIATION:
               case Effect.DRUG_ADDICTION:
               case Effect.CHEMICAL_POISONING:
               case Effect.ALCOHOLISM:
               case Effect.EffectCount:
                  timestr = String(effect.param >> 24);
                  break;
               case Effect.ADD_HP_ON_HIT:
                  timestr = String(effect.param >> 16);
                  break;
               default:
                  timestr = (effect.endtime > now) ? this.TimeToStr(effect.endtime - now) : "";
                  break;
            }
            switch(effect.type)
            {
               case Effect.ADD_HP_ON_HIT:
               case Effect.ADD_HP_CONTINUOUSLY:
               case Effect.ADD_STATS:
               case Effect.INC_RADIATION_RESIST_TIME:
               case Effect.RESIST_ARMOR_DISRUPTION:
               case Effect.RESIST_FIRE:
               case Effect.RESIST_POISON:
               case Effect.RESIST_SHOCK:
               case Effect.EFFECT_CONST3:
               case Effect.EFFECT_CONST10:
               case Effect.EFFECT_CONST9:
               case Effect.LOW_EXP:
               case Effect.EFFECT_CONST2:
               case Effect.EFFECT_CONST13:
               case Effect.EFFECT_CONST11:
               case Effect.EFFECT_CONST4:
                  textFmt = positiveTf;
                  timeFmt = positiveTimeTf;
                  break;
               case Effect.SILENCE:
               case Effect.LIGHT_TRAUMA:
               case Effect.EFFECT_CONST14:
                  textFmt = lightNegativeTf;
                  timeFmt = lightNegativeTimeTf;
                  break;
               default:
                  textFmt = severeNegativeTf;
                  timeFmt = severeNegativeTimeTf;
                  break;
            }
            if(effect.type == Effect.EFFECT_CONST9 && effect.param != 0 && effect.param < 100)
            {
               textFmt = lightNegativeTf;
               timeFmt = lightNegativeTimeTf;
            }
            textField = createTextField(0,-1,300,textFmt,Effect.GetName(effect),18);
            timeTextField = createTextField(0,1,300,timeFmt,timestr,18);
            sprite = new Sprite();
            updateBgUI(sprite,false,300,16);
            button = this.createDisplayBut(18,i * 18,sprite,sprite,sprite,null,0,Effect.getString3(effect.type,effect.param));
            this.traumSpriteButtons.push(button);
            this.traumScrollSprite.addContent(button);
            sprite.addChild(textField);
            sprite.addChild(timeTextField);
            i++;
         }
         this.traumScrollSprite.init(i * 18,scroll);
      }
      
      public function healTraumFinal(param1:Object) : void
      {
         this.main.socket.sendHeal(this.traumUID);
         traumUID = 0;
         this.closeMenu();
      }
      
      private function handleTraumPressed(param1:Object) : void
      {
         var traumaParam:int = this.character.Effects[param1.value].param;
         traumUID = param1.value;
         this.main.showWarningMenu(getString("IDS_HEAL_0") + " " + this.getMaxHealPackCount(traumaParam) + " " + getString("IDS_HEAL_PACK_" + Character.TRAUM_SEVERITY[traumaParam]) + ".",this.healTraumFinal);
      }
      
      private function getMaxHealPackCount(param1:int) : int
      {
         var costFactor:int = Character.TRAUM_FACTOR[param1] - this.character.skills[Character.SKILL_DOCTOR] / 10000;
         var packCount:int = Character.TRAUM_COST[param1];
         if(costFactor > 0)
         {
            packCount += Character.TRAUM_COST[param1] * costFactor / 100;
         }
         return packCount;
      }
      
      public function TimeToStr(param1:int) : String
      {
         if(param1 == 0)
         {
            return "";
         }
         var unusedString:String = "";
         var hours:int = param1 / 3600;
         var minutes:int = param1 % 3600 / 60;
         var seconds:int = param1 % 60;
         unusedString = hours + ":" + minutes + "':" + seconds + "\"";
         return unusedString;
      }
      
      private function updateCreateSkills() : void
      {
         var skillIndex:int = 0;
         skillIndex = 0;
         while(skillIndex < BATTLE_SKILLS_COUNT)
         {
            if(this.battleSkillCheckBool[skillIndex])
            {
               this.character.skills[skillIndex] = 100000;
            }
            else
            {
               this.character.skills[skillIndex] = 10000;
            }
            this.skillCount[skillIndex].text = int(this.character.skills[skillIndex] / 10000).toString();
            skillIndex++;
         }
         skillIndex = 0;
         while(skillIndex < PEACE_SKILLS_COUNT)
         {
            if(this.peaceSkillCheckBool[skillIndex])
            {
               this.character.skills[BATTLE_SKILLS_COUNT + skillIndex] = 100000;
            }
            else
            {
               this.character.skills[BATTLE_SKILLS_COUNT + skillIndex] = 10000;
            }
            this.skillCount[BATTLE_SKILLS_COUNT + skillIndex].text = int(this.character.skills[BATTLE_SKILLS_COUNT + skillIndex] / 10000).toString();
            skillIndex++;
         }
      }
      
      private function createCharSkillsMenu() : void
      {
         var battleAllowance:int = Character.SKILL_ADD_VALUE[this.character.intellect - 1] * (this.character.level + 1);
         var peaceAllowance:int = Character.SKILL_ADD_VALUE[this.character.intellect - 1] * (this.character.level + 1);
         var freePeacePoints:int = peaceAllowance - this.character.pieceSkillSum;
         var freeBattlePoints:int = battleAllowance - this.character.battleSkillSum;
         if(freeBattlePoints < 0)
         {
            freeBattlePoints = 0;
         }
         if(freePeacePoints < 0)
         {
            freePeacePoints = 0;
         }
         battleSkillCheck = new Array();
         peaceSkillCheck = new Array();
         battleSkillBtn = new Array();
         peaceSkillBtn = new Array();
         var unusedInt:int = 90;
         this.submenu.draw(bitmap16,87,377);
         var skillIndex:int;
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 10187041;
         hintFormat.size = 10;
         hintFormat.bold = false;
         hintFormat.align = TextFormatAlign.CENTER;
         var skillFormat:TextFormat = new TextFormat();
         skillFormat.font = "Verdana";
         skillFormat.color = 10187041;
         skillFormat.size = 12;
         skillFormat.bold = true;
         var pointsFormat:TextFormat = new TextFormat();
         pointsFormat.font = "Verdana";
         pointsFormat.color = 13408825;
         pointsFormat.size = 12;
         pointsFormat.bold = true;
         var skillValueFormat:TextFormat = new TextFormat();
         skillValueFormat.font = "Verdana";
         skillValueFormat.color = 10187041;
         skillValueFormat.size = 12;
         skillValueFormat.bold = true;
         skillValueFormat.align = TextFormatAlign.CENTER;
         var pointsValueFormat:TextFormat = new TextFormat();
         pointsValueFormat.font = "Verdana";
         pointsValueFormat.color = 13408825;
         pointsValueFormat.size = 12;
         pointsValueFormat.bold = true;
         pointsValueFormat.align = TextFormatAlign.CENTER;
         skillIndex = 0;
         while(skillIndex < BATTLE_SKILLS_COUNT)
         {
            if(this.battleSkillCheckBool[skillIndex] == null)
            {
               this.battleSkillCheckBool[skillIndex] = false;
            }
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,318,16);
            this.battleSkillCheck.push(this.addCheckBox(87,114 + skillIndex * 18,this.battleSkillSelect,skillIndex));
            this.battleSkillCheck[skillIndex].checked = this.battleSkillCheckBool[skillIndex];
            skillButton = this.addDisplayBut(104,113 + skillIndex * 18,rowBackground,rowBackground,rowBackground,this.battleSkillSelect,skillIndex);
            this.battleSkillBtn.push(skillButton);
            battleLabel = createTextField(106,111 + skillIndex * 18,200,skillFormat,_("IDS_SKILL_" + skillIndex));
            this.submenu.addChild(battleLabel);
            this.skillCount[skillIndex] = createTextField(384,111 + skillIndex * 18,34,skillValueFormat,int(this.character.skills[skillIndex] / 10000).toString());
            skillButton.textField1 = battleLabel;
            skillButton.textField2 = this.skillCount[skillIndex];
            skillButton.hintText = (this.character.skills[skillIndex] / 10000).toFixed(4);
            this.submenu.addChild(this.skillCount[skillIndex]);
            skillIndex++;
         }
         skillIndex = 0;
         while(skillIndex < PEACE_SKILLS_COUNT)
         {
            if(this.peaceSkillCheckBool[skillIndex] == null)
            {
               this.peaceSkillCheckBool[skillIndex] = false;
            }
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,318,16);
            this.peaceSkillCheck.push(this.addCheckBox(87,264 + skillIndex * 18,this.peaceSkillSelect,skillIndex));
            this.peaceSkillCheck[skillIndex].checked = this.peaceSkillCheckBool[skillIndex];
            skillButton = this.addDisplayBut(104,263 + skillIndex * 18,rowBackground,rowBackground,rowBackground,this.peaceSkillSelect,skillIndex);
            this.peaceSkillBtn.push(skillButton);
            peaceLabel = createTextField(106,261 + skillIndex * 18,200,skillFormat,_("IDS_SKILL_" + (skillIndex + BATTLE_SKILLS_COUNT)));
            this.submenu.addChild(peaceLabel);
            this.skillCount[BATTLE_SKILLS_COUNT + skillIndex] = createTextField(384,261 + skillIndex * 18,34,skillValueFormat,int(this.character.skills[skillIndex + BATTLE_SKILLS_COUNT] / 10000).toString());
            skillButton.textField1 = peaceLabel;
            skillButton.textField2 = this.skillCount[BATTLE_SKILLS_COUNT + skillIndex];
            skillButton.hintText = (this.character.skills[skillIndex + BATTLE_SKILLS_COUNT] / 10000).toFixed(4);
            this.submenu.addChild(this.skillCount[BATTLE_SKILLS_COUNT + skillIndex]);
            skillIndex++;
         }
         if(!this.isCharCreate)
         {
            this.submenu.draw(bitmap16,87,189);
            this.submenu.draw(bitmap16,87,339);
            pointsBackground = new Sprite();
            updateBgUI(pointsBackground,false,318,16);
            pointsBackground.x = 104;
            pointsBackground.y = 195;
            this.submenu.addChild(pointsBackground);
            this.submenu.addChild(createTextField(106,193,200,pointsFormat,getString("IDS_SKILL_ADD") + ":"));
            this.submenu.addChild(createTextField(384,193,34,pointsValueFormat,freeBattlePoints.toString()));
            pointsBackground = new Sprite();
            updateBgUI(pointsBackground,false,318,16);
            pointsBackground.x = 104;
            pointsBackground.y = 345;
            this.submenu.addChild(pointsBackground);
            this.submenu.addChild(createTextField(106,343,200,pointsFormat,getString("IDS_SKILL_ADD") + ":"));
            this.submenu.addChild(createTextField(384,343,34,pointsValueFormat,freePeacePoints.toString()));
         }
         var rowBackground:Sprite;
         var skillButton:NButton;
         var battleHeading:TextField = createTextField(195,66,110,headingFormat,getString("IDS_BATTLE_SKILL"));
         this.submenu.addChild(battleHeading);
         if(this.isCharCreate)
         {
            battleHint = createTextField(102,87,316,hintFormat,getString("IDS_SELECT_BATTLE_SKILL"));
         }
         else
         {
            battleHint = createTextField(102,87,316,hintFormat,getString("IDS_CHAR_BATTLE_SKILL"));
         }
         this.submenu.addChild(battleHint);
         if(this.isCharCreate)
         {
            peaceHint = createTextField(102,237,316,hintFormat,getString("IDS_SELECT_PEACE_SKILL"));
         }
         else
         {
            peaceHint = createTextField(102,237,316,hintFormat,getString("IDS_CHAR_PEACE_SKILL"));
         }
         this.submenu.addChild(peaceHint);
         var battleHint:TextField;
         var peaceHint:TextField;
         var peaceHeading:TextField = createTextField(194,216,110,headingFormat,getString("IDS_PEACE_SKILL"));
         var battleLabel:TextField;
         var peaceLabel:TextField;
         var pointsBackground:Sprite;
         this.submenu.addChild(peaceHeading);
      }
      
      private function selectPerk(param1:int) : void
      {
         var perkIndex:int = 0;
         while(perkIndex < Character.MAX_PERK_COUNT)
         {
            if(this.avaiblePerks[perkIndex])
            {
               updateBgUI(this.avaiblePerks[perkIndex].upState,false,this.avaiblePerks[perkIndex].upState.width,this.avaiblePerks[perkIndex].upState.height,this.avaiblePerks[perkIndex].textField1);
               this.avaiblePerksCheck[perkIndex].highlight = false;
            }
            perkIndex++;
         }
         updateBgUI(this.avaiblePerks[param1].upState,true,this.avaiblePerks[param1].upState.width,this.avaiblePerks[param1].upState.height,this.avaiblePerks[param1].textField1);
         this.avaiblePerksCheck[param1].highlight = true;
         this.createInfoMenu(getString("IDS_PERK_" + param1),getString("IDS_PERK_DESC_" + param1));
      }
      
      private function selectOwnPerk(param1:int) : void
      {
         var perkIndex:int = 0;
         while(perkIndex < Character.MAX_PERK_COUNT)
         {
            if(this.perks[perkIndex])
            {
               updateBgUI(this.perks[perkIndex].upState,false,this.perks[perkIndex].upState.width,this.perks[perkIndex].upState.height,this.perks[perkIndex].textField1);
            }
            perkIndex++;
         }
         updateBgUI(this.perks[param1].upState,true,this.perks[param1].upState.width,this.perks[param1].upState.height,this.perks[param1].textField1);
         this.createInfoMenu(getString("IDS_PERK_" + param1),getString("IDS_PERK_DESC_" + param1));
      }
      
      private function handleOwnPerkPress(param1:Object) : void
      {
         this.selectOwnPerk(param1.value);
      }
      
      private function handlePerkConfirmPress(param1:Object) : void
      {
         var selectedPerk:int = -1;
         var perkIndex:int = 0;
         while(perkIndex < Character.MAX_PERK_COUNT)
         {
            if(this.avaiblePerksBool[perkIndex])
            {
               selectedPerk = perkIndex;
            }
            perkIndex++;
         }
         if(selectedPerk != -1)
         {
            this.socket.sendStr("pc|" + selectedPerk);
            this.character.avaiblePerks = 0;
            this.character.perks |= 1 << selectedPerk;
            this.startMenu();
         }
      }
      
      private function handlePerkCheck(param1:Object) : void
      {
         var perkIndex:int = 0;
         perkIndex = 0;
         while(perkIndex < Character.MAX_PERK_COUNT)
         {
            this.avaiblePerksBool[perkIndex] = false;
            if(this.avaiblePerksCheck[perkIndex])
            {
               this.avaiblePerksCheck[perkIndex].checked = false;
            }
            perkIndex++;
         }
         this.avaiblePerksBool[param1.value] = true;
         this.avaiblePerksCheck[param1.value].checked = true;
         this.selectPerk(param1.value);
         this.updateCharacterLabels();
         this.enableTabs();
      }
      
      private function createCharPerkMenu() : void
      {
         avaiblePerks = new Array(Character.MAX_PERK_COUNT);
         avaiblePerksCheck = new Array(Character.MAX_PERK_COUNT);
         perks = new Array(Character.MAX_PERK_COUNT);
         var unusedInt:int = 91;
         this.submenu.draw(bitmap16,87,380);
         this.submenu.draw(ramUL,PERK_SELECT_X + 1,PERK_SELECT_Y + 1);
         this.submenu.drawTile(ramTop,PERK_SELECT_X + ramUL.width + 1,PERK_SELECT_Y,PERK_SELECT_WIDTH - ramUL.width - ramUR.width - 2,ramTop.height);
         this.submenu.draw(ramUR,PERK_SELECT_X + PERK_SELECT_WIDTH - ramUR.width - 1,PERK_SELECT_Y + 1);
         this.submenu.drawTile(ramSide,PERK_SELECT_X,PERK_SELECT_Y + ramUL.height + 1,ramSide.width,PERK_SELECT_HEIGHT - ramUL.height - ramDL.height - 2);
         this.submenu.drawTile(ramSide,PERK_SELECT_X + PERK_SELECT_WIDTH - ramSide.width,PERK_SELECT_Y + ramUR.height + 1,ramSide.width,PERK_SELECT_HEIGHT - ramUR.height - ramDR.height - 2);
         this.submenu.draw(ramDL,PERK_SELECT_X + 1,PERK_SELECT_Y + PERK_SELECT_HEIGHT - ramDL.height - 1);
         this.submenu.drawTile(ramBottom,PERK_SELECT_X + ramDL.width + 1,PERK_SELECT_Y + PERK_SELECT_HEIGHT - ramBottom.height,PERK_SELECT_WIDTH - ramDL.width - ramDR.width - 2,ramBottom.height);
         this.submenu.draw(ramDR,PERK_SELECT_X + PERK_SELECT_WIDTH - ramDR.width - 1,PERK_SELECT_Y + PERK_SELECT_HEIGHT - ramDR.height - 1);
         perkScrollSprite = new ScrollSprite(PERK_SELECT_WIDTH - 15,PERK_SELECT_HEIGHT - 12);
         this.perkScrollSprite.x = PERK_SELECT_X + 6;
         this.perkScrollSprite.y = PERK_SELECT_Y + 6;
         this.submenuItems.push(this.perkScrollSprite);
         this.submenu.addUIChild(this.perkScrollSprite);
         ownPerkScrollSprite = new ScrollSprite(OWN_PERK_SELECT_WIDTH,OWN_PERK_SELECT_HEIGHT);
         this.ownPerkScrollSprite.x = OWN_PERK_SELECT_X;
         this.ownPerkScrollSprite.y = OWN_PERK_SELECT_Y;
         this.submenuItems.push(this.ownPerkScrollSprite);
         this.submenu.addUIChild(this.ownPerkScrollSprite);
         var perkIndex:int;
         var perkFormat:TextFormat = new TextFormat();
         perkFormat.font = "Verdana";
         perkFormat.color = 10187041;
         perkFormat.size = 12;
         perkFormat.bold = true;
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 10187041;
         hintFormat.size = 10;
         var availableRowCount:int = 0;
         var ownedRowCount:int = 0;
         perkIndex = 0;
         while(perkIndex < Character.MAX_PERK_COUNT)
         {
            if(this.character.avaiblePerks >> perkIndex & 1)
            {
               if(this.avaiblePerksBool[perkIndex] == null)
               {
                  this.avaiblePerksBool[perkIndex] = false;
               }
               checkBox = this.createCheckBox(1,availableRowCount * 16 + 1,this.handlePerkCheck,perkIndex,14,14);
               checkBox.maskSprite = this.perkScrollSprite.maskShape;
               this.avaiblePerksCheck[perkIndex] = checkBox;
               if(this.avaiblePerksBool[perkIndex])
               {
                  checkBox.checked = true;
               }
               this.perkScrollSprite.addContent(checkBox);
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,PERK_SELECT_WIDTH - 44,14);
               button = this.createDisplayBut(16,availableRowCount * 16,rowBackground,rowBackground,rowBackground,this.handlePerkCheck,perkIndex);
               this.perkScrollSprite.addContent(button);
               label = createTextField(20,availableRowCount * 16 - 2,PERK_SELECT_WIDTH - 48,perkFormat,getString("IDS_PERK_" + perkIndex));
               label.height = 18;
               this.perkScrollSprite.addLine(label);
               button.textField1 = label;
               this.avaiblePerks[perkIndex] = button;
               availableRowCount++;
            }
            if(this.character.perks >> perkIndex & 1)
            {
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,OWN_PERK_SELECT_WIDTH - 14,14);
               button = this.createDisplayBut(0,ownedRowCount * 16,rowBackground,rowBackground,rowBackground,this.handleOwnPerkPress,perkIndex);
               this.ownPerkScrollSprite.addContent(button);
               label = createTextField(0,ownedRowCount * 16 - 2,OWN_PERK_SELECT_WIDTH - 10,perkFormat,getString("IDS_PERK_" + perkIndex));
               label.height = 18;
               this.ownPerkScrollSprite.addLine(label);
               button.textField1 = label;
               this.perks[perkIndex] = button;
               ownedRowCount++;
            }
            perkIndex++;
         }
         this.perkScrollSprite.init(availableRowCount * 16 - 2);
         this.ownPerkScrollSprite.init(ownedRowCount * 16 - 2);
         if(!this.isCharCreate && this.character.avaiblePerks != 0)
         {
            this.addNBut(343,198,getBmp("DONE_BUTTON"),getBmp("DONE_BUTTON_OVER"),getBmp("DONE_BUTTON_PRESSED"),this.handlePerkConfirmPress);
         }
         var checkBox:NCheckBox;
         var button:BaseButton;
         var rowBackground:Sprite;
         var label:TextField;
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         this.submenu.addChild(createTextField(166,67,210,headingFormat,getString("IDS_AVAIBLE_PERKS")));
         this.submenu.addChild(createTextField(153,88,250,hintFormat,getString("IDS_SELECT_PERK")));
         this.submenu.addChild(createTextField(220,243,120,headingFormat,getString("IDS_OWN_PERKS")));
      }
      
      private function setSkillsNotHighlight() : void
      {
         var skillIndex:int = 0;
         skillIndex = 0;
         while(skillIndex < BATTLE_SKILLS_COUNT)
         {
            updateBgUI(this.battleSkillBtn[skillIndex].upState,false,this.battleSkillBtn[skillIndex].upState.width,this.battleSkillBtn[skillIndex].upState.height,this.battleSkillBtn[skillIndex].textField1,this.battleSkillBtn[skillIndex].textField2);
            this.battleSkillCheck[skillIndex].highlight = false;
            skillIndex++;
         }
         skillIndex = 0;
         while(skillIndex < PEACE_SKILLS_COUNT)
         {
            updateBgUI(this.peaceSkillBtn[skillIndex].upState,false,this.peaceSkillBtn[skillIndex].upState.width,this.peaceSkillBtn[skillIndex].upState.height,this.peaceSkillBtn[skillIndex].textField1,this.peaceSkillBtn[skillIndex].textField2);
            this.peaceSkillCheck[skillIndex].highlight = false;
            skillIndex++;
         }
      }
      
      private function showSkillInfo(param1:int) : void
      {
         this.createInfoMenu(getString("IDS_SKILL_" + param1.toString()),getString("IDS_SKILL_DESC_" + param1.toString()));
      }
      
      private function battleSkillSelect(param1:Object) : void
      {
         var selectedCount:int = 0;
         this.setSkillsNotHighlight();
         var skillIndex:int = 0;
         while(skillIndex < BATTLE_SKILLS_COUNT)
         {
            if(this.battleSkillCheck[skillIndex].checked)
            {
               selectedCount++;
            }
            skillIndex++;
         }
         this.battleSkillCheck[param1.value].highlight = true;
         this.showSkillInfo(param1.value);
         if(this.isCharCreate)
         {
            if(selectedCount < PRIORITY_BATTLE_SKILL_COUNT && !this.battleSkillCheck[param1.value].checked)
            {
               this.battleSkillCheckBool[param1.value] = true;
               this.battleSkillCheck[param1.value].checked = true;
            }
            else
            {
               this.battleSkillCheckBool[param1.value] = false;
               this.battleSkillCheck[param1.value].checked = false;
            }
         }
         this.enableTabs();
         if(this.isCharCreate)
         {
            this.updateCreateSkills();
         }
         updateBgUI(this.battleSkillBtn[param1.value].upState,true,this.battleSkillBtn[param1.value].upState.width,this.battleSkillBtn[param1.value].upState.height,this.battleSkillBtn[param1.value].textField1,this.battleSkillBtn[param1.value].textField2);
      }
      
      private function peaceSkillSelect(param1:Object) : void
      {
         var selectedCount:int = 0;
         this.setSkillsNotHighlight();
         var skillIndex:int = 0;
         while(skillIndex < PEACE_SKILLS_COUNT)
         {
            if(this.peaceSkillCheck[skillIndex].checked)
            {
               selectedCount++;
            }
            skillIndex++;
         }
         this.peaceSkillCheck[param1.value].highlight = true;
         this.showSkillInfo(param1.value + BATTLE_SKILLS_COUNT);
         if(this.isCharCreate)
         {
            if(selectedCount < PRIORITY_PEACE_SKILL_COUNT && !this.peaceSkillCheck[param1.value].checked)
            {
               this.peaceSkillCheckBool[param1.value] = true;
               this.peaceSkillCheck[param1.value].checked = true;
            }
            else
            {
               this.peaceSkillCheckBool[param1.value] = false;
               this.peaceSkillCheck[param1.value].checked = false;
            }
         }
         this.enableTabs();
         if(this.isCharCreate)
         {
            this.updateCreateSkills();
         }
         updateBgUI(this.peaceSkillBtn[param1.value].upState,true,this.peaceSkillBtn[param1.value].upState.width,this.peaceSkillBtn[param1.value].upState.height,this.peaceSkillBtn[param1.value].textField1,this.peaceSkillBtn[param1.value].textField2);
      }
      
      private function drawTextTile(param1:Bitmap, param2:int, param3:int, param4:int, param5:int) : void
      {
         var fillMatrix:Matrix = new Matrix();
         fillMatrix.translate(param2,param3);
         this.textMenu.graphics.beginBitmapFill(param1.bitmapData,fillMatrix);
         this.textMenu.graphics.drawRect(param2,param3,param4,param5);
         this.textMenu.graphics.endFill();
      }
      
      private function drawText(param1:Bitmap, param2:int, param3:int) : void
      {
         var fillMatrix:Matrix = new Matrix();
         fillMatrix.translate(param2,param3);
         this.textMenu.graphics.beginBitmapFill(param1.bitmapData,fillMatrix);
         this.textMenu.graphics.drawRect(param2,param3,param1.width,param1.height);
         this.textMenu.graphics.endFill();
      }
      
      public function avatarSelect(param1:Object) : void
      {
         selectedAvatar = param1.value % 1000;
         this.enableTabs();
         this.updateSelector();
         curApear = this.selectedAvatar / AVATAR_IN_GROUP;
         this.loadAppearance();
      }
      
      private function applyChange(param1:Object) : void
      {
         if(this.nameTF)
         {
            this.socket.sendStr("ei|" + this.nameTF.text + "|" + this.city.text + "|" + this.country.text + "|" + this.about.text + "|");
         }
         closeHandler();
      }
      
      private function nextUI(param1:Object) : void
      {
         if(this.canConfirm)
         {
            this.sendCharacterType();
         }
         else if(this.selectedTab < this.enabledTab)
         {
            if(this.selectedTab < TAB_COUNT - 1)
            {
               this.tabButtons[this.selectedTab].upState = this.notPressedBmp[this.tabButtons[this.selectedTab].value];
               ++this.selectedTab;
               this.tabButtons[this.selectedTab].upState = this.overBmp[this.tabButtons[this.selectedTab].value];
               this.clearAllChilds();
               this.startMenu();
            }
            else
            {
               this.charDone();
            }
         }
         else
         {
            this.main.showNotifyMenu(this.errorMessage);
         }
      }
      
      private function apearenceChange(param1:Object) : void
      {
         selectedAvatar = -1;
         this.updateSelector();
         curApear += param1.value;
         this.loadAppearance();
      }
      
      private function enableTabs() : void
      {
         var index:int = 0;
         var selectedCount:int = 0;
         if(this.isCharCreate)
         {
            enabledTab = 0;
            canConfirm = this.selectedCharType != CHAR_TYPE_CUSTOM && this.selectedAvatar != -1;
            if(this.selectedAvatar != -1 && this.selectedCharType == CHAR_TYPE_CUSTOM)
            {
               enabledTab = 1;
               if(this.statsAvaible == 0)
               {
                  enabledTab = 2;
                  selectedCount = 0;
                  index = 0;
                  while(index < BATTLE_SKILLS_COUNT)
                  {
                     if(this.battleSkillCheckBool[index])
                     {
                        selectedCount++;
                     }
                     index++;
                  }
                  if(selectedCount == PRIORITY_BATTLE_SKILL_COUNT)
                  {
                     selectedCount = 0;
                     index = 0;
                     while(index < PEACE_SKILLS_COUNT)
                     {
                        if(this.peaceSkillCheckBool[index])
                        {
                           selectedCount++;
                        }
                        index++;
                     }
                     if(selectedCount == PRIORITY_PEACE_SKILL_COUNT)
                     {
                        enabledTab = 3;
                        selectedCount = 0;
                        index = 0;
                        while(index < Character.MAX_PERK_COUNT)
                        {
                           if(this.avaiblePerksBool[index])
                           {
                              selectedCount++;
                           }
                           index++;
                        }
                        if(selectedCount == 1)
                        {
                           enabledTab = 4;
                        }
                        else
                        {
                           errorMessage = getString("IDS_ERROR_PERK");
                        }
                     }
                     else
                     {
                        errorMessage = getString("IDS_ERROR_PEACE_SKILLS");
                     }
                  }
                  else
                  {
                     errorMessage = getString("IDS_ERROR_BATTLE_SKILLS");
                  }
               }
               else
               {
                  errorMessage = getString("IDS_ERROR_STATS");
               }
            }
            else
            {
               errorMessage = getString("IDS_ERROR_AVATAR");
            }
            index = 0;
            while(index < TAB_COUNT)
            {
               if(index <= this.enabledTab)
               {
                  this.tabButtons[index].enabled = true;
               }
               else
               {
                  this.tabButtons[index].enabled = false;
               }
               index++;
            }
         }
      }
      
      public function updateCharacterLabels() : void
      {
         if(this.selectedTab != TAB_STAT)
         {
            return;
         }
         var hpIncrease:int = 0;
         if(this.character.stats[Character.STAT_STRENGTH] + this.character.stats[Character.STAT_ENDURANCE] <= 10)
         {
            hpIncrease = 4;
         }
         else if(this.character.stats[Character.STAT_STRENGTH] + this.character.stats[Character.STAT_ENDURANCE] < 15)
         {
            hpIncrease = 5;
         }
         else if(this.character.stats[Character.STAT_STRENGTH] + this.character.stats[Character.STAT_ENDURANCE] < 17)
         {
            hpIncrease = 7;
         }
         else
         {
            hpIncrease = 8;
         }
         var maximumHp:int = 10 + this.character.stats[Character.STAT_STRENGTH] + 2 * this.character.stats[Character.STAT_ENDURANCE];
         if(this.character.hasPerk(Character.ABILITY_ADD_HP_LOW))
         {
            maximumHp += 10;
         }
         if(this.character.hasPerk(Character.ABILITY_ADD_HP_HIGH))
         {
            maximumHp += 20;
         }
         this.calculatedParams[CALCULATED_HP].text = maximumHp + "(+" + hpIncrease + ")";
         if(this.main.nuclearWorld == null)
         {
            maximumWeight = Character.MAX_WEIGHT_CONST + this.character.stats[Character.STAT_STRENGTH] * 3 + this.character.stats[Character.STAT_ENDURANCE] * 4;
            if(this.character.hasPerk(Character.PERK_STRONG_SPIN) || this.avaiblePerksBool[Character.PERK_STRONG_SPIN])
            {
               maximumWeight += 100;
            }
         }
         else
         {
            maximumWeight = this.character.MaxWeight / 1000;
         }
         this.calculatedParams[CALCULATED_WEIGHT].text = maximumWeight;
         if(this.character.stats[Character.STAT_STRENGTH] < 7)
         {
            this.calculatedParams[CALCULATED_HANDS_DAMAGE].text = "1-4";
         }
         else
         {
            this.calculatedParams[CALCULATED_HANDS_DAMAGE].text = "2-6";
         }
         var maximumWeight:int;
         var criticalChance:int = Character.CRITICAL_LUCK_VAL[this.character.stats[Character.STAT_LUCK] - 1];
         if(this.character.hasPerk(Character.PERK_ANATOMY))
         {
            criticalChance += 5;
         }
         if(this.character.stats[Character.STAT_LUCK] + this.character.stats[Character.STAT_INTELLECT] >= 17)
         {
            criticalChance += 8;
         }
         else if(this.character.stats[Character.STAT_LUCK] + this.character.stats[Character.STAT_INTELLECT] >= 15)
         {
            criticalChance += 3;
         }
         if(this.character.hasAbility(Character.ABILITY_CRITICAL_HIT))
         {
            criticalChance += 5;
         }
         if(this.character.hasAbility(Character.ABILITY_CRITICAL_HIT2))
         {
            criticalChance += 8;
         }
         this.calculatedParams[CALCULATED_CRITICAL_PROB].text = criticalChance + "%";
         this.calculatedParams[CALCULATED_RADIATION_STABILITY].text = this.character.radiationResist + "%";
         var evadeValue1:int = (this.character.stats[Character.STAT_DEFTNESS] - 2) * 2;
         var evadeValue2:int = (this.character.stats[Character.STAT_PERCEPTION] / 5 + this.character.stats[Character.STAT_DEFTNESS] - 2) * 2;
         var statIndex:int;
         if(this.character.hasPerk(Character.PERK_GUTTAPERCHA) || this.avaiblePerksBool[Character.PERK_GUTTAPERCHA])
         {
            evadeValue1 += 6;
            evadeValue2 += 6;
         }
         if(this.character.stats[Character.STAT_PERCEPTION] + this.character.stats[Character.STAT_DEFTNESS] >= 17)
         {
            evadeValue1 += 12;
            evadeValue2 += 12;
         }
         else if(this.character.stats[Character.STAT_PERCEPTION] + this.character.stats[Character.STAT_DEFTNESS] >= 15)
         {
            evadeValue1 += 4;
            evadeValue2 += 4;
         }
         if(this.character.hasAbility(Character.ABILITY_EVADE_CHANCE))
         {
            evadeValue1 += 3;
            evadeValue2 += 3;
         }
         if(this.character.hasAbility(Character.ABILITY_EVADE_CHANCE2))
         {
            evadeValue1 += 12;
            evadeValue2 += 12;
         }
         if(this.character.hasAbility(Character.ABILITY_EVADE_CHANCE3))
         {
            evadeValue1 += 10;
            evadeValue2 += 10;
         }
         if(this.character.hasAbility(Character.ABILITY_EVADE_CHANCE4))
         {
            evadeValue1 += 10;
            evadeValue2 += 10;
         }
         if(this.character.hasPerk(Character.PERK_EXTRA_REFLEXES))
         {
            evadeValue1 += 6;
            evadeValue2 += 6;
         }
         if(evadeValue1 > evadeValue2)
         {
            this.calculatedParams[CALCULATED_EVADE_PROBABILITY].text = evadeValue2 + "-" + evadeValue1 + "%";
         }
         else
         {
            this.calculatedParams[CALCULATED_EVADE_PROBABILITY].text = evadeValue1 + "-" + evadeValue2 + "%";
         }
         this.calculatedParams[CALCULATED_SKILL_POINTS].text = Character.SKILL_ADD_VALUE[this.character.stats[Character.STAT_INTELLECT] - 1];
         statIndex = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            this.statCounts[statIndex].text = this.character.stats[statIndex];
            statIndex++;
         }
         if(this.statsCountTF)
         {
            this.statsCountTF.text = this.statsAvaible.toString();
         }
      }
      
      private function addDecButton(param1:int, param2:int, param3:Function, param4:int = 0) : NButton
      {
         var arrowBitmap:Bitmap = getBmp("LEFT_ARROW");
         var button:NButton = new NButton(param3,arrowBitmap,getBmp("LEFT_ARROW_OVER"),getBmp("LEFT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      private function avatarCompleteHandler(param1:Event) : void
      {
         param1.target.loader.scaleX = 0.5;
         param1.target.loader.scaleY = 0.5;
         param1.target.removeEventListener(Event.COMPLETE,this.avatarCompleteHandler);
      }
      
      private function addAvatar(param1:int, param2:int, param3:Function, param4:int = 0) : NButton
      {
         var avatarFrame:UIElement = new UIElement();
         avatarFrame.draw(getBmp("SILVER_FRAME"),0,0);
         var avatarLoader:Loader = new Loader();
         avatarLoader.x = 1;
         avatarLoader.y = 1;
         var avatarRequest:URLRequest = new URLRequest("icons/avatar/av" + param4 + ".jpg");
         avatarLoader.load(avatarRequest);
         avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.avatarCompleteHandler);
         avatarFrame.addChild(avatarLoader);
         var button:NButton = new NButton(param3,avatarFrame,avatarFrame,avatarFrame,null);
         button.value = param4;
         button.setSize(AVATAR_WIDTH,AVATAR_HEIGHT);
         button.x = param1;
         button.y = param2;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      private function addAddButton(param1:int, param2:int, param3:Function, param4:int = 0) : NButton
      {
         var arrowBitmap:Bitmap = getBmp("RIGHT_ARROW");
         var button:NButton = new NButton(param3,arrowBitmap,getBmp("RIGHT_ARROW_OVER"),getBmp("RIGHT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      private function addLabel(param1:int, param2:int, param3:int, param4:int, param5:String) : TextField
      {
         var label:TextField = new TextField();
         label.background = false;
         label.border = false;
         label.multiline = true;
         label.selectable = false;
         label.wordWrap = true;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         label.defaultTextFormat = labelFormat;
         label.x = param1;
         label.y = param2;
         label.width = param3;
         label.height = param4;
         label.text = param5;
         this.submenu.addChild(label);
         return label;
      }
      
      private function loadAppearance() : void
      {
         if(this.curApear < 0)
         {
            curApear = AVATAR_GROUPS_COUNT[this.character.sex] - 1;
         }
         else if(this.curApear >= AVATAR_GROUPS_COUNT[this.character.sex])
         {
            curApear = 0;
         }
         if(this.isCharCreate)
         {
            this.character.images[Character.APPEARANCE_IDX] = this.curApear;
         }
         this.gameBitmap1.doAction945(this.character);
         this.updateAvatarSprites();
         this.enableTabs();
      }
      
      private function nullSendCharacter() : void
      {
         var index:int = 0;
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            this.character.stats[index] = 3;
            index++;
         }
         index = 0;
         while(index < BATTLE_SKILLS_COUNT)
         {
            this.battleSkillCheckBool[index] = false;
            index++;
         }
         index = 0;
         while(index < PEACE_SKILLS_COUNT)
         {
            this.peaceSkillCheckBool[index] = false;
            index++;
         }
         index = 0;
         while(index < Character.MAX_PERK_COUNT)
         {
            this.avaiblePerksBool[index] = false;
            index++;
         }
      }
      
      private function sendCharacterType() : void
      {
         switch(this.selectedCharType)
         {
            case CHAR_TYPE_LIGHT:
               this.nullSendCharacter();
               this.character.stats[Character.STAT_STRENGTH] = 8;
               this.character.stats[Character.STAT_ENDURANCE] = 10;
               this.character.stats[Character.STAT_LUCK] = 10;
               this.character.stats[Character.STAT_PERCEPTION] = 3;
               this.character.stats[Character.STAT_DEFTNESS] = 3;
               this.character.stats[Character.STAT_INTELLECT] = 5;
               this.battleSkillCheckBool[Character.SKILL_COLD_ARMS] = true;
               this.battleSkillCheckBool[Character.SKILL_SMALL_ARMS] = true;
               this.peaceSkillCheckBool[Character.SKILL_DOCTOR - BATTLE_SKILLS_COUNT] = true;
               this.peaceSkillCheckBool[Character.SKILL_TRADE - BATTLE_SKILLS_COUNT] = true;
               this.avaiblePerksBool[Character.PERK_DODGER] = true;
               statsAvaible = 0;
               this.charDone();
               break;
            case CHAR_TYPE_RIFLEMAN:
               this.nullSendCharacter();
               this.character.stats[Character.STAT_STRENGTH] = 5;
               this.character.stats[Character.STAT_ENDURANCE] = 6;
               this.character.stats[Character.STAT_LUCK] = 10;
               this.character.stats[Character.STAT_PERCEPTION] = 7;
               this.character.stats[Character.STAT_DEFTNESS] = 6;
               this.character.stats[Character.STAT_INTELLECT] = 5;
               this.battleSkillCheckBool[Character.SKILL_SMALL_ARMS] = true;
               this.battleSkillCheckBool[Character.SKILL_POWER_WEAPON] = true;
               this.peaceSkillCheckBool[Character.SKILL_TRADE - BATTLE_SKILLS_COUNT] = true;
               this.peaceSkillCheckBool[Character.SKILL_SCIENCE - BATTLE_SKILLS_COUNT] = true;
               this.avaiblePerksBool[Character.PERK_GUTTAPERCHA] = true;
               statsAvaible = 0;
               this.charDone();
               break;
            case CHAR_TYPE_HEAVY:
               this.nullSendCharacter();
               this.character.stats[Character.STAT_STRENGTH] = 6;
               this.character.stats[Character.STAT_ENDURANCE] = 5;
               this.character.stats[Character.STAT_LUCK] = 10;
               this.character.stats[Character.STAT_PERCEPTION] = 5;
               this.character.stats[Character.STAT_DEFTNESS] = 6;
               this.character.stats[Character.STAT_INTELLECT] = 7;
               this.battleSkillCheckBool[Character.SKILL_COLD_ARMS] = true;
               this.battleSkillCheckBool[Character.SKILL_HEAVY_WEAPON] = true;
               this.peaceSkillCheckBool[Character.SKILL_DOCTOR - BATTLE_SKILLS_COUNT] = true;
               this.peaceSkillCheckBool[Character.SKILL_REPAIR - BATTLE_SKILLS_COUNT] = true;
               this.avaiblePerksBool[Character.PERK_REGENERATION] = true;
               statsAvaible = 0;
               this.charDone();
               break;
         }
      }
      
      private function charDone() : void
      {
         var request:String = "cc|" + this.curApear + "|" + this.selectedAvatar + "|";
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            request += this.character.stats[index] + "|";
            index++;
         }
         var index:int;
         var priorityMask:int = 0;
         index = 0;
         while(index < BATTLE_SKILLS_COUNT)
         {
            if(this.battleSkillCheckBool[index])
            {
               priorityMask |= 1 << index;
            }
            index++;
         }
         index = 0;
         while(index < PEACE_SKILLS_COUNT)
         {
            if(this.peaceSkillCheckBool[index])
            {
               priorityMask |= 1 << index + BATTLE_SKILLS_COUNT;
            }
            index++;
         }
         var perkIndex:int = 0;
         index = 0;
         while(index < Character.MAX_PERK_COUNT)
         {
            if(this.avaiblePerksBool[index])
            {
               perkIndex = index;
            }
            index++;
         }
         request += priorityMask + "|" + perkIndex + "|";
         this.socket.sendStr(request);
      }
      
      private function handleStatBtnPress(param1:Object) : void
      {
         var statIndex:int = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            updateBgUI(this.statBtn[statIndex].upState,false,this.statBtn[statIndex].upState.width,this.statBtn[statIndex].upState.height,this.statBtn[statIndex].textField1,this.statBtn[statIndex].textField2);
            statIndex++;
         }
         updateBgUI(param1.upState,true,param1.upState.width,param1.upState.height,param1.textField1);
         this.createInfoMenu(getString("IDS_STAT_" + param1.value.toString()),getString("IDS_STAT_DESC_" + param1.value.toString()));
      }
      
      private function handleAddStatButton(param1:Object) : void
      {
         if(this.character.stats[param1.value] < Character.MAX_STAT_VAL && this.statsAvaible > 0)
         {
            ++this.character.stats[param1.value];
            --this.statsAvaible;
            this.updateCharacterLabels();
            this.enableTabs();
         }
      }
      
      private function handleDecStatButton(param1:Object) : void
      {
         if(this.character.stats[param1.value] > Character.START_STAT_VAL && this.statsAvaible < this.maxStats)
         {
            --this.character.stats[param1.value];
            ++this.statsAvaible;
            this.updateCharacterLabels();
            this.enableTabs();
         }
      }
      
      private function createInfoMenu(param1:String, param2:String) : void
      {
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         infoMenu = new NUIComponent();
         this.infoMenu.x = 18;
         this.infoMenu.y = 67;
         addUIChild(this.infoMenu);
         this.infoMenu.fillBg(4,4,INFO_MENU_WIDTH - 8,INFO_MENU_HEIGHT - 8);
         this.infoMenu.drawFrame(0,0,INFO_MENU_WIDTH,INFO_MENU_HEIGHT);
         var closeBitmap:Bitmap = new CLOSE();
         var closeButton:NButton = new NButton(this.closeInfoMenuHandler,closeBitmap,new CLOSE_OVER(),new CLOSE_PRESSED(),closeBitmap);
         closeButton.x = 196;
         closeButton.y = 12;
         this.infoMenuItems.push(closeButton);
         this.infoMenu.addUIChild(closeButton);
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13343541;
         titleFormat.size = 12;
         titleFormat.bold = true;
         var descriptionFormat:TextFormat = new TextFormat();
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187296;
         descriptionFormat.size = 12;
         var label:TextField = createTextField(30,17,150,titleFormat,param1);
         this.infoMenu.addChild(label);
         label = createTextField(0,0,185,descriptionFormat);
         label.wordWrap = true;
         label.text = param2;
         label.height = label.textHeight + 6;
         var scroll:ScrollSprite = new ScrollSprite(192,254);
         scroll.addLine(label);
         scroll.x = 22;
         scroll.y = 44;
         scroll.init();
         this.infoMenuItems.push(scroll);
         this.infoMenu.addUIChild(scroll);
      }
      
      private function closeInfoMenuHandler(param1:Object) : void
      {
         this.clearInfoMenuItems();
      }
      
      private function clearInfoMenuItems() : void
      {
         var item:Object = null;
         removeChild(this.infoMenu);
         while(this.infoMenuItems.length > 0)
         {
            item = this.infoMenuItems.pop();
            item.dispose();
         }
         infoMenu = null;
      }
   }
}

