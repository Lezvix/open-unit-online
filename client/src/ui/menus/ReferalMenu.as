package ui.menus
{
   import flash.text.TextField;
   import ui.RowList;
   import ui.NTextFormat;
   
   public class ReferalMenu extends TitledMenu
   {
      
      public function ReferalMenu(params:Object)
      {
         w = 480;
         h = 300;
         var statsList:RowList = new RowList(w - 60);
         statsList.setPos(30,44);
         var i:int = 0;
         while(i < 5)
         {
            statsList.addRow(_("IDS_REF_" + i),params.data[1 + i]);
            i++;
         }
         var posY:int = statsList.y + statsList.height + 6;
         faqLabel = createLabel(30,posY,_("IDS_REF_FAQ"),NTextFormat.titleFormat,w - 60);
         posY = faqLabel.y + faqLabel.height + 6;
         var faqLabel:TextField;
         var description:TextField = createText(25,posY,_("IDS_DESC"),NTextFormat.plain.center,w - 50);
         h = Math.max(h,description.y + description.height + 53);
         super(TYPE_REFERAL,_("IDS_REFERAL_MENU"),w,h);
         addUIChild(statsList);
         addChild(faqLabel);
         addChild(description);
         addButton(w - 119,h - 42,_("IDS_TO_CLOSE"),onCloseClick);
         draw(bitmap16,(w - bitmap16.width) / 2,description.y - 3);
         draw(bitmap16,(w - bitmap16.width) / 2,description.y + description.height + 3);
         height = h;
      }
   }
}

