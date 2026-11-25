package com.junkbyte.console.view
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.Log;
   import com.junkbyte.console.core.Remoting;
   import com.junkbyte.console.core.LogReferences;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.system.Security;
   import flash.system.SecurityPanel;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class MainPanel extends ConsolePanel
   {
      
      public static const CHANNELS_PANEL:String = "mainPanel";
      
      private static const CLHISTORY:String = "clhistory";
      
      private static const VIEWING_CHANNELS:String = "viewingChannels";
      
      private static const IGNORED_CHANNELS:String = "ignoredChannels";
      
      private static const PRIORITY:String = "priority";
      
      private var _traceField:TextField;
      
      private var _cmdPrefx:TextField;
      
      private var _cmdField:TextField;
      
      private var _hintField:TextField;
      
      private var _cmdBG:Shape;
      
      private var _blinkLine:Shape;
      
      private var flag85:Boolean;
      
      private var flag24:Boolean;
      
      private var flag106:Boolean;
      
      private var flag132:Boolean;
      
      private var scrollSprite1:Sprite;
      
      private var _scroll:Sprite;
      
      private var uintValue26:uint;
      
      private var intValue166:int;
      
      private var flag45:Boolean;
      
      private var numValue22:Number;
      
      private var intValue89:int;
      
      private var intValue28:int;
      
      private var _viewingChannels:Array;
      
      private var _ignoredChannels:Array;
      
      private var obj19:Object = new Object();
      
      private var intValue179:int = -1;
      
      private var _priority:uint;
      
      private var _filterText:String;
      
      private var _filterRegExp:RegExp;
      
      private var str35:String = "";
      
      private var flag53:Boolean;
      
      private var flag128:Boolean;
      
      private var flag126:Boolean;
      
      private var flag10:Boolean = true;
      
      private var flag124:Boolean;
      
      private var onText:String;
      
      private var _clhistory:Array;
      
      public function MainPanel(param1:Console)
      {
         super(param1);
         var menuSize:int = style.menuFontSize;
         var commandFormat:TextFormat;
         console.cl.addCLCmd("filter",this.doAction300,"Filter console logs to matching string. When done, click on the * (global channel) at top.",true);
         console.cl.addCLCmd("filterexp",this.doAction763,"Filter console logs to matching regular expression",true);
         console.cl.addCLCmd("clearhistory",this.doAction916,"Clear history of commands you have entered.",true);
         name = CHANNELS_PANEL;
         minWidth = 50;
         minHeight = 18;
         this._traceField = makeTF("traceField");
         this._traceField.wordWrap = true;
         this._traceField.multiline = true;
         this._traceField.y = menuSize;
         this._traceField.addEventListener(Event.SCROLL,this.on_traceFieldScroll);
         addChild(this._traceField);
         txtField = makeTF("menuField");
         txtField.wordWrap = true;
         txtField.multiline = true;
         txtField.autoSize = TextFieldAutoSize.RIGHT;
         txtField.height = menuSize + 6;
         txtField.y = -2;
         doAction732(txtField,this.onMenuRollOver);
         addChild(txtField);
         this._cmdBG = new Shape();
         this._cmdBG.name = "commandBackground";
         this._cmdBG.graphics.beginFill(style.commandLineColor,0.1);
         this._cmdBG.graphics.drawRoundRect(0,0,100,18,menuSize,menuSize);
         this._cmdBG.scale9Grid = new Rectangle(9,9,80,1);
         addChild(this._cmdBG);
         commandFormat = new TextFormat(style.menuFont,style.menuFontSize,style.highColor);
         this._cmdField = new TextField();
         this._cmdField.name = "commandField";
         this._cmdField.type = TextFieldType.INPUT;
         this._cmdField.x = 40;
         this._cmdField.height = menuSize + 6;
         this._cmdField.addEventListener(KeyboardEvent.KEY_DOWN,this.on_cmdFieldKeyDown);
         this._cmdField.addEventListener(KeyboardEvent.KEY_UP,this.on_cmdFieldKeyUp);
         this._cmdField.addEventListener(FocusEvent.FOCUS_IN,this.on_cmdFieldFocusIn);
         this._cmdField.addEventListener(FocusEvent.FOCUS_OUT,this.on_cmdFieldFocusOut);
         this._cmdField.defaultTextFormat = commandFormat;
         addChild(this._cmdField);
         this._hintField = makeTF("hintField",true);
         this._hintField.mouseEnabled = false;
         this._hintField.x = this._cmdField.x;
         this._hintField.autoSize = TextFieldAutoSize.LEFT;
         addChild(this._hintField);
         this.doAction769();
         commandFormat.color = style.commandLineColor;
         this._cmdPrefx = new TextField();
         this._cmdPrefx.name = "commandPrefx";
         this._cmdPrefx.type = TextFieldType.DYNAMIC;
         this._cmdPrefx.x = 2;
         this._cmdPrefx.height = menuSize + 6;
         this._cmdPrefx.selectable = false;
         this._cmdPrefx.defaultTextFormat = commandFormat;
         this._cmdPrefx.addEventListener(MouseEvent.MOUSE_DOWN,this.on_cmdPrefxMouseDown);
         this._cmdPrefx.addEventListener(MouseEvent.MOUSE_MOVE,this.on_cmdPrefxMouseMove);
         this._cmdPrefx.addEventListener(MouseEvent.ROLL_OUT,this.on_cmdPrefxMouseMove);
         addChild(this._cmdPrefx);
         this._blinkLine = new Shape();
         this._blinkLine.name = "blinkLine";
         this._blinkLine.alpha = 0.2;
         addChild(this._blinkLine);
         this.scrollSprite1 = new Sprite();
         this.scrollSprite1.name = "scroller";
         this.scrollSprite1.tabEnabled = false;
         this.scrollSprite1.y = menuSize + 4;
         this.scrollSprite1.buttonMode = true;
         this.scrollSprite1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown3,false,0,true);
         this._scroll = new Sprite();
         this._scroll.name = "scrollbar";
         this._scroll.tabEnabled = false;
         this._scroll.y = style.controlSize;
         this._scroll.graphics.beginFill(style.controlColor,1);
         this._scroll.graphics.drawRect(-style.controlSize,0,style.controlSize,30);
         this._scroll.graphics.beginFill(0,0);
         this._scroll.graphics.drawRect(-style.controlSize * 2,0,style.controlSize * 2,30);
         this._scroll.graphics.endFill();
         this._scroll.addEventListener(MouseEvent.MOUSE_DOWN,this.on_scrollMouseDown,false,0,true);
         this.scrollSprite1.addChild(this._scroll);
         addChild(this.scrollSprite1);
         this._cmdField.visible = false;
         this._cmdPrefx.visible = false;
         this._cmdBG.visible = false;
         this.doAction259("");
         init(640,100,true);
         doAction246(txtField);
         if(console.so[CLHISTORY] is Array)
         {
            this._clhistory = console.so[CLHISTORY];
         }
         else
         {
            console.so[CLHISTORY] = this._clhistory = new Array();
         }
         if(config.rememberFilterSettings && console.so[VIEWING_CHANNELS] is Array)
         {
            this._viewingChannels = console.so[VIEWING_CHANNELS];
         }
         else
         {
            console.so[VIEWING_CHANNELS] = this._viewingChannels = new Array();
         }
         if(config.rememberFilterSettings && console.so[IGNORED_CHANNELS] is Array)
         {
            this._ignoredChannels = console.so[IGNORED_CHANNELS];
         }
         if(this._viewingChannels.length > 0 || this._ignoredChannels == null)
         {
            console.so[IGNORED_CHANNELS] = this._ignoredChannels = new Array();
         }
         if(config.rememberFilterSettings && console.so[PRIORITY] is uint)
         {
            this._priority = console.so[PRIORITY];
         }
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
         addEventListener(TextEvent.LINK,this.onLink,false,0,true);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage,false,0,true);
      }
      
      public function doAction890(param1:String, param2:Function, param3:Array, param4:String) : void
      {
         if(param1)
         {
            param1 = param1.replace(/[^\w]*/g,"");
            if(param2 == null)
            {
               delete this.obj19[param1];
            }
            else
            {
               this.obj19[param1] = new Array(param2,param3,param4);
            }
            flag53 = true;
         }
         else
         {
            console.report("ERROR: Invalid add menu params.",9);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown,true,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onStageKeyUp,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown,false,0,true);
      }
      
      private function onRemovedFromStage(param1:Event = null) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown,true);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.onStageKeyUp);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown);
      }
      
      private function onStageMouseDown(param1:MouseEvent) : void
      {
         flag24 = param1.shiftKey;
         flag106 = param1.ctrlKey;
         flag132 = param1.altKey;
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         var newFontSize:int = 0;
         if(this.flag24)
         {
            newFontSize = console.config.style.traceFontSize + (param1.delta > 0 ? 1 : -1);
            if(newFontSize > 10 && newFontSize < 20)
            {
               console.config.style.traceFontSize = newFontSize;
               console.config.style.updateStyleSheet();
               this.doAction560();
               param1.stopPropagation();
            }
         }
      }
      
      private function on_cmdPrefxMouseMove(param1:MouseEvent) : void
      {
         console.panels.tooltip(param1.type == MouseEvent.MOUSE_MOVE ? "Current scope::(CommandLine)" : "",this);
      }
      
      private function on_cmdPrefxMouseDown(param1:MouseEvent) : void
      {
         try
         {
            stage.focus = this._cmdField;
            this.doAction175();
         }
         catch(err:Error)
         {
         }
      }
      
      private function onStageKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SHIFT)
         {
            flag24 = true;
         }
         if(param1.keyCode == Keyboard.CONTROL)
         {
            flag106 = true;
         }
         if(param1.keyCode == 18)
         {
            flag132 = true;
         }
      }
      
      private function onStageKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.SHIFT)
         {
            flag24 = false;
         }
         else if(param1.keyCode == Keyboard.CONTROL)
         {
            flag106 = false;
         }
         else if(param1.keyCode == 18)
         {
            flag132 = false;
         }
         if((param1.keyCode == Keyboard.TAB || param1.keyCode == Keyboard.ENTER) && parent.visible && visible && this._cmdField.visible)
         {
            try
            {
               stage.focus = this._cmdField;
               this.doAction175();
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function requestLogin(param1:Boolean = true) : void
      {
         var transformValue:ColorTransform = new ColorTransform();
         if(param1)
         {
            console.commandLine = true;
            console.report("//",-2);
            console.report("// <b>Enter remoting password</b> in CommandLine below...",-2);
            this.doAction259("Password");
            transformValue.color = style.controlColor;
            this._cmdBG.transform.colorTransform = transformValue;
            this._traceField.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
         }
         else
         {
            this.doAction259("");
            this._cmdBG.transform.colorTransform = transformValue;
            this._traceField.transform.colorTransform = transformValue;
         }
         this._cmdField.displayAsPassword = param1;
         flag124 = param1;
      }
      
      public function update(param1:Boolean) : void
      {
         if(this._blinkLine.alpha > 0)
         {
            this._blinkLine.alpha -= 0.25;
         }
         if(style.showCommandLineScope)
         {
            if(this.str35 != console.cl.scopeString)
            {
               str35 = console.cl.scopeString;
               this.doAction259(this.str35);
            }
         }
         else if(this.str35 != null)
         {
            str35 = "";
            this.doAction259("");
         }
         if(param1)
         {
            this._blinkLine.alpha = 1;
            flag53 = true;
            flag128 = true;
         }
         if(this.flag128)
         {
            flag128 = false;
            this.doAction241(true);
         }
         if(this.flag53)
         {
            flag53 = false;
            this.doAction425();
         }
      }
      
      public function doAction560() : void
      {
         flag10 = true;
         flag128 = true;
      }
      
      private function doAction241(param1:Boolean = false) : void
      {
         if(this.flag10)
         {
            this.doAction114();
         }
         else if(!param1)
         {
            this.doAction35();
         }
         if(this.intValue89 != this.intValue28)
         {
            if(this.flag10)
            {
               this._traceField.setSelection(this._traceField.text.length - this.intValue89,this._traceField.text.length - this.intValue28);
            }
            else
            {
               this._traceField.setSelection(this._traceField.text.length - this.intValue28,this._traceField.text.length - this.intValue89);
            }
            intValue28 = -1;
            intValue89 = -1;
         }
      }
      
      private function doAction35() : void
      {
         var logHtml:String = "";
         var entry:Log = console.logs.first;
         var showChannel:Boolean = this._viewingChannels.length != 1;
         var showAll:Boolean = this._priority == 0 && this._viewingChannels.length == 0;
         while(entry)
         {
            if(showAll || this.check2(entry))
            {
               logHtml += this.getString15(entry,showChannel);
            }
            entry = entry.next;
         }
         flag126 = true;
         this._traceField.htmlText = "<logs>" + logHtml + "</logs>";
         flag126 = false;
         this.doAction15();
      }
      
      public function doAction229(param1:Boolean) : void
      {
         if(param1 && this.flag10)
         {
            flag10 = false;
            this.doAction241();
            this._traceField.scrollV = this._traceField.maxScrollV;
         }
         else if(!param1)
         {
            flag10 = true;
            this.doAction114();
         }
         this.updateMenu();
      }
      
      private function doAction114() : void
      {
         var logHtml:String = "";
         var remainingLines:int = Math.round(this._traceField.height / style.traceFontSize);
         var charsPerLine:int = Math.round(this._traceField.width * 5 / style.traceFontSize);
         var entry:Log = console.logs.last;
         var showChannel:Boolean = this._viewingChannels.length != 1;
         var entryLines:int;
         while(entry)
         {
            if(this.check2(entry))
            {
               entryLines = Math.ceil(entry.text.length / charsPerLine);
               if(entry.html || remainingLines >= entryLines)
               {
                  logHtml = this.getString15(entry,showChannel) + logHtml;
               }
               else
               {
                  entry = entry.clone();
                  entry.text = entry.text.substring(Math.max(0,entry.text.length - charsPerLine * remainingLines));
                  logHtml = this.getString15(entry,showChannel) + logHtml;
                  break;
               }
               remainingLines -= entryLines;
               if(remainingLines <= 0)
               {
                  break;
               }
            }
            entry = entry.log1;
         }
         flag126 = true;
         this._traceField.htmlText = "<logs>" + logHtml + "</logs>";
         this._traceField.scrollV = this._traceField.maxScrollV;
         flag126 = false;
         this.doAction15();
      }
      
      private function check2(param1:Log) : Boolean
      {
         return (this._priority == 0 || param1.priority >= this._priority) && (this.check14(param1.ch) || this._filterText && this._viewingChannels.indexOf(Console.CONSOLE_CONST4) >= 0 && param1.text.toLowerCase().indexOf(this._filterText) >= 0 || this._filterRegExp && this._viewingChannels.indexOf(Console.CONSOLE_CONST4) >= 0 && param1.text.search(this._filterRegExp) >= 0);
      }
      
      private function check14(param1:String) : Boolean
      {
         return (this._viewingChannels.length == 0 || this._viewingChannels.indexOf(param1) >= 0) && (this._ignoredChannels.length == 0 || this._ignoredChannels.indexOf(param1) < 0);
      }
      
      public function get reportChannel() : String
      {
         return this._viewingChannels.length == 1 ? this._viewingChannels[0] : Console.C2;
      }
      
      public function setViewingChannels(... rest) : void
      {
         var channelList:Array = new Array();
         var channelValue:Object;
         var channel:String;
         for each(channelValue in rest)
         {
            channelList.push(Console.getString10(channelValue));
         }
         if(this._viewingChannels[0] == LogReferences.LOG_REFERENCES_CONST1 && (!channelList || channelList[0] != this._viewingChannels[0]))
         {
            console.refs.exitFocus();
         }
         this._ignoredChannels.splice(0);
         this._viewingChannels.splice(0);
         if(channelList.indexOf(Console.CONSOLE_CONST1) < 0 && channelList.indexOf(null) < 0)
         {
            for each(channel in channelList)
            {
               this._viewingChannels.push(channel);
            }
         }
         this.doAction560();
         console.panels.updateMenu();
      }
      
      public function doAction156(... rest) : void
      {
         var channelList:Array = new Array();
         var channelValue:Object;
         var channel:String;
         for each(channelValue in rest)
         {
            channelList.push(Console.getString10(channelValue));
         }
         if(this._viewingChannels[0] == LogReferences.LOG_REFERENCES_CONST1)
         {
            console.refs.exitFocus();
         }
         this._ignoredChannels.splice(0);
         this._viewingChannels.splice(0);
         if(channelList.indexOf(Console.CONSOLE_CONST1) < 0 && channelList.indexOf(null) < 0)
         {
            for each(channel in channelList)
            {
               this._ignoredChannels.push(channel);
            }
         }
         this.doAction560();
         console.panels.updateMenu();
      }
      
      private function doAction300(param1:String = "") : void
      {
         if(param1)
         {
            _filterRegExp = null;
            _filterText = LogReferences.EscHTML(param1.toLowerCase());
            this.doAction878();
         }
         else
         {
            this.doAction386();
         }
      }
      
      private function doAction763(param1:String = "") : void
      {
         if(param1)
         {
            _filterText = null;
            _filterRegExp = new RegExp(LogReferences.EscHTML(param1),"gi");
            this.doAction878();
         }
         else
         {
            this.doAction386();
         }
      }
      
      private function doAction878() : void
      {
         console.clear(Console.CONSOLE_CONST4);
         console.logs.addChannel(Console.CONSOLE_CONST4);
         this.setViewingChannels(Console.CONSOLE_CONST4);
      }
      
      private function doAction386() : void
      {
         _filterRegExp = null;
         _filterText = null;
         if(this._viewingChannels.length == 1 && this._viewingChannels[0] == Console.CONSOLE_CONST4)
         {
            this.setViewingChannels(Console.CONSOLE_CONST1);
         }
      }
      
      private function getString15(param1:Log, param2:Boolean) : String
      {
         var prefixHtml:String = "<p>";
         if(param2)
         {
            prefixHtml += param1.str24;
         }
         if(config.showLineNumber)
         {
            prefixHtml += param1.str11;
         }
         if(config.showTimestamp)
         {
            prefixHtml += param1.timeStr;
         }
         var priorityTag:String = "p" + param1.priority;
         return prefixHtml + "<" + priorityTag + ">" + this.getString36(param1.text) + "</" + priorityTag + "></p>";
      }
      
      private function getString36(param1:String) : String
      {
         var matchResult:Object = null;
         var matchIndex:int = 0;
         var matchedText:String = null;
         var lowerText:String = null;
         var matchPosition:int = 0;
         if(this._filterRegExp)
         {
            this._filterRegExp.lastIndex = 0;
            matchResult = this._filterRegExp.exec(param1);
            while(matchResult != null)
            {
               matchIndex = matchResult.index;
               matchedText = matchResult[0];
               if(matchedText.search("<|>") >= 0)
               {
                  this._filterRegExp.lastIndex -= matchedText.length - matchedText.search("<|>");
               }
               else if(param1.lastIndexOf("<",matchIndex) <= param1.lastIndexOf(">",matchIndex))
               {
                  param1 = param1.substring(0,matchIndex) + "<u>" + param1.substring(matchIndex,matchIndex + matchedText.length) + "</u>" + param1.substring(matchIndex + matchedText.length);
                  this._filterRegExp.lastIndex += 7;
               }
               matchResult = this._filterRegExp.exec(param1);
            }
         }
         else if(this._filterText)
         {
            lowerText = param1.toLowerCase();
            matchPosition = lowerText.lastIndexOf(this._filterText);
            while(matchPosition >= 0)
            {
               param1 = param1.substring(0,matchPosition) + "<u>" + param1.substring(matchPosition,matchPosition + this._filterText.length) + "</u>" + param1.substring(matchPosition + this._filterText.length);
               matchPosition = lowerText.lastIndexOf(this._filterText,matchPosition - 2);
            }
         }
         return param1;
      }
      
      private function on_traceFieldScroll(param1:Event = null) : void
      {
         if(this.flag126 || this.flag24)
         {
            return;
         }
         var atBottom:Boolean = this._traceField.scrollV >= this._traceField.maxScrollV;
         var scrollOffset:int;
         if(!console.paused && this.flag10 != atBottom)
         {
            scrollOffset = this._traceField.maxScrollV - this._traceField.scrollV;
            intValue89 = this._traceField.text.length - this._traceField.selectionBeginIndex;
            intValue28 = this._traceField.text.length - this._traceField.selectionEndIndex;
            flag10 = atBottom;
            this.doAction241();
            this._traceField.scrollV = this._traceField.maxScrollV - scrollOffset;
         }
         this.doAction15();
      }
      
      private function doAction15() : void
      {
         if(this._traceField.maxScrollV <= 1)
         {
            this.scrollSprite1.visible = false;
         }
         else
         {
            this.scrollSprite1.visible = true;
            if(this.flag10)
            {
               propValue20 = 1;
            }
            else
            {
               propValue20 = (this._traceField.scrollV - 1) / (this._traceField.maxScrollV - 1);
            }
         }
      }
      
      private function onMouseDown3(param1:MouseEvent) : void
      {
         if(this._scroll.visible && this._scroll.mouseY > 0 || !this._scroll.visible && this.scrollSprite1.mouseY > this.numValue22 / 2)
         {
            intValue166 = 3;
         }
         else
         {
            intValue166 = -3;
         }
         this._traceField.scrollV += this.intValue166;
         uintValue26 = 0;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame3,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp3,false,0,true);
      }
      
      private function onEnterFrame3(param1:Event) : void
      {
         ++this.uintValue26;
         if(this.uintValue26 > 10)
         {
            uintValue26 = 9;
            if(this.intValue166 < 0 && this._scroll.y > this.scrollSprite1.mouseY || this.intValue166 > 0 && this._scroll.y + this._scroll.height < this.scrollSprite1.mouseY)
            {
               this._traceField.scrollV += this.intValue166;
            }
         }
      }
      
      private function onStageMouseUp3(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame3);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp3);
      }
      
      private function get propValue20() : Number
      {
         return (this._scroll.y - style.controlSize) / (this.numValue22 - 30 - style.controlSize * 2);
      }
      
      private function set propValue20(param1:Number) : void
      {
         this._scroll.y = style.controlSize + (this.numValue22 - 30 - style.controlSize * 2) * param1;
      }
      
      private function on_scrollMouseDown(param1:MouseEvent) : void
      {
         var scrollPosition:Number;
         flag45 = true;
         if(!console.paused && this.flag10)
         {
            flag10 = false;
            scrollPosition = this.propValue20;
            this.doAction241();
            propValue20 = scrollPosition;
         }
         this._scroll.startDrag(false,new Rectangle(0,style.controlSize,0,this.numValue22 - 30 - style.controlSize * 2));
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove3,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp4,false,0,true);
         param1.stopPropagation();
      }
      
      private function onStageMouseMove3(param1:MouseEvent) : void
      {
         flag126 = true;
         this._traceField.scrollV = Math.round(this.propValue20 * (this._traceField.maxScrollV - 1) + 1);
         flag126 = false;
      }
      
      private function onStageMouseUp4(param1:MouseEvent) : void
      {
         this._scroll.stopDrag();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove3);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp4);
         flag45 = false;
         this.on_traceFieldScroll();
      }
      
      override public function set width(param1:Number) : void
      {
         flag126 = true;
         super.width = param1;
         this._traceField.width = param1 - 4;
         txtField.width = param1 - 6;
         this._cmdField.width = width - 15 - this._cmdField.x;
         this._cmdBG.width = param1;
         this._blinkLine.graphics.clear();
         this._blinkLine.graphics.lineStyle(1,style.controlColor);
         this._blinkLine.graphics.moveTo(10,-1);
         this._blinkLine.graphics.lineTo(param1 - 10,-1);
         this.scrollSprite1.x = param1;
         flag10 = true;
         this.doAction355();
         flag53 = true;
         flag128 = true;
         flag126 = false;
      }
      
      override public function set height(param1:Number) : void
      {
         flag126 = true;
         var menuHeight:int = style.menuFontSize;
         var minimumHeight:Number = menuHeight + 6 + style.traceFontSize;
         if(height != param1)
         {
            flag85 = param1 < (this._cmdField.visible ? minimumHeight + menuHeight + 4 : minimumHeight);
         }
         super.height = param1;
         var menuHidden:Boolean = this.flag85 || !style.topMenu;
         this.doAction594();
         this._traceField.y = menuHidden ? 0 : menuHeight;
         this._traceField.height = param1 - (this._cmdField.visible ? menuHeight + 4 : 0) - (menuHidden ? 0 : menuHeight);
         var commandY:Number = param1 - (menuHeight + 6);
         this._cmdField.y = commandY;
         this._cmdPrefx.y = commandY;
         this._hintField.y = this._cmdField.y - this._hintField.height;
         this._cmdBG.y = commandY;
         this._blinkLine.y = this._cmdField.visible ? commandY : param1;
         this.scrollSprite1.y = menuHidden ? 6 : menuHeight + 4;
         var scrollControlSize:uint = style.controlSize;
         numValue22 = this._blinkLine.y - (this._cmdField.visible ? 0 : scrollControlSize * 2) - this.scrollSprite1.y;
         this._scroll.visible = this.numValue22 > 40;
         this.scrollSprite1.graphics.clear();
         if(this.numValue22 >= 10)
         {
            this.scrollSprite1.graphics.beginFill(style.controlColor,0.7);
            this.scrollSprite1.graphics.drawRect(-scrollControlSize,0,scrollControlSize,scrollControlSize);
            this.scrollSprite1.graphics.drawRect(-scrollControlSize,this.numValue22 - scrollControlSize,scrollControlSize,scrollControlSize);
            this.scrollSprite1.graphics.beginFill(style.controlColor,0.25);
            this.scrollSprite1.graphics.drawRect(-scrollControlSize,scrollControlSize,scrollControlSize,this.numValue22 - scrollControlSize * 2);
            this.scrollSprite1.graphics.beginFill(0,0);
            this.scrollSprite1.graphics.drawRect(-scrollControlSize * 2,scrollControlSize * 2,scrollControlSize * 2,this.numValue22 - scrollControlSize * 2);
            this.scrollSprite1.graphics.endFill();
         }
         flag10 = true;
         flag128 = true;
         flag126 = false;
      }
      
      private function doAction594() : void
      {
         var menuHidden:Boolean = this.flag85 || !style.topMenu;
         this._traceField.y = menuHidden ? 0 : txtField.y + txtField.height - 6;
         this._traceField.height = Math.max(0,height - (this._cmdField.visible ? style.menuFontSize + 4 : 0) - this._traceField.y);
      }
      
      public function updateMenu(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.doAction425();
         }
         else
         {
            flag53 = true;
         }
      }
      
      private function doAction425() : void
      {
         var menuHtml:String = "<r><high>";
         var hasExternalLinks:Boolean;
         var externalKey:String;
         if(this.flag85 || !style.topMenu)
         {
            menuHtml += "<menu><b> <a href=\"event:show\">‹</a>";
         }
         else
         {
            if(!console.panels.channelsPanel)
            {
               menuHtml += this.getChannelsLink(true);
            }
            menuHtml += "<menu> <b>";
            for(externalKey in this.obj19)
            {
               menuHtml += "<a href=\"event:external_" + externalKey + "\">" + externalKey + "</a> ";
               hasExternalLinks = true;
            }
            if(hasExternalLinks)
            {
               menuHtml += "¦ ";
            }
            menuHtml += this.getString55("<a href=\"event:fps\">F</a>",console.fpsMonitor > 0);
            menuHtml += this.getString55(" <a href=\"event:mm\">M</a>",console.memoryMonitor > 0);
            menuHtml += this.getString55(" <a href=\"event:command\">CL</a>",this.commandLine);
            if(console.remoter.remoting != Remoting.RECIEVER)
            {
               if(config.displayRollerEnabled)
               {
                  menuHtml += this.getString55(" <a href=\"event:roller\">Ro</a>",console.displayRoller);
               }
               if(config.rulerToolEnabled)
               {
                  menuHtml += this.getString55(" <a href=\"event:ruler\">RL</a>",console.panels.rulerActive);
               }
            }
            menuHtml += " ¦</b>";
            menuHtml += " <a href=\"event:copy\">Sv</a>";
            menuHtml += " <a href=\"event:priority\">P" + this._priority + "</a>";
            menuHtml += this.getString55(" <a href=\"event:pause\">P</a>",console.paused);
            menuHtml += " <a href=\"event:clear\">C</a> <a href=\"event:close\">X</a> <a href=\"event:hide\">›</a>";
         }
         menuHtml += " </b></menu></high></r>";
         txtField.htmlText = menuHtml;
         txtField.scrollH = txtField.maxScrollH;
         this.doAction594();
      }
      
      public function getChannelsLink(param1:Boolean = false) : String
      {
         var linksHtml:String = "<chs>";
         var channelList:Array = console.logs.getChannels();
         var visibleCount:int = channelList.length;
         if(param1 && visibleCount > style.maxChannelsInMenu)
         {
            visibleCount = style.maxChannelsInMenu;
         }
         var hasFilter:Boolean = this._viewingChannels.length > 0 || this._ignoredChannels.length > 0;
         var channelIndex:int = 0;
         var channel:String;
         var channelLabel:String;
         while(channelIndex < visibleCount)
         {
            channel = channelList[channelIndex];
            channelLabel = !hasFilter && channelIndex == 0 || hasFilter && channelIndex != 0 && this.check14(channel) ? "<ch><b>" + channel + "</b></ch>" : channel;
            linksHtml += "<a href=\"event:channel_" + channel + "\">[" + channelLabel + "]</a> ";
            channelIndex++;
         }
         if(param1)
         {
            linksHtml += "<ch><a href=\"event:channels\"><b>" + (channelList.length > visibleCount ? "..." : "") + "</b>^^ </a></ch>";
         }
         linksHtml += "</chs> ";
         return linksHtml;
      }
      
      private function getString55(param1:String, param2:Boolean) : String
      {
         if(param2)
         {
            return "<menuHi>" + param1 + "</menuHi>";
         }
         return param1;
      }
      
      public function onMenuRollOver(param1:TextEvent, param2:ConsolePanel = null) : void
      {
         if(param2 == null)
         {
            param2 = this;
         }
         var tooltipText:String = param1.text ? param1.text.replace("event:","") : "";
         var externalLink:Array;
         var tooltipMap:Object;
         if(tooltipText == "channel_" + Console.CONSOLE_CONST1)
         {
            tooltipText = "View all channels";
         }
         else if(tooltipText == "channel_" + Console.CONSOLE_CONST3)
         {
            tooltipText = "Default channel::Logs with no channel";
         }
         else if(tooltipText == "channel_" + Console.C2)
         {
            tooltipText = "Console\'s channel::Logs generated from Console";
         }
         else if(tooltipText == "channel_" + Console.CONSOLE_CONST4)
         {
            tooltipText = this._filterRegExp ? String(this._filterRegExp) : this._filterText;
            tooltipText = "Filtering channel" + "::*" + tooltipText + "*";
         }
         else if(tooltipText == "channel_" + LogReferences.LOG_REFERENCES_CONST1)
         {
            tooltipText = "Inspecting channel";
         }
         else if(tooltipText.indexOf("channel_") == 0)
         {
            tooltipText = "Change channel::shift: select multiple\nctrl: ignore channel";
         }
         else if(tooltipText == "pause")
         {
            if(console.paused)
            {
               tooltipText = "Resume updates";
            }
            else
            {
               tooltipText = "Pause updates";
            }
         }
         else if(tooltipText == "close" && param2 == this)
         {
            tooltipText = "Close::Type password to show again";
         }
         else if(tooltipText.indexOf("external_") == 0)
         {
            externalLink = this.obj19[tooltipText.substring(9)];
            if(externalLink)
            {
               tooltipText = externalLink[2];
            }
         }
         else
         {
            tooltipMap = {
               "fps":"Frames Per Second",
               "mm":"Memory Monitor",
               "roller":"Display Roller::Map the display list under your mouse",
               "ruler":"Screen Ruler::Measure the distance and angle between two points on screen.",
               "command":"Command Line",
               "copy":"Save to clipboard::shift: no channel name\nctrl: use viewing filters\nalt: save to file",
               "clear":"Clear log",
               "priority":"Priority filter::shift: previous priority\n(skips unused priorites)",
               "channels":"Expand channels",
               "close":"Close"
            };
            tooltipText = tooltipMap[tooltipText];
         }
         console.panels.tooltip(tooltipText,param2);
      }
      
      private function onLink(e:TextEvent) : void
      {
         txtField.setSelection(0,0);
         stopDrag();
         var t:String = e.text;
         if(t == "pause")
         {
            if(console.paused)
            {
               console.paused = false;
            }
            else
            {
               console.paused = true;
            }
            console.panels.tooltip(null);
         }
         else if(t == "hide")
         {
            console.panels.tooltip();
            flag85 = true;
            console.config.style.topMenu = false;
            height = height;
            this.updateMenu();
         }
         else if(t == "show")
         {
            console.panels.tooltip();
            flag85 = false;
            console.config.style.topMenu = true;
            height = height;
            this.updateMenu();
         }
         else if(t == "close")
         {
            console.panels.tooltip();
            visible = false;
            dispatchEvent(new Event(Event.CLOSE));
         }
         else if(t == "channels")
         {
            console.panels.channelsPanel = !console.panels.channelsPanel;
         }
         else if(t == "fps")
         {
            console.fpsMonitor = !console.fpsMonitor;
         }
         else if(t == "priority")
         {
            this.doAction353(this.flag24);
         }
         else if(t == "mm")
         {
            console.memoryMonitor = !console.memoryMonitor;
         }
         else if(t == "roller")
         {
            console.displayRoller = !console.displayRoller;
         }
         else if(t == "ruler")
         {
            console.panels.tooltip();
            console.panels.startRuler();
         }
         else if(t == "command")
         {
            commandLine = !this.commandLine;
         }
         else if(t == "copy")
         {
            var str:String = console.logs.getLogsAsString("\r\n",!this.flag24,this.flag106 ? this.check2 : null);
            if(this.flag132)
            {
               var file:FileReference = new FileReference();
               try
               {
                  file["save"](str,"log.txt");
               }
               catch(err:Error)
               {
                  console.report("Save to file is not supported in your flash player.",8);
               }
            }
            else
            {
               System.setClipboard(str);
               console.report("Copied log to clipboard.",-1);
            }
         }
         else if(t == "clear")
         {
            console.clear();
         }
         else if(t == "settings")
         {
            console.report("A new window should open in browser. If not, try searching for \'Flash Player Global Security Settings panel\' online :)",-1);
            Security.showSettings(SecurityPanel.SETTINGS_MANAGER);
         }
         else if(t == "remote")
         {
            console.remoter.remoting = Remoting.RECIEVER;
         }
         else if(t.indexOf("ref") == 0)
         {
            console.refs.handleRefEvent(t);
         }
         else if(t.indexOf("channel_") == 0)
         {
            this.onChannelPressed(t.substring(8));
         }
         else if(t.indexOf("cl_") == 0)
         {
            var ind:int = t.indexOf("_",3);
            console.cl.handleScopeEvent(uint(t.substring(3,ind < 0 ? t.length : ind)));
            if(ind >= 0)
            {
               this._cmdField.text = t.substring(ind + 1);
            }
         }
         else if(t.indexOf("external_") == 0)
         {
            var menu:Array = this.obj19[t.substring(9)];
            if(menu)
            {
               menu[0].apply(null,menu[1]);
            }
         }
         txtField.setSelection(0,0);
         e.stopPropagation();
      }
      
      public function onChannelPressed(param1:String) : void
      {
         var channelList:Array = null;
         if(this.flag106 && param1 != Console.CONSOLE_CONST1)
         {
            channelList = this.getArray6(this._ignoredChannels,param1);
            this.doAction156.apply(this,channelList);
         }
         else if(this.flag24 && param1 != Console.CONSOLE_CONST1 && this._viewingChannels[0] != LogReferences.LOG_REFERENCES_CONST1)
         {
            channelList = this.getArray6(this._viewingChannels,param1);
            this.setViewingChannels.apply(this,channelList);
         }
         else
         {
            console.setViewingChannels(param1);
         }
      }
      
      private function getArray6(param1:Array, param2:String) : Array
      {
         param1 = param1.concat();
         var channelIndex:int = param1.indexOf(param2);
         if(channelIndex >= 0)
         {
            param1.splice(channelIndex,1);
            if(param1.length == 0)
            {
               param1.push(Console.CONSOLE_CONST1);
            }
         }
         else
         {
            param1.push(param2);
         }
         return param1;
      }
      
      public function set priority(param1:uint) : void
      {
         _priority = param1;
         console.so[PRIORITY] = this._priority;
         this.doAction560();
         this.updateMenu();
      }
      
      public function get priority() : uint
      {
         return this._priority;
      }
      
      private function doAction353(param1:Boolean) : void
      {
         var nextPriority:uint = 10;
         var previousPriority:uint;
         var entry:Log = console.logs.last;
         var currentPriority:int = this._priority;
         _priority = 0;
         var remainingEntries:uint = 32000;
         while(entry && remainingEntries > 0)
         {
            remainingEntries--;
            if(this.check2(entry))
            {
               if(entry.priority > currentPriority && nextPriority > entry.priority)
               {
                  nextPriority = entry.priority;
               }
               if(entry.priority < currentPriority && previousPriority < entry.priority)
               {
                  previousPriority = entry.priority;
               }
            }
            entry = entry.log1;
         }
         if(param1)
         {
            if(previousPriority == currentPriority)
            {
               currentPriority = 10;
            }
            else
            {
               currentPriority = previousPriority;
            }
         }
         else if(nextPriority == currentPriority)
         {
            currentPriority = 0;
         }
         else
         {
            currentPriority = nextPriority;
         }
         priority = currentPriority;
      }
      
      private function doAction916(... rest) : void
      {
         intValue179 = -1;
         console.updateSO();
         _clhistory = new Array();
      }
      
      private function on_cmdFieldKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            if(this.onText)
            {
               this._cmdField.text = this.onText;
               this.doAction175();
               this.doAction769();
            }
         }
      }
      
      private function on_cmdFieldKeyUp(param1:KeyboardEvent) : void
      {
         var commandText:String = null;
         var historyIndex:int = 0;
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.doAction560();
            this.doAction769();
            if(this.flag124)
            {
               console.remoter.login(this._cmdField.text);
               this._cmdField.text = "";
               this.requestLogin(false);
            }
            else
            {
               commandText = this._cmdField.text;
               if(commandText.length > 2)
               {
                  historyIndex = this._clhistory.indexOf(commandText);
                  while(historyIndex >= 0)
                  {
                     this._clhistory.splice(historyIndex,1);
                     historyIndex = this._clhistory.indexOf(commandText);
                  }
                  this._clhistory.unshift(commandText);
                  intValue179 = -1;
                  if(this._clhistory.length > 20)
                  {
                     this._clhistory.splice(20);
                  }
                  console.updateSO(CLHISTORY);
               }
               this._cmdField.text = "";
               if(config.commandLineInputPassThrough != null)
               {
                  commandText = config.commandLineInputPassThrough(commandText);
               }
               if(commandText)
               {
                  console.cl.run(commandText);
               }
            }
         }
         else if(param1.keyCode == Keyboard.ESCAPE)
         {
            if(stage)
            {
               stage.focus = null;
            }
         }
         else if(param1.keyCode == Keyboard.UP)
         {
            this.doAction769();
            if(this._cmdField.text && this.intValue179 < 0)
            {
               this._clhistory.unshift(this._cmdField.text);
               ++this.intValue179;
            }
            if(this.intValue179 < this._clhistory.length - 1)
            {
               ++this.intValue179;
               this._cmdField.text = this._clhistory[this.intValue179];
               this.doAction175();
            }
            else
            {
               intValue179 = this._clhistory.length;
               this._cmdField.text = "";
            }
         }
         else if(param1.keyCode == Keyboard.DOWN)
         {
            this.doAction769();
            if(this.intValue179 > 0)
            {
               --this.intValue179;
               this._cmdField.text = this._clhistory[this.intValue179];
               this.doAction175();
            }
            else
            {
               intValue179 = -1;
               this._cmdField.text = "";
            }
         }
         else if(param1.keyCode == Keyboard.TAB)
         {
            this.doAction175();
         }
         else if(!this.flag124)
         {
            this.on_cmdFieldFocusIn();
         }
      }
      
      private function doAction175() : void
      {
         this._cmdField.setSelection(this._cmdField.text.length,this._cmdField.text.length);
      }
      
      private function on_cmdFieldFocusIn(param1:Event = null) : void
      {
         var commandText:String = this._cmdField.text;
         if(commandText && config.commandLineAutoCompleteEnabled && console.remoter.remoting != Remoting.RECIEVER)
         {
            try
            {
               this.doAction769(console.cl.getHintsFor(commandText,5));
               return;
            }
            catch(err:Error)
            {
            }
         }
         this.doAction769();
      }
      
      private function on_cmdFieldFocusOut(param1:Event) : void
      {
         this.doAction769();
      }
      
      private function doAction769(param1:Array = null) : void
      {
         var hintLines:Array = null;
         var hint:Array = null;
         var caretBounds:Rectangle = null;
         var secondHint:String = null;
         var hasCommonPrefix:Boolean = false;
         var charIndex:int = 0;
         if(param1 && param1.length)
         {
            onText = param1[0][0];
            if(param1.length > 1)
            {
               secondHint = param1[1][0];
               hasCommonPrefix = false;
               charIndex = 0;
               while(charIndex < secondHint.length)
               {
                  if(secondHint.charAt(charIndex) == this.onText.charAt(charIndex))
                  {
                     hasCommonPrefix = true;
                  }
                  else
                  {
                     if(hasCommonPrefix && this._cmdField.text.length < charIndex)
                     {
                        onText = this.onText.substring(0,charIndex);
                     }
                     break;
                  }
                  charIndex++;
               }
            }
            hintLines = new Array();
            for each(hint in param1)
            {
               hintLines.push("<p3>" + hint[0] + "</p3> <p0>" + (hint[1] ? hint[1] : "") + "</p0>");
            }
            this._hintField.htmlText = "<p>" + hintLines.reverse().join("\n") + "</p>";
            this._hintField.visible = true;
            caretBounds = this._cmdField.getCharBoundaries(this._cmdField.text.length - 1);
            if(!caretBounds)
            {
               caretBounds = new Rectangle();
            }
            this._hintField.x = this._cmdField.x + caretBounds.x + caretBounds.width + 30;
            this._hintField.y = height - this._hintField.height;
         }
         else
         {
            this._hintField.visible = false;
            onText = null;
         }
      }
      
      public function doAction259(param1:String) : void
      {
         if(this.flag124)
         {
            flag124 = false;
            this.requestLogin(false);
         }
         this._cmdPrefx.autoSize = TextFieldAutoSize.LEFT;
         this._cmdPrefx.text = param1;
         this.doAction355();
      }
      
      private function doAction355() : void
      {
         var availableWidth:Number = width - 48;
         if(this._cmdPrefx.width > 120 || this._cmdPrefx.width > availableWidth)
         {
            this._cmdPrefx.autoSize = TextFieldAutoSize.NONE;
            this._cmdPrefx.width = availableWidth > 120 ? 120 : availableWidth;
            this._cmdPrefx.scrollH = this._cmdPrefx.maxScrollH;
         }
         this._cmdField.x = this._cmdPrefx.width + 2;
         this._cmdField.width = width - 15 - this._cmdField.x;
         this._hintField.x = this._cmdField.x;
      }
      
      public function set commandLine(param1:Boolean) : void
      {
         if(param1)
         {
            this._cmdField.visible = true;
            this._cmdPrefx.visible = true;
            this._cmdBG.visible = true;
         }
         else
         {
            this._cmdField.visible = false;
            this._cmdPrefx.visible = false;
            this._cmdBG.visible = false;
         }
         flag53 = true;
         this.height = height;
      }
      
      public function get commandLine() : Boolean
      {
         return this._cmdField.visible;
      }
   }
}

