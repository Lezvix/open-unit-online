package ui
{
   import ui.buttons.NButton;
   import net.FightSocket;
   import core.ui.BaseButton;
   import core.ui.UIComponent;
   import core.effects.Move;
   import core.effects.TweenEffect;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   import flash.events.*;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class EnterPage extends NUIComponent
   {
      
      private var DOOR_RIGHT:Class = EnterPage_DOOR_RIGHT;
      
      private var DOOR_LEFT:Class = EnterPage_DOOR_LEFT;
      
      private var PANEL:Class = EnterPage_PANEL;
      
      private var ENTER_BUTTON:Class = EnterPage_ENTER_BUTTON;
      
      private var ENTER_BUTTON_OVER:Class = EnterPage_ENTER_BUTTON_OVER;
      
      private var ENTER_BUTTON_PRESSED:Class = EnterPage_ENTER_BUTTON_PRESSED;
      
      private var GRAD_TOP:Class = EnterPage_GRAD_TOP;
      
      private var GRAD_BOTTOM:Class = EnterPage_GRAD_BOTTOM;
      
      private var ENTER_GRAD:Class = EnterPage_ENTER_GRAD;
      
      private var TEXT_PLACE:Class = EnterPage_TEXT_PLACE;
      
      public var nameInput:NTextInput;
      
      public var passInput:NTextInput;
      
      private var moveRight:Move;
      
      private var moveLeft:Move;
      
      private var main:Main;
      
      public var loginButton:BaseButton;
      
      private var panelSprite:UIComponent = new UIComponent();
      
      private var doorRightPart:UIComponent = new UIComponent();
      
      private var doorLeftPart:UIComponent = new UIComponent();
      
      private var maskUI1:UIComponent = new UIComponent();
      
      private var maskUI2:UIComponent = new UIComponent();
      
      public var statusLabel:TextField;
      
      public var registerButton:BaseButton;
      
      private var time:Timer = new Timer(300);
      
      public var social:Boolean = false;
      
      private var params:Object = {};
      
      public var enterButton:NButton;
      
      public function EnterPage(main:Main, w:int, h:int)
      {
         this.main = main;
         this.graphics.beginFill(592137);
         this.graphics.drawRect(0,0,w,h);
         this.graphics.endFill();
         var panel:Bitmap = new this.PANEL();
         var textPlace:Bitmap = new this.TEXT_PLACE();
         var grad_top:Bitmap = new this.GRAD_TOP();
         var grad_bottom:Bitmap = new this.GRAD_BOTTOM();
         var doorRight:Bitmap = new this.DOOR_RIGHT();
         var doorLeft:Bitmap = new this.DOOR_LEFT();
         var matrix:Matrix = new Matrix();
         matrix.ty = 0;
         graphics.beginBitmapFill(grad_top.bitmapData,matrix);
         graphics.drawRect(0,0,w,grad_top.height);
         matrix.ty = h - grad_bottom.height;
         graphics.beginBitmapFill(grad_bottom.bitmapData,matrix);
         graphics.drawRect(0,h - grad_bottom.height,w,grad_bottom.height);
         this.panelSprite.graphics.beginBitmapFill(panel.bitmapData);
         this.panelSprite.graphics.drawRect(0,0,panel.width,panel.height);
         this.panelSprite.graphics.endFill();
         matrix.ty = 237;
         matrix.tx = 15;
         this.panelSprite.graphics.beginBitmapFill(textPlace.bitmapData,matrix);
         this.panelSprite.graphics.drawRect(15,237,textPlace.width,textPlace.height);
         this.panelSprite.graphics.endFill();
         this.nameInput = this.createTextInput(16,int(panel.width / 2) - 64,int(panel.height / 2) - 27,154);
         this.nameInput.showPlaceholder(_("IDS_YOUR_LOGIN"));
         this.params = LoaderInfo(main.root.loaderInfo).parameters;
         this.social = "social" in this.params && this.params.social.toString() == "true" && "type" in this.params && "id" in this.params && "user" in this.params && "token" in this.params;
         if(this.social)
         {
            this.nameInput.text = this.params.user.toString();
            this.nameInput.enabled = false;
         }
         this.nameInput.onKeyDown = this.onNameKey;
         this.passInput = this.createTextInput(64,int(panel.width / 2) - 64,int(panel.height / 2),154);
         this.passInput.displayAsPassword = true;
         this.passInput.showPlaceholder(_("IDS_YOUR_PASS"));
         if(this.social)
         {
            this.passInput.text = "bowl of petunias";
            this.passInput.enabled = false;
         }
         this.passInput.onKeyDown = this.onPassKey;
         this.statusLabel = this.createText(240,0,0);
         var inputFormat:TextFormat = new TextFormat();
         inputFormat.font = "Verdana";
         inputFormat.color = 10053154;
         inputFormat.align = TextFormatAlign.CENTER;
         inputFormat.size = 10;
         inputFormat.bold = true;
         inputFormat.underline = false;
         this.statusLabel.defaultTextFormat = inputFormat;
         this.statusLabel.text = _("IDS_ENTER_USERNAME_AND_PASS");
         this.panelSprite.x = int((w - panel.width) / 2);
         this.panelSprite.y = int((h - panel.height) / 2);
         this.panelSprite.width = panel.width;
         this.panelSprite.height = panel.height;
         addUIChild(this.panelSprite);
         this.panelSprite.addUIChild(this.nameInput);
         this.panelSprite.addUIChild(this.passInput);
         function onStatusClick(param1:Object):void
         {
            navigateToURL(new URLRequest("http://nkvd-online.ru/justice/?name=" + FightSocket(main.socket).login),"_blank");
         }
         this.enterButton = new NButton(onStatusClick,this.statusLabel);
         this.enterButton.setPos(int(panel.width / 2) - 95,int(panel.height / 2) + 191);
         this.enterButton.enabled = false;
         var transformOver:ColorTransform = new ColorTransform(1.6,1.6,1.6);
         this.enterButton.mouseOverCallback = function(param1:Object):void
         {
            enterButton.transform.colorTransform = transformOver;
         };
         var transformNormal:ColorTransform = new ColorTransform();
         this.enterButton.mouseOutCallback2 = function(param1:Object):void
         {
            enterButton.transform.colorTransform = transformNormal;
         };
         this.panelSprite.addUIChild(this.enterButton);
         var enterGradBmp:Bitmap = new this.ENTER_GRAD();
         enterGradBmp.x = 133;
         enterGradBmp.y = 417;
         this.panelSprite.addChild(enterGradBmp);
         var but1:Bitmap = new this.ENTER_BUTTON();
         var butOvr:Bitmap = new this.ENTER_BUTTON_OVER();
         var butPrs:Bitmap = new this.ENTER_BUTTON_PRESSED();
         this.loginButton = new NButton(this.onClick,but1,butOvr,butPrs,but1);
         this.loginButton.x = int((panel.width - this.loginButton.width) / 2) + 34;
         this.loginButton.y = int(panel.height / 2) + 127;
         this.panelSprite.addUIChild(this.loginButton);
         this.loginButton.enabled = false;
         var tf12Bold:TextFormat = new TextFormat();
         tf12Bold.font = "Verdana";
         tf12Bold.color = 10451751;
         tf12Bold.size = 12;
         tf12Bold.bold = true;
         tf12Bold.align = TextFormatAlign.CENTER;
         var tf12BoldLight:TextFormat = new TextFormat();
         tf12BoldLight.font = "Verdana";
         tf12BoldLight.color = 16443497;
         tf12BoldLight.size = 12;
         tf12BoldLight.bold = true;
         tf12BoldLight.align = TextFormatAlign.CENTER;
         var butText:TextField = new TextField();
         butText.width = enterGradBmp.width;
         butText.height = 18;
         butText.selectable = false;
         butText.defaultTextFormat = tf12Bold;
         butText.text = _("IDS_GAME_REGISTER");
         var butTextOver:TextField = new TextField();
         butTextOver.width = enterGradBmp.width;
         butTextOver.height = 18;
         butTextOver.selectable = false;
         butTextOver.defaultTextFormat = tf12BoldLight;
         butTextOver.text = _("IDS_GAME_REGISTER");
         this.registerButton = new NButton(this.handleRegisterPress,butText,butTextOver,butTextOver);
         this.registerButton.x = enterGradBmp.x;
         this.registerButton.y = 397;
         this.registerButton.enabled = !this.social;
         this.panelSprite.addUIChild(this.registerButton);
         this.maskUI1.x = 0;
         this.maskUI1.y = 0;
         this.maskUI1.width = w;
         this.maskUI1.height = h;
         this.maskUI1.graphics.clear();
         this.maskUI1.graphics.beginFill(65280);
         this.maskUI1.graphics.drawRect(int(this.panelSprite.width / 2) - 67,int(this.panelSprite.height / 2) - 32,161,59);
         this.maskUI2.x = 0;
         this.maskUI2.y = 0;
         this.maskUI2.width = w;
         this.maskUI2.height = h;
         this.maskUI2.graphics.clear();
         this.maskUI2.graphics.beginFill(65280);
         this.maskUI2.graphics.drawRect(int(this.panelSprite.width / 2) - 67,int(this.panelSprite.height / 2) - 32,161,59);
         this.doorRightPart.width = doorRight.width;
         this.doorRightPart.x = int((this.panelSprite.width + doorRight.width) / 2) - 28;
         this.doorRightPart.y = int((this.panelSprite.height - doorRight.height) / 2) - 2;
         this.doorRightPart.graphics.beginBitmapFill(doorRight.bitmapData);
         this.doorRightPart.graphics.drawRect(0,0,doorRight.width,doorRight.height);
         this.doorLeftPart.width = doorLeft.width;
         this.doorLeftPart.x = int((this.panelSprite.width - doorLeft.width) / 2) - 18;
         this.doorLeftPart.y = int((this.panelSprite.height - doorLeft.height) / 2) - 2;
         this.doorLeftPart.graphics.beginBitmapFill(doorLeft.bitmapData);
         this.doorLeftPart.graphics.drawRect(0,0,doorLeft.width,doorLeft.height);
         this.doorRightPart.mask = this.maskUI1;
         this.doorLeftPart.mask = this.maskUI2;
         this.panelSprite.addChild(this.maskUI1);
         this.panelSprite.addChild(this.maskUI2);
         this.panelSprite.addChild(this.doorLeftPart);
         this.panelSprite.addChild(this.doorRightPart);
         this.time.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.time.start();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.nameInput.focus();
         this.nameInput.selectAll();
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         this.moveOut();
         this.time.stop();
         time = null;
      }
      
      public function moveOut() : void
      {
         moveRight = new Move(this.doorRightPart);
         moveLeft = new Move(this.doorLeftPart);
         this.moveLeft.xBy = -this.doorLeftPart.width;
         this.moveRight.xBy = this.doorRightPart.width;
         this.moveRight.duration = 1.5;
         this.moveLeft.duration = 1.5;
         this.moveLeft.play();
         this.moveRight.play();
         this.moveRight.addEndListener(this.onDoorsOpened);
      }
      
      public function moveIn() : void
      {
         this.doorRightPart.x -= 7;
         this.doorLeftPart.x += 7;
         this.panelSprite.addChild(this.doorLeftPart);
         this.panelSprite.addChild(this.doorRightPart);
         this.moveLeft.xBy = this.doorLeftPart.width - 7;
         this.moveRight.xBy = -this.doorRightPart.width + 7;
         this.moveRight.duration = 1.5;
         this.moveLeft.duration = 1.5;
         this.moveLeft.play();
         this.moveRight.play();
         this.moveLeft.addEndListener(this.onDoorsClosed);
         this.loginButton.enabled = false;
      }
      
      private function onDoorsOpened(effect:TweenEffect) : void
      {
         this.moveRight.removeEndListener(this.onDoorsOpened);
         this.panelSprite.removeChild(this.doorLeftPart);
         this.panelSprite.removeChild(this.doorRightPart);
         if(this.social)
         {
            this.main.Connect(this.params);
         }
         else
         {
            this.loginButton.enabled = true;
         }
      }
      
      private function onDoorsClosed(effect:TweenEffect) : void
      {
         this.main.startGameLoad();
      }
      
      public function resize(newWidth:int, newHeight:int) : void
      {
         this.graphics.beginFill(592137);
         this.graphics.drawRect(0,0,newWidth,newHeight);
         this.graphics.endFill();
         var gradTop:Bitmap = new this.GRAD_TOP();
         var gradBottom:Bitmap = new this.GRAD_BOTTOM();
         var matrix:Matrix = new Matrix();
         matrix.ty = 0;
         graphics.beginBitmapFill(gradTop.bitmapData,matrix);
         graphics.drawRect(0,0,newWidth,gradTop.height);
         graphics.endFill();
         matrix.ty = newHeight - gradBottom.height;
         graphics.beginBitmapFill(gradBottom.bitmapData,matrix);
         graphics.drawRect(0,newHeight - gradBottom.height,newWidth,gradBottom.height);
         graphics.endFill();
         this.panelSprite.x = newWidth / 2 - this.panelSprite.width / 2;
         this.panelSprite.y = newHeight / 2 - this.panelSprite.height / 2;
         width = newWidth;
         height = newHeight;
      }
      
      private function handleRegisterPress(sender:Object) : void
      {
         navigateToURL(new URLRequest(_("IDS_REGISTRATION_PAGE")),"_blank");
      }
      
      private function onClick(sender:Object) : void
      {
         this.enterButton.enabled = false;
         this.main.Connect();
      }
      
      private function onNameKey(event:KeyboardEvent) : void
      {
         if(this.social)
         {
            return;
         }
         if(event.keyCode == Keyboard.ENTER)
         {
            this.main.Connect();
         }
         else if(event.keyCode == Keyboard.TAB)
         {
            stage.focus = this.passInput;
         }
      }
      
      private function onPassKey(event:KeyboardEvent) : void
      {
         if(this.social)
         {
            return;
         }
         if(event.keyCode == Keyboard.ENTER)
         {
            this.main.Connect();
         }
         else if(event.keyCode == Keyboard.TAB)
         {
            stage.focus = this.nameInput;
         }
      }
      
      private function createText(textWidth:uint, posX:uint, posY:uint) : TextField
      {
         var textField:TextField = new TextField();
         textField.borderColor = 13408563;
         textField.width = textWidth;
         textField.height = 18;
         textField.x = posX;
         textField.y = posY;
         return textField;
      }
      
      private function createTextInput(maxChars:int, posX:Number, posY:Number, inputWidth:Number) : NTextInput
      {
         var input:NTextInput = new NTextInput(maxChars,new NTextFormat({"color":10053154}));
         input.setPos(posX,posY);
         input.width = inputWidth;
         return input;
      }
   }
}

