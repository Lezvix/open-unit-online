package ui
{
   import ui.buttons.*;
   import core.resources.Localization;
   import core.ui.BaseButton;
   import core.ui.NScrollBar;
   import core.ui.ChatTextField;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import game.Client;
   
   public class NuclearMenu extends NUIComponent
   {
      
      public static var DRAG_OFFSET:int = 20;
      
      public static var BUTTON_WIDTH:int = 100;
      
      public static var BUTTON_HEIGHT:int = 20;
      
      public static var BUTTON_BIG_WIDTH:int = 130;
      
      public static var BUTTON_BIG_HEIGHT:int = 20;
      
      public static var SMALL_PLUS_WIDTH:int = 14;
      
      public static var SMALL_PLUS_HEIGHT:int = 14;
      
      public static var SMALL_BUTTON_WIDTH:int = 65;
      
      public static var SMALL_BUTTON_HEIGHT:int = 12;
      
      public static var SMALL_BUTTON_WIDTH_BIG:int = 105;
      
      public static var uiContainer:Sprite;

      public static var BUTTON_DEFAULT:int = 0;
      
      public static var BUTTON_SIGN:int = 1;
      
      public static var BUTTON_SMALL:int = 2;
      
      public static var BUTTON_SMALL_PLUS:int = 3;
      
      public static var BUTTON_BIG:int = 4;
      
      public static var BUTTON_SMALL_BWIDTH:int = 5;
      
      protected static const _border_color:uint = 13408825;
      
      protected static const _border_alpha:Number = 0.7;
      
      [Embed(source="/assets/NuclearMenu_CLOSE.png")]
      
      protected var CLOSE:Class;
      
      [Embed(source="/assets/NuclearMenu_CLOSE_PRESSED.png")]
      
      protected var CLOSE_PRESSED:Class;
      
      [Embed(source="/assets/NuclearMenu_CLOSE_OVER.png")]
      
      protected var CLOSE_OVER:Class;
      
      [Embed(source="/assets/NuclearMenu_OK_BUTTON.png")]
      
      protected var OK_BUTTON:Class;
      
      [Embed(source="/assets/NuclearMenu_OK_BUTTON_OVER.png")]
      
      protected var OK_BUTTON_OVER:Class;
      
      [Embed(source="/assets/NuclearMenu_OK_BUTTON_PRESSED.png")]
      
      protected var OK_BUTTON_PRESSED:Class;
      
      public var closeFunction:Function;
      
      public var menuType:int;
      
      public var submenus:Array = new Array();
      
      public var menuParent:Object;
      
      public var dragable:Boolean = true;
      
      public var filterButtons:Array = new Array();
      
      protected var itemArrays:Array = new Array();
      
      public var itemLists:Array = new Array();
      
      public var graphicsVisible:Boolean = true;
      
      public var removed:Boolean = false;
      
      protected var pagesCount:int;
      
      protected var curPage:int;
      
      public function NuclearMenu()
      {
         super();
      }
      
      protected static function createTextInput(param1:int, param2:int, param3:int, param4:String = "") : NTextInput
      {
         var input:NTextInput = new NTextInput(255,NTextFormat.input);
         input.setPos(param1,param2);
         input.width = param3;
         input.text = param4;
         return input;
      }
      
      protected static function createInput(param1:int, param2:int, param3:int, param4:int = 6, param5:int = 0) : NTextInput
      {
         var input:NTextInput;
         input = new NTextInput(param4,NTextFormat.input.right);
         input.doAction463();
         input.setPos(param1,param2);
         input.width = param3;
         input.text = param5.toString();
         return input;
      }
      
      public static function getString(param1:String) : String
      {
         return Localization.getString(param1);
      }
      
      public static function getFormattedString(param1:String, ... rest) : String
      {
         return Localization.getFormattedString(param1,rest);
      }
      
      public static function getNScrollBar1(param1:int) : NScrollBar
      {
         return new NuclearScrollBar(param1);
      }
      
      protected static function createSimpleButton(param1:int, param2:int, param3:String, param4:Function = null) : NButton
      {
         var button:TabButton = new TabButton(param3,param4);
         button.setPos(param1,param2);
         return button;
      }
      
      public static function createTextField(param1:int, param2:int, param3:int, param4:TextFormat, param5:String = "", param6:int = 100, param7:Boolean = false) : TextField
      {
         var field:TextField = new TextField();
         field.x = param1;
         field.y = param2;
         field.width = param3;
         field.height = param6;
         field.defaultTextFormat = param4;
         field.selectable = false;
         field.text = param5;
         if(param7)
         {
            field.multiline = true;
            field.wordWrap = true;
         }
         return field;
      }
      
      public static function getTextFormat(param1:Object = null) : TextFormat
      {
         var format:TextFormat = null;
         if(!param1)
         {
            format = new TextFormat("Verdana",10,13408563);
         }
         else
         {
            format = new TextFormat(param1.font ? param1.font : "Verdana",param1.size ? param1.size : 10,param1.color ? param1.color : 13408563,param1.bold,param1.italic,param1.underline,param1.url,param1.target,param1.align,param1.leftMargin,param1.rightMargin);
            format.letterSpacing = param1.letterSpacing;
         }
         return format;
      }
      
      public function createMenu() : void
      {
      }
      
      public function closeMenu() : void
      {
         var menuIndex:int = 0;
         if(uiParent)
         {
            uiParent.removeUIChild(this);
            Client.client.removeMenu(this);
         }
         menuIndex = 0;
         while(menuIndex < this.submenus.length)
         {
            this.submenus[menuIndex].closeHandler();
            menuIndex++;
         }
         if(this.menuParent)
         {
            menuIndex = 0;
            while(menuIndex < this.menuParent.submenus.length)
            {
               if(this.menuParent.submenus[menuIndex] == this)
               {
                  this.menuParent.submenus.splice(menuIndex,1);
                  break;
               }
               menuIndex++;
            }
         }
      }
      
      public function closeHandler() : void
      {
         this.closeMenu();
         if(this.closeFunction != null)
         {
            this.closeFunction();
         }
      }
      
      override public function dispose() : void
      {
         removed = true;
         super.dispose();
      }
      
      public function removeGraphics(param1:Object) : void
      {
         var listIndex:int = 0;
         while(listIndex < this.itemLists.length)
         {
            this.itemLists[listIndex].setMinimized(this.graphicsVisible);
            listIndex++;
         }
         graphicsVisible = !this.graphicsVisible;
      }
      
      public function centerMenu(param1:int, param2:int) : void
      {
         if(param1 != -1)
         {
            x = Math.max(0,int((param1 - width) / 2));
         }
         if(param2 != -1)
         {
            y = Math.max(0,int((param2 - height) / 2));
         }
      }
      
      public function create(param1:int, param2:int, param3:Boolean = true, param4:uint = 1776411, param5:Number = 1) : void
      {
         graphics.beginFill(param4,0);
         graphics.drawRect(0,0,param1,param2);
         graphics.endFill();
         width = param1;
         height = param2;
      }
      
      protected function drawWindow(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         graphics.lineStyle(1,_border_color,_border_alpha);
         graphics.drawRect(param2,param3,param4,param5);
         graphics.moveTo(param2 + 1,param3 + 22);
         graphics.lineTo(param2 + param4,param3 + 22);
         graphics.lineStyle();
         var titleField:TextField = new TextField();
         titleField.x = param2 + 4;
         titleField.y = param3 + 2;
         titleField.width = param4 - 8;
         titleField.height = 18;
         titleField.defaultTextFormat = getTextFormat({
            "size":12,
            "color":10187041
         });
         titleField.selectable = false;
         titleField.text = param1;
         addChild(titleField);
      }
      
      protected function drawBorder(param1:Number, param2:Number, param3:Number, param4:Number, param5:Graphics = null) : void
      {
         if(param5 == null)
         {
            param5 = this.graphics;
         }
         param5.lineStyle(1,_border_color,_border_alpha);
         param5.drawRect(param1,param2,param3,param4);
         param5.lineStyle();
      }
      
      public function addSimpleCloseBtn() : void
      {
         var closeBitmap:Bitmap = new this.CLOSE();
         this.addCloseButton(width - closeBitmap.width - 10,10,closeBitmap,new this.CLOSE_OVER(),new this.CLOSE_PRESSED());
      }
      
      public function addDefaultCloseButton(param1:int, param2:int) : void
      {
         this.addCloseButton(param1,param2,new this.CLOSE(),new this.CLOSE_OVER(),new this.CLOSE_PRESSED());
      }
      
      public function addCloseButton(param1:int, param2:int, param3:Bitmap, param4:Bitmap, param5:Bitmap) : void
      {
         var button:NButton = new NButton(this.onClose,param3,param4,param5,param3);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.useHandCursor = true;
         addUIChild(button);
      }
      
      public function onClose(param1:Object) : void
      {
         this.closeHandler();
      }
      
      public function addButton(param1:BaseButton, param2:int, param3:int, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Function = null, param8:int = 0) : void
      {
         param1 = new NButton(param7,param4,param5,param6,param4);
         param1.object = this;
         param1.x = param2;
         param1.y = param3;
         param1.value = param8;
         addUIChild(param1);
      }
      
      public function addNewButton(param1:int, param2:int, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Function = null, param7:int = 0, param8:Boolean = false) : BaseButton
      {
         var button:NButton = new NButton(param6,param3,param4,param5,param3);
         button.object = this;
         button.x = param1;
         button.y = param2;
         if(param8)
         {
            this.filterButtons.push(button);
         }
         button.value = param7;
         addUIChild(button);
         return button;
      }
      
      public function createButton(param1:int, param2:int, param3:int, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Function = null) : NButton
      {
         var button:NButton = new NButton(param7,param4,param5,param6,param4);
         button.object = this;
         button.x = param1;
         button.y = param2;
         button.value = param3;
         return button;
      }
      
      protected function addSimpleTextField(param1:int, param2:int, param3:String, param4:int = 14, param5:int = 200, param6:int = 300, param7:String = "left", param8:uint = 13408825, param9:Boolean = false) : TextField
      {
         var field:TextField;
         field = new TextField();
         field.background = false;
         field.border = false;
         field.multiline = true;
         field.wordWrap = true;
         field.selectable = false;
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = param8;
         format.size = param4;
         format.underline = false;
         format.align = param7;
         format.bold = param9;
         field.width = param5;
         field.height = param6;
         field.defaultTextFormat = format;
         field.x = param1;
         field.y = param2;
         field.text = param3;
         addChild(field);
         return field;
      }
      
      protected function createInvItemArray() : Array
      {
         var items:Array = new Array();
         this.itemArrays.push(items);
         return items;
      }
      
      public function update() : void
      {
      }
      
      protected function setColor(param1:TextField, param2:uint) : void
      {
         var format:TextFormat = new TextFormat();
         format.font = param1.defaultTextFormat.font;
         format.size = param1.defaultTextFormat.size;
         format.color = param2;
         format.bold = param1.defaultTextFormat.bold;
         format.align = param1.defaultTextFormat.align;
         param1.setTextFormat(format);
      }
      
      protected function updateBgUI(param1:Sprite, param2:Boolean, param3:int, param4:int, param5:TextField = null, param6:TextField = null) : void
      {
         if(param2)
         {
            param1.graphics.beginFill(3944991);
         }
         else
         {
            param1.graphics.beginFill(2762011);
         }
         param1.graphics.drawRect(0,0,param3,param4);
         param1.graphics.endFill();
         if(param2)
         {
            param1.graphics.beginFill(4602143);
         }
         else
         {
            param1.graphics.beginFill(3156252);
         }
         param1.graphics.drawRect(0,0,param3,1);
         param1.graphics.drawRect(0,0,1,param4);
         param1.graphics.drawRect(param3 - 1,0,1,param4);
         param1.graphics.drawRect(0,param4 - 1,param3,1);
         param1.graphics.endFill();
         if(param5 != null)
         {
            if(param2)
            {
               this.setColor(param5,13408825);
            }
            else
            {
               this.setColor(param5,10187041);
            }
         }
         if(param6 != null)
         {
            if(param2)
            {
               this.setColor(param6,13408825);
            }
            else
            {
               this.setColor(param6,10187041);
            }
         }
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      override protected function includesMouse() : Boolean
      {
         if(stage != null && mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0 && this.dragable)
         {
            return true;
         }
         return false;
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.dragable && mouseY < DRAG_OFFSET)
         {
            startDrag();
         }
      }
      
      protected function doAction153(param1:int, param2:int, param3:String, param4:Function = null) : void
      {
         addUIChild(createSimpleButton(param1,param2,param3,param4));
      }
      
      public function sortItemsByLevel(param1:Array) : void
      {
         var itemIndex:int;
         var scanIndex:int;
         var minimumLevel:int;
         var minimumIndex:int;
         var itemCount:int = param1.length;
         itemIndex = 0;
         while(itemIndex < itemCount - 1)
         {
            minimumIndex = itemIndex;
            minimumLevel = param1[itemIndex].level;
            scanIndex = itemIndex + 1;
            while(scanIndex < itemCount)
            {
               if(param1[scanIndex].level < minimumLevel)
               {
                  minimumLevel = param1[scanIndex].level;
                  minimumIndex = scanIndex;
               }
               scanIndex++;
            }
            var item:Object = param1[minimumIndex];
            param1[minimumIndex] = param1[itemIndex];
            param1[itemIndex] = item;
            itemIndex++;
         }
      }
      
      override public function mouseUpHandler() : void
      {
         stopDrag();
      }
      
      public function addOpponentItem(param1:Array) : void
      {
      }
      
      public function addServerUserItem(param1:Array) : void
      {
      }
      
      public function delServerUserItem() : void
      {
      }
      
      public function addHealTraum(param1:int) : void
      {
      }
      
      public function delHealTraum() : void
      {
      }
      
      public function addOpItemCount(param1:int, param2:int) : void
      {
      }
      
      public function delOpItem(param1:int, param2:int) : void
      {
      }
      
      public function opponentConfirm() : void
      {
      }
      
      public function falseConfirm() : void
      {
      }
      
      public function setPrice(param1:int) : void
      {
      }
      
      public function createButtonSprite(param1:uint, param2:TextFormat, param3:String, param4:int, param5:int, param6:int, param7:int) : Sprite
      {
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginFill(param1);
         sprite.graphics.drawRect(0,0,param6,param7);
         sprite.graphics.endFill();
         sprite.graphics.beginFill(13408825);
         sprite.graphics.drawRect(0,0,param6,1);
         sprite.graphics.drawRect(0,0,1,param7);
         sprite.graphics.drawRect(param6 - 1,0,1,param7);
         sprite.graphics.drawRect(0,param7 - 1,param6,1);
         sprite.graphics.endFill();
         var label:TextField = new TextField();
         label.wordWrap = true;
         label.multiline = true;
         label.defaultTextFormat = param2;
         label.x = param4;
         label.y = param5;
         label.width = param6 - 2;
         label.text = param3;
         label.height = label.textHeight + 6;
         sprite.addChild(label);
         return sprite;
      }
      
      public function createTextButtonDirect(param1:int, param2:int, param3:String, param4:Function, param5:int, param6:int, param7:int, param8:int, param9:int = 0, param10:int = 0, param11:Object = null) : BaseButton
      {
         var normalFormat:TextFormat = new TextFormat();
         var overFormat:TextFormat = new TextFormat();
         var pressedFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = 10;
         normalFormat.align = TextFormatAlign.CENTER;
         overFormat.font = "Verdana";
         overFormat.color = 16777062;
         overFormat.size = 10;
         overFormat.align = TextFormatAlign.CENTER;
         pressedFormat.font = "Verdana";
         pressedFormat.color = 7493152;
         pressedFormat.size = 10;
         pressedFormat.align = TextFormatAlign.CENTER;
         normalSprite = this.createButtonSprite(0,normalFormat,param3,param7,param8,param5,param6);
         overSprite = this.createButtonSprite(4075281,overFormat,param3,param7,param8,param5,param6);
         pressedSprite = this.createButtonSprite(0,pressedFormat,param3,param7 + 1,param8 + 1,param5,param6);
         var normalSprite:Sprite;
         var overSprite:Sprite;
         var pressedSprite:Sprite;
         var button:NButton = new NButton(param4,normalSprite,overSprite,pressedSprite,null);
         button.x = param1;
         button.y = param2;
         button.value = param9;
         return button;
      }
      
      protected function showNotifyMenu(param1:String) : void
      {
         Client.client.showNotifyMenu(param1);
      }
      
      protected function showWarningMenu(param1:String, param2:Function, param3:Function = null) : void
      {
         Client.client.showWarningMenu(param1,param2,param3);
      }
      
      public function createTextButton(param1:int, param2:int, param3:String, param4:Function, param5:int = 0, param6:int = 0, param7:Object = null, param8:int = -1, param9:int = -1, param10:int = 10) : BaseButton
      {
         var normalFormat:TextFormat = new TextFormat();
         var overFormat:TextFormat = new TextFormat();
         var pressedFormat:TextFormat = new TextFormat();
         normalFormat.font = "Verdana";
         normalFormat.color = 13408825;
         normalFormat.size = param10;
         normalFormat.align = TextFormatAlign.CENTER;
         overFormat.font = "Verdana";
         overFormat.color = 16777062;
         overFormat.size = param10;
         overFormat.align = TextFormatAlign.CENTER;
         pressedFormat.font = "Verdana";
         pressedFormat.color = 7493152;
         pressedFormat.size = param10;
         pressedFormat.align = TextFormatAlign.CENTER;
         if(param8 > 0 && param9 > 0)
         {
            normalSprite = this.createButtonSprite(0,normalFormat,param3,1,1,param8,param9);
            overSprite = this.createButtonSprite(4075281,overFormat,param3,1,1,param8,param9);
            pressedSprite = this.createButtonSprite(0,pressedFormat,param3,2,2,param8,param9);
         }
         else
         {
            switch(param6)
            {
               case BUTTON_DEFAULT:
                  normalSprite = this.createButtonSprite(0,normalFormat,param3,1,1,BUTTON_WIDTH,BUTTON_HEIGHT);
                  overSprite = this.createButtonSprite(4075281,overFormat,param3,1,1,BUTTON_WIDTH,BUTTON_HEIGHT);
                  pressedSprite = this.createButtonSprite(0,pressedFormat,param3,2,2,BUTTON_WIDTH,BUTTON_HEIGHT);
                  break;
               case BUTTON_SIGN:
                  normalSprite = this.createButtonSprite(0,normalFormat,param3,1,1,BUTTON_HEIGHT,BUTTON_HEIGHT);
                  overSprite = this.createButtonSprite(4075281,overFormat,param3,1,1,BUTTON_HEIGHT,BUTTON_HEIGHT);
                  pressedSprite = this.createButtonSprite(0,pressedFormat,param3,2,2,BUTTON_HEIGHT,BUTTON_HEIGHT);
                  break;
               case BUTTON_SMALL:
                  normalSprite = this.createButtonSprite(3156252,normalFormat,param3,1,-2,SMALL_BUTTON_WIDTH,SMALL_BUTTON_HEIGHT);
                  overSprite = this.createButtonSprite(4602143,overFormat,param3,1,-2,SMALL_BUTTON_WIDTH,SMALL_BUTTON_HEIGHT);
                  pressedSprite = this.createButtonSprite(3156252,pressedFormat,param3,2,-1,SMALL_BUTTON_WIDTH,SMALL_BUTTON_HEIGHT);
                  break;
               case BUTTON_SMALL_BWIDTH:
                  normalSprite = this.createButtonSprite(3156252,normalFormat,param3,1,-2,SMALL_BUTTON_WIDTH_BIG,SMALL_BUTTON_HEIGHT);
                  overSprite = this.createButtonSprite(4602143,overFormat,param3,1,-2,SMALL_BUTTON_WIDTH_BIG,SMALL_BUTTON_HEIGHT);
                  pressedSprite = this.createButtonSprite(3156252,pressedFormat,param3,2,-1,SMALL_BUTTON_WIDTH_BIG,SMALL_BUTTON_HEIGHT);
                  break;
               case BUTTON_SMALL_PLUS:
                  normalSprite = this.createButtonSprite(3156252,normalFormat,param3,1,-2,SMALL_PLUS_WIDTH,SMALL_PLUS_HEIGHT);
                  overSprite = this.createButtonSprite(4602143,overFormat,param3,1,-2,SMALL_PLUS_WIDTH,SMALL_PLUS_HEIGHT);
                  pressedSprite = this.createButtonSprite(3156252,pressedFormat,param3,2,-1,SMALL_PLUS_WIDTH,SMALL_PLUS_HEIGHT);
                  break;
               case BUTTON_BIG:
                  normalSprite = this.createButtonSprite(0,normalFormat,param3,1,1,BUTTON_BIG_WIDTH,BUTTON_BIG_HEIGHT);
                  overSprite = this.createButtonSprite(4075281,overFormat,param3,1,1,BUTTON_BIG_WIDTH,BUTTON_BIG_HEIGHT);
                  pressedSprite = this.createButtonSprite(0,pressedFormat,param3,2,2,BUTTON_BIG_WIDTH,BUTTON_BIG_HEIGHT);
                  break;
            }
         }
         var normalSprite:Sprite;
         var overSprite:Sprite;
         var pressedSprite:Sprite;
         var button:NButton = new NButton(param4,normalSprite,overSprite,pressedSprite);
         button.x = param1;
         button.y = param2;
         button.value = param5;
         return button;
      }
      
      protected function createNBTextInput(param1:int, param2:int, param3:int, param4:NTextFormat, param5:int) : ChatTextField
      {
         var input:NTextInput = new NTextInput(param5,param4);
         input.x = param1;
         input.y = param2;
         input.width = param3;
         input.height = 16;
         return input;
      }
      
      protected function createPageButtons(param1:Sprite, param2:int, param3:int) : void
      {
         var unusedSprite:Sprite = null;
         var pageLabel:TextField = null;
         var pageIndex:int = 0;
         var currentFormat:TextFormat = new TextFormat();
         currentFormat.font = "Verdana";
         currentFormat.color = 13408825;
         currentFormat.size = 10;
         currentFormat.bold = true;
         var ellipsisFormat:TextFormat = new TextFormat();
         ellipsisFormat.font = "Verdana";
         ellipsisFormat.color = 10187041;
         ellipsisFormat.size = 10;
         if(this.curPage == 0)
         {
            pageLabel = createTextField(param3,param2,50,currentFormat,(this.curPage + 1).toString(),18);
            param3 += pageLabel.textWidth + 5;
            param1.addChild(pageLabel);
         }
         else
         {
            param3 = this.addPageButton(0,param3,param2);
         }
         pageIndex = this.curPage - 3;
         if(pageIndex <= 1)
         {
            pageIndex = 1;
         }
         else
         {
            pageLabel = createTextField(param3,param2,50,ellipsisFormat,"...",18);
            param3 += pageLabel.textWidth + 5;
            param1.addChild(pageLabel);
         }
         while(pageIndex <= this.curPage + 3 && pageIndex < this.pagesCount)
         {
            if(pageIndex == this.curPage)
            {
               pageLabel = createTextField(param3,param2,50,currentFormat,(this.curPage + 1).toString(),18);
               param3 += pageLabel.textWidth + 5;
               param1.addChild(pageLabel);
            }
            else
            {
               param3 = this.addPageButton(pageIndex,param3,param2);
            }
            pageIndex++;
         }
         if(pageIndex < this.pagesCount - 1)
         {
            pageLabel = createTextField(param3,param2,50,ellipsisFormat,"...",18);
            param3 += pageLabel.textWidth + 5;
            param1.addChild(pageLabel);
         }
         if(pageIndex < this.pagesCount)
         {
            param3 = this.addPageButton(this.pagesCount - 1,param3,param2);
         }
      }
      
      protected function addPageButton(param1:int, param2:int, param3:int) : int
      {
         return 0;
      }
   }
}

