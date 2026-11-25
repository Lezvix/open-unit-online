package ui
{
   import ui.buttons.ChannelButton;
   import flash.text.TextField;
   import game.Client;
   
   public class ChatLog extends ScrollSprite
   {
      
      public static const MAX_LINES:int = 150;
      
      protected var isSelecting:Boolean = false;
      
      protected var startIdx:int;
      
      protected var endIdx:int;
      
      protected var tf:TextField = new TextField();
      
      protected var _channelButton:ChannelButton;
      
      public function ChatLog(logWidth:int, logHeight:int, button:ChannelButton)
      {
         super(logWidth,logHeight);
         this._channelButton = button;
         this.tf.multiline = true;
         this.tf.wordWrap = true;
         this.tf.width = logWidth - 15;
         this.tf.selectable = true;
         this.tf.text = "";
         uiContainer.addChild(this.tf);
         uiContainer.height = logHeight;
         uiContainer.enabled = false;
         disposeOnRemove = false;
      }
      
      public function get channel() : int
      {
         return this.channelButton.channel;
      }
      
      public function get channelButton() : ChannelButton
      {
         return this._channelButton;
      }
      
      public function addLogText(time:String, str:String, format:NTextFormat) : void
      {
         str = "(" + time + ") " + str;
         var lines:Array = str.split("\r");
         var i:int = 0;
         while(i < lines.length)
         {
            this.tf.appendText(lines[i] + "\n");
            this.tf.setTextFormat(format,this.tf.text.length - (lines[i].length + 1),this.tf.text.length);
            i++;
         }
         if(this.tf.numLines > MAX_LINES)
         {
            this.tf.replaceText(0,this.tf.getLineOffset(this.tf.numLines - MAX_LINES),"");
         }
         this.tf.height = this.tf.textHeight + 5;
         this.init();
         if(!this.channelButton.toggled)
         {
            this.channelButton.setNotification();
         }
      }
      
      public function addText(time:String, author:String, str:String, format:NTextFormat) : void
      {
         if(author != Main.UserCharacter.name && str.indexOf(Client._("IDS_CHAT_TO",Main.UserCharacter.name)) != -1)
         {
            format = format.derive({"color":12487904});
         }
         str = "(" + time + ") <" + author + "> : " + str;
         var lines:Array = str.split("\r");
         var i:int = 0;
         while(i < lines.length)
         {
            this.tf.appendText(lines[i] + "\n");
            this.tf.setTextFormat(format,this.tf.text.length - (lines[i].length + 1),this.tf.text.length);
            i++;
         }
         if(this.tf.numLines > MAX_LINES)
         {
            this.tf.replaceText(0,this.tf.getLineOffset(this.tf.numLines - MAX_LINES),"");
         }
         this.tf.height = this.tf.textHeight + 5;
         this.init();
         if(!this.channelButton.toggled)
         {
            this.channelButton.setNotification();
         }
      }
      
      override public function clear() : void
      {
         this.tf.text = "";
         this.tf.height = this.tf.textHeight + 5;
         this.init();
         this.channelButton.resetNotification();
      }
      
      override public function set width(value:Number) : void
      {
         if(value != width)
         {
            initWidth = value;
            maskShape.graphics.clear();
            maskShape.graphics.beginFill(0,0);
            maskShape.graphics.drawRect(0,0,initWidth,initHeight);
            maskShape.width = initWidth;
            maskShape.height = initHeight;
            uiContainer.graphics.clear();
            uiContainer.graphics.beginFill(0,0);
            uiContainer.graphics.drawRect(0,0,initWidth,initHeight);
            uiContainer.graphics.endFill();
            scroll.x = initWidth - 7;
            super.width = value;
            this.tf.width = width - 15;
            this.tf.height = this.tf.textHeight + 5;
            this.init();
         }
      }
      
      override public function init(contentHeight:int = -1, scrollPos:int = 0, resetScroll:Boolean = true) : void
      {
         super.init(this.tf.height,int.MAX_VALUE);
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function mouseMoveHandler() : void
      {
         if(this.isSelecting)
         {
            this.updateMousePos();
         }
      }
      
      override public function mouseDownHandler() : void
      {
         var line:int = 0;
         startIdx = this.tf.getCharIndexAtPoint(uiContainer.mouseX,uiContainer.mouseY);
         if(this.startIdx != -1)
         {
            endIdx = this.startIdx;
            this.tf.setSelection(this.startIdx,this.endIdx);
            isSelecting = true;
         }
         else
         {
            line = this.tf.getLineIndexAtPoint(uiContainer.mouseX,uiContainer.mouseY);
            if(line != -1)
            {
               startIdx = this.tf.getLineOffset(line) + this.tf.getLineLength(line);
               if(this.startIdx >= 0)
               {
                  endIdx = this.startIdx;
                  this.tf.setSelection(this.startIdx,this.endIdx);
                  isSelecting = true;
               }
               else
               {
                  this.tf.setSelection(this.tf.text.length,this.tf.text.length);
               }
            }
            else
            {
               this.tf.setSelection(this.tf.text.length,this.tf.text.length);
            }
         }
         stage.focus = this.tf;
         super.mouseDownHandler();
      }
      
      protected function updateMousePos() : void
      {
         var line:int = 0;
         endIdx = this.tf.getCharIndexAtPoint(uiContainer.mouseX,uiContainer.mouseY);
         if(this.endIdx == -1)
         {
            line = this.tf.getLineIndexAtPoint(uiContainer.mouseX,uiContainer.mouseY);
            if(line != -1)
            {
               endIdx = this.tf.getLineOffset(line) + this.tf.getLineLength(line);
               if(this.endIdx < 0)
               {
                  endIdx = this.tf.text.length;
               }
            }
            else
            {
               endIdx = this.tf.text.length;
            }
         }
         this.tf.setSelection(this.startIdx,this.endIdx);
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.isSelecting)
         {
            this.updateMousePos();
            isSelecting = false;
         }
         super.mouseUpHandler();
      }
   }
}

