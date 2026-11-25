package game
{
   import core.resources.Localization;
   import net.*;
   import game.npc.*;
   import core.ui.BaseApplication;
   import ui.menus.*;
   import core.effects.ColorEffect;
   import game.world.WorldItem;
   import events.*;
   import flash.display.*;
   import flash.events.*;
   import flash.system.fscommand;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import ui.*;
   
   public class Client extends BaseApplication
   {
      
      public static var MONTH_DAYS:int = 30;
      
      public static const MAX_STAGE_WIDTH:int = 1280;
      
      public static const MAX_STAGE_HEIGHT:int = 1024;
      
      public static const ERROR_WRONG_LOGIN:int = 0;
      
      public static const ERROR_USER_ONLINE:int = 1;
      
      public static const ERROR_BANNED:int = 2;
      
      public static const ERROR_TO_MANY_TRIES:int = 6;
      
      public static var PROD_ERROR_WRON_RES_TYPE:int = 0;
      
      public static var PROD_ERROR_EMPTY:int = 1;
      
      public static var client:Client;

      public static const currentCharacter:Character = new Character();
      
      public static var QUEST_IN_PROGRESS:int = 0;
      
      public static var QUEST_IS_FINISHED:int = 1;
      
      public static var QUEST_IS_FAILED:int = 2;
      
      public static var QUEST_IN_PROGRESS_SAVE:int = 3;
      
      public static var PET_AGRESSION_TOTAL:int = 0;
      
      public static var PET_AGRESSION_PVE:int = 1;
      
      public static var PET_AGRESSION_PVP:int = 2;
      
      public static var PET_AGRESSION_NONE:int = 3;
      
      public static var ACTION_TYPE_BOT_REPAIR:int = 0;
      
      public static var ACTION_TYPE_ASK_REPAIR:int = 1;
      
      public static var ACTION_TYPE_REPAIR:int = 2;
      
      public static var ACTION_TYPE_BOT_HEAL:int = 3;
      
      public static var ACTION_TYPE_ASK_HEAL:int = 4;
      
      public static var ACTION_TYPE_HEAL:int = 5;
      
      public static var ACTION_TYPE_BARTER:int = 6;
      
      public static var HINT_TYPE_SELECT_WARNING:int = -1;
      
      public static var HINT_TYPE_NONE:int = 0;
      
      public static var HINT_TYPE_TARGET_UL:int = 1;
      
      public static var HINT_TYPE_TARGET_UR:int = 2;
      
      public static var HINT_TYPE_TARGET_DR:int = 3;
      
      public static var HINT_TYPE_TARGET_DL:int = 4;
      
      public static var NPC_TRADE_BOT:int = 0;
      
      public static var NPC_TRADE_BOX:int = 1;
      
      public static var NPC_TRADE_CELL:int = 2;
      
      public static const MENU_SETTINGS:int = 0;
      
      public static const MENU_NOTIFY_WARN:int = 1;
      
      public static const MENU_WARNING:int = 2;
      
      public static const MENU_PAY_SYSTEM:int = 3;
      
      public static const MENU_QUEST_LOG:int = 4;
      
      public static const MENU_BOT_BARTER:int = 5;
      
      public static const MENU_DIALOG:int = 6;
      
      public static const MENU_ACTION:int = 7;
      
      public static const MENU_BARTER_REQUEST:int = 8;
      
      public static const MENU_BARTER_WAIT:int = 9;
      
      public static const MENU_PAID_SERVICES:int = 10;
      
      public static const MENU_MAP:int = 11;
      
      public static const MENU_REFERAL:int = 12;
      
      public static const MENU_CHAR_INFO:int = 13;
      
      public static const MENU_INVENTORY:int = 14;
      
      public static const MENU_COUNT:int = 15;
      
      public static const MENU_RESPAWN_COUNTER:int = 16;
      
      public static const MENU_TIPS:int = 17;
      
      public static const MENU_CHAR_CREATE:int = 18;
      
      public static const MENU_CHARACTER:int = 19;
      
      public static const MENU_HINT:int = 20;
      
      public static const MENU_DEPOD:int = 21;
      
      public static const MENU_DEPOD_SUBMENU:int = 22;
      
      public static const MENU_FACTORY:int = 23;
      
      public static const MENU_CRAFT:int = 24;
      
      public static const MENU_UPGRADE:int = 25;
      
      public static const MENU_PRINT:int = 26;
      
      public static const MENUS_COUNT:int = 27;
      
      public static const TM_MENU_28:int = 28;
      
      public static const TM_MENU_MAIN:int = 0;
      
      public static const TM_MENU_REQUEST_ZONES:int = 1;
      
      public static const TM_MENU_ATTACK_ZONES:int = 2;
      
      public static const TM_MENU_LOCATIONS:int = 3;
      
      public static const TM_EXIT:int = 4;
      
      public static const TM_MENU_INVENTORY:int = 5;
      
      public static const TM_MENU_WELCOM:int = 6;
      
      public static const TM_MENU_CLAN:int = 7;
      
      public static const TM_MENU_CLAN_CONTROL:int = 8;
      
      public static const TM_MENU_CLAN_MONEY:int = 9;
      
      public static const TM_MENU_CLAN_DUES:int = 10;
      
      public static const TM_MENU_EXCHANGE:int = 11;
      
      public static const TM_MENU_RATING:int = 12;
      
      public static const TM_MENU_CLAN_HIRE:int = 13;
      
      public static const TM_SUBMENU_HIRE:int = 14;
      
      public static const TM_MENU_PRIVATE_HIRE:int = 15;
      
      public static const TM_MENU_PRIVATE_NEW_ORDER:int = 16;
      
      public static const TM_MENU_PRIVATE_MY_ORDERS:int = 17;
      
      public static const TM_MENU_RLS:int = 18;
      
      public static const TM_MENU_RAID:int = 20;
      
      public static const TM_MENU_RAID_LOCS:int = 21;
      
      public static const TM_MENU_RAID_PARTIES:int = 22;
      
      public static const TM_MENU_RAID_23:int = 23;
      
      public static const HIRE_TYPE_25:int = 25;
      
      public static var HIRE_TYPE_CLAN:int = 0;
      
      public static var HIRE_TYPE_PRIVATE:int = 1;
      
      public static var HIRE_TYPE_NEW_ORDER:int = 2;
      
      public static var HIRE_TYPE_MY_ORDERS:int = 3;
      
      protected static var _curWidth:int;

      protected static var _curHeight:int;

      public var world:World;
      
      public var socket:GameSocket;
      
      public var sessionId:uint;
      
      public var player:PlayerItem;
      
      public var SCREEN_STEP:int = 50;
      
      public var setWidth:int = -1;
      
      public var setHeight:int = -1;
      
      public var usingExpendable:Boolean = false;
      
      public var expInUse:Boolean = false;
      
      public var expendableIdx:int = -1;
      
      public var gameStarted:Boolean = false;
      
      public var barterUserId:int = -1;
      
      public var processTime:uint = 0;
      
      public var processInterval:uint;
      
      public var processLoadInterval:uint;
      
      public var clickedUser:PlayerItem = null;
      
      public var useMenuInterval:int = -1;
      
      public var tox:int;
      
      public var toy:int;
      
      public var realToX:int;
      
      public var realToY:int;
      
      public var moveUse:Boolean = false;
      
      public var isCtrlPressed:Boolean = false;
      
      public var flag4:Boolean = false;
      
      protected const nZoneInfo1:NZoneInfo = new NZoneInfo();
      
      protected var deathStr:String;
      
      public var upPressed:Boolean = false;
      
      public var downPressed:Boolean = false;
      
      public var rightPressed:Boolean = false;
      
      public var leftPressed:Boolean = false;
      
      protected var settings1:Settings;
      
      public var playerLogin:String;
      
      public var questArrowSprite:Sprite;
      
      public var upStairsSprite:Sprite;
      
      public var questCoords:Dictionary = new Dictionary();
      
      public var startResetPlaceId:int = -1;
      
      public var startQuestId:int = -1;
      
      public var startQuestName:String = "";
      
      public var startPlaceName:String = "";
      
      public var startPlaceI:int = -1;
      
      public var startPlaceJ:int = -1;
      
      public var startPlaceLevel:int = -1;
      
      public var startHintType:int = -1;
      
      public var startHintHeader:String;
      
      public var startHintText:String;
      
      public var lootStr:String;
      
      public var userCharacter:Character = currentCharacter;
      
      protected var serviceTime:int = 0;
      
      public var menus:Array = new Array();
      
      protected var lastMenuX:int;
      
      protected var lastMenuY:int;
      
      public const MENU_POS_CENTER:int = 0;
      
      public const MENU_POS_LAST_COORDS:int = 1;
      
      public const MENU_POS_CENTER_NOCHAT:int = 2;
      
      public const MENU_POS_MOUSE:int = 3;
      
      public const MENU_POS_FREE:int = 4;
      
      public const intValue185:int = 5;
      
      protected var menu:Object;
      
      public var expPanel:Object;
      
      protected var getData:Array;
      
      public function Client()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.settings1 = new Settings();
      }
      
      public static function get curWidth() : int
      {
         return _curWidth;
      }
      
      public static function get curHeight() : int
      {
         return _curHeight;
      }
      
      public static function get settings() : Settings
      {
         return client.settings1;
      }
      
      public static function getString(param1:String) : String
      {
         return Localization.getString(param1);
      }
      
      public static function _(param1:String, ... rest) : String
      {
         return rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1);
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onStageFullScreen);
         super.addedToStage(param1);
      }
      
      override public function get fullscreen() : Boolean
      {
         return super.fullscreen;
      }
      
      override public function set fullscreen(param1:Boolean) : void
      {
         fscommand("fscr");
         try
         {
            if(param1 && !this.flag60)
            {
               needFadeOut = true;
            }
            stage.displayState = param1 ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;
         }
         catch(e:*)
         {
         }
         _fullscreen = param1;
      }
      
      private function onStageFullScreen(param1:FullScreenEvent) : void
      {
         if(!param1.fullScreen)
         {
            needFadeOut = false;
         }
      }
      
      protected var needFadeOut:Boolean = false;

      public var flag60:Boolean = false;

      protected function hideMenus() : void
      {
         this.closeAllMenus();
         if(this.clickedUser || this.moveUse)
         {
            clearInterval(this.useMenuInterval);
            clickedUser = null;
         }
      }
      
      public function closeAllMenus() : void
      {
         var menuItem:Object = null;
         while(this.menus.length > 0)
         {
            menuItem = this.menus.pop();
            menuItem.closeMenu();
         }
      }
      
      public function centerMenus(param1:int, param2:int) : void
      {
         var menuIndex:int = 0;
         while(menuIndex < this.menus.length)
         {
            this.menus[menuIndex].centerMenu(param1,param2);
            menuIndex++;
         }
      }
      
      public function removeMenu(param1:Object) : void
      {
         var menuIndex:int = 0;
         while(menuIndex < this.menus.length)
         {
            if(this.menus[menuIndex] == param1)
            {
               this.menus.splice(menuIndex,1);
               break;
            }
            menuIndex++;
         }
      }
      
      public function getMenu(param1:int) : Object
      {
         var menuIndex:int = 0;
         while(menuIndex < this.menus.length)
         {
            if(this.menus[menuIndex].menuType == param1)
            {
               return this.menus[menuIndex];
            }
            menuIndex++;
         }
         return null;
      }
      
      public function closeMenu(param1:int) : void
      {
         var menuIndex:int = 0;
         while(menuIndex < this.menus.length)
         {
            if(this.menus[menuIndex].menuType == param1)
            {
               this.menus[menuIndex].closeMenu();
               return;
            }
            menuIndex++;
         }
      }
      
      protected function startGame() : void
      {
         this.nZoneInfo1.y = 50;
         uiContainer.addChild(this.nZoneInfo1);
      }
      
      protected function showTerminal() : void
      {
      }
      
      protected function showWorld() : void
      {
      }
      
      public function getTraumSaverity(param1:int) : int
      {
         return 0;
      }
      
      public function selectQuestTarget(param1:int) : void
      {
         Client.settings["questId"] = param1;
         if(this.questCoords[param1])
         {
            if(settings["selectedI"] == -1 && settings["selectedJ"] == -1)
            {
               this.world.setQuestCoords(this.questCoords[param1].i,this.questCoords[param1].j,this.questCoords[param1].lev);
            }
         }
      }
      
      public function resetQuestTarget() : void
      {
         if(settings["selectedI"] == -1 && settings["selectedJ"] == -1)
         {
            this.world.resetQuestCoords();
         }
         settings["questId"] = -1;
      }
      
      public function closeConfirmMenus() : void
      {
         this.closeMenu(MENU_NOTIFY_WARN);
         this.closeMenu(MENU_WARNING);
      }
      
      public function dataDialogLeave() : void
      {
         this.closeMenu(MENU_BOT_BARTER);
         this.closeMenu(MENU_BARTER_REQUEST);
         this.closeMenu(MENU_BARTER_WAIT);
         this.closeMenu(MENU_ACTION);
         this.closeMenu(MENUS_COUNT);
         this.closeMenu(MENU_COUNT);
      }
      
      public function resetPlace(param1:int, param2:int) : void
      {
         if(param2 == settings["questId"] && settings["selectedI"] == -1 && settings["selectedJ"] == -1)
         {
            if(this.gameStarted)
            {
               this.world.resetQuestCoords();
            }
            else
            {
               startResetPlaceId = param2;
            }
         }
         if(param1 == QUEST_IS_FINISHED || param1 == QUEST_IS_FAILED)
         {
            if(this.questCoords[param2])
            {
               delete this.questCoords[param2];
            }
         }
         if(param2 == settings["questId"] && (param1 == QUEST_IS_FINISHED || param1 == QUEST_IS_FAILED))
         {
            settings["questId"] = -1;
            this.targetNextQuest();
         }
      }
      
      private function targetNextQuest() : void
      {
         var quest:Object = null;
         if(settings["autoTarget"] && settings["questId"] == -1 && settings["selectedI"] == -1 && settings["selectedJ"] == -1)
         {
            for each(quest in this.questCoords)
            {
               settings["questId"] = quest.qId;
               this.world.setQuestCoords(quest.i,quest.j,quest.lev);
               return;
            }
         }
      }
      
      public function setPlace(param1:String, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int) : void
      {
         if(this.gameStarted)
         {
            if(settings["questId"] == -1 && settings["autoTarget"] && settings["selectedI"] == -1 && settings["selectedJ"] == -1)
            {
               settings["questId"] = param3;
            }
            if(param3 == settings["questId"] && settings["selectedI"] == -1 && settings["selectedJ"] == -1)
            {
               this.world.setQuestCoords(param5,param6,param7);
            }
         }
         else
         {
            startQuestId = param3;
            startQuestName = param1;
            startPlaceName = param4;
            startPlaceI = param5;
            startPlaceJ = param6;
            startPlaceLevel = param7;
         }
         if(param2 == QUEST_IS_FINISHED || param2 == QUEST_IS_FAILED)
         {
            if(this.questCoords[param3])
            {
               delete this.questCoords[param3];
            }
         }
         else
         {
            this.questCoords[param3] = {
               "qName":param1,
               "qId":param3,
               "plName":param4,
               "i":param5,
               "j":param6,
               "lev":param7
            };
         }
         if(param3 == settings["questId"] && (param2 == QUEST_IS_FINISHED || param2 == QUEST_IS_FAILED))
         {
            settings["questId"] = -1;
            this.targetNextQuest();
         }
      }
      
      public function setCoords(param1:Array, param2:int) : void
      {
         if(settings["selectedI"] == -1 && settings["selectedJ"] == -1)
         {
            this.world.questArrowSprite.visible = false;
         }
         questCoords = new Dictionary();
         var remainingPlaces:int = param1[param2];
         param2++;
         while(remainingPlaces > 0)
         {
            this.setPlace(param1[param2],QUEST_IN_PROGRESS,param1[param2 + 1],param1[param2 + 2],param1[param2 + 3],param1[param2 + 4],param1[param2 + 5]);
            param2 += 6;
            remainingPlaces--;
         }
         remainingPlaces = param1[param2];
         param2++;
         while(remainingPlaces > 0)
         {
            this.setPlace(param1[param2],QUEST_IN_PROGRESS,param1[param2 + 1],param1[param2 + 2],param1[param2 + 3],param1[param2 + 4],param1[param2 + 5]);
            param2 += 6;
            remainingPlaces--;
         }
      }
      
      private function processLoad(param1:Object) : void
      {
         this.socket.sendPlaceRespawn();
      }
      
      public function initClient() : void
      {
         MovieItem.init();
         PlayerItem.createPals();
         WorldItem.world = this.world;
      }
      
      public function updateFollowPosition() : void
      {
         if(this.world.followPosition.y - curHeight / 2 < this.player.y - MAX_STAGE_HEIGHT)
         {
            this.world.followPosition.y = this.player.y - MAX_STAGE_HEIGHT + curHeight / 2;
         }
         if(this.world.followPosition.x - curWidth / 2 < this.player.x - MAX_STAGE_WIDTH)
         {
            this.world.followPosition.x = this.player.x - MAX_STAGE_WIDTH + curWidth / 2;
         }
         if(this.world.followPosition.y + curHeight / 2 > this.player.y + MAX_STAGE_HEIGHT)
         {
            this.world.followPosition.y = this.player.y + MAX_STAGE_HEIGHT - curHeight / 2;
         }
         if(this.world.followPosition.x + curWidth / 2 > this.player.x + MAX_STAGE_WIDTH)
         {
            this.world.followPosition.x = this.player.x + MAX_STAGE_WIDTH - curWidth / 2;
         }
      }
      
      public function updateRun() : void
      {
      }
      
      protected function placeRespawnHandler() : void
      {
         this.world.placeRespawnHandler();
      }
      
      protected function processWorld() : void
      {
         if(this.upPressed || this.downPressed || this.leftPressed || this.rightPressed)
         {
            this.world.followMode = World.FOLLOW_POSITION;
            if(this.upPressed)
            {
               this.world.followPosition.y -= this.SCREEN_STEP;
            }
            if(this.downPressed)
            {
               this.world.followPosition.y += this.SCREEN_STEP;
            }
            if(this.leftPressed)
            {
               this.world.followPosition.x -= this.SCREEN_STEP;
            }
            if(this.rightPressed)
            {
               this.world.followPosition.x += this.SCREEN_STEP;
            }
            this.updateFollowPosition();
            this.world.moveCameraForPosition();
         }
      }
      
      public function getKey(param1:int) : int
      {
         return settings["key_" + param1];
      }
      
      public function updateMenu(param1:int, param2:Object) : void
      {
         var existingMenu:Object = this.getMenu(param1);
         if(existingMenu != null)
         {
            existingMenu.updateData(param2);
         }
      }
      
      public function startMenu(param1:int, param2:Object = null, param3:Object = null, param4:int = 0) : Object
      {
         var previousMenu:Object;
         if(param4 == this.MENU_POS_LAST_COORDS)
         {
            previousMenu = this.getMenu(param1);
            if(previousMenu)
            {
               lastMenuX = previousMenu.x;
               lastMenuY = previousMenu.y;
            }
         }
         this.closeMenu(param1);
         var createdMenu:NuclearMenu = this.createMenu(param1,param2);
         var propertyKey:*;
         if(!createdMenu)
         {
            if(param2)
            {
               for(propertyKey in param2)
               {
                  // the body was a trace() call: mxmlc omits it in release builds, but an
                  // empty for-in body makes ASC 1 compile all following assignments in
                  // this file through a temporary register
                  trace(propertyKey);
               }
            }
            return null;
         }
         switch(param4)
         {
            case this.MENU_POS_CENTER:
               createdMenu.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),ChatPanel.instance ? ChatPanel.instance.y : Math.min(curHeight,MAX_STAGE_HEIGHT));
               break;
            case this.MENU_POS_CENTER_NOCHAT:
               createdMenu.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),Math.min(curHeight,MAX_STAGE_HEIGHT));
               break;
            case this.MENU_POS_LAST_COORDS:
               if(!previousMenu)
               {
                  createdMenu.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),ChatPanel.instance.y);
               }
               else
               {
                  createdMenu.x = this.lastMenuX;
                  createdMenu.y = this.lastMenuY;
               }
               break;
            case this.MENU_POS_MOUSE:
               createdMenu.x = mouseX - int(createdMenu.width / 2);
               createdMenu.y = mouseY - int(createdMenu.height / 2);
               break;
         }
         createdMenu.menuType = param1;
         uiContainer.addUIChild(createdMenu);
         this.menus.push(createdMenu);
         if(param3)
         {
            param3.submenus.push(createdMenu);
         }
         return createdMenu;
      }
      
      public function createMenu(param1:int, param2:Object = null) : NuclearMenu
      {
         return null;
      }
      
      public function showCharCreateMenu() : void
      {
         this.startMenu(MENU_CHAR_CREATE);
      }
      
      public function showCharacterMenu(param1:Array = null, param2:int = 0) : void
      {
         this.startMenu(MENU_CHARACTER,{
            "data":param1,
            "idx":param2
         },null,this.MENU_POS_CENTER);
      }
      
      public function get(param1:int, param2:Object = null, param3:int = 0) : BaseMenu
      {
         var modalLayer:ModalLayer = this.getModalLayer1(param1,param2);
         if((modalLayer) && modalLayer.menu)
         {
            switch(param3)
            {
               case this.MENU_POS_CENTER:
                  if(Terminal.instance && Terminal.instance.visible)
                  {
                     modalLayer.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),Math.min(curHeight,440));
                  }
                  else
                  {
                     modalLayer.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),ChatPanel.instance ? ChatPanel.instance.y : Math.min(curHeight,MAX_STAGE_HEIGHT));
                  }
                  break;
               case this.MENU_POS_CENTER_NOCHAT:
                  modalLayer.centerMenu(Math.min(curWidth,MAX_STAGE_WIDTH),Math.min(curHeight,MAX_STAGE_HEIGHT));
                  break;
               case this.MENU_POS_LAST_COORDS:
                  break;
               case this.MENU_POS_MOUSE:
                  modalLayer.setPos(mouseX - int(this.menu.width / 2),mouseY - int(this.menu.height / 2));
                  break;
               case this.MENU_POS_FREE:
                  break;
               case this.intValue185:
                  modalLayer.setPos(8,-modalLayer.height - 8);
                  break;
            }
            if(param3 === this.intValue185)
            {
               ChatPanel.instance.addUIChild(modalLayer);
            }
            else
            {
               uiContainer.addUIChild(modalLayer);
            }
            this.menus.push(modalLayer.menu);
         }
         return modalLayer.menu;
      }
      
      protected function getModalLayer1(param1:int, param2:Object = null) : ModalLayer
      {
         var createdMenu:BaseMenu = null;
         switch(param1)
         {
            case BaseMenu.TYPE_CHARACTER_INFO:
               createdMenu = new CharacterInfo(false,this);
               break;
            case BaseMenu.TYPE_INVENTORY:
               createdMenu = new Inventory(param2);
               break;
            case BaseMenu.TYPE_REFERAL:
               this.closeMenu(param1);
               createdMenu = new ReferalMenu(param2);
               break;
            case BaseMenu.TYPE_CONFIRM:
               createdMenu = new ConfirmMenu(param2.message,param2.okClickHandler,param2.cancelClickHandler);
               break;
            case BaseMenu.TYPE_COUNT:
               createdMenu = new CountMenu(param2.item,param2.okClickHandler,param2.cancelClickHandler);
               break;
            case BaseMenu.TYPE_QUESTION:
               createdMenu = new QuestionMenu(param2.message,param2.yesClickHandler,param2.noClickHandler);
               break;
            case BaseMenu.TYPE_NOTIFY:
               createdMenu = new NotifyMenu(param2.data);
               break;
            case BaseMenu.TYPE_SOBER_CONFIRM:
               createdMenu = new SoberConfirmMenu(param2.message,param2.okClickHandler,param2.cancelClickHandler);
               break;
            case BaseMenu.TYPE_PAY_SYSTEM:
               createdMenu = new PaySystemMenu();
               break;
            case BaseMenu.TYPE_BOT_BARTER:
               createdMenu = new BotBarter(param2);
               break;
            case BaseMenu.TYPE_PRINT:
               createdMenu = new PrintMenu(param2.data);
               break;
            case BaseMenu.TYPE_CRAFT:
               createdMenu = new CraftMenu(param2.data);
               break;
            case BaseMenu.TYPE_UPGRADE:
               createdMenu = new UpgradeMenu(param2.data);
               break;
            case BaseMenu.TYPE_BADGE_SHOP:
               createdMenu = new BadgeShopMenu(param2.data);
               break;
            case BaseMenu.TYPE_ACTION_REQUEST:
               createdMenu = new ActionRequestMenu(param2);
               break;
            case BaseMenu.TYPE_ACTION_WAIT:
               createdMenu = new ActionWaitMenu(param2);
               break;
            case BaseMenu.TYPE_BARTER:
               if(param2.action == ACTION_TYPE_BARTER)
               {
                  createdMenu = new Barter(param2);
               }
               else if(param2.action == ACTION_TYPE_BOT_REPAIR)
               {
                  createdMenu = new RepairMenu({
                     "type":RepairMenu.TYPE_BOT_REPAIR,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               else if(param2.action == ACTION_TYPE_REPAIR)
               {
                  createdMenu = new RepairMenu({
                     "type":RepairMenu.TYPE_REPAIR,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               else if(param2.action == ACTION_TYPE_ASK_REPAIR)
               {
                  createdMenu = new RepairMenu({
                     "type":RepairMenu.TYPE_ASK_REPAIR,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               else if(param2.action == ACTION_TYPE_ASK_HEAL)
               {
                  createdMenu = new HealMenu({
                     "type":HealMenu.TYPE_ASK_HEAL,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               else if(param2.action == ACTION_TYPE_BOT_HEAL)
               {
                  createdMenu = new HealMenu({
                     "type":HealMenu.TYPE_BOT_HEAL,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               else if(param2.action == ACTION_TYPE_HEAL)
               {
                  createdMenu = new HealMenu({
                     "type":HealMenu.TYPE_HEAL,
                     "data":param2.data,
                     "offset":param2.dataIdx
                  });
               }
               break;
            case BaseMenu.TYPE_SOCIAL:
               createdMenu = new SocialMenu();
               break;
            case BaseMenu.TYPE_CUSTOMIZATION:
               createdMenu = new CustomizationMenu();
               break;
            case BaseMenu.TYPE_MANAGEMENT:
               createdMenu = new ManagementMenu(param2.data);
               break;
            case BaseMenu.TYPE_CLAN_PRODUCT:
               createdMenu = new ClanProductMenu(param2.data);
               break;
            case BaseMenu.TYPE_DEPOD:
               createdMenu = new DepodMenu(param2.data);
               break;
            case BaseMenu.TYPE_DEPOD_LOG:
               createdMenu = new DepodLogMenu(param2.data);
               break;
            case BaseMenu.TYPE_HINT:
               createdMenu = new HintMenu(param2.title,param2.text);
               break;
         }
         return new ModalLayer(createdMenu);
      }
      
      public function showPaidServicesMenu(param1:Array = null) : void
      {
         this.startMenu(MENU_PAID_SERVICES,{"data":param1},null,this.MENU_POS_CENTER);
      }
      
      public function showRespawnCounter(param1:int, param2:String) : void
      {
         this.startMenu(MENU_RESPAWN_COUNTER,{
            "respawnTicks":param1,
            "tip":param2
         },null,this.MENU_POS_FREE);
      }
      
      public function showBarterWait(param1:String, param2:int) : void
      {
         this.get(BaseMenu.TYPE_ACTION_WAIT,{
            "seconds":10,
            "username":param1,
            "action":param2
         });
      }
      
      public function showSettingsMenu() : void
      {
         this.startMenu(MENU_SETTINGS);
      }
      
      public function showBarterRequest(param1:String, param2:int) : void
      {
         this.get(BaseMenu.TYPE_ACTION_REQUEST,{
            "seconds":10,
            "username":param1,
            "action":param2
         });
      }
      
      public function showCharInfo() : Object
      {
         return this.get(BaseMenu.TYPE_CHARACTER_INFO);
      }
      
      public function showDepodMenu(param1:Array, param2:int = 0) : void
      {
         var existingMenu:Object = this.getMenu(MENU_DEPOD);
         var savedCellId:int = -1;
         if(existingMenu)
         {
            if(existingMenu.selectedCell)
            {
               savedCellId = existingMenu.selectedCell.value;
            }
         }
         this.startMenu(MENU_DEPOD,{
            "data":param1,
            "type":param2,
            "selectedId":savedCellId
         },null,this.MENU_POS_LAST_COORDS);
      }
      
      public function showMapMenu(param1:String, param2:int, param3:int) : Object
      {
         return this.startMenu(MENU_MAP,{
            "mapName":param1,
            "width":param2,
            "height":param3
         });
      }
      
      public function showYesNoMenu(param1:String, param2:Function, param3:Function = null) : void
      {
         this.get(BaseMenu.TYPE_QUESTION,{
            "message":param1,
            "yesClickHandler":param2,
            "noClickHandler":param3
         });
      }
      
      public function showWarningMenu(param1:String, param2:Function, param3:Function = null) : void
      {
         this.get(BaseMenu.TYPE_CONFIRM,{
            "message":param1,
            "okClickHandler":param2,
            "cancelClickHandler":param3
         });
      }
      
      public function dataBanText() : void
      {
         this.get(BaseMenu.TYPE_PAY_SYSTEM);
      }
      
      public function showNotifyMenu(param1:String, param2:int = 0) : void
      {
         this.get(BaseMenu.TYPE_NOTIFY,{"data":param1});
      }
      
      public function showRefMenu(param1:Array) : void
      {
         this.get(BaseMenu.TYPE_INVENTORY,{"data":param1});
      }
      
      public function showHint(param1:int, param2:String, param3:String) : void
      {
         var hintMenu:HintMenu = this.getMenu(BaseMenu.TYPE_HINT) as HintMenu;
         if(hintMenu)
         {
            hintMenu.pendingQueue(param2,param3);
         }
         else
         {
            this.get(BaseMenu.TYPE_HINT,{
               "type":param1,
               "title":param2,
               "text":param3
            },this.intValue185);
         }
      }
      
      public function showFactoryMenu(param1:Array) : void
      {
         this.startMenu(MENU_QUEST_LOG,{"data":param1});
      }
      
      public function showBotBarter(param1:int, param2:Array) : void
      {
         this.closeMenu(MENU_DEPOD);
         this.closeMenu(MENU_FACTORY);
         this.get(BaseMenu.TYPE_BOT_BARTER,{
            "type":param1,
            "data":param2
         });
      }
      
      public function showActionMenu(param1:int, param2:Array = null, param3:int = -1) : void
      {
         this.closeMenu(BaseMenu.TYPE_ACTION_REQUEST);
         this.closeMenu(BaseMenu.TYPE_ACTION_WAIT);
         this.get(BaseMenu.TYPE_BARTER,{
            "action":param1,
            "data":param2,
            "dataIdx":param3
         });
      }
      
      public function showDialogMenu(param1:Array, param2:Boolean, param3:int, param4:Boolean, param5:Boolean, param6:Boolean) : void
      {
         this.startMenu(MENU_DIALOG,{
            "data":param1,
            "isObjectDialog":param2,
            "nodeDataIdx":param3,
            "addTradeNode":param4,
            "addMedNode":param5,
            "addFixNode":param6
         });
      }
      
      private function handleTerminalData(param1:Array) : Boolean
      {
         var unusedInt:int = 0;
         switch(param1[0])
         {
            case "eg":
               this.tdataStartGame();
               return true;
            case "ul":
               this.dataWarList();
               return true;
            case "uu":
               this.doAction180();
               return true;
            case "cl":
               this.doAction465();
               return true;
            case "cu":
               this.tdataInventory();
               return true;
            case "du":
               this.tdataDeletePlayer();
               return true;
            case "et":
               this.dataEventChatText();
               return true;
            case "lr":
               this.tdataLocations();
               return true;
            case "de":
               this.tdataDueRequest();
               return true;
            case "co":
               this.tdataClanControl();
               return true;
            case "rc":
               this.tdataClanRequest();
               return true;
            case "zf":
               this.tdataZoneListFailed();
               return true;
            case "zl":
               this.tdataZoneList();
               return true;
            case "au":
               this.tdataZoneAuctionUpdate();
               return true;
            case "an":
               this.tdataZoneAuctionDelete();
               return true;
            case "zs":
               this.tdataAttackZoneSuccess();
               return true;
            case "az":
               this.tdataAvaibleZone();
               return true;
            case "ry":
               this.tdataRaidLocations();
               return true;
            case "r1":
               this.tdataRaidPartyUpdate();
               return true;
            case Commands.COMMANDS_CONST24:
               this.doAction629();
               return true;
            case Commands.COMMANDS_CONST2:
            case Commands.COMMANDS_CONST9:
            case Commands.COMMANDS_CONST12:
            case Commands.COMMANDS_CONST6:
            case Commands.COMMANDS_CONST16:
            case Commands.COMMANDS_CONST21:
            case Commands.COMMANDS_CONST15:
            case Commands.COMMANDS_CONST25:
            case Commands.COMMANDS_CONST23:
            case Commands.COMMANDS_CONST38:
               GameEventDispatcher.dispatch(param1);
               return true;
            case Commands.COMMANDS_CONST27:
               this.userCharacter.doAction303(param1);
               GameEventDispatcher.dispatch(param1);
               return true;
            case "r2":
               this.tdataRaidPartyRemove();
               return true;
            case "ro":
               this.tdataRaidPartiesList();
               return true;
            case "ri":
               this.tdataClanZoneList();
               return true;
            case "iv":
               this.tdataAddEvent();
               return true;
            case "ah":
               return true;
            case "ht":
               return true;
            case "za":
               this.tdataShowExchange();
               return true;
            case "zd":
               this.tdataOwnExchangeAdded();
               return true;
            case "ua":
               this.tdataChangeUserAccess();
               return true;
            case "eh":
               this.tdataRadiolocationRequest();
               return true;
            case "eu":
               this.tdataUpdateExchange();
               return true;
            case "ae":
               this.tdataRadiolocate();
               return true;
            case "hy":
               this.tdataClanHireMenu();
               return true;
            case "ph":
               this.tdataPrivateHireMenu();
               return true;
            case "hm":
               this.tdataMyHireRequests();
               return true;
            case "hu":
               this.tdataHireUsers();
               return true;
            case "hg":
               this.tdataPrivateHireAdd();
               return true;
            case "fu":
               this.tdataFindUser();
               return true;
            case "rr":
               this.tdataBanText();
               return true;
            case "rl":
               this.tdataSystemText();
               return true;
            case "mp":
               this.tdataShowMap();
               return true;
         }
         return false;
      }
      
      protected function handleData() : Boolean
      {
         if(!this.gameStarted)
         {
            switch(this.getData[0])
            {
               case "lg":
               case "ls":
               case "eg":
               case "cc":
               case "lf":
               case "hn":
               case "cl":
               case "cd":
               case "es":
               case "ch":
               case "ss":
               case Commands.COMMANDS_CONST27:
               case Commands.FRIENDS_INFO:
               case Commands.COMMANDS_CONST8:
               case Commands.COMMANDS_CONST25:
                  break;
               default:
                  return true;
            }
         }
         if(Terminal.instance != null && Terminal.instance.visible && this.handleTerminalData(this.getData))
         {
            return true;
         }
         switch(this.getData[0])
         {
            case "po":
               this.tdataChatText();
               break;
            case Commands.COMMANDS_CONST14:
               this.doAction449();
               return true;
            case Commands.FRIENDS_INFO:
            case Commands.COMMANDS_CONST8:
            case Commands.COMMANDS_CONST30:
            case Commands.COMMANDS_CONST15:
            case Commands.COMMANDS_CONST22:
            case Commands.COMMANDS_CONST39:
            case Commands.COMMANDS_CONST25:
            case Commands.COMMANDS_CONST1:
               GameEventDispatcher.dispatch(this.getData);
               return true;
            case Commands.COMMANDS_CONST24:
               this.doAction629();
               return true;
            case "zc":
               this.doAction668();
               return true;
            case "lg":
               this.dataLogin();
               return false;
            case "nb":
               this.dataNewBullets();
               return true;
            case "nw":
               this.dataNewWeapons();
               return true;
            case "ec":
               this.dataExperianceChange();
               return true;
            case "vh":
               this.dataBaseChange();
               return true;
            case "ur":
               this.dataUpdateRun();
               return true;
            case "wc":
               this.dataWeightChange();
               break;
            case "ce":
               this.dataCharExpendable();
               return true;
            case "ch":
               this.dataCharacter();
               return true;
            case "ps":
               this.dataSkillValueChange();
               return true;
            case "ls":
               this.dataStartGame();
               return true;
            case "lf":
               this.dataLoginFailed();
               return true;
            case "uu":
               this.dataUpdateUser();
               return true;
            case "pl":
               this.dataOwnPlayerLevel();
               return true;
            case "ul":
               this.dataUserList();
               return true;
            case "cv":
               this.tdataEnterTerminal();
               return true;
            case "fb":
               this.dataFireBullet();
               return true;
            case "eb":
               this.dataEffectStart();
               return true;
            case "cc":
               this.dataCreatingChar();
               return true;
            case "cm":
               this.dataCharacterMenu();
               GameEventDispatcher.dispatch(this.getData);
               return true;
            case "uc":
               this.dataUpdateCharacter();
               return true;
            case "iv":
               this.showPaySystemMenu();
               return true;
            case "ic":
               this.dataInventoryCancel();
               return true;
            case "ef":
               this.dataExpendableEndUse();
               return true;
            case "ar":
               this.dataActionRequest();
               return true;
            case "aw":
               this.dataActionWait();
               return true;
            case "al":
               this.dataActionLeave();
               return true;
            case "am":
               this.dataActionMenu();
               return true;
            case "ai":
               this.dataAddFixItem();
               return true;
            case "af":
               this.dataAddItem();
               return true;
            case "df":
               this.dataDelFixItem();
               return true;
            case "th":
               this.dataAddTraumaToAction();
               return true;
            case "td":
               this.dataDelTraumFromAction();
               return true;
            case "bc":
               this.dataAddExistItems();
               return true;
            case "di":
               this.dataDelOppItem();
               return true;
            case "ac":
               this.dataActionConfirm();
               return true;
            case "sa":
               this.dataSafeBarter();
               return true;
            case "bf":
               this.dataActionConfirmFault();
               return true;
            case "bb":
               this.dataBotAction();
               return true;
            case "rk":
               this.dataCraftRecipes();
               return true;
            case "rv":
               this.dataUpgradeRecipes();
               return true;
            case "ug":
               this.dataUpgradeGroups();
               return true;
            case "bx":
               this.dataTradeBox();
               return true;
            case "cb":
               this.dataTradeCell();
               return true;
            case "ql":
               this.dataShowInventory();
               return true;
            case "ah":
               this.dataAddHp();
               return true;
            case "ht":
               this.doAction913();
               return true;
            case Commands.COMMANDS_CONST32:
            case "ev":
               this.dataNewClanChatLevel();
               return true;
            case Commands.COMMANDS_CONST29:
               this.world.evadePlayer(this.getData[1]);
               return true;
            case Commands.COMMANDS_CONST27:
               this.userCharacter.doAction303(this.getData);
               if(this.world)
               {
                  this.world.redrawPlayers();
               }
               GameEventDispatcher.dispatch(this.getData);
               return true;
            case "ca":
               this.dataChangeAddon();
               return true;
            case "av":
               this.dataAddonValue();
               return true;
            case "et":
               this.doAction766();
               return true;
            case "sd":
               this.dataStartDialog();
               return true;
            case "ds":
               this.dataStartObjectDialog();
               return true;
            case "dn":
               this.dataDialogNode();
               return true;
            case "dl":
               this.closeActionMenus();
               return true;
            case "se":
               this.dataStartExpUse();
               return true;
            case "hd":
               this.dataSetFireType();
               return true;
            case "fs":
               this.dataEvadePlayer();
               return true;
            case "ex":
               this.dataEffectUpdate();
               return true;
            case "ss":
               this.dataServiceList();
               return true;
            case "bd":
               this.dataBuffDelete();
               return true;
            case "pc":
               this.dataAvaiblePerks();
               return true;
            case "hn":
               this.dataHint();
               return true;
            case "lp":
               this.dataPlaceList();
               return true;
            case "sp":
               this.dataSetPrice();
               return true;
            case "rp":
               this.dataUpdatePaidValues();
               return true;
            case "to":
               this.dataTraumOver();
               return true;
            case "od":
               this.dataOperationId();
               return true;
            case "he":
               this.dataSilentText();
               return true;
            case "hf":
               this.dataHealFailed();
               return true;
            case "dt":
               this.dataRespawn();
               return true;
            case "pr":
               this.dataPlaceRespawn();
               return true;
            case "mp":
               this.dataShowMap();
               return true;
            case "pd":
               this.dataPaidServices();
               return true;
            case "pp":
               this.dataPaidPresents();
               return true;
            case "pi":
               this.dataPaidShopItems();
               return true;
            case "ud":
               this.dataUpdatePaidServices();
               return true;
            case "pe":
               this.dataPayError();
               return true;
            case "sw":
               this.dataShowWelcom();
               return true;
            case "ua":
               this.dataChangeUserAccess();
               return true;
            case "rm":
               this.dataFactoryMenuUpdate();
               return true;
            case "pw":
               this.dataProductionError();
               return true;
            case "pn":
               this.dataAskProduction();
               return true;
            case "ld":
               this.doAction719();
               return true;
            case "fq":
               this.dataFinishQuest();
               return true;
            case "cp":
               this.dataChangePaidFeatures();
               return true;
            case "uw":
               this.dataOwnWeaponWait();
               return true;
            case "oe":
               this.dataOwnUse();
               return true;
            case "um":
               this.dataInventoryRepair();
               return true;
            case "es":
               this.dataServiceEnd();
               return true;
            case "ep":
               this.dataExchangeProcessed();
               return true;
            case "en":
               this.dataExchangeEnd();
               return true;
            case "sr":
               this.dataSapperResult();
               return true;
            case "fd":
               this.dataFade();
               return true;
            case "tl":
               this.dataTutorialHighlight();
               return true;
         }
         return false;
      }
      
      public function processData(param1:Array) : Boolean
      {
         this.getData = param1;
         return this.handleData();
      }
      
      protected function tdataChatText() : void
      {
         ChatPanel.instance.doAction604(this.getData[1],this.getData[2]);
         Terminal.instance.doAction604(this.getData[1],this.getData[2]);
      }
      
      protected function doAction449() : void
      {
         var notificationId:int;
         notificationId = this.getData[1];
         var notificationText:String = Chat.prepareText(_.apply(null,["IDS_NOTIFICATION_" + notificationId].concat(this.getData.slice(2))));
         var paidMenu:PaidServicesMenu;
         if(notificationText)
         {
            this.showNotifyMenu(notificationText);
            if(notificationId == 80 || notificationId == 81)
            {
               paidMenu = this.getMenu(MENU_PAID_SERVICES) as PaidServicesMenu;
               if(paidMenu)
               {
                  paidMenu.payBlocked = false;
               }
            }
         }
      }
      
      protected function doAction668() : void
      {
         var zoneStatus:int = this.getData[3];
         this.expPanel.setPvpType(zoneStatus);
         var zoneName:String = this.getData[1];
         var zoneDescription:String = this.getData[2];
         var zoneOwner:String = this.getData[5];
         this.nZoneInfo1.update(zoneName,zoneDescription,zoneStatus,zoneOwner);
         this.nZoneInfo1.x = Math.min(stageWidth,MAX_STAGE_WIDTH) - this.nZoneInfo1.width >> 1;
         var musicId:int = this.getData[4];
         this.world.playMusic(musicId);
      }
      
      protected function dataWeightChange() : void
      {
         this.world.userWeight = this.getData[1];
         UnitEventDispatcher.instance.dispatch(EventType.eventType1);
         menu = this.getMenu(Client.MENU_CHARACTER);
         if(this.menu != null)
         {
            this.menu.updateCharacterLabels();
         }
      }
      
      protected function dataEffectStart() : void
      {
         this.world.startEffect(this.getData[1],this.getData[2],this.getData[3],this.getData[4]);
      }
      
      protected function showPaySystemMenu() : void
      {
         this.showRefMenu(this.getData);
      }
      
      protected function dataInventoryCancel() : void
      {
         this.closeConfirmMenus();
         this.closeMenu(MENU_COUNT);
         this.closeMenu(MENU_INVENTORY);
      }
      
      protected function dataActionRequest() : void
      {
         barterUserId = this.getData[1];
         this.showBarterRequest(this.getData[2],this.getData[3]);
      }
      
      protected function dataActionWait() : void
      {
         barterUserId = this.getData[1];
         this.showBarterWait(this.getData[2],this.getData[3]);
      }
      
      protected function dataActionLeave() : void
      {
         this.dataDialogLeave();
      }
      
      protected function dataActionMenu() : void
      {
         this.socket.barterOpId = 0;
         this.dataDialogLeave();
         switch(int(this.getData[1]))
         {
            case GameSocket.ACTION_REPAIR:
               this.showActionMenu(ACTION_TYPE_REPAIR,this.getData,8);
               break;
            case GameSocket.ACTION_ASK_REPAIR:
               this.showActionMenu(ACTION_TYPE_ASK_REPAIR,this.getData,8);
               break;
            case GameSocket.ACTION_ASK_HEAL:
               this.showActionMenu(ACTION_TYPE_ASK_HEAL,this.getData,8);
               break;
            case GameSocket.ACTION_HEAL:
               this.showActionMenu(ACTION_TYPE_HEAL,this.getData,8);
               break;
            case GameSocket.ACTION_BARTER:
               this.showActionMenu(ACTION_TYPE_BARTER,this.getData);
               break;
         }
      }
      
      protected function dataAddFixItem() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.addOpponentItem(this.getData);
         }
      }
      
      protected function dataAddItem() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.menu.addServerUserItem(this.getData);
         }
      }
      
      protected function dataDelFixItem() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.menu.delServerUserItem();
         }
      }
      
      protected function dataAddTraumaToAction() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.menu.addHealTraum(this.getData[2]);
         }
      }
      
      protected function dataDelTraumFromAction() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.menu.delHealTraum();
         }
      }
      
      protected function dataAddExistItems() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.addOpItemCount(this.getData[3],this.getData[2]);
         }
      }
      
      protected function dataDelOppItem() : void
      {
         this.socket.barterOpId = this.getData[1];
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.delOpItem(this.getData[3],this.getData[2]);
         }
      }
      
      protected function dataActionConfirm() : void
      {
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.opponentConfirm();
         }
      }
      
      protected function dataSafeBarter() : void
      {
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.barterEndTime = int(this.getData[1]) * 1000 + getTimer();
         }
      }
      
      protected function dataActionConfirmFault() : void
      {
         menu = this.getMenu(BaseMenu.TYPE_BARTER);
         if(this.menu)
         {
            this.menu.falseConfirm();
         }
      }
      
      protected function dataBotAction() : void
      {
         switch(int(this.getData[1]))
         {
            case GameSocket.ACTION_ASK_REPAIR:
               this.showActionMenu(Client.ACTION_TYPE_BOT_REPAIR,this.getData,7);
               break;
            case GameSocket.ACTION_ASK_HEAL:
               this.showActionMenu(Client.ACTION_TYPE_BOT_HEAL,this.getData,7);
               break;
            case GameSocket.ACTION_BARTER:
               this.showBotBarter(NPC_TRADE_BOT,this.getData);
               break;
         }
      }
      
      protected function dataCraftRecipes() : void
      {
         CraftSystem.parseCraftRecipes(this.getData);
         var craftMenu:CraftMenu = this.getMenu(BaseMenu.TYPE_CRAFT) as CraftMenu;
         if(craftMenu)
         {
            craftMenu.recipesLoaded();
         }
      }
      
      protected function dataUpgradeRecipes() : void
      {
         CraftSystem.parseUpgradeRecipes(this.getData);
         var upgradeMenu:UpgradeMenu = this.getMenu(BaseMenu.TYPE_UPGRADE) as UpgradeMenu;
         if(upgradeMenu)
         {
            upgradeMenu.recipesLoaded();
         }
      }
      
      protected function dataUpgradeGroups() : void
      {
         CraftSystem.parseUpgradeGroups(this.getData);
      }
      
      protected function doAction629() : void
      {
         var menuTypeId:int = this.getData[1];
         var existingMenu:Object;
         switch(menuTypeId)
         {
            case BaseMenu.TYPE_CRAFT:
            case BaseMenu.TYPE_UPGRADE:
            case BaseMenu.TYPE_PRINT:
            case BaseMenu.TYPE_BADGE_SHOP:
            case BaseMenu.TYPE_CLAN_PRODUCT:
            case BaseMenu.TYPE_MANAGEMENT:
               existingMenu = this.getMenu(menuTypeId);
               if(existingMenu)
               {
                  existingMenu.parseData(this.getData);
               }
               else
               {
                  this.get(menuTypeId,{"data":this.getData});
               }
               break;
            case BaseMenu.TYPE_SOCIAL:
            case BaseMenu.TYPE_CUSTOMIZATION:
            case BaseMenu.TYPE_DEPOD:
               this.get(menuTypeId,{"data":this.getData});
               break;
            case -TerminalSubmenu.TM_MENU_CLAN_25:
               Terminal.instance.createMenu(TerminalSubmenu.TM_MENU_CLAN_25);
               break;
            default:
               break;
         }
      }
      
      protected function dataTradeBox() : void
      {
         this.showBotBarter(NPC_TRADE_BOX,this.getData);
      }
      
      protected function dataTradeCell() : void
      {
         this.showBotBarter(NPC_TRADE_CELL,this.getData);
      }
      
      protected function dataShowInventory() : void
      {
         this.showFactoryMenu(this.getData);
      }
      
      protected function dataAddHp() : void
      {
         if(this.player && (int(this.getData[1]) == this.player.sessionId || int(this.getData[1]) == 0))
         {
            this.expPanel.setHp(this.player.hp + int(this.getData[2]),this.player.maxHp);
         }
         this.world.addHp(this.getData[1],this.getData[2]);
      }
      
      protected function doAction913() : void
      {
         var targetSessionId:int = this.getData[1];
         var damage:int = this.getData[2];
         var hitType:int = this.getData[3];
         if(targetSessionId == this.sessionId)
         {
            this.expPanel.setHp(this.player.hp - damage,this.player.maxHp);
         }
         this.world.hitPlayer(targetSessionId,damage,hitType);
      }
      
      protected function dataNewClanChatLevel() : void
      {
         this.world.doAction265(this.getData[1]);
      }
      
      protected function doAction766() : void
      {
         this.world.deleteAll();
         ChatPanel.instance.deleteAll();
         Terminal.instance.terminalNumber = this.getData[1] >> 1;
         Terminal.instance.radarMenuAvailable = (this.getData[1] & 1) == 1;
         this.showTerminal();
      }
      
      protected function dataStartDialog() : void
      {
         this.showDialogMenu(this.getData,false,8,this.getData[5] == 1,this.getData[6] == 1,this.getData[7] == 1);
      }
      
      protected function dataStartObjectDialog() : void
      {
         this.showDialogMenu(this.getData,true,3,false,false,false);
      }
      
      protected function dataDialogNode() : void
      {
         menu = this.getMenu(MENU_DIALOG);
         if(this.menu)
         {
            this.menu.parseDialogNode(this.getData,1);
         }
      }
      
      protected function closeActionMenus() : void
      {
         this.closeMenu(BaseMenu.TYPE_CUSTOMIZATION);
         this.closeMenu(BaseMenu.TYPE_BADGE_SHOP);
         this.closeMenu(MENU_DEPOD);
         this.closeMenu(BaseMenu.TYPE_MANAGEMENT);
         this.closeMenu(MENU_DIALOG);
         this.closeMenu(MENU_CRAFT);
         this.closeMenu(MENU_UPGRADE);
         this.closeMenu(MENU_PRINT);
      }
      
      protected function dataEvadePlayer() : void
      {
         NuclearChat.instance.setFireType(this.getData[1]);
      }
      
      protected function dataEffectUpdate() : void
      {
      }
      
      protected function doAction737() : void
      {
      }
      
      protected function dataServiceList() : void
      {
      }
      
      protected function dataBuffDelete() : void
      {
      }
      
      public function hideHint() : void
      {
         BaseApplication.hideHint();
      }
      
      protected function dataHint() : void
      {
         if(this.getData[3] != "")
         {
            if(!this.gameStarted)
            {
               startHintType = this.getData[1];
               startHintHeader = this.getData[2];
               startHintText = this.getData[3];
            }
            else
            {
               this.showHint(this.getData[1],this.getData[2],this.getData[3]);
            }
         }
         if(this.getData.length > 5)
         {
            this.setPlace(this.getData[2],this.getData[1],this.getData[4],this.getData[5],this.getData[6],this.getData[7],this.getData[8]);
         }
         else
         {
            this.resetPlace(this.getData[1],this.getData[4]);
         }
      }
      
      protected function dataPlaceList() : void
      {
         if(Client.settings["selectedI"] != -1 && Client.settings["selectedJ"] != -1)
         {
            this.world.setQuestCoords(Client.settings["selectedI"],Client.settings["selectedJ"],Client.settings["selectedLev"]);
         }
         this.setCoords(this.getData,1);
         this.world.updateArrow();
      }
      
      protected function dataSetPrice() : void
      {
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.menu.setPrice(this.getData[1]);
         }
      }
      
      protected function dataUpdatePaidValues() : void
      {
         menu = this.getMenu(BaseMenu.TYPE_INVENTORY) as Inventory;
         if(this.menu)
         {
            this.menu.itemRepaired(this.getData[1],this.getData[2]);
         }
      }
      
      protected function dataTraumOver() : void
      {
         menu = this.getMenu(MENU_ACTION);
         if(this.menu)
         {
            this.socket.barterOpId = this.getData[1];
            this.menu.removeTraum(this.getData[2]);
         }
         menu = this.getMenu(MENU_CHARACTER);
         if(this.menu)
         {
            this.menu.removeTraum(this.getData[2]);
         }
      }
      
      protected function dataOperationId() : void
      {
         this.socket.barterOpId = this.getData[1];
      }
      
      protected function dataHealFailed() : void
      {
         this.showNotifyMenu(getString("IDS_HEAL_FAILED"));
      }
      
      protected function dataRespawn() : void
      {
         this.showRespawnCounter(this.getData[1],this.getData.length > 2 ? this.getData[2] : "");
      }
      
      protected function dataPlaceRespawn() : void
      {
         this.showYesNoMenu(_("IDS_PLACE_RESPAWN"),this.processLoad);
      }
      
      protected function dataShowMap() : void
      {
         this.showMapMenu(this.getData[1],this.getData[2],this.getData[3]);
      }
      
      protected function dataPaidServices() : void
      {
         this.expPanel.hideServiceSprite();
         this.showPaidServicesMenu(this.getData);
      }
      
      protected function dataPaidPresents() : void
      {
         menu = this.getMenu(MENU_PAID_SERVICES);
         if(this.menu)
         {
            this.menu.getPresents(this.getData);
         }
      }
      
      protected function dataPaidShopItems() : void
      {
         menu = this.getMenu(MENU_PAID_SERVICES);
         if(this.menu)
         {
            this.menu.getShopItems(this.getData);
         }
      }
      
      protected function dataUpdatePaidServices() : void
      {
         menu = this.getMenu(MENU_PAID_SERVICES);
         if(this.menu)
         {
            this.menu.updateData(this.getData);
         }
      }
      
      protected function dataPayError() : void
      {
         this.showNotifyMenu(getString("IDS_PAY_ERROR_" + this.getData[1]));
         menu = this.getMenu(MENU_PAID_SERVICES);
         if(this.menu)
         {
            this.menu.payBlocked = false;
         }
      }
      
      protected function dataShowWelcom() : void
      {
         Terminal.instance.showWelcom = true;
      }
      
      protected function dataChangeUserAccess() : void
      {
         this.userCharacter.Permissions = this.getData[1];
      }
      
      protected function dataFactoryMenuUpdate() : void
      {
         this.get(BaseMenu.TYPE_REFERAL,{"data":this.getData});
      }
      
      protected function dataProductionError() : void
      {
         switch(int(this.getData[1]))
         {
            case PROD_ERROR_WRON_RES_TYPE:
               this.showNotifyMenu(_("IDS_PRODUCTION_WARN",_("IDS_RES_TYPE_" + this.getData[2])));
               break;
            case PROD_ERROR_EMPTY:
               this.showNotifyMenu(_("IDS_PRODUCTION_EMPTY"));
               break;
         }
      }
      
      protected function dataAskProduction() : void
      {
         this.showYesNoMenu(_("IDS_ASK_PRODUCTION",this.getData[1],this.getData[2],this.getData[3]),this.socket.sendAcceptProduction,this.socket.sendRejectProduction);
      }
      
      protected function doAction719() : void
      {
         var logMenu:DepodLogMenu = this.getMenu(BaseMenu.TYPE_DEPOD_LOG) as DepodLogMenu;
         if(logMenu)
         {
            logMenu.update(this.getData);
         }
         else
         {
            this.get(BaseMenu.TYPE_DEPOD_LOG,{"data":this.getData});
         }
      }
      
      protected function dataFinishQuest() : void
      {
         this.resetPlace(QUEST_IS_FINISHED,this.getData[1]);
      }
      
      protected function dataInventoryRepair() : void
      {
         menu = this.getMenu(MENU_PAID_SERVICES);
         if(this.menu)
         {
            this.menu.updateValues(this.getData[1],this.getData[2]);
         }
      }
      
      protected function dataServiceEnd() : void
      {
         if(this.gameStarted)
         {
            this.expPanel.startServiceMove(this.getData[1]);
         }
         else
         {
            serviceTime = this.getData[1];
         }
      }
      
      protected function dataExchangeProcessed() : void
      {
         this.showHint(HINT_TYPE_SELECT_WARNING,getString("IDS_TERM_ICO_11"),getString("IDS_WARNING") + " " + getString("IDS_EXCH_HINT_0") + " " + this.getData[3] + " " + getString("IDS_EXCH_HINT_1") + " " + this.getData[2] + " " + getString("IDS_EXCH_HINT_2") + " " + this.getData[1] + " " + getString("IDS_EXCH_HINT_3"));
      }
      
      protected function dataExchangeEnd() : void
      {
         this.showHint(HINT_TYPE_NONE,getString("IDS_TERM_ICO_11"),getString("IDS_EXCH_END"));
      }
      
      protected function dataSapperResult() : void
      {
         var targetSessionId:int = this.getData[1];
         var resultCode:int = this.getData[2];
         this.world.sapperText(targetSessionId,resultCode);
      }
      
      protected function dataStartGame() : void
      {
      }
      
      protected function dataLogin() : void
      {
      }
      
      protected function dataNewBullets() : void
      {
      }
      
      protected function dataNewWeapons() : void
      {
      }
      
      protected function dataExperianceChange() : void
      {
      }
      
      protected function dataBaseChange() : void
      {
      }
      
      protected function dataUpdateRun() : void
      {
      }
      
      protected function dataCharExpendable() : void
      {
      }
      
      protected function dataCharacter() : void
      {
      }
      
      protected function dataSkillValueChange() : void
      {
      }
      
      protected function dataLoginFailed() : void
      {
      }
      
      protected function dataUpdateUser() : void
      {
      }
      
      protected function dataOwnPlayerLevel() : void
      {
      }
      
      protected function dataUserList() : void
      {
      }
      
      protected function tdataEnterTerminal() : void
      {
         var worldPlayer:PlayerItem = this.world.getPlayer(int(this.getData[1]));
         if(worldPlayer != null)
         {
            worldPlayer.doAction332(this.getData.slice(2));
         }
      }
      
      protected function dataFireBullet() : void
      {
      }
      
      protected function dataCreatingChar() : void
      {
      }
      
      protected function dataCharacterMenu() : void
      {
      }
      
      protected function dataUpdateCharacter() : void
      {
      }
      
      protected function dataExpendableEndUse() : void
      {
      }
      
      protected function dataChangeAddon() : void
      {
      }
      
      protected function dataAddonValue() : void
      {
      }
      
      protected function dataStartExpUse() : void
      {
      }
      
      protected function dataSetFireType() : void
      {
         NuclearChat.instance.handleStateButton(this.getData[1]);
      }
      
      protected function dataAvaiblePerks() : void
      {
      }
      
      protected function dataSilentText() : void
      {
         this.userCharacter.skills[Character.SKILL_DOCTOR] = int(this.getData[1]);
      }
      
      protected function dataChangePaidFeatures() : void
      {
      }
      
      protected function dataOwnWeaponWait() : void
      {
      }
      
      protected function dataOwnUse() : void
      {
      }
      
      protected function dataFade() : void
      {
         this.getData[1] == "1" ? this.fadeIn() : this.fadeOut();
      }
      
      protected function dataTutorialHighlight() : void
      {
         this.addTutorialSelector(this.getData[1]);
      }
      
      protected function tdataStartGame() : void
      {
         this.showWorld();
      }
      
      protected function dataWarList() : void
      {
         GameSocket.socket.gameIsStarted = true;
         var fieldIndex:int = 1;
         while(fieldIndex < this.getData.length - 1)
         {
            Terminal.instance.onExit(UserList.parse(this.getData,fieldIndex));
            fieldIndex += 10;
         }
      }
      
      protected function doAction180() : void
      {
         var user:UserList = UserList.parse(this.getData,1);
         Terminal.instance.onExit(user);
         if(this.userCharacter.userId == user.userId && Terminal.instance.currentMenuId == Client.TM_MENU_CLAN_CONTROL && user.clanId == 0)
         {
            Terminal.instance.createMenu(Client.TM_MENU_CLAN);
         }
      }
      
      protected function doAction465() : void
      {
         GameSocket.socket.gameIsStarted = true;
         var fieldIndex:int = 1;
         var user:UserList;
         while(fieldIndex < this.getData.length - 1)
         {
            user = UserList.parse(this.getData,fieldIndex);
            Terminal.instance.onExit(user);
            ChatPanel.instance.doAction813(user);
            fieldIndex += 10;
         }
      }
      
      protected function tdataInventory() : void
      {
         this.doAction180();
         ChatPanel.instance.doAction813(UserList.parse(this.getData,1));
      }
      
      protected function tdataDeletePlayer() : void
      {
         Terminal.instance.doAction160(this.getData[1]);
         ChatPanel.instance.doAction526(this.getData[1]);
      }
      
      protected function dataEventChatText() : void
      {
         Terminal.instance.terminalNumber = this.getData[1];
      }
      
      protected function tdataLocations() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_LOCATIONS)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_LOCATIONS,true);
            }
            Terminal.instance.radioMenu.parseLocations(this.getData,1);
         }
      }
      
      protected function tdataDueRequest() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_CLAN_DUES)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_CLAN_DUES,true);
            }
            Terminal.instance.radioMenu.parseDue(this.getData);
         }
      }
      
      protected function tdataClanControl() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_CLAN_CONTROL)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_CLAN_CONTROL,true);
            }
            Terminal.instance.radioMenu.parseClanControl(this.getData);
         }
      }
      
      protected function tdataClanRequest() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_CLAN_CONTROL)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_CLAN_CONTROL,true);
            }
            Terminal.instance.radioMenu.parseClanRequest(this.getData);
         }
      }
      
      protected function tdataZoneListFailed() : void
      {
         this.showNotifyMenu(getString("IDS_ERROR_ZONE_ATTACK"));
      }
      
      protected function tdataZoneAuctionDelete() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_ATTACK_ZONES)
         {
            Terminal.instance.radioMenu.parseDeleteAuction(this.getData);
         }
      }
      
      protected function tdataZoneAuctionUpdate() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_ATTACK_ZONES)
         {
            Terminal.instance.radioMenu.updateAuctionData(this.getData);
         }
      }
      
      protected function tdataZoneList() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_ATTACK_ZONES)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_ATTACK_ZONES,true);
            }
            if(this.getData.length > 1)
            {
               Terminal.instance.radioMenu.parseAttackZones(this.getData,1);
            }
         }
      }
      
      protected function tdataAttackZoneSuccess() : void
      {
         this.showNotifyMenu(getString("IDS_ATTACK_SUCCESS"));
      }
      
      protected function tdataRaidLocations() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RAID_LOCS)
         {
            Terminal.instance.radioMenu.parseData(this.getData);
         }
      }
      
      protected function tdataClanZoneList() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RAID_LOCS)
         {
            Terminal.instance.createMenu(TM_MENU_RAID_PARTIES);
         }
      }
      
      protected function tdataRaidPartiesList() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RAID_PARTIES)
         {
            Terminal.instance.radioMenu.parseData(this.getData);
         }
      }
      
      protected function tdataRaidPartyUpdate() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RAID_PARTIES)
         {
            Terminal.instance.radioMenu.parseUpdateData(this.getData);
         }
      }
      
      protected function tdataRaidPartyRemove() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RAID_PARTIES)
         {
            Terminal.instance.radioMenu.parseRemoveData(this.getData);
         }
      }
      
      protected function tdataAvaibleZone() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_REQUEST_ZONES)
         {
            if(!Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_REQUEST_ZONES,true);
            }
            if(this.getData.length > 1)
            {
               Terminal.instance.radioMenu.parseLocationsList(this.getData,1);
            }
         }
      }
      
      protected function tdataAddEvent() : void
      {
         Terminal.instance.createMenu(TM_MENU_INVENTORY);
      }
      
      protected function tdataShowExchange() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_REQUEST_ZONES)
         {
            Terminal.instance.radioMenu.updateLocation(this.getData);
         }
      }
      
      protected function tdataOwnExchangeAdded() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_REQUEST_ZONES)
         {
            Terminal.instance.radioMenu.removeLocation(this.getData);
         }
      }
      
      protected function tdataChangeUserAccess() : void
      {
         this.userCharacter.Permissions = this.getData[1];
         switch(Terminal.instance.currentMenuId)
         {
            case TM_MENU_MAIN:
            case TM_MENU_CLAN:
               Terminal.instance.radioMenu.updatePageCount();
               break;
         }
      }
      
      protected function tdataRadiolocationRequest() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_EXCHANGE)
         {
            Terminal.instance.radioMenu.parseCreateMenu(this.getData);
         }
      }
      
      protected function tdataUpdateExchange() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_EXCHANGE)
         {
            Terminal.instance.radioMenu.parseMenuItems(this.getData,1);
         }
      }
      
      protected function tdataRadiolocate() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_EXCHANGE)
         {
            Terminal.instance.radioMenu.parseExchangeAdded(this.getData);
         }
      }
      
      protected function tdataClanHireMenu() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_CLAN_HIRE && Terminal.instance.radioMenu.mainType == HIRE_TYPE_CLAN)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_CLAN_HIRE,true);
            }
            Terminal.instance.radioMenu.parseClanHireData(this.getData,1);
         }
      }
      
      protected function tdataPrivateHireMenu() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_PRIVATE_HIRE || Terminal.instance.currentMenuId == TM_MENU_PRIVATE_MY_ORDERS || Terminal.instance.currentMenuId == TM_MENU_PRIVATE_NEW_ORDER)
         {
            if(Terminal.instance.radioMenu.mainType != HIRE_TYPE_PRIVATE || Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_PRIVATE_HIRE,true);
            }
            Terminal.instance.radioMenu.parsePrivateHireData(this.getData,1);
         }
      }
      
      protected function tdataMyHireRequests() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_PRIVATE_MY_ORDERS && Terminal.instance.radioMenu.mainType == HIRE_TYPE_MY_ORDERS)
         {
            if(Terminal.instance.radioMenu.dataLoaded)
            {
               Terminal.instance.createMenu(TM_MENU_PRIVATE_MY_ORDERS,true);
            }
            Terminal.instance.radioMenu.parseMyHireUsers(this.getData,1);
         }
      }
      
      protected function tdataHireUsers() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_PRIVATE_MY_ORDERS && Terminal.instance.radioMenu.mainType == HIRE_TYPE_MY_ORDERS)
         {
            Terminal.instance.radioMenu.parseHireUsers(this.getData,1);
         }
      }
      
      protected function tdataPrivateHireAdd() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_PRIVATE_NEW_ORDER && Terminal.instance.radioMenu.mainType == HIRE_TYPE_NEW_ORDER)
         {
            Terminal.instance.radioMenu.parsePrivateHireAdd(this.getData,1);
         }
      }
      
      protected function tdataFindUser() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_PRIVATE_NEW_ORDER && Terminal.instance.radioMenu.mainType == HIRE_TYPE_NEW_ORDER)
         {
            Terminal.instance.radioMenu.parsePrivateFindUser(this.getData,1);
         }
      }
      
      protected function tdataBanText() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RLS)
         {
            Terminal.instance.radioMenu.parseData(this.getData);
         }
      }
      
      protected function tdataSystemText() : void
      {
         if(Terminal.instance.currentMenuId == TM_MENU_RLS)
         {
            Terminal.instance.radioMenu.parseRadiolocation(this.getData);
         }
      }
      
      protected function tdataShowMap() : void
      {
      }
      
      public function fadeIn() : void
      {
         var effect:ColorEffect = new ColorEffect(this);
         effect.startBlueOffset = -255;
         effect.startGreenOffset = -255;
         effect.startRedOffset = -255;
         effect.endBlueOffset = 0;
         effect.endGreenOffset = 0;
         effect.endRedOffset = 0;
         effect.duration = 2;
         effect.play();
      }
      
      public function fadeOut() : void
      {
         var effect:ColorEffect = new ColorEffect(this);
         effect.startBlueOffset = 0;
         effect.startGreenOffset = 0;
         effect.startRedOffset = 0;
         effect.endBlueOffset = -255;
         effect.endGreenOffset = -255;
         effect.endRedOffset = -255;
         effect.duration = 2;
         effect.play();
      }
      
      public function addTutorialSelector(param1:int) : void
      {
      }
   }
}

