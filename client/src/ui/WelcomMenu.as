package ui
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class WelcomMenu extends NuclearMenu
   {
      
      public static var WELCOM_MENU_WIDTH:int = 626;
      
      public static var WELCOM_MENU_HEIGHT:int = 336;
      
      private static var SCROLLT_X:int = 11;
      
      private static var SCROLLT_Y:int = 57;
      
      private static var SCROLLT_WIDTH:int = 607;
      
      private static var SCROLLT_HEIGHT:int = 161;
      
      public function WelcomMenu(terminal:Terminal, params:Object)
      {
         var headerFormat:TextFormat = null;
         var textFormat:TextFormat = null;
         super();
         dragable = false;
         draw(getBmp("GERB_SPR"),12,3);
         headerFormat = new TextFormat();
         headerFormat.font = "Verdana";
         headerFormat.color = 13408825;
         headerFormat.bold = true;
         headerFormat.size = 12;
         textFormat = new TextFormat();
         textFormat.font = "Verdana";
         textFormat.color = 13408825;
         textFormat.size = 12;
         var welcomeText:TextField = new TextField();
         welcomeText.wordWrap = true;
         welcomeText.width = SCROLLT_WIDTH - 15;
         welcomeText.defaultTextFormat = textFormat;
         welcomeText.text = _("IDS_WELCOM_TEXT",int(Math.random() * 90000) + 10000,terminal.terminalNumber);
         welcomeText.height = welcomeText.textHeight + 4;
         var scroll:ScrollSprite = new ScrollSprite(SCROLLT_WIDTH,SCROLLT_HEIGHT,4);
         scroll.addLine(welcomeText);
         scroll.x = SCROLLT_X;
         scroll.y = SCROLLT_Y;
         scroll.init();
         addUIChild(scroll);
         var header:TextField = createTextField(69,2,543,headerFormat,getString("IDS_WELCOM_HEADER"),56);
         header.wordWrap = true;
         addChild(header);
         drawRect(0,0,625,225,13408825);
         drawHLine(4,50,618,13408825);
         addUIChild(createTextButton(526,234,getString("IDS_EXIT"),this.closeBtnHandler));
      }
      
      private function closeBtnHandler(sender:Object) : void
      {
         closeHandler();
      }
      
      override public function createMenu() : void
      {
         create(WELCOM_MENU_WIDTH,WELCOM_MENU_HEIGHT,false,0);
      }
   }
}

