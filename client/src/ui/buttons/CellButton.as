package ui.buttons
{
   import core.ui.UIElement;
   import ui.menus.NuclearSprite;
   import flash.display.Bitmap;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import ui.NuclearMenu;
   import ui.NTextFormat;
   
   public class CellButton extends NButton
   {
      
      private static var bitmap21:Bitmap;
      
      private static var bitmap43:Bitmap;
      
      private static var bitmap30:Bitmap;
      
      private static var bitmap6:Bitmap;
      
      private static var bitmap18:Bitmap;
      
      private static var bitmap48:Bitmap;
      
      private static var bitmap26:Bitmap;
      
      private var frame:UIElement = new UIElement();
      
      private var cellWidth:int;
      
      private var cellHeight:int;
      
      private var idValue:int;
      
      private var _cellLocked:Boolean;
      
      private var personal:Boolean;
      
      public function CellButton(cellId:int, cellIndex:int, hasPassword:Boolean, buttonWidth:int, buttonHeight:int, clickHandler:Function)
      {
         var icon:Bitmap;
         var label:TextField;
         this.cellWidth = buttonWidth;
         this.cellHeight = buttonHeight;
         this.drawNormal();
         icon = getBmp("ICO_CELL_" + cellIndex);
         icon.x = buttonWidth - icon.width >> 1;
         icon.y = (buttonHeight - icon.height >> 1) - 4;
         this.frame.addChild(icon);
         label = new TextField();
         label.defaultTextFormat = NTextFormat.titleFormat;
         label.text = _("IDS_CELL_NAME_" + cellIndex);
         label.width = buttonWidth;
         label.height = label.textHeight + 4;
         label.y = buttonHeight - label.height - 3;
         this.frame.addChild(label);
         this.idValue = cellId;
         this._cellLocked = hasPassword;
         this.personal = cellIndex < 3;
         super(clickHandler,this.frame,this.frame,this.frame);
         if(cellId == 0)
         {
            alpha = 1 / 3;
         }
      }
      
      private static function initGlowBitmaps() : void
      {
         var uiAssets:* = NuclearMenu.uiContainer;
         bitmap21 = new uiAssets["RAM_GLOW_DL"]();
         bitmap43 = new uiAssets["RAM_GLOW_DR"]();
         bitmap26 = new uiAssets["RAM_GLOW_SIDE"]();
         bitmap30 = new uiAssets["RAM_GLOW_TOP"]();
         bitmap6 = new uiAssets["RAM_GLOW_UL"]();
         bitmap18 = new uiAssets["RAM_GLOW_UR"]();
         bitmap48 = new uiAssets["RAM_GLOW_BOTTOM"]();
      }
      
      public function focus() : void
      {
         this.drawGlow();
      }
      
      public function unfocus() : void
      {
         this.drawNormal();
      }
      
      private function drawGlow() : void
      {
         if(!bitmap30)
         {
            initGlowBitmaps();
         }
         this.frame.graphics.clear();
         this.frame.draw(bitmap6,-4,-4);
         this.frame.drawTile(bitmap30,bitmap6.width - 4,-4,this.cellWidth - bitmap6.width - bitmap18.width + 8,bitmap30.height);
         this.frame.draw(bitmap18,this.cellWidth - bitmap18.width + 4,-4);
         this.frame.drawTile(bitmap26,-4,bitmap6.height - 4,bitmap26.width,this.cellHeight - bitmap6.height - bitmap21.height + 8);
         this.frame.drawTile(bitmap26,this.cellWidth - bitmap26.width + 7,bitmap18.height - 4,bitmap26.width,this.cellHeight - bitmap18.height - bitmap43.height + 8);
         this.frame.draw(bitmap21,-4,this.cellHeight - bitmap21.height + 4);
         this.frame.drawTile(bitmap48,bitmap21.width - 4,this.cellHeight - bitmap48.height + 4,this.cellWidth - bitmap21.width - bitmap43.width + 8,bitmap48.height);
         this.frame.draw(bitmap43,this.cellWidth - bitmap43.width + 4,this.cellHeight - bitmap43.height + 4);
      }
      
      private function drawNormal() : void
      {
         this.frame.graphics.clear();
         NuclearSprite.drawRamFrame(this.frame,0,0,this.cellWidth,this.cellHeight);
      }
      
      public function get id() : int
      {
         return this.idValue;
      }
      
      public function get isLocked() : Boolean
      {
         return this._cellLocked;
      }
      
      public function get isPersonal() : Boolean
      {
         return this.personal;
      }
   }
}

