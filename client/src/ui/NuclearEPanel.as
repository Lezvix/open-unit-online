package ui
{
   import ui.buttons.*;
   import net.*;
   import ui.menus.*;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import game.Client;
   
   public class NuclearEPanel extends NUIComponent
   {
      
      public static var instance:NuclearEPanel;
      
      public static const QUICK_SLOTS_COUNT:int = 10;
      
      protected var main:Main;
      
      protected var quickSlots:Vector.<QuickSlotButton> = new Vector.<QuickSlotButton>(QUICK_SLOTS_COUNT);
      
      protected var _locked:Boolean = false;
      
      protected var moneyText:TextField;
      
      protected var friendBadge:Sprite;
      
      protected var friendCountText:TextField;
      
      public function NuclearEPanel(mainObj:Main)
      {
         var panelBg:Bitmap;
         var button:NButton;
         super();
         this.main = mainObj;
         instance = this;
         panelBg = getBmp("UP_PANEL");
         height = panelBg.height;
         width = panelBg.width;
         draw(panelBg);
         button = new NButton(this.onServicesClick,getBmp("SERVICES_BTN"),getBmp("SERVICES_BTN_OVER"),getBmp("SERVICES_BTN_PRESSED"));
         button.setPos(2,3);
         addUIChild(button);
         button = new NButton(this.onSocialClick,getBmp("SOCIAL_BTN"),getBmp("SOCIAL_BTN_OVER"),getBmp("SOCIAL_BTN_PRESSED"));
         button.hintText = _("IDS_SOCIAL_INTERACTION_CENTER");
         button.setPos(120,3);
         addUIChild(button);
         this.friendCountText = new TextField();
         this.friendCountText.defaultTextFormat = new NTextFormat({
            "color":16765023,
            "size":11
         }).center;
         this.friendCountText.x = 1;
         this.friendBadge = new Sprite();
         this.friendBadge.y = 17;
         this.friendBadge.addChild(this.friendCountText);
         button = new NButton(this.onSettingsClick,getBmp("SETTINGS_BTN"),getBmp("SETTINGS_BTN_OVER"),getBmp("SETTINGS_BTN_PRESSED"));
         button.hintText = _("IDS_SETTINGS");
         button.setPos(153,3);
         addUIChild(button);
         button = new NButton(this.onFullscreenClick,getBmp("FULLSCREEN_BTN"),getBmp("FULLSCREEN_BTN_OVER"),getBmp("FULLSCREEN_BTN_PRESSED"));
         button.hintText = _("IDS_FULLSCREEN");
         button.setPos(186,3);
         addUIChild(button);
         this.moneyText = new TextField();
         this.moneyText.width = 99;
         this.moneyText.x = 61;
         this.moneyText.y = 35;
         this.moneyText.defaultTextFormat = new NTextFormat({
            "color":16765023,
            "size":11
         }).right;
         this.updateMoney();
         addChild(this.moneyText);
         var i:int = 0;
         var slot:QuickSlotButton;
         while(i < QUICK_SLOTS_COUNT)
         {
            slot = new QuickSlotButton(i,this.onQuickSlotClick);
            slot.setPos(width - slot.width - 2,41 + QuickSlotButton.HEIGHT * i);
            this.quickSlots[i] = slot;
            addUIChild(slot);
            i++;
         }
         button = new ToggleButton(this.onPanelLockClick,getBmp("PANEL_LOCK_BTN"),getBmp("PANEL_LOCK_BTN_OVER"),getBmp("PANEL_LOCK_BTN_PRESSED"));
         button.hintText = _("IDS_TO_LOCK");
         button.setPos(width - button.width,panelBg.height);
         addUIChild(button);
         height = panelBg.height + button.height;
         this.updateFriendRequests();
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST8,this.updateMoney);
         GameEventDispatcher.addCommandHandler(Commands.FRIENDS_INFO,this.updateFriendRequests);
      }
      
      private function updateFriendRequests(fields:Array = null) : void
      {
         var requests:int = this.main.userCharacter.friendRequests;
         if(requests > 0)
         {
            this.friendCountText.text = requests.toString();
            this.friendCountText.width = int(Math.round(this.friendCountText.textWidth) + (requests > 9 ? 9 : 12));
            this.friendCountText.height = 17;
            this.friendBadge.graphics.clear();
            this.friendBadge.graphics.lineStyle(1,13408825);
            this.friendBadge.graphics.beginFill(3813142);
            this.friendBadge.graphics.drawRect(0,0,this.friendCountText.width + this.friendCountText.x + (requests > 9 ? (requests > 99 ? 1 : -1) : 0),17);
            this.friendBadge.graphics.endFill();
            this.friendBadge.x = 152 - (this.friendCountText.width + this.friendCountText.x) / 2;
            addChild(this.friendBadge);
         }
         else if(contains(this.friendBadge))
         {
            removeChild(this.friendBadge);
         }
      }
      
      public function get isLocked() : Boolean
      {
         return this._locked;
      }
      
      private function updateMoney(fields:Array = null) : void
      {
         this.moneyText.text = this.main.userCharacter.money.toString();
      }
      
      public function hideMoney() : void
      {
         this.moneyText.visible = false;
      }
      
      public function showMoney() : void
      {
         this.moneyText.visible = true;
      }
      
      override protected function includesMouse() : Boolean
      {
         return mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < 33 || mouseX > 13 && mouseX < width && mouseY >= 33 && mouseY < 52 || mouseX > 133 && mouseX < width && mouseY >= 52 && mouseY < height - 20;
      }
      
      protected function onPanelLockClick(button:ToggleButton) : void
      {
         _locked = !this._locked;
         button.hintText = this._locked ? _("IDS_TO_UNLOCK") : _("IDS_TO_LOCK");
         button.toggled = this._locked;
         var i:int = 0;
         while(i < QUICK_SLOTS_COUNT)
         {
            this.quickSlots[i].enabled = !this._locked;
            i++;
         }
         this.updateFriendRequests();
      }
      
      protected function onSocialClick(sender:Object) : void
      {
         var menu:SocialMenu = this.main.getMenu(BaseMenu.TYPE_SOCIAL) as SocialMenu;
         if(menu == null)
         {
            this.main.get(BaseMenu.TYPE_SOCIAL);
         }
         else
         {
            menu.closeMenu();
         }
      }
      
      protected function onServicesClick(sender:Object) : void
      {
         var menu:PaidServicesMenu = this.main.getMenu(BaseMenu.TYPE_ACTION_10) as PaidServicesMenu;
         if(menu == null)
         {
            GameSocket.socket.showPaidServices();
         }
         else
         {
            menu.closeMenu();
         }
      }
      
      protected function onSettingsClick(sender:Object) : void
      {
         var menu:SettingsMenu = this.main.getMenu(BaseMenu.TYPE_0) as SettingsMenu;
         if(menu == null)
         {
            this.main.showSettingsMenu();
         }
         else
         {
            menu.closeMenu();
         }
      }
      
      protected function onFullscreenClick(button:NButton) : void
      {
         Client.client.fullscreen = !Client.client.fullscreen;
      }
      
      public function subItemCount(slotIndex:int) : void
      {
         this.quickSlots[slotIndex].decreaseCount();
      }
      
      public function drawAddon(fields:Array, offset:int) : void
      {
         var i:int = 0;
         var imageId:int;
         var itemName:String;
         var count:int;
         while(i < QUICK_SLOTS_COUNT)
         {
            imageId = fields[offset++];
            itemName = fields[offset++];
            count = fields[offset++];
            this.quickSlots[i].update(imageId,itemName,count);
            i++;
         }
      }
      
      protected function onQuickSlotClick(slot:QuickSlotButton) : void
      {
         this.main.useQuickSlot(slot.index);
      }
      
      public function hasQuickSlotItem(slotIndex:int) : Boolean
      {
         return this.quickSlots[slotIndex].visible;
      }
      
      public function getQuickSlotImage(slotIndex:int) : int
      {
         return this.quickSlots[slotIndex].imageId;
      }
      
      public function getQuickSlotItemName(slotIndex:int) : String
      {
         return this.quickSlots[slotIndex].itemname;
      }
   }
}

