package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import ui.menus.TerminalSubmenu;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.Client;
   
   public class TerminalMenu extends NuclearMenu
   {
      
      public static var TERMINAL_MENU_WIDTH:int = 626;
      
      public static var TERMINAL_MENU_HEIGHT:int = 336;
      
      public static var ICON_WIDTH:int = 70;
      
      public static var ICON_X_OFS:int = 60;
      
      public static const TYPE_MAIN:int = 0;
      
      public static const TYPE_CLAN:int = 1;
      
      public static const TYPE_HIRE:int = 2;
      
      public static const TYPE_RAID:int = 3;
      
      public static var ICONS_SCREEN:int = 4;
      
      public var items:Array;
      
      public var iconCount:int = 4;
      
      private var socket:GameSocket;
      
      private var terminal:Terminal;
      
      private var pageCount:int = 0;
      
      private var iconBmp:Array;
      
      private var iconOverBmp:Array;
      
      private var menuIds:Array;
      
      private var pageId:int = 0;
      
      private var pageTextField:TextField;
      
      private var iconButtons:Array = new Array();
      
      private var iconText:Array = new Array();
      
      public var type:int;
      
      public function TerminalMenu(param1:int, param2:Object)
      {
         super();
         dragable = false;
         this.socket = GameSocket.socket;
         this.terminal = Terminal.instance;
         this.type = param1;
         draw(getBmp("GERB_SPR"),12,3);
         var boldFormat:TextFormat = new TextFormat();
         boldFormat.font = "Verdana";
         boldFormat.color = 13408825;
         boldFormat.bold = true;
         boldFormat.size = 12;
         var normalFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 12;
         var smallFormat:TextFormat = new TextFormat();
         smallFormat.font = "Verdana";
         smallFormat.color = 13408825;
         smallFormat.size = 9;
         var centeredBoldFormat:TextFormat = new TextFormat();
         centeredBoldFormat.font = "Verdana";
         centeredBoldFormat.color = 13408825;
         centeredBoldFormat.bold = true;
         centeredBoldFormat.size = 12;
         centeredBoldFormat.align = TextFormatAlign.CENTER;
         var centeredFormat:TextFormat = new TextFormat();
         centeredFormat.font = "Verdana";
         centeredFormat.color = 13408825;
         centeredFormat.size = 12;
         centeredFormat.align = TextFormatAlign.CENTER;
         switch(param1)
         {
            case TYPE_MAIN:
               this.iconBmp = [uiContainer["ICON_EVENT"],uiContainer["ICON_EXCHANGE"],uiContainer["ICON_QUEST"],uiContainer["ICON_EXIT"],uiContainer["ICON_RLS"],uiContainer["ICON_CLAN"],uiContainer["ICON_CLAN_ATTACK"],uiContainer["ICON_NAYM"],uiContainer["ICON_RAIDS"],uiContainer["ICON_POLITICS"]];
               this.iconOverBmp = [uiContainer["ICON_EVENT_OVER"],uiContainer["ICON_EXCHANGE_OVER"],uiContainer["ICON_QUEST_OVER"],uiContainer["ICON_EXIT_OVER"],uiContainer["ICON_RLS_OVER"],uiContainer["ICON_CLAN_OVER"],uiContainer["ICON_CLAN_ATTACK_OVER"],uiContainer["ICON_NAYM_OVER"],uiContainer["ICON_RAIDS_OVER"],uiContainer["ICON_POLITICS_OVER"]];
               this.menuIds = [Client.TM_MENU_REQUEST_ZONES,Client.TM_MENU_EXCHANGE,Client.TM_MENU_LOCATIONS,Client.TM_EXIT,Client.TM_MENU_RLS,Client.TM_MENU_CLAN,Client.TM_MENU_ATTACK_ZONES,Client.TM_SUBMENU_HIRE,Client.TM_MENU_RAID,TerminalSubmenu.TM_MENU_CLAN_23];
               break;
            case TYPE_CLAN:
               this.iconBmp = [uiContainer["ICON_CONTROL"],uiContainer["ICON_CLAN_PAYS"],uiContainer["ICON_MONEY"],uiContainer["ICON_CLAN_ATTACK"],uiContainer["ICON_POLITICS"],uiContainer["ICON_CLAN_WARS"]];
               this.iconOverBmp = [uiContainer["ICON_CONTROL_OVER"],uiContainer["ICON_CLAN_PAYS_OVER"],uiContainer["ICON_MONEY_OVER"],uiContainer["ICON_CLAN_ATTACK_OVER"],uiContainer["ICON_POLITICS_OVER"],uiContainer["ICON_CLAN_WARS_OVER"]];
               this.menuIds = [Client.TM_MENU_CLAN_CONTROL,Client.TM_MENU_CLAN_DUES,Client.TM_MENU_CLAN_MONEY,TerminalSubmenu.TM_MENU_CLAN_ZONES,TerminalSubmenu.TM_MENU_CLAN_26,TerminalSubmenu.TM_MENU_CLAN_25];
               break;
            case TYPE_HIRE:
               this.iconBmp = [uiContainer["ICON_SINGLE_NAYM"],uiContainer["ICON_CLAN_NAYM"]];
               this.iconOverBmp = [uiContainer["ICON_SINGLE_NAYM_OVER"],uiContainer["ICON_CLAN_NAYM_OVER"]];
               this.menuIds = [Client.TM_MENU_PRIVATE_HIRE,Client.TM_MENU_CLAN_HIRE];
               break;
            case TYPE_RAID:
               this.iconBmp = [uiContainer["ICON_RAID_JOIN"],uiContainer["ICON_RAID_CREATE"]];
               this.iconOverBmp = [uiContainer["ICON_RAID_JOIN_OVER"],uiContainer["ICON_RAID_CREATE_OVER"]];
               this.menuIds = [Client.TM_MENU_RAID_PARTIES,Client.TM_MENU_RAID_LOCS];
               break;
         }
         this.pageCount = 1;
         var iconsOnPage:int = 0;
         var menuIndex:int = 0;
         while(menuIndex < this.menuIds.length)
         {
            if(iconsOnPage == ICONS_SCREEN)
            {
               iconsOnPage = 0;
               ++this.pageCount;
            }
            iconsOnPage++;
            menuIndex++;
         }
         this.iconCount = this.menuIds.length;
         addChild(createTextField(0,9,TERMINAL_MENU_WIDTH,centeredBoldFormat,getString("IDS_TERM_NETWORK"),18));
         addChild(createTextField(0,27,TERMINAL_MENU_WIDTH,centeredFormat,getString("IDS_TERM_MAIN"),18));
         addChild(createTextField(491,9,135,smallFormat,getString("IDS_TERM_OS"),18));
         addChild(createTextField(491,27,135,smallFormat,getString("IDS_TERM_CORP"),18));
         drawRect(0,0,625,225,13408825);
         drawHLine(4,50,618,13408825);
         if(param1 == TYPE_MAIN)
         {
            this.pageTextField = createTextField(0,234,TERMINAL_MENU_WIDTH,centeredFormat,"-" + (this.pageId + 1).toString() + "-",18);
            addChild(this.pageTextField);
            addUIChild(createTextButton(526,234,"---->",this.nextPageHandler));
            addUIChild(createTextButton(0,234,"<----",this.prevPageHandler));
         }
         else
         {
            this.pageTextField = createTextField(0,234,526,centeredFormat,"-" + (this.pageId + 1).toString() + "-",18);
            addChild(this.pageTextField);
            addUIChild(createTextButton(526,234,getString("IDS_BACK"),this.closeBtnHandler));
            addUIChild(createTextButton(419,234,"---->",this.nextPageHandler));
            addUIChild(createTextButton(0,234,"<----",this.prevPageHandler));
         }
         this.updatePage();
      }
      
      public function updatePageCount() : void
      {
         pageCount = 1;
         var iconsOnPage:int = 0;
         var menuIndex:int = 0;
         while(menuIndex < this.menuIds.length)
         {
            iconsOnPage++;
            if(iconsOnPage == ICONS_SCREEN)
            {
               iconsOnPage = 0;
               ++this.pageCount;
            }
            menuIndex++;
         }
         if(this.pageId >= this.pageCount)
         {
            pageId = this.pageCount - 1;
         }
         this.updatePage();
      }
      
      private function closeBtnHandler(param1:Object) : void
      {
         closeHandler();
      }
      
      private function removeIcons() : void
      {
         var iconButton:Object = null;
         var iconLabel:Object = null;
         while(this.iconButtons.length > 0)
         {
            iconButton = this.iconButtons.pop();
            iconButton.dispose();
            removeChild(DisplayObject(iconButton));
         }
         while(this.iconText.length > 0)
         {
            iconLabel = this.iconText.pop();
            removeChild(DisplayObject(iconLabel));
         }
      }
      
      private function updatePage() : void
      {
         this.removeIcons();
         this.pageTextField.text = "-" + (this.pageId + 1) + "-";
         var pageIndex:int = 0;
         var firstMenuIndex:int = 0;
         var iconsOnPage:int = 0;
         while(pageIndex < this.pageId)
         {
            iconsOnPage++;
            if(iconsOnPage == ICONS_SCREEN)
            {
               iconsOnPage = 0;
               pageIndex++;
            }
            firstMenuIndex++;
         }
         iconsOnPage = 0;
         var menuIndex:int = firstMenuIndex;
         while(menuIndex < this.menuIds.length && iconsOnPage < ICONS_SCREEN)
         {
            iconsOnPage++;
            menuIndex++;
         }
         var startX:int = (TERMINAL_MENU_WIDTH - (ICON_WIDTH + ICON_X_OFS) * iconsOnPage + ICON_X_OFS) / 2;
         menuIndex = firstMenuIndex;
         var iconIndex:int = 0;
         var iconButton:NButton;
         while(iconIndex < iconsOnPage)
         {
            iconButton = this.addIconButton(this.iconBmp[menuIndex],this.iconOverBmp[menuIndex],startX + iconIndex * (ICON_WIDTH + ICON_X_OFS),85,this.menuIds[menuIndex]);
            iconIndex++;
            if(!this.terminal.menuAvaible(this.menuIds[menuIndex]))
            {
               iconButton.enabled = false;
            }
            menuIndex++;
         }
      }
      
      private function nextPageHandler(param1:Object) : void
      {
         if(this.pageId < this.pageCount - 1)
         {
            ++this.pageId;
            this.updatePage();
         }
      }
      
      private function prevPageHandler(param1:Object) : void
      {
         if(this.pageId > 0)
         {
            --this.pageId;
            this.updatePage();
         }
      }
      
      override public function dispose() : void
      {
         this.removeIcons();
         super.dispose();
      }
      
      override public function createMenu() : void
      {
         create(TERMINAL_MENU_WIDTH,TERMINAL_MENU_HEIGHT,false,0);
      }
      
      public function addIconButton(param1:Class, param2:Class, param3:int, param4:int, param5:int) : NButton
      {
         var iconBitmap:Bitmap = new param1();
         var button:NButton = new NButton(this.onIconPress,iconBitmap,new param2(),iconBitmap,iconBitmap);
         button.object = this;
         button.value = param5;
         button.x = param3;
         button.y = param4;
         this.iconButtons.push(button);
         addUIChild(button);
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         labelFormat.align = TextFormatAlign.CENTER;
         var label:TextField = createTextField(param3 - 20,param4 + 78,ICON_WIDTH + 40,labelFormat,_("IDS_TERM_ICO_" + param5),50);
         label.wordWrap = true;
         this.iconText.push(label);
         addChild(label);
         return button;
      }
      
      public function onIconPress(param1:Object) : void
      {
         closeHandler();
         switch(param1.value)
         {
            case Client.TM_EXIT:
               this.socket.sendClanZonesRequest();
               break;
            case Client.TM_MENU_INVENTORY:
               this.socket.getInventory();
               break;
            default:
               this.terminal.createMenu(param1.value);
               break;
         }
      }
   }
}

