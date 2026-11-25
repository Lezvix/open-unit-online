package ui
{
   import ui.buttons.*;
   import core.loaders.Picture;
   import ui.controls.PresentItem;
   import net.GameSocket;
   import core.display.NSprite;
   import game.npc.*;
   import core.ui.BaseButton;
   import ui.menus.BaseMenu;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getDefinitionByName;
   import game.*;
   
   public class PaidServicesMenu extends NuclearMenu
   {
      
      public static var TS_BAG_SIZE_1:int = 0;
      
      public static var TS_BAG_SIZE_2:int = 1;
      
      public static var TS_SMALL_RESPAWN_TIME_1:int = 2;
      
      public static var TS_SMALL_RESPAWN_TIME_2:int = 3;
      
      public static var TS_SMALL_RESPAWN_TIME_3:int = 4;
      
      public static var TS_FAST_HP_REGENERATION_1:int = 5;
      
      public static var TS_FAST_HP_REGENERATION_2:int = 6;
      
      public static var TS_SMALL_TRAUM_TIME_1:int = 7;
      
      public static var TS_SMALL_TRAUM_TIME_2:int = 8;
      
      public static var TS_LONG_RUN_1:int = 9;
      
      public static var TS_LONG_RUN_2:int = 10;
      
      public static var TS_LONG_RUN_3:int = 11;
      
      public static var TS_EXP_BONUS_1:int = 12;
      
      public static var TS_EXP_BONUS_2:int = 13;
      
      public static var TS_EXP_BONUS_3:int = 14;
      
      public static var TS_EXP_BONUS_4:int = 15;
      
      public static var TS_AUTOATTACK:int = 16;
      
      public static var TS_SKILL_BONUS_1:int = 17;
      
      public static var TS_SKILL_BONUS_2:int = 18;
      
      public static var TS_SKILL_BONUS_3:int = 19;
      
      public static var TS_TRADE_SKILL_BONUS:int = 20;
      
      public static var TS_CONVERT_BONUS_1:int = 21;
      
      public static var TS_CONVERT_BONUS_2:int = 22;
      
      public static var TS_CONVERT_BONUS_3:int = 23;
      
      public static var TS_PLACE_RESPAWN:int = 24;
      
      public static var TS_DROP_AUTOCOLLECTION:int = 25;
      
      public static var TS_ITEM_LOTTERY:int = 26;
      
      public static var TS_FREE_ZONE_CROSSING:int = 27;
      
      public static var TS_LIMIT_SKILL_0:int = 28;
      
      public static var TS_LIMIT_SKILL_1:int = 29;
      
      public static var TS_LIMIT_SKILL_2:int = 30;
      
      public static var TS_LIMIT_SKILL_3:int = 31;
      
      public static var TS_LIMIT_SKILL_4:int = 32;
      
      public static var TS_LIMIT_SKILL_5:int = 33;
      
      public static var TS_LIMIT_SKILL_6:int = 34;
      
      public static var TS_LIMIT_SKILL_7:int = 35;
      
      public static var TS_LIMIT_SKILL_8:int = 36;
      
      public static var TS_FRIEND_PET_1:int = 37;
      
      public static var TS_FRIEND_PET_2:int = 38;
      
      public static var TS_FRIEND_KSENOMORF:int = 39;
      
      public static var TS_HIRE_LICENSE:int = 40;
      
      public static var TS_GAME_BIG_BAG:int = 41;
      
      public static var TS_REFERAL_EXP_BONUS:int = 42;
      
      public static var TS_FRIEND_PET_3:int = 43;
      
      public static var TS_FRIEND_PET_4:int = 44;
      
      public static var TS_FRIEND_PET_5:int = 45;
      
      public static var TS_LONG_NOPVP_RUN_1:int = 46;
      
      public static var TS_INVISIBLE:int = 47;
      
      public static var TS_FRIEND_PET_6:int = 48;
      
      public static var TS_FRIEND_PET_7:int = 49;
      
      public static var TS_FRIEND_PET_8:int = 50;
      
      public static var TS_FRIEND_PET_9:int = 51;
      
      private static var SERVICE_GROUP:Array = new Array(0,0,1,1,1,2,2,3,3,4,4,4,5,5,5,5,6,7,7,7,8,9,9,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,23,23,24,0,5,23,23,23,4,25,23,23,23,23);
      
      private static var PET_GROUP:int = 23;
      
      private static const PET_NAME_RESTRICT:String = " 0-9а-яА-Яa-zA-Z_-().";
      
      public static const SV_ACCAUNT_BUISNES:int = 0;
      
      public static const SV_ACCAUNT_PREMIUM:int = 1;
      
      public static const SV_ACCAUNT_VIP:int = 2;
      
      public static var SV_BAG_SIZE_1:int = 3;
      
      public static var SV_BAG_SIZE_2:int = 4;
      
      public static var SV_PLACE_RESPAWN:int = 5;
      
      public static var SV_FREE_ZONE_CROSSING:int = 6;
      
      public static var SV_LIMIT_SKILL_0:int = 20;
      
      public static var SV_LIMIT_SKILL_8:int = 28;
      
      private static var OWN_SERVICES_X:int = 280;
      
      private static var OWN_SERVICES_Y:int = 273;
      
      private static var OWN_SERVICES_WIDTH:int = 365;
      
      private static var OWN_SERVICES_HEIGHT:int = 106;
      
      private static var SERVICES_X:int = 279;
      
      private static var SERVICES_Y:int = 114;
      
      private static var SERVICES_WIDTH:int = 365;
      
      private static var SERVICES_HEIGHT:int = 209;
      
      private static var ACCAUNT_WIDTH:int = 180;
      
      private static var ACCAUNT_HEIGHT:int = 106;
      
      private static const SUBMENU:int = 0;
      
      private static const TABMENU:int = 1;
      
      private static const SUBMENU_STATS:int = 0;
      
      private static const SUBMENU_PERKS:int = 1;
      
      public static const ACCAUNT_COUNT:int = 4;
      
      public static var MENU_WIDTH:int = 658;
      
      public static var MENU_HEIGHT:int = 434;
      
      public static var INFO_MENU_WIDTH:int = 224;
      
      public static var INFO_MENU_HEIGHT:int = 334;
      
      public static var INFO_SMALL_WIDTH:int = 308;
      
      public static var INFO_SMALL_HEIGHT:int = 100;
      
      public static const TAB_COUNT:int = 4;
      
      private static var TAB_CONTROL:int = 0;
      
      private static var TAB_ACCAUNT:int = 1;
      
      private static var TAB_SERVICES:int = 2;
      
      private static var TAB_SHOP:int = 3;
      
      private static var TAB_STATS:int = 4;
      
      private static var TAB_HAIR:int = 5;
      
      private static var TAB_GIFTS:int = 6;
      
      private static var TAB_AVATARS:int = 7;
      
      private static var SS_PET:int = 0;
      
      private static var SS_AUTOLOOT:int = 1;
      
      public static const ACCAUNT_START:int = 0;
      
      public static const ACCAUNT_BUISNES:int = 1;
      
      public static const ACCAUNT_PREMIUM:int = 2;
      
      public static const ACCAUNT_VIP:int = 3;
      
      private static var MAX_CHANGE_STAT:int = 39;
      
      private static var STAT_CHANGE_COST:int = 75;
      
      private static var BSKILL_CHANGE_COST:int = 3;
      
      private static var PSKILL_CHANGE_COST:int = 1;
      
      private static var PSKILL_CHANGE_225:int = 225;
      
      private static var PSKILL_CHANGE_150:int = 150;
      
      private static const HAIR_PAL_1875:int = 1875;
      
      private static var HAIR_PAL_COUNT:int = 11;
      
      private static const PRESENT_CELL_HEIGHT:int = 60;
      
      private static const PRESENT_CELL_WIDTH:int = 420;
      
      private static const PRESENT_WIDTH:int = 105;
      
      private var ramDL:Bitmap;
      
      private var ramDR:Bitmap;
      
      private var ramSide:Bitmap;
      
      private var ramTop:Bitmap;
      
      private var ramUL:Bitmap;
      
      private var ramUR:Bitmap;
      
      private var ramBottom:Bitmap;
      
      private var glowRamDL:Bitmap;
      
      private var glowRamDR:Bitmap;
      
      private var glowRamSide:Bitmap;
      
      private var glowRamTop:Bitmap;
      
      private var glowRamUL:Bitmap;
      
      private var glowRamUR:Bitmap;
      
      private var glowRamBottom:Bitmap;
      
      public var main:Main;
      
      private var tabButtons:Array = new Array(TAB_COUNT);
      
      private var submenu:NUIComponent;
      
      private var submenuItems:Array = new Array();
      
      private var tabmenu:NUIComponent;
      
      private var tabmenuItems:Array = new Array();
      
      private var textMenu:NUIComponent;
      
      private var selectedTab:int;
      
      private var notPressedBmp:Array;
      
      private var pressedBmp:Array;
      
      private var overBmp:Array;
      
      private var ACCAUNT_BMP_CLASS:Array;
      
      private const filterNotPressedBmp:Vector.<Bitmap> = new Vector.<Bitmap>(ShopItem.PAY_FILTER_8,true);
      
      private const filterPressedBmp:Vector.<Bitmap> = new Vector.<Bitmap>(ShopItem.PAY_FILTER_8,true);
      
      private const filterOverBmp:Vector.<Bitmap> = new Vector.<Bitmap>(ShopItem.PAY_FILTER_8,true);
      
      private var array91:Array = new Array(ShopItem.PAY_FILTER_8);
      
      private var infoMenu:NUIComponent = null;
      
      private var infoMenuItems:Array = new Array();
      
      private var accauntCostTF:Array = new Array(4);
      
      private var accauntButtons:Array = new Array(4);
      
      private var accauntCost:Array = new Array(new Array(0,0,0,0,0),new Array(5),new Array(5),new Array(5));
      
      private var accauntServiceId:Array = new Array(null,new Array(5),new Array(5),new Array(5));
      
      private var lastSelectedBtn:BaseButton = null;
      
      private var selectedAccaunt:int = -1;
      
      private var selectedService:int = -1;
      
      private var selectedDays:int = 0;
      
      private var dayButtons:Array = new Array(5);
      
      private var costTF:TextField;
      
      private var itemPresentDesc:TextField;
      
      private var complSelectedAccaunt:int;
      
      private var complSelectedDays:int;
      
      private var shopItems:ShopItemsGrid;
      
      private var basketList:ShopItemsGrid;
      
      private var filter:int = 0;
      
      private var nuiComponent5:NUIComponent;
      
      private var topItem:ShopItem = null;
      
      private var money:int;
      
      private var gameMoney:int = 0;
      
      private var freeStats:int;
      
      private var accauntType:int;
      
      private var accauntTime:int;
      
      private var accauntServices:Array = new Array(new Array(),new Array(),new Array(),TS_BAG_SIZE_1,TS_BAG_SIZE_2,TS_PLACE_RESPAWN,TS_DROP_AUTOCOLLECTION,TS_FREE_ZONE_CROSSING,TS_EXP_BONUS_4,TS_SMALL_RESPAWN_TIME_2,TS_BAG_SIZE_2,TS_SMALL_RESPAWN_TIME_3,TS_FAST_HP_REGENERATION_2,TS_SMALL_TRAUM_TIME_2,TS_LONG_RUN_3,TS_EXP_BONUS_3,TS_SKILL_BONUS_3,TS_PLACE_RESPAWN,TS_DROP_AUTOCOLLECTION,TS_ITEM_LOTTERY,TS_LIMIT_SKILL_0,TS_LIMIT_SKILL_1,TS_LIMIT_SKILL_2,TS_LIMIT_SKILL_3,TS_LIMIT_SKILL_4,TS_LIMIT_SKILL_5,TS_LIMIT_SKILL_6,TS_LIMIT_SKILL_7,TS_LIMIT_SKILL_8,TS_FRIEND_PET_1,TS_FRIEND_PET_2,TS_FRIEND_KSENOMORF,TS_HIRE_LICENSE,TS_GAME_BIG_BAG,TS_REFERAL_EXP_BONUS,TS_FRIEND_PET_3,TS_FRIEND_PET_4,TS_FRIEND_PET_5,TS_LONG_NOPVP_RUN_1,TS_INVISIBLE,TS_FRIEND_PET_6,TS_FRIEND_PET_7,TS_FRIEND_PET_8,TS_FRIEND_PET_9);
      
      private var services:Array = new Array();
      
      private var ownServices:Array = new Array();
      
      private var ownTime:Array = new Array();
      
      private var servicesChecked:Array = new Array();
      
      private var servicesCheck:Array = new Array();
      
      private var servicesButtons:Array = new Array();
      
      private var servicesTime:Array = new Array();
      
      private var servicesServIdx:Array = new Array();
      
      private var servicesCost:Array = new Array();
      
      private var curPetServiceId:int;
      
      private var petServiceId:int;
      
      private var petName:String;
      
      private var petAgression:int;
      
      private var petDistance:int;
      
      private var activeService:int;
      
      private var petTrain:Boolean;
      
      private var petNameCost:int;
      
      private var petTrainCost:int;
      
      private var petAgressionCheck:NCheckBox;
      
      private var petDistanceCheck:NCheckBox;
      
      private var petNameInput:NTextInput;
      
      private var shopItemsAr:Array = new Array();
      
      private var statCostText:TextField;
      
      private var stats:Array = new Array(Character.STAT_COUNT);
      
      private var curStats:Array = new Array(Character.STAT_COUNT);
      
      private var skills:Array = new Array(Character.SKILL_COUNT);
      
      private var curSkills:Array = new Array(Character.SKILL_COUNT);
      
      private var statButtons:Array = new Array(Character.STAT_COUNT);
      
      private var perkButtons:Array = null;
      
      private var statText:Array = new Array(Character.STAT_COUNT);
      
      private var skillText:Array = new Array(Character.SKILL_COUNT);
      
      private var skillButtons:Array = new Array(Character.SKILL_COUNT);
      
      private var peaceSkillSum:int;
      
      private var battleSkillSum:int;
      
      private var freePeaceTF:TextField;
      
      private var freeBattleTF:TextField;
      
      private var freeStatsTF:TextField;
      
      private var statsTime:int;
      
      private var skillsTime:int;
      
      private var prioritySkill:int;
      
      private var curPrioritySkill:int;
      
      private var limiters:int;
      
      private var curLimiters:int;
      
      private var flag139:Boolean;
      
      private var perks:int;
      
      private var curPerks:int;
      
      private var deleteServiceId:int = -1;
      
      public var itemInfoMenu:ItemInfo;
      
      public var hairs:Array;
      
      public var avatars:Array;
      
      public var hairPals:Array;
      
      private var hairBg:Bitmap;
      
      private var hairBgHl:Bitmap;
      
      private var hairButtons:Array;
      
      private var curHairId:int = -1;
      
      private var curPalId:int = -1;
      
      private var playerView:PlayerPreview = null;
      
      private var playerRotDir:int;
      
      private var hairLoaders:Array;
      
      private var moneyBmp:Bitmap;
      
      private var gameMoneyBmp:Bitmap;
      
      private var razdBmp:Bitmap;
      
      private var changeHairColorCost:int;
      
      private var avatarPal:int = -1;
      
      private var array96:Array = [];
      
      private var presents:Object = [];
      
      private var presentsScroll:ScrollSprite;
      
      private var presentSelector:Bitmap;
      
      private var currentPresent:int = -1;
      
      private var anonymCheck:NCheckBox;
      
      private var anonimText:TextField;
      
      private var sigText:TextField;
      
      private var signatureInput:NTextInput;
      
      private var loginInput:NTextInput;
      
      private var cantDeleteText:TextField;
      
      private var curWeek:int = 0;
      
      private var weekButtons:Array;
      
      private var weekDescText:TextField;
      
      private var gameMoneyTF:TextField;
      
      private var moneyTF:TextField;
      
      private var presentLogin:String;
      
      private var avatarSelector:Bitmap;
      
      private var currentAvatar:int = -1;
      
      public var payBlocked:Boolean = true;
      
      public var presentsLoaded:Boolean = false;
      
      public var shopItemsLoaded:Boolean = false;
      
      private var hairLoader:GameBitmap;
      
      private var dragger:ShopItemDragger = new ShopItemDragger();
      
      private var nuiComponent15:NUIComponent = null;
      
      private var filterButtonList1:Vector.<FilterButton> = null;
      
      public function PaidServicesMenu(param1:Main, param2:Array, param3:String)
      {
         Main.closeMenus(BaseMenu.TYPE_CUSTOMIZATION);
         super();
         this.main = param1;
         this.presentLogin = param3;
         this.ramDL = new NUIComponent.LINE();
         bitmaps(this.ramDL.bitmapData);
         this.ramDR = new NUIComponent.RAM_DL();
         bitmaps(this.ramDR.bitmapData);
         this.ramSide = new NUIComponent.RAM_DR();
         bitmaps(this.ramSide.bitmapData);
         this.ramTop = new NUIComponent.RAM_SIDE();
         bitmaps(this.ramTop.bitmapData);
         this.ramUL = new NUIComponent.RAM_TOP();
         bitmaps(this.ramUL.bitmapData);
         this.ramUR = new NUIComponent.RAM_UL();
         bitmaps(this.ramUR.bitmapData);
         this.ramBottom = new NUIComponent.RAM_UR();
         bitmaps(this.ramBottom.bitmapData);
         this.ACCAUNT_BMP_CLASS = new Array(uiContainer["STAR_ACC"],uiContainer["BUS_ACC"],uiContainer["PREM_ACC"],uiContainer["VIP_ACC"]);
         this.notPressedBmp = new Array(getBmp("CONTROL_TAB"),getBmp("ACC_TAB"),getBmp("SERVICE_TAB"),getBmp("SHOP_TAB"));
         this.pressedBmp = new Array(getBmp("CONTROL_TAB_PRESSED"),getBmp("ACC_TAB_PRESSED"),getBmp("SERVICE_TAB_PRESSED"),getBmp("SHOP_TAB_PRESSED"));
         this.overBmp = new Array(getBmp("CONTROL_TAB_OVER"),getBmp("ACC_TAB_OVER"),getBmp("SERVICE_TAB_OVER"),getBmp("SHOP_TAB_OVER"));
         var index:int = 0;
         while(index < ShopItem.PAY_FILTER_8)
         {
            this.filterNotPressedBmp[index] = getBmp("PAY_FILTER_" + index);
            this.filterPressedBmp[index] = getBmp("PAY_FILTER_" + index + "_PRESSED");
            this.filterOverBmp[index] = getBmp("PAY_FILTER_" + index + "_OVER");
            index++;
         }
         this.glowRamDL = getBmp("RAM_GLOW_DL");
         this.glowRamDR = getBmp("RAM_GLOW_DR");
         this.glowRamSide = getBmp("RAM_GLOW_SIDE");
         this.glowRamTop = getBmp("RAM_GLOW_TOP");
         this.glowRamUL = getBmp("RAM_GLOW_UL");
         this.glowRamUR = getBmp("RAM_GLOW_UR");
         this.glowRamBottom = getBmp("RAM_GLOW_BOTTOM");
         this.parseData(param2);
         graphics.beginFill(1776411,1);
         graphics.drawRect(4,4,MENU_WIDTH - 8,MENU_HEIGHT - 8);
         graphics.endFill();
         drawFrame(0,0,MENU_WIDTH,MENU_HEIGHT);
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13408825;
         titleFormat.size = 12;
         titleFormat.bold = true;
         addChild(createTextField(266,11,200,titleFormat,getString("IDS_PAID_SERVICES")));
         var tabX:int = 17;
         if(param3 != "")
         {
            this.selectedTab = TAB_GIFTS;
         }
         index = 0;
         while(index < TAB_COUNT)
         {
            if(index == this.upTab)
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
         this.submenu = new NUIComponent();
         this.submenu.x = 0;
         this.submenu.width = 0;
         this.submenu.height = 0;
         this.submenu.visible = true;
         addUIChild(this.submenu);
         this.tabmenu = new NUIComponent();
         this.tabmenu.x = 0;
         this.tabmenu.width = 0;
         this.tabmenu.height = 0;
         this.tabmenu.visible = true;
         addUIChild(this.tabmenu);
         this.itemInfoMenu = new ItemInfo(this.submenu);
         addUIChild(this.itemInfoMenu);
         this.nuiComponent5 = new NUIComponent();
         addUIChild(this.nuiComponent5);
         this.startMenu();
         this.hairLoader = new GameBitmap();
         this.hairLoader.doAction945(param1.userCharacter);
         this.hairLoader.doAction698();
         this.dragger.dropHandler = this.onShopItemDrop;
         addUIChild(this.dragger);
      }
      
      public static function getTimeStr(param1:int) : String
      {
         var clockOffset:Number = ChatPanel.instance.propValue103 - new Date().getTime();
         var displayDate:Date = new Date(param1 * 1000 + clockOffset);
         return displayDate.hours + ":" + (displayDate.minutes < 10 ? "0" + displayDate.minutes : displayDate.minutes);
      }
      
      public static function getDateStr(param1:int) : String
      {
         var clockOffset:Number = ChatPanel.instance.propValue103 - new Date().getTime();
         var displayDate:Date = new Date(param1 * 1000 + clockOffset);
         var dateText:String;
         if(displayDate.dateUTC < 10)
         {
            dateText = "0" + displayDate.dateUTC + ".";
         }
         else
         {
            dateText = displayDate.dateUTC + ".";
         }
         if(displayDate.monthUTC < 9)
         {
            dateText += "0" + (displayDate.monthUTC + 1) + ".";
         }
         else
         {
            dateText += displayDate.monthUTC + 1 + ".";
         }
         return dateText + displayDate.fullYearUTC;
      }
      
      protected function onShopItemDrop(param1:ShopItemDragger) : void
      {
         var droppedItem:ShopItem = null;
         if(!param1.isActive)
         {
            droppedItem = param1.dropItem();
            if(this.basketList.isMouseOver)
            {
               this.basketList.doAction715([droppedItem]);
            }
            else
            {
               this.shopItems.doAction715([droppedItem]);
            }
            this.doAction335();
         }
      }
      
      private function setActiveService(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            activeService |= 1 << param1;
         }
         else
         {
            activeService &= -1 ^ 1 << param1;
         }
      }
      
      private function getActiveService(param1:int) : Boolean
      {
         return (this.activeService >> param1 & 1) == 1;
      }
      
      public function updateData(param1:Array) : void
      {
         this.parseData(param1);
         this.clearAllChilds();
         this.startMenu();
      }
      
      public function getShopItems(param1:Array) : void
      {
         this.parseShopItems(param1);
         this.clearAllChilds();
         this.startMenu();
      }
      
      private function parseShopItems(param1:Array) : void
      {
         shopItemsAr = new Array();
         var fieldIndex:int = 1;
         var remainingItems:int = param1[fieldIndex];
         var shopItem:ShopItem;
         fieldIndex++;
         while(remainingItems > 0)
         {
            shopItem = new ShopItem();
            fieldIndex += shopItem.create(param1.slice(fieldIndex));
            this.shopItemsAr.push(shopItem);
            remainingItems--;
         }
         shopItemsLoaded = true;
      }
      
      protected function doAction366(param1:NButton) : void
      {
         this.itemInfoMenu.targetItem = param1.value as InventoryItem;
         this.itemInfoMenu.create();
      }
      
      public function getPresents(param1:Array) : void
      {
         this.doAction444(param1);
         this.clearAllChilds();
         this.startMenu();
      }
      
      private function doAction444(param1:Array) : void
      {
         this.disposePresents();
         array96 = [];
         presents = {};
         var unusedNumber:Number = 1.5;
         var fieldIndex:int = 1;
         var referenceDate:int = param1[fieldIndex++];
         var groupTitle:String = param1[fieldIndex++];
         var groupDate:int = param1[fieldIndex++];
         var presentCount:int = param1[fieldIndex++];
         var presentGroup:Object;
         var presentIndex:int;
         var present:Object;
         while(groupTitle)
         {
            presentGroup = {
               "title":groupTitle,
               "date":groupDate,
               "presents":[]
            };
            presentIndex = 0;
            for(; presentIndex < presentCount; presentIndex++)
            {
               present = {
                  "id":param1[fieldIndex++],
                  "name":param1[fieldIndex++],
                  "image":param1[fieldIndex++],
                  "type":param1[fieldIndex++],
                  "currency":param1[fieldIndex++],
                  "cost":param1.slice(fieldIndex,fieldIndex + 4),
                  "date":groupDate
               };
               fieldIndex += 4;
               if(groupDate > 0 && groupDate < referenceDate)
               {
                  if(present.currency == "0")
                  {
                     continue;
                  }
                  else if(present.type == PresentItem.PT_ITEM_PRESENT)
                  {
                     present.cost[0] *= 1.5;
                  }
               }
               this.presents[present.id] = present;
               presentGroup.presents.push(present);
            }
            if(presentGroup.presents.length > 0)
            {
               this.array96.push(presentGroup);
            }
            groupTitle = param1[fieldIndex++];
            groupDate = param1[fieldIndex++];
            presentCount = param1[fieldIndex++];
         }
         presentsLoaded = true;
      }
      
      private function parseData(param1:Array) : void
      {
         var index:int;
         var avatarRequest:URLRequest;
         var avatarLoader:Loader;
         payBlocked = false;
         this.disposeAvatars();
         avatarPal = -1;
         hairs = new Array();
         avatars = new Array();
         hairPals = new Array();
         limiters = 0;
         curLimiters = 0;
         this.accauntServices[0] = new Array();
         this.accauntServices[1] = new Array();
         this.accauntServices[2] = new Array();
         services = new Array();
         ownServices = new Array();
         ownTime = new Array();
         servicesChecked = new Array();
         servicesCheck = new Array();
         servicesButtons = new Array();
         servicesTime = new Array();
         servicesServIdx = new Array();
         servicesCost = new Array();
         gameMoney = param1[1];
         money = param1[2];
         statsTime = param1[3];
         skillsTime = param1[4];
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            this.stats[index] = int(param1[5 + index]);
            this.curStats[index] = int(param1[5 + index]);
            index++;
         }
         perks = param1[11];
         curPerks = 0;
         prioritySkill = param1[12];
         curPrioritySkill = this.prioritySkill;
         battleSkillSum = param1[13];
         peaceSkillSum = param1[14];
         index = 0;
         while(index < Character.CUR_SKILL_COUNT)
         {
            this.skills[index] = int(param1[15 + index]);
            this.curSkills[index] = int(param1[15 + index]);
            index++;
         }
         accauntType = ACCAUNT_START;
         freeStats = param1[23];
         curPetServiceId = param1[24];
         petServiceId = param1[25];
         petDistance = param1[26];
         petAgression = param1[27];
         activeService = int(param1[28]);
         petTrain = int(param1[29]) == 1;
         petName = param1[30];
         petNameCost = param1[31];
         petTrainCost = param1[32];
         var currentAvatarId:int = param1[33];
         var avatarGoldCost:int = param1[34];
         if(currentAvatarId != 0)
         {
            avatarRequest = new URLRequest("icons/avatar/av" + currentAvatarId + ".jpg");
            avatarLoader = new Loader();
            avatarLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
            avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.avatarCompleteHandler);
            avatarLoader.load(avatarRequest);
            this.avatars.push({
               "avatarImg":currentAvatarId,
               "cost":0,
               "goldCost":avatarGoldCost,
               "ldr":avatarLoader
            });
         }
         avatarPal = param1[35];
         var avatarId:int;
         var remainingEntries:int = param1[36];
         var hairPalette:Array;
         var subIndex:int;
         var serviceType:int;
         var serviceTime:int;
         var unusedObject:Object;
         var serviceId:int;
         var serviceCost:int;
         index = 37;
         while(remainingEntries > 0)
         {
            if(this.main.userCharacter.sex == Character.SEX_MALE)
            {
               avatarId = 1000 + int(param1[index]);
            }
            else
            {
               avatarId = 2000 + int(param1[index]);
            }
            avatarRequest = new URLRequest("icons/avatar/av" + avatarId + ".jpg");
            avatarLoader = new Loader();
            avatarLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
            avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.avatarCompleteHandler);
            avatarLoader.load(avatarRequest);
            this.avatars.push({
               "avatarImg":avatarId,
               "cost":int(param1[index + 1]),
               "goldCost":int(param1[index + 2]),
               "ldr":avatarLoader
            });
            index += 3;
            remainingEntries--;
         }
         changeHairColorCost = param1[index];
         remainingEntries = param1[index + 1];
         index += 2;
         while(remainingEntries > 0)
         {
            this.hairs.push({
               "viewId":int(param1[index]),
               "cost":int(param1[index + 1]),
               "goldCost":int(param1[index + 2])
            });
            hairPalette = new Array();
            subIndex = 0;
            while(subIndex < HAIR_PAL_COUNT)
            {
               hairPalette.push(int(param1[index + 3 + subIndex]));
               subIndex++;
            }
            this.hairPals.push(hairPalette);
            index += 3 + HAIR_PAL_COUNT;
            remainingEntries--;
         }
         remainingEntries = param1[index];
         index++;
         subIndex = 0;
         while(remainingEntries > 0)
         {
            serviceType = param1[index];
            serviceTime = param1[index + 1];
            if(serviceType <= SV_ACCAUNT_VIP && serviceType >= this.accauntType)
            {
               accauntType = ACCAUNT_BUISNES + serviceType;
               accauntTime = serviceTime;
            }
            else if(serviceType >= SV_LIMIT_SKILL_0 && serviceType <= SV_LIMIT_SKILL_8)
            {
               this.enableLimiters(serviceType - SV_LIMIT_SKILL_0);
               this.enableCurLimiters(serviceType - SV_LIMIT_SKILL_0);
            }
            this.ownServices.push(serviceType);
            this.ownTime.push(serviceTime);
            remainingEntries--;
            index += 2;
         }
         subIndex = 0;
         while(subIndex < 3)
         {
            remainingEntries = param1[index];
            index++;
            while(remainingEntries > 0)
            {
               this.accauntServices[subIndex].push(int(param1[index]));
               index++;
               remainingEntries--;
            }
            subIndex++;
         }
         remainingEntries = param1[index];
         index++;
         for(; remainingEntries > 0; this.servicesServIdx.push(serviceId),this.services.push(serviceType),this.servicesChecked.push(false),this.servicesTime.push(serviceTime),this.servicesCost.push(serviceCost),index += 4,remainingEntries--)
         {
            serviceId = param1[index];
            serviceType = param1[index + 1];
            serviceTime = param1[index + 2];
            serviceCost = param1[index + 3];
            if(serviceType <= SV_ACCAUNT_VIP)
            {
               switch(serviceTime)
               {
                  case 1:
                     this.accauntCost[serviceType + 1][0] = serviceCost;
                     this.accauntServiceId[serviceType + 1][0] = serviceId;
                     break;
                  case 7:
                     this.accauntCost[serviceType + 1][1] = serviceCost;
                     this.accauntServiceId[serviceType + 1][1] = serviceId;
                     break;
                  case 30:
                     this.accauntCost[serviceType + 1][2] = serviceCost;
                     this.accauntServiceId[serviceType + 1][2] = serviceId;
                     break;
                  case 90:
                     this.accauntCost[serviceType + 1][3] = serviceCost;
                     this.accauntServiceId[serviceType + 1][3] = serviceId;
                     break;
                  case 180:
                     this.accauntCost[serviceType + 1][4] = serviceCost;
                     this.accauntServiceId[serviceType + 1][4] = serviceId;
                     break;
               }
            }
         }
         flag139 = param1[index] === "1";
      }
      
      private function get upTab() : int
      {
         if(this.selectedTab <= TAB_SHOP)
         {
            return this.selectedTab;
         }
         return TAB_SHOP;
      }
      
      public function barPress(param1:Object) : void
      {
         this.tabButtons[this.upTab].upState = this.notPressedBmp[this.tabButtons[this.upTab].value];
         param1.upState = this.overBmp[param1.value];
         selectedTab = param1.value;
         this.clearAllChilds();
         this.startMenu();
      }
      
      public function createPaidServicesMenu(param1:Boolean = true, param2:uint = 1776411, param3:Number = 1) : void
      {
         create(MENU_WIDTH,MENU_HEIGHT,param1,param2,param3);
         addDefaultCloseButton(618,12);
      }
      
      private function disposePresents() : void
      {
      }
      
      private function disposeAvatars() : void
      {
         var index:int = 0;
         if(this.avatars)
         {
            index = 0;
            while(index < this.avatars.length)
            {
               if(this.avatars[index].content)
               {
                  this.avatars[index].content.bitmapData.dispose();
               }
               this.avatars[index].ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
               this.avatars[index].ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.avatarCompleteHandler);
               index++;
            }
         }
      }
      
      override public function dispose() : void
      {
         this.disposePresents();
         this.disposeAvatars();
         this.itemInfoMenu.dispose();
         this.clearAllChilds();
         this.submenu.dispose();
         this.hairLoader.dispose();
         if(this.playerView)
         {
            this.playerView.dispose();
            playerView = null;
         }
         super.dispose();
      }
      
      private function clearTabmenu() : void
      {
         this.tabmenu.disposeAllChilds();
         this.tabmenu.graphics.clear();
      }
      
      private function clearAllChilds() : void
      {
         this.clearTabmenu();
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         this.submenu.disposeAllChilds();
         this.submenu.graphics.clear();
         hairLoaders = null;
      }
      
      private function addCheckBox(param1:int, param2:int, param3:Function, param4:int = 0) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3,this.submenu);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         this.submenuItems.push(checkBox);
         this.submenu.addUIChild(checkBox);
         return checkBox;
      }
      
      public function addNBut(param1:int, param2:int, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Function = null, param7:int = 0) : BaseButton
      {
         var button:BaseButton = new NButton(param6,param3,param4,param5,param3);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         this.submenuItems.push(button);
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
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         return button;
      }
      
      public function createDisplayBut(param1:int, param2:int, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject, param6:Function = null, param7:int = 0, param8:Object = null, param9:int = 0) : BaseButton
      {
         var button:BaseButton = new NButton(param6,param3,param4,param5,null);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param7;
         if(param9 == SUBMENU)
         {
            this.submenuItems.push(button);
         }
         else
         {
            this.tabmenuItems.push(button);
         }
         return button;
      }
      
      public function startMenu() : void
      {
         switch(this.selectedTab)
         {
            case TAB_CONTROL:
               this.createControlMenu();
               break;
            case TAB_ACCAUNT:
               this.createAccauntMenu();
               break;
            case TAB_SERVICES:
               this.createServicesMenu();
               break;
            case TAB_SHOP:
               this.createShopMenu();
               break;
            case TAB_STATS:
               this.createStatsMenu();
               break;
            case TAB_HAIR:
               this.createHairMenu();
               break;
            case TAB_GIFTS:
               this.createPresentMenu();
               break;
            case TAB_AVATARS:
               this.createAvatarMenu();
               break;
         }
      }
      
      private function drawInk(param1:Object, param2:int, param3:int, param4:int, param5:int) : void
      {
         param1.draw(this.ramUL,param2 + 1,param3 + 1);
         param1.drawTile(this.ramTop,param2 + this.ramUL.width + 1,param3,param4 - this.ramUL.width - this.ramUR.width - 2,this.ramTop.height);
         param1.draw(this.ramUR,param2 + param4 - this.ramUR.width - 1,param3 + 1);
         var sideHeight:int = Math.max(0,Math.min(this.ramSide.height,param5 - this.ramUL.height - this.ramDL.height - 2));
         if(sideHeight > 0)
         {
            param1.drawTile(this.ramSide,param2,param3 + this.ramUL.height + 1,this.ramSide.width,sideHeight);
            param1.drawTile(this.ramSide,param2 + param4 - this.ramSide.width,param3 + this.ramUR.height + 1,this.ramSide.width,sideHeight);
         }
         if(param5 - this.ramUL.height - this.ramDL.height - 2 - sideHeight > 0)
         {
            param1.drawVLine(param2,param3 + this.ramUL.height + 1 + sideHeight,param5 - this.ramUL.height - this.ramDL.height - 2 - sideHeight,12748580);
            param1.drawVLine(param2 + param4 - this.ramSide.width,param3 + this.ramUR.height + 1 + sideHeight,param5 - this.ramUR.height - this.ramDR.height - 2 - sideHeight,12748580);
         }
         param1.draw(this.ramDL,param2 + 1,param3 + param5 - this.ramDL.height - 1);
         param1.drawTile(this.ramBottom,param2 + this.ramDL.width + 1,param3 + param5 - this.ramBottom.height,param4 - this.ramDL.width - this.ramDR.width - 2,this.ramBottom.height);
         param1.draw(this.ramDR,param2 + param4 - this.ramDR.width - 1,param3 + param5 - this.ramDR.height - 1);
      }
      
      private function drawInkNoGrad(param1:Object, param2:int, param3:int, param4:int, param5:int) : void
      {
         param1.draw(this.ramUL,param2 + 1,param3 + 1);
         param1.drawTile(this.ramTop,param2 + this.ramUL.width + 1,param3,param4 - this.ramUL.width - this.ramUR.width - 2,this.ramTop.height);
         param1.draw(this.ramUR,param2 + param4 - this.ramUR.width - 1,param3 + 1);
         param1.drawVLine(param2,param3 + this.ramUL.height + 1,param5 - this.ramUL.height - this.ramDL.height - 2,12748580);
         param1.drawVLine(param2 + param4 - this.ramSide.width,param3 + this.ramUR.height + 1,param5 - this.ramUR.height - this.ramDR.height - 2,12748580);
         param1.draw(this.ramDL,param2 + 1,param3 + param5 - this.ramDL.height - 1);
         param1.drawTile(this.ramBottom,param2 + this.ramDL.width + 1,param3 + param5 - this.ramBottom.height,param4 - this.ramDL.width - this.ramDR.width - 2,this.ramBottom.height);
         param1.draw(this.ramDR,param2 + param4 - this.ramDR.width - 1,param3 + param5 - this.ramDR.height - 1);
      }
      
      private function handleActiveService(param1:Object) : void
      {
         this.setActiveService(param1.object.switchServId,true);
         this.main.socket.setServiceActive(param1.object.switchServId,true);
         this.createInfoMenu(param1.object.header,param1.object.description,param1.object.useSmallMenu,param1.object.deleteId,param1.object.useWarning,param1.object.switchServId);
      }
      
      private function handleDeactiveService(param1:Object) : void
      {
         this.setActiveService(param1.object.switchServId,false);
         this.main.socket.setServiceActive(param1.object.switchServId,false);
         this.createInfoMenu(param1.object.header,param1.object.description,param1.object.useSmallMenu,param1.object.deleteId,param1.object.useWarning,param1.object.switchServId);
      }
      
      private function handleActivatePet(param1:Object) : void
      {
         this.setActiveService(SS_PET,true);
         this.main.socket.setServiceActive(SS_PET,true);
         this.createPetMenu(param1.value1);
         this.main.showNotifyMenu(getString("IDS_PET_ACTIVE_WARN"));
      }
      
      private function handleDeactivatePet(param1:Object) : void
      {
         this.setActiveService(SS_PET,false);
         this.main.socket.setServiceActive(SS_PET,false);
         this.createPetMenu(param1.value1);
      }
      
      private function handleSetPetName(param1:Object) : void
      {
         if(this.petNameCost > this.money)
         {
            this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         if(this.petNameInput.text == "")
         {
            this.main.showNotifyMenu(getString("IDS_PET_NAME_WARN"));
            return;
         }
         if(this.petName != this.petNameInput.text)
         {
            petName = this.petNameInput.text;
            this.main.socket.sendPetSettings(this.petNameInput.text,this.petAgression,this.petTrain,this.petDistance);
            this.main.showNotifyMenu(getString("IDS_NAME_CHANGED"));
         }
      }
      
      private function handlePetDistance(param1:Object) : void
      {
         if(this.petDistanceCheck)
         {
            this.petDistanceCheck.checked = false;
         }
         petDistanceCheck = NCheckBox(param1);
         this.petDistanceCheck.checked = true;
         petDistance = param1.value;
         this.main.socket.sendPetSettings("",this.petAgression,this.petTrain,this.petDistance);
      }
      
      private function handlePetAgression(param1:Object) : void
      {
         if(this.petAgressionCheck)
         {
            this.petAgressionCheck.checked = false;
         }
         petAgressionCheck = NCheckBox(param1);
         this.petAgressionCheck.checked = true;
         petAgression = param1.value;
         this.main.socket.sendPetSettings("",this.petAgression,this.petTrain,this.petDistance);
      }
      
      private function handleSetPetTrain(param1:Object) : void
      {
         if(this.petTrainCost > this.money)
         {
            this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         petTrain = true;
         this.main.socket.sendPetSettings("",this.petAgression,this.petTrain,this.petDistance);
         this.createPetMenu(param1.value1);
      }
      
      public function createInfoButton(param1:int, param2:int, param3:int, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Function = null) : BaseButton
      {
         var button:BaseButton = new NButton(param7,param4,param5,param6,param4);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param3;
         this.infoMenuItems.push(button);
         return button;
      }
      
      private function createPetMenu(param1:int) : void
      {
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13343541;
         titleFormat.size = 12;
         titleFormat.bold = true;
         titleFormat.align = TextFormatAlign.CENTER;
         var sectionFormat:TextFormat = new TextFormat();
         sectionFormat.font = "Verdana";
         sectionFormat.color = 13343541;
         sectionFormat.size = 10;
         sectionFormat.bold = true;
         sectionFormat.align = TextFormatAlign.CENTER;
         var boldFormat:TextFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13343541;
         boldFormat.size = 12;
         boldFormat.bold = true;
         var smallBoldFormat:TextFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13343541;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         var smallFormat:TextFormat = new TextFormat();
         smallFormat.font = "Verdana";
         smallFormat.color = 10187296;
         smallFormat.size = 10;
         var menuWidth:int = INFO_MENU_WIDTH;
         var menuHeight:int = INFO_MENU_HEIGHT;
         infoMenu = new NUIComponent();
         this.infoMenu.x = 23;
         this.infoMenu.y = 78;
         addUIChild(this.infoMenu);
         this.drawInk(this.infoMenu,0,0,menuWidth,menuHeight);
         var label:TextField;
         var scroll:ScrollSprite = new ScrollSprite(menuWidth - 16,menuHeight - 49,4);
         label = createTextField(10,10,menuWidth - 30,titleFormat,getString("IDS_PET_SETTINGS"));
         this.infoMenu.addChild(label);
         scroll.addLine(createTextField(0,0,menuWidth - 30,sectionFormat,getString("IDS_PET_ACTIVE"),18));
         scroll.addLine(createTextField(0,159,menuWidth - 30,sectionFormat,getString("IDS_PET_DISTANTION"),18));
         scroll.addLine(createTextField(0,219,menuWidth - 30,sectionFormat,getString("IDS_PET_AGRESSION"),18));
         if(this.getActiveService(SS_PET))
         {
            button = this.createInfoButton(1,19,0,getBmp("DEACTIVATE"),getBmp("DEACTIVATE_OVER"),getBmp("DEACTIVATE_PRESSED"),this.handleDeactivatePet);
            button.value1 = param1;
         }
         else
         {
            button = this.createInfoButton(1,19,0,getBmp("ACTIVATE"),getBmp("ACTIVATE_OVER"),getBmp("ACTIVATE_PRESSED"),this.handleActivatePet);
            button.value1 = param1;
         }
         scroll.addContent(button);
         scroll.addLine(createTextField(2,60,150,boldFormat,getString("IDS_PET_NAME"),18));
         scroll.addLine(createTextField(2,103,150,smallBoldFormat,getString("IDS_SERV_COST"),18));
         scroll.addLine(createTextField(2,343,150,smallBoldFormat,getString("IDS_SERV_COST"),18));
         scroll.addLine(createTextField(122,103,150,smallBoldFormat,this.petNameCost.toString() + getString("IDS_CREDS"),18));
         scroll.addLine(createTextField(122,343,150,smallBoldFormat,this.petTrainCost.toString() + getString("IDS_CREDS"),18));
         button = this.createInfoButton(1,124,0,getBmp("CNAME"),getBmp("CNAME_OVER"),getBmp("CNAME_PRESSED"),this.handleSetPetName);
         scroll.addContent(button);
         petNameInput = createTextInput(1,79,184);
         this.petNameInput.maxChars = 16;
         this.petNameInput.text = this.petName;
         this.petNameInput.restrict = PET_NAME_RESTRICT;
         scroll.addContent(this.petNameInput);
         optionIndex = 0;
         while(optionIndex < 2)
         {
            checkBox = new NCheckBox(this.handlePetDistance,scroll);
            checkBox.x = 1;
            checkBox.y = 179 + optionIndex * 18;
            checkBox.value = optionIndex;
            if(optionIndex == this.petDistance)
            {
               checkBox.checked = true;
               petDistanceCheck = checkBox;
            }
            this.infoMenuItems.push(checkBox);
            scroll.addContent(checkBox);
            scroll.addLine(createTextField(20,179 + optionIndex * 18 - 2,100,smallFormat,getString("IDS_DISTANTION_" + optionIndex),18));
            optionIndex++;
         }
         optionIndex = 0;
         while(optionIndex < 4)
         {
            checkBox = new NCheckBox(this.handlePetAgression,scroll);
            checkBox.x = 1;
            checkBox.y = 239 + optionIndex * 18;
            checkBox.value = optionIndex;
            if(optionIndex == this.petAgression)
            {
               checkBox.checked = true;
               petAgressionCheck = checkBox;
            }
            this.infoMenuItems.push(checkBox);
            scroll.addContent(checkBox);
            scroll.addLine(createTextField(20,239 + optionIndex * 18 - 2,100,smallFormat,getString("IDS_AGRESSION_" + optionIndex),18));
            optionIndex++;
         }
         if(this.petTrain)
         {
            scroll.addLine(createTextField(2,316,150,smallBoldFormat,getString("IDS_PET_TRAINED"),18));
         }
         else
         {
            button = this.createInfoButton(1,316,0,getBmp("TRAIN"),getBmp("TRAIN_OVER"),getBmp("TRAIN_PRESSED"),this.handleSetPetTrain);
            button.value1 = param1;
            scroll.addContent(button);
         }
         label = createTextField(0,370,menuWidth - 40,smallFormat,getString("IDS_AGRESSION_DESC") + "\n\n" + getString("IDS_ACTIVE_TO") + " " + getDateStr(param1) + " " + getTimeStr(param1));
         label.multiline = true;
         label.wordWrap = true;
         label.height = label.textHeight + 5;
         scroll.addLine(label);
         scroll.x = 7;
         scroll.y = 33;
         var button:BaseButton;
         var optionIndex:int;
         var checkBox:NCheckBox;
         var decoration:Bitmap = getBmp("MN_C_LINE");
         scroll.uiContainer.draw(decoration,11,52);
         scroll.uiContainer.draw(decoration,11,156);
         scroll.uiContainer.draw(decoration,11,216);
         scroll.uiContainer.draw(decoration,11,365);
         decoration = getBmp("V_GOLD");
         scroll.uiContainer.draw(decoration,110,105);
         scroll.uiContainer.draw(decoration,110,345);
         scroll.init(label.y + label.height);
         this.infoMenuItems.push(scroll);
         this.infoMenu.addUIChild(scroll);
      }
      
      private function createInfoMenu(param1:String, param2:String, param3:Boolean = false, param4:int = -1, param5:Boolean = false, param6:int = -1) : void
      {
         var menuOptions:Object = {
            "header":param1,
            "description":param2,
            "useSmallMenu":param3,
            "deleteId":param4,
            "useWarning":param5,
            "switchServId":param6
         };
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         infoMenu = new NUIComponent();
         if(param3)
         {
            menuWidth = INFO_SMALL_WIDTH;
            menuHeight = INFO_SMALL_HEIGHT;
            this.infoMenu.x = 19;
            this.infoMenu.y = 280;
         }
         else
         {
            menuWidth = INFO_MENU_WIDTH;
            menuHeight = INFO_MENU_HEIGHT;
            this.infoMenu.x = 23;
            this.infoMenu.y = 78;
         }
         addUIChild(this.infoMenu);
         this.drawInk(this.infoMenu,0,0,menuWidth,menuHeight);
         var menuWidth:int;
         var menuHeight:int;
         var closeBitmap:Bitmap = new CLOSE();
         var titleFormat:TextFormat = new TextFormat();
         titleFormat.font = "Verdana";
         titleFormat.color = 13343541;
         titleFormat.size = 12;
         titleFormat.bold = true;
         titleFormat.underline = false;
         titleFormat.align = TextFormatAlign.CENTER;
         var descriptionFormat:TextFormat = new TextFormat();
         var label:TextField;
         var scroll:ScrollSprite;
         var button:BaseButton;
         var warningBitmap:Bitmap;
         var deleteBitmap:Bitmap;
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187296;
         descriptionFormat.size = 10;
         titleFormat.underline = false;
         if(param1 == "")
         {
            scroll = new ScrollSprite(menuWidth - 16,menuHeight - 32,4);
         }
         else
         {
            scroll = new ScrollSprite(menuWidth - 16,menuHeight - 49,4);
            label = createTextField(10,10,menuWidth - 30,titleFormat,param1);
            this.infoMenu.addChild(label);
         }
         if(param5)
         {
            warningBitmap = getBmp("WARNING_SCROLL");
            scroll.addChild(warningBitmap);
            label = createTextField(72,0,menuWidth - 104,descriptionFormat);
         }
         else if(param6 != -1)
         {
            if(this.getActiveService(param6))
            {
               button = this.createInfoButton(1,0,0,getBmp("DEACTIVATE"),getBmp("DEACTIVATE_OVER"),getBmp("DEACTIVATE_PRESSED"),this.handleDeactiveService);
            }
            else
            {
               button = this.createInfoButton(1,0,0,getBmp("ACTIVATE"),getBmp("ACTIVATE_OVER"),getBmp("ACTIVATE_PRESSED"),this.handleActiveService);
            }
            button.object = menuOptions;
            scroll.addContent(button);
            label = createTextField(0,30,menuWidth - 32,descriptionFormat);
         }
         else
         {
            label = createTextField(0,0,menuWidth - 32,descriptionFormat);
         }
         label.wordWrap = true;
         label.text = param2;
         if(label.text.length == 0)
         {
            label.height = 0;
         }
         else
         {
            label.height = label.textHeight + 6;
         }
         scroll.addLine(label);
         if(param4 != -1)
         {
            deleteBitmap = getBmp("PS_DELETE");
            button = new NButton(this.deleteServiceHandler,deleteBitmap,getBmp("PS_DELETE_OVER"),getBmp("PS_DELETE_PRESSED"),deleteBitmap);
            button.x = 82;
            button.y = label.y + label.height + 20;
            button.value = SV_LIMIT_SKILL_0 + param4;
            scroll.addContent(button);
            this.infoMenuItems.push(button);
         }
         scroll.x = 7;
         if(param1 == "")
         {
            scroll.y = 16;
         }
         else
         {
            scroll.y = 33;
         }
         scroll.init();
         this.infoMenuItems.push(scroll);
         this.infoMenu.addUIChild(scroll);
      }
      
      private function deleteService(param1:Object) : void
      {
         this.main.socket.sendStr("ds|" + this.deleteServiceId);
      }
      
      private function deleteServiceHandler(param1:Object) : void
      {
         deleteServiceId = param1.value;
         this.main.showWarningMenu(getString("IDS_SERV_DELETE_WARN"),this.deleteService);
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
         if(this.playerView)
         {
            this.playerView.dispose();
            playerView = null;
         }
         infoMenu = null;
      }
      
      private function addBalanceSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : Sprite
      {
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         var amountFormat:TextFormat = new TextFormat();
         amountFormat.font = "Verdana";
         amountFormat.color = 13408825;
         amountFormat.size = 12;
         amountFormat.bold = true;
         amountFormat.align = TextFormatAlign.RIGHT;
         var balanceSprite:Sprite = new Sprite();
         updateBgUI(balanceSprite,false,param3,param4);
         balanceSprite.x = param1;
         balanceSprite.y = param2;
         this.submenu.addChild(balanceSprite);
         balanceSprite.addChild(createTextField(10,-2,200,labelFormat,getString("IDS_BALANCE"),20));
         if(param5)
         {
            moneyTF = createTextField(param3 - 105,-2,100,amountFormat,this.money.toString() + " " + getString("IDS_CREDS"),20);
            balanceSprite.addChild(this.moneyTF);
         }
         else
         {
            moneyTF = createTextField(param3 - 125,-2,100,amountFormat,this.money.toString() + " " + getString("IDS_CREDS"),20);
            balanceSprite.addChild(this.moneyTF);
         }
         return balanceSprite;
      }
      
      private function createControlMenu() : void
      {
         this.drawInk(this.submenu,OWN_SERVICES_X,OWN_SERVICES_Y,OWN_SERVICES_WIDTH,OWN_SERVICES_HEIGHT);
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var smallBoldFormat:TextFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13408825;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         var serviceFormat:TextFormat = new TextFormat();
         serviceFormat.font = "Verdana";
         serviceFormat.color = 10187041;
         serviceFormat.size = 12;
         serviceFormat.bold = true;
         var rightBoldFormat:TextFormat = new TextFormat();
         rightBoldFormat.font = "Verdana";
         rightBoldFormat.color = 13408825;
         rightBoldFormat.size = 10;
         rightBoldFormat.bold = true;
         rightBoldFormat.align = TextFormatAlign.RIGHT;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 10;
         rightFormat.align = TextFormatAlign.RIGHT;
         var rightMutedFormat:TextFormat = new TextFormat();
         rightMutedFormat.font = "Verdana";
         rightMutedFormat.color = 10187041;
         rightMutedFormat.size = 10;
         rightMutedFormat.align = TextFormatAlign.RIGHT;
         var smallMutedFormat:TextFormat = new TextFormat();
         smallMutedFormat.font = "Verdana";
         smallMutedFormat.color = 10187041;
         smallMutedFormat.size = 10;
         var rightHeadingFormat:TextFormat = new TextFormat();
         rightHeadingFormat.font = "Verdana";
         rightHeadingFormat.color = 13408825;
         rightHeadingFormat.size = 12;
         rightHeadingFormat.bold = true;
         rightHeadingFormat.align = TextFormatAlign.RIGHT;
         this.submenu.addChild(createTextField(358,64,200,headingFormat,getString("IDS_BALANCE_CONTROL"),20));
         this.addBalanceSprite(279,86,365,16);
         this.submenu.addChild(createTextField(279,106,380,smallBoldFormat,getString("IDS_CREDS_DESC"),16));
         var label:TextField = createTextField(278,122,225,smallMutedFormat,getString("IDS_REPLENISH_DESC"),40);
         label.multiline = true;
         label.wordWrap = true;
         this.submenu.addChild(label);
         label = createTextField(256,387,280,smallMutedFormat,getString("IDS_PAY_STAR_DESC"),40);
         label.multiline = true;
         label.wordWrap = true;
         this.submenu.addChild(label);
         var button:NButton = createSimpleButton(544,123,getString("IDS_ADD_FUNDS"),this.payHandler);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         button = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         this.submenu.draw(bitmap16,278,153);
         this.submenu.draw(bitmap16,278,384);
         this.submenu.addChild(createTextField(383,155,200,headingFormat,getString("IDS_CURRENT_ACCAUNT"),20));
         this.submenu.addChild(createTextField(383,250,200,headingFormat,getString("IDS_ACTIVATED_SERVICES"),20));
         var accountBitmap:Bitmap = new this.ACCAUNT_BMP_CLASS[this.accauntType]();
         bitmaps(accountBitmap.bitmapData);
         this.submenu.draw(accountBitmap,286,173);
         this.submenu.addChild(createTextField(451,185,100,smallMutedFormat,getString("IDS_ACCAUNT_TYPE"),20));
         this.submenu.addChild(createTextField(451,200,100,smallMutedFormat,getString("IDS_PAID_TO"),20));
         this.submenu.addChild(createTextField(516,185,100,rightBoldFormat,getString("IDS_ACCAUNT_" + this.accauntType),20));
         this.submenu.addChild(createTextField(516,200,100,rightBoldFormat,this.accauntType == ACCAUNT_START ? getString("IDS_FOREVER") : getDateStr(this.accauntTime),20));
         if(this.accauntType != ACCAUNT_START)
         {
            this.submenu.addChild(createTextField(516,215,100,rightBoldFormat,getTimeStr(this.accauntTime),20));
         }
         var servicesScroll:ScrollSprite = new ScrollSprite(OWN_SERVICES_WIDTH - 12,OWN_SERVICES_HEIGHT - 12,4);
         servicesScroll.x = OWN_SERVICES_X + 6;
         servicesScroll.y = OWN_SERVICES_Y + 6;
         this.submenuItems.push(servicesScroll);
         this.submenu.addUIChild(servicesScroll);
         var rowIndex:int = 0;
         var rowBackground:Sprite;
         var serviceButton:BaseButton;
         var dateStart:int;
         var ownedIndex:int = 0;
         var serviceTime:int;
         var serviceType:int;
         var serviceId:int;
         var accountServiceIndex:int;
         while(ownedIndex < this.ownServices.length)
         {
            serviceTime = this.ownTime[ownedIndex];
            serviceType = this.ownServices[ownedIndex];
            if(serviceType <= SV_ACCAUNT_VIP)
            {
               accountServiceIndex = 0;
               while(accountServiceIndex < this.accauntServices[serviceType].length)
               {
                  serviceId = this.accauntServices[serviceType][accountServiceIndex];
                  rowBackground = new Sprite();
                  updateBgUI(rowBackground,false,OWN_SERVICES_WIDTH - 22,16);
                  serviceButton = this.createDisplayBut(0,rowIndex * 19,rowBackground,rowBackground,rowBackground,this.handleOwnServicePress,serviceId,servicesScroll);
                  serviceButton.value1 = serviceTime;
                  servicesScroll.addContent(serviceButton);
                  label = createTextField(5,rowIndex * 19 - 2,190,serviceFormat,getString("IDS_SERVICE_NAME_" + serviceId) + "*",18);
                  label.height = 18;
                  servicesScroll.addLine(label);
                  serviceButton.textField1 = label;
                  label = createTextField(166,rowIndex * 19 - 1,175,rightMutedFormat,getString("IDS_ACTIVE_TO"),18);
                  dateStart = label.text.length;
                  label.appendText("  " + getDateStr(serviceTime));
                  label.setTextFormat(rightFormat,dateStart,label.text.length);
                  label.height = 17;
                  servicesScroll.addLine(label);
                  rowIndex++;
                  accountServiceIndex++;
               }
            }
            else
            {
               serviceId = this.accauntServices[serviceType];
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,OWN_SERVICES_WIDTH - 22,16);
               serviceButton = this.createDisplayBut(0,rowIndex * 19,rowBackground,rowBackground,rowBackground,this.handleOwnServicePress,serviceId,servicesScroll);
               serviceButton.value1 = serviceTime;
               servicesScroll.addContent(serviceButton);
               label = createTextField(5,rowIndex * 19 - 2,190,serviceFormat,getString("IDS_SERVICE_NAME_" + serviceId),18);
               label.height = 18;
               servicesScroll.addLine(label);
               label = createTextField(166,rowIndex * 19 - 1,175,rightMutedFormat,getString("IDS_ACTIVE_TO"),18);
               dateStart = label.text.length;
               label.appendText("  " + getDateStr(serviceTime));
               label.setTextFormat(rightFormat,dateStart,label.text.length);
               label.height = 17;
               servicesScroll.addLine(label);
               rowIndex++;
            }
            ownedIndex++;
         }
         servicesScroll.init(rowIndex * 19);
         if(this.freeStats > 0)
         {
            this.createInfoMenu(getString("IDS_PS_INFORMATION"),getString("IDS_PS_FREE_STAT_0"));
         }
         else
         {
            this.createInfoMenu("","");
         }
      }
      
      private function handleOwnServicePress(param1:Object) : void
      {
         if(this.lastSelectedBtn != null)
         {
            updateBgUI(Sprite(this.lastSelectedBtn.upState),false,this.lastSelectedBtn.upState.width,this.lastSelectedBtn.upState.height,this.lastSelectedBtn.textField1);
         }
         lastSelectedBtn = BaseButton(param1);
         updateBgUI(Sprite(this.lastSelectedBtn.upState),true,this.lastSelectedBtn.upState.width,this.lastSelectedBtn.upState.height,this.lastSelectedBtn.textField1);
         if(SERVICE_GROUP[param1.value] == PET_GROUP)
         {
            if(param1.value == this.curPetServiceId)
            {
               this.createPetMenu(param1.value1);
            }
            else
            {
               this.createInfoMenu(getString("IDS_INFORMATION"),getString("IDS_PET_OTHER_SERVICE"),false,-1);
            }
         }
         else
         {
            switch(param1.value)
            {
               case TS_DROP_AUTOCOLLECTION:
                  this.createInfoMenu(getString("IDS_INFORMATION"),getString("IDS_SERVICE_DESC_" + param1.value) + "\n\n" + getString("IDS_ACTIVE_TO") + " " + getDateStr(param1.value1) + " " + getTimeStr(param1.value1),false,param1.value < TS_LIMIT_SKILL_0 || param1.value > TS_LIMIT_SKILL_8 ? -1 : param1.value - TS_LIMIT_SKILL_0,false,SS_AUTOLOOT);
                  break;
               default:
                  this.createInfoMenu(getString("IDS_INFORMATION"),getString("IDS_SERVICE_DESC_" + param1.value) + "\n\n" + getString("IDS_ACTIVE_TO") + " " + getDateStr(param1.value1) + " " + getTimeStr(param1.value1),false,param1.value < TS_LIMIT_SKILL_0 || param1.value > TS_LIMIT_SKILL_8 ? -1 : param1.value - TS_LIMIT_SKILL_0);
                  break;
            }
         }
      }
      
      private function payHandler(param1:Object) : void
      {
         this.main.dataBanText();
      }
      
      private function drawAccauntInk(param1:NSprite, param2:Boolean) : void
      {
         param1.graphics.clear();
         if(param2)
         {
            param1.draw(this.glowRamUL,-4,-4);
            param1.drawTile(this.glowRamTop,this.glowRamUL.width - 4,-4,ACCAUNT_WIDTH - this.glowRamUL.width - this.glowRamUR.width + 8,this.glowRamTop.height);
            param1.draw(this.glowRamUR,ACCAUNT_WIDTH - this.glowRamUR.width + 4,-4);
            param1.drawTile(this.glowRamSide,-4,this.glowRamUL.height - 4,this.glowRamSide.width,ACCAUNT_HEIGHT - this.glowRamUL.height - this.glowRamDL.height + 8);
            param1.drawTile(this.glowRamSide,ACCAUNT_WIDTH - this.glowRamSide.width + 7,this.glowRamUR.height - 4,this.glowRamSide.width,ACCAUNT_HEIGHT - this.glowRamUR.height - this.glowRamDR.height + 8);
            param1.draw(this.glowRamDL,-4,ACCAUNT_HEIGHT - this.glowRamDL.height + 4);
            param1.drawTile(this.glowRamBottom,this.glowRamDL.width - 4,ACCAUNT_HEIGHT - this.glowRamBottom.height + 4,ACCAUNT_WIDTH - this.glowRamDL.width - this.glowRamDR.width + 8,this.glowRamBottom.height);
            param1.draw(this.glowRamDR,ACCAUNT_WIDTH - this.glowRamDR.width + 4,ACCAUNT_HEIGHT - this.glowRamDR.height + 4);
         }
         else
         {
            this.drawInk(param1,0,0,ACCAUNT_WIDTH,ACCAUNT_HEIGHT);
         }
      }
      
      private function createAccaunt(param1:int, param2:int, param3:int) : BaseButton
      {
         var valueFormat:TextFormat = new TextFormat();
         valueFormat.font = "Verdana";
         valueFormat.color = 13408825;
         valueFormat.size = 10;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 10;
         var accountSprite:NSprite = new NSprite();
         this.drawAccauntInk(accountSprite,false);
         var accountBitmap:Bitmap = new this.ACCAUNT_BMP_CLASS[param3]();
         bitmaps(accountBitmap.bitmapData);
         accountBitmap.x = 10;
         accountBitmap.y = 10;
         accountSprite.addChild(accountBitmap);
         accountSprite.addChild(createTextField(92,8,80,labelFormat,getString("IDS_TYPE"),25));
         accountSprite.addChild(createTextField(92,20,80,valueFormat,getString("IDS_ACCAUNT_" + param3),25));
         accountSprite.addChild(createTextField(92,34,80,labelFormat,getString("IDS_ACCAUNT_STATUS"),25));
         accountSprite.addChild(createTextField(92,46,80,valueFormat,this.accauntType == param3 ? getString("IDS_STATUS_ACTIVE") : getString("IDS_STATUS_NOT_ACTIVE"),25));
         accountSprite.addChild(createTextField(92,60,80,labelFormat,getString("IDS_ACCAUNT_COST"),25));
         this.accauntCostTF[param3] = createTextField(92,72,80,valueFormat,"",25);
         accountSprite.addChild(this.accauntCostTF[param3]);
         if(this.accauntType == param3)
         {
            var activeMark:NSprite = new NSprite();
            updateBgUI(activeMark,false,16,16);
            activeMark.draw(getBmp("MARK_CHECK"),3,3);
            activeMark.x = 155;
            activeMark.y = 8;
            accountSprite.addChild(activeMark);
         }
         var button:BaseButton = this.createDisplayBut(param1,param2,accountSprite,accountSprite,accountSprite,this.handleAccauntPress,param3,this.submenu);
         return button;
      }
      
      private function handleAccauntPress(param1:Object) : void
      {
         if(this.selectedAccaunt != -1)
         {
            this.drawAccauntInk(this.accauntButtons[this.selectedAccaunt].upState,false);
         }
         selectedAccaunt = param1.value;
         var servicesText:String = "";
         var serviceId:int;
         var serviceIndex:int;
         if(this.selectedAccaunt > 0)
         {
            serviceIndex = 0;
            while(serviceIndex < this.accauntServices[this.selectedAccaunt - 1].length)
            {
               serviceId = this.accauntServices[this.selectedAccaunt - 1][serviceIndex];
               servicesText += "*" + getString("IDS_ACC_SERVICE_NAME_" + serviceId) + "\n";
               serviceIndex++;
            }
         }
         this.createInfoMenu(getString("IDS_ACCAUNT_" + this.selectedAccaunt),getString("IDS_ACCAUNT_DESC_" + this.selectedAccaunt) + "\n" + servicesText);
         this.drawAccauntInk(param1.upState,true);
         this.updateAccauntCost();
      }
      
      private function updateAccauntCost() : void
      {
         var accountIndex:int = 0;
         while(accountIndex < 4)
         {
            this.accauntCostTF[accountIndex].text = this.accauntCost[accountIndex][this.selectedDays] + " " + getString("IDS_CREDS");
            accountIndex++;
         }
         if(this.selectedAccaunt >= 0)
         {
            this.costTF.text = this.accauntCost[this.selectedAccaunt][this.selectedDays].toString() + " " + getString("IDS_CREDS");
         }
         else
         {
            this.costTF.text = "-";
         }
      }
      
      private function handleDayButtonPress(param1:Object) : void
      {
         updateBgUI(this.dayButtons[this.selectedDays].upState,false,41,16,this.dayButtons[this.selectedDays].textField1);
         selectedDays = param1.value;
         updateBgUI(this.dayButtons[this.selectedDays].upState,true,41,16,this.dayButtons[this.selectedDays].textField1);
         this.updateAccauntCost();
      }
      
      private function createDayButton(param1:int, param2:int, param3:int) : BaseButton
      {
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 10187041;
         labelFormat.size = 12;
         labelFormat.bold = true;
         labelFormat.align = TextFormatAlign.CENTER;
         var background:Sprite = new Sprite();
         var label:TextField = createTextField(0,-2,41,labelFormat,getString("IDS_DAYS_" + param3),18);
         background.addChild(label);
         updateBgUI(background,this.selectedDays == param3,41,16,label);
         var button:BaseButton = this.createDisplayBut(param1,param2,background,background,background,this.handleDayButtonPress,param3,this.submenu);
         button.textField1 = label;
         this.submenu.addUIChild(button);
         return button;
      }
      
      private function handleCompleateAccaunt(param1:Object) : void
      {
         if(this.checkAccauntServices())
         {
            this.main.showWarningMenu(getString("IDS_ACCOUNT_WARNING"),this.handleRealCompleateAccaunt);
            return;
         }
         var unusedInt:int = 0;
         var request:String = "bs|" + this.accauntServiceId[this.complSelectedAccaunt][this.complSelectedDays];
         if(this.money < this.accauntCost[this.complSelectedAccaunt][this.complSelectedDays])
         {
            this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
         }
         else
         {
            payBlocked = true;
            this.main.socket.sendStr(request);
         }
      }
      
      private function handleRealCompleateAccaunt(param1:Object) : void
      {
         var unusedInt:int = 0;
         var request:String = "bs|" + this.accauntServiceId[this.complSelectedAccaunt][this.complSelectedDays];
         if(this.money < this.accauntCost[this.complSelectedAccaunt][this.complSelectedDays])
         {
            this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
         }
         else
         {
            payBlocked = true;
            this.main.socket.sendStr(request);
         }
      }
      
      private function areServSame(param1:int, param2:int) : Boolean
      {
         if(SERVICE_GROUP[param1] == SERVICE_GROUP[param2])
         {
            return true;
         }
         return false;
      }
      
      private function checkAccauntServices() : Boolean
      {
         var accountServiceIndex:int = 0;
         var ownedIndex:int = 0;
         var ownedService:int = 0;
         accountServiceIndex = 0;
         while(accountServiceIndex < this.accauntServices[this.complSelectedAccaunt - 1].length)
         {
            ownedIndex = 0;
            while(ownedIndex < this.ownServices.length)
            {
               ownedService = this.ownServices[ownedIndex];
               if(ownedService > SV_ACCAUNT_VIP)
               {
                  if(this.areServSame(this.accauntServices[this.complSelectedAccaunt - 1][accountServiceIndex],this.accauntServices[ownedService]))
                  {
                     return true;
                  }
               }
               ownedIndex++;
            }
            accountServiceIndex++;
         }
         return false;
      }
      
      private function handleAcceptAccaunt(param1:Object) : void
      {
         var unusedInt:int = 0;
         var request:String = null;
         if(this.payBlocked)
         {
            return;
         }
         if(this.selectedAccaunt == -1)
         {
            this.main.showNotifyMenu(getString("IDS_ERR_SELECT_ACCAUNT"));
         }
         else if(this.selectedAccaunt == 0)
         {
            this.main.showNotifyMenu(getString("IDS_ERR_START_ACCAUNT"));
         }
         else
         {
            complSelectedAccaunt = this.selectedAccaunt;
            complSelectedDays = this.selectedDays;
            if(this.accauntType > 0)
            {
               if(this.accauntType > this.selectedAccaunt)
               {
                  this.main.showWarningMenu(getString("IDS_WARN_LOW_ACCAUNT"),this.handleCompleateAccaunt);
                  return;
               }
               if(this.accauntType < this.selectedAccaunt)
               {
                  this.main.showWarningMenu(getString("IDS_WARN_ACCAUNT_TIME"),this.handleCompleateAccaunt);
                  return;
               }
            }
            if(this.checkAccauntServices())
            {
               this.main.showWarningMenu(getString("IDS_ACCOUNT_WARNING"),this.handleRealCompleateAccaunt);
               return;
            }
            unusedInt = 0;
            request = "bs|" + this.accauntServiceId[this.selectedAccaunt][this.selectedDays];
            if(this.money < this.accauntCost[this.selectedAccaunt][this.selectedDays])
            {
               this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            }
            else
            {
               payBlocked = true;
               this.main.socket.sendStr(request);
            }
         }
      }
      
      private function createAccauntMenu() : void
      {
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var priceFormat:TextFormat = new TextFormat();
         priceFormat.font = "Verdana";
         priceFormat.color = 13408825;
         priceFormat.size = 12;
         priceFormat.bold = true;
         priceFormat.align = TextFormatAlign.RIGHT;
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 10187041;
         hintFormat.size = 10;
         selectedAccaunt = -1;
         this.submenu.draw(bitmap16,278,353);
         this.submenu.draw(bitmap16,278,383);
         this.submenu.addChild(createTextField(328,64,250,headingFormat,getString("IDS_AVAIBLE_ACCAUNTS"),30));
         this.submenu.addChild(createTextField(265,85,250,hintFormat,getString("IDS_SELECT_DAYS"),30));
         this.dayButtons[0] = this.createDayButton(402,86,0);
         this.dayButtons[1] = this.createDayButton(450,86,1);
         this.dayButtons[2] = this.createDayButton(498,86,2);
         this.dayButtons[3] = this.createDayButton(546,86,3);
         this.dayButtons[4] = this.createDayButton(594,86,4);
         this.addBalanceSprite(279,360,365,16);
         this.submenu.addChild(createTextField(289,333,270,headingFormat,getString("IDS_SELECTED_ACCAOUNT_PRICE"),30));
         costTF = createTextField(510,333,108,priceFormat,"",30);
         this.submenu.addChild(this.costTF);
         this.accauntButtons[0] = this.createAccaunt(265,110,0);
         this.accauntButtons[1] = this.createAccaunt(455,110,1);
         this.accauntButtons[2] = this.createAccaunt(265,225,2);
         this.accauntButtons[3] = this.createAccaunt(455,225,3);
         this.submenu.addUIChild(this.accauntButtons[0]);
         this.submenu.addUIChild(this.accauntButtons[1]);
         this.submenu.addUIChild(this.accauntButtons[2]);
         this.submenu.addUIChild(this.accauntButtons[3]);
         var button:NButton = createSimpleButton(279,390,getString("IDS_APPLY"),this.handleAcceptAccaunt);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         button = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         this.updateAccauntCost();
         this.createInfoMenu("","");
      }
      
      private function serviceCheckHandler(param1:Object) : void
      {
         if(this.selectedService != -1)
         {
            this.servicesCheck[this.selectedService].highlight = false;
            updateBgUI(this.servicesButtons[this.selectedService].upState,false,this.servicesButtons[this.selectedService].upState.width,this.servicesButtons[this.selectedService].upState.height,this.servicesButtons[this.selectedService].textField1,this.servicesButtons[this.selectedService].textField2);
         }
         selectedService = param1.value;
         this.servicesChecked[this.selectedService] = !this.servicesChecked[this.selectedService];
         this.servicesCheck[this.selectedService].checked = this.servicesChecked[this.selectedService];
         this.createInfoMenu(getString("IDS_INFORMATION"),getString("IDS_SERVICE_DESC_" + this.accauntServices[this.services[this.selectedService]]));
         this.servicesCheck[this.selectedService].highlight = true;
         updateBgUI(this.servicesButtons[this.selectedService].upState,true,this.servicesButtons[this.selectedService].upState.width,this.servicesButtons[this.selectedService].upState.height,this.servicesButtons[this.selectedService].textField1,this.servicesButtons[this.selectedService].textField2);
         this.updateServicesCost();
      }
      
      private function servicePressHandler(param1:Object) : void
      {
         if(this.selectedService != -1)
         {
            this.servicesCheck[this.selectedService].highlight = false;
            updateBgUI(this.servicesButtons[this.selectedService].upState,false,this.servicesButtons[this.selectedService].upState.width,this.servicesButtons[this.selectedService].upState.height,this.servicesButtons[this.selectedService].textField1,this.servicesButtons[this.selectedService].textField2);
         }
         selectedService = param1.value;
         this.createInfoMenu(getString("IDS_INFORMATION"),getString("IDS_SERVICE_DESC_" + this.accauntServices[this.services[this.selectedService]]));
         this.servicesCheck[this.selectedService].highlight = true;
         updateBgUI(this.servicesButtons[this.selectedService].upState,true,this.servicesButtons[this.selectedService].upState.width,this.servicesButtons[this.selectedService].upState.height,this.servicesButtons[this.selectedService].textField1,this.servicesButtons[this.selectedService].textField2);
      }
      
      private function checkServices() : Boolean
      {
         var serviceIndex:int = 0;
         var ownedIndex:int = 0;
         var accountServiceIndex:int = 0;
         var ownedService:int = 0;
         serviceIndex = 0;
         while(serviceIndex < this.services.length)
         {
            if(this.servicesChecked[serviceIndex])
            {
               ownedIndex = 0;
               for(; ownedIndex < this.ownServices.length; ownedIndex++)
               {
                  ownedService = this.ownServices[ownedIndex];
                  if(ownedService > SV_ACCAUNT_VIP)
                  {
                     if(this.areServSame(this.accauntServices[this.services[serviceIndex]],this.accauntServices[ownedService]) && ownedService != this.services[serviceIndex])
                     {
                        return true;
                     }
                  }
                  else
                  {
                     accountServiceIndex = 0;
                     while(accountServiceIndex < this.accauntServices[ownedService].length)
                     {
                        if(this.areServSame(this.accauntServices[this.services[serviceIndex]],this.accauntServices[ownedService][accountServiceIndex]))
                        {
                           return true;
                        }
                        accountServiceIndex++;
                     }
                  }
               }
            }
            serviceIndex++;
         }
         return false;
      }
      
      private function handleServicesCompleate(param1:Object) : void
      {
         this.buyService();
      }
      
      private function buyService() : void
      {
         var totalCost:int = 0;
         var request:String = "bs|";
         var serviceIndex:int = 0;
         while(serviceIndex < this.services.length)
         {
            if(this.servicesChecked[serviceIndex])
            {
               totalCost += this.servicesCost[serviceIndex];
               request += this.servicesServIdx[serviceIndex] + "|";
            }
            serviceIndex++;
         }
         if(this.money < totalCost)
         {
            showNotifyMenu(getString("IDS_PAY_ERROR_0"));
         }
         else
         {
            payBlocked = true;
            this.main.socket.sendStr(request);
         }
      }
      
      private function handleAcceptServices(param1:Object) : void
      {
         if(this.payBlocked)
         {
            return;
         }
         var hasSelection:Boolean = false;
         var serviceIndex:int = 0;
         while(serviceIndex < this.services.length)
         {
            if(this.servicesChecked[serviceIndex])
            {
               hasSelection = true;
               break;
            }
            serviceIndex++;
         }
         if(!hasSelection)
         {
            showNotifyMenu(getString("IDS_NO_SERVCIE_SELECT"));
            return;
         }
         if(this.checkServices())
         {
            showWarningMenu(getString("IDS_SERVICE_WARNING"),this.handleServicesCompleate);
            return;
         }
         this.buyService();
      }
      
      private function updateServicesCost() : void
      {
         var totalCost:int = 0;
         var serviceIndex:int = 0;
         while(serviceIndex < this.services.length)
         {
            if(this.servicesChecked[serviceIndex])
            {
               totalCost += this.servicesCost[serviceIndex];
            }
            serviceIndex++;
         }
         this.costTF.text = totalCost.toString() + " " + getString("IDS_CREDS");
      }
      
      private function createServicesMenu() : void
      {
         selectedService = -1;
         servicesCheck = new Array();
         servicesButtons = new Array();
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var rightHeadingFormat:TextFormat = new TextFormat();
         rightHeadingFormat.font = "Verdana";
         rightHeadingFormat.color = 13408825;
         rightHeadingFormat.size = 12;
         rightHeadingFormat.bold = true;
         rightHeadingFormat.align = TextFormatAlign.RIGHT;
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 10187041;
         hintFormat.size = 10;
         var serviceFormat:TextFormat = new TextFormat();
         serviceFormat.font = "Verdana";
         serviceFormat.color = 10187041;
         serviceFormat.size = 12;
         serviceFormat.bold = true;
         var priceFormat:TextFormat = new TextFormat();
         priceFormat.font = "Verdana";
         priceFormat.color = 10187041;
         priceFormat.size = 12;
         priceFormat.bold = true;
         priceFormat.align = TextFormatAlign.RIGHT;
         this.submenu.addChild(createTextField(364,67,250,headingFormat,getString("IDS_AVAIBLE_SERVICES"),40));
         this.submenu.addChild(createTextField(338,87,250,hintFormat,getString("IDS_SELECT_SERVICES"),40));
         this.drawInk(this.submenu,SERVICES_X,SERVICES_Y,SERVICES_WIDTH,SERVICES_HEIGHT);
         var servicesScroll:ScrollSprite = new ScrollSprite(SERVICES_WIDTH - 12,SERVICES_HEIGHT - 12,4);
         servicesScroll.x = SERVICES_X + 6;
         servicesScroll.y = SERVICES_Y + 6;
         this.submenuItems.push(servicesScroll);
         this.submenu.addUIChild(servicesScroll);
         var serviceIndex:int;
         var rowIndex:int = 0;
         serviceIndex = 0;
         while(serviceIndex < this.services.length)
         {
            if(this.services[serviceIndex] > SV_ACCAUNT_VIP)
            {
               this.servicesCheck[serviceIndex] = this.createCheckBox(1,rowIndex * 18 + 1,this.serviceCheckHandler,serviceIndex,servicesScroll);
               if(this.servicesChecked[serviceIndex])
               {
                  this.servicesCheck[serviceIndex].checked = true;
               }
               servicesScroll.addContent(this.servicesCheck[serviceIndex]);
               rowBackground = new Sprite();
               updateBgUI(rowBackground,false,SERVICES_WIDTH - 44,16);
               serviceButton = this.createDisplayBut(18,rowIndex * 18,rowBackground,rowBackground,rowBackground,this.servicePressHandler,serviceIndex,servicesScroll);
               serviceLabel = createTextField(22,rowIndex * 18 - 2,SERVICES_WIDTH - 48,serviceFormat,getString("IDS_SERVICE_NAME_" + this.accauntServices[this.services[serviceIndex]]) + "(" + this.servicesTime[serviceIndex] + " " + (this.servicesTime[serviceIndex] == 1 ? getString("IDS_DAY") : getString("IDS_DAYS")) + ")",18);
               serviceButton.textField1 = serviceLabel;
               priceLabel = createTextField(SERVICES_WIDTH - 129,rowIndex * 18 - 2,100,priceFormat,this.servicesCost[serviceIndex].toString() + " " + getString("IDS_CREDS"),18);
               serviceButton.textField2 = priceLabel;
               this.servicesButtons[serviceIndex] = serviceButton;
               servicesScroll.addContent(serviceButton);
               servicesScroll.addLine(serviceLabel);
               servicesScroll.addLine(priceLabel);
               rowIndex++;
            }
            serviceIndex++;
         }
         servicesScroll.init(rowIndex * 18);
         this.submenu.draw(bitmap16,278,353);
         this.submenu.draw(bitmap16,278,383);
         this.addBalanceSprite(279,360,365,16);
         this.submenu.addChild(createTextField(289,333,250,headingFormat,getString("IDS_SELECTED_SERVICE_PRICE"),30));
         costTF = createTextField(510,333,108,rightHeadingFormat,"",30);
         this.submenu.addChild(this.costTF);
         var rowBackground:Sprite;
         var serviceButton:BaseButton;
         var serviceLabel:TextField;
         var priceLabel:TextField;
         var button:NButton = createSimpleButton(279,390,getString("IDS_APPLY"),this.handleAcceptServices);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         button = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         this.updateServicesCost();
         this.createInfoMenu("","");
      }
      
      protected function setFilter(param1:int) : void
      {
         filterButtons[param1].upState = this.filterPressedBmp[param1];
         this.shopItems.filter = param1;
         if(param1 == ShopItem.PAY_FILTER_WEAPON)
         {
            this.shopItems.y = 117 + ShopItemView.LARGE_HEIGHT;
            this.shopItems.height = 252 - ShopItemView.LARGE_HEIGHT;
            if(!this.submenu.contains(this.nuiComponent15))
            {
               this.submenu.addUIChild(this.nuiComponent15);
               this.updateShopCost(this.filterButtonList1[0]);
            }
         }
         else
         {
            this.shopItems.y = 117;
            this.shopItems.height = 253;
            if(this.submenu.contains(this.nuiComponent15))
            {
               this.submenu.removeUIChild(this.nuiComponent15);
            }
         }
         this.textField23.text = filterButtons[param1].hintText;
      }
      
      private function handleFilterPress(param1:NButton) : void
      {
         var selectedFilter:int = int(param1.value);
         var currentFilter:int = this.shopItems.filter;
         if(ShopItem.array60.indexOf(this.shopItems.filter) != -1)
         {
            currentFilter = ShopItem.PAY_FILTER_WEAPON;
         }
         filterButtons[currentFilter].upState = this.filterNotPressedBmp[currentFilter];
         this.setFilter(currentFilter == selectedFilter ? ShopItem.PAY_FILTER_7 : selectedFilter);
      }
      
      private function handleShopPay(param1:Object) : void
      {
         if(this.payBlocked)
         {
            return;
         }
         if(this.basketList.propValue162 > this.money)
         {
            showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         var basketItems:Vector.<ShopItem> = this.basketList.items;
         if(basketItems.length == 0)
         {
            return;
         }
         var request:String = "bi|";
         var itemIndex:int = 0;
         while(itemIndex < basketItems.length)
         {
            request += basketItems[itemIndex].packId + "|";
            itemIndex++;
         }
         payBlocked = true;
         this.main.socket.sendStr(request);
      }
      
      private function doAction335() : void
      {
         this.costTF.text = this.basketList.propValue162 + " " + getString("IDS_CREDS");
      }
      
      private var textField23:TextField;

      private function createShopMenu() : void
      {
         if(!this.shopItemsLoaded)
         {
            this.main.socket.getShopItems();
         }
         this.createTabSubmenu();
         var headingFormat:TextFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         var priceFormat:TextFormat = new TextFormat();
         priceFormat.font = "Verdana";
         priceFormat.color = 13408825;
         priceFormat.size = 12;
         priceFormat.bold = true;
         priceFormat.align = TextFormatAlign.RIGHT;
         this.drawInk(this.submenu,68,91,320,290);
         this.drawInk(this.submenu,402,91,236,275);
         var filterIndex:int;
         var filterY:int = 90;
         filterIndex = 0;
         while(filterIndex < ShopItem.PAY_FILTER_8)
         {
            if(filterIndex == ShopItem.PAY_FILTER_7)
            {
               filterButtons[filterIndex] = this.addNBut(19,filterY,this.filterPressedBmp[filterIndex],this.filterOverBmp[filterIndex],this.filterPressedBmp[filterIndex],this.handleFilterPress,filterIndex);
            }
            else
            {
               filterButtons[filterIndex] = this.addNBut(19,filterY,this.filterNotPressedBmp[filterIndex],this.filterOverBmp[filterIndex],this.filterPressedBmp[filterIndex],this.handleFilterPress,filterIndex);
            }
            filterButtons[filterIndex].hintText = _("IDS_SHOP_FILTER_" + filterIndex);
            filterY += 36;
            filterIndex++;
         }
         if(this.textField23)
         {
            textField23 = null;
         }
         textField23 = createTextField(78,96,300,NTextFormat.titleFormat,getString("IDS_PAY_SHOP"),18);
         this.submenu.addChild(this.textField23);
         this.submenu.addChild(createTextField(472,96,100,headingFormat,getString("IDS_PAY_BASKET"),18));
         this.submenu.addChild(createTextField(418,370,100,headingFormat,getString("IDS_PAY_RESULT"),18));
         costTF = createTextField(531,370,100,priceFormat,"",18);
         this.submenu.addChild(this.costTF);
         this.addBalanceSprite(66,393,322,16);
         var button:NButton = createSimpleButton(410,390,getString("IDS_APPLY"),this.handleShopPay);
         var filterButton:FilterButton;
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         button = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         if(this.nuiComponent15 == null)
         {
            nuiComponent15 = new NUIComponent();
            this.nuiComponent15.setPos(78,127);
            this.nuiComponent15.disposeOnRemove = false;
         }
         if(this.filterButtonList1 == null)
         {
            filterButtonList1 = new Vector.<FilterButton>(ShopItem.array60.length,true);
            filterIndex = 0;
            while(filterIndex < ShopItem.array60.length)
            {
               filterButton = new FilterButton(ShopItem.array60[filterIndex],this.updateShopCost);
               filterButton.hintText = _("IDS_SKILL_" + filterIndex);
               filterButton.x = filterIndex * 45;
               this.filterButtonList1[filterIndex] = filterButton;
               this.nuiComponent15.addUIChild(filterButton);
               filterIndex++;
            }
            this.nuiComponent15.x = 78 + (300 - filterIndex * 45) / 2;
         }
         shopItems = new ShopItemsGrid(300,253,ShopItemView.STYLE_LARGE,this.doAction366);
         this.shopItems.setPos(78,117);
         this.shopItems.propValue49 = this.onShopItemSelect;
         this.shopItems.doAction715(this.shopItemsAr);
         this.shopItems.selectHandler = this.onSelect;
         this.submenu.addUIChild(this.shopItems);
         this.submenuItems.push(this.shopItems);
         basketList = new ShopItemsGrid(217,240,ShopItemView.STYLE_NORMAL);
         this.basketList.x = 412;
         this.basketList.y = 117;
         this.basketList.propValue49 = this.doAction383;
         this.submenu.addUIChild(this.basketList);
         this.submenuItems.push(this.basketList);
         this.doAction335();
         this.setFilter(ShopItem.PAY_FILTER_7);
      }
      
      private function updateShopCost(param1:FilterButton) : void
      {
         var index:int = 0;
         while(index < this.filterButtonList1.length)
         {
            this.filterButtonList1[index].toggled = this.filterButtonList1[index] == param1;
            index++;
         }
         this.shopItems.filter = int(param1.value);
      }
      
      private function onSelect(param1:ShopItem, param2:ShopItem) : int
      {
         return param1.packId < param2.packId ? -1 : 1;
      }
      
      protected function onShopItemSelect(param1:ShopItemView) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.shopitem,param1.image);
            this.dragger.setPos(this.shopItems.x + param1.x,this.shopItems.y + param1.y - this.shopItems.scrollV);
            this.shopItems.doAction713([param1.shopitem]);
         }
      }
      
      protected function doAction383(param1:ShopItemView) : void
      {
         if(this.dragger.isActive)
         {
            this.dragger.startDragItem(param1.shopitem,param1.image);
            this.dragger.setPos(this.basketList.x + param1.x,this.basketList.y + param1.y - this.basketList.scrollV);
            this.basketList.doAction713([param1.shopitem]);
            this.doAction335();
         }
      }
      
      private function handleSubTabPress(param1:Object) : void
      {
         selectedTab = param1.value;
         this.clearAllChilds();
         this.startMenu();
      }
      
      private function createTabSubmenu() : void
      {
         this.addNBut(20,64,getBmp("WEAPON_TAB"),getBmp("WEAPON_TAB_OVER"),getBmp("WEAPON_TAB_PRESSED"),this.handleSubTabPress,TAB_SHOP);
         this.addNBut(178,64,getBmp("STAT_TAB"),getBmp("STAT_TAB_OVER"),getBmp("STAT_TAB_PRESSED"),this.handleSubTabPress,TAB_STATS);
         this.addNBut(336,64,getBmp("VISUAL_TAB"),getBmp("VISUAL_TAB_OVER"),getBmp("VISUAL_TAB_PRESSED"),this.handleSubTabPress,TAB_HAIR);
         this.addNBut(494,64,getBmp("GIFTS_TAB"),getBmp("GIFTS_TAB_OVER"),getBmp("GIFTS_TAB_PRESSED"),this.handleSubTabPress,TAB_GIFTS);
      }
      
      private function unselectAllButtons() : void
      {
         var index:int = 0;
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            updateBgUI(this.statButtons[index].upState,false,295,16,this.statButtons[index].textField1);
            index++;
         }
         index = 0;
         while(index < Character.CUR_SKILL_COUNT)
         {
            updateBgUI(this.skillButtons[index].upState,false,259,16,this.skillButtons[index].textField1);
            index++;
         }
         index = 0;
         while(index < Character.PERKS_COUNT)
         {
            if(this.perkButtons != null && index < this.perkButtons.length)
            {
               updateBgUI(this.perkButtons[index].upState,false,295,16,this.checks[index].enabled ? this.perkButtons[index].textField1 : null);
            }
            index++;
         }
      }
      
      private function handleStatPress(param1:Object) : void
      {
         this.unselectAllButtons();
         updateBgUI(param1.upState,true,295,16,param1.textField1);
         this.createInfoMenu(getString("IDS_PS_INFORMATION"),getString("IDS_PS_STAT_DESC"),true);
      }
      
      private function handlePerkPress(param1:Object) : void
      {
         this.unselectAllButtons();
         updateBgUI(param1.upState,true,295,16,param1.object.enabled ? param1.textField1 : null);
         this.perkDescription.text = getString("IDS_PERK_DESC_" + param1.value);
      }
      
      private function handleSkillPress(param1:Object) : void
      {
         this.unselectAllButtons();
         updateBgUI(param1.upState,true,259,16,param1.textField1);
         this.createInfoMenu(getString("IDS_PS_INFORMATION"),getString("IDS_PS_SKILL_DESC"),true);
      }
      
      private function subSkill(param1:int) : void
      {
         if(this.curSkills[param1] > 0)
         {
            this.curSkills[param1]--;
            this.updateSkills();
            this.updateCharCost();
         }
      }
      
      private function addSkill(param1:int) : void
      {
         if((param1 < Character.SKILL_DOCTOR && this.freeBattleSkill > 0 || param1 >= Character.SKILL_DOCTOR && this.freePeaceSkill > 0) && this.curSkills[param1] < this.skills[param1] && (this.getCurPriority(param1) == 1 || this.getPriority(param1) == 0))
         {
            this.curSkills[param1]++;
            this.updateSkills();
            this.updateCharCost();
         }
      }
      
      private function subSkillHandler(param1:Object) : void
      {
         this.subSkill(param1.value);
      }
      
      private function addSkillHandler(param1:Object) : void
      {
         this.addSkill(param1.value);
      }
      
      private function get freeBattleSkill() : int
      {
         var skillDifference:int = 0;
         var skillIndex:int = 0;
         while(skillIndex < Character.SKILL_DOCTOR)
         {
            skillDifference += this.skills[skillIndex] - this.curSkills[skillIndex];
            skillIndex++;
         }
         var skillAllowance:int = Character.SKILL_ADD_VALUE[this.curStats[Character.STAT_INTELLECT] - 1] * (this.main.userCharacter.level + 1);
         return skillAllowance - this.battleSkillSum + skillDifference;
      }
      
      private function get freePeaceSkill() : int
      {
         var skillDifference:int = 0;
         var skillIndex:int = Character.SKILL_DOCTOR;
         while(skillIndex < Character.CUR_SKILL_COUNT)
         {
            skillDifference += this.skills[skillIndex] - this.curSkills[skillIndex];
            skillIndex++;
         }
         var skillAllowance:int = Character.SKILL_ADD_VALUE[this.curStats[Character.STAT_INTELLECT] - 1] * (this.main.userCharacter.level + 1);
         return skillAllowance - this.peaceSkillSum + skillDifference;
      }
      
      private function subStatHandler(param1:Object) : void
      {
         var skillPointsNeeded:int = 0;
         var battlePoints:int = 0;
         var peacePoints:int = 0;
         if(this.curStats[param1.value] > Character.START_STAT_VAL)
         {
            skillPointsNeeded = 0;
            if(param1.value == Character.STAT_INTELLECT)
            {
               skillPointsNeeded = (Character.SKILL_ADD_VALUE[this.curStats[param1.value]] - Character.SKILL_ADD_VALUE[this.curStats[param1.value] - 1]) * (this.main.userCharacter.level + 1);
               battlePoints = this.freeBattleSkill;
               peacePoints = this.freePeaceSkill;
               if(battlePoints < skillPointsNeeded || peacePoints < skillPointsNeeded)
               {
                  showNotifyMenu(getString("IDS_PS_LEVEL_WARN_0") + " " + skillPointsNeeded + " " + getString("IDS_PS_LEVEL_WARN_SKILL"));
                  return;
               }
            }
            --this.curStats[param1.value];
            if(this.changedStats > MAX_CHANGE_STAT + this.freeStats)
            {
               ++this.curStats[param1.value];
            }
            else
            {
               this.updateStats();
               this.updateSkills();
               this.updateCharCost();
            }
         }
      }
      
      private function addStatHandler(param1:Object) : void
      {
         if(Character.START_STAT_AVAIBLE + Character.START_STAT_VAL * Character.STAT_COUNT - this.statSum > 0 && this.curStats[param1.value] < Character.MAX_STAT_VAL)
         {
            ++this.curStats[param1.value];
            this.updateStats();
            this.updateSkills();
            this.updateCharCost();
         }
      }
      
      private function addDecButton(param1:int, param2:int, param3:Function, param4:int = 0, param5:int = 0) : BaseButton
      {
         var arrowBitmap:Bitmap = getBmp("LEFT_ARROW");
         var button:BaseButton = new NButton(param3,arrowBitmap,getBmp("LEFT_ARROW_OVER"),getBmp("LEFT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         if(param5 == SUBMENU)
         {
            this.submenuItems.push(button);
            this.submenu.addUIChild(button);
         }
         else
         {
            this.tabmenuItems.push(button);
            this.tabmenu.addUIChild(button);
         }
         return button;
      }
      
      private function addAddButton(param1:int, param2:int, param3:Function, param4:int = 0, param5:int = 0) : BaseButton
      {
         var arrowBitmap:Bitmap = getBmp("RIGHT_ARROW");
         var button:BaseButton = new NButton(param3,arrowBitmap,getBmp("RIGHT_ARROW_OVER"),getBmp("RIGHT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         if(param5 == SUBMENU)
         {
            this.submenuItems.push(button);
            this.submenu.addUIChild(button);
         }
         else
         {
            this.tabmenuItems.push(button);
            this.tabmenu.addUIChild(button);
         }
         return button;
      }
      
      private function addInfoDecButton(param1:int, param2:int, param3:Function, param4:int = 0) : BaseButton
      {
         var arrowBitmap:Bitmap = getBmp("LEFT_ARROW");
         var button:BaseButton = new NButton(param3,arrowBitmap,getBmp("LEFT_ARROW_OVER"),getBmp("LEFT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         this.infoMenuItems.push(button);
         this.infoMenu.addUIChild(button);
         return button;
      }
      
      private function addInfoAddButton(param1:int, param2:int, param3:Function, param4:int = 0) : BaseButton
      {
         var arrowBitmap:Bitmap = getBmp("RIGHT_ARROW");
         var button:BaseButton = new NButton(param3,arrowBitmap,getBmp("RIGHT_ARROW_OVER"),getBmp("RIGHT_ARROW_PRESSED"),arrowBitmap);
         button.value = param4;
         button.x = param1;
         button.y = param2;
         this.infoMenuItems.push(button);
         this.infoMenu.addUIChild(button);
         return button;
      }
      
      private function updateSkills() : void
      {
         var originalValueFormat:TextFormat = new TextFormat();
         originalValueFormat.font = "Verdana";
         originalValueFormat.color = 10187041;
         originalValueFormat.size = 12;
         originalValueFormat.bold = true;
         originalValueFormat.align = TextFormatAlign.CENTER;
         var skillIndex:int;
         var originalValueStart:int;
         var unusedInt1:int = 0;
         var unusedInt2:int = 0;
         skillIndex = 0;
         while(skillIndex < Character.CUR_SKILL_COUNT)
         {
            this.skillText[skillIndex].text = this.curSkills[skillIndex].toString();
            originalValueStart = this.skillText[skillIndex].text.length;
            this.skillText[skillIndex].text += "(" + this.skills[skillIndex] + ")";
            this.skillText[skillIndex].setTextFormat(originalValueFormat,originalValueStart,this.skillText[skillIndex].text.length);
            skillIndex++;
         }
         this.freeBattleTF.text = this.freeBattleSkill.toString();
         this.freePeaceTF.text = this.freePeaceSkill.toString();
      }
      
      private function get statSum() : int
      {
         var total:int = 0;
         var statIndex:int = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            total += this.curStats[statIndex];
            statIndex++;
         }
         return total;
      }
      
      private function get changedStats() : int
      {
         var total:int = 0;
         var statIndex:int = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            if(this.curStats[statIndex] < this.stats[statIndex])
            {
               total += this.stats[statIndex] - this.curStats[statIndex];
            }
            statIndex++;
         }
         return total;
      }
      
      private function updateStats() : void
      {
         var originalValueFormat:TextFormat = new TextFormat();
         var statIndex:int;
         var originalValueStart:int;
         originalValueFormat.font = "Verdana";
         originalValueFormat.color = 10187041;
         originalValueFormat.size = 12;
         originalValueFormat.bold = true;
         originalValueFormat.align = TextFormatAlign.CENTER;
         statIndex = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            this.statText[statIndex].text = this.curStats[statIndex].toString();
            originalValueStart = this.statText[statIndex].text.length;
            this.statText[statIndex].text += "(" + this.stats[statIndex] + ")";
            this.statText[statIndex].setTextFormat(originalValueFormat,originalValueStart,this.statText[statIndex].text.length);
            statIndex++;
         }
         this.freeStatsTF.text = (Character.START_STAT_AVAIBLE + Character.START_STAT_VAL * Character.STAT_COUNT - this.statSum).toString();
      }
      
      private function limitPressHandler(param1:Object) : void
      {
         var previousUpState:Object = param1.object;
         var previousOverState:Object = param1.object1;
         param1.object = param1.upState;
         param1.object1 = param1.overState;
         param1.upState = previousUpState;
         param1.overState = previousOverState;
         if(this.getCurLimiters(param1.value) == 1)
         {
            this.disablePriority(param1.value);
         }
         else
         {
            this.enableCurLimiters(param1.value);
            this.createInfoMenu(getString("IDS_PS_INFORMATION"),formatString("IDS_SKILL_LIMIT_DESC",param1.value),true);
         }
         this.updateCharCost();
      }
      
      private function get charCost() : int
      {
         var totalCost:int = 0;
         var skillIndex:int = 0;
         var changedCount:int = this.changedStats;
         if(changedCount > this.freeStats)
         {
            totalCost += STAT_CHANGE_COST * (changedCount - this.freeStats);
         }
         skillIndex = 0;
         while(skillIndex < Character.CUR_SKILL_COUNT)
         {
            if(skillIndex < Character.SKILL_DOCTOR)
            {
               totalCost += (this.skills[skillIndex] - this.curSkills[skillIndex]) * BSKILL_CHANGE_COST;
            }
            else
            {
               totalCost += (this.skills[skillIndex] - this.curSkills[skillIndex]) * PSKILL_CHANGE_COST;
            }
            if(this.getLimiters(skillIndex) == 0 && this.getCurLimiters(skillIndex) == 1)
            {
               if(skillIndex < Character.SKILL_DOCTOR)
               {
                  totalCost += PSKILL_CHANGE_225;
               }
               else
               {
                  totalCost += PSKILL_CHANGE_150;
               }
            }
            skillIndex++;
         }
         return totalCost;
      }
      
      private function get propValue136() : int
      {
         return this.flag139 || this.curPerks == 0 ? 0 : HAIR_PAL_1875;
      }
      
      private function updateCharCost() : void
      {
         var cost:int = this.statSubmenu == SUBMENU_PERKS ? this.propValue136 : this.charCost;
         this.statCostText.text = cost + " " + getString("IDS_CREDS");
      }
      
      private function priorityCheckHandler(param1:Object) : void
      {
         var battleCount:int = 0;
         var peaceCount:int = 0;
         var skillIndex:int = 0;
         if(this.skillsTime == 0)
         {
            if(this.getCurPriority(param1.value) == 1)
            {
               if(this.getPriority(param1.value) == 1)
               {
                  this.curSkills[param1.value] = 0;
                  this.updateSkills();
               }
               this.resetCurrentPerk(param1.value);
               param1.checked = false;
               this.updateCharCost();
            }
            else
            {
               battleCount = 0;
               peaceCount = 0;
               skillIndex = 0;
               while(skillIndex < Character.CUR_SKILL_COUNT)
               {
                  if(this.getCurPriority(skillIndex) == 1)
                  {
                     if(skillIndex < Character.SKILL_DOCTOR)
                     {
                        battleCount++;
                     }
                     else
                     {
                        peaceCount++;
                     }
                  }
                  skillIndex++;
               }
               if(param1.value < Character.SKILL_DOCTOR && battleCount < 2 || param1.value >= Character.SKILL_DOCTOR && peaceCount < 2)
               {
                  this.enableCurPriority(param1.value);
                  param1.checked = true;
                  this.updateCharCost();
               }
            }
         }
      }
      
      private function createCheckBox(param1:int, param2:int, param3:Function, param4:int = 0, param5:Object = null, param6:int = 0) : NCheckBox
      {
         var checkBox:NCheckBox = new NCheckBox(param3,param5);
         checkBox.value = param4;
         checkBox.object = this;
         checkBox.x = param1;
         checkBox.y = param2;
         if(param6 == SUBMENU)
         {
            this.submenuItems.push(checkBox);
         }
         else
         {
            this.tabmenuItems.push(checkBox);
         }
         return checkBox;
      }
      
      private function perkPay() : void
      {
         this.main.socket.sendStr("pk|" + this.curPerks + "|");
      }
      
      private function charPay(param1:Object) : void
      {
         if(this.payBlocked)
         {
            return;
         }
         var request:String = "bc|" + this.curPrioritySkill + "|" + this.curLimiters + "|";
         var index:int = 0;
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            request += this.curStats[index] + "|";
            index++;
         }
         index = 0;
         while(index < Character.CUR_SKILL_COUNT)
         {
            request += this.skills[index] - this.curSkills[index] + "|";
            index++;
         }
         payBlocked = true;
         this.main.socket.sendStr(request);
      }
      
      private function showTimeWarnMenu(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(param2)
            {
               showWarningMenu(getString("IDS_PS_TIME_WARN_2"),this.charPay);
            }
            else
            {
               showWarningMenu(getString("IDS_PS_TIME_WARN_0"),this.charPay);
            }
         }
         else if(param2)
         {
            showWarningMenu(getString("IDS_PS_TIME_WARN_1"),this.charPay);
         }
      }
      
      private function handleCharPay(target:Object) : void
      {
         var i:int;
         var selectedCount:int;
         var perksCount:int;
         var warnId:String;
         var battlePriorityCount:int;
         var peacePriorityCount:int;
         var skillWarn:Boolean;
         var statWarn:Boolean;
         if(this.statSubmenu == SUBMENU_PERKS)
         {
            if(this.curPerks != 0)
            {
               selectedCount = Character.getPreksCountInPerks(this.curPerks);
               perksCount = Character.getPreksCountInPerks(this.perks);
               if(selectedCount == perksCount)
               {
                  if(!this.flag139 && this.money < this.propValue136)
                  {
                     showNotifyMenu(_("IDS_PAY_ERROR_0"));
                     return;
                  }
                  warnId = this.flag139 ? "IDS_PERK_CHANGE_WITH_LIST_CONFIRM" : "IDS_PERK_CHANGE_CONFIRM";
                  Client.client.showYesNoMenu(_(warnId),function(param1:*):void
                  {
                     perkPay();
                     closeMenu();
                  });
               }
               else
               {
                  showNotifyMenu(getString("IDS_PS_FREE_PERKS"));
               }
            }
         }
         else
         {
            battlePriorityCount = 0;
            peacePriorityCount = 0;
            i = 0;
            while(i < Character.CUR_SKILL_COUNT)
            {
               if(this.getCurPriority(i) == 1)
               {
                  if(i < Character.SKILL_DOCTOR)
                  {
                     battlePriorityCount++;
                  }
                  else
                  {
                     peacePriorityCount++;
                  }
               }
               i++;
            }
            if(battlePriorityCount != 2 || peacePriorityCount != 2)
            {
               showNotifyMenu(getString("IDS_PRIORITY_WARN"));
               return;
            }
            if(this.money < this.charCost)
            {
               showNotifyMenu(getString("IDS_PAY_ERROR_0"));
               return;
            }
            if(Character.START_STAT_AVAIBLE + Character.START_STAT_VAL * Character.STAT_COUNT != this.statSum)
            {
               showNotifyMenu(getString("IDS_PS_FREE_STAT"));
               return;
            }
            skillWarn = false;
            statWarn = false;
            if(this.curPrioritySkill != this.prioritySkill)
            {
               skillWarn = true;
            }
            if(this.changedStats > this.freeStats)
            {
               statWarn = true;
            }
            i = 0;
            while(i < Character.CUR_SKILL_COUNT)
            {
               if(this.curSkills[i] != this.skills[i])
               {
                  skillWarn = true;
               }
               i++;
            }
            if(statWarn || skillWarn)
            {
               this.showTimeWarnMenu(statWarn,skillWarn);
            }
            else
            {
               this.charPay(null);
            }
         }
      }
      
      private function createStatsList() : void
      {
         statSubmenu = SUBMENU_STATS;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.bold = true;
         centeredFormat.align = TextFormatAlign.CENTER;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.bold = true;
         rightFormat.align = TextFormatAlign.RIGHT;
         index = 0;
         while(index < Character.STAT_COUNT)
         {
            label = createTextField(30,130 + index * 18,200,labelFormat,getString("IDS_STAT_" + index),18);
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,295,16,label);
            button = this.createDisplayBut(25,132 + index * 18,rowBackground,rowBackground,rowBackground,this.handleStatPress,index,this.tabmenu);
            button.textField1 = label;
            this.tabmenu.addUIChild(button);
            this.tabmenu.addChild(label);
            this.statButtons[index] = button;
            if(this.statsTime == 0)
            {
               this.addDecButton(220,129 + index * 18,this.subStatHandler,index,TABMENU);
               this.addAddButton(304,129 + index * 18,this.addStatHandler,index,TABMENU);
            }
            this.statText[index] = createTextField(237,130 + index * 18,66,centeredFormat,"0",18);
            this.tabmenu.addChild(this.statText[index]);
            index++;
         }
         rowBackground = new Sprite();
         updateBgUI(rowBackground,false,295,16);
         rowBackground.x = 25;
         rowBackground.y = 247;
         this.tabmenu.addChild(rowBackground);
         this.tabmenu.addChild(createTextField(30,246,200,labelFormat,getString("IDS_STAT_ADD"),18));
         freeStatsTF = createTextField(220,246,100,rightFormat,"0",18);
         this.tabmenu.addChild(this.freeStatsTF);
         var index:int;
         var button:BaseButton;
         var rowBackground:Sprite;
         var label:TextField;
         var decoration:Bitmap = getBmp("RAZDELITEL2");
         var checkBox:NCheckBox;
         var rowY:int;
         var warningText:String;
         var activeBitmap:Bitmap;
         var activeOverBitmap:Bitmap;
         var inactiveBitmap:Bitmap;
         var inactiveOverBitmap:Bitmap;
         this.tabmenu.draw(decoration,29,242);
         if(this.skillsTime != 0 || this.statsTime != 0 || this.freeStats > 0)
         {
            warningText = "";
            if(this.freeStats > 0)
            {
               warningText += getString("IDS_PS_FREE_STAT_1") + "\n";
            }
            if(this.statsTime)
            {
               warningText += getString("IDS_PS_STAT_WARN") + " " + getDateStr(this.statsTime) + ".\n";
            }
            if(this.skillsTime)
            {
               warningText += getString("IDS_PS_SKILL_WARN") + " " + getDateStr(this.skillsTime) + ".";
            }
            this.createInfoMenu(getString("IDS_PS_WARNING"),warningText,true,-1,true);
         }
         else
         {
            this.createInfoMenu("","",true);
         }
         decoration = getBmp("RAZDELITEL2");
         this.tabmenu.draw(decoration,357,341);
         this.tabmenu.draw(decoration,358,188);
         this.tabmenu.draw(decoration,358,306);
         this.tabmenu.addChild(createTextField(428,93,130,labelFormat,getString("IDS_PS_BS"),18));
         this.tabmenu.addChild(createTextField(426,211,130,labelFormat,getString("IDS_PS_PS"),18));
         rowBackground = new Sprite();
         updateBgUI(rowBackground,false,259,16);
         rowBackground.x = 379;
         rowBackground.y = 194;
         this.tabmenu.addChild(rowBackground);
         this.tabmenu.addChild(createTextField(384,192,200,labelFormat,getString("IDS_STAT_ADD"),18));
         freeBattleTF = createTextField(MENU_WIDTH - 125,192,100,rightFormat,"0",18);
         this.tabmenu.addChild(this.freeBattleTF);
         rowBackground = new Sprite();
         updateBgUI(rowBackground,false,259,16);
         rowBackground.x = 379;
         rowBackground.y = 312;
         this.tabmenu.addChild(rowBackground);
         this.tabmenu.addChild(createTextField(384,310,200,labelFormat,getString("IDS_STAT_ADD"),18));
         freePeaceTF = createTextField(MENU_WIDTH - 125,310,100,rightFormat,"0",18);
         this.tabmenu.addChild(this.freePeaceTF);
         index = 0;
         while(index < Character.CUR_SKILL_COUNT)
         {
            if(index < Character.SKILL_DOCTOR)
            {
               label = createTextField(384,110 + index * 18,200,labelFormat,getString("IDS_SKILL_SHORT_" + index),18);
            }
            else
            {
               label = createTextField(384,228 + (index - Character.SKILL_DOCTOR) * 18,200,labelFormat,getString("IDS_SKILL_" + index),18);
            }
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,259,16,label);
            if(index < Character.SKILL_DOCTOR)
            {
               rowY = 112 + index * 18;
            }
            else
            {
               rowY = 230 + (index - Character.SKILL_DOCTOR) * 18;
            }
            button = this.createDisplayBut(379,rowY,rowBackground,rowBackground,rowBackground,this.handleSkillPress,index,this.tabmenu,TABMENU);
            checkBox = this.createCheckBox(362,rowY + 1,this.priorityCheckHandler,index,this.tabmenu,TABMENU);
            if(this.getCurPriority(index) == 1)
            {
               checkBox.checked = true;
            }
            button.textField1 = label;
            this.tabmenu.addUIChild(button);
            this.tabmenu.addChild(label);
            this.tabmenu.addUIChild(checkBox);
            this.skillButtons[index] = button;
            if(index < Character.SKILL_DOCTOR)
            {
               if(this.skillsTime == 0)
               {
                  this.addDecButton(538,109 + index * 18,this.subSkillHandler,index,TABMENU);
                  this.addAddButton(622,109 + index * 18,this.addSkillHandler,index,TABMENU);
               }
               this.skillText[index] = createTextField(551,110 + index * 18,74,centeredFormat,"0",18);
            }
            else
            {
               if(this.skillsTime == 0)
               {
                  this.addDecButton(538,227 + (index - Character.SKILL_DOCTOR) * 18,this.subSkillHandler,index,TABMENU);
                  this.addAddButton(622,227 + (index - Character.SKILL_DOCTOR) * 18,this.addSkillHandler,index,TABMENU);
               }
               this.skillText[index] = createTextField(551,228 + (index - Character.SKILL_DOCTOR) * 18,74,centeredFormat,"0",18);
            }
            this.tabmenu.addChild(this.skillText[index]);
            if(this.getLimiters(index) == 1)
            {
               decoration = getBmp("BRAKE_ACTIVE");
               decoration.x = 344;
               decoration.y = rowY;
               this.tabmenu.addChild(decoration);
            }
            else
            {
               activeBitmap = getBmp("BRAKE_ACTIVE");
               activeOverBitmap = getBmp("BRAKE_ACTIVE_OVER");
               inactiveBitmap = getBmp("BRAKE_INACTIVE");
               inactiveOverBitmap = getBmp("BRAKE_INACTIVE_OVER");
               if(this.getCurLimiters(index) == 1)
               {
                  button = createButton(344,rowY,index,activeBitmap,activeOverBitmap,activeBitmap,this.limitPressHandler);
                  button.object = inactiveBitmap;
                  button.object1 = inactiveOverBitmap;
               }
               else
               {
                  button = createButton(344,rowY,index,inactiveBitmap,inactiveOverBitmap,inactiveBitmap,this.limitPressHandler);
                  button.object = activeBitmap;
                  button.object1 = activeOverBitmap;
               }
               this.tabmenuItems.push(button);
               this.tabmenu.addUIChild(button);
            }
            index++;
         }
         this.updateCharCost();
      }
      
      private function perkCheckHandler(param1:NCheckBox) : void
      {
         if(param1.checked)
         {
            this.doAction48(int(param1.value));
         }
         else
         {
            this.doAction725(int(param1.value));
         }
         param1.checked = !param1.checked;
         this.updatePerks();
         this.updateCharCost();
      }
      
      private function doAction48(param1:int) : void
      {
         curPerks &= -1 ^ 1 << param1;
      }
      
      private function doAction725(param1:int) : void
      {
         curPerks |= 1 << param1;
      }
      
      private function getPerkLevelByCount(param1:int) : int
      {
         return param1 * 3;
      }
      
      private function canDisablePerk(param1:int) : Boolean
      {
         var remainingPerks:int = this.curPerks & (-1 ^ 1 << param1);
         return Character.checkPerk(remainingPerks,this.stats);
      }
      
      private function updatePerks() : void
      {
         var enabledFormat:TextFormat = new TextFormat();
         enabledFormat.font = "Verdana";
         enabledFormat.color = 13408825;
         enabledFormat.size = 12;
         enabledFormat.bold = true;
         var disabledFormat:TextFormat = new TextFormat();
         disabledFormat.font = "Verdana";
         disabledFormat.color = 8088138;
         disabledFormat.size = 12;
         disabledFormat.bold = true;
         var selectedPerkCount:int = Character.getPreksCountInPerks(this.curPerks);
         var originalPerkCount:int = Character.getPreksCountInPerks(this.perks);
         var perkLevel:int = this.getPerkLevelByCount(selectedPerkCount);
         var freePerks:int = originalPerkCount - selectedPerkCount;
         var availablePerks:int = Character.getAvaiblePerks(perkLevel,this.curPerks,this.stats);
         this.freeStatsTF.text = freePerks.toString();
         var perkIndex:int = 0;
         while(perkIndex < Character.PERKS_COUNT)
         {
            this.checks[perkIndex].checked = Character.hasPerkInPerks(this.curPerks,perkIndex);
            if(this.checks[perkIndex].checked && this.canDisablePerk(perkIndex) || !this.checks[perkIndex].checked && Character.hasPerkInPerks(availablePerks,perkIndex) && freePerks > 0)
            {
               this.checks[perkIndex].enabled = true;
               this.perkTexts[perkIndex].setTextFormat(enabledFormat);
            }
            else
            {
               this.checks[perkIndex].enabled = false;
               this.perkTexts[perkIndex].setTextFormat(disabledFormat);
            }
            perkIndex++;
         }
      }
      
      private function createPerksList() : void
      {
         statSubmenu = SUBMENU_PERKS;
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.bold = true;
         centeredFormat.align = TextFormatAlign.CENTER;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.bold = true;
         rightFormat.align = TextFormatAlign.RIGHT;
         var perkScroll:ScrollSprite = new ScrollSprite(287,106,4);
         this.tabmenu.addUIChild(perkScroll);
         this.tabmenuItems.push(perkScroll);
         perkScroll.x = 25;
         perkScroll.y = 130;
         checks = new Array();
         perkTexts = new Array();
         perkButtons = new Array();
         var perkIndex:int = 0;
         var button:BaseButton;
         var rowBackground:Sprite;
         var label:TextField;
         var checkBox:NCheckBox;
         while(perkIndex < Character.PERKS_COUNT)
         {
            label = createTextField(5,perkIndex * 18,271,labelFormat,getString("IDS_PERK_" + perkIndex),18);
            rowBackground = new Sprite();
            updateBgUI(rowBackground,false,276,16,label);
            button = this.createDisplayBut(0,2 + perkIndex * 18,rowBackground,rowBackground,rowBackground,this.handlePerkPress,perkIndex,this.tabmenu);
            button.textField1 = label;
            this.perkButtons[perkIndex] = button;
            perkScroll.addContent(button);
            perkScroll.addLine(label);
            checkBox = this.createCheckBox(258,4 + perkIndex * 18,this.perkCheckHandler,perkIndex,this.tabmenu,TABMENU);
            perkScroll.addContent(checkBox);
            this.perkTexts.push(label);
            this.checks.push(checkBox);
            button.object = checkBox;
            perkIndex++;
         }
         perkScroll.init(4 + perkIndex * 18);
         var separator:Bitmap = getBmp("RAZDELITEL2");
         var descriptionFormat:TextFormat;
         this.submenu.draw(separator,29,242);
         rowBackground = new Sprite();
         updateBgUI(rowBackground,false,295,16);
         rowBackground.x = 25;
         rowBackground.y = 247;
         this.tabmenu.addChild(rowBackground);
         this.tabmenu.addChild(createTextField(30,246,200,labelFormat,getString("IDS_STAT_ADD"),18));
         freeStatsTF = createTextField(220,246,100,rightFormat,"0",18);
         this.tabmenu.addChild(this.freeStatsTF);
         label = createTextField(348,101,286,centeredFormat,getString("IDS_PS_PERK_DESC_HEADER"),18);
         this.tabmenu.addChild(label);
         descriptionFormat = new TextFormat();
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187041;
         descriptionFormat.size = 10;
         perkDescription = createTextField(348,116,286,descriptionFormat,"",194);
         this.perkDescription.multiline = true;
         this.perkDescription.wordWrap = true;
         this.tabmenu.addChild(this.perkDescription);
         this.updatePerks();
         this.updateCharCost();
         this.createInfoMenu("",getString("IDS_PS_PERK_DESC"),true);
      }
      
      private function statsPressHandler(param1:Object) : void
      {
         this.clearTabmenu();
         this.updateStatTabs(true);
         this.createStatsList();
         this.updateStats();
      }
      
      private function perksPressHandler(param1:Object) : void
      {
         this.clearTabmenu();
         this.updateStatTabs(false);
         this.createPerksList();
      }
      
      private function updateStatTabs(param1:Boolean) : void
      {
         if(param1)
         {
            this.statsButton.upState = this.statsButton.object.hlight;
            this.statsButton.overState = this.statsButton.object.hlight;
            this.perkButton.upState = this.perkButton.object.def;
            this.perkButton.overState = this.perkButton.object.def;
         }
         else
         {
            this.statsButton.upState = this.statsButton.object.def;
            this.statsButton.overState = this.statsButton.object.def;
            this.perkButton.upState = this.perkButton.object.hlight;
            this.perkButton.overState = this.perkButton.object.hlight;
         }
      }
      
      private var statsButton:BaseButton;

      private var perkButton:BaseButton;

      private var checks:Array;

      private var perkTexts:Array;

      private var statSubmenu:int = 0;

      private var perkDescription:TextField;

      private function createStatsMenu() : void
      {
         var headingFormat:TextFormat;
         var tabFormat:TextFormat;
         var selectedTabFormat:TextFormat;
         var descriptionFormat:TextFormat;
         var rightFormat:TextFormat;
         var normalTabLabel:TextField;
         var selectedTabLabel:TextField;
         var rowBackground:Sprite;
         var limiterBitmap:Bitmap;
         var descriptionLabel:TextField;
         var button:NButton;
         this.createTabSubmenu();
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         tabFormat = new TextFormat();
         tabFormat.font = "Verdana";
         tabFormat.color = 13408825;
         tabFormat.size = 12;
         tabFormat.bold = true;
         tabFormat.align = TextFormatAlign.CENTER;
         selectedTabFormat = new TextFormat();
         selectedTabFormat.font = "Verdana";
         selectedTabFormat.color = 16776067;
         selectedTabFormat.size = 12;
         selectedTabFormat.bold = true;
         selectedTabFormat.align = TextFormatAlign.CENTER;
         descriptionFormat = new TextFormat();
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187041;
         descriptionFormat.size = 10;
         rightFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.bold = true;
         rightFormat.align = TextFormatAlign.RIGHT;
         normalTabLabel = createTextField(0,0,122,tabFormat,getString("IDS_PS_STATS"),18);
         selectedTabLabel = createTextField(0,0,122,selectedTabFormat,getString("IDS_PS_STATS"),18);
         statsButton = this.addDisplayBut(37,101,selectedTabLabel,selectedTabLabel,selectedTabLabel,this.statsPressHandler);
         this.statsButton.object = {
            "def":normalTabLabel,
            "hlight":selectedTabLabel
         };
         normalTabLabel = createTextField(0,0,122,tabFormat,getString("IDS_PS_PERKS"),18);
         selectedTabLabel = createTextField(0,0,122,selectedTabFormat,getString("IDS_PS_PERKS"),18);
         perkButton = this.addDisplayBut(185,101,normalTabLabel,normalTabLabel,selectedTabLabel,this.perksPressHandler);
         this.perkButton.object = {
            "def":normalTabLabel,
            "hlight":selectedTabLabel
         };
         rowBackground = new Sprite();
         updateBgUI(rowBackground,false,298,16);
         rowBackground.x = 340;
         rowBackground.y = 367;
         this.submenu.addChild(rowBackground);
         this.submenu.addChild(createTextField(350,365,170,headingFormat,getString("IDS_PS_STAT_COST"),18));
         statCostText = createTextField(MENU_WIDTH - 125,365,100,rightFormat,"0",18);
         this.submenu.addChild(this.statCostText);
         this.addBalanceSprite(340,349,298,16,true);
         limiterBitmap = getBmp("BRAKE_ACTIVE");
         limiterBitmap.x = 23;
         limiterBitmap.y = 393;
         this.submenu.addChild(limiterBitmap);
         descriptionLabel = createTextField(43,386,285,descriptionFormat,getString("IDS_PS_LIMIT_DESC"),40);
         descriptionLabel.multiline = true;
         descriptionLabel.wordWrap = true;
         this.submenu.addChild(descriptionLabel);
         this.drawInk(this.submenu,19,91,308,181);
         this.drawInk(this.submenu,336,91,308,244);
         this.drawInk(this.submenu,37,101,122,21);
         this.drawInk(this.submenu,185,101,122,21);
         this.createStatsList();
         button = createSimpleButton(340,390,getString("IDS_APPLY"),this.handleCharPay);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         button = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(button);
         this.submenu.addUIChild(button);
         this.updateStats();
         this.updateSkills();
         this.updateCharCost();
      }
      
      public function enableCurPriority(param1:int) : void
      {
         curPrioritySkill |= 1 << param1;
      }
      
      public function resetCurrentPerk(param1:int) : void
      {
         curPrioritySkill &= -1 ^ 1 << param1;
      }
      
      public function getCurPriority(param1:int) : int
      {
         return this.curPrioritySkill >> param1 & 1;
      }
      
      public function setCurrentPerk(param1:int) : void
      {
         prioritySkill |= 1 << param1;
      }
      
      public function disableCurPriority(param1:int) : void
      {
         prioritySkill &= -1 ^ 1 << param1;
      }
      
      public function getPriority(param1:int) : int
      {
         return this.prioritySkill >> param1 & 1;
      }
      
      public function enableCurLimiters(param1:int) : void
      {
         curLimiters |= 1 << param1;
      }
      
      public function disablePriority(param1:int) : void
      {
         curLimiters &= -1 ^ 1 << param1;
      }
      
      public function getCurLimiters(param1:int) : int
      {
         return this.curLimiters >> param1 & 1;
      }
      
      public function enableLimiters(param1:int) : void
      {
         limiters |= 1 << param1;
      }
      
      public function disableCurLimiters(param1:int) : void
      {
         limiters &= -1 ^ 1 << param1;
      }
      
      public function getLimiters(param1:int) : int
      {
         return this.limiters >> param1 & 1;
      }
      
      private function handleHairPress(param1:Object) : void
      {
         if(this.curHairId != -1)
         {
            this.hairButtons[this.curHairId].upState.graphics.clear();
            this.hairButtons[this.curHairId].upState.draw(this.hairBg,0,0);
         }
         curHairId = param1.value;
         curPalId = this.avatarPal == -1 ? 0 : this.avatarPal;
         this.hairButtons[this.curHairId].upState.draw(this.hairBgHl,0,0);
         this.selectHair(param1.value,this.curPalId);
      }
      
      private function loadErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private function avatarCompleteHandler(param1:Event) : void
      {
         param1.target.loader.scaleX = 0.5;
         param1.target.loader.scaleY = 0.5;
         this.updateAvatar();
      }
      
      private function onComplete2(param1:Event) : void
      {
         var picture:Picture;
         picture = param1.target as Picture;
         picture.removeEventListener(Event.COMPLETE,this.onComplete2);
         picture.x -= picture.width >> 1;
         picture.y -= picture.height >> 1;
      }
      
      private function completeHandler(param1:Event) : void
      {
         param1.target.loader.x -= int(param1.target.content.width / 2);
         param1.target.loader.y -= int(param1.target.content.height / 2);
      }
      
      private function handleRotateLeft(param1:Object) : void
      {
         playerRotDir = (this.playerRotDir + 7) % 8;
         this.playerView.previewPlayer.dir = PlayerItem.ROTATE_DIRS[this.playerRotDir];
      }
      
      private function handleRotateRight(param1:Object) : void
      {
         playerRotDir = (this.playerRotDir + 1) % 8;
         this.playerView.previewPlayer.dir = PlayerItem.ROTATE_DIRS[this.playerRotDir];
      }
      
      private function buyHairHandler(param1:Object) : void
      {
         var goldPrice:int;
         var gamePrice:int;
         if(this.payBlocked)
         {
            return;
         }
         goldPrice = this.hairs[this.curHairId].goldCost;
         gamePrice = this.hairs[this.curHairId].cost;
         if(this.avatarPal != this.curPalId)
         {
            goldPrice += this.changeHairColorCost;
         }
         if(this.money < goldPrice && this.gameMoney < gamePrice)
         {
            this.main.showNotifyMenu(getString("IDS_GPAY_ERROR_2"));
            return;
         }
         if(this.money < goldPrice)
         {
            this.main.showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         if(this.gameMoney < gamePrice)
         {
            this.main.showNotifyMenu(getString("IDS_GPAY_ERROR_1"));
            return;
         }
         payBlocked = true;
         this.main.socket.sendBuyHair(this.curHairId,this.curPalId);
      }
      
      private function selectHair(param1:int, param2:int) : void
      {
         var headingFormat:TextFormat;
         var descriptionFormat:TextFormat;
         var highlightFormat:TextFormat;
         var previewBackground:Sprite;
         var button:BaseButton;
         var hairMask:Shape;
         var playerContainer:Sprite;
         var goldPrice:int;
         var gamePrice:int;
         var label:TextField;
         var highlightStart:int;
         var paletteIndex:int;
         var bitmap:Bitmap;
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         headingFormat.align = TextFormatAlign.CENTER;
         descriptionFormat = new TextFormat();
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187041;
         descriptionFormat.size = 10;
         highlightFormat = new TextFormat();
         highlightFormat.font = "Verdana";
         highlightFormat.color = 13408825;
         highlightFormat.size = 10;
         highlightFormat.bold = true;
         infoMenu = new NUIComponent();
         addUIChild(this.infoMenu);
         this.infoMenu.draw(this.razdBmp,358,173);
         this.infoMenu.draw(this.razdBmp,358,283);
         this.infoMenu.addChild(createTextField(336,98,308,headingFormat,getString("IDS_PS_INFORMATION") + ":",18));
         previewBackground = new Sprite();
         updateBgUI(previewBackground,false,82,87);
         previewBackground.x = 391;
         previewBackground.y = 185;
         this.infoMenu.addChild(previewBackground);
         previewBackground = new Sprite();
         updateBgUI(previewBackground,false,82,87);
         previewBackground.x = 506;
         previewBackground.y = 185;
         this.infoMenu.addChild(previewBackground);
         button = new NButton(this.buyHairHandler,getBmp("ACCEPT_S"),getBmp("ACCEPT_S_OVER"),getBmp("ACCEPT_S_PRESSED"));
         button.x = 529;
         button.y = 293;
         this.infoMenuItems.push(button);
         this.infoMenu.addUIChild(button);
         hairMask = new Shape();
         hairMask.graphics.lineStyle(1,16711680);
         hairMask.graphics.beginFill(16777215);
         hairMask.graphics.drawRect(0,0,56,65);
         hairMask.graphics.endFill();
         hairMask.x = 404;
         hairMask.y = 190;
         this.infoMenu.addChild(hairMask);
         this.hairLoader.doAction849(this.hairPals[param1][param2],0);
         this.hairLoader.setPos(386,203);
         if(Client.currentCharacter.sex === Character.SEX_FEMALE)
         {
            this.hairLoader.x -= 6;
            this.hairLoader.y -= 5;
         }
         this.hairLoader.mask = hairMask;
         this.infoMenu.addChild(this.hairLoader);
         playerContainer = new Sprite();
         playerContainer.x = 547;
         playerContainer.y = 255;
         this.infoMenu.addChild(playerContainer);
         playerView = new PlayerPreview(this.main.player.type);
         this.playerView.previewPlayer.layerView[PlayerItem.HAIR_LAYER] = this.hairs[param1].viewId;
         if(this.main.player)
         {
            this.playerView.previewPlayer.layerView[PlayerItem.BODY_5] = this.main.player.layerView[PlayerItem.BODY_5];
            this.playerView.previewPlayer.layerView[PlayerItem.WEAPON_LAYER] = this.main.player.layerView[PlayerItem.WEAPON_LAYER];
            this.playerView.previewPlayer.layerView[PlayerItem.WEAPON_3] = this.main.player.layerView[PlayerItem.WEAPON_3];
            this.playerView.previewPlayer.layerView[PlayerItem.BODY_LAYER] = this.main.player.layerView[PlayerItem.BODY_LAYER];
         }
         else
         {
            this.playerView.previewPlayer.layerView[PlayerItem.BODY_5] = 0;
            this.playerView.previewPlayer.layerView[PlayerItem.WEAPON_LAYER] = 0;
            this.playerView.previewPlayer.layerView[PlayerItem.WEAPON_3] = 0;
            this.playerView.previewPlayer.layerView[PlayerItem.BODY_LAYER] = 0;
         }
         this.playerView.previewPlayer.layerView[PlayerItem.WEAPON_4] = 0;
         if(this.main.player)
         {
            this.playerView.previewPlayer.layerPal[PlayerItem.PANTS_LAYER] = this.main.player.layerPal[PlayerItem.PANTS_LAYER];
            this.playerView.previewPlayer.layerPal[PlayerItem.BODY_5] = this.main.player.layerPal[PlayerItem.BODY_5];
            this.playerView.previewPlayer.layerPal[PlayerItem.WEAPON_LAYER] = this.main.player.layerPal[PlayerItem.WEAPON_LAYER];
            this.playerView.previewPlayer.layerPal[PlayerItem.WEAPON_3] = this.main.player.layerPal[PlayerItem.WEAPON_3];
            this.playerView.previewPlayer.layerPal[PlayerItem.BODY_LAYER] = this.main.player.layerPal[PlayerItem.BODY_LAYER];
         }
         else
         {
            this.playerView.previewPlayer.layerPal[PlayerItem.PANTS_LAYER] = 0;
            this.playerView.previewPlayer.layerPal[PlayerItem.BODY_5] = 0;
            this.playerView.previewPlayer.layerPal[PlayerItem.WEAPON_LAYER] = 0;
            this.playerView.previewPlayer.layerPal[PlayerItem.WEAPON_3] = 0;
            this.playerView.previewPlayer.layerPal[PlayerItem.BODY_LAYER] = 0;
         }
         this.playerView.previewPlayer.layerPal[PlayerItem.HAIR_LAYER] = param2;
         this.playerView.previewPlayer.layerPal[PlayerItem.WEAPON_4] = 0;
         this.playerView.previewPlayer.dir = PlayerItem.ROTATE_DIRS[this.playerRotDir];
         this.playerView.previewPlayer.state = PlayerItem.stStand;
         playerContainer.addChild(this.playerView);
         this.addInfoDecButton(512,222,this.handleRotateLeft);
         this.addInfoAddButton(574,222,this.handleRotateRight);
         goldPrice = this.hairs[param1].goldCost;
         gamePrice = this.hairs[param1].cost;
         if(this.avatarPal != param2)
         {
            goldPrice += this.changeHairColorCost;
         }
         label = createTextField(357,117,300,descriptionFormat,getString("IDS_HAIR_COLOR"),18);
         highlightStart = label.text.length;
         label.appendText(" \"" + getString("IDS_HCOLOR_" + param2) + "\"");
         label.setTextFormat(highlightFormat,highlightStart,label.length);
         this.infoMenu.addChild(label);
         label = createTextField(357,135,300,descriptionFormat,getString("IDS_HAIR_COST"),18);
         highlightStart = label.text.length;
         if(goldPrice > 0)
         {
            label.appendText(" " + goldPrice.toString() + " " + getString("IDS_CREDS"));
         }
         if(gamePrice > 0)
         {
            label.appendText(" " + gamePrice.toString() + " " + getString("IDS_GAME_MONEY"));
         }
         if(highlightStart < label.text.length)
         {
            label.setTextFormat(highlightFormat,highlightStart,label.length);
         }
         this.infoMenu.addChild(label);
         this.infoMenu.addChild(createTextField(357,153,300,descriptionFormat,getString("IDS_PS_PRESS_ACCEPT"),18));
         label = createTextField(345,296,200,descriptionFormat,getString("IDS_PS_SERV_COST"),18);
         highlightStart = label.text.length;
         if(goldPrice > 0)
         {
            label.appendText(" " + goldPrice.toString() + " " + getString("IDS_CREDS"));
         }
         if(gamePrice > 0)
         {
            label.appendText(" " + gamePrice.toString() + " " + getString("IDS_GAME_MONEY"));
         }
         if(highlightStart < label.text.length)
         {
            label.setTextFormat(highlightFormat,highlightStart,label.length);
         }
         this.infoMenu.addChild(label);
         this.infoMenu.addChild(createTextField(19,331,308,headingFormat,getString("IDS_HCOLOR_HEADER"),18));
         paletteIndex = 0;
         while(paletteIndex < HAIR_PAL_COUNT)
         {
            if(paletteIndex == param2)
            {
               bitmap = getBmp("HCOLOR_SLOT_S_HL");
            }
            else
            {
               bitmap = getBmp("HCOLOR_SLOT_S");
            }
            button = new NButton(this.selectPalHandler,bitmap,bitmap,bitmap,bitmap);
            button.x = 31 + paletteIndex * 26;
            button.y = 349;
            button.value = paletteIndex;
            this.infoMenuItems.push(button);
            this.infoMenu.addUIChild(button);
            bitmap = getBmp("HAIR_COLOR_" + paletteIndex);
            bitmap.x = 35 + paletteIndex * 26;
            bitmap.y = 353;
            this.infoMenu.addChild(bitmap);
            paletteIndex++;
         }
      }
      
      private function selectPalHandler(param1:Object) : void
      {
         curPalId = param1.value;
         this.selectHair(this.curHairId,this.curPalId);
      }
      
      private function crateGRBalanceSprite(param1:int, param2:int) : void
      {
         var amountFormat:TextFormat;
         var labelFormat:TextFormat;
         var background:Sprite;
         amountFormat = new TextFormat();
         amountFormat.font = "Verdana";
         amountFormat.color = 13408825;
         amountFormat.size = 12;
         amountFormat.bold = true;
         amountFormat.align = TextFormatAlign.RIGHT;
         labelFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         background = new Sprite();
         updateBgUI(background,false,297,38);
         background.x = param1;
         background.y = param2;
         this.submenu.addChild(background);
         this.submenu.addChild(createTextField(param1 + 5,param2 + 1,200,labelFormat,getString("IDS_BALANCE"),18));
         moneyTF = createTextField(param1,param2 + 1,290,amountFormat,this.money.toString() + " " + getString("IDS_CREDS"),18);
         this.submenu.addChild(this.moneyTF);
         gameMoneyTF = createTextField(param1,param2 + 19,290,amountFormat,this.gameMoney.toString() + " " + getString("IDS_GAME_MONEY"),18);
         this.submenu.addChild(this.gameMoneyTF);
         moneyBmp = getBmp("V_GOLD");
         this.moneyBmp.y = param2 + 4;
         this.moneyBmp.x = this.moneyTF.x + this.moneyTF.width - this.moneyTF.textWidth - 17;
         gameMoneyBmp = getBmp("V_SILVER");
         this.gameMoneyBmp.y = param2 + 22;
         this.gameMoneyBmp.x = this.gameMoneyTF.x + this.gameMoneyTF.width - this.gameMoneyTF.textWidth - 17;
         this.submenu.addChild(this.moneyBmp);
         this.submenu.addChild(this.gameMoneyBmp);
      }
      
      private function createHairMenu() : void
      {
         var headingFormat:TextFormat;
         var rightFormat:TextFormat;
         var boldFormat:TextFormat;
         var hairScroll:ScrollSprite;
         var hairIndex:int;
         var hairPreview:HairstyleLoader;
         var hairButton:BaseButton;
         var hairFrame:NSprite;
         var unusedString:String;
         var closeButton:NButton;
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         headingFormat.align = TextFormatAlign.CENTER;
         rightFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.bold = true;
         rightFormat.align = TextFormatAlign.RIGHT;
         boldFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13408825;
         boldFormat.size = 12;
         boldFormat.bold = true;
         playerRotDir = 0;
         hairLoaders = new Array();
         hairButtons = new Array();
         this.createTabSubmenu();
         this.drawInk(this.submenu,19,91,308,227);
         this.drawInk(this.submenu,336,91,308,227);
         this.drawInkNoGrad(this.submenu,19,325,308,56);
         razdBmp = getBmp("RAZDELITEL2");
         this.submenu.draw(this.razdBmp,358,380);
         this.submenu.addChild(createTextField(19,98,308,headingFormat,getString("IDS_HAIRS") + ":",18));
         this.crateGRBalanceSprite(341,334);
         hairScroll = new ScrollSprite(291,193,4);
         hairScroll.x = 26;
         hairScroll.y = 114;
         this.submenuItems.push(hairScroll);
         this.submenu.addUIChild(hairScroll);
         hairIndex = 0;
         hairBg = getBmp("HAIR_SLOT_S");
         hairBgHl = getBmp("HAIR_SLOT_S_HL");
         hairIndex = 0;
         while(hairIndex < this.hairs.length)
         {
            hairFrame = new NSprite();
            hairFrame.draw(this.hairBg,0,0);
            hairButton = this.createDisplayBut(hairIndex % 5 * 56,int(hairIndex / 5) * 64,hairFrame,hairFrame,hairFrame,this.handleHairPress,hairIndex,hairScroll);
            hairScroll.addContent(hairButton);
            this.hairButtons.push(hairButton);
            hairPreview = new HairstyleLoader(this.main.userCharacter.sex,this.hairPals[hairIndex][0],0);
            if(this.main.userCharacter.sex === Character.SEX_MALE)
            {
               hairPreview.x = -16;
               hairPreview.y = 18;
            }
            else
            {
               hairPreview.x = -22;
               hairPreview.y = 8;
            }
            hairFrame.addChild(hairPreview);
            this.hairLoaders.push(hairPreview);
            hairIndex++;
         }
         hairScroll.init(hairScroll.uiContainer.height - 2);
         this.addNBut(20,392,getBmp("AVATARS_TAB"),getBmp("AVATARS_TAB_OVER"),getBmp("AVATARS_TAB_PRESSED"),this.handleSubTabPress,TAB_AVATARS);
         this.addNBut(178,392,getBmp("HAIRS_TAB"),getBmp("HAIRS_TAB_OVER"),getBmp("HAIRS_TAB_PRESSED"),this.handleSubTabPress,TAB_HAIR);
         closeButton = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(closeButton);
         this.submenu.addUIChild(closeButton);
      }
      
      private function handlePresentPress(param1:Object) : void
      {
         var weekIndex:int;
         var showWeekOptions:Boolean;
         var present:Object;
         this.presentSelector.visible = true;
         this.presentSelector.x = param1.x;
         this.presentSelector.y = param1.y;
         currentPresent = param1.value;
         present = this.presents[this.currentPresent];
         if(present.type == PresentItem.PT_ITEM_PRESENT && present.date > 0)
         {
            showWeekOptions = false;
            this.sigText.y = 151;
            this.signatureInput.y = 179;
            this.itemPresentDesc.text = formatString("IDS_HOLIDAY_DESC",present.date);
         }
         else
         {
            showWeekOptions = true;
            this.sigText.y = 171;
            this.signatureInput.y = 199;
         }
         this.itemPresentDesc.visible = !showWeekOptions;
         this.weekDescText.visible = showWeekOptions;
         this.anonimText.visible = showWeekOptions;
         this.anonymCheck.visible = showWeekOptions;
         this.anonymCheck.enabled = showWeekOptions;
         weekIndex = 0;
         while(weekIndex < this.weekButtons.length)
         {
            this.weekButtons[weekIndex].visible = showWeekOptions;
            this.weekButtons[weekIndex].enabled = showWeekOptions;
            weekIndex++;
         }
         switch(present.type)
         {
            case PresentItem.PT_NO_DELETE:
               this.signatureInput.visible = false;
               this.sigText.visible = false;
               this.cantDeleteText.visible = true;
               break;
            default:
               this.signatureInput.visible = true;
               this.sigText.visible = true;
               this.cantDeleteText.visible = false;
               break;
         }
         this.updatePresentCost();
      }
      
      private function handleAnonymCheck(param1:Object) : void
      {
         this.anonymCheck.checked = !this.anonymCheck.checked;
      }
      
      private function handleBuyPresent(param1:Object) : void
      {
         var present:Object;
         var presentCost:int;
         if(this.payBlocked)
         {
            return;
         }
         if(this.loginInput.text == "")
         {
            showNotifyMenu(_("IDS_SELECT_LOGIN_ER"));
            return;
         }
         if(this.currentPresent == -1)
         {
            showNotifyMenu(_("IDS_SELECT_PRESENT_ER"));
            return;
         }
         present = this.presents[this.currentPresent];
         presentCost = present.type == PresentItem.PT_ITEM_PRESENT ? present.cost[0] : present.cost[this.curWeek];
         if(present.currency == 0)
         {
            if(presentCost > this.gameMoney)
            {
               showNotifyMenu(getString("IDS_GPAY_ERROR_1"));
               return;
            }
         }
         else if(presentCost > this.money)
         {
            showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         payBlocked = true;
         this.main.socket.sendStr("bp|" + this.loginInput.text + "|" + this.currentPresent + "|" + (this.anonymCheck.checked ? "0|" : "1|") + this.curWeek + "|" + this.signatureInput.text + "|");
      }
      
      private function updatePresentCost() : void
      {
         var present:Object;
         var presentCost:int;
         if(this.currentPresent == -1)
         {
            this.costTF.text = "-";
         }
         else
         {
            present = this.presents[this.currentPresent];
            presentCost = present.type == PresentItem.PT_ITEM_PRESENT ? present.cost[0] : present.cost[this.curWeek];
            this.costTF.text = presentCost + " " + _(present.currency == 0 ? "IDS_GAME_MONEY" : "IDS_CREDS");
         }
      }
      
      private function handleWeekChange(param1:Object) : void
      {
         updateBgUI(this.weekButtons[this.curWeek].upState,false,16,16,this.weekButtons[this.curWeek].textField1);
         curWeek = param1.value;
         updateBgUI(this.weekButtons[this.curWeek].upState,true,16,16,this.weekButtons[this.curWeek].textField1);
         this.updatePresentCost();
      }
      
      private function createWeekButton(param1:int, param2:int, param3:int) : BaseButton
      {
         var labelFormat:TextFormat;
         var background:Sprite;
         var label:TextField;
         var button:BaseButton;
         labelFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.bold = true;
         labelFormat.align = TextFormatAlign.CENTER;
         background = new Sprite();
         label = createTextField(0,-2,16,labelFormat,(param3 + 1).toString(),18);
         background.addChild(label);
         updateBgUI(background,param3 == this.curWeek,16,16,label);
         button = this.createDisplayBut(param1,param2,background,background,background,this.handleWeekChange,param3,this.submenu);
         button.textField1 = label;
         this.weekButtons.push(button);
         return button;
      }
      
      public function updateValues(param1:int, param2:int) : void
      {
         if(param1 != -1)
         {
            this.gameMoney = param1;
            if(this.gameMoneyTF)
            {
               this.gameMoneyTF.text = param1.toString() + " " + getString("IDS_GAME_MONEY");
               this.gameMoneyBmp.x = this.gameMoneyTF.x + this.gameMoneyTF.width - this.gameMoneyTF.textWidth - 17;
            }
         }
         if(param2 != -1)
         {
            money = param2;
            if(this.moneyTF)
            {
               this.moneyTF.text = this.money.toString() + " " + getString("IDS_CREDS");
               if(this.moneyBmp)
               {
                  this.moneyBmp.x = this.moneyTF.x + this.moneyTF.width - this.moneyTF.textWidth - 17;
               }
            }
         }
      }
      
      private function createPresentMenu() : void
      {
         var headingFormat:TextFormat;
         var rightFormat:TextFormat;
         var boldFormat:TextFormat;
         var smallCenteredFormat:TextFormat;
         var smallBoldFormat:TextFormat;
         var smallFormat:TextFormat;
         var captionFormat:TextFormat;
         var mutedCaptionFormat:TextFormat;
         var mutedSmallFormat:TextFormat;
         var contentY:int;
         var groupSpacing:int;
         var gradientMatrix:Matrix;
         var groupData:Object;
         var highlightStart:int;
         var highlightEnd:int;
         var closeButton:NButton;
         var rowCount:int;
         var itemIndex:int;
         var presentData:Object;
         var background:Sprite;
         var picture:Picture;
         var presentButton:BaseButton;
         if(!this.presentsLoaded)
         {
            GameSocket.socket.getPaidPresents();
            return;
         }
         weekButtons = new Array();
         currentPresent = -1;
         curWeek = 0;
         this.createTabSubmenu();
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         headingFormat.align = TextFormatAlign.CENTER;
         rightFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.bold = true;
         rightFormat.align = TextFormatAlign.RIGHT;
         boldFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13408825;
         boldFormat.size = 12;
         boldFormat.bold = true;
         smallCenteredFormat = new TextFormat();
         smallCenteredFormat.font = "Verdana";
         smallCenteredFormat.color = 13408825;
         smallCenteredFormat.size = 10;
         smallCenteredFormat.bold = true;
         smallCenteredFormat.align = TextFormatAlign.CENTER;
         smallBoldFormat = new TextFormat();
         smallBoldFormat.font = "Verdana";
         smallBoldFormat.color = 13408825;
         smallBoldFormat.size = 10;
         smallBoldFormat.bold = true;
         smallFormat = new TextFormat();
         smallFormat.font = "Verdana";
         smallFormat.color = 13408825;
         smallFormat.size = 10;
         captionFormat = new TextFormat();
         captionFormat.font = "Verdana";
         captionFormat.color = 13408825;
         captionFormat.size = 9;
         mutedCaptionFormat = new TextFormat();
         mutedCaptionFormat.font = "Verdana";
         mutedCaptionFormat.color = 10187041;
         mutedCaptionFormat.size = 9;
         mutedSmallFormat = new TextFormat();
         mutedSmallFormat.font = "Verdana";
         mutedSmallFormat.color = 10187041;
         mutedSmallFormat.size = 10;
         this.drawInk(this.submenu,19,91,447,275);
         this.drawInk(this.submenu,477,91,167,275);
         presentsScroll = new ScrollSprite(431,263,16);
         this.presentsScroll.setPos(27,98);
         this.submenuItems.push(this.presentsScroll);
         this.submenu.addUIChild(this.presentsScroll);
         contentY = 0;
         groupSpacing = 10;
         gradientMatrix = new Matrix();
         gradientMatrix.createGradientBox(PRESENT_CELL_WIDTH / 2,PRESENT_CELL_HEIGHT / 2,Math.PI / 2);
         for each(groupData in this.array96)
         {
            rowCount = (groupData.presents.length - 1) / 4 + 1;
            this.presentsScroll.addLine(createTextField(0,contentY,431,headingFormat,groupData.title,18));
            contentY += 22;
            gradientMatrix.ty += 6;
            itemIndex = 0;
            while(itemIndex < rowCount)
            {
               this.presentsScroll.uiContainer.graphics.beginGradientFill(GradientType.LINEAR,[3092271,2236962],[1,1],[0,255],gradientMatrix);
               this.presentsScroll.uiContainer.graphics.drawRect(0,gradientMatrix.ty + 1,PRESENT_CELL_WIDTH,PRESENT_CELL_HEIGHT - 1);
               this.presentsScroll.uiContainer.graphics.endFill();
               this.presentsScroll.uiContainer.graphics.beginFill(4013373);
               this.presentsScroll.uiContainer.graphics.drawRect(0,gradientMatrix.ty + 48,PRESENT_CELL_WIDTH,13);
               this.presentsScroll.uiContainer.graphics.endFill();
               gradientMatrix.ty += PRESENT_CELL_HEIGHT;
               itemIndex++;
            }
            gradientMatrix.ty += 16 + groupSpacing;
            itemIndex = 0;
            while(itemIndex < groupData.presents.length)
            {
               presentData = groupData.presents[itemIndex];
               background = new Sprite();
               background.graphics.beginFill(0,0);
               background.graphics.drawRect(0,0,PRESENT_WIDTH,PRESENT_CELL_HEIGHT);
               background.graphics.endFill();
               picture = new Picture(null);
               picture.x = PRESENT_WIDTH >> 1;
               picture.y = 24;
               picture.addEventListener(Event.COMPLETE,this.onComplete2);
               picture.id = "icons/presents/p" + presentData.image + ".png";
               background.addChild(picture);
               presentButton = this.createDisplayBut(itemIndex % 4 * PRESENT_WIDTH,contentY,background,background,background,this.handlePresentPress,presentData.id,this.presentsScroll);
               this.presentsScroll.addLine(createTextField(itemIndex % 4 * PRESENT_WIDTH + 1,contentY + 45,105,captionFormat,presentData.name,18));
               this.presentsScroll.addContent(presentButton);
               itemIndex++;
               if(itemIndex % 4 == 0 && itemIndex < groupData.presents.length - 1)
               {
                  contentY += PRESENT_CELL_HEIGHT;
               }
            }
            contentY += PRESENT_CELL_HEIGHT + groupSpacing;
         }
         contentY -= groupSpacing;
         presentSelector = getBmp("GIFT_RAMKA");
         this.presentSelector.visible = false;
         this.presentsScroll.addLine(this.presentSelector);
         this.presentsScroll.uiContainer.height = contentY;
         this.presentsScroll.init(contentY);
         this.submenu.addChild(createTextField(477,91,167,headingFormat,getString("IDS_PRESENT_OPTIONS"),18));
         this.submenu.addChild(createTextField(492,119,100,smallFormat,getString("IDS_TARGET"),18));
         anonimText = createTextField(492,151,100,smallFormat,getString("IDS_ANONYM") + ":",18);
         this.submenu.addChild(this.anonimText);
         itemPresentDesc = createTextField(489,243,150,mutedCaptionFormat,"",60);
         this.itemPresentDesc.wordWrap = true;
         this.itemPresentDesc.multiline = true;
         this.itemPresentDesc.visible = false;
         this.submenu.addChild(this.itemPresentDesc);
         sigText = createTextField(492,171,130,smallFormat,getString("IDS_PRESENT_SIG") + " ",44);
         highlightStart = this.sigText.text.length;
         this.sigText.multiline = true;
         this.sigText.wordWrap = true;
         this.sigText.appendText(getString("IDS_SIG_DESC"));
         highlightEnd = this.sigText.text.length;
         this.sigText.appendText(":");
         this.sigText.setTextFormat(mutedSmallFormat,highlightStart,highlightEnd);
         this.submenu.addChild(this.sigText);
         cantDeleteText = createTextField(492,171,137,smallCenteredFormat,getString("IDS_CANT_DELETE"),100);
         this.cantDeleteText.visible = false;
         this.cantDeleteText.wordWrap = true;
         this.cantDeleteText.multiline = true;
         this.submenu.addChild(this.cantDeleteText);
         weekDescText = createTextField(492,264,100,smallFormat,getString("IDS_PRES_LIVETIME") + " ",44);
         highlightStart = this.weekDescText.text.length;
         this.weekDescText.multiline = true;
         this.weekDescText.wordWrap = true;
         this.weekDescText.appendText(getString("IDS_PRES_WEEK"));
         highlightEnd = this.weekDescText.text.length;
         this.weekDescText.appendText(":");
         this.weekDescText.setTextFormat(mutedSmallFormat,highlightStart,highlightEnd);
         this.submenu.addChild(this.weekDescText);
         anonymCheck = this.createCheckBox(620,154,this.handleAnonymCheck,0,this.submenu);
         this.submenu.addUIChild(this.anonymCheck);
         this.submenu.addChild(createTextField(492,294,100,smallFormat,getString("IDS_PS_SERV_COST"),18));
         loginInput = createTextInput(489,133,143);
         this.loginInput.maxChars = 16;
         if(this.presentLogin != "")
         {
            this.loginInput.text = this.presentLogin;
         }
         this.submenu.addUIChild(this.loginInput);
         signatureInput = createTextInput(489,199,143);
         this.signatureInput.multiline = true;
         this.signatureInput.wordWrap = true;
         this.signatureInput.height = 58;
         this.submenu.addUIChild(this.signatureInput);
         background = new Sprite();
         updateBgUI(background,false,143,16);
         background.x = 489;
         background.y = 312;
         this.submenu.addChild(background);
         costTF = createTextField(489,310,140,rightFormat,"-",18);
         this.submenu.addChild(this.costTF);
         this.submenu.addUIChild(this.createWeekButton(588,263,0));
         this.submenu.addUIChild(this.createWeekButton(608,263,1));
         this.submenu.addUIChild(this.createWeekButton(588,282,2));
         this.submenu.addUIChild(this.createWeekButton(608,282,3));
         this.crateGRBalanceSprite(28,377);
         this.addNBut(507,338,getBmp("GIFT_BTN"),getBmp("GIFT_BTN_OVER"),getBmp("GIFT_BTN_PRESSED"),this.handleBuyPresent);
         closeButton = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(closeButton);
         this.submenu.addUIChild(closeButton);
         this.updatePresentCost();
      }
      
      private function showAvatarSubmenu() : void
      {
         var headingFormat:TextFormat;
         var descriptionFormat:TextFormat;
         var priceFormat:TextFormat;
         var acceptButton:BaseButton;
         var gamePrice:int;
         var goldPrice:int;
         var label:TextField;
         var priceStart:int;
         if(this.infoMenu)
         {
            this.clearInfoMenuItems();
         }
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         headingFormat.align = TextFormatAlign.CENTER;
         descriptionFormat = new TextFormat();
         descriptionFormat.font = "Verdana";
         descriptionFormat.color = 10187041;
         descriptionFormat.size = 10;
         priceFormat = new TextFormat();
         priceFormat.font = "Verdana";
         priceFormat.color = 13408825;
         priceFormat.size = 10;
         priceFormat.bold = true;
         infoMenu = new NUIComponent();
         addUIChild(this.infoMenu);
         this.drawInk(this.infoMenu,354,141,94,122);
         this.infoMenu.draw(this.razdBmp,358,122);
         this.infoMenu.draw(this.razdBmp,358,283);
         this.infoMenu.addChild(createTextField(336,98,308,headingFormat,getString("IDS_PS_INFORMATION") + ":",18));
         acceptButton = new NButton(this.buyAvatarHandler,getBmp("ACCEPT_S"),getBmp("ACCEPT_S_OVER"),getBmp("ACCEPT_S_PRESSED"));
         acceptButton.x = 529;
         acceptButton.y = 293;
         this.infoMenuItems.push(acceptButton);
         this.infoMenu.addUIChild(acceptButton);
         gamePrice = this.avatars[this.currentAvatar].cost;
         goldPrice = this.avatars[this.currentAvatar].goldCost;
         label = createTextField(466,155,180,descriptionFormat,getString("IDS_PS_AVATAR"),60);
         label.wordWrap = true;
         priceStart = label.text.length;
         if(goldPrice > 0)
         {
            label.appendText(" " + goldPrice.toString() + " " + getString("IDS_CREDS"));
         }
         if(gamePrice > 0)
         {
            label.appendText(" " + gamePrice.toString() + " " + getString("IDS_GAME_MONEY"));
         }
         if(priceStart < label.text.length)
         {
            label.setTextFormat(priceFormat,priceStart,label.length);
         }
         this.infoMenu.addChild(label);
         label = createTextField(466,223,180,descriptionFormat,getString("IDS_PS_PRESS_ACCEPT"),44);
         label.wordWrap = true;
         this.infoMenu.addChild(label);
         label = createTextField(345,296,200,descriptionFormat,getString("IDS_PS_SERV_COST"),18);
         priceStart = label.text.length;
         if(goldPrice > 0)
         {
            label.appendText(" " + goldPrice.toString() + " " + getString("IDS_CREDS"));
         }
         if(gamePrice > 0)
         {
            label.appendText(" " + gamePrice.toString() + " " + getString("IDS_GAME_MONEY"));
         }
         if(priceStart < label.text.length)
         {
            label.setTextFormat(priceFormat,priceStart,label.length);
         }
         this.infoMenu.addChild(label);
         this.updateAvatar();
      }
      
      private function buyAvatarHandler(param1:Object) : void
      {
         if(this.gameMoney < this.avatars[this.currentAvatar].cost)
         {
            showNotifyMenu(getString("IDS_GPAY_ERROR_1"));
            return;
         }
         if(this.money < this.avatars[this.currentAvatar].goldCost)
         {
            showNotifyMenu(getString("IDS_PAY_ERROR_0"));
            return;
         }
         GameSocket.socket.buyAvatar(this.avatars[this.currentAvatar].avatarImg);
      }
      
      private function handleAvatarPress(param1:Object) : void
      {
         this.avatarSelector.x = param1.x - 3;
         this.avatarSelector.y = param1.y - 4;
         this.avatarSelector.visible = true;
         currentAvatar = param1.value;
         this.showAvatarSubmenu();
      }
      
      private function updateAvatar() : void
      {
         if(this.selectedTab == TAB_AVATARS && this.infoMenu && this.currentAvatar != -1 && this.avatars[this.currentAvatar].ldr.content)
         {
            this.infoMenu.draw(this.avatars[this.currentAvatar].ldr.content,360,147);
         }
      }
      
      private function createAvatarMenu() : void
      {
         var headingFormat:TextFormat;
         var avatarScroll:ScrollSprite;
         var avatarIndex:int;
         var avatarFrame:NSprite;
         var avatarButton:BaseButton;
         var frameBitmap:Bitmap;
         var closeButton:NButton;
         currentAvatar = -1;
         headingFormat = new TextFormat();
         headingFormat.font = "Verdana";
         headingFormat.color = 13408825;
         headingFormat.size = 12;
         headingFormat.bold = true;
         headingFormat.align = TextFormatAlign.CENTER;
         playerRotDir = 0;
         hairLoaders = new Array();
         hairButtons = new Array();
         this.createTabSubmenu();
         this.drawInk(this.submenu,19,91,308,290);
         this.drawInk(this.submenu,336,91,308,227);
         razdBmp = getBmp("RAZDELITEL2");
         this.submenu.draw(this.razdBmp,358,380);
         this.submenu.addChild(createTextField(19,98,308,headingFormat,getString("IDS_AVATARS") + ":",18));
         this.crateGRBalanceSprite(341,334);
         avatarScroll = new ScrollSprite(283,259,4);
         avatarScroll.x = 34;
         avatarScroll.y = 114;
         this.submenuItems.push(avatarScroll);
         this.submenu.addUIChild(avatarScroll);
         avatarIndex = 0;
         frameBitmap = getBmp("SILVER_FRAME");
         avatarIndex = 0;
         while(avatarIndex < this.avatars.length)
         {
            avatarFrame = new NSprite();
            avatarFrame.draw(frameBitmap,0,0);
            this.avatars[avatarIndex].ldr.x = 1;
            this.avatars[avatarIndex].ldr.y = 1;
            avatarFrame.addChild(this.avatars[avatarIndex].ldr);
            avatarButton = this.createDisplayBut(3 + avatarIndex % 5 * 54,4 + int(avatarIndex / 5) * 66,avatarFrame,avatarFrame,avatarFrame,this.handleAvatarPress,avatarIndex,avatarScroll);
            avatarScroll.addContent(avatarButton);
            avatarIndex++;
         }
         avatarSelector = getBmp("AVA_RAMKA");
         this.avatarSelector.visible = false;
         avatarScroll.addLine(this.avatarSelector);
         avatarScroll.init();
         this.addNBut(20,392,getBmp("AVATARS_TAB"),getBmp("AVATARS_TAB_OVER"),getBmp("AVATARS_TAB_PRESSED"),this.handleSubTabPress,TAB_AVATARS);
         this.addNBut(178,392,getBmp("HAIRS_TAB"),getBmp("HAIRS_TAB_OVER"),getBmp("HAIRS_TAB_PRESSED"),this.handleSubTabPress,TAB_HAIR);
         closeButton = createSimpleButton(544,390,getString("IDS_TO_CLOSE"),onClose);
         this.submenuItems.push(closeButton);
         this.submenu.addUIChild(closeButton);
      }
   }
}

import game.Character;
import ui.GameBitmap;

class HairstyleLoader extends GameBitmap
{
   
   public function HairstyleLoader(param1:int, param2:uint, param3:uint)
   {
      super();
      str33 = param1 === Character.SEX_MALE ? "m" : "f";
      doAction849(param2,param3);
   }
}
