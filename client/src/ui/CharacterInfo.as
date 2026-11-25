package ui
{
   import ui.buttons.*;
   import ui.controls.PresentItem;
   import net.*;
   import core.ui.BaseButton;
   import core.ui.UIElement;
   import ui.menus.NuclearSprite;
   import events.*;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import game.Effect;
   import game.CharParam;
   import game.Character;
   
   public class CharacterInfo extends NuclearSprite
   {
      
      private static const WIDTH:int = 671;
      
      private static const HEIGHT:int = 482;
      
      public static var hintSprite:Sprite;

      public static var charInfo:CharacterInfo;

      [Embed(source="/assets/CharacterInfo_QUICK_P_CENTER.png")]
      
      private var QUICK_P_CENTER:Class;
      
      [Embed(source="/assets/CharacterInfo_MENU_DOWN_TILE.png")]
      
      private var MENU_DOWN_TILE:Class;
      
      [Embed(source="/assets/CharacterInfo_HP_BAR.png")]
      
      private var HP_BAR:Class;
      
      [Embed(source="/assets/CharacterInfo_BAR_INF_01.png")]
      
      private var BAR_INF_01:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_MG.png")]
      
      private var BUTTON_MG:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_MG_OVER.png")]
      
      private var BUTTON_MG_OVER:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_MG_PRESS.png")]
      
      private var BUTTON_MG_PRESS:Class;
      
      [Embed(source="/assets/CharacterInfo_BACKGROUND.png")]
      
      private var BACKGROUND:Class;
      
      [Embed(source="/assets/CharacterInfo_LINE_G.png")]
      
      private var LINE_G:Class;
      
      [Embed(source="/assets/CharacterInfo_LINE_INF_S.png")]
      
      private var LINE_INF_S:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_ABILITY.png")]
      
      private var BUTTON_ABILITY:Class;
      
      private var MAG_TILE5:Class = CharacterInfo_MAG_TILE5;
      
      private var MAG_TILE3:Class = CharacterInfo_MAG_TILE3;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_ABILITY_OVER.png")]
      
      private var BUTTON_ABILITY_OVER:Class;
      
      [Embed(source="/assets/ProgressBar_IMG_6.png")]
      
      private var BUTTON_ABILITY_PRESS:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_PRESENT.png")]
      
      private var BUTTON_PRESENT:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_PRESENT_OVER.png")]
      
      private var BUTTON_PRESENT_OVER:Class;
      
      [Embed(source="/assets/CharacterInfo_BUTTON_PRESENT_PRESS.png")]
      
      private var BUTTON_PRESENT_PRESS:Class;
      
      public var character:Character;
      
      public var appearance:Sprite;
      
      public var sprite:Sprite;
      
      public var hpsprite:UIElement;
      
      protected var traumsText:TextField;
      
      public var avatarLoader:Loader;
      
      public var weapon1Loader:Loader;
      
      public var weapon2Loader:Loader;
      
      public var baseButton4:BaseButton;
      
      private var direction:Boolean = true;
      
      private var gameBitmap1:GameBitmap;
      
      private var presentsList:PresentsList;
      
      private var ScrollV:int;
      
      private var Scroll:int;
      
      private var sprite9:Sprite;
      
      private var terminalFlashOn:Sprite;
      
      private var playerAbout:TextField;
      
      private var pvpRating:TextField;
      
      private var playerCity:NTextInput;
      
      private var playerFullName:NTextInput;
      
      private var playerCountry:NTextInput;
      
      private var playerHP:TextField;
      
      private var scrollTextPart:ScrollSprite;
      
      protected var armorClassText:TextField;
      
      protected var armorClassTF1:NTextFormat;
      
      protected var armorClassTF2:NTextFormat;
      
      private var lineInfS2:Bitmap;
      
      private var lineInfS3:Bitmap;
      
      private var client:Object;
      
      private var topSprite:Sprite;
      
      private var abilityButton:GradientToggleButton;
      
      private var presentsButton:GradientToggleButton;
      
      private var rewardsButton:GradientToggleButton;
      
      private var removeEnemyButton:GradientToggleButton;
      
      private var removeFriendButton:GradientToggleButton;
      
      private var charHealthParamsBars:Array = new Array(Character.HEALTH_PARAMS_COUNT);
      
      private var pvpRankIcon1:PvpRankIcon;
      
      public function CharacterInfo(param1:Boolean = false, param2:Object = null)
      {
         super(TYPE_CHARACTER_INFO);
         Main.closeMenus(type);
         this.client = param2;
         charInfo = this;
         width = WIDTH;
         height = HEIGHT;
         GameEventDispatcher.addCommandHandler(Commands.FRIENDS_INFO,this.onLoadAppearanceHandler);
      }
      
      public static function showHint(param1:String) : void
      {
         if(hintSprite != null)
         {
            hideHint();
         }
         charInfo.setHint(param1);
      }
      
      public static function moveHint() : void
      {
         if(hintSprite)
         {
            hintSprite.x = charInfo.mouseX;
            hintSprite.y = charInfo.mouseY - hintSprite.height;
         }
      }
      
      public static function hideHint() : void
      {
         charInfo.removeChild(hintSprite);
         hintSprite = null;
      }
      
      public static function TimeToStr(param1:int) : String
      {
         var result:String = "";
         var hours:int = param1 / 3600;
         var minutes:int = param1 % 3600 / 60;
         var seconds:int = param1 % 60;
         if(hours != 0)
         {
            result += hours + _("IDS_HOURS") + " ";
         }
         if(minutes != 0)
         {
            result += minutes + _("IDS_MINUTES") + " ";
         }
         if(seconds != 0)
         {
            result += seconds + _("IDS_SECONDS") + " ";
         }
         return result;
      }
      
      private function onLoadAppearanceHandler(param1:Array) : void
      {
         this.doAction382();
      }
      
      private function doAction382() : void
      {
         if(this.removeFriendButton != null)
         {
            removeUIChild(this.removeFriendButton);
            removeFriendButton = null;
         }
         if(this.removeEnemyButton != null)
         {
            removeUIChild(this.removeEnemyButton);
            removeEnemyButton = null;
         }
         var currentUserId:int = Main.UserCharacter.userId;
         if(this.character.userId == currentUserId)
         {
            return;
         }
         var friends:Array = Main.UserCharacter.friendList;
         var isFriend:Boolean = false;
         var entryIndex:int = 0;
         while(entryIndex < friends.length)
         {
            if(friends[entryIndex].id == this.character.userId)
            {
               isFriend = true;
               break;
            }
            entryIndex++;
         }
         removeFriendButton = new GradientToggleButton(isFriend ? this.doAction210 : this.doAction65,_(isFriend ? "IDS_REMOVE_FRIEND" : "IDS_ADD_FRIEND"),125);
         this.removeFriendButton.setPos(409,379);
         addUIChild(this.removeFriendButton);
         var enemies:Array = Main.UserCharacter.enemyList;
         var isEnemy:Boolean = false;
         if(!isFriend)
         {
            entryIndex = 0;
            while(entryIndex < enemies.length)
            {
               if(enemies[entryIndex].id == this.character.userId)
               {
                  isEnemy = true;
                  break;
               }
               entryIndex++;
            }
         }
         removeEnemyButton = new GradientToggleButton(isEnemy ? this.doAction34 : this.doAction944,_(isEnemy ? "IDS_REMOVE_ENEMY" : "IDS_ADD_ENEMY"),125);
         this.removeEnemyButton.setPos(280,379);
         addUIChild(this.removeEnemyButton);
      }
      
      private function doAction65(param1:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0k,this.character.name);
      }
      
      private function doAction944(param1:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0o,this.character.name);
         param1.enabled = false;
      }
      
      private function doAction210(param1:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0l,this.character.name);
         param1.enabled = false;
      }
      
      private function doAction34(param1:Object) : void
      {
         GameSocket.socket.send(Commands.FRIENDS_0p,this.character.name);
         param1.enabled = false;
      }
      
      private function _on_effect_event(param1:Object) : void
      {
         if(param1["type"] == Effect.ARMOR_DISRUPTION || param1["type"] == Effect.EffectCount)
         {
            this.RecalcArmorClass();
         }
      }
      
      public function infoMouseMoveHandler() : void
      {
         if(hintSprite)
         {
            moveHint();
         }
      }
      
      public function setHint(param1:String) : void
      {
         hintSprite = new Sprite();
         var hintFormat:TextFormat = new TextFormat();
         hintFormat.font = "Verdana";
         hintFormat.color = 13408563;
         hintFormat.size = 10;
         hintFormat.underline = false;
         hintFormat.bold = true;
         var hintText:TextField = new TextField();
         hintText.defaultTextFormat = hintFormat;
         hintText.autoSize = TextFieldAutoSize.LEFT;
         hintText.selectable = false;
         hintText.multiline = false;
         hintText.x = 2;
         hintText.y = 2;
         hintText.text = param1;
         if(hintText.textWidth > 200)
         {
            hintText.wordWrap = true;
            hintText.width = 200;
            hintText.height = hintText.textHeight + 2;
         }
         hintSprite.graphics.clear();
         hintSprite.graphics.lineStyle(1,13408563);
         hintSprite.graphics.moveTo(0,0);
         hintSprite.graphics.lineTo(0,hintText.numLines * 13 + 5);
         hintSprite.graphics.lineTo(5 + hintText.width,hintText.numLines * 13 + 5);
         hintSprite.graphics.lineTo(5 + hintText.width,0);
         hintSprite.graphics.lineTo(0,0);
         hintSprite.graphics.beginFill(1776411);
         hintSprite.graphics.drawRect(0,0,5 + hintText.width,hintText.numLines * 13 + 5);
         hintSprite.addChild(hintText);
         moveHint();
         addChild(hintSprite);
      }
      
      override public function dispose() : void
      {
         this.scrollTextPart.dispose();
         GameEventDispatcher.removeCommandHandler(Commands.FRIENDS_INFO,this.onLoadAppearanceHandler);
         if(this.character.userId == Main.UserCharacter.userId)
         {
            UnitEventDispatcher.instance.removeListener(EventType.EffectUpdated,this._on_effect_event);
            UnitEventDispatcher.instance.removeListener(EventType.EffectRemoved,this._on_effect_event);
            Main.UserCharacter.removeChangeListener(this.doAction506);
         }
         super.dispose();
      }
      
      public function doAction245() : void
      {
      }
      
      public function upperPart() : void
      {
         hpsprite = new NUIComponent();
         var backgroundBitmap:Bitmap = new this.BACKGROUND();
         bitmaps(backgroundBitmap.bitmapData);
         var buttonMgPressedBitmap:Bitmap = new this.BUTTON_MG_PRESS();
         bitmaps(buttonMgPressedBitmap.bitmapData);
         var menuDownTile:Bitmap = new this.MENU_DOWN_TILE();
         bitmaps(menuDownTile.bitmapData);
         var quickPanelCenter:Bitmap = new this.QUICK_P_CENTER();
         bitmaps(quickPanelCenter.bitmapData);
         var buttonMgOverBitmap:Bitmap = new this.BUTTON_MG_OVER();
         bitmaps(buttonMgOverBitmap.bitmapData);
         var infoBarBitmap:Bitmap = new this.BAR_INF_01();
         bitmaps(infoBarBitmap.bitmapData);
         var buttonMgBitmap:Bitmap = new this.BUTTON_MG();
         bitmaps(buttonMgBitmap.bitmapData);
         var hpBarBitmap:Bitmap = new this.HP_BAR();
         bitmaps(hpBarBitmap.bitmapData);
         var infoLineBitmap:Bitmap = new this.LINE_INF_S();
         bitmaps(infoLineBitmap.bitmapData);
         var lineBitmap:Bitmap = new this.LINE_G();
         bitmaps(lineBitmap.bitmapData);
         var abilityButtonBitmap:Bitmap = new this.BUTTON_ABILITY();
         bitmaps(abilityButtonBitmap.bitmapData);
         var magTile3:Bitmap = new this.MAG_TILE3();
         bitmaps(magTile3.bitmapData);
         var magTile5:Bitmap = new this.MAG_TILE5();
         bitmaps(magTile5.bitmapData);
         var abilityButtonOverBitmap:Bitmap = new this.BUTTON_ABILITY_OVER();
         bitmaps(abilityButtonOverBitmap.bitmapData);
         var presentButtonBitmap:Bitmap = new this.BUTTON_PRESENT();
         bitmaps(presentButtonBitmap.bitmapData);
         var presentButtonOverBitmap:Bitmap = new this.BUTTON_PRESENT_OVER();
         bitmaps(presentButtonOverBitmap.bitmapData);
         draw(backgroundBitmap,4,8);
         drawTile(slotBmp,244,92,100,56);
         drawTile(slotBmp,244,157,100,56);
         pvpRankIcon1 = new PvpRankIcon();
         this.pvpRankIcon1.propValue95 = this.character.Rank;
         this.pvpRankIcon1.x = 34;
         this.pvpRankIcon1.y = 269;
         addUIChild(this.pvpRankIcon1);
         fillRect(244,133,100,15,4013373);
         fillRect(244,198,100,15,4013373);
         draw(buttonMgPressedBitmap,0,0);
         draw(presentButtonBitmap,373,9);
         if(this.character.clanId != 0)
         {
            draw(presentButtonOverBitmap,12,340);
         }
         draw(infoBarBitmap,104,57);
         draw(quickPanelCenter,104,71);
         draw(menuDownTile,104,86);
         draw(buttonMgOverBitmap,104,102);
         drawFrame(0,0,WIDTH,HEIGHT);
         drawTile(magTile3,360,9,magTile3.width,363);
         drawTile(abilityButtonBitmap,13,362,649,abilityButtonBitmap.height);
         draw(magTile5,360,5);
         draw(infoLineBitmap,7,362);
         draw(lineBitmap,659,362);
         draw(abilityButtonOverBitmap,360,362);
         sprite9 = new Sprite();
         this.sprite9.graphics.beginBitmapFill(hpBarBitmap.bitmapData);
         this.sprite9.graphics.drawRect(0,0,hpBarBitmap.width,hpBarBitmap.height);
         this.sprite9.graphics.endFill();
         this.sprite9.x = 103;
         this.sprite9.y = 55;
         this.sprite9.visible = false;
         addChild(this.sprite9);
         terminalFlashOn = new Sprite();
         this.terminalFlashOn.graphics.beginBitmapFill(buttonMgBitmap.bitmapData);
         this.terminalFlashOn.graphics.drawRect(0,0,buttonMgBitmap.width,buttonMgBitmap.height);
         this.terminalFlashOn.graphics.endFill();
         this.terminalFlashOn.x = 104;
         this.terminalFlashOn.y = 102;
         this.terminalFlashOn.visible = false;
         addChild(this.terminalFlashOn);
         this.hpsprite.x = 123;
         this.hpsprite.y = 35;
         addChild(this.hpsprite);
         addTextLabel(462,10,_("IDS_PRIVATE_INFO"),NTextFormat.titleFormat.left,200);
         scrollTextPart = new ScrollSprite(271,303);
         this.scrollTextPart.y = 54;
         this.scrollTextPart.x = 382;
         addUIChild(this.scrollTextPart);
         presentsList = new PresentsList(GameSocket.socket,this.topSprite,this,this.client);
         this.presentsList.x = 22;
         this.presentsList.y = 401;
         this.presentsList.create(7);
         addUIChild(this.presentsList);
         var buyPresentButton:NButton = new GradientToggleButton(this.handleMakePresent,_("IDS_BUY_PRESENT"),120);
         var clanLabel:TextField;
         buyPresentButton.setPos(538,379);
         addUIChild(buyPresentButton);
         this.doAction382();
         presentsButton = new GradientToggleButton(this.handlePresents,_("IDS_PRESENTS"),84);
         this.presentsButton.setPos(16,379);
         this.presentsButton.toggleOn();
         abilityButton = new GradientToggleButton(this.onAbilityClick,_("IDS_ABILITY"),84);
         this.abilityButton.setPos(104,379);
         rewardsButton = new GradientToggleButton(this.handleAbility,_("IDS_REWARDS"),84);
         this.rewardsButton.setPos(192,379);
         addUIChild(this.presentsButton);
         addUIChild(this.abilityButton);
         addUIChild(this.rewardsButton);
         if(this.character.clanId != 0)
         {
            clanLabel = addTextLabel(33,345,_("IDS_CLAN") + ":",NTextFormat.plain);
            addTextLabel(clanLabel.x + clanLabel.textWidth + 8,345,this.character.clanName,NTextFormat.normal,200);
            addTextLabel(212,345,_("IDS_CLAN_POSITION_" + this.character.clanPosition),NTextFormat.normal.center,134);
         }
      }
      
      private function handlePresents(param1:Object) : void
      {
         this.updatePresents();
         this.presentsButton.toggleOn();
         this.abilityButton.toggleOff();
         this.rewardsButton.toggleOff();
      }
      
      private function handleAbility(param1:Object) : void
      {
         this.doAction640();
         this.presentsButton.toggleOff();
         this.abilityButton.toggleOff();
         this.rewardsButton.toggleOn();
      }
      
      private function onAbilityClick(param1:Object) : void
      {
         this.updateAbility();
         this.presentsButton.toggleOff();
         this.rewardsButton.toggleOff();
         this.abilityButton.toggleOn();
      }
      
      private function handleMakePresent(param1:Object) : void
      {
         if(this.client)
         {
            this.client.presentLogin = this.character.name;
            this.client.socket.showPaidServices();
         }
      }
      
      public function init() : void
      {
         fillBg(4,4,WIDTH - 8,HEIGHT - 8);
         addDefaultCloseButton(WIDTH - 42,14);
         topSprite = new Sprite();
         this.upperPart();
         traumsText = new TextField();
         this.traumsText.multiline = true;
         this.traumsText.wordWrap = true;
         this.traumsText.selectable = false;
         this.traumsText.width = 200;
         this.traumsText.defaultTextFormat = NTextFormat.normal;
         var hpFillBitmap:Bitmap = new this.BUTTON_ABILITY_PRESS();
         bitmaps(hpFillBitmap.bitmapData);
         appearance = new Sprite();
         avatarLoader = new Loader();
         this.avatarLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
         this.avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.ioErrorHandler);
         weapon1Loader = new Loader();
         weapon2Loader = new Loader();
         addChild(this.weapon1Loader);
         addChild(this.weapon2Loader);
         addChild(this.avatarLoader);
         addChild(this.appearance);
         this.updateMainText();
         this.avatarLoader.x = 19;
         this.avatarLoader.y = 13;
         if(this.character.online == 1)
         {
            this.sprite9.visible = true;
         }
         if(this.character.terminal == 1)
         {
            this.terminalFlashOn.visible = true;
         }
         this.hpsprite.graphics.clear();
         this.hpsprite.graphics.beginBitmapFill(hpFillBitmap.bitmapData);
         this.hpsprite.graphics.drawRect(0,0,117 * this.character.hp / this.character.hpAll,hpFillBitmap.height);
         this.hpsprite.graphics.endFill();
         addChild(this.topSprite);
         if(!this.client)
         {
            hintSprite = new Sprite();
            addChild(hintSprite);
         }
         if(this.character.userId == Main.UserCharacter.userId)
         {
            UnitEventDispatcher.instance.addListener(EventType.EffectUpdated,this._on_effect_event);
            UnitEventDispatcher.instance.addListener(EventType.EffectRemoved,this._on_effect_event);
            Main.UserCharacter.addChangeListener(this.doAction506);
         }
         gameBitmap1 = new GameBitmap();
         addChild(this.gameBitmap1);
         this.gameBitmap1.setPos(127,58);
      }
      
      private function ioErrorHandler(param1:Event) : void
      {
         param1.target.loader.removeEventListener(Event.COMPLETE,this.ioErrorHandler);
         param1.target.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
      }
      
      private function onContentLoaderInfoIoError(param1:IOErrorEvent) : void
      {
         param1.target.loader.removeEventListener(Event.COMPLETE,this.ioErrorHandler);
         param1.target.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
         draw(getBmp("AVATAR_NOT_FOUND"),19,13);
      }
      
      private function doAction506(param1:Object) : void
      {
         var currentCharacter:Character = Main.UserCharacter;
         switch(param1.property)
         {
            case "Rank":
               this.pvpRankIcon1.propValue95 = currentCharacter.Rank;
               break;
            case "pvpRating":
            case "NextRankPoints":
               this.pvpRating.text = formatString("IDS_PVP_RATING",currentCharacter.pvpRating,currentCharacter.NextRankPoints);
               this.pvpRating.setTextFormat(NTextFormat.plain,0,12);
               break;
            case "alcoholism":
               this.charHealthParamsBars[CharParam.CHAR_PARAM_CONST5].Value = currentCharacter.getNumber9(CharParam.CHAR_PARAM_CONST5);
               break;
            case "chemicalPoisoning":
               this.charHealthParamsBars[CharParam.CHAR_PARAM_CONST12].Value = currentCharacter.getNumber9(CharParam.CHAR_PARAM_CONST12);
               break;
            case "drugAddiction":
               this.charHealthParamsBars[CharParam.CHAR_PARAM_CONST1].Value = currentCharacter.getNumber9(CharParam.CHAR_PARAM_CONST1);
               break;
            case "irradiation":
               this.charHealthParamsBars[CharParam.CHAR_PARAM_CONST4].Value = currentCharacter.getNumber9(CharParam.CHAR_PARAM_CONST4);
               break;
            case "aspd":
               this.charHealthParamsBars[CharParam.EffectCount].Value = currentCharacter.getNumber9(CharParam.EffectCount);
               break;
         }
      }
      
      private function loadErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function RecalcArmorClass() : void
      {
         var armorClass:int = Math.min(999,this.character.armorClass + this.character.armorBonus);
         var modifierPercent:int = 0;
         var effect:Object;
         var bonusStart:int;
         if(this.character.hasSeenPerk(Character.PERK_SHELL))
         {
            modifierPercent += 7;
         }
         if(this.character.hasAbility(Character.ABILITY_ARMOR_CLASS))
         {
            modifierPercent += 5;
         }
         if(this.character.userId == Main.UserCharacter.userId)
         {
            effect = Main.UserCharacter.getEffect(Effect.ARMOR_DISRUPTION);
            if(effect)
            {
               modifierPercent -= effect.param;
            }
            effect = Main.UserCharacter.getEffect(Effect.EFFECT_CONST11);
            if(effect)
            {
               modifierPercent += effect.param;
            }
            effect = Main.UserCharacter.getEffect(Effect.EffectCount);
            if(effect)
            {
               modifierPercent -= effect.param >> 24 & 0xFF;
            }
         }
         modifierPercent = Math.max(-100,modifierPercent);
         if(modifierPercent != 0)
         {
            armorClass *= (100 + modifierPercent) / 100;
         }
         armorClass = Math.max(0,Math.min(999,armorClass));
         this.armorClassText.text = _("IDS_AC") + ":             " + armorClass;
         this.armorClassText.height = this.armorClassText.textHeight + 5;
         this.armorClassText.setTextFormat(this.armorClassTF1);
         if(this.character.armorBonus > 0)
         {
            bonusStart = this.armorClassText.text.length;
            this.armorClassText.appendText("  (" + this.character.armorBonus + ")");
            this.armorClassText.setTextFormat(this.armorClassTF2,bonusStart,this.armorClassText.text.length);
         }
      }
      
      public function updateMainText() : void
      {
         var separator:Bitmap = new this.BUTTON_PRESENT_PRESS();
         bitmaps(separator.bitmapData);
         lineInfS2 = new this.BUTTON_PRESENT_PRESS();
         bitmaps(this.lineInfS2.bitmapData);
         lineInfS3 = new this.BUTTON_PRESENT_PRESS();
         bitmaps(this.lineInfS3.bitmapData);
         separator.x = 2;
         separator.y = 74;
         this.scrollTextPart.addLine(separator);
         var index:int = 0;
         while(index < Character.STAT_COUNT)
         {
            addTextLabel(15,134 + 15 * index,_("IDS_STAT_" + index),NTextFormat.normal,150);
            addTextLabel(103,134 + 15 * index,this.character.stats[index].toString(),NTextFormat.normal.center,20);
            index++;
         }
         armorClassTF1 = new NTextFormat({"bold":true});
         armorClassTF2 = new NTextFormat({
            "bold":true,
            "color":16731648
         });
         armorClassText = createLabel(15,230,"",this.armorClassTF1,200);
         addChild(this.armorClassText);
         if(this.character.userId == Main.UserCharacter.userId)
         {
            index = 0;
            while(index < Character.HEALTH_PARAMS_COUNT)
            {
               if(!this.charHealthParamsBars[index])
               {
                  this.charHealthParamsBars[index] = new LevelsBar(_("IDS_HEALTH_PARAM_" + index),this.character.getHealthParam(index),Character.HEALTH_PARAMS_CRITICAL_VALUES[index],Character.HEALTH_PARAMS_MAX_VALUES[index]);
                  this.charHealthParamsBars[index].x = 248 + 20 * index;
                  this.charHealthParamsBars[index].y = 212;
                  addChild(this.charHealthParamsBars[index]);
               }
               else
               {
                  this.charHealthParamsBars[index].Value = this.character.getHealthParam(index);
               }
               index++;
            }
         }
         this.RecalcArmorClass();
         addTextLabel(115,11,this.character.name,new NTextFormat({
            "size":12,
            "bold":true
         }),200);
         addTextLabel(250,11,"[" + this.character.level + "]",new NTextFormat({
            "size":12,
            "bold":true
         }),40);
         var firstWeaponLabel:TextField = createLabel(244,132,this.character.weaponName[0],new NTextFormat({
            "size":9,
            "letterSpacing":-1
         }),99);
         var secondWeaponLabel:TextField = createLabel(244,197,this.character.weaponName[1],new NTextFormat({
            "size":9,
            "letterSpacing":-1
         }),99);
         while(firstWeaponLabel.textWidth > firstWeaponLabel.width - 2)
         {
            firstWeaponLabel.text = firstWeaponLabel.text.slice(0,-4) + "...";
         }
         while(secondWeaponLabel.textWidth > secondWeaponLabel.width - 2)
         {
            secondWeaponLabel.text = secondWeaponLabel.text.slice(0,-4) + "...";
         }
         this.scrollTextPart.addLine(createLabel(0,8,_("IDS_NAME") + ":",NTextFormat.plain.right,49));
         playerFullName = createTextInput(57,8,182,"");
         this.playerFullName.height = 18;
         this.playerFullName.isValue25 = true;
         this.scrollTextPart.addLine(this.playerFullName);
         this.scrollTextPart.addLine(createLabel(0,28,_("IDS_CITY") + ":",NTextFormat.plain.right,49));
         playerCity = createTextInput(57,28,182,"");
         this.playerCity.height = 18;
         this.playerCity.isValue25 = true;
         this.scrollTextPart.addLine(this.playerCity);
         this.scrollTextPart.addLine(createLabel(0,48,_("IDS_COUNTRY") + ":",NTextFormat.plain.right,49));
         playerCountry = createTextInput(57,48,182,"");
         this.playerCountry.height = 18;
         this.playerCountry.isValue25 = true;
         this.scrollTextPart.addLine(this.playerCountry);
         playerHP = createLabel(84,50,"0",NTextFormat.normal.strong,100);
         this.scrollTextPart.addLine(this.playerHP);
         this.scrollTextPart.addLine(createLabel(10,79,_("IDS_ABOUT") + ":",NTextFormat.plain,100));
         playerAbout = createText(10,97,"",NTextFormat.normal,220);
         this.playerAbout.selectable = false;
         this.scrollTextPart.addLine(this.playerAbout);
         this.lineInfS2.x = 2;
         this.lineInfS2.y = this.playerAbout.y + this.playerAbout.height;
         this.scrollTextPart.addLine(this.lineInfS2);
         pvpRating = createLabel(10,this.lineInfS2.y + 5,"!",NTextFormat.normal.strong,220);
         this.pvpRating.selectable = false;
         this.scrollTextPart.addLine(this.pvpRating);
         this.lineInfS3.x = 2;
         this.lineInfS3.y = this.pvpRating.y + this.pvpRating.height;
         this.scrollTextPart.addLine(this.lineInfS3);
         this.traumsText.x = 10;
         this.scrollTextPart.addLine(this.traumsText);
         addChild(firstWeaponLabel);
         addChild(secondWeaponLabel);
         addChild(this.scrollTextPart);
      }
      
      public function doAction340() : void
      {
         this.playerFullName.text = this.character.fullName;
         this.playerCity.text = this.character.city;
         this.playerCountry.text = this.character.country;
         this.playerHP.text = this.character.hp + "/" + this.character.hpAll;
         if(this.character.pvpRating == 0 && this.character.level > 0)
         {
            this.pvpRating.text = _("IDS_PVP_RATING_UNDEFINED");
            this.pvpRating.setTextFormat(NTextFormat.plain,0,this.pvpRating.text.length - 1);
         }
         else
         {
            this.pvpRating.text = formatString("IDS_PVP_RATING",this.character.pvpRating,this.character.NextRankPoints);
            this.pvpRating.setTextFormat(NTextFormat.plain,0,12);
         }
         this.playerAbout.text = this.character.about;
         this.playerAbout.height = this.playerAbout.textHeight + 6;
         var contentY:int = this.playerAbout.y + this.playerAbout.height + 4;
         this.lineInfS2.y = contentY;
         contentY += 6;
         this.pvpRating.y = contentY;
         contentY = this.pvpRating.y + this.pvpRating.height + 4;
         this.lineInfS3.y = contentY;
         contentY += 10;
         this.scrollTextPart.addLine(createLabel(10,contentY,_("IDS_STATE") + ":",NTextFormat.plain,100));
         contentY += 16;
         this.playerHP.y = contentY;
         this.scrollTextPart.addLine(createLabel(10,contentY,_("IDS_HP") + ":",NTextFormat.plain,100));
         contentY += 18;
         this.traumsText.y = contentY;
         this.scrollTextPart.init();
         this.updatePresents();
      }
      
      private function onLoad1(param1:Event) : void
      {
         this.weapon1Loader.x = 294 - this.weapon1Loader.width / 2;
         this.weapon1Loader.y = 114 - this.weapon1Loader.height / 2;
         this.weapon1Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad1);
      }
      
      private function onLoad2(param1:Event) : void
      {
         this.weapon2Loader.x = 294 - this.weapon2Loader.width / 2;
         this.weapon2Loader.y = 179 - this.weapon2Loader.height / 2;
         this.weapon2Loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoad2);
      }
      
      public function loadAppearance() : void
      {
         var imageRequest:URLRequest = new URLRequest("icons/avatar/av" + this.character.avatarImg + ".jpg");
         if(this.character.avatarImg != 0)
         {
            this.avatarLoader.load(imageRequest);
         }
         if(this.character.weaponImg[0] != 0)
         {
            imageRequest = new URLRequest("icons/inv/i" + this.character.weaponImg[0] + ".png");
            this.weapon1Loader.load(imageRequest);
            this.weapon1Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoad1);
            this.weapon1Loader.x = 294 - this.weapon1Loader.width / 2;
            this.weapon1Loader.y = 137 - this.weapon1Loader.height / 2;
         }
         if(this.character.weaponImg[1] != 0)
         {
            imageRequest = new URLRequest("icons/inv/i" + this.character.weaponImg[1] + ".png");
            this.weapon2Loader.load(imageRequest);
            this.weapon2Loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoad2);
         }
         this.gameBitmap1.doAction945(this.character);
      }
      
      public function updateTraums() : void
      {
         var traumaType:int = 0;
         var traumaParam:int = 0;
         var timeRemaining:int = 0;
         var unusedInt:int = 0;
         var unusedString:String = null;
         var traumaIndex:int = 0;
         this.traumsText.text = "";
         if(this.character.traumTypes)
         {
            traumaIndex = 0;
            while(traumaIndex < this.character.traumTypes.length)
            {
               traumaType = this.character.traumTypes[traumaIndex];
               timeRemaining = this.character.traumTimes[traumaIndex];
               traumaParam = this.character.traumParams[traumaIndex];
               switch(traumaType)
               {
                  case Effect.LIGHT_TRAUMA:
                  case Effect.SEVERE_TRAUMA:
                     this.traumsText.appendText(_("IDS_TRAUMA_" + traumaParam) + " (" + _("IDS_BUFF_" + traumaType) + ") " + _("IDS_TIME_LEFT") + " " + TimeToStr(timeRemaining) + "\n\n");
                     break;
                  case Effect.IRRADIATION:
                  case Effect.ALCOHOLISM:
                  case Effect.DRUG_ADDICTION:
                  case Effect.CHEMICAL_POISONING:
                  case Effect.EffectCount:
                     this.traumsText.appendText(_("IDS_BUFF_" + traumaType) + " (" + _("IDS_TRAUM_SEVERITY_2") + ")\n\n");
                     break;
                  default:
                     break;
               }
               traumaIndex++;
            }
         }
         this.traumsText.height = this.traumsText.textHeight;
         this.scrollTextPart.init(this.traumsText.y + this.traumsText.textHeight + 6);
      }
      
      private function updateAbility() : void
      {
         this.presentsList.disposePresents();
         var abilityIndex:int = 0;
         var clanAbilities:int = this.character.clanAbilities;
         var userAbilities:int = this.character.userAbilities;
         while(clanAbilities > 0 || userAbilities > 0)
         {
            if(clanAbilities & 1 == 1 || userAbilities & 1 == 1)
            {
               this.presentsList.addPresent(new PresentItem(0,0,abilityIndex,_("IDS_CLAN_ABILITY_" + abilityIndex),"ability/cability"));
            }
            abilityIndex++;
            clanAbilities >>= 1;
            userAbilities >>= 1;
         }
         this.presentsList.update();
         this.presentsList.setVals();
      }
      
      private function updatePresents() : void
      {
         var description:String;
         this.presentsList.disposePresents();
         var presentIndex:int = 0;
         var present:Object;
         while(presentIndex < this.character.presents.length)
         {
            present = this.character.presents[presentIndex];
            if(present.type != PresentItem.PT_ITEM_3)
            {
               if(present.senderLogin != "")
               {
                  description = _("IDS_PRESENTS_FROM") + " " + present.senderLogin + ". " + present.sig;
               }
               else
               {
                  description = _("IDS_ANONYM") + ". " + present.sig;
               }
               this.presentsList.addPresent(new PresentItem(present.id,present.type,present.img,description));
            }
            presentIndex++;
         }
         this.presentsList.update();
         this.presentsList.setVals();
      }
      
      private function doAction640() : void
      {
         this.presentsList.disposePresents();
         var presentIndex:int = 0;
         var present:Object;
         while(presentIndex < this.character.presents.length)
         {
            present = this.character.presents[presentIndex];
            if(present.type == PresentItem.PT_ITEM_3)
            {
               this.presentsList.addPresent(new PresentItem(present.id,present.type,present.img,_("IDS_PRESENTS_FROM") + " " + present.senderLogin + ". " + present.sig));
            }
            presentIndex++;
         }
         this.presentsList.update();
         this.presentsList.setVals();
      }
   }
}

