package ui.menus
{
   import ui.buttons.NButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import ui.NTextFormat;
   
   public class TerminalSubmenu extends BaseMenu
   {
      
      public static const TM_MENU_CLAN_9:int = 9;
      
      public static const TM_MENU_CLAN_ZONES:int = 19;
      
      public static const TM_MENU_CLAN_23:int = 23;
      
      public static const TM_MENU_CLAN_25:int = 25;
      
      public static const TM_MENU_CLAN_26:int = 26;
      
      public var closeFunction:Function;
      
      public function TerminalSubmenu(menuType:int, hasBackButton:Boolean = true)
      {
         super(-menuType);
         w = 625;
         h = 336;
         draggable = false;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,W,H);
         graphics.endFill();
         width = W;
         height = H;
         if(hasBackButton)
         {
            this.addTerminalButton(526,234,_("IDS_BACK"),this.onCloseClick);
         }
      }
      
      protected static function createTerminalButton(posX:int, posY:int, label:String, handler:Function, buttonWidth:int = 100) : NButton
      {
         var normalFormat:NTextFormat = NTextFormat.normal.center.setSize(10);
         var overFormat:NTextFormat = new NTextFormat({
            "color":16777062,
            "size":10,
            "align":TextFormatAlign.CENTER
         });
         var pressedFormat:NTextFormat = new NTextFormat({
            "color":7493152,
            "size":10,
            "align":TextFormatAlign.CENTER
         });
         var normalSprite:Sprite = createButtonSprite(0,normalFormat,label,1,1,buttonWidth,20);
         var overSprite:Sprite = createButtonSprite(4075281,overFormat,label,1,1,buttonWidth,20);
         var pressedSprite:Sprite = createButtonSprite(0,pressedFormat,label,2,2,buttonWidth,20);
         var button:NButton = new NButton(handler,normalSprite,overSprite,pressedSprite);
         button.setPos(posX,posY);
         return button;
      }
      
      protected static function createButtonSprite(bgColor:uint, format:NTextFormat, label:String, textX:int, textY:int, spriteWidth:int, spriteHeight:int) : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(bgColor);
         sprite.graphics.drawRect(0,0,spriteWidth,spriteHeight);
         sprite.graphics.endFill();
         sprite.graphics.beginFill(13408825);
         sprite.graphics.drawRect(0,0,spriteWidth,1);
         sprite.graphics.drawRect(0,0,1,spriteHeight);
         sprite.graphics.drawRect(spriteWidth - 1,0,1,spriteHeight);
         sprite.graphics.drawRect(0,spriteHeight - 1,spriteWidth,1);
         sprite.graphics.endFill();
         var textField:TextField = new TextField();
         textField.wordWrap = true;
         textField.multiline = true;
         textField.defaultTextFormat = format;
         textField.x = textX;
         textField.y = textY;
         textField.width = spriteWidth - 2;
         textField.text = label;
         textField.height = textField.textHeight + 6;
         sprite.addChild(textField);
         return sprite;
      }
      
      public function parseData(fields:Array) : void
      {
      }
      
      protected function onCloseClick(sender:Object) : void
      {
         closeMenu();
         if(this.closeFunction != null)
         {
            this.closeFunction();
         }
      }
      
      override protected function drawWindow(title:String, posX:Number, posY:Number, rectWidth:Number, rectHeight:Number) : void
      {
         graphics.lineStyle(1,_border_color);
         graphics.drawRect(posX,posY,rectWidth,rectHeight);
         graphics.moveTo(posX + 4,posY + 22);
         graphics.lineTo(posX + rectWidth - 4,posY + 22);
         graphics.lineStyle();
         addTextLabel(posX + 4,posY + 2,title,new NTextFormat({
            "size":12,
            "color":13408825
         }),rectWidth - 8);
      }
      
      protected function addTerminalButton(posX:int, posY:int, label:String, handler:Function = null, buttonWidth:int = 100) : void
      {
         addUIChild(createTerminalButton(posX,posY,label,handler,buttonWidth));
      }
      
      override protected function showModal(menu:BaseMenu) : void
      {
         (parent as ModalLayer).showModal(menu);
      }
   }
}

