package ui
{
   import core.ui.UIComponent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import mx.events.ResizeEvent;
   
   public class GameLoader extends UIComponent
   {
      
      [Embed(source="/assets/GameLoader_DOOR_RIGHT.png")]
      
      private var DOOR_RIGHT:Class;
      
      [Embed(source="/assets/GameLoader_DOOR_LEFT.png")]
      
      private var DOOR_LEFT:Class;
      
      [Embed(source="/assets/EnterPage_PANEL.png")]
      
      private var PANEL:Class;
      
      [Embed(source="/assets/Main_GRAD_TOP.png")]
      
      private var GRAD_TOP:Class;
      
      [Embed(source="/assets/Main_GRAD_BOTTOM.png")]
      
      private var GRAD_BOTTOM:Class;
      
      [Embed(source="/assets/GameLoader_TEXT_PLACE.png")]
      
      private var TEXT_PLACE:Class;
      
      public var progressText:TextField;
      
      private var main:Main;
      
      private var radius:Number = 18;
      
      private var satelliteRadius:Number = 1.5;
      
      public var container:Sprite = new Sprite();
      
      private var percents:int;
      
      private var upperPart:Sprite = new Sprite();
      
      private var lastVal:int = -1;
      
      public var loderText:TextField;
      
      private var enterPage:NUIComponent;
      
      public function GameLoader(param1:Main, param2:NUIComponent)
      {
         super();
         this.main = param1;
         this.enterPage = param2;
         this.progressText = new TextField();
         this.progressText.width = 40;
         this.progressText.height = 40;
         var progressFormat:TextFormat = new TextFormat();
         progressFormat.font = "Verdana";
         progressFormat.color = 13408563;
         progressFormat.align = TextFormatAlign.CENTER;
         progressFormat.size = 10;
         progressFormat.bold = true;
         this.progressText.defaultTextFormat = progressFormat;
         this.loderText = this.createText(240,param1.stageWidth / 2 - 95,param1.stageHeight / 2 + 190);
         var loaderFormat:TextFormat = new TextFormat();
         loaderFormat.font = "Verdana";
         loaderFormat.color = 10053154;
         loaderFormat.align = TextFormatAlign.CENTER;
         loaderFormat.size = 10;
         loaderFormat.bold = true;
         this.loderText.defaultTextFormat = loaderFormat;
         addChild(this.loderText);
         this.addEventListener(ResizeEvent.RESIZE,this.resizeHandler);
         addChild(this.container);
         addChild(this.upperPart);
         addChild(this.progressText);
      }
      
      public function drawAll() : void
      {
         this.progressText.x = int(this.enterPage.width / 2) - 8;
         this.progressText.y = int(this.enterPage.height / 2) - 12;
         this.container.x = int(this.enterPage.width / 2) + 13;
         this.container.y = int(this.enterPage.height / 2) - 3;
         graphics.clear();
         var panelBitmap:Bitmap = new this.PANEL();
         var topGradient:Bitmap = new this.GRAD_TOP();
         var bottomGradient:Bitmap = new this.GRAD_BOTTOM();
         var rightDoor:Bitmap = new this.DOOR_RIGHT();
         var leftDoor:Bitmap = new this.DOOR_LEFT();
         var textBackground:Bitmap = new this.TEXT_PLACE();
         var fillMatrix:Matrix = new Matrix();
         this.graphics.beginFill(592137);
         this.graphics.drawRect(0,0,this.enterPage.width,this.enterPage.height);
         this.graphics.endFill();
         fillMatrix.ty = 0;
         graphics.beginBitmapFill(topGradient.bitmapData,fillMatrix);
         graphics.drawRect(0,0,this.enterPage.width,topGradient.height);
         graphics.endFill();
         fillMatrix.ty = this.enterPage.height - bottomGradient.height;
         graphics.beginBitmapFill(bottomGradient.bitmapData,fillMatrix);
         graphics.drawRect(0,this.enterPage.height - bottomGradient.height,this.enterPage.width,bottomGradient.height);
         graphics.endFill();
         fillMatrix.tx = int((this.enterPage.width - panelBitmap.width) / 2);
         fillMatrix.ty = int((this.enterPage.height - panelBitmap.height) / 2);
         graphics.beginBitmapFill(panelBitmap.bitmapData,fillMatrix);
         graphics.drawRect(fillMatrix.tx,fillMatrix.ty,panelBitmap.width,panelBitmap.height);
         graphics.endFill();
         fillMatrix.tx = int((this.enterPage.width - panelBitmap.width) / 2) + 15;
         fillMatrix.ty = int((this.enterPage.height - panelBitmap.height) / 2) + 237;
         graphics.beginBitmapFill(textBackground.bitmapData,fillMatrix);
         graphics.drawRect(fillMatrix.tx,fillMatrix.ty,textBackground.width,textBackground.height);
         graphics.endFill();
         fillMatrix.tx = int((this.enterPage.width + rightDoor.width) / 2) - 28;
         fillMatrix.ty = int((this.enterPage.height - rightDoor.height) / 2) - 2;
         graphics.beginBitmapFill(rightDoor.bitmapData,fillMatrix);
         graphics.drawRect(fillMatrix.tx,fillMatrix.ty,rightDoor.width,rightDoor.height);
         graphics.endFill();
         this.upperPart.graphics.clear();
         fillMatrix.tx = int((this.enterPage.width - leftDoor.width) / 2) - 18;
         fillMatrix.ty = int((this.enterPage.height - leftDoor.height) / 2) - 2;
         this.upperPart.graphics.beginBitmapFill(leftDoor.bitmapData,fillMatrix);
         this.upperPart.graphics.drawRect(fillMatrix.tx,fillMatrix.ty,leftDoor.width,leftDoor.height);
         this.upperPart.graphics.endFill();
         this.loderText.x = this.enterPage.width / 2 - 95;
         this.loderText.y = this.enterPage.height / 2 + 190;
      }
      
      private function resizeHandler(param1:ResizeEvent) : void
      {
         this.drawAll();
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.drawAll();
      }
      
      public function drawProgress(param1:Number, param2:Number) : void
      {
         var angle:Number = param1 * Math.PI * 2 / param2;
         while(angle >= 0)
         {
            this.doEveryFrame(angle);
            angle -= 0.1;
         }
      }
      
      private function doEveryFrame(param1:Number) : void
      {
         var offsetX:Number = Math.cos(param1 + Math.PI / 2) * this.radius;
         var offsetY:Number = Math.sin(param1 + Math.PI / 2) * this.radius;
         this.container.graphics.beginFill(13408563);
         this.container.graphics.drawCircle(offsetX,-offsetY,this.satelliteRadius);
         this.container.graphics.endFill();
      }
      
      public function progress(param1:int, param2:int) : void
      {
         var progressStep:int = param1 * Math.PI * 2 * 10 / param2;
         if(progressStep != this.lastVal)
         {
            lastVal = progressStep;
            this.progressText.text = Math.round(param1 / param2 * 100).toString();
            this.drawProgress(param1,param2);
         }
      }
      
      private function createText(param1:uint, param2:uint, param3:uint) : TextField
      {
         var textField:TextField = new TextField();
         textField.background = false;
         textField.border = false;
         textField.borderColor = 13408563;
         textField.multiline = false;
         textField.selectable = false;
         textField.width = param1;
         textField.height = 18;
         textField.x = param2;
         textField.y = param3;
         textField.tabEnabled = true;
         return textField;
      }
   }
}

