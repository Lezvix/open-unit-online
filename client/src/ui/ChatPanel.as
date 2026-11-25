package ui
{
   import ui.buttons.*;
   import net.*;
   import core.display.BmpTextField;
   import game.npc.PlayerItem;
   import events.*;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import game.*;
   import mx.utils.StringUtil;
   
   public class ChatPanel extends NUIComponent
   {
      
      public static var instance:ChatPanel;
      
      private static const HIDE_500:int = 500;
      
      private static const HIDE_82:int = 108;
      
      private static const HIDE_138:int = 138;
      
      private static const HIDE_38:int = 38;
      
      private static const HIDE_188:int = 188;
      
      private static const HIDE_85:int = 85;
      
      private static const HIDE_TIME:int = 300;
      
      public static const GA_ADD_CLAN_USERS:int = 0;
      
      public static const GA_SHOW_CLAN:int = 1;
      
      public static const TYPE_2:int = 2;
      
      public static const TYPE_CLAN:int = 3;
      
      protected static const GA_HIRE_PEOPLE:int = 5;
      
      protected static const GA_HIRE_6:int = 6;
      
      protected static const GA_HIRE_7:int = 7;
      
      protected static const GA_HIRE_9:int = 9;
      
      protected static const nTextFormat3:NTextFormat = NTextFormat.input.derive({"color":14659426});
      
      protected static const nTextFormat4:NTextFormat = NTextFormat.input.derive({"color":16771509});
      
      protected static const MESSAGE_COLORS:Array = [nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3,nTextFormat3.derive({"color":6273841}),nTextFormat3.derive({"color":16737792}),nTextFormat3.derive({"color":6467551}),nTextFormat3,nTextFormat3.derive({"color":12728380})];
      
      public static const GA_ADD_CLAN_16:int = 16;
      
      private const chatPanelLeftBmp:Bitmap = getBmp("CHAT_PANEL_LEFT");
      
      private const chatPanelCenterBmp:Bitmap = getBmp("CHAT_PANEL_CENTER");
      
      private const chatPanelRightBmp:Bitmap = getBmp("CHAT_PANEL_RIGHT");
      
      protected var main:Main;
      
      protected var intValue43:int;
      
      protected var intValue175:int;
      
      protected var clockFontText:BmpTextField;
      
      protected var input:NTextInput;
      
      protected var userList:ChatUser;
      
      protected var chatUsers:ChatUser;
      
      protected var timer:Timer;
      
      protected var baseOpened:Boolean = false;
      
      protected var autoButton:NButton;
      
      protected var logoutButton:NButton;
      
      protected var nButton8:NButton;
      
      protected var nButton22:NButton;
      
      protected var nuiComponent2:NUIComponent;
      
      protected var shape6:Shape = new Shape();
      
      protected var channelButtonList1:Vector.<ChannelButton> = new Vector.<ChannelButton>();
      
      protected var channels:Vector.<ChatLog> = new Vector.<ChatLog>();
      
      protected var stageWidth:int;
      
      protected var stageHeight:int;
      
      protected const stringList2:Vector.<String> = new Vector.<String>();
      
      public function ChatPanel(param1:Main, param2:int, param3:int)
      {
         super();
         this.main = param1;
         instance = this;
         this.autoButton = new NButton(this.onMinimizeClick,getBmp("MINIMIZE_BUTTON"),getBmp("MINIMIZE_BUTTON_OVER"),getBmp("MINIMIZE_BUTTON_PRESSED"));
         addUIChild(this.autoButton);
         this.logoutButton = new NButton(this.onMaximizeClick,getBmp("MAXIMIZE_BUTTON"),getBmp("MAXIMIZE_BUTTON_OVER"),getBmp("MAXIMIZE_BUTTON_PRESSED"));
         this.logoutButton.visible = false;
         addUIChild(this.logoutButton);
         this.autoButton.y = this.logoutButton.y = 13;
         var scrollBitmap:Bitmap = getBmp("CHANNEL_SCROLL_BUTTON");
         var scrollOverBitmap:Bitmap = getBmp("CHANNEL_SCROLL_BUTTON_OVER");
         var scrollPressedBitmap:Bitmap = getBmp("CHANNEL_SCROLL_BUTTON_PRESSED");
         this.nButton8 = new NButton(this.doAction299,scrollBitmap,scrollOverBitmap,scrollPressedBitmap);
         this.nButton8.setPos(100,15);
         addUIChild(this.nButton8);
         scrollBitmap = new Bitmap(Chat.getBitmapData2(scrollBitmap.bitmapData));
         scrollOverBitmap = new Bitmap(Chat.getBitmapData2(scrollOverBitmap.bitmapData));
         scrollPressedBitmap = new Bitmap(Chat.getBitmapData2(scrollPressedBitmap.bitmapData));
         this.nButton22 = new NButton(this.doAction898,scrollBitmap,scrollOverBitmap,scrollPressedBitmap);
         this.nButton22.y = this.nButton8.y;
         addUIChild(this.nButton22);
         this.nuiComponent2 = new NUIComponent();
         this.nuiComponent2.setPos(this.nButton8.x + this.nButton8.width,this.nButton8.y);
         this.nuiComponent2.height = 18;
         addUIChild(this.nuiComponent2);
         this.shape6.x = this.nuiComponent2.x;
         this.shape6.y = this.nuiComponent2.y;
         addChild(this.shape6);
         this.nuiComponent2.propValue176 = this.shape6;
         this.chatUsers = new ChatUser(192,HIDE_138);
         this.chatUsers.y = 42;
         this.chatUsers.nameClickHandler = this.handleChatInputKeyDown;
         this.chatUsers.privateCallback = this.smileButtonClick;
         this.chatUsers.disposeOnRemove = false;
         this.userList = new ChatUser(192,HIDE_138);
         this.userList.y = 42;
         this.userList.nameClickHandler = this.handleChatInputKeyDown;
         this.userList.privateCallback = this.smileButtonClick;
         this.userList.disposeOnRemove = false;
         addUIChild(this.userList);
         this.input = new NTextInput(255,NTextFormat.input);
         this.input.setPos(12,HIDE_188);
         this.input.background = false;
         this.input.borderColor = 13408825;
         this.input.height = 18;
         this.input.textField.setPos(3,4);
         this.input.textField.textColor = 16771509;
         this.input.onKeyDown = this.onOnKeyDown;
         if(Client.settings["showChannel_" + GA_SHOW_CLAN])
         {
            this.doAction103(GA_SHOW_CLAN);
         }
         if(Client.settings["showChannel_" + TYPE_2])
         {
            this.doAction103(TYPE_2);
         }
         if(Client.currentCharacter.clanId > 0 && Client.settings["showChannel_" + TYPE_CLAN])
         {
            this.doAction103(TYPE_CLAN);
         }
         if(Client.settings["showChannel_" + GA_ADD_CLAN_USERS])
         {
            this.doAction103(GA_ADD_CLAN_USERS);
         }
         if(this.channels.length > 0)
         {
            this.selectChannel(this.channels[0].channelButton);
         }
         height = this.chatPanelLeftBmp.height;
         this.clockFontText = new BmpTextField(85,25,getBmp("CLOCK_FONT")," 0123456789.:",3);
         this.clockFontText.x = 10;
         this.clockFontText.y = 4;
         addChild(this.clockFontText);
         addUIChild(this.input);
         this.doAction155(param2,param3);
         processIntervalValue = 500;
         UnitEventDispatcher.instance.addListener(EventType.EffectAdded,this.doAction426);
      }
      
      public function doAction221(param1:String) : void
      {
         this.input.appendText(param1);
         this.input.focus();
         this.input.moveCaretToEnd();
      }
      
      private function doAction426(param1:Object) : void
      {
         if(!visible)
         {
            return;
         }
         switch(param1.type)
         {
            case Effect.LIGHT_TRAUMA:
            case Effect.SEVERE_TRAUMA:
               this.doAction242(this.getString51(),formatString("IDS_GET_TRAUMA",param1.param,this.main.getTraumSaverity(param1.param)),GA_HIRE_6);
               break;
         }
      }
      
      protected function doAction599(param1:String, param2:String, param3:int) : void
      {
         var systemSender:String = _("IDS_SYSTEM_MESSAGE");
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channel >= 0)
            {
               this.channels[channelIndex].addText(param1,systemSender,param2,MESSAGE_COLORS[param3]);
            }
            channelIndex++;
         }
      }
      
      public function doAction242(param1:String, param2:String, param3:int) : void
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channel == GA_SHOW_CLAN)
            {
               this.channels[channelIndex].addLogText(param1,param2,MESSAGE_COLORS[param3]);
               break;
            }
            channelIndex++;
         }
      }
      
      public function doAction604(param1:int, param2:String) : void
      {
         this.addChannel(-param1,param2,-1,true);
         this.input.focus();
      }
      
      protected function handleChatInputKeyDown(param1:NButton) : void
      {
         this.input.text = _("IDS_CHAT_TO",param1.value) + " " + this.input.text;
         this.input.moveCaretToEnd();
         this.input.focus();
      }
      
      protected function smileButtonClick(param1:NButton) : void
      {
         GameSocket.socket.sendStr("po|" + param1.value);
      }
      
      protected function onBack(param1:NButton) : void
      {
         this.doAction920(param1.value);
      }
      
      public function doAction103(param1:int) : void
      {
         if(param1 >= 0)
         {
            this.addChannel(param1,_("IDS_CHAT_CHANNEL_" + param1),0);
         }
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
         var closeButton:NButton = new NButton(this.onBack,getBmp("CHANNEL_CLOSE_BUTTON"),getBmp("CHANNEL_CLOSE_BUTTON_OVER"),getBmp("CHANNEL_CLOSE_BUTTON_PRESSED"));
         var channelButton:ChannelButton = new ChannelTabButton(this.selectChannel,param1,param2,closeButton);
         var logWidth:int = Math.max(HIDE_500,this.stageWidth - NuclearChat.instance.width) - 235;
         var chatLog:ChatLog = new ChatLog(logWidth,this.baseOpenedValue ? HIDE_38 : HIDE_138,channelButton);
         chatLog.x = 13;
         chatLog.y = 42;
         closeButton.value = chatLog;
         if(param1 >= 0 && param1 <= 4)
         {
            if(!Client.settings["showChannel_" + param1])
            {
               Client.settings["showChannel_" + param1] = true;
               Client.settings.save();
            }
         }
         if(param3 == -1)
         {
            channelIndex = 0;
            while(channelIndex < this.channelButtonList1.length)
            {
               if(this.channelButtonList1[channelIndex].channel < 0)
               {
                  param3 = channelIndex;
                  break;
               }
               channelIndex++;
            }
         }
         if(param3 >= 0 && param3 < this.channelButtonList1.length)
         {
            this.channelButtonList1.splice(param3,0,channelButton);
            channelIndex = param3;
            while(channelIndex < this.channelButtonList1.length)
            {
               this.channelButtonList1[channelIndex].x = channelIndex > 0 ? this.channelButtonList1[channelIndex - 1].x + this.channelButtonList1[channelIndex - 1].width + 1 : 1;
               channelIndex++;
            }
            this.channels.splice(param3,0,chatLog);
         }
         else
         {
            this.channelButtonList1.push(channelButton);
            param3 = this.channelButtonList1.length - 1;
            channelButton.x = this.channelButtonList1.length > 1 ? this.channelButtonList1[param3 - 1].x + this.channelButtonList1[param3 - 1].width + 1 : 1;
            this.channels.push(chatLog);
         }
         this.nuiComponent2.addUIChild(channelButton);
         this.nuiComponent2.addUIChild(closeButton);
         if(param4 || this.channels.length === 1)
         {
            this.selectChannel(channelButton);
         }
         return chatLog;
      }
      
      public function updateUserList() : void
      {
         this.input.focus();
      }
      
      protected function onOnKeyDown(param1:KeyboardEvent) : void
      {
         var message:String = null;
         var index:int = 0;
         var recipient:String = null;
         var channelId:int = 0;
         if(param1.keyCode == Keyboard.ENTER)
         {
            message = this.input.text;
            this.input.text = "";
            if(message)
            {
               index = 0;
               while(index < this.stringList2.length)
               {
                  if(this.stringList2[index] == message)
                  {
                     this.stringList2.splice(index,1);
                  }
                  index++;
               }
               this.stringList2.push(message);
               if(this.stringList2.length > GA_ADD_CLAN_16)
               {
                  this.stringList2.shift();
               }
               if(message.charAt(0) == "/" || message.charAt(0) == "?" && message.length > 1)
               {
                  if(message.charAt(0) == "/")
                  {
                     message = StringUtil.trim(message.slice(1));
                  }
                  else
                  {
                     message = StringUtil.trim(message);
                  }
                  index = message.indexOf(" ");
                  if(index == -1)
                  {
                     message = message.toLocaleLowerCase();
                  }
                  else
                  {
                     message = message.slice(0,index).toLocaleLowerCase() + message.slice(index);
                  }
                  if(message == "help")
                  {
                     message = "?";
                  }
                  else
                  {
                     if(message == "trade")
                     {
                        this.addChannel(TYPE_2,_("IDS_CHAT_CHANNEL_" + TYPE_2),0,true);
                        return;
                     }
                     else if(message == "clan")
                     {
                        if(Client.currentCharacter.clanId != 0)
                        {
                           this.addChannel(TYPE_CLAN,_("IDS_CHAT_CHANNEL_" + TYPE_CLAN),0,true);
                        }
                        return;
                     }
                     else if(message == "events")
                     {
                        this.addChannel(GA_SHOW_CLAN,_("IDS_CHAT_CHANNEL_" + GA_SHOW_CLAN),0,true);
                        return;
                     }
                     else if(message == "general")
                     {
                        this.addChannel(GA_ADD_CLAN_USERS,_("IDS_CHAT_CHANNEL_" + GA_ADD_CLAN_USERS),0,true);
                        return;
                     }
                  }
                  if(message.length > 0)
                  {
                     if(message.length > 3 && message.search("pm ") == 0)
                     {
                        recipient = message.slice(3);
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
                     GameSocket.socket.send("sc",message);
                  }
               }
               else if(this.channels.length > 0)
               {
                  channelId = this.propValue118;
                  if(channelId < 0 || channelId == GA_ADD_CLAN_USERS || channelId == TYPE_2 || channelId == TYPE_CLAN)
                  {
                     GameSocket.socket.send("sg",channelId,message);
                  }
               }
            }
         }
         else if(param1.keyCode == Keyboard.UP && this.stringList2.length > 0)
         {
            this.input.text = this.stringList2.pop();
            this.input.moveCaretToEnd();
            this.stringList2.unshift(this.input.text);
         }
         else if(param1.keyCode == Keyboard.DOWN && this.stringList2.length > 0)
         {
            this.input.text = this.stringList2[this.stringList2.length - 1];
            this.input.moveCaretToEnd();
            this.stringList2.push(this.stringList2.shift());
         }
         else if(param1.keyCode == Main.instance.getKey(Main.KEY_CHANGE_34))
         {
            Screenshot.doAction404();
         }
      }
      
      protected function get propValue118() : int
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channelButtonList1.length)
         {
            if(this.channelButtonList1[channelIndex].toggled)
            {
               return this.channelButtonList1[channelIndex].channel;
            }
            channelIndex++;
         }
         return 0;
      }
      
      public function get serverTime() : Number
      {
         return (this.intValue43 + getTimer() - this.intValue175) / 1000;
      }
      
      override protected function process() : void
      {
         var currentTime:int = getTimer();
         var serverSeconds:int = (this.intValue43 + currentTime - this.intValue175) / 1000;
         var hours:int = serverSeconds / 3600 % 24;
         var minutes:int = serverSeconds / 60 % 60;
         var hoursText:String = hours < 10 ? "0" + hours : hours.toString();
         var minutesText:String = minutes < 10 ? "0" + minutes : minutes.toString();
         var separator:String = (currentTime % 1000 < 500) ? ":" : ".";
         this.clockFontText.setText(hoursText + separator + minutesText);
      }
      
      public function getString51() : String
      {
         var serverSeconds:int = this.serverTime;
         var hours:int = serverSeconds / 3600 % 24;
         var minutes:int = serverSeconds / 60 % 60;
         return (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes);
      }
      
      protected var date1:Date;

      public function get propValue103() : Number
      {
         return this.date1.getTime() + (getTimer() - this.intValue175);
      }
      
      public function set propValue64(param1:String) : void
      {
         var dateParts:Array = param1.split(".");
         date1 = new Date(int(dateParts[0]),int(dateParts[1]),int(dateParts[2]),int(dateParts[3]),int(dateParts[4]),int(dateParts[5]));
         intValue43 = (int(dateParts[3]) * 3600 + int(dateParts[4]) * 60 + int(dateParts[5])) * 1000;
         intValue175 = getTimer();
      }
      
      public function get propValue94() : String
      {
         var currentDate:Date = new Date(this.date1.getTime() + (getTimer() - this.intValue175));
         return currentDate.toDateString();
      }
      
      public function get propValue140() : String
      {
         var currentDate:Date = new Date(this.date1.getTime() + (getTimer() - this.intValue175));
         return currentDate.toTimeString();
      }
      
      public function get baseOpenedValue() : Boolean
      {
         return this.baseOpened;
      }
      
      public function set baseOpenedValue(param1:Boolean) : void
      {
         if(this.baseOpened != param1 && this.timer == null)
         {
            baseOpened = param1;
            this.autoButton.visible = !param1;
            this.logoutButton.visible = param1;
            enabled = false;
            timer = new Timer(20);
            this.timer.addEventListener(TimerEvent.TIMER,param1 ? this.doAction406 : this.doAction436);
            this.timer.start();
            GameSocket.socket.doAction720();
         }
      }
      
      public function get propValue139() : Number
      {
         return this.stageHeight - y;
      }
      
      protected function doAction436(param1:TimerEvent) : void
      {
         var animationSteps:int = HIDE_TIME / this.timer.delay;
         y = Math.max(this.stageHeight - height,y - (height - HIDE_82) / animationSteps);
         this.input.y = Math.min(HIDE_188,this.input.y + (HIDE_188 - HIDE_85) / animationSteps);
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channelButton.toggled)
            {
               this.channels[channelIndex].height = Math.min(HIDE_138,this.channels[channelIndex].height + (HIDE_138 - HIDE_38) / animationSteps);
               break;
            }
            channelIndex++;
         }
         this.userList.height = Math.min(HIDE_138,this.userList.height + (HIDE_138 - HIDE_38) / animationSteps);
         this.chatUsers.height = Math.min(HIDE_138,this.chatUsers.height + (HIDE_138 - HIDE_38) / animationSteps);
         if(this.timer.currentCount == animationSteps)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.doAction436);
            this.timer.stop();
            timer = null;
            enabled = true;
         }
      }
      
      protected function doAction406(param1:TimerEvent) : void
      {
         var animationSteps:int = HIDE_TIME / this.timer.delay;
         y = Math.min(this.stageHeight - HIDE_82,y + (height - HIDE_82) / animationSteps);
         this.input.y = Math.max(HIDE_85,this.input.y - (HIDE_188 - HIDE_85) / animationSteps);
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channelButton.toggled)
            {
               this.channels[channelIndex].height = Math.max(HIDE_38,this.channels[channelIndex].height - (HIDE_138 - HIDE_38) / animationSteps);
               break;
            }
            channelIndex++;
         }
         this.userList.height = Math.max(HIDE_38,this.userList.height - (HIDE_138 - HIDE_38) / animationSteps);
         this.chatUsers.height = Math.max(HIDE_38,this.chatUsers.height - (HIDE_138 - HIDE_38) / animationSteps);
         if(this.timer.currentCount == animationSteps)
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.doAction406);
            this.timer.stop();
            timer = null;
            enabled = true;
         }
      }
      
      override public function handleAddedToUITree() : void
      {
         super.handleAddedToUITree();
         if(this.channels.length > 0)
         {
            this.selectChannel(this.channelButtonList1[0]);
         }
      }
      
      protected function selectChannel(param1:ChannelButton) : void
      {
         var channelIndex:int = 0;
         var channelButton:ChannelButton;
         while(channelIndex < this.channelButtonList1.length)
         {
            channelButton = this.channelButtonList1[channelIndex];
            if(channelButton === param1)
            {
               channelButton.toggled = true;
               if(!this.channels[channelIndex].parent)
               {
                  this.channels[channelIndex].height = this.baseOpenedValue ? HIDE_38 : HIDE_138;
                  addUIChild(this.channels[channelIndex]);
               }
               if(this.channels[channelIndex].channel == TYPE_CLAN)
               {
                  if(this.userList.addedToUITree)
                  {
                     removeUIChild(this.userList);
                  }
                  if(!this.chatUsers.addedToUITree)
                  {
                     addUIChild(this.chatUsers);
                  }
               }
               else
               {
                  if(this.chatUsers.addedToUITree)
                  {
                     removeUIChild(this.chatUsers);
                  }
                  if(!this.userList.addedToUITree)
                  {
                     addUIChild(this.userList);
                  }
               }
            }
            else
            {
               channelButton.toggled = false;
               if(this.channels[channelIndex].parent)
               {
                  removeUIChild(this.channels[channelIndex]);
               }
            }
            channelIndex++;
         }
      }
      
      protected function doAction299(param1:Object) : void
      {
         if(this.channels.length === 0)
         {
            return;
         }
         if(this.channelButtonList1[0].x < 0)
         {
            this.doAction213(Math.max(this.channelButtonList1[0].x,-30));
         }
      }
      
      protected function doAction213(param1:int) : void
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channelButtonList1.length)
         {
            this.channelButtonList1[channelIndex].x -= param1;
            channelIndex++;
         }
      }
      
      protected function doAction898(param1:Object) : void
      {
         if(this.channels.length === 0)
         {
            return;
         }
         var lastButton:DisplayObject = this.channelButtonList1[this.channelButtonList1.length - 1];
         if(lastButton.x + lastButton.width > this.nuiComponent2.width)
         {
            this.doAction213(Math.min(lastButton.x + lastButton.width - this.nuiComponent2.width,30));
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
         this.doAction316();
      }
      
      protected function doAction316() : void
      {
         width = Math.max(HIDE_500,this.stageWidth - NuclearChat.instance.width);
         if(this.timer == null)
         {
            y = this.baseOpenedValue ? this.stageHeight - HIDE_82 : this.stageHeight - height;
         }
         this.autoButton.x = this.logoutButton.x = width - 46;
         this.nButton22.x = width - 81;
         this.userList.x = width - 211;
         this.chatUsers.x = this.userList.x;
         this.nuiComponent2.width = this.nButton22.x - this.nButton8.x - this.nButton8.width;
         this.shape6.graphics.clear();
         this.shape6.graphics.beginFill(0,0);
         this.shape6.graphics.drawRect(0,0,this.nuiComponent2.width,this.nuiComponent2.height);
         this.shape6.graphics.endFill();
         this.input.width = width - 33;
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            this.channels[channelIndex].width = width - 235;
            channelIndex++;
         }
         graphics.clear();
         draw(this.chatPanelLeftBmp);
         draw(this.chatPanelRightBmp,width - this.chatPanelRightBmp.width,26);
         drawTile(this.chatPanelCenterBmp,this.chatPanelLeftBmp.width,33,width - this.chatPanelLeftBmp.width - this.chatPanelRightBmp.width,this.chatPanelCenterBmp.height);
      }
      
      public function doAction387(param1:* = null) : void
      {
         var sessionId:int = 0;
         var user:UserList = null;
         if(param1 == null)
         {
            param1 = [];
            for each(user in this.userList.propValue120)
            {
               param1.push(user.sessionId);
            }
         }
         for each(sessionId in param1)
         {
            if(sessionId > 0)
            {
               this.doAction160(sessionId);
            }
         }
      }
      
      public function doAction116(param1:* = null) : void
      {
         var sessionId:int = 0;
         var user:UserList = null;
         if(param1 == null)
         {
            param1 = [];
            for each(user in this.chatUsers.propValue120)
            {
               param1.push(user.sessionId);
            }
         }
         for each(sessionId in param1)
         {
            if(sessionId > 0)
            {
               this.doAction526(sessionId);
            }
         }
      }
      
      public function doAction759(param1:String) : void
      {
         this.doAction920(param1,true);
      }
      
      public function doAction951(param1:int) : void
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channel == param1)
            {
               this.doAction920(channelIndex);
               return;
            }
            channelIndex++;
         }
      }
      
      protected function doAction920(param1:*, param2:Boolean = false) : void
      {
         var selectedIndex:int = -1;
         var channelName:String;
         var channelIndex:int;
         var chatLog:ChatLog;
         var closedLabel:String;
         if(param1 is String)
         {
            channelName = param1.toString().toLocaleLowerCase();
            channelIndex = 0;
            while(channelIndex < this.channels.length)
            {
               if(this.channels[channelIndex].channelButton.label.toLocaleLowerCase() == channelName && (this.channels[channelIndex].channel < 0 || !param2))
               {
                  selectedIndex = channelIndex;
                  break;
               }
               channelIndex++;
            }
         }
         else if(param1 is int)
         {
            selectedIndex = int(param1);
         }
         else if(param1 is ChatLog)
         {
            chatLog = param1 as ChatLog;
            channelIndex = 0;
            while(channelIndex < this.channels.length)
            {
               if(this.channels[channelIndex] == chatLog)
               {
                  selectedIndex = channelIndex;
                  break;
               }
               channelIndex++;
            }
         }
         if(selectedIndex >= 0 && selectedIndex < this.channels.length && (this.channels[selectedIndex].channel < 0 || !param2))
         {
            closedLabel = this.channelButtonList1[selectedIndex].label;
            if(this.channelButtonList1[selectedIndex].toggled)
            {
               channelIndex = 0;
               while(channelIndex < this.channels.length)
               {
                  if(channelIndex !== selectedIndex)
                  {
                     this.selectChannel(this.channelButtonList1[channelIndex]);
                     break;
                  }
                  channelIndex++;
               }
            }
            if(visible && this.channels[selectedIndex].channel < 0)
            {
               Terminal.instance.doAction759(closedLabel);
            }
            if(this.channels[selectedIndex].channel >= 0 && this.channels[selectedIndex].channel <= 4)
            {
               Client.settings["showChannel_" + this.channels[selectedIndex].channel] = false;
               Client.settings.save();
            }
            if(this.channels[selectedIndex].addedToUITree)
            {
               removeUIChild(this.channels[selectedIndex]);
            }
            this.channels[selectedIndex].dispose();
            this.nuiComponent2.removeUIChild(this.channelButtonList1[selectedIndex]);
            this.channelButtonList1.splice(selectedIndex,1);
            this.channels.splice(selectedIndex,1);
            channelIndex = selectedIndex;
            while(channelIndex < this.channelButtonList1.length)
            {
               this.channelButtonList1[channelIndex].x = channelIndex > 0 ? this.channelButtonList1[channelIndex - 1].x + this.channelButtonList1[channelIndex - 1].width + 1 : 1;
               channelIndex++;
            }
         }
      }
      
      public function doAction307(param1:int, param2:String, param3:Array) : void
      {
         if(!visible && param1 >= 0)
         {
            return;
         }
         var timeText:String = this.getString51();
         var channelIndex:int;
         var itemDescriptions:Array;
         var remainingItems:int;
         var fieldIndex:int;
         var targetLog:ChatLog;
         var privateLog:ChatLog;
         if(param1 == GA_HIRE_7)
         {
            channelIndex = 0;
            while(channelIndex < this.channels.length)
            {
               if(this.channels[channelIndex].channelButton.toggled)
               {
                  this.channels[channelIndex].addText(timeText,param2,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_7]);
                  break;
               }
               channelIndex++;
            }
         }
         else if(param1 == GA_SHOW_CLAN)
         {
            if(!Client.settings.showPvP && (param3[0] == "51" || param3[0] == "52" || param3[0] == "57"))
            {
               return;
            }
            if(param3[0] == "27")
            {
               itemDescriptions = [];
               remainingItems = Math.max(0,int(param3[1]));
               fieldIndex = 2;
               while(remainingItems > 0)
               {
                  itemDescriptions.push(param3[fieldIndex] + (param3[fieldIndex + 1] > 1 ? " " + param3[fieldIndex + 1] + _("IDS_COUNT_SHORT") : ""));
                  fieldIndex += 2;
                  remainingItems--;
               }
               param3.splice(1,param3.length - 2,itemDescriptions.join(", "));
            }
            this.doAction242(timeText,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),GA_SHOW_CLAN);
         }
         else if(param1 == GA_HIRE_6)
         {
            this.doAction599(timeText,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),param2 == "1" ? GA_HIRE_PEOPLE : GA_HIRE_6);
         }
         else if(param1 == GA_HIRE_PEOPLE)
         {
            param2 = _("IDS_CHAT_EVENT");
            channelIndex = 0;
            while(channelIndex < this.channels.length)
            {
               if(this.channels[channelIndex].channel == GA_SHOW_CLAN)
               {
                  this.channels[channelIndex].addText(timeText,param2,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_PEOPLE]);
                  break;
               }
               channelIndex++;
            }
         }
         else if(param1 == GA_HIRE_9)
         {
            targetLog = this.getChatLog1(Client.currentCharacter.clanId == 0 ? GA_ADD_CLAN_USERS : TYPE_CLAN);
            if(targetLog)
            {
               targetLog.addLogText(timeText,this.formatSystemMessage(param3[0],param3.slice(1,param3.length - 1)),MESSAGE_COLORS[GA_HIRE_9]);
            }
         }
         else if(param1 < 0)
         {
            privateLog = this.addChannel(param1,param2);
            privateLog.addText(timeText,param2,param3[0],param2 == Client.currentCharacter.name ? nTextFormat4 : nTextFormat3);
         }
         else
         {
            channelIndex = 0;
            while(channelIndex < this.channels.length)
            {
               if(this.channels[channelIndex].channel == param1)
               {
                  if(!Client.settings.hideFoesMessages || !Client.currentCharacter.check32(param2))
                  {
                     this.channels[channelIndex].addText(timeText,param2,param3[0],param2 == Client.currentCharacter.name ? nTextFormat4 : MESSAGE_COLORS[param1]);
                  }
                  break;
               }
               channelIndex++;
            }
         }
      }
      
      private function getChatLog1(param1:int) : ChatLog
      {
         var channelIndex:int = 0;
         while(channelIndex < this.channels.length)
         {
            if(this.channels[channelIndex].channel == param1)
            {
               return this.channels[channelIndex];
            }
            channelIndex++;
         }
         return null;
      }
      
      protected function formatSystemMessage(param1:String, param2:Array) : String
      {
         return Chat.prepareText(getString11("IDS_SYS_MSG_" + param1,param2));
      }
      
      public function deleteAll() : void
      {
         this.doAction387();
         this.doAction116();
      }
      
      public function doAction160(param1:int) : void
      {
         this.userList.doAction856(param1);
      }
      
      public function onExit(param1:PlayerItem) : void
      {
         var user:UserList = new UserList();
         user.login = param1.login;
         user.sessionId = param1.sessionId;
         user.level = param1.level;
         user.clanId = param1.clanId;
         user.clanName = param1.clanName;
         user.clanUrl = param1.clanUrl;
         user.userId = param1.userId;
         user.hireClanId = param1.hireClanId;
         user.hireClanName = param1.hireClanName;
         user.hireClanUrl = param1.hireClanUrl;
         this.userList.onExit(user);
      }
      
      public function doAction813(param1:UserList) : void
      {
         this.chatUsers.onExit(param1);
      }
      
      public function doAction526(param1:int) : void
      {
         this.chatUsers.doAction856(param1);
      }
   }
}

