package ui
{
   import ui.buttons.NButton;
   import net.GameEventDispatcher;
   import core.display.BmpTextField;
   import ui.menus.*;
   import core.effects.Move;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.Chat;
   import game.GameConsts;
   
   public class UpPanel extends NUIComponent
   {
      
      private var pvpBmp:Array;
      
      private var levelSprite:NButton;
      
      private var serviceSprite:NButton;
      
      private var serviceText:TextField;
      
      private var levelBmpText:BmpTextField;
      
      private var curPvpBmp:Bitmap = null;
      
      private var avatar:Loader;
      
      public var nameText:TextField;
      
      public var levelText:TextField;
      
      private var hp:int;
      
      private var hpAll:int;
      
      private var main:Main;
      
      private var pvpSprite:Sprite;
      
      public var runLight:Bitmap;
      
      private var movement:Move;
      
      private var petBmp:Bitmap;
      
      private var petAgressionInterval:int = -1;
      
      private var agressionText:TextField;
      
      private var agressionTF:TextFormat;
      
      private var startWaitTime:int = 0;
      
      private var endWaitTime:int = 0;
      
      private var needWaitRedraw:Boolean = false;
      
      private var useWaitStart:int = 0;
      
      private var useWaitEnd:int = -1;
      
      private var useWaitBmps:Array = new Array();
      
      private var useWaitVisible:Boolean = false;
      
      private var progressBar2:ProgressBar;
      
      private var hpSprite:ProgressBar;
      
      private var progressBar1:ProgressBar;
      
      private var progressBar3:ProgressBar;
      
      private var iconHint1Button:NButton;
      
      public function UpPanel(main:Main)
      {
         this.pvpBmp = [getBmp("UP_PANEL_PVP"),getBmp("UP_PANEL_NO_PVP"),getBmp("UP_PANEL_GOOD_PVP"),getBmp("UP_PANEL_PVP"),getBmp("UP_PANEL_GOOD_PVP")];
         processIntervalValue = 40;
         this.main = main;
         this.petBmp = getBmp("PET_INDICATOR");
         this.petBmp.x = 7;
         this.petBmp.y = 157;
         var sprite:Sprite = new Sprite();
         sprite.addChild(getBmp("LEVEL_INDICATOR"));
         this.levelBmpText = new BmpTextField(33,25,getBmp("CLOCK_FONT")," 0123456789.:",3);
         this.levelBmpText.x = 148;
         this.levelBmpText.y = 31;
         sprite.addChild(this.levelBmpText);
         function onCharMenuOpened(param1:Array):void
         {
            GameEventDispatcher.removeCommandHandler("cm",onCharMenuOpened);
            try
            {
               (main.getMenu(BaseMenu.TYPE_19) as CharacterMenu).doAction598(CharacterMenu.TAB_PERK);
            }
            catch(err:Error)
            {
            }
         }
         function onNewLevelClick(param1:Object):void
         {
            var characterMenu:CharacterMenu = null;
            param1.visible = false;
            param1.y = -50;
            if(param1.value)
            {
               characterMenu = main.getMenu(BaseMenu.TYPE_19) as CharacterMenu;
               if(characterMenu == null)
               {
                  GameEventDispatcher.addCommandHandler("cm",onCharMenuOpened);
                  main.socket.getCharMenu();
               }
               else
               {
                  characterMenu.doAction598(CharacterMenu.TAB_PERK);
               }
            }
         }
         this.levelSprite = new NButton(onNewLevelClick,sprite);
         this.levelSprite.visible = false;
         addUIChild(this.levelSprite);
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = 13408563;
         format.size = 12;
         format.bold = true;
         sprite = new Sprite();
         sprite.addChild(getBmp("SERVICE_OVER"));
         this.serviceText = new TextField();
         this.serviceText.x = 117;
         this.serviceText.y = 16;
         this.serviceText.width = 70;
         this.serviceText.height = 18;
         this.serviceText.defaultTextFormat = format;
         this.serviceText.selectable = false;
         sprite.addChild(this.serviceText);
         function onServicesClick(param1:Object):void
         {
            param1.visible = false;
            param1.y = -50;
            var servicesMenu:PaidServicesMenu = main.getMenu(BaseMenu.TYPE_ACTION_10) as PaidServicesMenu;
            if(servicesMenu == null)
            {
               main.socket.showPaidServices();
            }
         }
         this.serviceSprite = new NButton(onServicesClick,sprite);
         this.serviceSprite.visible = false;
         addUIChild(this.serviceSprite);
         var bitmap:Bitmap = getBmp("UP_PANEL_FULL");
         addChild(bitmap);
         width = bitmap.width;
         height = bitmap.height;
         function hpTipGenerator(param1:Number, param2:Number):String
         {
            return int(param1 * 100 / param2) + "%  " + param1 + "/" + param2;
         }
         this.hpSprite = new ProgressBar(124,100,100,hpTipGenerator);
         this.hpSprite.setPos(335,14);
         addUIChild(this.hpSprite);
         var s:String = _("IDS_RUN_TOOLTEXT") + SettingsMenu.getKeyText(main.getKey(Main.KEY_RUN));
         function runTipGenerator(param1:Number, param2:Number):String
         {
            return s + " (" + int(param1 * 100 / param2) + "%)";
         }
         function runProgressClick(param1:Object):void
         {
            main.checkTutorialSelector(GameConsts.RUN);
            main.socket.sendChangeRun();
         }
         this.progressBar2 = new ProgressBar(126,100,100,runTipGenerator,runProgressClick);
         this.progressBar2.setPos(483,14);
         addUIChild(this.progressBar2);
         this.progressBar3 = new ProgressBar(124,100,100);
         this.progressBar3.setPos(638,14);
         addChild(this.progressBar3);
         function expTipGenerator(param1:Number, param2:Number):String
         {
            return int(param1 * 100 / param2) + "%  " + param1 + "/" + param2;
         }
         this.progressBar1 = new ProgressBar(180,100,100,expTipGenerator);
         this.progressBar1.setPos(108,34);
         addUIChild(this.progressBar1);
         this.avatar = new Loader();
         this.iconHint1Button = new NButton(this.onIconHint1Click,this.avatar,null,null,null,_("IDS_ICON_HINT_1"));
         this.iconHint1Button.setPos(19,12);
         addUIChild(this.iconHint1Button);
         var textFormat:TextFormat = NTextFormat.normal.center;
         this.nameText = new TextField();
         this.nameText.selectable = false;
         this.nameText.width = 172;
         this.nameText.height = 20;
         this.nameText.x = 110;
         this.nameText.y = 14;
         this.nameText.defaultTextFormat = NTextFormat.titleFormat;
         var nameBtn:NButton = new NButton(this.onIconHintCharInfoClick,this.nameText,null,null,null,_("IDS_ICON_HINT_CHAR_INFO"));
         addUIChild(nameBtn);
         this.levelText = new TextField();
         this.levelText.selectable = false;
         this.levelText.width = 22;
         this.levelText.x = 287;
         this.levelText.y = 14;
         this.levelText.defaultTextFormat = NTextFormat.titleFormat;
         addChild(this.levelText);
         this.runLight = getBmp("UP_PANEL_RUN");
         this.runLight.x = 461;
         this.runLight.y = 8;
         addChild(this.runLight);
         sprite = new Sprite();
         sprite.graphics.drawRect(0,0,22,22);
         var btn:NButton = new NButton(runProgressClick,sprite);
         btn.setPos(461,8);
         addUIChild(btn);
         this.pvpSprite = new Sprite();
         this.pvpSprite.x = 806;
         this.pvpSprite.y = 3;
         addChild(this.pvpSprite);
         var bmp:Bitmap;
         var i:int = 0;
         while(i < 2)
         {
            bmp = getBmp("WI_" + i);
            bmp.x = 615;
            bmp.y = 5;
            bmp.visible = false;
            addChild(bmp);
            this.useWaitBmps.push(bmp);
            i++;
         }
         this.useWaitVisible = false;
         var defFormat:TextFormat = new TextFormat();
         defFormat.font = "Verdana";
         defFormat.color = 12255111;
         defFormat.size = 12;
         this.agressionTF = new TextFormat();
         this.agressionTF.font = "Verdana";
         this.agressionTF.color = 12255111;
         this.agressionTF.bold = true;
         this.agressionTF.size = 12;
         this.agressionText = new TextField();
         this.agressionText.x = 50;
         this.agressionText.y = 160;
         this.agressionText.width = 230;
         this.agressionText.height = 40;
         this.agressionText.multiline = true;
         this.agressionText.wordWrap = true;
         this.agressionText.defaultTextFormat = defFormat;
         this.agressionText.selectable = false;
         this.updateWaitProgress();
      }
      
      override public function tutorHighligt(param1:int) : void
      {
         switch(param1)
         {
            case GameConsts.RUN:
               if(!this.runLight.visible)
               {
                  Main.instance.doAction131(this.runLight.x,this.runLight.y,this.runLight.width,this.runLight.height,this);
               }
               break;
         }
      }
      
      public function setPetAgression(param1:int) : void
      {
         if(this.petAgressionInterval != -1)
         {
            clearInterval(this.petAgressionInterval);
            removeChild(this.petBmp);
            removeChild(this.agressionText);
         }
         petAgressionInterval = setInterval(this.handleAgressionInterval,2000);
         this.agressionText.text = _("IDS_AGRESSION_NOTICE") + " \"";
         var startIndex:int = this.agressionText.text.length;
         this.agressionText.appendText(_("IDS_AGR_PET_" + param1));
         var endIndex:int = this.agressionText.text.length;
         this.agressionText.appendText("\"");
         this.agressionText.setTextFormat(this.agressionTF,startIndex,endIndex);
         addChild(this.petBmp);
         addChild(this.agressionText);
      }
      
      public function handleAgressionInterval() : void
      {
         clearInterval(this.petAgressionInterval);
         petAgressionInterval = -1;
         removeChild(this.petBmp);
         removeChild(this.agressionText);
      }
      
      public function startNewLevelPerkMove(param1:int) : void
      {
         this.levelSprite.value = true;
         this.levelSprite.x = 114;
         this.levelSprite.y = -31;
         movement = new Move(this.levelSprite);
         this.movement.duration = 1;
         this.movement.yBy = 75;
         this.levelSprite.visible = true;
         if(param1 < 10)
         {
            this.levelBmpText.setText("0" + param1.toString());
         }
         else
         {
            this.levelBmpText.setText(param1.toString());
         }
         this.movement.play();
      }
      
      public function startNewLevelMove(param1:int) : void
      {
         this.levelSprite.value = false;
         this.levelSprite.x = 114;
         this.levelSprite.y = -31;
         movement = new Move(this.levelSprite);
         this.movement.duration = 1;
         this.movement.yBy = 54;
         if(param1 < 10)
         {
            this.levelBmpText.setText("0" + param1);
         }
         else
         {
            this.levelBmpText.setText(param1.toString());
         }
         this.levelSprite.visible = true;
         this.movement.play();
      }
      
      public function startServiceMove(param1:int) : void
      {
         this.serviceSprite.x = 111;
         this.serviceSprite.y = -18;
         movement = new Move(this.serviceSprite);
         this.movement.duration = 1;
         this.movement.yBy = 61;
         this.serviceText.text = Chat.getString32(param1);
         this.serviceSprite.visible = true;
         this.movement.play();
      }
      
      public function hideServiceSprite() : void
      {
         this.serviceSprite.visible = false;
      }
      
      public function hideNewLevel() : void
      {
         this.levelSprite.visible = false;
      }
      
      public function setHp(param1:int, param2:int) : void
      {
         param1 = Math.max(0,Math.min(param1,param2));
         this.hp = param1;
         this.hpAll = param2;
         this.hpSprite.updateValues(param1,param2,0.2 * param2);
      }
      
      public function setExperience(param1:int, param2:int) : void
      {
         param1 = Math.max(0,Math.min(param1,param2));
         this.progressBar1.updateValues(param1,param2);
      }
      
      public function setRun(param1:int, param2:int) : void
      {
         param1 = Math.max(0,Math.min(param1,param2));
         this.progressBar2.updateValues(param1,param2);
         if(param1 == 0)
         {
            this.runLight.visible = false;
         }
      }
      
      public function loadAvatar(param1:int) : void
      {
         this.avatar.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
         this.avatar.contentLoaderInfo.addEventListener(Event.COMPLETE,this.ioErrorHandler);
         this.avatar.load(new URLRequest("icons/avatar/av" + param1 + ".jpg"));
      }
      
      private function ioErrorHandler(param1:Event) : void
      {
         this.avatar.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.ioErrorHandler);
         this.avatar.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
         this.iconHint1Button.upState = this.avatar;
      }
      
      private function onContentLoaderInfoIoError(param1:IOErrorEvent) : void
      {
         this.avatar.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.ioErrorHandler);
         this.avatar.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onContentLoaderInfoIoError);
         this.iconHint1Button.upState = getBmp("AVATAR_NOT_FOUND");
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && mouseX >= 0 && mouseY >= 0 && (mouseX < 853 && mouseY < 29 || mouseX < 312 && mouseY < 45 || mouseX < 117 && mouseY < 139);
      }
      
      private function onIconHint1Click(param1:Object) : void
      {
         var characterMenu:CharacterMenu = this.main.getMenu(BaseMenu.TYPE_19) as CharacterMenu;
         if(characterMenu == null)
         {
            this.main.socket.getCharMenu();
         }
         else
         {
            characterMenu.closeMenu();
         }
      }
      
      private function onIconHintCharInfoClick(param1:Object) : void
      {
         var characterInfo:CharacterInfo = this.main.getMenu(BaseMenu.TYPE_CHARACTER_INFO) as CharacterInfo;
         if(characterInfo == null || characterInfo.character.userId != this.main.userCharacter.userId)
         {
            this.main.socket.getCharInfo(this.main.userCharacter.userId);
         }
         else
         {
            characterInfo.closeMenu();
         }
      }
      
      public function setPvpType(param1:int) : void
      {
         if(this.curPvpBmp)
         {
            this.pvpSprite.removeChild(this.curPvpBmp);
         }
         curPvpBmp = this.pvpBmp[param1];
         this.pvpSprite.addChild(this.curPvpBmp);
      }
      
      public function startWaitTimer(param1:int) : void
      {
         if(param1 > 0)
         {
            startWaitTime = getTimer();
            endWaitTime = this.startWaitTime + param1;
            needWaitRedraw = true;
            this.updateWaitProgress();
         }
         else
         {
            startWaitTime = endWaitTime = 0;
            this.progressBar3.updateValues(1,1);
         }
      }
      
      public function startUseWait(param1:int) : void
      {
         if(param1 > 0)
         {
            useWaitStart = getTimer();
            useWaitEnd = this.useWaitStart + param1;
            this.updateUseWaitIcon();
         }
      }
      
      private function setUseWaitIcon(param1:int) : void
      {
         var index:int = 0;
         if(param1 < 0 || !this.useWaitBmps[param1].visible)
         {
            index = 0;
            while(index < this.useWaitBmps.length)
            {
               this.useWaitBmps[index].visible = false;
               index++;
            }
            if(param1 >= 0)
            {
               useWaitVisible = true;
               this.useWaitBmps[param1].visible = true;
            }
            else
            {
               useWaitVisible = false;
            }
         }
      }
      
      protected function updateUseWaitIcon() : void
      {
         var currentTime:int = getTimer();
         if(currentTime < this.useWaitEnd)
         {
            if(this.useWaitEnd - currentTime <= 500)
            {
               this.setUseWaitIcon(0);
            }
            else
            {
               this.setUseWaitIcon(1);
            }
         }
         else if(this.useWaitVisible)
         {
            this.setUseWaitIcon(-1);
         }
      }
      
      override protected function process() : void
      {
         this.updateUseWaitIcon();
         this.updateWaitProgress();
      }
      
      protected function updateWaitProgress() : void
      {
         var currentTime:int = getTimer();
         if(currentTime < this.endWaitTime || this.needWaitRedraw)
         {
            this.progressBar3.updateValues(currentTime - this.startWaitTime,this.endWaitTime - this.startWaitTime);
            needWaitRedraw = currentTime < this.endWaitTime;
         }
      }
   }
}

