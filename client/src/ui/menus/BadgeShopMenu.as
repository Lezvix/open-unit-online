package ui.menus
{
   import ui.buttons.*;
   import net.GameSocket;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import game.InventoryItem;
   import ui.*;
   
   public class BadgeShopMenu extends TitledMenu
   {
      
      private const WIDTH:int = 600;
      
      private const HEIGHT:int = 260;
      
      private const SLOT_W:int = 96;
      
      private const SLOT_H:int = 56;
      
      private const BUY_X:int = 410;
      
      private const BUY_Y:int = 102.0;
      
      private const INFO_WINDOW_X:int = 515.0;
      
      private const INFO_WINDOW_Y:int = 148.0;
      
      private var infoMenu:ItemInfo;
      
      private var currentItem:int = 2147483647;
      
      private var badgeCount:int = 0;
      
      private var badgesText:TextField;
      
      private var items:Array = new Array();
      
      private var groups:Array;
      
      private var itemsByGroup:Dictionary;
      
      private var currentGroup:int = -1;
      
      private var groupDropDown:DropDown;
      
      private var exchangeButton:NButton;
      
      private var paySlot:ItemSlot;
      
      private var buySlot:ItemSlot;
      
      public function BadgeShopMenu(fields:Array)
      {
         super(TYPE_BADGE_SHOP,_("IDS_BADGE_SHOP_MENU"),this.WIDTH,this.HEIGHT);
         drawWindowBg();
         this.buySlot = new ItemSlot();
         this.buySlot.setPos(this.BUY_X,this.BUY_Y);
         this.buySlot.showInfoButton(this.infoShow);
         addUIChild(this.buySlot);
         var button:NButton = new NButton(this.onNextArrowClick,getBmp("NEXT_ARROW_BUTTON"),getBmp("NEXT_ARROW_BUTTON_OVER"),getBmp("NEXT_ARROW_BUTTON_PRESS"));
         button.setPos(this.BUY_X + this.SLOT_W + 6,this.BUY_Y + (this.SLOT_H - 29) / 2);
         addUIChild(button);
         button = new NButton(this.onPrevArrowClick,getBmp("PREV_ARROW_BUTTON"),getBmp("PREV_ARROW_BUTTON_OVER"),getBmp("PREV_ARROW_BUTTON_PRESS"));
         button.setPos(this.BUY_X - 29,this.BUY_Y + (this.SLOT_H - 29) / 2);
         addUIChild(button);
         this.groupDropDown = new DropDown(175,null,this.onGroupChange,0,15);
         this.groupDropDown.setPos(38,(this.HEIGHT - this.groupDropDown.height) / 2);
         addTextLabel(this.BUY_X - 58,this.BUY_Y + 16,"=",NTextFormat.normal.derive({"size":14}));
         addTextLabel(this.BUY_X - this.SLOT_W - 75,this.BUY_Y - 19,_("IDS_SELL"),NTextFormat.normal.center.derive({"size":11}),this.SLOT_W);
         addTextLabel(this.BUY_X,this.BUY_Y - 19,_("IDS_BUY"),NTextFormat.normal.center.derive({"size":11}),this.SLOT_W);
         this.badgesText = createLabel(19,this.HEIGHT - 32,"?",NTextFormat.normal.derive({"size":11}),200);
         addChild(this.badgesText);
         this.paySlot = new ItemSlot();
         this.paySlot.setPos(this.BUY_X - this.SLOT_W - 75,this.BUY_Y);
         addUIChild(this.paySlot);
         this.exchangeButton = createButton(this.WIDTH - 228,this.HEIGHT - 42,_("IDS_TO_EXCHANGE"),this.onExchangeClick);
         addUIChild(this.exchangeButton);
         addButton(this.WIDTH - 119,this.HEIGHT - 42,_("IDS_TO_CLOSE"),onCloseClick);
         addUIChild(this.groupDropDown);
         this.infoMenu = new ItemInfo();
         addUIChild(this.infoMenu);
         this.parseData(fields);
      }
      
      private function onExchangeClick(sender:Object) : void
      {
         if(this.items[this.currentItem])
         {
            GameSocket.socket.deleteAddRequest(this.items[this.currentItem].id);
         }
      }
      
      private function onGroupChange(dropDown:Object) : void
      {
         if(this.currentGroup != dropDown.SelectedKey)
         {
            currentGroup = dropDown.SelectedKey;
            this.buySlot.removeItem();
            this.paySlot.removeItem();
            items = this.itemsByGroup[this.currentGroup];
            currentItem = int.MAX_VALUE;
            this.updateCurrentItem(this.currentItem);
         }
      }
      
      private function updateCurrentItem(index:int) : void
      {
         if(this.items.length == 0)
         {
            return;
         }
         if(index < 0)
         {
            index = this.items.length - 1;
         }
         else if(index >= this.items.length)
         {
            index = 0;
         }
         currentItem = index;
         var item:InventoryItem = this.items[this.currentItem].item;
         this.buySlot.insertItem(item,this.items[this.currentItem].count);
         if(this.infoMenu.visible)
         {
            this.infoMenu.targetItem = item;
            this.infoMenu.create(this.infoMenu.x,this.infoMenu.y);
         }
         item = this.items[this.currentItem].payItem;
         this.paySlot.insertItem(item,this.items[this.currentItem].cost);
         this.exchangeButton.enabled = item.itemId != -246 || this.items[this.currentItem].cost <= this.badgeCount;
      }
      
      public function parseData(fields:Array) : void
      {
         groups = new Array();
         this.groups.push(-1);
         itemsByGroup = new Dictionary();
         this.itemsByGroup[-1] = new Array();
         var offset:int = 2;
         badgeCount = fields[offset++];
         this.badgesText.text = _("IDS_BADGES",this.badgeCount);
         var offerCount:int = fields[offset++];
         while(offerCount > 0)
         {
            offer = {"id":int(fields[offset++])};
            itemLength = fields[offset];
            item = new InventoryItem(fields.slice(offset,offset + itemLength));
            offset += itemLength;
            offer["item"] = item;
            offer["count"] = int(fields[offset++]);
            itemLength = fields[offset];
            payItem = new InventoryItem(fields.slice(offset,offset + itemLength));
            offset += itemLength;
            offer["payItem"] = payItem;
            offer["cost"] = int(fields[offset++]);
            offer["group"] = int(fields[offset++]);
            if(this.groups.indexOf(offer.group) == -1)
            {
               this.groups.push(offer.group);
            }
            if(!(offer.group in this.itemsByGroup))
            {
               this.itemsByGroup[offer.group] = new Array();
            }
            this.itemsByGroup[-1].push(offer);
            this.itemsByGroup[offer.group].push(offer);
            offerCount--;
         }
         var groupLabels:Dictionary = new Dictionary();
         var group:int;
         var offer:Object;
         var itemLength:int;
         var item:InventoryItem;
         var payItem:InventoryItem;
         for each(group in this.groups)
         {
            groupLabels[group] = _("IDS_BADGE_SHOP_GROUP_" + group);
         }
         this.paySlot.removeItem();
         this.buySlot.removeItem();
         this.groupDropDown.selectedValue = groupLabels;
         items = this.itemsByGroup[this.currentGroup];
         this.groupDropDown.SelectedKey = this.currentGroup;
         this.updateCurrentItem(this.currentItem);
      }
      
      protected function onNextArrowClick(sender:Object) : void
      {
         this.updateCurrentItem(this.currentItem + 1);
      }
      
      protected function onPrevArrowClick(sender:Object) : void
      {
         this.updateCurrentItem(this.currentItem - 1);
      }
      
      protected function infoShow(button:Object) : void
      {
         var item:InventoryItem = button.value as InventoryItem;
         if(this.infoMenu.visible)
         {
            this.infoMenu.close();
         }
         else
         {
            this.infoMenu.targetItem = item;
            this.infoMenu.create(this.INFO_WINDOW_X,this.INFO_WINDOW_Y);
         }
      }
   }
}

