package ui
{
   import ui.buttons.*;
   import core.resources.Localization;
   import net.GameSocket;
   import core.ui.UIComponent;
   import ui.menus.BaseMenu;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import game.*;
   
   public class ChatUser extends ScrollSprite
   {
      
      protected const userListList1:Vector.<UserList> = new Vector.<UserList>();
      
      protected const rows:Vector.<UIComponent> = new Vector.<UIComponent>();
      
      protected var idsIconHintCharInfo:String = _("IDS_ICON_HINT_CHAR_INFO");
      
      public var nameClickHandler:Function = null;
      
      public var privateCallback:Function = null;
      
      public function ChatUser(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      protected static function _(param1:String, ... rest) : String
      {
         return rest ? Localization.getFormattedString.apply(null,[param1].concat(rest)) : Localization.getString(param1);
      }
      
      public function get propValue120() : Vector.<UserList>
      {
         return this.userListList1;
      }
      
      public function onExit(param1:UserList) : void
      {
         if(!param1)
         {
            return;
         }
         var index:int = 0;
         while(index < this.userListList1.length)
         {
            if(this.userListList1[index].userId == param1.userId)
            {
               this.userListList1.splice(index,1);
               uiContainer.removeUIChild(this.rows[index]);
               this.rows.splice(index,1);
               break;
            }
            index++;
         }
         this.userListList1.push(param1);
         row = new UIComponent();
         var row:UIComponent;
         var button:NButton = null;
         iconLoader = null;
         var iconLoader:Loader;
         var offsetX:int = 0;
         if(param1.userId != Main.UserCharacter.userId)
         {
            button = new NButton(this.onPrivateClick,getBmp("PRIVATE"),getBmp("PRIVATE_OVER"));
            button.value = param1.userId;
            button.y = 5;
            offsetX += 12;
            row.addUIChild(button);
         }
         if(param1.hireClanId != 0)
         {
            if(param1.hireClanId == -1)
            {
               button = new NButton(null,getBmp("NAYM_ICO"));
               button.hintText = _("IDS_HIRE_STR");
            }
            else
            {
               hireIcon = new Sprite();
               iconLoader = new Loader();
               iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.weaponLoadHandler);
               iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.weaponLoadHandler);
               iconLoader.load(new URLRequest("icons/icon/clan" + param1.hireClanId + ".png"));
               iconLoader.alpha = 0.6;
               hireIcon.addChild(iconLoader);
               hireBadge = getBmp("NAYM_CLAN_ICO");
               hireIcon.graphics.beginBitmapFill(hireBadge.bitmapData);
               hireIcon.graphics.drawRect(11,6,hireBadge.width,hireBadge.height);
               hireIcon.graphics.endFill();
               button = new NButton(this.doAction369,hireIcon);
               button.value = param1.hireClanUrl;
               button.hintText = param1.hireClanName;
            }
            button.x = offsetX;
            button.y = 2;
            row.addUIChild(button);
            offsetX += 16;
         }
         if(param1.clanId != 0)
         {
            iconLoader = new Loader();
            iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.weaponLoadHandler);
            iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.weaponLoadHandler);
            iconLoader.load(new URLRequest("icons/icon/clan" + param1.clanId + ".png"));
            button = new NButton(this.doAction369,iconLoader);
            button.hintText = param1.clanName;
            button.value = param1.clanUrl;
            button.y = 2;
            button.x = offsetX;
            row.addUIChild(button);
            offsetX += 17;
         }
         var normalLabel:TextField = new TextField();
         normalLabel.defaultTextFormat = NTextFormat.plain.derive({"color":14069602});
         normalLabel.text = param1.login + "[" + param1.level + "]";
         normalLabel.width = normalLabel.textWidth + 5;
         normalLabel.height = normalLabel.textHeight + 5;
         var hoverLabel:TextField = new TextField();
         var hireIcon:Sprite;
         var hireBadge:Bitmap;
         hoverLabel.defaultTextFormat = NTextFormat.plain.derive({"color":16771509});
         hoverLabel.text = normalLabel.text;
         hoverLabel.width = normalLabel.width;
         hoverLabel.height = normalLabel.height;
         button = new NButton(this.doAction775,normalLabel,hoverLabel);
         button.value = param1.login;
         button.x = offsetX;
         offsetX += button.width;
         row.addUIChild(button);
         button = new ImageButton(this.onIconHintCharInfoClick2,this.idsIconHintCharInfo);
         button.value = param1.userId;
         button.setPos(offsetX,4);
         row.addUIChild(button);
         row.height = 12;
         this.rows.push(row);
         uiContainer.addUIChild(row);
         uiContainer.height = Math.max(height,row.height);
         this.doAction511();
      }
      
      private function weaponLoadHandler(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.weaponLoadHandler);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.weaponLoadHandler);
      }
      
      protected function onIconHintCharInfoClick2(param1:NButton) : void
      {
         var characterInfo:CharacterInfo = Client.client.getMenu(BaseMenu.TYPE_CHARACTER_INFO) as CharacterInfo;
         if(characterInfo == null || characterInfo.character.userId != int(param1.value))
         {
            GameSocket.socket.getCharInfo(int(param1.value));
         }
         else
         {
            characterInfo.closeMenu();
         }
      }
      
      protected function onPrivateClick(param1:NButton) : void
      {
         if(this.privateCallback != null)
         {
            this.privateCallback(param1);
         }
      }
      
      protected function doAction775(param1:NButton) : void
      {
         if(this.nameClickHandler != null)
         {
            this.nameClickHandler(param1);
         }
      }
      
      protected function doAction369(param1:NButton) : void
      {
         if(param1.value)
         {
            navigateToURL(new URLRequest(param1.value.toString()),"_blank");
         }
      }
      
      protected function doAction511(param1:int = 0) : void
      {
         var rowIndex:int = param1;
         while(rowIndex < this.rows.length)
         {
            this.rows[rowIndex].y = 4 + 13 * rowIndex;
            rowIndex++;
         }
         this.init();
      }
      
      override public function init(param1:int = -1, param2:int = 0, param3:Boolean = true) : void
      {
         super.init(this.rows.length * 13 + 6,scrollV);
      }
      
      public function doAction856(param1:int) : void
      {
         var index:int = 0;
         while(index < this.userListList1.length)
         {
            if(this.userListList1[index].sessionId == param1)
            {
               this.userListList1.splice(index,1);
               uiContainer.removeUIChild(this.rows[index]);
               this.rows.splice(index,1);
               this.doAction511(index);
               break;
            }
            index++;
         }
      }
   }
}

