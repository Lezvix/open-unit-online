package ui.menus
{
   import ui.buttons.*;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import game.Client;
   import ui.GameCursor;
   import ui.NUIComponent;
   import ui.NTextFormat;
   import ui.NTextInput;
   
   public class BaseMenu extends NUIComponent
   {
      
      public static const TYPE_0:int = 0;
      
      public static const TYPE_NOTIFY:int = 1;
      
      public static const TYPE_CONFIRM:int = 2;
      
      public static const TYPE_PAY_SYSTEM:int = 3;
      
      public static const TYPE_BOT_4:int = 4;
      
      public static const TYPE_BOT_BARTER:int = 5;
      
      public static const TYPE_6:int = 6;
      
      public static const TYPE_BARTER:int = 7;
      
      public static const TYPE_ACTION_REQUEST:int = 8;
      
      public static const TYPE_ACTION_WAIT:int = 9;
      
      public static const TYPE_ACTION_10:int = 10;
      
      public static const TYPE_11:int = 11;
      
      public static const TYPE_REFERAL:int = 12;
      
      public static const TYPE_CHARACTER_INFO:int = 13;
      
      public static const TYPE_INVENTORY:int = 14;
      
      public static const TYPE_COUNT:int = 15;
      
      public static const TYPE_16:int = 16;
      
      public static const TYPE_17:int = 17;
      
      public static const TYPE_18:int = 18;
      
      public static const TYPE_19:int = 19;
      
      public static const TYPE_HINT:int = 20;
      
      public static const TYPE_21:int = 21;
      
      public static const TYPE_22:int = 22;
      
      public static const TYPE_MANAGEMENT:int = 23;
      
      public static const TYPE_CRAFT:int = 24;
      
      public static const TYPE_UPGRADE:int = 25;
      
      public static const TYPE_PRINT:int = 26;
      
      public static const TYPE_BADGE_SHOP:int = 27;
      
      public static const TYPE_28:int = 28;
      
      public static const TYPE_PASSWORD:int = 29;
      
      public static const TYPE_QUESTION:int = 30;
      
      public static const TYPE_DEPOD:int = 31;
      
      public static const TYPE_SOCIAL:int = 32;
      
      public static const TYPE_CUSTOMIZATION:int = 33;
      
      public static const TYPE_SOBER_CONFIRM:int = 34;
      
      public static const TYPE_CLAN_PRODUCT:int = 35;
      
      public static const TYPE_INPUT:int = 29;
      
      public static const TYPE_DEPOD_LOG:int = 36;
      
      public static const TM_MENU_28:int = 37;
      
      private static var DRAG_OFFSET:int = 20;
      
      protected var w:int;
      
      protected var h:int;
      
      private var typeValue:int;
      
      private var _draggable:Boolean = true;
      
      protected const submenus:Vector.<BaseMenu> = new Vector.<BaseMenu>();
      
      public function BaseMenu(menuType:int)
      {
         super();
         this.typeValue = menuType;
         switch(menuType)
         {
            case TYPE_REFERAL:
            case TYPE_PAY_SYSTEM:
               Main.closeMenus(menuType);
               break;
            case TYPE_MANAGEMENT:
            case TYPE_CLAN_PRODUCT:
            case TYPE_CRAFT:
            case TYPE_UPGRADE:
            case TYPE_PRINT:
            case TYPE_DEPOD:
            case TYPE_BOT_BARTER:
            case TYPE_BARTER:
               Main.closeMenus(TYPE_MANAGEMENT,TYPE_UPGRADE,TYPE_CRAFT,TYPE_PRINT,TYPE_DEPOD,TYPE_CLAN_PRODUCT);
               break;
            default:
               break;
         }
      }
      
      protected static function createLabel(posX:int, posY:int, str:String, format:NTextFormat = null, labelWidth:int = -1) : TextField
      {
         var label:TextField = new TextField();
         label.defaultTextFormat = format ? format : NTextFormat.plain;
         label.x = posX;
         label.y = posY;
         label.text = str;
         label.width = labelWidth == -1 ? label.textWidth + 5 : labelWidth;
         label.height = label.textHeight + 5;
         return label;
      }
      
      protected static function createText(posX:int, posY:int, str:String, format:NTextFormat = null, textWidth:int = -1) : TextField
      {
         var textField:TextField = new TextField();
         textField.defaultTextFormat = format ? format : NTextFormat.plain;
         textField.x = posX;
         textField.y = posY;
         textField.multiline = true;
         textField.wordWrap = true;
         if(textWidth != -1)
         {
            textField.width = textWidth;
         }
         textField.text = str;
         textField.height = textField.textHeight + 5;
         return textField;
      }
      
      protected static function createTextInput(posX:int, posY:int, inputWidth:int, str:String = "") : NTextInput
      {
         var input:NTextInput = new NTextInput(255,NTextFormat.input);
         input.setPos(posX,posY);
         input.width = inputWidth;
         input.text = str;
         return input;
      }
      
      protected static function createInput(posX:int, posY:int, inputWidth:int, maxChars:int = 6, value:int = 0) : NTextInput
      {
         var input:NTextInput = new NTextInput(maxChars,NTextFormat.input.right);
         input.doAction463();
         input.setPos(posX,posY);
         input.width = inputWidth;
         input.text = value.toString();
         return input;
      }
      
      public static function TimeToStr(seconds:int) : String
      {
         if(seconds == 0)
         {
            return "0";
         }
         return int(seconds / 3600) + ":" + int(seconds % 3600 / 60) + "\':" + int(seconds % 60) + "\"";
      }
      
      protected static function drawBorder(target:Object, posX:int, posY:int, rectWidth:int, rectHeight:int, lineColor:uint = 3156252) : void
      {
         if("graphics" in target)
         {
            target.graphics.lineStyle(1,lineColor);
            target.graphics.drawRect(posX,posY,rectWidth,rectHeight);
            target.graphics.endFill();
         }
      }
      
      protected static const _border_color:uint = 13408825;

      protected static const _border_alpha:Number = 0.7;

      protected static function createButton(posX:int, posY:int, label:String, handler:Function = null) : NButton
      {
         var button:TabButton = new TabButton(label,handler);
         button.setPos(posX,posY);
         return button;
      }
      
      public function get draggable() : Boolean
      {
         return this._draggable;
      }
      
      public function set draggable(value:Boolean) : void
      {
         _draggable = value;
      }
      
      public function get type() : int
      {
         return this.typeValue;
      }
      
      public function get menuType() : int
      {
         return this.typeValue;
      }
      
      public function closeMenu() : void
      {
         if(uiParent)
         {
            uiParent.removeUIChild(this);
         }
         Client.client.removeMenu(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      public function centerInParent() : void
      {
         if(parent)
         {
            this.centerMenu(parent.width,parent.height);
         }
      }
      
      public function centerMenu(areaWidth:int, areaHeight:int) : void
      {
         setPos(Math.max(0,int((areaWidth - width) / 2)),Math.max(0,int((areaHeight - height) / 2)));
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0;
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.draggable && mouseY < DRAG_OFFSET)
         {
            this.startDrag();
         }
      }
      
      override public function mouseUpHandler() : void
      {
         this.stopDrag();
      }
      
      protected function addTextLabel(posX:int, posY:int, str:String, format:NTextFormat = null, labelWidth:int = -1) : TextField
      {
         var label:TextField = createLabel(posX,posY,str,format,labelWidth);
         addChild(label);
         return label;
      }
      
      protected function addText(posX:int, posY:int, str:String, format:NTextFormat = null, textWidth:int = -1) : TextField
      {
         var textField:TextField = createText(posX,posY,str,format,textWidth);
         addChild(textField);
         return textField;
      }
      
      protected function addTextInput(posX:int, posY:int, inputWidth:int, str:String = "") : void
      {
         addUIChild(createTextInput(posX,posY,inputWidth,str));
      }
      
      protected function drawWindow(title:String, posX:Number, posY:Number, rectWidth:Number, rectHeight:Number) : void
      {
         graphics.lineStyle(1,_border_color,_border_alpha);
         graphics.drawRect(posX,posY,rectWidth,rectHeight);
         graphics.moveTo(posX + 1,posY + 22);
         graphics.lineTo(posX + rectWidth,posY + 22);
         graphics.lineStyle();
         this.addTextLabel(posX + 4,posY + 2,title,new NTextFormat({
            "size":12,
            "color":10187041
         }),rectWidth - 8);
      }
      
      protected function addButton(posX:int, posY:int, label:String, handler:Function = null) : void
      {
         addUIChild(createButton(posX,posY,label,handler));
      }
      
      protected function showModal(menu:BaseMenu) : void
      {
         (parent as ModalLayer).showModal(menu,true);
      }
      
      protected function showConfirm(message:String, okHandler:Function, cancelHandler:Function = null) : void
      {
         this.showModal(new ConfirmMenu(message,okHandler,cancelHandler));
      }
      
      protected function showNotification(message:String, closeHandler:Function = null) : void
      {
         this.showModal(new NotifyMenu(message,closeHandler));
      }
      
      protected function showSubConfirm(message:String, okHandler:Function, cancelHandler:Function = null) : BaseMenu
      {
         this.closeSubmenus();
         var menu:BaseMenu = new ConfirmMenu(message,okHandler,cancelHandler);
         this.submenus.push(menu);
         addUIChild(menu);
         menu.centerInParent();
         return menu;
      }
      
      protected function showSubNotify(message:String, closeHandler:Function = null) : BaseMenu
      {
         this.closeSubmenus();
         var menu:BaseMenu = new NotifyMenu(message,closeHandler);
         this.submenus.push(menu);
         addUIChild(menu);
         menu.centerInParent();
         return menu;
      }
      
      protected function closeSubmenus() : void
      {
         var i:int = 0;
         while(i < this.submenus.length)
         {
            this.submenus[i].closeMenu();
            i++;
         }
         this.submenus.splice(0,this.submenus.length);
      }
      
      protected var currentCursor:int = 0;

      override public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null) : void
      {
         currentCursor = GameCursor.CURSOR_2;
         super.startDrag(lockCenter,bounds);
      }
      
      override public function stopDrag() : void
      {
         currentCursor = GameCursor.CURSOR_DEFAULT;
         super.stopDrag();
      }
      
      override public function get cursorId() : int
      {
         return this.currentCursor;
      }
      
      public function get W() : int
      {
         return this.w;
      }
      
      public function get H() : int
      {
         return this.h;
      }
   }
}

