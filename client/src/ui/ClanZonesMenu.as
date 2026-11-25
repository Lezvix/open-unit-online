package ui
{
   import ui.buttons.*;
   import net.GameSocket;
   import net.GameEventDispatcher;
   import net.Commands;
   import ui.menus.TerminalSubmenu;
   import flash.text.TextField;
   
   public class ClanZonesMenu extends TerminalSubmenu
   {
      
      private var textField15:TextField;
      
      private var scrollSprite1:ScrollSprite;
      
      private var rowList2:RowList;
      
      private var nButton26:NButton;
      
      public function ClanZonesMenu()
      {
         super(TM_MENU_CLAN_ZONES);
         drawWindow("C:\\" + _("IDS_TERM_ICO_19"),0,0,270,225);
         drawWindow(_("IDS_DESCRIPTION"),279,0,346,225);
         if(Main.UserCharacter.isValue65)
         {
            this.nButton26 = createTerminalButton(418,234,_("IDS_REJECT"),function(sender:Object):void
            {
               var selected:* = propValue28.selectedRow;
               var zone:*;
               if(selected != -1)
               {
                  zone = propValue28.getRowValue(selected);
                  if(zone)
                  {
                     showConfirm(_("IDS_CLAN_ZONE_REJECT_CONFIRMATION",zone.name),function(param1:Object):void
                     {
                        GameSocket.socket.send(Commands.COMMANDS_CONST33,zone.id);
                     });
                  }
               }
            });
            addUIChild(this.nButton26);
         }
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST23,this.update);
         GameSocket.socket.send(Commands.COMMANDS_CONST23);
      }
      
      private function get scroll() : ScrollSprite
      {
         if(!this.scrollSprite1)
         {
            scrollSprite1 = new ScrollSprite(252,185,4);
            this.scrollSprite1.setPos(10,32);
            addUIChild(this.scrollSprite1);
         }
         return this.scrollSprite1;
      }
      
      private function get propValue28() : RowList
      {
         if(!this.rowList2)
         {
            rowList2 = new RowList(239,this.doAction368);
            this.scroll.addContent(this.rowList2);
            this.scroll.init(this.rowList2.height);
         }
         return this.rowList2;
      }
      
      private function get description() : TextField
      {
         if(!this.textField15)
         {
            textField15 = createText(287,28,"",NTextFormat.normal.setSize(12),338);
            addChild(this.textField15);
         }
         return this.textField15;
      }
      
      private function doAction590(param1:String) : void
      {
         this.description.text = param1;
         this.description.height = this.description.textHeight + 4;
      }
      
      private function doAction435() : void
      {
         if(this.textField15)
         {
            this.description.text = "";
         }
      }
      
      private function update(param1:Array) : void
      {
         var fieldIndex:int = 1;
         var zoneCount:int = int(param1[fieldIndex++]);
         var zoneIndex:int;
         var zone:Object;
         this.propValue28.clear();
         if(zoneCount == 0)
         {
            this.doAction590(_("IDS_NO_CLAN_ZONES"));
         }
         else
         {
            this.doAction435();
            zoneIndex = 0;
            while(zoneIndex < zoneCount)
            {
               zone = {
                  "id":param1[fieldIndex++],
                  "name":param1[fieldIndex++],
                  "info":param1[fieldIndex++],
                  "type":param1[fieldIndex++],
                  "x":param1[fieldIndex++],
                  "y":param1[fieldIndex++],
                  "reward":int(param1[fieldIndex++])
               };
               this.propValue28.addRow(zone.name,"",zone);
               zoneIndex++;
            }
            this.scroll.init(this.propValue28.height);
         }
         if(this.nButton26)
         {
            this.nButton26.visible = zoneCount > 0;
         }
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST23,this.update);
         super.dispose();
      }
      
      private function doAction368(param1:SelectableButton) : void
      {
         var zone:Object = null;
         var zoneDescription:String = null;
         this.doAction435();
         if(param1.Selected)
         {
            zone = param1.value;
            zoneDescription = zone.info + "\n" + formatString("IDS_ZONE_TYPE",zone.type) + "\n" + formatString("IDS_ZONE_ASSIGNMENT",zone.type) + "\n" + formatString("IDS_LOCATION_REWARD",zone.reward);
            if(zone.x != "0" && zone.y != "0")
            {
               zoneDescription += "\n" + _("IDS_COORDS") + ": " + zone.x + ", " + zone.y;
            }
            this.doAction590(zoneDescription);
         }
      }
   }
}

