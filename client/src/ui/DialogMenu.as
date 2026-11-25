package ui
{
   import ui.buttons.TextLinkButton;
   import net.GameSocket;
   import flash.display.*;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class DialogMenu extends NuclearMenu
   {
      
      public static var DIALOG_MENU_WIDTH:int = 650;
      
      public static var DIALOG_MENU_HEIGHT:int = 350;
      
      private static const TRADER_NODE_ID:int = -1;
      
      private static const MED_NODE_ID:int = -2;
      
      private static const FIX_NODE_ID:int = -3;
      
      private var botScroll:ScrollSprite;
      
      private var answerScroll:ScrollSprite;
      
      private var socket:GameSocket;
      
      private var botTextLbl:TextField;
      
      private var scrollV:int;
      
      private var sessionId:int;
      
      private var playerName:String;
      
      public function DialogMenu(param1:GameSocket, param2:Array, param3:String, param4:Boolean)
      {
         super();
         this.playerName = param3;
         if(param4)
         {
            this.sessionId = 0;
         }
         else
         {
            this.sessionId = param2[1];
         }
         this.socket = param1;
         graphics.beginFill(1776411,1);
         graphics.drawRect(0,0,650,350);
         var leftTop:Bitmap = frameLeftTop;
         var leftEdge:Bitmap = frameLeft;
         var leftBottom:Bitmap = frameLeftBottom;
         var topEdge:Bitmap = frameTop;
         var bottomEdge:Bitmap = frameBottom;
         var rightTop:Bitmap = frameRightTop;
         var rightEdge:Bitmap = frameRight;
         var rightBottom:Bitmap = frameRightBottom;
         var avatarLoader:Loader = new Loader();
         if(param4)
         {
            avatarRequest = new URLRequest("icons/avatar/av" + param2[2] + ".jpg");
         }
         else
         {
            avatarRequest = new URLRequest("icons/avatar/av" + param2[3] + ".jpg");
         }
         avatarLoader.load(avatarRequest);
         var avatarRequest:URLRequest;
         var portraitTop:Bitmap = getBmp("FRAM_TOP");
         var portraitLeft:Bitmap = getBmp("FRAM_LEFT");
         var portraitRight:Bitmap = getBmp("FRAM_RIGHT");
         var portraitBottom:Bitmap = getBmp("FRAM_BOTTOM");
         var backgroundBitmap:Bitmap = getBmp("DIALOG_WINDOW_BG");
         var lampBitmap:Bitmap = getBmp("LAMP");
         var wallBitmap:Bitmap = getBmp("WALL");
         drawTile(backgroundBitmap,4,3,backgroundBitmap.width,350);
         draw(wallBitmap,19,-4);
         draw(leftTop,0,-4);
         drawTile(leftEdge,0,leftTop.height - 4,leftEdge.width,362 - leftTop.height - leftBottom.height);
         draw(leftBottom,0,358 - leftBottom.height);
         drawTile(topEdge,leftTop.width,-4,654 - leftTop.width * 2,topEdge.height);
         drawTile(bottomEdge,leftTop.width,358 - bottomEdge.height,654 - leftTop.width * 2,topEdge.height);
         drawTile(rightEdge,651 - rightEdge.width,rightTop.height - 4,rightEdge.width,366 - rightTop.height - rightBottom.height);
         draw(rightBottom,650 - rightEdge.width,358 - rightBottom.height);
         draw(rightTop,650 - rightEdge.width,-4);
         draw(portraitTop,rightEdge.width + portraitTop.width - 80,13);
         draw(portraitLeft,rightEdge.width + portraitTop.width - 80,13 + portraitTop.height);
         draw(portraitRight,rightEdge.width + portraitTop.width + 3 + avatarLoader.width + 4,13 + portraitTop.height);
         draw(portraitBottom,rightEdge.width + portraitTop.width - 80,13 + portraitTop.height + portraitRight.height);
         avatarLoader.x = rightEdge.width + portraitTop.width + portraitLeft.width - 80;
         avatarLoader.y = 13 + portraitTop.height;
         var nameFormat:TextFormat = new TextFormat();
         nameFormat.font = "Verdana";
         nameFormat.color = 13408563;
         nameFormat.size = 14;
         nameFormat.bold = true;
         var nameField:TextField = new TextField();
         nameField.width = 400;
         nameField.height = 24;
         nameField.defaultTextFormat = nameFormat;
         nameField.x = 150;
         nameField.y = 10;
         nameField.selectable = false;
         if(param4)
         {
            nameField.text = param2[1].toString();
         }
         else
         {
            nameField.text = param2[2] + "[" + param2[4] + "]";
         }
         addChild(nameField);
         addChild(avatarLoader);
      }
      
      override public function createMenu() : void
      {
         create(DIALOG_MENU_WIDTH,DIALOG_MENU_HEIGHT,true,1776411,0);
         if(Main.UserCharacter.level > 0)
         {
            addCloseButton(613,10,new CLOSE(),new CLOSE_OVER(),new CLOSE_PRESSED());
         }
      }
      
      override public function closeHandler() : void
      {
         this.socket.sendStr("dl");
         super.closeHandler();
      }
      
      public function parseDialogNode(param1:Array, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : int
      {
         if(this.botScroll)
         {
            removeUIChild(this.botScroll);
         }
         if(this.answerScroll)
         {
            removeUIChild(this.answerScroll);
         }
         var dialogFormat:TextFormat = new TextFormat();
         dialogFormat.font = "Verdana";
         dialogFormat.color = 13408563;
         dialogFormat.size = 10;
         dialogFormat.bold = true;
         dialogFormat.align = "left";
         botTextLbl = addSimpleTextField(0,0,"",10,450,10);
         this.botTextLbl.defaultTextFormat = dialogFormat;
         this.botTextLbl.wordWrap = true;
         this.botTextLbl.text = param1[param2].replace("*НИК*",this.playerName);
         this.botTextLbl.height = this.botTextLbl.textHeight + 6;
         botScroll = new ScrollSprite(482,120,4);
         this.botScroll.x = 150;
         this.botScroll.y = 45;
         addUIChild(this.botScroll);
         this.botScroll.addLine(this.botTextLbl);
         this.botScroll.init(this.botTextLbl.height);
         answerScroll = new ScrollSprite(482,154,4);
         this.answerScroll.x = 150;
         this.answerScroll.y = 185;
         addUIChild(this.answerScroll);
         var answerY:int = 0;
         this.botScroll.init();
         param2++;
         var answerNumber:int = 1;
         var answerButton:TextLinkButton;
         while(param2 < param1.length - 1)
         {
            answerButton = this.addTextButton(param1[param2],0,answerY,answerNumber + ". " + param1[param2 + 1].replace("*НИК*",this.playerName));
            answerY += answerButton.height;
            param2 += 2;
            answerNumber++;
         }
         if(param3)
         {
            answerButton = this.addTextButton(TRADER_NODE_ID,0,answerY,answerNumber + ". " + getString("IDS_DIALOG_BARTER"));
            answerY += answerButton.height;
            answerNumber++;
         }
         if(param4)
         {
            answerButton = this.addTextButton(MED_NODE_ID,0,answerY,answerNumber + ". " + getString("IDS_DIALOG_MED"));
            answerY += answerButton.height;
            answerNumber++;
         }
         if(param5)
         {
            answerButton = this.addTextButton(FIX_NODE_ID,0,answerY,answerNumber + ". " + getString("IDS_DIALOG_REPAIR"));
            answerY += answerButton.height;
            answerNumber++;
         }
         this.answerScroll.init(answerY);
         return param2;
      }
      
      protected function addTextButton(param1:int, param2:int, param3:int, param4:String) : TextLinkButton
      {
         var button:TextLinkButton = new TextLinkButton(this.clickHandler,param4,472);
         button.value = param1;
         button.x = param2;
         button.y = param3;
         this.answerScroll.addContent(button);
         return button;
      }
      
      public function clickHandler(param1:Object) : void
      {
         var nodeId:int = param1.value;
         switch(nodeId)
         {
            case TRADER_NODE_ID:
               this.closeHandler();
               this.socket.sendActionRequest(this.sessionId,GameSocket.ACTION_BARTER);
               break;
            case MED_NODE_ID:
               this.closeHandler();
               this.socket.sendActionRequest(this.sessionId,GameSocket.ACTION_ASK_HEAL);
               break;
            case FIX_NODE_ID:
               this.closeHandler();
               this.socket.sendActionRequest(this.sessionId,GameSocket.ACTION_ASK_REPAIR);
               break;
            default:
               this.socket.sendStr("da|" + nodeId);
               break;
         }
      }
   }
}

