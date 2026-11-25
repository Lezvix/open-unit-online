package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import core.display.BmpTextField;
   import core.ui.UIElement;
   import ui.menus.*;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.KeyboardEvent;
   import flash.geom.*;
   import flash.ui.Keyboard;
   import flash.utils.*;
   import game.*;
   import mx.utils.StringUtil;
   
   public class Terminal extends NUIComponent
   {
      
      public static var instance:Terminal;
      
      public static const GA_ADD_CLAN_16:int = 16;
      
      protected static const GA_ADD_CLAN_USERS:int = 0;
      
      public static const GA_SHOW_CLAN:int = 1;
      
      public static const TYPE_2:int = 2;
      
      public static const TYPE_CLAN:int = 3;
      
      public static const GA_HIRE_PEOPLE:int = 5;
      
      protected static const GA_HIRE_6:int = 6;
      
      protected static const GA_HIRE_7:int = 7;
      
      protected static const GA_HIRE_8:int = 8;
      
      protected static const GA_HIRE_9:int = 9;
      
      protected static const nTextFormat3:NTextFormat = NTextFormat.input.derive({"color":14659426});
      
      protected static const nTextFormat4:NTextFormat = NTextFormat.input.derive({"color":16771509});
      
      protected static const MESSAGE_COLORS:Array = [nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3.derive({"color":6273841}),nTextFormat3.derive({"color":16737792}),nTextFormat3.derive({"color":6467542}),nTextFormat3,nTextFormat3.derive({"color":12728380})];
      
      public static const CHANNEL_CLAN:int = 44;
      
      public static const CHANNEL_2:int = 2;
      
      public var showWelcom:Boolean = false;
      
      private var menuContainer:NUIComponent;
      
      private var menu:Object;
      
      private var _currentMenuId:int;
      
      private var terminalRadarAvailable:Boolean;
      
      private var main:Main;
      
      private var nuiComponent12:NUIComponent;
      
      private var nuiComponent17:NUIComponent;
      
      private var nuiComponent4:NUIComponent;
      
      private var nuiComponent14:NUIComponent;
      
      private var nuiComponent6:NUIComponent;
      
      private var nuiComponent20:NUIComponent;
      
      private var nuiComponent1:NUIComponent;
      
      private var nuiComponent8:NUIComponent;
      
      private var nuiComponent10:NUIComponent;
      
      private var nuiComponent9:NUIComponent;
      
      private var shape3:Shape;
      
      private var shape7:Shape;
      
      private var shape4:Shape;
      
      private var settingsBmp:Bitmap;
      
      private var settingsBmpOvr:Bitmap;
      
      private var settingsBmpPrs:Bitmap;
      
      private var cba6:Bitmap;
      
      protected const stringList2:Vector.<String> = new Vector.<String>();
      
      private var input:NTextInput;
      
      private var p1:NButton;
      
      private var p2:NButton;
      
      private var p3:NButton;
      
      private var m1:NButton;
      
      private var bmpTextField2:BmpTextField;
      
      private var bmpTextField1:BmpTextField;
      
      private const bmpLabelList1:Vector.<BmpLabel> = new Vector.<BmpLabel>(3,true);
      
      private const nButtonList2:Vector.<NButton> = new Vector.<NButton>(3,true);
      
      private const nButtonList3:Vector.<NButton> = new Vector.<NButton>(3,true);
      
      protected var userList:ChatUser;
      
      protected var nuiComponent2:NUIComponent;
      
      protected var nuiComponent18:NUIComponent;
      
      protected var newsTicker1:NewsTicker;
      
      protected var scrollSprite2:ScrollSprite;
      
      protected var channelsExpandButton:NButton;
      
      protected var channelsCollapseButton:NButton;
      
      protected var channelButtonList1:Vector.<ChannelButton>;
      
      protected var channels:Vector.<ChatLog>;
      
      public function Terminal(main:Main, stageWidth:int, stageHeight:int)
      {
         this.channelButtonList1 = new Vector.<ChannelButton>();
         this.channels = new Vector.<ChatLog>();
         super();
         instance = this;
         this.main = main;
         this.nuiComponent12 = new NUIComponent();
         this.nuiComponent17 = new NUIComponent();
         this.nuiComponent4 = new NUIComponent();
         this.nuiComponent14 = new NUIComponent();
         this.nuiComponent6 = new NUIComponent();
         this.nuiComponent20 = new NUIComponent();
         this.nuiComponent1 = new NUIComponent();
         this.nuiComponent8 = new NUIComponent();
         this.nuiComponent10 = new NUIComponent();
         this.nuiComponent9 = new NUIComponent();
         var cloc:Bitmap = getBmp("CLOCK_CENTER");
         var tla:Bitmap = getBmp("TERMINAL_LEFT_A");
         var tlb:Bitmap = getBmp("TERMINAL_LEFT_B");
         var tlc:Bitmap = getBmp("TERMINAL_LEFT_C");
         var tca:Bitmap = getBmp("TERMINAL_CENTER_A");
         var tcb:Bitmap = getBmp("TERMINAL_CENTER_B");
         var tra:Bitmap = getBmp("TERMINAL_RIGHT_A");
         var trb:Bitmap = getBmp("TERMINAL_RIGHT_B");
         var trc:Bitmap = getBmp("TERMINAL_RIGHT_C");
         var tcta:Bitmap = getBmp("TERMINAL_CENTER_TILE_A");
         var tlt:Bitmap = getBmp("TERMINAL_LEFT_TILE");
         var trt:Bitmap = getBmp("TERMINAL_RIGHT_TILE");
         var tctb:Bitmap = getBmp("TERMINAL_CENTER_TILE_B");
         var tctc:Bitmap = getBmp("TERMINAL_CENTER_TILE_C");
         var tctd:Bitmap = getBmp("TERMINAL_CENTER_TILE_D");
         var tcc:Bitmap = getBmp("TERMINAL_CENTER_C");
         var tcd:Bitmap = getBmp("TERMINAL_CENTER_D");
         var matrixc:Matrix = new Matrix();
         matrixc.translate(tla.width + tca.width + tcta.width + tcc.width + 107,419);
         var matrix1:Matrix = new Matrix();
         matrix1.translate(tla.width,0);
         var matrix2:Matrix = new Matrix();
         matrix2.translate(0,tla.height);
         var matrix3:Matrix = new Matrix();
         matrix3.translate(tla.width + tca.width,0);
         var matrix4:Matrix = new Matrix();
         matrix4.translate(tla.width + tca.width + tcta.width,0);
         var matrix44:Matrix = new Matrix();
         matrix44.translate(tla.width + tca.width + tcta.width + tcc.width,0);
         var matrix5:Matrix = new Matrix();
         matrix5.translate(tla.width,tla.height - tcb.height - 1);
         var matrix6:Matrix = new Matrix();
         matrix6.translate(tla.width + tcb.width,tla.height - tctb.height - 1);
         var matrix7:Matrix = new Matrix();
         matrix7.translate(tla.width + tcb.width + tctb.width,tla.height - tcd.height - 1);
         var matrix8:Matrix = new Matrix();
         matrix8.translate(0,tla.height + tlb.height);
         var matrix9:Matrix = new Matrix();
         matrix9.translate(0,tla.height + tlb.height + tlt.height - 23);
         var matrix10:Matrix = new Matrix();
         matrix10.translate(tla.width + tca.width + tcta.width + tcc.width,tra.height);
         var matrix11:Matrix = new Matrix();
         matrix11.translate(tla.width + tca.width + tcta.width + tcc.width,tra.height + trb.height);
         var matrix12:Matrix = new Matrix();
         matrix12.translate(tlc.width + tctc.width,tra.height + trb.height + trt.height - 23);
         var matrix13:Matrix = new Matrix();
         matrix13.translate(tlc.width,tla.height + tlb.height + tlt.height - 23);
         var matrix14:Matrix = new Matrix();
         matrix14.translate(tlc.width,tla.height + tlb.height + tlt.height + tlc.width - tctd.height);
         graphics.beginFill(0);
         graphics.drawRect(0,0,Client.MAX_STAGE_WIDTH,Client.MAX_STAGE_HEIGHT);
         graphics.beginBitmapFill(tla.bitmapData);
         graphics.drawRect(0,0,tla.width,tla.height);
         graphics.beginBitmapFill(tca.bitmapData,matrix1);
         graphics.drawRect(tla.width,0,tca.width,tca.height);
         graphics.beginBitmapFill(tlb.bitmapData,matrix2);
         graphics.drawRect(0,tla.height,tlb.width,tlb.height);
         graphics.beginBitmapFill(tcta.bitmapData,matrix3);
         graphics.drawRect(tla.width + tca.width,0,tcta.width,tcta.height);
         this.nuiComponent8.x = tlc.width;
         this.nuiComponent8.y = main.stageHeight - tlc.height;
         this.nuiComponent8.height = tctc.height;
         this.nuiComponent8.width = tctc.width;
         this.nuiComponent8.graphics.clear();
         this.nuiComponent8.graphics.beginBitmapFill(tctc.bitmapData);
         this.nuiComponent8.graphics.drawRect(0,0,tctc.width + 277,tctc.height);
         this.nuiComponent8.graphics.endFill();
         addChild(this.nuiComponent8);
         this.nuiComponent10.x = tlc.width;
         this.nuiComponent10.y = main.stageHeight - tctd.height;
         this.nuiComponent10.height = tctd.height;
         this.nuiComponent10.width = tctd.width;
         this.nuiComponent10.graphics.clear();
         this.nuiComponent10.graphics.beginBitmapFill(tctd.bitmapData);
         this.nuiComponent10.graphics.drawRect(0,0,tctd.width + 277,tctd.height);
         this.nuiComponent10.graphics.endFill();
         addChild(this.nuiComponent10);
         this.nuiComponent6.x = main.stageWidth - trt.width;
         this.nuiComponent6.y = tra.height + trb.height;
         this.nuiComponent6.height = main.stageHeight - tra.height - trb.height - trc.height;
         this.nuiComponent6.width = trb.width;
         this.nuiComponent6.graphics.clear();
         this.nuiComponent6.graphics.beginBitmapFill(trt.bitmapData);
         this.nuiComponent6.graphics.drawRect(0,0,trt.width,trt.height);
         this.nuiComponent6.graphics.endFill();
         addChild(this.nuiComponent6);
         this.nuiComponent1.x = 0;
         this.nuiComponent1.y = main.stageHeight - this.nuiComponent1.height;
         this.nuiComponent1.height = tlc.height;
         this.nuiComponent1.width = tlc.width;
         this.nuiComponent1.graphics.clear();
         this.nuiComponent1.graphics.beginBitmapFill(tlc.bitmapData);
         this.nuiComponent1.graphics.drawRect(0,0,tlc.width,tlc.height);
         this.nuiComponent1.graphics.endFill();
         addChild(this.nuiComponent1);
         this.nuiComponent12.x = tla.width + tca.width + tcta.width + tcc.width;
         this.nuiComponent12.y = 0;
         this.nuiComponent12.height = tra.height;
         this.nuiComponent12.width = tra.width;
         this.nuiComponent12.graphics.clear();
         this.nuiComponent12.graphics.beginBitmapFill(tra.bitmapData);
         this.nuiComponent12.graphics.drawRect(0,0,tra.width,tra.height);
         this.nuiComponent12.graphics.endFill();
         addChild(this.nuiComponent12);
         this.nuiComponent17.x = tla.width + tca.width + tcta.width;
         this.nuiComponent17.y = 0;
         this.nuiComponent17.height = tcc.height;
         this.nuiComponent17.width = tcc.width;
         this.nuiComponent17.graphics.clear();
         this.nuiComponent17.graphics.beginBitmapFill(tcc.bitmapData);
         this.nuiComponent17.graphics.drawRect(0,0,tcc.width,tcc.height);
         this.nuiComponent17.graphics.endFill();
         addChild(this.nuiComponent17);
         this.nuiComponent4.x = tla.width + tcb.width + tctb.width;
         this.nuiComponent4.y = tla.height - tcd.height - 1;
         this.nuiComponent4.height = tcd.height;
         this.nuiComponent4.width = tcd.width;
         this.nuiComponent4.graphics.clear();
         this.nuiComponent4.graphics.beginBitmapFill(tcd.bitmapData);
         this.nuiComponent4.graphics.drawRect(0,0,tcd.width,tcd.height);
         this.nuiComponent4.graphics.endFill();
         addChild(this.nuiComponent4);
         this.nuiComponent14.x = main.stageWidth - trb.width;
         this.nuiComponent14.y = tra.height;
         this.nuiComponent14.height = trb.height;
         this.nuiComponent14.width = trb.width;
         this.nuiComponent14.graphics.clear();
         this.nuiComponent14.graphics.beginBitmapFill(trb.bitmapData);
         this.nuiComponent14.graphics.drawRect(0,0,trb.width,trb.height);
         this.nuiComponent14.graphics.endFill();
         addChild(this.nuiComponent14);
         this.nuiComponent20.x = main.stageWidth - trc.width;
         this.nuiComponent20.y = main.stageHeight - trt.height;
         this.nuiComponent20.height = trc.height;
         this.nuiComponent20.width = trc.width;
         this.nuiComponent20.graphics.clear();
         this.nuiComponent20.graphics.beginBitmapFill(trc.bitmapData);
         this.nuiComponent20.graphics.drawRect(0,0,trc.width,trc.height);
         this.nuiComponent20.graphics.endFill();
         addChild(this.nuiComponent20);
         this.shape4 = new Shape();
         this.shape4.graphics.lineStyle(1,16777215);
         this.shape4.graphics.moveTo(0,0);
         this.shape4.graphics.lineTo(29,0);
         this.shape4.graphics.lineStyle(2,592137);
         this.shape4.graphics.moveTo(4,-2);
         this.shape4.graphics.lineTo(25,-2);
         this.shape4.graphics.lineStyle(2,592137);
         this.shape4.graphics.moveTo(4,2);
         this.shape4.graphics.lineTo(25,2);
         addChild(this.shape4);
         this.shape7 = new Shape();
         this.shape7.graphics.lineStyle(1,16711680);
         this.shape7.graphics.moveTo(0,0);
         this.shape7.graphics.lineTo(39,0);
         addChild(this.shape7);
         this.shape3 = new Shape();
         this.shape3.y = this.shape7.y = this.shape4.y = 423;
         this.shape3.graphics.lineStyle(1,16763904);
         this.shape3.graphics.moveTo(0,0);
         this.shape3.graphics.lineTo(41,0);
         addChild(this.shape3);
         this.nuiComponent9.x = main.stageWidth - tra.width + 107;
         this.nuiComponent9.y = 419;
         this.nuiComponent9.height = cloc.height;
         this.nuiComponent9.width = cloc.width;
         this.nuiComponent9.graphics.clear();
         this.nuiComponent9.graphics.beginBitmapFill(cloc.bitmapData);
         this.nuiComponent9.graphics.drawRect(0,0,cloc.width,cloc.height);
         this.nuiComponent9.graphics.endFill();
         addChild(this.nuiComponent9);
         graphics.beginBitmapFill(tcb.bitmapData,matrix5);
         graphics.drawRect(tla.width,tla.height - tcb.height,tcb.width,tcb.height);
         graphics.beginBitmapFill(tctb.bitmapData,matrix6);
         graphics.drawRect(tla.width + tcb.width,tla.height - tcb.height - 1,tctb.width,tctb.height);
         graphics.beginBitmapFill(tlt.bitmapData,matrix8);
         graphics.drawRect(0,tla.height + tlb.height,tlt.width,tlt.height - 23);
         graphics.beginBitmapFill(cloc.bitmapData,matrixc);
         graphics.drawRect(tla.width + tca.width + tcta.width + tcc.width + 107,419,cloc.width,cloc.height);
         graphics.endFill();
         this.p2 = new NButton(this.onSettingsClick,getBmp("SETTINGS_BUTTON"),getBmp("SETTINGS_BUTTON_OVER"),getBmp("SETTINGS_BUTTON_PRESSED"),getBmp("SETTINGS_BUTTON"));
         this.p2.y = 0;
         addUIChild(this.p2);
         this.p1 = new NButton(this.onExitClick,getBmp("EXIT_BUTTON"),getBmp("EXIT_BUTTON_OVER"),getBmp("EXIT_BUTTON_PRESSED"),getBmp("EXIT_BUTTON"));
         this.p1.y = 48;
         addUIChild(this.p1);
         this.p3 = new NButton(this.onCloseInventory,getBmp("TERM_ENTER_BUTTON"),getBmp("TERM_ENTER_BUTTON_OVER"),getBmp("TERM_ENTER_BUTTON_PRESSED"),getBmp("TERM_ENTER_BUTTON_PRESSED"));
         addUIChild(this.p3);
         this.input = new NTextInput(255,NTextFormat.input);
         this.input.x = 38;
         this.input.background = false;
         this.input.border = false;
         this.input.height = 18;
         this.input.textField.setPos(3,4);
         this.input.textField.textColor = 16771509;
         this.input.onKeyDown = this.onOnKeyDown;
         addUIChild(this.input);
         this.m1 = new NButton(this.terminalClick,getBmp("TERM_ENTER_BUTTON"),getBmp("TERM_ENTER_BUTTON_OVER"),getBmp("TERM_ENTER_BUTTON_PRESSED"));
         this.m1.setPos(454,415);
         addUIChild(this.m1);
         var bmp:Bitmap = getBmp("LETTERS_B");
         this.bmpTextField2 = new BmpTextField(70,10,bmp,"0123456789,.\\|/",1);
         this.bmpTextField2.setText("201");
         this.bmpTextField2.x = 351;
         this.bmpTextField2.y = 17;
         addChild(this.bmpTextField2);
         this.bmpTextField1 = new BmpTextField(70,10,bmp,"0123456789,.\\|/",1);
         this.bmpTextField1.setText("153\\324");
         this.bmpTextField1.x = 420;
         this.bmpTextField1.y = 17;
         addChild(this.bmpTextField1);
         bmp = getBmp("LETTERS_A");
         var i:int = 0;
         while(i < this.bmpLabelList1.length)
         {
            this.bmpLabelList1[i] = new BmpLabel(13,19,bmp,"0123456789/");
            this.bmpLabelList1[i].assign(0);
            this.bmpLabelList1[i].x = 330 + 43 * i;
            this.bmpLabelList1[i].y = 423;
            addChild(this.bmpLabelList1[i]);
            i++;
         }
         i = 0;
         while(i < this.nButtonList2.length)
         {
            bmp = getBmp("PLUS" + i + "_A");
            this.nButtonList2[i] = new NButton(this.onPlusClick,bmp,bmp,getBmp("PLUS" + i + "_B"));
            this.nButtonList2[i].value = i;
            this.nButtonList2[i].value1 = getBmp("PLUS" + i + "_C");
            this.nButtonList2[i].setPos(343 + 44 * i,411);
            addUIChild(this.nButtonList2[i]);
            bmp = getBmp("MINUS" + i + "_A");
            this.nButtonList3[i] = new NButton(this.onMinusClick,bmp,bmp,getBmp("MINUS" + i + "_B"));
            this.nButtonList3[i].value = i;
            this.nButtonList3[i].value1 = getBmp("MINUS" + i + "_C");
            this.nButtonList3[i].setPos(343 + 44 * i,433);
            addUIChild(this.nButtonList3[i]);
            this.nButtonList2[i].downHandler = function(param1:NButton):void
            {
               nButtonList3[param1.value].upState = nButtonList3[param1.value].value1 as DisplayObject;
            };
            this.nButtonList2[i].upHandler = function(param1:NButton):void
            {
               nButtonList3[param1.value].upState = nButtonList3[param1.value].overState;
            };
            this.nButtonList3[i].downHandler = function(param1:NButton):void
            {
               nButtonList2[param1.value].upState = nButtonList2[param1.value].value1 as DisplayObject;
            };
            this.nButtonList3[i].upHandler = function(param1:NButton):void
            {
               nButtonList2[param1.value].upState = nButtonList2[param1.value].overState;
            };
            i++;
         }
         this.nuiComponent2 = new NUIComponent();
         this.nuiComponent2.setPos(this.input.x + 5,494);
         addUIChild(this.nuiComponent2);
         this.channelsExpandButton = new NButton(this.onChannelsExpandClick,getBmp("CHANNELS_EXPAND_BUTTON"),getBmp("CHANNELS_EXPAND_BUTTON_OVER"));
         this.channelsExpandButton.visible = false;
         this.nuiComponent2.addUIChild(this.channelsExpandButton);
         this.channelsCollapseButton = new NButton(this.moveOut1,getBmp("CHANNELS_COLLAPSE_BUTTON"),getBmp("CHANNELS_COLLAPSE_BUTTON_OVER"));
         this.channelsCollapseButton.visible = false;
         this.nuiComponent2.addUIChild(this.channelsCollapseButton);
         this.nuiComponent18 = new NUIComponent();
         this.nuiComponent18.y = this.nuiComponent2.y + this.nuiComponent2.height + 1;
         this.nuiComponent18.graphics.lineStyle(1,6702080,0.7);
         this.nuiComponent18.graphics.beginFill(0);
         this.nuiComponent18.graphics.drawRect(0,0,204,150);
         this.nuiComponent18.graphics.endFill();
         this.nuiComponent18.disposeOnRemove = false;
         this.scrollSprite2 = new ScrollSprite(192,138);
         this.scrollSprite2.setPos(6,6);
         this.nuiComponent18.addUIChild(this.scrollSprite2);
         this.userList = new ChatUser(192,138);
         this.userList.y = 510;
         this.userList.nameClickHandler = this.handleChatInputKeyDown;
         this.userList.privateCallback = this.smileButtonClick;
         addUIChild(this.userList);
         this.addChannel(GA_ADD_CLAN_USERS,_("IDS_CHAT_CHANNEL_" + GA_ADD_CLAN_USERS),0,true);
         this.newsTicker1 = new NewsTicker();
         this.newsTicker1.y = 313;
         addChild(this.newsTicker1);
         this.menuContainer = new NUIComponent();
         this.menuContainer.y = 50;
         addUIChild(this.menuContainer);
         this.doAction155(stageWidth,stageHeight);
         processIntervalValue = 40;
         disposeOnRemove = false;
      }
      
      public function get radioMenu() : Object
      {
         return this.menu;
      }
      
      public function doAction759(param1:String) : void
      {
         this.doAction920(param1,true);
      }
      
      protected function onChannelsExpandClick(param1:NButton) : void
      {
         param1.visible = false;
         this.channelsCollapseButton.visible = true;
         if(contains(this.nuiComponent18))
         {
            removeUIChild(this.nuiComponent18);
         }
         this.scrollSprite2.clear();
         var visibleChannelCount:int = Math.max(1,Math.min(this.channels.length,this.nuiComponent2.width / (this.channelButtonList1[0].width + 1)));
         var channelIndex:int = visibleChannelCount;
         var channelButton:NButton;
         while(channelIndex < this.channels.length)
         {
            channelButton = new TextLinkButton(this.doAction540,this.channelButtonList1[channelIndex].label,this.scrollSprite2.width);
            channelButton.value = channelIndex;
            channelButton.y = (channelIndex - visibleChannelCount) * channelButton.height;
            this.scrollSprite2.addContent(channelButton);
            this.scrollSprite2.init((channelIndex - visibleChannelCount + 1) * channelButton.height);
            channelIndex++;
         }
         this.nuiComponent18.x = this.nuiComponent2.x + param1.x;
         this.nuiComponent18.visible = true;
         addUIChild(this.nuiComponent18);
      }
      
      protected function doAction540(param1:NButton) : void
      {
         var channelIndex:int = int(param1.value);
         var selectedButton:ChannelButton = this.channelButtonList1[channelIndex];
         var channelLog:ChatLog = this.channels[channelIndex];
         while(channelIndex > 1)
         {
            this.channelButtonList1[channelIndex] = this.channelButtonList1[channelIndex - 1];
            this.channels[channelIndex] = this.channels[channelIndex - 1];
            channelIndex--;
         }
         this.channelButtonList1[1] = selectedButton;
         this.channels[1] = channelLog;
         this.selectChannel(selectedButton);
         this.doAction78();
      }
      
      protected function moveOut1(param1:NButton) : void
      {
         param1.visible = false;
         this.channelsExpandButton.visible = true;
         this.nuiComponent18.visible = false;
      }
      
      protected function getString51() : String
      {
         var serverSeconds:int = ChatPanel.instance.serverTime;
         var hours:int = serverSeconds / 3600 % 24;
         var minutes:int = serverSeconds / 60 % 60;
         return (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes);
      }
      
      protected function addChannel(param1:int, param2:String, param3:int = -1, param4:Boolean = false) : ChatLog
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channel == param1)
            {
               if(param4)
               {
                  this.selectChannel(this.channels[channelIndex].channelButton);
               }
               return this.channels[channelIndex];
            }
            channelIndex++;
         }
         var closeButton:NButton = null;
         if(param1 != GA_ADD_CLAN_USERS)
         {
            closeButton = new NButton(this.onBack,getBmp("TERM_CHANNEL_CLOSE_BUTTON"),getBmp("TERM_CHANNEL_CLOSE_BUTTON_OVER"));
         }
         var newChannelButton:ChannelButton = new SmallChannelButton(this.selectChannel,param1,param2,closeButton);
         newChannelButton.y = 0;
         var channelLog:ChatLog = new ChatLog(this.channels.length > 0 ? this.channels[0].width : 300,this.userList.height,newChannelButton);
         channelLog.setPos(this.input.x + 8,this.userList.y);
         if(param3 >= 0 && param3 < this.channelButtonList1.length - 1)
         {
            this.channelButtonList1.splice(param3,0,newChannelButton);
            channelIndex = param3;
            while(channelIndex < this.channelButtonList1.length)
            {
               this.channelButtonList1[channelIndex].x = channelIndex > 0 ? this.channelButtonList1[channelIndex - 1].x + this.channelButtonList1[channelIndex - 1].width + 1 : 1;
               channelIndex++;
            }
            this.channels.splice(param3,0,channelLog);
         }
         else
         {
            this.channelButtonList1.push(newChannelButton);
            param3 = this.channelButtonList1.length - 1;
            newChannelButton.x = this.channelButtonList1.length > 1 ? this.channelButtonList1[param3 - 1].x + this.channelButtonList1[param3 - 1].width + 1 : 1;
            this.channels.push(channelLog);
         }
         this.nuiComponent2.addUIChild(newChannelButton);
         if(closeButton != null)
         {
            this.nuiComponent2.addUIChild(closeButton);
            closeButton.value = channelLog;
         }
         if(param4)
         {
            this.selectChannel(newChannelButton);
         }
         this.doAction78();
         return channelLog;
      }
      
      public function doAction604(param1:int, param2:String) : void
      {
         this.addChannel(-param1,param2,-1,true);
         this.updateUserList();
      }
      
      protected function onBack(param1:NButton) : void
      {
         this.doAction920(param1.value);
      }
      
      public function deleteAll() : void
      {
         this.doAction387();
      }
      
      public function doAction387(param1:* = null) : void
      {
         var userSessionId:int = 0;
         var user:UserList = null;
         if(param1 == null)
         {
            param1 = [];
            for each(user in this.userList.propValue120)
            {
               param1.push(user.sessionId);
            }
         }
         for each(userSessionId in param1)
         {
            if(userSessionId > 0)
            {
               this.doAction160(userSessionId);
            }
         }
      }
      
      public function doAction160(param1:int) : void
      {
         this.userList.doAction856(param1);
      }
      
      public function onExit(param1:UserList) : void
      {
         this.userList.onExit(param1);
      }
      
      protected function handleChatInputKeyDown(param1:NButton) : void
      {
         this.input.text = _("IDS_CHAT_TO",param1.value) + " " + this.input.text;
         this.updateUserList();
         this.input.moveCaretToEnd();
      }
      
      protected function smileButtonClick(param1:NButton) : void
      {
         GameSocket.socket.sendStr("po|" + param1.value);
      }
      
      public function updateUserList() : void
      {
         this.input.focus();
      }
      
      protected function onPlusClick(param1:NButton) : void
      {
         var digitIndex:int = int(param1.value);
         var digitValue:int = int(this.bmpLabelList1[digitIndex].getText());
         if(digitValue < 9)
         {
            this.bmpLabelList1[digitIndex].assign(digitValue + 1);
         }
      }
      
      protected function onMinusClick(param1:NButton) : void
      {
         var digitIndex:int = int(param1.value);
         var digitValue:int = int(this.bmpLabelList1[digitIndex].getText());
         if(digitValue > 0)
         {
            this.bmpLabelList1[digitIndex].assign(digitValue - 1);
         }
      }
      
      protected function onCloseInventory(param1:NButton) : void
      {
         this.doAction385();
      }
      
      protected function terminalClick(param1:NButton) : void
      {
         GameSocket.socket.sendFindUserByLogin(this.terminalNumber);
      }
      
      public function get terminalNumber() : int
      {
         var numberValue:int = int(this.bmpLabelList1[0].getText());
         numberValue *= 10;
         numberValue += int(this.bmpLabelList1[1].getText());
         numberValue *= 10;
         numberValue += int(this.bmpLabelList1[2].getText());
         return numberValue;
      }
      
      public function set radarMenuAvailable(available:Boolean) : void
      {
         terminalRadarAvailable = available;
      }
      
      public function set terminalNumber(param1:int) : void
      {
         this.bmpLabelList1[0].assign(int(param1 / 100));
         this.bmpLabelList1[1].assign(int(param1 / 10) % 10);
         this.bmpLabelList1[2].assign(param1 % 10);
         this.bmpTextField2.setText(this.bmpLabelList1[0].getText() + this.bmpLabelList1[1].getText() + this.bmpLabelList1[2].getText());
         this.channels[0].clear();
         this.deleteAll();
      }
      
      private function doAction611(param1:Array) : void
      {
         var user:UserList = UserList.parse(param1,1);
         user.timestamp = getTimer() + 1000 * 60 * 10;
         this.onExit(user);
      }
      
      protected function doAction385() : void
      {
         var inputText:String = this.input.text;
         var index:int;
         var recipient:String;
         this.input.text = "";
         if(inputText)
         {
            index = 0;
            while(index < this.stringList2.length)
            {
               if(this.stringList2[index] == inputText)
               {
                  this.stringList2.splice(index,1);
               }
               index++;
            }
            this.stringList2.push(inputText);
            if(this.stringList2.length > GA_ADD_CLAN_16)
            {
               this.stringList2.shift();
            }
            if(inputText.charAt(0) == "/" || inputText.charAt(0) == "?" && inputText.length > 1)
            {
               if(inputText.charAt(0) == "/")
               {
                  inputText = StringUtil.trim(inputText.slice(1));
               }
               else
               {
                  inputText = StringUtil.trim(inputText);
               }
               inputText = inputText.toLocaleLowerCase();
               if(inputText == "help")
               {
                  inputText = "?";
               }
               if(inputText.length > 0)
               {
                  if(inputText.length > 3 && inputText.search("pm ") == 0)
                  {
                     recipient = inputText.slice(3);
                     index = 0;
                     while(index < this.channels.length)
                     {
                        if(this.channels[index].channelButton.label.toLocaleLowerCase() == recipient)
                        {
                           this.selectChannel(this.channels[index].channelButton);
                           return;
                        }
                        index++;
                     }
                  }
                  GameSocket.socket.sendStr("sc|" + inputText);
               }
            }
            else
            {
               GameSocket.socket.sendStr("sg|" + this.propValue118 + "|" + inputText);
            }
         }
      }
      
      protected function get propValue118() : int
      {
         var index:int = 0;
         while(index < this.channelButtonList1.length)
         {
            if(this.channelButtonList1[index].toggled)
            {
               if(this.channelButtonList1[index].channel == GA_ADD_CLAN_USERS)
               {
                  switch(this.terminalNumber)
                  {
                     case CHANNEL_CLAN:
                        return TYPE_CLAN;
                     case CHANNEL_2:
                        return GA_HIRE_8;
                     default:
                        return GA_ADD_CLAN_USERS;
                  }
               }
               else
               {
                  return this.channelButtonList1[index].channel;
               }
            }
            index++;
         }
         return 0;
      }
      
      protected function onOnKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.doAction385();
         }
         else if(param1.keyCode == Keyboard.UP && this.stringList2.length > 0)
         {
            this.input.text = this.stringList2.pop();
            this.stringList2.unshift(this.input.text);
         }
         else if(param1.keyCode == Keyboard.DOWN && this.stringList2.length > 0)
         {
            this.input.text = this.stringList2[this.stringList2.length - 1];
            this.stringList2.push(this.stringList2.shift());
         }
         else if(param1.keyCode == Main.instance.getKey(Main.KEY_CHANGE_34))
         {
            Screenshot.doAction404();
         }
      }
      
      override protected function process() : void
      {
         var serverSeconds:Number = ChatPanel.instance.serverTime;
         var hours:int = serverSeconds / 3600 % 24;
         var minutes:int = serverSeconds / 60 % 60;
         var seconds:Number = serverSeconds % 60;
         this.shape7.rotation = (minutes + seconds / 60 - 15) / 60 * 360;
         this.shape4.rotation = (hours + minutes / 60 - 3) / 12 * 360;
         this.shape3.rotation = (seconds - 15) / 60 * 360;
         var currentTime:int = getTimer();
         var expiredSessions:Array;
         var index:int;
         if(this.terminalNumber == CHANNEL_2 && this.userList.propValue120.length > 0)
         {
            expiredSessions = [];
            index = 0;
            while(index < this.userList.propValue120.length)
            {
               if(this.userList.propValue120[index].timestamp < currentTime)
               {
                  expiredSessions.push(this.userList.propValue120[index].sessionId);
               }
               index++;
            }
            index = 0;
            while(index < expiredSessions.length)
            {
               this.userList.doAction856(expiredSessions[index]);
               index++;
            }
         }
      }
      
      private function onSettingsClick(param1:NButton) : void
      {
         var settingsMenu:SettingsMenu = this.main.getMenu(BaseMenu.TYPE_0) as SettingsMenu;
         if(settingsMenu == null)
         {
            this.main.showSettingsMenu();
         }
         else
         {
            settingsMenu.closeMenu();
         }
      }
      
      private function onExitClick(param1:NButton) : void
      {
         GameSocket.socket.sendClanZonesRequest();
      }
      
      public function get currentMenuId() : int
      {
         return this._currentMenuId;
      }
      
      public function doAction307(param1:int, param2:String, param3:Array) : void
      {
         if(!visible && param1 >= 0)
         {
            return;
         }
         var timeText:String = this.getString51();
         var index:int;
         var channelLog:ChatLog;
         if(param1 == GA_SHOW_CLAN || param1 == TYPE_2)
         {
            return;
         }
         if(param1 == GA_HIRE_7)
         {
            index = 0;
            while(index < this.channels.length)
            {
               if(this.channels[index].channelButton.toggled)
               {
                  this.channels[index].addText(timeText,param2,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_7]);
                  break;
               }
               index++;
            }
         }
         else if(param1 == GA_HIRE_6)
         {
            this.channels[0].addText(timeText,_("IDS_SYSTEM_MESSAGE"),this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[param2 == "1" ? GA_HIRE_PEOPLE : GA_HIRE_6]);
         }
         else if(param1 == GA_HIRE_PEOPLE)
         {
            this.channels[0].addText(timeText,_("IDS_CHAT_EVENT"),this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_PEOPLE]);
         }
         else if(param1 < 0)
         {
            channelLog = this.addChannel(param1,param2);
            channelLog.addText(timeText,param2,param3[0],param2 == Client.currentCharacter.name ? nTextFormat4 : nTextFormat3);
         }
         else if(param1 == GA_ADD_CLAN_USERS || param1 == TYPE_CLAN)
         {
            this.channels[0].addText(timeText,param2,param3[0],param2 == Client.currentCharacter.name ? nTextFormat4 : MESSAGE_COLORS[param1]);
         }
         else if(param1 == GA_HIRE_8 && this.terminalNumber == CHANNEL_2)
         {
            this.channels[0].addText(timeText,param2,param3[0],param2 == Client.currentCharacter.name ? nTextFormat4 : MESSAGE_COLORS[param1]);
         }
         else if(param1 == GA_HIRE_9)
         {
            this.channels[0].addLogText(timeText,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_9]);
         }
      }
      
      protected function formatSystemMessage(param1:String, param2:Array) : String
      {
         return Chat.prepareText(getString11("IDS_SYS_MSG_" + param1,param2));
      }
      
      protected function doAction920(param1:*, param2:Boolean = false) : void
      {
         var channelIndex:int = -1;
         var channelLabel:String;
         var index:int;
         var channelLog:ChatLog;
         var removedLabel:String;
         if(param1 is String)
         {
            channelLabel = param1.toString().toLocaleLowerCase();
            index = 0;
            while(index < this.channels.length)
            {
               if(this.channels[index].channelButton.label.toLocaleLowerCase() == channelLabel && (this.channels[index].channel < 0 || !param2))
               {
                  channelIndex = index;
                  break;
               }
               index++;
            }
         }
         else if(param1 is int)
         {
            channelIndex = int(param1);
         }
         else if(param1 is ChatLog)
         {
            channelLog = param1 as ChatLog;
            index = 0;
            while(index < this.channels.length)
            {
               if(this.channels[index] == channelLog)
               {
                  channelIndex = index;
                  break;
               }
               index++;
            }
         }
         if(channelIndex >= 0 && channelIndex < this.channels.length && (this.channels[channelIndex].channel < 0 || !param2))
         {
            removedLabel = this.channelButtonList1[channelIndex].label;
            if(this.channelButtonList1[channelIndex].toggled)
            {
               this.selectChannel(this.channelButtonList1[0]);
            }
            if(visible && this.channels[channelIndex].channel < 0)
            {
               ChatPanel.instance.doAction759(removedLabel);
            }
            this.channels[channelIndex].dispose();
            this.nuiComponent2.removeUIChild(this.channelButtonList1[channelIndex]);
            this.channelButtonList1[channelIndex].dispose();
            this.channelButtonList1.splice(channelIndex,1);
            this.channels.splice(channelIndex,1);
            index = channelIndex;
            while(index < this.channelButtonList1.length)
            {
               this.channelButtonList1[index].x = index > 0 ? this.channelButtonList1[index - 1].x + this.channelButtonList1[index - 1].width + 1 : 1;
               index++;
            }
            this.doAction78();
         }
      }
      
      protected function selectChannel(param1:ChannelButton) : void
      {
         var index:int = 0;
         while(index < this.channelButtonList1.length)
         {
            if(this.channelButtonList1[index] == param1)
            {
               this.channelButtonList1[index].toggled = true;
               if(!this.channels[index].parent)
               {
                  addUIChild(this.channels[index]);
               }
            }
            else
            {
               this.channelButtonList1[index].toggled = false;
               if(this.channels[index].parent)
               {
                  removeUIChild(this.channels[index]);
               }
            }
            index++;
         }
      }
      
      public function doAction155(param1:int, param2:int) : void
      {
         if(this.menu != null)
         {
            this.newsTicker1.x = this.menuContainer.x = (param1 - this.menu.width) / 2;
         }
         this.p1.x = param1 - this.p1.width;
         this.p2.x = param1 - this.p2.width;
         this.input.y = param2 - 37;
         this.input.width = param1 - 165;
         this.p3.setPos(this.input.x + this.input.width + 25,this.input.y - 9);
         this.userList.x = param1 - this.userList.width - 68;
         this.userList.height = Math.max(35,param2 - this.userList.y - 60);
         this.doAction78();
         this.nuiComponent6.x = param1 - this.nuiComponent6.width;
         this.nuiComponent8.y = param2 - this.nuiComponent1.height;
         this.nuiComponent10.y = param2 - this.nuiComponent10.height;
         this.nuiComponent14.x = param1 - this.nuiComponent14.width;
         this.nuiComponent20.x = param1 - this.nuiComponent20.width;
         this.nuiComponent20.y = param2 - this.nuiComponent20.height;
         this.nuiComponent12.x = param1 - this.nuiComponent12.width;
         this.nuiComponent17.x = param1 - this.nuiComponent12.width - this.nuiComponent17.width;
         this.nuiComponent4.x = param1 - this.nuiComponent12.width - this.nuiComponent4.width + 21;
         this.nuiComponent1.y = param2 - this.nuiComponent1.height;
         this.nuiComponent9.x = param1 - this.nuiComponent12.width + 107;
         this.shape3.x = this.shape4.x = this.shape7.x = param1 - this.nuiComponent12.width + 113;
      }
      
      protected function doAction78() : void
      {
         var index:int = 0;
         while(index < this.channels.length)
         {
            this.channels[index].width = this.userList.x - this.channels[index].x - 15;
            this.channels[index].height = this.userList.height;
            this.channelButtonList1[index].x = index > 0 ? this.channelButtonList1[index - 1].x + this.channelButtonList1[index - 1].width + 1 : 0;
            index++;
         }
         this.nuiComponent2.width = this.channels[0].width;
         var visibleChannelCount:int = Math.max(1,Math.min(this.channels.length,this.nuiComponent2.width / (this.channelButtonList1[0].width + 1)));
         index = 0;
         while(index < visibleChannelCount)
         {
            this.channelButtonList1[index].visible = true;
            index++;
         }
         index = visibleChannelCount;
         while(index < this.channels.length)
         {
            this.channelButtonList1[index].visible = false;
            index++;
         }
         this.nuiComponent18.visible = this.channelsExpandButton.visible = this.channelsCollapseButton.visible = false;
         if(visibleChannelCount < this.channels.length)
         {
            this.channelsExpandButton.visible = true;
            this.channelsExpandButton.x = this.channelsCollapseButton.x = this.channelButtonList1[visibleChannelCount - 1].x + this.channelButtonList1[visibleChannelCount - 1].width + 1;
         }
      }
      
      public function createMenu(param1:int, param2:Boolean = false) : void
      {
         _currentMenuId = param1;
         var modalLayer:ModalLayer = null;
         var createdMenu:Object = null;
         switch(param1)
         {
            case TerminalSubmenu.TM_MENU_CLAN_23:
               createdMenu = new NewsMenu();
               modalLayer = new ModalLayer(createdMenu as BaseMenu);
               break;
            case TerminalSubmenu.TM_MENU_CLAN_25:
               createdMenu = new ClanWarsMenu();
               modalLayer = new ModalLayer(createdMenu as BaseMenu);
               break;
            case Client.TM_MENU_MAIN:
               createdMenu = new TerminalMenu(TerminalMenu.TYPE_MAIN,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_CLAN:
               createdMenu = new TerminalMenu(TerminalMenu.TYPE_CLAN,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_SUBMENU_HIRE:
               createdMenu = new TerminalMenu(TerminalMenu.TYPE_HIRE,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_RAID:
               createdMenu = new TerminalMenu(TerminalMenu.TYPE_RAID,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_RAID_LOCS:
               createdMenu = new RaidLocationsMenu(GameSocket.socket,this,this.menuContainer,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_RAID_PARTIES:
               createdMenu = new RaidPartiesMenu(GameSocket.socket,this,this.menuContainer,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_LOCATIONS:
               createdMenu = new LocationsMenu(GameSocket.socket,this,this.menuContainer,LocationsMenu.TYPE_QUEST_LOCATIONS,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_ATTACK_ZONES:
               createdMenu = new LocationsMenu(GameSocket.socket,this,this.menuContainer,LocationsMenu.TYPE_ATTACK_ZONES,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_REQUEST_ZONES:
               createdMenu = new AttackRequestsMenu(GameSocket.socket,this,this.menuContainer,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_INVENTORY:
               return;
            case Client.TM_MENU_WELCOM:
               createdMenu = new WelcomMenu(this,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_CLAN_CONTROL:
               createdMenu = new ClanMenu(GameSocket.socket,this,this.menuContainer,Client.currentCharacter.hasAccess(Stat.Alcoholism) ? ClanMenu.TYPE_CONTROL_OWNER : ClanMenu.TYPE_CONTROL,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_CLAN_MONEY:
               createdMenu = new ClanMoneyMenu();
               break;
            case Client.TM_MENU_CLAN_DUES:
               createdMenu = new ClanMenu(GameSocket.socket,this,this.menuContainer,Client.currentCharacter.hasAccess(Stat.Depression) ? ClanMenu.TYPE_DUES_OWNER : ClanMenu.TYPE_DUES,param2);
               createdMenu.createMenu();
               break;
            case TerminalSubmenu.TM_MENU_CLAN_ZONES:
               createdMenu = new ClanZonesMenu();
               modalLayer = new ModalLayer(createdMenu as BaseMenu);
               break;
            case TerminalSubmenu.TM_MENU_CLAN_26:
               createdMenu = new ClanAnnounceMenu();
               modalLayer = new ModalLayer(createdMenu as BaseMenu);
               break;
            case Client.TM_MENU_EXCHANGE:
               createdMenu = new ExchangeMenu(GameSocket.socket,this,this.menuContainer);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_CLAN_HIRE:
               createdMenu = new ClanHireMenu(Client.HIRE_TYPE_CLAN,GameSocket.socket,this,this.menuContainer,Client.currentCharacter.hasAccess(Stat.GA_DELETE_CLAN_5),param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_PRIVATE_HIRE:
               createdMenu = new ClanHireMenu(Client.HIRE_TYPE_PRIVATE,GameSocket.socket,this,this.menuContainer,Client.currentCharacter.hasAccess(Stat.GA_DELETE_CLAN_5),param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_PRIVATE_MY_ORDERS:
               createdMenu = new ClanHireMenu(Client.HIRE_TYPE_MY_ORDERS,GameSocket.socket,this,this.menuContainer,false,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_PRIVATE_NEW_ORDER:
               createdMenu = new ClanHireMenu(Client.HIRE_TYPE_NEW_ORDER,GameSocket.socket,this,this.menuContainer,false,param2);
               createdMenu.createMenu();
               break;
            case Client.TM_MENU_RLS:
               createdMenu = new RadioMenu(GameSocket.socket,this,this.menuContainer);
               createdMenu.createMenu();
               break;
            default:
               createdMenu = new TerminalMenu(TerminalMenu.TYPE_MAIN,this.menuContainer);
               param1 = TerminalMenu.TYPE_MAIN;
               createdMenu.createMenu();
               break;
         }
         if(param1 != TerminalMenu.TYPE_MAIN)
         {
            createdMenu.closeFunction = this.backHandler;
         }
         if(modalLayer == null)
         {
            this.startMenu(createdMenu);
         }
         else
         {
            this.closeMenu();
            this.menu = createdMenu;
            this.menuContainer.addUIChild(modalLayer);
         }
      }
      
      private function startMenu(param1:Object) : void
      {
         this.closeMenu();
         this.menu = param1;
         this.menuContainer.addUIChild(param1 as UIElement);
      }
      
      private function closeMenu() : void
      {
         if(this.menu != null)
         {
            if(this.menu.uiParent)
            {
               this.menu.uiParent.removeUIChild(this.menu);
               this.main.removeMenu(this.menu);
            }
            menu = null;
         }
      }
      
      public function menuAvaible(menuId:int) : Boolean
      {
         switch(menuId)
         {
            case Client.TM_MENU_RLS:
               return this.terminalRadarAvailable;
            case Client.TM_MENU_CLAN_MONEY:
            case Client.TM_MENU_CLAN_DUES:
               return Client.currentCharacter.hasAccess(Stat.ChemicalPoisoning);
            case Client.TM_MENU_ATTACK_ZONES:
               return Client.currentCharacter.hasAccess(Stat.DrugAddiction);
            case TerminalSubmenu.TM_MENU_CLAN_ZONES:
               return Client.currentCharacter.clanId != 0;
            case TerminalSubmenu.TM_MENU_CLAN_25:
               return Client.currentCharacter.isValue6;
            default:
               return true;
         }
      }
      
      public function showAdvertise() : void
      {
         this.newsTicker1.visible = true;
      }
      
      public function hideAdvertise() : void
      {
         this.newsTicker1.visible = false;
      }
      
      private function backHandler() : void
      {
         switch(this.currentMenuId)
         {
            case Client.TM_MENU_CLAN_CONTROL:
            case Client.TM_MENU_CLAN_MONEY:
            case Client.TM_MENU_CLAN_DUES:
            case TerminalSubmenu.TM_MENU_CLAN_ZONES:
            case TerminalSubmenu.TM_MENU_CLAN_25:
            case TerminalSubmenu.TM_MENU_CLAN_26:
               this.createMenu(Client.TM_MENU_CLAN);
               break;
            case Client.TM_MENU_CLAN_HIRE:
            case Client.TM_MENU_PRIVATE_HIRE:
               this.createMenu(Client.TM_SUBMENU_HIRE);
               break;
            case Client.TM_MENU_PRIVATE_NEW_ORDER:
            case Client.TM_MENU_PRIVATE_MY_ORDERS:
               this.createMenu(Client.TM_MENU_PRIVATE_HIRE);
               break;
            case Client.TM_MENU_RAID_LOCS:
            case Client.TM_MENU_RAID_PARTIES:
               this.createMenu(Client.TM_MENU_RAID);
               break;
            default:
               this.createMenu(Client.TM_MENU_MAIN);
               break;
         }
      }
   }
}

