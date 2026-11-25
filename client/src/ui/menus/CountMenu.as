package ui.menus
{
   import ui.buttons.CommonButton;
   import ui.buttons.NButton;
   import debug.Assert;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import game.InventoryItem;
   import ui.NTextInput;
   
   public class CountMenu extends NuclearSprite
   {
      
      private var okCallback:Function;
      
      private var cancelCallback:Function;
      
      protected var slotItem:InventoryItem;
      
      protected var input:NTextInput;
      
      protected var okButton:NButton;
      
      public function CountMenu(item:InventoryItem, okHandler:Function, cancelHandler:Function = null)
      {
         Assert.isTrue(item && item.isExpendable);
         super(TYPE_COUNT);
         w = 300;
         h = 130;
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         this.slotItem = item;
         this.okCallback = okHandler;
         this.cancelCallback = cancelHandler;
         this.input = createInput(32,42,180,item.count.toString().length + 2,item.type == InventoryItem.TYPE_OTHER_EXP ? item.count : 1);
         this.input.onKeyDown = this.onKeyDown;
         this.input.allHandler = this.allHandler;
         addUIChild(this.input);
         var button:NButton = new NButton(this.onPlusClick2,getBmp("PLUS"),getBmp("PLUS_OVER"),getBmp("PLUS_PRESSED"));
         button.setPos(this.input.x + this.input.width + 12,this.input.y - button.height + this.input.height / 2);
         addUIChild(button);
         button = new NButton(this.onMinusClick2,getBmp("MINUS"),getBmp("MINUS_OVER"),getBmp("MINUS_PRESSED"));
         button.setPos(this.input.x + this.input.width + button.width + 12,this.input.y - button.height + this.input.height / 2);
         addUIChild(button);
         button = new CommonButton(_("IDS_ALL"),this.onAllClick);
         button.setPos(this.input.x + this.input.width + 12,this.input.y + this.input.height / 2 - 1);
         addUIChild(button);
         this.okButton = createButton(w / 2 - 106,h - 45,"OK",this.okClickHandler);
         addUIChild(this.okButton);
         addButton(w / 2 + 3,h - 45,_("IDS_CANCEL"),this.cancelClickHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.input.selectAll();
         this.input.focus();
      }
      
      protected function onPlusClick2(button:NButton) : void
      {
         this.input.text = Math.max(1,Math.min(this.item.count,this.input.text ? int(this.input.text) + 1 : 1)).toString();
         this.okButton.enabled = true;
      }
      
      protected function onMinusClick2(button:NButton) : void
      {
         this.input.text = Math.max(1,Math.min(this.item.count,this.input.text ? int(this.input.text) - 1 : 1)).toString();
         this.okButton.enabled = true;
      }
      
      protected function onAllClick(button:NButton) : void
      {
         this.input.text = this.item.count.toString();
         this.okButton.enabled = true;
      }
      
      public function get count() : int
      {
         return Math.max(1,Math.min(this.item.count,this.input.text ? int(this.input.text) : 1));
      }
      
      public function get item() : InventoryItem
      {
         return this.slotItem;
      }
      
      protected function okClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.okCallback != null)
         {
            this.okCallback(this);
         }
      }
      
      protected function cancelClickHandler(sender:Object) : void
      {
         closeMenu();
         if(this.cancelCallback != null)
         {
            this.cancelCallback(this);
         }
      }
      
      protected function onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.ENTER && this.okButton.enabled)
         {
            this.okClickHandler(this.okButton);
         }
         else if(event.keyCode == Keyboard.ESCAPE)
         {
            this.cancelClickHandler(null);
         }
      }
      
      protected function allHandler(event:KeyboardEvent) : void
      {
         var count:int = this.input.text ? int(this.input.text) : 0;
         this.okButton.enabled = count > 0 && count <= this.item.count;
      }
   }
}

