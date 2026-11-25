package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import game.*;
   import ui.*;
   
   public class ClanProductMenu extends TitledMenu
   {
      
      private static const WIDTH:int = 560;
      
      private static const HEIGHT:int = 360;
      
      private var cellId:int;
      
      private var extendCount:int;
      
      private var baseSize:int;
      
      private var extendSize:int;
      
      private var extendPrice:int;
      
      private var maxExtendCount:int;
      
      private var clanMoney:int;
      
      private var extendButton:NButton;
      
      private var sizeText:TextField;
      
      private var moneyText:TextField;
      
      public function ClanProductMenu(fields:Array)
      {
         super(TYPE_CLAN_PRODUCT,_("IDS_CLAN_PRODUCT_DEPOD_MENU"),WIDTH,HEIGHT);
         drawWindowBg();
         var cellImage:Bitmap = getBmp("CLAN_PRODUCT_CELL");
         draw(cellImage,(WIDTH - cellImage.width) / 2,(HEIGHT - cellImage.height) / 2 - 20);
         addButton(17,HEIGHT - 41,_("IDS_ENTER"),this.onEnterClick);
         this.extendButton = createButton(123,HEIGHT - 41,_("IDS_EXTEND"),this.onExtendClick);
         addUIChild(this.extendButton);
         var label:TextField = addTextLabel(50,HEIGHT - 68,_("IDS_CELL_SIZE"),NTextFormat.titleFormat.left);
         graphics.beginFill(2762011);
         graphics.lineStyle(1,3156252);
         graphics.drawRect(3 + label.x + label.width,label.y,82,18);
         graphics.endFill();
         this.sizeText = addTextLabel(label.x + 6 + label.width,label.y,"0",NTextFormat.titleFormat.propValue12,78);
         label = addTextLabel(95 + label.x + label.width,label.y,_("IDS_DEPOD_CLAN_MONEY"),NTextFormat.titleFormat.left);
         graphics.beginFill(2762011);
         graphics.lineStyle(1,3156252);
         graphics.drawRect(3 + label.x + label.width,label.y,WIDTH - (label.x + label.width + 37),18);
         graphics.endFill();
         var silverIcon:Bitmap = getBmp("V_SILVER");
         silverIcon.x = 7 + label.x + label.width;
         silverIcon.y = label.y + 4;
         addChild(silverIcon);
         this.moneyText = addTextLabel(label.x + label.width + 23,label.y,"0",NTextFormat.titleFormat.left.propValue12,WIDTH - (label.x + label.width + 37));
         this.parseData(fields);
      }
      
      public function parseData(fields:Array) : void
      {
         var offset:int = 2;
         cellId = fields[offset++];
         extendCount = fields[offset++];
         baseSize = fields[offset++];
         extendSize = fields[offset++];
         var cellSize:int = (this.baseSize + this.extendCount * this.extendSize) / 1000;
         this.sizeText.text = Chat.formatNumber(cellSize);
         extendPrice = fields[offset++];
         maxExtendCount = fields[offset++];
         clanMoney = fields[offset++];
         this.moneyText.text = formatString("IDS_MONEY_TEMPLATE",this.clanMoney);
         this.extendButton.enabled = true;
      }
      
      private function onExtendClick(sender:Object) : void
      {
         if(this.extendCount >= this.maxExtendCount)
         {
            showNotification(_("IDS_NOTIFICATION_69"));
         }
         else if(this.extendPrice > this.clanMoney)
         {
            showNotification(formatString("IDS_NOTIFICATION_13",this.extendPrice,this.clanMoney));
         }
         else
         {
            showModal(new QuestionMenu(formatString("IDS_EXTEND_CELL_NOTIFICATION",(this.baseSize + (this.extendCount + 1) * this.extendSize) / 1000,this.extendPrice),function(param1:Object):void
            {
               GameSocket.socket.send(Commands.COMMANDS_CONST10);
               extendButton.enabled = false;
            }));
         }
      }
      
      private function onEnterClick(sender:Object) : void
      {
         GameSocket.socket.sendLogin(this.cellId,"");
         closeMenu();
      }
   }
}

