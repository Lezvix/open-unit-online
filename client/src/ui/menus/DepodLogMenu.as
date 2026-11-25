package ui.menus
{
   import ui.buttons.PageButton;
   import net.GameSocket;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ui.ScrollSprite;
   import ui.NUIComponent;
   import ui.NTextFormat;
   
   public class DepodLogMenu extends TitledMenu
   {
      
      private static const WIDTH:int = 600;
      
      private static const HEIGHT:int = 360;
      
      private var logScroll:ScrollSprite;
      
      private var pagesPanel:NUIComponent;
      
      public function DepodLogMenu(fields:Array)
      {
         super(TYPE_DEPOD_LOG,_("IDS_CELL_STATISTIC"),WIDTH,HEIGHT);
         addTextLabel(164,40,_("IDS_OPERATION_TYPE"),NTextFormat.titleFormat,140);
         addTextLabel(304,40,_("IDS_CELL_ITEM"),NTextFormat.titleFormat,140);
         addTextLabel(444,40,_("IDS_CELL_COUNT"),NTextFormat.titleFormat,120);
         addChild(createLabel(20,331,_("IDS_PAGES"),NTextFormat.plain.strong,200));
         this.logScroll = new ScrollSprite(563,270,11);
         this.logScroll.x = 20;
         this.logScroll.y = 61;
         addUIChild(this.logScroll);
         this.update(fields);
      }
      
      public function update(fields:Array) : void
      {
         var offset:int = 1;
         var pageCount:int = fields[offset++];
         var page:int = fields[offset++];
         var recordCount:int = fields[offset++];
         this.logScroll.clear();
         var i:int = 0;
         var year:int;
         var month:int;
         var day:int;
         var hours:int;
         var minutes:int;
         var operation:int;
         var playerName:String;
         var itemName:String;
         var count:int;
         var cellBg:Sprite;
         var timeStr:String;
         var dateStr:String;
         while(i < recordCount)
         {
            year = (0 | fields[offset++]) + 1900;
            month = fields[offset++];
            day = fields[offset++];
            hours = fields[offset++];
            minutes = fields[offset++];
            operation = fields[offset++];
            playerName = fields[offset++];
            itemName = fields[offset++];
            count = fields[offset++];
            cellBg = new Sprite();
            cellBg.graphics.beginFill(2762011);
            cellBg.graphics.drawRect(0,0,138,28);
            cellBg.graphics.beginFill(3156252);
            cellBg.graphics.drawRect(0,0,138,1);
            cellBg.graphics.drawRect(0,0,1,28);
            cellBg.graphics.drawRect(138 - 1,0,1,28);
            cellBg.graphics.drawRect(0,28 - 1,138,1);
            cellBg.graphics.endFill();
            cellBg.y = 34 * i;
            this.logScroll.addLine(cellBg);
            cellBg = new Sprite();
            cellBg.graphics.beginFill(2762011);
            cellBg.graphics.drawRect(0,0,403,28);
            cellBg.graphics.beginFill(3156252);
            cellBg.graphics.drawRect(0,0,403,1);
            cellBg.graphics.drawRect(0,0,1,28);
            cellBg.graphics.drawRect(403 - 1,0,1,28);
            cellBg.graphics.drawRect(0,28 - 1,403,1);
            cellBg.graphics.endFill();
            cellBg.x = 145;
            cellBg.y = 34 * i;
            this.logScroll.addLine(cellBg);
            this.logScroll.addLine(createLabel(145,34 * i + 6,_("IDS_CELL_OP_" + operation),NTextFormat.plain.center,140));
            this.logScroll.addLine(createLabel(286,34 * i + 6,itemName,NTextFormat.plain.center,140));
            this.logScroll.addLine(createLabel(427,34 * i + 6,count + _("IDS_COUNT_SHORT"),NTextFormat.plain.center,121));
            this.logScroll.addLine(createLabel(9,34 * i + 0,playerName,NTextFormat.plain.strong,140));
            timeStr = (hours < 10 ? "0" : "") + hours + ":" + (minutes < 10 ? "0" : "") + minutes;
            this.logScroll.addLine(createLabel(9,34 * i + 11,timeStr,NTextFormat.plain,140));
            dateStr = (day < 10 ? "0" : "") + day + "." + (month < 10 ? "0" : "") + month + "." + year;
            this.logScroll.addLine(createLabel(67,34 * i + 11,dateStr,NTextFormat.plain,140));
            i++;
         }
         this.logScroll.init(34 * recordCount - 5);
         this.updatePages(page,pageCount);
      }
      
      private function updatePages(page:int, pageCount:int) : void
      {
         if(this.pagesPanel)
         {
            removeUIChild(this.pagesPanel);
         }
         pagesPanel = new NUIComponent();
         addUIChild(this.pagesPanel);
         var posX:int = 93;
         var posY:int = 331;
         if(page === 0)
         {
            label = createLabel(posX,posY,String(page + 1),NTextFormat.normal.strong,50);
            posX += label.textWidth + 5;
            this.pagesPanel.addChild(label);
         }
         else
         {
            pageButton = new PageButton(this.onPageClick,0);
            pageButton.x = posX;
            pageButton.y = posY;
            this.pagesPanel.addUIChild(pageButton);
            posX += pageButton.width;
         }
         var label:TextField;
         var pageButton:PageButton;
         var pageIndex:int = page - 3;
         if(pageIndex <= 1)
         {
            pageIndex = 1;
         }
         else
         {
            label = createLabel(posX,posY,"...",NTextFormat.plain,50);
            posX += label.textWidth + 5;
            this.pagesPanel.addChild(label);
         }
         while(pageIndex <= page + 3 && pageIndex < pageCount)
         {
            if(pageIndex == page)
            {
               label = createLabel(posX,posY,String(page + 1),NTextFormat.normal.strong,50);
               posX += label.textWidth + 5;
               this.pagesPanel.addChild(label);
            }
            else
            {
               pageButton = new PageButton(this.onPageClick,pageIndex);
               pageButton.x = posX;
               pageButton.y = posY;
               this.pagesPanel.addUIChild(pageButton);
               posX += pageButton.width;
            }
            pageIndex++;
         }
         if(pageIndex < pageCount - 1)
         {
            label = createLabel(posX,posY,"...",NTextFormat.plain,50);
            posX += label.textWidth + 5;
            this.pagesPanel.addChild(label);
         }
         if(pageIndex < pageCount)
         {
            pageButton = new PageButton(this.onPageClick,pageCount - 1);
            pageButton.x = posX;
            pageButton.y = posY;
            this.pagesPanel.addUIChild(pageButton);
         }
      }
      
      private function onPageClick(button:PageButton) : void
      {
         GameSocket.socket.requestCellLog(button.targetPage);
      }
   }
}

