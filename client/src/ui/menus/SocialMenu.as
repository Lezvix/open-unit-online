package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import core.ui.UIElement;
   import flash.text.TextField;
   import ui.ScrollSprite;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class SocialMenu extends TitledMenu
   {
      
      private const WIDTH:int = 500;
      
      private const HEIGHT:int = 383;
      
      private var friendlistButton:ContentTabButton;
      
      private var blacklistButton:ContentTabButton;
      
      private var friendsScroll:ScrollSprite;
      
      private var enemiesScroll:ScrollSprite;
      
      private var addLabel:TextField;
      
      private var nameInput:NTextInput;
      
      public function SocialMenu()
      {
         var onFriendsTabClick:Function = null;
         var onEnemiesTabClick:Function = null;
         onFriendsTabClick = function(sender:Object):void
         {
            if(blacklistButton.Selected)
            {
               friendlistButton.Selected = true;
               removeUIChild(blacklistButton.tabContent);
               addUIChild(friendlistButton.tabContent);
               blacklistButton.Selected = false;
               addLabel.text = _("IDS_ADD_TO_FRIENDLIST");
            }
         };
         onEnemiesTabClick = function(sender:Object):void
         {
            if(friendlistButton.Selected)
            {
               blacklistButton.Selected = true;
               removeUIChild(friendlistButton.tabContent);
               addUIChild(blacklistButton.tabContent);
               friendlistButton.Selected = false;
               addLabel.text = _("IDS_ADD_TO_BLACKLIST");
            }
         };
         Main.closeMenus(TYPE_SOCIAL);
         super(TYPE_SOCIAL,_("IDS_SOCIAL_INTERACTION_CENTER"),this.WIDTH,this.HEIGHT);
         this.friendlistButton = new ContentTabButton(_("IDS_FRIENDLIST"),(this.WIDTH - 34) / 2 - 16,onFriendsTabClick);
         this.friendlistButton.setPos(16,38);
         addUIChild(this.friendlistButton);
         this.friendlistButton.tabContent.setPos(this.friendlistButton.x,this.friendlistButton.y + this.friendlistButton.height + 8);
         addUIChild(this.friendlistButton.tabContent);
         this.blacklistButton = new ContentTabButton(_("IDS_BLACKLIST"),this.friendlistButton.width,onEnemiesTabClick);
         this.blacklistButton.setPos(20 + this.friendlistButton.width + 32,this.friendlistButton.y);
         addUIChild(this.blacklistButton);
         this.blacklistButton.tabContent.setPos(this.friendlistButton.x,this.friendlistButton.y + this.friendlistButton.height + 8);
         this.friendlistButton.Selected = true;
         this.friendsScroll = new ScrollSprite(this.WIDTH - 48,this.HEIGHT - 174);
         this.friendsScroll.setPos(6,8);
         this.friendlistButton.tabContent.addUIChild(this.friendsScroll);
         drawRamFrame(this.friendlistButton.tabContent,3,0,this.WIDTH - 35,this.HEIGHT - 160);
         this.enemiesScroll = new ScrollSprite(this.WIDTH - 48,this.HEIGHT - 174);
         this.enemiesScroll.setPos(6,8);
         this.blacklistButton.tabContent.addUIChild(this.enemiesScroll);
         drawRamFrame(this.blacklistButton.tabContent,3,0,this.WIDTH - 35,this.HEIGHT - 160);
         drawHSeparator(8,this.HEIGHT - 81,this.WIDTH - 14);
         this.addLabel = addTextLabel(8,this.HEIGHT - 65,_("IDS_ADD_TO_FRIENDLIST"),NTextFormat.titleFormat,this.WIDTH - 14);
         this.nameInput = createTextInput((this.WIDTH - 96 - 200 - 10) / 2,this.addLabel.y + 23,200);
         this.nameInput.enterHandler = this.onAddClick;
         addUIChild(this.nameInput);
         addButton(this.nameInput.x + this.nameInput.width + 10,this.nameInput.y - 2,_("IDS_ADD"),this.onAddClick);
         GameEventDispatcher.addCommandHandler(Commands.FRIENDS_INFO,this.onFriendsInfo);
         this.updateLists();
      }
      
      override public function dispose() : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.FRIENDS_INFO,this.onFriendsInfo);
         super.dispose();
      }
      
      private function onFriendsInfo(fields:Array) : void
      {
         this.updateLists();
      }
      
      private function updateLists() : void
      {
         var scrollPos:int = this.friendsScroll.scrollV;
         this.friendlistButton.tabContent.removeUIChild(this.friendsScroll);
         friendsScroll = new ScrollSprite(this.WIDTH - 48,this.HEIGHT - 174);
         this.friendsScroll.setPos(6,8);
         this.friendlistButton.tabContent.addUIChild(this.friendsScroll);
         drawRamFrame(this.friendlistButton.tabContent,3,0,this.WIDTH - 35,this.HEIGHT - 160);
         var players:Array = Main.UserCharacter.friendList;
         var i:int = 0;
         var player:Object;
         var label:TextField;
         var onlineIcon:NButton;
         var infoButton:ImageButton;
         var removeButton:TextLinkButton;
         var clanIcon:NButton;
         var messageButton:TextLinkButton;
         var yesButton:TextLinkButton;
         while(i < players.length)
         {
            player = players[i];
            label = createLabel(6,1 + i * 21,i + 1 + ". ",NTextFormat.plain);
            label.cacheAsBitmap = true;
            this.friendsScroll.addLine(label);
            onlineIcon = new IconButton(player.online);
            onlineIcon.setPos(label.x + label.textWidth,label.y + 1);
            if(player.status == 0)
            {
               onlineIcon.hintText = player.online ? _("IDS_ONLINE") : _("IDS_OFFLINE");
               this.friendsScroll.addContent(onlineIcon);
            }
            else
            {
               this.friendsScroll.addLine(onlineIcon);
            }
            if(player.clan.id != 0)
            {
               clanIcon = new ClanIconButton(player.clan);
               clanIcon.setPos(label.x + label.textWidth + 16,label.y + 2);
               this.friendsScroll.addContent(clanIcon);
            }
            label = createLabel(player.clan.id == 0 ? label.x + label.textWidth + 16 : clanIcon.x + 17,label.y,player.name + " [" + player.level + "]",NTextFormat.normal);
            label.cacheAsBitmap = true;
            infoButton = new ImageButton(this.onIconHintCharInfoClick2,_("IDS_ICON_HINT_CHAR_INFO"));
            infoButton.value = player.id;
            infoButton.setPos(label.x + label.textWidth + 5,label.y + 5);
            if(player.status == 0)
            {
               if(player.online)
               {
                  messageButton = new TextLinkButton(this.onPrivateMessageClick,_("IDS_PRIVATE_MESSAGE"),120);
                  messageButton.value = player.id;
                  messageButton.setPos(this.friendsScroll.width - 185,label.y);
                  this.friendsScroll.addContent(messageButton);
               }
               removeButton = new TextLinkButton(this.onRemoveClick,_("IDS_REMOVE"),70);
               removeButton.value = player.name;
               removeButton.setPos(this.friendsScroll.width - 65,label.y);
            }
            else if(player.status == 1)
            {
               this.friendsScroll.addLine(createLabel(this.friendsScroll.width - 225,label.y,_("IDS_FRIEND_CONFIRM_WAITING"),NTextFormat.plain));
               removeButton = new TextLinkButton(this.onRemoveClick,_("IDS_CANCEL"),70);
               removeButton.value = player.name;
               removeButton.setPos(this.friendsScroll.width - 65,label.y);
            }
            else
            {
               this.friendsScroll.addLine(createLabel(this.friendsScroll.width - 175,label.y,_("IDS_CONFIRM") + ":",NTextFormat.plain));
               yesButton = new TextLinkButton(this.onYesClick,getString29("IDS_YES"),60);
               yesButton.value = player.name;
               yesButton.setPos(this.friendsScroll.width - 70,label.y);
               this.friendsScroll.addContent(yesButton);
               this.friendsScroll.addLine(createLabel(yesButton.x + yesButton.width,label.y,"/",NTextFormat.plain));
               removeButton = new TextLinkButton(this.onRemoveClick,getString29("IDS_NO"),50);
               removeButton.value = player.name;
               removeButton.setPos(yesButton.x + yesButton.width + 10,label.y);
            }
            this.friendsScroll.addContent(removeButton);
            this.friendsScroll.addLine(label);
            this.friendsScroll.addContent(infoButton);
            this.drawRowBg(this.friendsScroll.uiContainer,4,label.y - 1,this.friendsScroll.width - 16,19);
            i++;
         }
         this.friendsScroll.init(1 + i * 21,scrollPos);
         players = Main.UserCharacter.enemyList;
         scrollPos = this.enemiesScroll.scrollV;
         this.blacklistButton.tabContent.removeUIChild(this.enemiesScroll);
         enemiesScroll = new ScrollSprite(this.WIDTH - 48,this.HEIGHT - 174);
         this.enemiesScroll.setPos(6,8);
         this.blacklistButton.tabContent.addUIChild(this.enemiesScroll);
         drawRamFrame(this.blacklistButton.tabContent,3,0,this.WIDTH - 35,this.HEIGHT - 160);
         i = 0;
         while(i < players.length)
         {
            player = players[i];
            label = createLabel(6,1 + i * 21,i + 1 + ". ",NTextFormat.plain);
            this.enemiesScroll.addLine(label);
            if(player.clan.id != 0)
            {
               clanIcon = new ClanIconButton(player.clan);
               clanIcon.setPos(label.x + label.textWidth + 3,label.y + 2);
               this.enemiesScroll.addContent(clanIcon);
            }
            label = createLabel(player.clan.id == 0 ? label.x + label.textWidth + 3 : clanIcon.x + 17,label.y,player.name + " [" + player.level + "]",NTextFormat.normal);
            infoButton = new ImageButton(this.onIconHintCharInfoClick2);
            infoButton.value = player.id;
            infoButton.setPos(label.x + label.textWidth + 5,label.y + 5);
            removeButton = new TextLinkButton(this.onRemoveClick2,_("IDS_REMOVE"),70);
            removeButton.value = player.name;
            removeButton.setPos(this.friendsScroll.width - 65,label.y);
            this.enemiesScroll.addLine(label);
            this.enemiesScroll.addContent(infoButton);
            this.enemiesScroll.addContent(removeButton);
            this.drawRowBg(this.enemiesScroll.uiContainer,4,label.y - 1,this.enemiesScroll.width - 16,19);
            i++;
         }
         this.enemiesScroll.init(1 + i * 21,scrollPos);
      }
      
      private function drawRowBg(target:UIElement, posX:int, posY:int, rowWidth:int, rowHeight:int) : void
      {
         target.graphics.beginFill(2762011);
         target.graphics.drawRect(posX,posY,rowWidth,rowHeight);
         target.graphics.endFill();
         target.graphics.beginFill(3156252);
         target.graphics.drawRect(posX,posY,rowWidth,1);
         target.graphics.drawRect(posX,posY,1,rowHeight);
         target.graphics.drawRect(rowWidth - 1,posY,1,rowHeight);
         target.graphics.drawRect(posX,rowHeight - 1,rowWidth,1);
         target.graphics.endFill();
      }
      
      private function onRemoveClick(button:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0l,button.value);
      }
      
      private function onRemoveClick2(button:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0p,button.value);
      }
      
      private function onPrivateMessageClick(button:Object) : void
      {
         GameSocket.socket.send("po",button.value);
      }
      
      private function onYesClick(button:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0k,button.value);
      }
      
      private function onIconHintCharInfoClick2(button:Object) : void
      {
         GameSocket.socket.getCharInfo(button.value);
      }
      
      private function onAddClick(sender:Object) : void
      {
         if(this.nameInput.text)
         {
            if(this.friendlistButton.Selected)
            {
               GameSocket.socket.send(Commands.FRIENDS_0k,this.nameInput.text);
            }
            else
            {
               GameSocket.socket.send(Commands.FRIENDS_0o,this.nameInput.text);
            }
            this.nameInput.text = "";
         }
      }
   }
}

