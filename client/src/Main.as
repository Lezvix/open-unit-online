package
{
   import core.resources.ResourcePack;
   import core.resources.ResourceManager;
   import net.*;
   import core.system.EventListeners;
   import game.npc.PlayerItem;
   import core.ui.*;
   import ui.menus.*;
   import game.world.*;
   import events.EventType;
   import events.UnitEventDispatcher;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.*;
   import game.*;
   import ui.*;
   
   public class Main extends Client
   {
      
      public static var KEY_TARGET_SELECTING:int = 0;
      
      public static var KEY_CAMERA_UP:int = 1;
      
      public static var KEY_CAMERA_DOWN:int = 2;
      
      public static var KEY_CAMERA_LEFT:int = 3;
      
      public static var KEY_CAMERA_RIGHT:int = 4;
      
      public static var KEY_CAMERA_CENTER:int = 5;
      
      public static var KEY_ACTION:int = 6;
      
      public static var KEY_RUN:int = 7;
      
      public static var KEY_ANGEL_UP:int = 8;
      
      public static var KEY_ANGEL_DOWN:int = 9;
      
      public static var KEY_BATTLE_MODE:int = 10;
      
      public static var KEY_CHARACTER_MENU:int = 11;
      
      public static var KEY_QUEST_MENU:int = 12;
      
      public static var KEY_INVENTORY:int = 13;
      
      public static var KEY_MAP_MENU:int = 14;
      
      public static var KEY_RELOAD:int = 15;
      
      public static var KEY_STOP:int = 16;
      
      public static var KEY_SLOT_1:int = 17;
      
      public static var KEY_SLOT_2:int = 18;
      
      public static var KEY_SLOT_3:int = 19;
      
      public static var KEY_SLOT_4:int = 20;
      
      public static var KEY_SLOT_5:int = 21;
      
      public static var KEY_SLOT_6:int = 22;
      
      public static var KEY_SLOT_7:int = 23;
      
      public static var KEY_SLOT_8:int = 24;
      
      public static var KEY_SLOT_9:int = 25;
      
      public static var KEY_SLOT_10:int = 26;
      
      public static var KEY_TOGGLE_CHAT:int = 27;
      
      public static var KEY_PET_ATTACK:int = 28;
      
      public static var KEY_PET_AGR_TOTAL:int = 29;
      
      public static var KEY_PET_AGR_PVE:int = 30;
      
      public static var KEY_PET_AGR_PVP:int = 31;
      
      public static var KEY_PET_AGR_NONE:int = 32;
      
      public static var KEY_CHANGE_SLOT:int = 33;
      
      public static var KEY_CHANGE_34:int = 34;
      
      public static var KEY_CHANGE_35:int = 35;
      
      public static var instance:Main;

      [Embed(source="/assets/Main_GRAD_TOP.png")]
      
      private var GRAD_TOP:Class;
      
      [Embed(source="/assets/Main_GRAD_BOTTOM.png")]
      
      private var GRAD_BOTTOM:Class;
      
      public var terminal:Terminal;
      
      private var enterPage:EnterPage;
      
      public var gameLoader:GameLoader;
      
      private const shape9:Shape = new Shape();
      
      private var fsocket:NuclearSocket;
      
      public var worldView:WorldView;
      
      public var nuclearWorld:NuclearWorld;
      
      public var chatPanel1:ChatPanel;
      
      public var nuclearChat:NuclearChat;
      
      public var upPanel:UpPanel;
      
      public var effectsPanel1:EffectsPanel;
      
      public var nuclearPanel:NuclearEPanel;
      
      private var useMenu:UseMenu = null;
      
      public var presentLogin:String = "";
      
      public var barterSelect:Boolean = false;
      
      public var dialogSelect:Boolean = false;
      
      public var weaponType:Array = new Array(0,0);
      
      public var weaponCharge:Array = new Array(0,0);
      
      public var weaponAmmo:Array = new Array(0,0);
      
      public var weaponCurrentAmmo:Array = new Array("-","-");
      
      public var fireType:Array = new Array(0,0);
      
      public var ammoType:Array = new Array(0,0);
      
      public var currentWeapon:int = 0;
      
      public var lastTime:uint;
      
      public var loadingStarted:Boolean = false;
      
      public var isCreatingChar:Boolean = false;
      
      public var startTime:uint;
      
      public var useMenuType:int;
      
      public var tutorialSelector:TutorialSelector = null;
      
      public var tutorialSelectorId:int = -1;
      
      private var gamePacksLoader1:GamePacksLoader;
      
      private var gameSoundManager1:GameSoundManager;
      
      public function Main()
      {
         super();
      }
      
      public static function closeMenus(... rest) : Boolean
      {
         var closedAny:Boolean = false;
         var menuIndex:int = 0;
         while(menuIndex < client.menus.length)
         {
            if(rest.indexOf(client.menus[menuIndex].menuType) != -1)
            {
               client.menus[menuIndex].closeMenu();
               closedAny = true;
            }
            menuIndex++;
         }
         return closedAny;
      }
      
      public static function get UserCharacter() : Character
      {
         return (client as Main).userCharacter;
      }
      
      public static function moveHint() : void
      {
         if(hintSprite)
         {
            if(app.mouseX < stageWidth / 2)
            {
               hintSprite.x = app.mouseX + 16;
            }
            else
            {
               hintSprite.x = app.mouseX - hintSprite.width - 5;
            }
            if(app.mouseY < stageHeight / 2)
            {
               hintSprite.y = app.mouseY + 13;
            }
            else
            {
               hintSprite.y = app.mouseY - hintSprite.height - 5;
            }
         }
      }
      
      public function init() : void
      {
         Client.client = this;
         instance = this;
         fsocket = new NuclearSocket(world,this);
         socket = this.fsocket;
         this.fsocket.dataHandler = processData;
         this.fsocket.connectHandler = this.socketConnectHandler;
         this.fsocket.connectionErrorHandler = this.socketConnectErrorHandler;
         this.fsocket.proxyConnectionErrorHandler = this.proxyConnectErrorHandler;
         this.fsocket.securityErrorHandler = this.socketSecurityErrorHandler;
         this.fsocket.proxySecurityErrorHandler = this.proxySecurityErrorHandler;
         this.fsocket.closeHandler = this.socketCloseHandler;
         this.fsocket.createCharInfoFunc = showCharInfo;
         GameEventDispatcher.addCommandHandler(Commands.FRIENDS_INFO,userCharacter.parseFriendsInfo);
         GameEventDispatcher.addCommandHandler(Commands.FRIENDS_INFO,this.doAction669);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST8,userCharacter.parseMoney);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST15,userCharacter.onStatusUpdate);
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST25,userCharacter.onEmailUpdate);
         UnitEventDispatcher.instance.addListener(EventType.EffectRemoved,userCharacter._on_effect_removed);
         UnitEventDispatcher.instance.addListener(EventType.EffectUpdated,userCharacter._on_effect_updated);
         UnitEventDispatcher.instance.addListener(EventType.eventType2,userCharacter.onServicesUpdate);
      }
      
      private function doAction669(param1:Array) : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.FRIENDS_INFO,this.doAction669);
         isBarterPressed = userCharacter.friendRequests > 0;
      }
      
      private var isBarterPressed:Boolean = false;

      public function get isTutorial() : Boolean
      {
         return userCharacter.level == 0 && getMenu(BaseMenu.TYPE_6);
      }
      
      public function doAction157() : void
      {
         gameSoundManager1 = new GameSoundManager();
         gamePacksLoader1 = new GamePacksLoader("ru");
         this.gamePacksLoader1.onGamePacksLoaded = this.doAction256;
         ResourceManager.sharedInstance = this.gamePacksLoader1;
         ResourceManager.sharedInstance.packCompleteHandler = this.onPackComplete;
         this.gamePacksLoader1.loadLocalePack();
      }
      
      private function onPackComplete(param1:ResourcePack) : void
      {
         ResourceManager.sharedInstance.packCompleteHandler = null;
         _uiContainer = new UIComponent();
         _uiContainer.handlesMouse = false;
         addChild(_uiContainer);
         uiContainer.handleAddedToUITree();
         NUIController.sharedController.cursorManager = new GameCursorManager(uiContainer);
         NUIController.sharedController.gameStarted = true;
         enterPage = new EnterPage(this,parent.width,parent.height);
         this.enterPage.width = parent.width;
         this.enterPage.height = parent.height;
         uiContainer.addUIChild(this.enterPage);
         fscommand("main");
      }
      
      public function startGameLoad() : void
      {
         gameLoader = new GameLoader(this,this.enterPage);
         uiContainer.addChild(this.gameLoader);
         this.gameLoader.drawAll();
         ResourceManager.sharedInstance.propValue185 = this.gameLoader.progress;
         ResourceManager.sharedInstance.packCompleteHandler = this.soundsLoadCompleat;
         this.gameLoader.loderText.text = _(this.gamePacksLoader1.packLoadingMessageId);
         this.gamePacksLoader1.loadRemainingGamePacks();
      }
      
      override protected function dataStartGame() : void
      {
         if(this.enterPage)
         {
            this.enterPage.moveIn();
         }
         else
         {
            this.startGame();
         }
      }
      
      private function soundsLoadCompleat(param1:ResourcePack) : void
      {
         this.gameLoader.loderText.text = _(this.gamePacksLoader1.packLoadingMessageId);
         this.gameLoader.container.graphics.clear();
         switch(param1.packId)
         {
            case GamePacksLoader.UI_PACK_ID:
               NuclearMenu.uiContainer = Sprite(param1.data);
               UIElement.uiPackId = GamePacksLoader.UI_PACK_ID;
               break;
            case GamePacksLoader.SOUNDS_PACK_ID:
               World.sprite7 = Sprite(param1.data);
               break;
            case GamePacksLoader.BACKGROUND_PACK_ID:
               World.resPacks.push(param1.data);
               break;
         }
      }
      
      private function doAction256() : void
      {
         uiContainer.removeUIChild(this.enterPage);
         enterPage = null;
         if(this.isCreatingChar)
         {
            showCharCreateMenu();
         }
         else
         {
            this.startGame();
         }
      }
      
      override public function setHint(param1:String) : void
      {
         var hintTextField:TextField = null;
         hintSprite = new Sprite();
         hintTextField = new TextField();
         hintTextField.defaultTextFormat = new TextFormat("Verdana",10,13408563);
         hintTextField.autoSize = TextFieldAutoSize.LEFT;
         hintTextField.selectable = false;
         hintTextField.multiline = false;
         hintTextField.x = 2;
         hintTextField.y = 1;
         hintTextField.text = param1;
         if(hintTextField.textWidth > 240)
         {
            hintTextField.wordWrap = true;
            hintTextField.width = 240;
            hintTextField.height = hintTextField.textHeight + 2;
         }
         hintSprite.graphics.clear();
         hintSprite.graphics.lineStyle(1,13408563,0.7);
         hintSprite.graphics.beginFill(1776411);
         hintSprite.graphics.drawRect(0,0,5 + hintTextField.width,hintTextField.numLines * 13 + 5);
         hintSprite.graphics.endFill();
         hintSprite.addChild(hintTextField);
         moveHint();
         addChild(hintSprite);
      }
      
      override public function mouseMoveHandler() : void
      {
         if(hintSprite)
         {
            moveHint();
         }
      }
      
      public function socketConnectHandler() : void
      {
         this.ping();
         this.fsocket.loginFight();
         this.enterPage.statusLabel.text = getString("IDS_CONNECTED");
      }
      
      public function socketCloseHandler() : void
      {
         socket.stopConnecting = true;
         if(gameStarted)
         {
            showNotifyMenu(getString("IDS_CONNECTION_CLOSED"));
         }
      }
      
      public function socketConnectErrorHandler() : void
      {
         this.enterPage.statusLabel.text = getString("IDS_CANT_CONNECT");
      }
      
      public function proxyConnectErrorHandler() : void
      {
         if(this.enterPage)
         {
            this.enterPage.statusLabel.text = getString("IDS_CANT_CONNECT_PROXY");
         }
      }
      
      public function socketSecurityErrorHandler() : void
      {
         if(this.enterPage)
         {
            this.enterPage.statusLabel.text = getString("IDS_SECURITY_ERROR") + ":" + socket.lastSecurityEvent.toString();
         }
      }
      
      public function proxySecurityErrorHandler() : void
      {
         this.enterPage.statusLabel.text = getString("IDS_SECURITY_ERROR_PROXY");
      }
      
      override protected function startGame() : void
      {
         super.startGame();
         parent.addEventListener(Event.DEACTIVATE,this.handleFocusOut);
         if(settings["lastLogin"] != "" && this.fsocket.login != settings["lastLogin"])
         {
            this.fsocket.removeClanUser(settings["lastLogin"]);
         }
         settings["lastLogin"] = this.fsocket.login;
         menu = getMenu(MENU_CHAR_CREATE);
         if(menu)
         {
            closeMenu(MENU_CHAR_CREATE);
         }
         this.startGameAfterLoad();
      }
      
      private function startGameAfterLoad() : void
      {
         var questArrow:Bitmap = null;
         nuclearWorld = new NuclearWorld(null);
         this.fsocket.world = this.nuclearWorld;
         questArrowSprite = new Sprite();
         questArrow = new NuclearMenu.uiContainer["QUEST_ARROW"]();
         questArrow.x = -16;
         questArrow.y = 0;
         questArrowSprite.addChild(questArrow);
         questArrowSprite.visible = false;
         upStairsSprite = new Sprite();
         upStairsSprite.visible = false;
         var upStair:Bitmap = new NuclearMenu.uiContainer["UP_STAIR"]();
         var downStair:Bitmap = new NuclearMenu.uiContainer["DOWN_STAIR"]();
         upStairsSprite.addChild(upStair);
         upStairsSprite.addChild(downStair);
         this.nuclearWorld.setQuestArrow(questArrowSprite,upStairsSprite,upStair,downStair,questArrow.width - 16,questArrow.height);
         this.nuclearWorld.visible = false;
         world = this.nuclearWorld;
         initClient();
         terminal = new Terminal(this,stageWidth,stageHeight);
         this.terminal.visible = false;
         nuclearChat = new NuclearChat(this,stageWidth,stageHeight);
         this.nuclearChat.visible = false;
         chatPanel1 = new ChatPanel(this,stageWidth,stageHeight);
         this.chatPanel1.visible = false;
         nuclearPanel = new NuclearEPanel(this);
         this.nuclearPanel.visible = false;
         upPanel = new UpPanel(this);
         this.upPanel.visible = false;
         effectsPanel1 = new EffectsPanel();
         this.effectsPanel1.setPos(5,144);
         this.effectsPanel1.visible = false;
         expPanel = this.upPanel;
         UseMenu.init();
         processInterval = setInterval(this.processWorld,WorldBase.MAX_LOAD_50);
         setInterval(this.forceGC,10000);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         uiContainer.addUIChild(this.nuclearPanel);
         uiContainer.addUIChild(this.upPanel);
         uiContainer.addUIChild(this.effectsPanel1);
         uiContainer.addUIChild(this.chatPanel1);
         uiContainer.addUIChild(this.nuclearChat);
         this.nuclearWorld.start();
         this.nuclearPanel.x = stageWidth - this.nuclearPanel.width;
         this.fsocket.enterGame();
         this.nuclearWorld.updatePanelLines();
         if(settings["enableRadio"])
         {
            world.startRadio();
         }
      }
      
      public function useMenuTimer() : void
      {
         clearInterval(useMenuInterval);
         if(this.useMenu)
         {
            this.useMenu.closeMenu();
            useMenu = null;
         }
         var selectedMenuType:int = -1;
         if(moveUse)
         {
            selectedMenuType = this.useMenuType;
         }
         else if(clickedUser.state == PlayerItem.stDead)
         {
            selectedMenuType = UseMenu.TYPE_DEAD;
         }
         else if(clickedUser.sessionId < 0)
         {
            selectedMenuType = this.nuclearChat.battleStateOn ? UseMenu.TYPE_BATTLE_NPC : UseMenu.TYPE_PEACE_NPC;
         }
         else
         {
            selectedMenuType = this.nuclearChat.battleStateOn ? UseMenu.TYPE_BATTLE_USER : UseMenu.TYPE_PEACE_USER;
         }
         useMenu = new UseMenu(this,selectedMenuType);
         this.useMenu.setPos(mouseX - uiContainer.x,mouseY - uiContainer.y);
         uiContainer.addUIChild(this.useMenu);
      }
      
      public function handleMouseAction(param1:int) : void
      {
         if(clickedUser)
         {
            switch(param1)
            {
               case UseMenu.ACTION_HEAL:
                  socket.sendActionRequest(clickedUser.sessionId,GameSocket.ACTION_ASK_HEAL);
                  break;
               case UseMenu.ACTION_REPAIR:
                  socket.sendActionRequest(clickedUser.sessionId,GameSocket.ACTION_ASK_REPAIR);
                  break;
               case UseMenu.ACTION_BARTER:
                  socket.sendActionRequest(clickedUser.sessionId,GameSocket.ACTION_BARTER);
                  break;
               case UseMenu.ACTION_DROP:
                  socket.sendActionRequest(clickedUser.sessionId,GameSocket.ACTION_BARTER);
                  break;
               case UseMenu.ACTION_DIALOG:
                  socket.sendActionRequest(clickedUser.sessionId,GameSocket.ACTION_DIALOG);
                  break;
               case UseMenu.ACTION_ATTACK:
                  this.nuclearChat.battleStateOn = true;
                  socket.attack(clickedUser.sessionId);
                  break;
            }
            if(PlayerItem.selectedTarget != clickedUser && clickedUser.state != PlayerItem.stDead)
            {
               if(PlayerItem.selectedTarget)
               {
                  PlayerItem.selectedTarget.removeSelectTarget();
               }
               PlayerItem.selectedTarget = clickedUser;
               PlayerItem.selectedTarget.addSelectTarget(this.nuclearChat.battleStateOn);
            }
            clickedUser = null;
         }
         else if(moveUse)
         {
            switch(param1)
            {
               case UseMenu.ACTION_MOVE:
                  socket.sendMove(tox,toy);
                  break;
               case UseMenu.ACTION_USE:
                  socket.sendUseItem(tox,toy);
                  break;
               case UseMenu.ACTION_TARGET_NEAR:
                  if(PlayerItem.selectedTarget)
                  {
                     PlayerItem.selectedTarget.removeSelectTarget();
                  }
                  PlayerItem.selectedTarget = world.findNearPlayer(realToX,realToY);
                  if(PlayerItem.selectedTarget)
                  {
                     PlayerItem.selectedTarget.addSelectTarget(this.nuclearChat.battleStateOn);
                  }
                  break;
               case UseMenu.ACTION_LOAD:
                  socket.sendReload();
                  break;
               case UseMenu.ACTION_UNLOAD:
                  socket.sendUnloadWeapon();
                  break;
            }
            moveUse = false;
         }
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.useMenu)
         {
            this.useMenu.closeMenu();
            useMenu = null;
         }
         else if(clickedUser)
         {
            if(clickedUser.state == PlayerItem.stDead)
            {
               this.handleMouseAction(UseMenu.ACTION_BARTER);
            }
            else if(clickedUser.sessionId < 0)
            {
               if(this.nuclearChat.auto && clickedUser.friendly)
               {
                  this.nuclearChat.battleStateOn = false;
               }
               if(this.nuclearChat.battleStateOn)
               {
                  this.handleMouseAction(UseMenu.ACTION_ATTACK);
               }
               else
               {
                  this.handleMouseAction(UseMenu.ACTION_DIALOG);
               }
            }
            else if(this.nuclearChat.battleStateOn)
            {
               this.handleMouseAction(UseMenu.ACTION_ATTACK);
            }
            else
            {
               this.handleMouseAction(UseMenu.ACTION_BARTER);
            }
            clearInterval(useMenuInterval);
         }
         else if(moveUse)
         {
            switch(this.useMenuType)
            {
               case UseMenu.TYPE_USE:
               case UseMenu.TYPE_MOVE:
                  this.handleMouseAction(UseMenu.ACTION_MOVE);
                  break;
               case UseMenu.TYPE_LOAD:
                  this.handleMouseAction(UseMenu.ACTION_LOAD);
                  break;
            }
            clearInterval(useMenuInterval);
         }
         super.mouseUpHandler();
      }
      
      override protected function showWorld() : void
      {
         this.hideMenus();
         this.terminal.visible = false;
         if(this.terminal.addedToUITree)
         {
            uiContainer.removeUIChild(this.terminal);
         }
         world.visible = true;
         addChildAt(world,0);
         this.upPanel.visible = true;
         this.nuclearPanel.visible = true;
         this.effectsPanel1.visible = true;
         this.nuclearChat.visible = true;
         this.chatPanel1.visible = true;
         uiContainer.addChild(questArrowSprite);
         uiContainer.addChild(upStairsSprite);
         this.resizeHandler();
         fscommand("main");
         if(this.gameLoader)
         {
            uiContainer.removeChild(this.gameLoader);
            gameLoader = null;
         }
      }
      
      override protected function hideMenus() : void
      {
         super.hideMenus();
         if(this.useMenu)
         {
            this.useMenu.closeMenu();
            useMenu = null;
         }
      }
      
      override protected function showTerminal() : void
      {
         settings["selectedI"] = -1;
         settings["selectedJ"] = -1;
         settings["selectedLev"] = -1;
         if(!expInUse || getData[1] == 1)
         {
            usingExpendable = false;
            expInUse = false;
            this.nuclearChat.clearInput();
         }
         this.hideMenus();
         if(world.visible)
         {
            removeChild(world);
            uiContainer.removeChild(questArrowSprite);
            uiContainer.removeChild(upStairsSprite);
            this.upPanel.visible = false;
            this.nuclearPanel.visible = false;
            this.effectsPanel1.visible = false;
            this.chatPanel1.visible = false;
            this.chatPanel1.doAction387();
            this.nuclearChat.visible = false;
            questArrowSprite.visible = false;
            upStairsSprite.visible = false;
         }
         this.terminal.deleteAll();
         uiContainer.addUIChild(this.terminal);
         this.terminal.visible = true;
         if(this.terminal.showWelcom)
         {
            this.terminal.showWelcom = false;
            this.terminal.createMenu(TM_MENU_WELCOM);
         }
         else
         {
            this.terminal.createMenu(TM_MENU_MAIN);
         }
         world.visible = false;
         this.resizeHandler();
         fscommand("main");
         if(this.gameLoader)
         {
            uiContainer.removeChild(this.gameLoader);
            gameLoader = null;
         }
      }
      
      public function drawCharCreateMenuBg(param1:Object, param2:int, param3:int) : void
      {
         uiContainer.graphics.beginFill(592137);
         uiContainer.graphics.drawRect(0,0,param2,param3);
         uiContainer.graphics.endFill();
         var topGradient:Bitmap = new this.GRAD_TOP();
         var bottomGradient:Bitmap = new this.GRAD_BOTTOM();
         var fillMatrix:Matrix = new Matrix();
         fillMatrix.ty = 0;
         graphics.beginBitmapFill(topGradient.bitmapData,fillMatrix);
         graphics.drawRect(0,0,param2,topGradient.height);
         graphics.endFill();
         fillMatrix.ty = param3 - bottomGradient.height;
         graphics.beginBitmapFill(bottomGradient.bitmapData,fillMatrix);
         graphics.drawRect(0,param3 - bottomGradient.height,param2,bottomGradient.height);
         graphics.endFill();
      }
      
      override public function mouseDownHandler() : void
      {
         if(needFadeOut)
         {
            needFadeOut = false;
            return;
         }
         if(this.isTutorial)
         {
            return;
         }
         if(this.useMenu)
         {
            this.useMenu.closeMenu();
            useMenu = null;
         }
         if(clickedUser || moveUse)
         {
            clearInterval(useMenuInterval);
            clickedUser = null;
         }
         if(this.terminal && !this.terminal.visible)
         {
            if(isCtrlPressed)
            {
               if(PlayerItem.selectedTarget)
               {
                  PlayerItem.selectedTarget.removeSelectTarget();
               }
               if(PlayerItem.isGlobalSelected)
               {
                  PlayerItem.selectedTarget = PlayerItem.target;
               }
               else
               {
                  PlayerItem.selectedTarget = world.findNearPlayer(mouseX - world.x,mouseY - world.y);
               }
               if(PlayerItem.selectedTarget)
               {
                  if(this.nuclearChat.auto && PlayerItem.selectedTarget.friendly)
                  {
                     this.nuclearChat.battleStateOn = false;
                  }
                  PlayerItem.selectedTarget.addSelectTarget(this.nuclearChat.battleStateOn);
               }
            }
            else if(flag4)
            {
               if(PlayerItem.selectedTarget)
               {
                  PlayerItem.selectedTarget.removeSelectTarget();
               }
               if(PlayerItem.isGlobalSelected)
               {
                  PlayerItem.selectedTarget = PlayerItem.target;
               }
               else
               {
                  PlayerItem.selectedTarget = world.findNearCorpse(mouseX - world.x,mouseY - world.y);
               }
               if(PlayerItem.selectedTarget)
               {
                  PlayerItem.selectedTarget.addSelectTarget(false);
               }
            }
            else if(usingExpendable)
            {
               if(world.hideItem == null)
               {
                  var hideRect:Rectangle = new Rectangle(-1,-1,-1,-1);
               }
               else
               {
                  hideRect = world.hideItem.hideRect;
               }
               tox = mouseX - world.x + WorldBase.worldXOfs;
               toy = mouseY - world.y + WorldItem.cMapLevelHeight * world.lPlayer.mapLevel + WorldBase.worldYOfs;
               socket.sendDirectUse(tox,toy,this.nuclearChat.throwAngleIdx,hideRect);
            }
            else if(PlayerItem.isGlobalSelected)
            {
               useMenuInterval = setInterval(this.useMenuTimer,200);
               clickedUser = PlayerItem.target;
            }
            else if(ObjectItem.target != null)
            {
               if(ObjectItem.target.advObjects != null)
               {
                  ObjectItem.target.processAdvertize();
               }
               else
               {
                  var id:int = ObjectItem.target.id;
                  if(ObjectItem.target.type == ObjectItem.START_SOUND_23)
                  {
                     var forgetMove:Function = function(param1:Object = null):void
                     {
                        GameEventDispatcher.removeCommandHandler("mv",onStartMove);
                     };
                     var leaveConfirmed:Function = function(param1:Object):void
                     {
                        forgetMove();
                        socket.send("us",id);
                     };
                     var onStartMove:Function = function(param1:Array):void
                     {
                        if(param1[1] == sessionId)
                        {
                           closeMenus(BaseMenu.TYPE_QUESTION);
                           forgetMove();
                        }
                     };
                     closeMenus(BaseMenu.TYPE_QUESTION);
                     GameEventDispatcher.addCommandHandler("mv",onStartMove);
                     showYesNoMenu(_("IDS_RAID_LEAVE_WARNING"),leaveConfirmed,forgetMove);
                  }
                  else
                  {
                     socket.send("us",id);
                  }
               }
            }
            else
            {
               tox = mouseX - world.x + WorldBase.worldXOfs;
               toy = mouseY - world.y + WorldItem.cMapLevelHeight * world.lPlayer.mapLevel + WorldBase.worldYOfs;
               realToX = mouseX - world.x;
               realToY = mouseY - world.y;
               useMenuInterval = setInterval(this.useMenuTimer,200);
               if(this.weaponType[this.currentWeapon] == InventoryItem.WEAPON_TYPE_NEAR_USE)
               {
                  useMenuType = UseMenu.TYPE_USE;
               }
               else
               {
                  useMenuType = UseMenu.TYPE_MOVE;
               }
               moveUse = true;
            }
         }
         super.mouseDownHandler();
      }
      
      override protected function tdataShowMap() : void
      {
         var mapMenu:Object = null;
         if(Terminal.instance.currentMenuId == TM_MENU_RLS)
         {
            mapMenu = showMapMenu(getData[1],getData[2],getData[3]);
            mapMenu.selectCoords(Terminal.instance.radioMenu.showMapI,Terminal.instance.radioMenu.showMapJ);
         }
      }
      
      override protected function dataLogin() : void
      {
         gameStarted = true;
         menu = getMenu(MENU_CHAR_CREATE);
         if(menu)
         {
            closeMenu(MENU_CHAR_CREATE);
         }
         this.upPanel.setRun(this.nuclearWorld.runVal,NuclearWorld.RUN_MAX);
         userCharacter.Permissions = getData[6];
         if(getData[5] > 0)
         {
            Terminal.instance.terminalNumber = getData[5] >> 1;
            Terminal.instance.radarMenuAvailable = (getData[5] & 1) == 1;
            if(!this.terminal.visible)
            {
               this.showTerminal();
            }
         }
         else
         {
            this.showWorld();
         }
         this.nuclearWorld.runSubValue = int(getData[9]) / 2;
         this.nuclearWorld.runAddValue = int(getData[10]) / 2;
         userCharacter.CurrentWeight = getData[11];
         this.nuclearWorld.userWeight = getData[11];
         this.nuclearChat.addonType = getData[7];
         this.nuclearChat.addonValue = getData[8];
         var addonDataIndex:int = userCharacter.parseFullInfo(getData,29);
         if(userCharacter.clanId != 0 && Client.settings["showChannel_" + ChatPanel.TYPE_CLAN])
         {
            this.chatPanel1.doAction103(ChatPanel.TYPE_CLAN);
         }
         playerLogin = userCharacter.name;
         userCharacter.experience = getData[13];
         userCharacter.levelExp = getData[14];
         userCharacter.nextLevelExp = getData[15];
         currentWeapon = getData[17];
         this.weaponType[0] = int(getData[18]);
         this.weaponAmmo[0] = getData[19];
         this.weaponCharge[0] = getData[20];
         this.fireType[0] = getData[21];
         this.ammoType[0] = getData[22];
         this.weaponType[1] = int(getData[23]);
         this.weaponAmmo[1] = getData[24];
         this.weaponCharge[1] = getData[25];
         this.fireType[1] = getData[26];
         this.ammoType[1] = getData[27];
         this.upPanel.setExperience(userCharacter.experience - userCharacter.levelExp,userCharacter.nextLevelExp - userCharacter.levelExp);
         this.upPanel.nameText.text = userCharacter.name;
         this.upPanel.levelText.text = userCharacter.level.toString();
         this.upPanel.loadAvatar(userCharacter.avatarImg);
         this.nuclearPanel.drawAddon(getData,addonDataIndex);
         this.nuclearChat.handleStateButton(this.currentWeapon);
         if(startHintType != -1)
         {
            showHint(startHintType,startHintHeader,startHintText);
         }
         if(startResetPlaceId != -1)
         {
            resetPlace(QUEST_IN_PROGRESS,startResetPlaceId);
         }
         if(startQuestId != -1)
         {
            setPlace(startQuestName,QUEST_IN_PROGRESS,startQuestId,startPlaceName,startPlaceI,startPlaceJ,startPlaceLevel);
         }
         if(userCharacter.avaiblePerks != 0)
         {
            this.upPanel.startNewLevelPerkMove(userCharacter.level);
         }
         if(serviceTime != 0)
         {
            this.upPanel.startServiceMove(serviceTime);
            serviceTime = 0;
         }
         if(this.isBarterPressed)
         {
            showNotifyMenu(_("IDS_NEW_FRIEND_REQUESTS"));
            isBarterPressed = false;
         }
      }
      
      override protected function dataNewBullets() : void
      {
         this.weaponCharge[getData[1]] = getData[2];
         this.weaponAmmo[getData[1]] = getData[3];
         this.nuclearChat.updateWeaponAmmo();
      }
      
      override protected function dataNewWeapons() : void
      {
         var fieldIndex:int = 1;
         var weaponIndex:int = 0;
         while(weaponIndex < 2)
         {
            userCharacter.weaponImg[weaponIndex] = int(getData[fieldIndex++]);
            userCharacter.weaponName[weaponIndex] = getData[fieldIndex++];
            this.weaponType[weaponIndex] = int(getData[fieldIndex++]);
            this.weaponAmmo[weaponIndex] = getData[fieldIndex++];
            this.weaponCharge[weaponIndex] = getData[fieldIndex++];
            this.fireType[weaponIndex] = getData[fieldIndex++];
            this.ammoType[weaponIndex] = getData[fieldIndex++];
            this.weaponCurrentAmmo[weaponIndex] = getData[fieldIndex++];
            weaponIndex++;
         }
         this.nuclearChat.updateWeapons();
      }
      
      override protected function dataExperianceChange() : void
      {
         userCharacter.experience = getData[2];
         userCharacter.levelExp = getData[3];
         userCharacter.nextLevelExp = getData[4];
         this.upPanel.setExperience(userCharacter.experience - userCharacter.levelExp,userCharacter.nextLevelExp - userCharacter.levelExp);
      }
      
      override protected function dataBaseChange() : void
      {
         this.nuclearWorld.runSubValue = int(getData[1]) / 2;
         this.nuclearWorld.runAddValue = int(getData[2]) / 2;
         if(player)
         {
            player.maxHp = int(getData[4]);
            this.upPanel.setHp(player.hp,player.maxHp);
         }
         var statIndex:int = 0;
         while(statIndex < Character.STAT_COUNT)
         {
            userCharacter.stats[statIndex] = int(getData[5 + statIndex]);
            statIndex++;
         }
         UnitEventDispatcher.instance.dispatch(EventType.eventType1);
         menu = getMenu(Client.MENU_CHARACTER);
         if(menu != null)
         {
            menu.updateCharacterLabels();
         }
      }
      
      override protected function dataUpdateRun() : void
      {
         this.nuclearWorld.runVal = int(getData[1]);
         this.upPanel.setRun(this.nuclearWorld.runVal,NuclearWorld.RUN_MAX);
      }
      
      override protected function dataCharExpendable() : void
      {
         this.nuclearPanel.drawAddon(getData,1);
      }
      
      override protected function dataCharacter() : void
      {
         userCharacter.parseInfo(getData,1);
      }
      
      override protected function dataSkillValueChange() : void
      {
         userCharacter.intellect = getData[1];
         userCharacter.prioritySkills = getData[2];
      }
      
      override protected function dataLoginFailed() : void
      {
         this.enterPage.enterButton.enabled = false;
         switch(int(getData[1]))
         {
            case ERROR_USER_ONLINE:
               this.enterPage.statusLabel.text = getString("IDS_USER_ONLINE");
               break;
            case ERROR_WRONG_LOGIN:
               this.enterPage.statusLabel.text = getString("IDS_WRONG_LOGIN");
               break;
            case ERROR_BANNED:
               this.enterPage.statusLabel.text = getString("IDS_LOGIN_BANNED");
               this.enterPage.enterButton.enabled = true;
               if(this.fsocket.social)
               {
                  this.enterPage.nameInput.enabled = true;
                  this.enterPage.passInput.enabled = true;
                  this.enterPage.passInput.text = "";
                  this.enterPage.loginButton.enabled = true;
                  this.enterPage.registerButton.enabled = true;
                  this.fsocket.social = false;
                  this.enterPage.social = false;
               }
               break;
            case ERROR_TO_MANY_TRIES:
               this.enterPage.statusLabel.text = getString("IDS_WAIT_15_SECS");
               break;
         }
      }
      
      override protected function dataUpdateUser() : void
      {
         var fieldIndex:int = 0;
         var updatedPlayer:PlayerItem = null;
         fieldIndex = 1;
         updatedPlayer = world.getPlayer(getData[fieldIndex]);
         if(updatedPlayer == null)
         {
            return;
         }
         fieldIndex += 3;
         var oldLevel:int = updatedPlayer.level;
         var oldClanId:int = updatedPlayer.clanId;
         var oldHireClanId:int = updatedPlayer.hireClanId;
         updatedPlayer.friendly = getData[fieldIndex++] == 1;
         updatedPlayer.level = getData[fieldIndex++];
         fieldIndex++;
         updatedPlayer.moveTimeValue = 0;
         var characterState:int = getData[fieldIndex++];
         switch(characterState)
         {
            case PlayerItem.csStand:
               if(updatedPlayer.state != PlayerItem.stUse)
               {
                  updatedPlayer.state = PlayerItem.stStand;
               }
               break;
            case PlayerItem.csMove:
               updatedPlayer.state = PlayerItem.stMove;
               updatedPlayer.loadMoveStack(getData[fieldIndex]);
               break;
            case PlayerItem.csDead:
               updatedPlayer.doAction238();
               break;
         }
         fieldIndex++;
         updatedPlayer.running = getData[fieldIndex++] == "1";
         updatedPlayer.fraction = getData[fieldIndex++];
         updatedPlayer.i = getData[fieldIndex++];
         updatedPlayer.j = getData[fieldIndex++];
         updatedPlayer.mapLevel = getData[fieldIndex++];
         updatedPlayer.doAction432();
         updatedPlayer.lastI = getData[fieldIndex++];
         updatedPlayer.lastJ = getData[fieldIndex++];
         updatedPlayer.walkSpeedValue = getData[fieldIndex++];
         updatedPlayer.runSpeedValue = getData[fieldIndex++];
         updatedPlayer.speed = updatedPlayer.running ? updatedPlayer.runSpeedValue : updatedPlayer.walkSpeedValue;
         updatedPlayer.maxHp = getData[fieldIndex + 1];
         updatedPlayer.hp = getData[fieldIndex];
         fieldIndex += 2;
         updatedPlayer.clanId = getData[fieldIndex++];
         updatedPlayer.clanName = getData[fieldIndex++];
         updatedPlayer.clanUrl = getData[fieldIndex++];
         updatedPlayer.hireClanId = getData[fieldIndex++];
         updatedPlayer.hireClanName = getData[fieldIndex++];
         updatedPlayer.hireClanUrl = getData[fieldIndex++];
         updatedPlayer.doAction332(getData.slice(fieldIndex,fieldIndex + 13));
         fieldIndex += 13;
         if(updatedPlayer == player)
         {
            this.upPanel.setHp(player.hp,player.maxHp);
            userCharacter.level = updatedPlayer.level;
            this.upPanel.levelText.text = userCharacter.level.toString();
         }
         if(oldLevel != updatedPlayer.level)
         {
            if(updatedPlayer == player)
            {
               if(userCharacter.avaiblePerks != 0 && updatedPlayer.level % 3 == 0)
               {
                  this.upPanel.startNewLevelPerkMove(userCharacter.level);
               }
               else
               {
                  this.upPanel.startNewLevelMove(userCharacter.level);
               }
            }
         }
         if(updatedPlayer.sessionId > 0 && (oldLevel != updatedPlayer.level || updatedPlayer.clanId != oldClanId || updatedPlayer.hireClanId != oldHireClanId))
         {
            this.chatPanel1.onExit(updatedPlayer);
         }
      }
      
      override protected function dataOwnPlayerLevel() : void
      {
         userCharacter.level = getData[1];
         if(userCharacter.avaiblePerks != 0 && userCharacter.level % 3 == 0)
         {
            this.upPanel.startNewLevelPerkMove(userCharacter.level);
         }
         else
         {
            this.upPanel.startNewLevelMove(userCharacter.level);
         }
      }
      
      override protected function dataUserList() : void
      {
         this.fsocket.gameIsStarted = true;
         var fieldIndex:int = 1;
         var newPlayer:PlayerItem;
         var playerLoginValue:String;
         var characterState:int;
         while(fieldIndex < getData.length - 1)
         {
            newPlayer = PlayerItem.create(getData[fieldIndex + 5]);
            newPlayer.sessionId = getData[fieldIndex];
            newPlayer.userId = getData[fieldIndex + 1];
            playerLoginValue = getData[fieldIndex + 2];
            newPlayer.friendly = getData[fieldIndex + 3] == 1;
            newPlayer.level = getData[fieldIndex + 4];
            characterState = getData[fieldIndex + 6];
            switch(characterState)
            {
               case PlayerItem.csStand:
                  if(newPlayer.state != PlayerItem.stUse)
                  {
                     newPlayer.state = PlayerItem.stStand;
                  }
                  break;
               case PlayerItem.csMove:
                  newPlayer.state = PlayerItem.stMove;
                  newPlayer.loadMoveStack(getData[fieldIndex + 7]);
                  break;
               case PlayerItem.csDead:
                  newPlayer.state = PlayerItem.stDead;
                  break;
               default:
                  throw new Error();
            }
            fieldIndex += 8;
            newPlayer.moveTimeValue = 0;
            newPlayer.running = getData[fieldIndex++] == "1";
            newPlayer.fraction = getData[fieldIndex++];
            newPlayer.i = getData[fieldIndex++];
            newPlayer.j = getData[fieldIndex++];
            newPlayer.destI = newPlayer.i;
            newPlayer.destJ = newPlayer.j;
            newPlayer.mapLevel = getData[fieldIndex++];
            newPlayer.doAction432();
            newPlayer.lastI = getData[fieldIndex++];
            newPlayer.lastJ = getData[fieldIndex++];
            newPlayer.walkSpeedValue = getData[fieldIndex++];
            newPlayer.runSpeedValue = getData[fieldIndex++];
            if(newPlayer.running)
            {
               newPlayer.speed = newPlayer.runSpeedValue;
            }
            else
            {
               newPlayer.speed = newPlayer.walkSpeedValue;
            }
            newPlayer.maxHp = getData[fieldIndex + 1];
            newPlayer.hp = getData[fieldIndex];
            fieldIndex += 2;
            newPlayer.clanId = getData[fieldIndex++];
            newPlayer.clanName = getData[fieldIndex++];
            newPlayer.clanUrl = getData[fieldIndex++];
            newPlayer.hireClanId = getData[fieldIndex++];
            newPlayer.hireClanName = getData[fieldIndex++];
            newPlayer.hireClanUrl = getData[fieldIndex++];
            newPlayer.login = playerLoginValue;
            newPlayer.doAction332(getData.slice(fieldIndex,fieldIndex + 13));
            fieldIndex += 13;
            world.addItem(newPlayer);
            if(newPlayer.sessionId > 0)
            {
               this.chatPanel1.onExit(newPlayer);
            }
            if(newPlayer == player)
            {
               closeMenu(MENU_RESPAWN_COUNTER);
               world.followMode = World.FOLLOW_PLAYER;
               this.upPanel.setHp(player.hp,player.maxHp);
               this.updateRun();
               this.nuclearWorld.moveCameraFor(player.x,player.y);
               world.updateArrow();
            }
         }
      }
      
      override protected function dataFireBullet() : void
      {
         this.nuclearWorld.addGranade(getData[1],getData[3],getData[4],getData[5],getData[6],getData[7],getData[8],getData[2],getData[9],getData[10],getData[11],getData[12],int(getData[13]) == 1);
      }
      
      override protected function dataCreatingChar() : void
      {
         isCreatingChar = true;
         userCharacter.sex = getData[1];
         this.startGameLoad();
      }
      
      override protected function dataCharacterMenu() : void
      {
         var nextFieldIndex:int = userCharacter.parseExtendedInfo(getData);
         showCharacterMenu(getData,nextFieldIndex);
      }
      
      override protected function dataUpdateCharacter() : void
      {
         userCharacter.parseFullInfo(getData);
         menu = getMenu(MENU_CHARACTER);
         if(menu)
         {
            menu.startMenu();
         }
      }
      
      override protected function dataExpendableEndUse() : void
      {
         if(!expInUse || getData[1] == 1)
         {
            usingExpendable = false;
            expInUse = false;
            this.nuclearChat.clearInput();
            if(getData[1] == 1)
            {
               this.nuclearPanel.subItemCount(expendableIdx);
            }
         }
         else if(expInUse && getData[1] == 2)
         {
            usingExpendable = false;
            expInUse = false;
            this.nuclearChat.clearInput();
         }
      }
      
      override protected function dataChangeAddon() : void
      {
         this.nuclearChat.addonType = getData[1];
         this.nuclearChat.addonValue = getData[2];
      }
      
      override protected function dataAddonValue() : void
      {
         this.nuclearChat.addonValue = getData[1];
      }
      
      override protected function dataStartExpUse() : void
      {
         expInUse = true;
         usingExpendable = true;
         expendableIdx = getData[1];
         this.nuclearChat.setUseSprite(this.nuclearPanel.getQuickSlotImage(expendableIdx),this.nuclearPanel.getQuickSlotItemName(expendableIdx));
      }
      
      override protected function dataWeightChange() : void
      {
         userCharacter.CurrentWeight = getData[1];
         super.dataWeightChange();
      }
      
      override protected function dataAvaiblePerks() : void
      {
         userCharacter.avaiblePerks = getData[1];
      }
      
      override protected function dataChangePaidFeatures() : void
      {
         userCharacter.avatarImg = getData[1];
         this.upPanel.loadAvatar(userCharacter.avatarImg);
         userCharacter.images[Character.HAIR_IDX] = int(getData[2]);
      }
      
      override protected function dataOwnWeaponWait() : void
      {
         this.upPanel.startWaitTimer(getData[1]);
      }
      
      override protected function dataOwnUse() : void
      {
         this.upPanel.startUseWait(getData[1]);
      }
      
      override protected function dataEffectUpdate() : void
      {
         UnitEventDispatcher.instance.dispatch(EventType.EffectUpdated,{
            "type":int(getData[1]),
            "endtime":int(getData[2]) + new Date().valueOf() / 1000,
            "param":int(getData[3]),
            "uid":Number(getData[4])
         });
      }
      
      override protected function dataBuffDelete() : void
      {
         UnitEventDispatcher.instance.dispatch(EventType.EffectRemoved,{
            "uid":Number(getData[1]),
            "type":int(getData[2])
         });
      }
      
      override protected function dataServiceList() : void
      {
         UnitEventDispatcher.instance.dispatch(EventType.eventType2,{"data":getData.slice(1)});
      }
      
      override protected function processWorld() : void
      {
         if(world.visible)
         {
            if(player)
            {
               world.process(true);
               world.sortView();
            }
            super.processWorld();
         }
      }
      
      private function processObj() : void
      {
         if(player)
         {
            world.processObjData();
         }
         var remainingTime:int = 50 - getTimer() + processTime;
         if(remainingTime < 0)
         {
            remainingTime = 0;
         }
      }
      
      private function forceGC() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      private function ping() : void
      {
         socket.sendPing();
         setTimeout(this.ping,20000);
      }
      
      override public function createMenu(param1:int, param2:Object = null) : NuclearMenu
      {
         var createdMenu:Object = null;
         switch(param1)
         {
            case MENU_SETTINGS:
               createdMenu = new SettingsMenu(this);
               createdMenu.createSettingsMenu();
               break;
            case MENU_QUEST_LOG:
               createdMenu = new QuestLog(this);
               createdMenu.createQuestLog(param2.data);
               break;
            case MENU_DIALOG:
               createdMenu = new DialogMenu(socket,param2.data,userCharacter.name,param2.isObjectDialog);
               createdMenu.createMenu();
               createdMenu.parseDialogNode(param2.data,param2.nodeDataIdx,param2.addTradeNode,param2.addMedNode,param2.addFixNode);
               break;
            case MENU_PAID_SERVICES:
               createdMenu = new PaidServicesMenu(this,param2.data,this.presentLogin);
               presentLogin = "";
               createdMenu.createPaidServicesMenu();
               break;
            case MENU_MAP:
               createdMenu = new MapMenu(this);
               createdMenu.createMap(param2.mapName,param2.width,param2.height);
               break;
            case MENU_RESPAWN_COUNTER:
               createdMenu = new RespawnCounter(param2.respawnTicks);
               createdMenu.createRespawnCounter();
               if(param2.tip != "" && settings["tips"])
               {
                  startMenu(MENU_TIPS,param2,createdMenu,MENU_POS_FREE);
                  createdMenu.centerMenu(stageWidth,this.chatPanel1.y - getMenu(MENU_TIPS).height - 2);
                  getMenu(MENU_TIPS).y = createdMenu.y + createdMenu.height + 2;
               }
               else
               {
                  createdMenu.centerMenu(stageWidth,this.chatPanel1.y);
               }
               break;
            case MENU_TIPS:
               createdMenu = new TipsMenu(param2.tip);
               createdMenu.createTipsMenu();
               createdMenu.centerMenu(stageWidth,this.chatPanel1.y);
               break;
            case MENU_CHAR_CREATE:
               if(this.gameLoader != null)
               {
                  uiContainer.removeChild(this.gameLoader);
                  gameLoader = null;
               }
               createdMenu = new CharacterMenu(this,userCharacter,true);
               createdMenu.createCreateCharacter();
               this.resizeHandler();
               break;
            case MENU_CHARACTER:
               this.upPanel.hideNewLevel();
               closeMenu(MENU_CHAR_CREATE);
               createdMenu = new CharacterMenu(this,userCharacter,false,param2.data,param2.idx);
               createdMenu.createCharacterMenu();
               break;
         }
         return createdMenu as NuclearMenu;
      }
      
      public function Connect(param1:Object = null) : void
      {
         this.enterPage.statusLabel.text = getString("IDS_CONNECTING_TO_SERVER");
         if(param1 == null)
         {
            this.fsocket.social = false;
            this.fsocket.login = this.enterPage.nameInput.text;
            this.fsocket.password = this.enterPage.passInput.text;
         }
         else
         {
            this.fsocket.social = true;
            this.fsocket.socialLoginCredentials = param1;
            this.fsocket.login = param1.user.toString();
         }
         socket.connectGame();
      }
      
      private function doAction744(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(param1 === 0 && param2 === 0)
         {
            if(mask)
            {
               mask = null;
            }
            return;
         }
         this.shape9.graphics.clear();
         this.shape9.graphics.beginFill(0);
         this.shape9.graphics.drawRect(param1,param2,param3,param4);
         this.shape9.graphics.endFill();
         if(!mask)
         {
            mask = this.shape9;
         }
      }
      
      public function doAction841(param1:int, param2:int) : void
      {
         _curWidth = param1;
         _curHeight = param2;
         var offsetX:int = 0;
         var offsetY:int = 0;
         if(param1 > MAX_STAGE_WIDTH)
         {
            offsetX = param1 - MAX_STAGE_WIDTH >> 1;
         }
         if(param2 > MAX_STAGE_HEIGHT)
         {
            offsetY = param2 - MAX_STAGE_HEIGHT >> 1;
         }
         uiContainer.setPos(offsetX,offsetY);
         var viewHeight:int = Math.min(param2,MAX_STAGE_HEIGHT);
         var viewWidth:int = Math.min(param1,MAX_STAGE_WIDTH);
         this.doAction744(offsetX,offsetY,viewWidth,viewHeight);
         if(this.gameLoader != null)
         {
            this.gameLoader.resize(viewWidth,viewHeight);
         }
         if(this.enterPage != null)
         {
            this.enterPage.resize(viewWidth,viewHeight);
         }
         if(world != null && world.visible)
         {
            if(player)
            {
               updateFollowPosition();
            }
            if(world.followMode == World.FOLLOW_POSITION)
            {
               world.moveCameraForPosition();
            }
            this.chatPanel1.doAction155(viewWidth,viewHeight);
            this.nuclearChat.doAction155(viewWidth,viewHeight);
            this.nuclearChat.x = this.chatPanel1.x + this.chatPanel1.width;
            this.nuclearPanel.x = viewWidth - this.nuclearPanel.width;
            nZoneInfo1.x = int((viewWidth - nZoneInfo1.width) / 2);
            this.nuclearWorld.updatePanelLines();
            this.nuclearWorld.updateArrow(viewWidth,viewHeight);
         }
         else if(this.terminal != null && this.terminal.visible)
         {
            this.terminal.doAction155(viewWidth,viewHeight);
         }
      }
      
      override protected function resizeHandler() : void
      {
         this.doAction841(stageWidth,stageHeight);
         super.resizeHandler();
      }
      
      override public function updateRun() : void
      {
         this.upPanel.runLight.visible = player.running;
      }
      
      public function useQuickSlot(param1:int) : void
      {
         if(!this.nuclearPanel.isLocked && this.nuclearPanel.hasQuickSlotItem(param1))
         {
            usingExpendable = true;
            expendableIdx = param1;
            socket.sendUseExp(expendableIdx);
         }
      }
      
      public function removeTutorialSelector() : void
      {
         if(this.tutorialSelector != null)
         {
            this.tutorialSelector.parent.removeChild(this.tutorialSelector);
            tutorialSelectorId = -1;
            tutorialSelector = null;
         }
      }
      
      public function doAction131(param1:int, param2:int, param3:int, param4:int, param5:Object, param6:int = 25) : void
      {
         tutorialSelector = new TutorialSelector(param1,param2,param3,param4,param6);
         param5.addChild(this.tutorialSelector);
      }
      
      public function checkTutorialSelector(param1:int) : void
      {
         if(this.tutorialSelectorId == param1)
         {
            this.removeTutorialSelector();
         }
      }
      
      override public function addTutorialSelector(param1:int) : void
      {
         var inventoryMenu:Inventory = null;
         this.removeTutorialSelector();
         tutorialSelectorId = param1;
         switch(param1)
         {
            case GameConsts.GAME_CONSTS_CONST2:
            case GameConsts.GAME_CONSTS_CONST1:
               this.nuclearChat.tutorHighligt(param1);
               break;
            case GameConsts.RUN:
               this.upPanel.tutorHighligt(param1);
               break;
            case GameConsts.RAM_2:
            case GameConsts.RAM_BOTTOM:
            case GameConsts.RAM_3:
               inventoryMenu = getMenu(BaseMenu.TYPE_INVENTORY) as Inventory;
               if(inventoryMenu != null)
               {
                  inventoryMenu.tutorHighligt(param1);
               }
               break;
         }
      }
      
      protected function handleKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case getKey(KEY_TARGET_SELECTING):
               isCtrlPressed = false;
               break;
            case getKey(KEY_CHANGE_35):
               flag4 = false;
               break;
            case getKey(KEY_CAMERA_UP):
               upPressed = false;
               break;
            case getKey(KEY_CAMERA_DOWN):
               downPressed = false;
               break;
            case getKey(KEY_CAMERA_RIGHT):
               rightPressed = false;
               break;
            case getKey(KEY_CAMERA_LEFT):
               leftPressed = false;
               break;
         }
      }
      
      protected function handleFocusOut(param1:Event) : void
      {
         isCtrlPressed = false;
         flag4 = false;
         upPressed = false;
         downPressed = false;
         rightPressed = false;
         leftPressed = false;
      }
      
      override public function getTraumSaverity(param1:int) : int
      {
         return int(Character.TRAUM_SEVERITY[param1]);
      }
      
      override protected function onKeyDown(param1:KeyboardEvent) : void
      {
         var slotIndex:int = 0;
         menu = getMenu(MENU_SETTINGS);
         if(menu && menu.selectedId >= 0 && menu.handleKeyPress(param1.keyCode))
         {
            return;
         }
         if(!usingExpendable)
         {
            slotIndex = 0;
            while(slotIndex < 10)
            {
               if(param1.keyCode == getKey(KEY_SLOT_1 + slotIndex))
               {
                  this.useQuickSlot(slotIndex);
                  return;
               }
               slotIndex++;
            }
         }
         switch(param1.keyCode)
         {
            case getKey(KEY_TARGET_SELECTING):
               isCtrlPressed = true;
               flag4 = false;
               break;
            case getKey(KEY_CHANGE_35):
               flag4 = true;
               isCtrlPressed = false;
               break;
            case getKey(KEY_CAMERA_CENTER):
               world.followMode = World.FOLLOW_PLAYER;
               break;
            case getKey(KEY_CAMERA_UP):
               upPressed = true;
               break;
            case getKey(KEY_CAMERA_DOWN):
               downPressed = true;
               break;
            case getKey(KEY_CAMERA_RIGHT):
               rightPressed = true;
               break;
            case getKey(KEY_CAMERA_LEFT):
               leftPressed = true;
               break;
            case getKey(KEY_ACTION):
               if(PlayerItem.selectedTarget && !this.isTutorial)
               {
                  clickedUser = PlayerItem.selectedTarget;
                  if(clickedUser.state == PlayerItem.stDead)
                  {
                     this.handleMouseAction(UseMenu.ACTION_BARTER);
                  }
                  else if(clickedUser.sessionId < 0)
                  {
                     if(this.nuclearChat.auto && clickedUser.friendly)
                     {
                        this.nuclearChat.battleStateOn = false;
                     }
                     if(this.nuclearChat.battleStateOn)
                     {
                        this.handleMouseAction(UseMenu.ACTION_ATTACK);
                     }
                     else
                     {
                        this.handleMouseAction(UseMenu.ACTION_DIALOG);
                     }
                  }
                  else if(this.nuclearChat.battleStateOn)
                  {
                     this.handleMouseAction(UseMenu.ACTION_ATTACK);
                  }
                  else
                  {
                     this.handleMouseAction(UseMenu.ACTION_BARTER);
                  }
               }
               break;
            case getKey(KEY_TOGGLE_CHAT):
               if(PlayerItem.selectedTarget)
               {
                  socket.petAttack(PlayerItem.selectedTarget.sessionId);
               }
               break;
            case getKey(KEY_PET_ATTACK):
               socket.sendPetAgression(PET_AGRESSION_TOTAL);
               this.upPanel.setPetAgression(0);
               break;
            case getKey(KEY_PET_AGR_TOTAL):
               socket.sendPetAgression(PET_AGRESSION_PVE);
               this.upPanel.setPetAgression(1);
               break;
            case getKey(KEY_PET_AGR_PVE):
               socket.sendPetAgression(PET_AGRESSION_PVP);
               this.upPanel.setPetAgression(2);
               break;
            case getKey(KEY_PET_AGR_PVP):
               socket.sendPetAgression(PET_AGRESSION_NONE);
               this.upPanel.setPetAgression(3);
               break;
            case getKey(KEY_STOP):
               socket.sendStop();
               break;
            case getKey(KEY_RUN):
               this.checkTutorialSelector(GameConsts.RUN);
               socket.sendChangeRun();
               break;
            case getKey(KEY_ANGEL_UP):
               this.nuclearChat && this.nuclearChat.handleAngleUp();
               break;
            case getKey(KEY_ANGEL_DOWN):
               this.nuclearChat && this.nuclearChat.handlePrivatePress();
               break;
            case getKey(KEY_BATTLE_MODE):
               this.checkTutorialSelector(GameConsts.GAME_CONSTS_CONST1);
               this.nuclearChat && (this.nuclearChat.battleStateOn = !this.nuclearChat.battleStateOn);
               break;
            case getKey(KEY_CHARACTER_MENU):
               if(!param1.ctrlKey)
               {
                  menu = getMenu(MENU_CHAR_CREATE);
                  if(menu != null)
                  {
                     menu.closeMenu();
                  }
                  else
                  {
                     menu = getMenu(MENU_CHARACTER) as CharacterMenu;
                     if(menu == null)
                     {
                        socket.getCharMenu();
                     }
                     else
                     {
                        menu.closeMenu();
                     }
                  }
               }
               break;
            case getKey(KEY_QUEST_MENU):
               menu = getMenu(MENU_QUEST_LOG) as QuestLog;
               if(menu == null)
               {
                  if(!this.isTutorial)
                  {
                     socket.sendQuestLogRequest();
                  }
               }
               else
               {
                  menu.closeMenu();
               }
               break;
            case getKey(KEY_INVENTORY):
               if(!this.isTutorial)
               {
                  menu = getMenu(BaseMenu.TYPE_INVENTORY) as Inventory;
                  if(menu == null)
                  {
                     socket.getInventory();
                  }
                  else
                  {
                     socket.sendStr("ia");
                  }
               }
               break;
            case getKey(KEY_MAP_MENU):
               if(!this.isTutorial)
               {
                  menu = getMenu(MENU_MAP) as MapMenu;
                  if(menu == null)
                  {
                     socket.sendGetMap();
                  }
                  else
                  {
                     menu.closeMenu();
                  }
               }
               break;
            case getKey(KEY_RELOAD):
               if(!this.isTutorial)
               {
                  socket.sendReload();
               }
               break;
            case getKey(KEY_PET_AGR_NONE):
               if(!this.isTutorial)
               {
                  socket.sendChangeHand(this.currentWeapon == 0 ? 1 : 0);
               }
               break;
            case getKey(KEY_CHANGE_SLOT):
               if(!this.isTutorial)
               {
                  GameSocket.socket.sendStr("ax");
               }
               break;
            case getKey(KEY_CHANGE_34):
               Screenshot.doAction404();
               break;
         }
         super.onKeyDown(param1);
      }
      
      override protected function addedToStage(param1:Event) : void
      {
         EventListeners.addEventListener(stage,KeyboardEvent.KEY_UP,this.handleKeyUp);
         super.addedToStage(param1);
      }
   }
}

