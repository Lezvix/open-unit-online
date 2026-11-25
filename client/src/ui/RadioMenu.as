package ui
{
   import net.GameSocket;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class RadioMenu extends NuclearMenu
   {
      
      public static var RADIO_MENU_WIDTH:int = 625;
      
      public static var RADIO_MENU_HEIGHT:int = 336;
      
      private var loginInput:NTextInput;
      
      private var serverText:TextField;
      
      private var xCoordTF:TextField;
      
      private var yCoordTF:TextField;
      
      private var startFlag:Boolean;
      
      private var userFound:Boolean = false;
      
      private var iCoord:int;
      
      private var jCoord:int;
      
      public var showMapI:int;
      
      public var showMapJ:int;
      
      private var socket:GameSocket;
      
      public function RadioMenu(gameSocket:GameSocket, terminal:Terminal, params:Object)
      {
         super();
         this.socket = gameSocket;
         gameSocket.sendRadiolocationRequest();
      }
      
      public function parseData(fields:Array) : void
      {
         if(fields[1] == "0")
         {
            this.createCommon();
            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 16711680;
            format.size = 12;
            format.align = TextFormatAlign.CENTER;
            var textField:TextField = new TextField();
            textField.defaultTextFormat = format;
            textField.x = 100;
            textField.width = RADIO_MENU_WIDTH - 200;
            textField.y = 90;
            textField.multiline = true;
            textField.wordWrap = true;
            textField.text = getString("IDS_RLS_NOT_AVAIBLE");
            addChild(textField);
         }
         else
         {
            this.createRadiolocation(fields);
         }
      }
      
      private function createCommon() : void
      {
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = 13408825;
         format.size = 12;
         drawRect(0,0,625,225,13408825);
         drawHLine(4,22,617,13408825);
         addChild(createTextField(14,3,400,format,getString("IDS_RADIOLOCATION"),18));
         addUIChild(createTextButton(526,230,getString("IDS_BACK"),this.closeBtnHandler));
      }
      
      public function createRadiolocation(fields:Array) : void
      {
         this.createCommon();
         var labelFormat:TextFormat = new TextFormat();
         labelFormat.font = "Verdana";
         labelFormat.color = 13408825;
         labelFormat.size = 12;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 12;
         rightFormat.align = TextFormatAlign.RIGHT;
         var errorFormat:TextFormat = new TextFormat();
         errorFormat.font = "Verdana";
         errorFormat.color = 16711680;
         errorFormat.size = 12;
         errorFormat.align = TextFormatAlign.CENTER;
         var centerFormat:TextFormat = new TextFormat();
         centerFormat.font = "Verdana";
         centerFormat.color = 13408825;
         centerFormat.size = 12;
         centerFormat.align = TextFormatAlign.CENTER;
         loginInput = createTextInput(204,72,180);
         this.loginInput.maxChars = 16;
         this.loginInput.text = getString("IDS_INPUT_USER_LOGIN");
         startFlag = true;
         this.loginInput.onClick = this.onTextClick;
         addUIChild(this.loginInput);
         addUIChild(createTextButton(395,72,getString("IDS_SEARCH"),this.searchHandler));
         addUIChild(createTextButton(247,155,getString("IDS_SHOW_ON_MAP"),this.showOnMapHandler,0,BUTTON_BIG));
         serverText = createTextField(0,110,RADIO_MENU_WIDTH,errorFormat,"",18);
         addChild(this.serverText);
         addChild(createTextField(190,132,300,labelFormat,getString("IDS_TARGET_COORDS"),18));
         addChild(createTextField(338,132,50,labelFormat,getString("IDS_X"),18));
         addChild(createTextField(395,132,50,labelFormat,getString("IDS_Y"),18));
         ndrawRoundRect(352,132,36,16,13408825,1);
         ndrawRoundRect(409,132,36,16,13408825,1);
         xCoordTF = createTextField(352,132,37,centerFormat,"",18);
         yCoordTF = createTextField(409,132,37,centerFormat,"",18);
         addChild(this.xCoordTF);
         addChild(this.yCoordTF);
      }
      
      private function onTextClick(sender:Object) : void
      {
         if(this.startFlag)
         {
            startFlag = false;
            this.loginInput.text = "";
         }
      }
      
      public function parseRadiolocation(fields:Array) : void
      {
         var timeLeft:int = 0;
         var terminalNumber:int = 0;
         if(fields[1] == "0")
         {
            userFound = false;
            timeLeft = fields[2];
            if(timeLeft > 0)
            {
               this.serverText.text = getString("IDS_RLS_TIME_LEFT").replace("%s",Math.ceil(timeLeft / 1000));
            }
            else
            {
               this.serverText.text = getString("IDS_USER_NOT_AVAIBLE");
            }
         }
         else
         {
            terminalNumber = fields[2];
            if(terminalNumber > 0)
            {
               userFound = false;
               this.serverText.text = getString("IDS_RLS_TERMINAL").replace("%s",terminalNumber.toString());
            }
            else
            {
               userFound = true;
               iCoord = int(fields[3]) / 2;
               jCoord = int(fields[4]) / 2;
               this.xCoordTF.text = this.jCoord.toString();
               this.yCoordTF.text = this.iCoord.toString();
               this.serverText.text = "";
            }
         }
      }
      
      private function showOnMapHandler(sender:Object) : void
      {
         if(this.userFound)
         {
            showMapI = this.iCoord;
            showMapJ = this.jCoord;
            this.socket.sendGetMap();
         }
      }
      
      private function searchHandler(sender:Object) : void
      {
         if(!this.startFlag)
         {
            this.socket.sendRemovePrivateHire(this.loginInput.text);
         }
      }
      
      private function closeBtnHandler(sender:Object) : void
      {
         closeHandler();
      }
      
      override public function createMenu() : void
      {
         create(RADIO_MENU_WIDTH,RADIO_MENU_HEIGHT,false,0);
      }
   }
}

