package ui.menus
{
   import ui.buttons.NButton;
   import core.ui.UIElement;
   import flash.display.Bitmap;
   import game.Chat;
   import ui.NTextFormat;
   
   public class NuclearSprite extends BaseMenu
   {
      
      [Embed(source="/assets/NUIComponent_IMG_10.png")]
      
      private static const IMG_10:Class;
      
      [Embed(source="/assets/NUIComponent_LINE.png")]
      
      private static const LINE:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_DL.png")]
      
      private static const RAM_DL:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_DR.png")]
      
      private static const RAM_DR:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_SIDE.png")]
      
      private static const RAM_SIDE:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_TOP.png")]
      
      private static const RAM_TOP:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_UL.png")]
      
      private static const RAM_UL:Class;
      
      [Embed(source="/assets/NUIComponent_RAM_UR.png")]
      
      private static const RAM_UR:Class;
      
      [Embed(source="/assets/NuclearSprite_FRAME_LEFT_TOP.png")]
      
      private static const FRAME_LEFT_TOP:Class;
      
      [Embed(source="/assets/NuclearSprite_FRAME_RIGHT_TOP.png")]
      
      private static const FRAME_RIGHT_TOP:Class;
      
      [Embed(source="/assets/NuclearSprite_IMG_4.png")]
      
      private static const IMG_4:Class;
      
      [Embed(source="/assets/CharacterInfo_LINE_INF_S.png")]
      
      private static const IMG_5:Class;
      
      [Embed(source="/assets/CharacterInfo_LINE_G.png")]
      
      private static const FRAME_RIGHT:Class;
      
      [Embed(source="/assets/NuclearSprite_IMG_26.png")]
      
      private static const IMG_26:Class;
      
      [Embed(source="/assets/CharacterInfo_MAG_TILE5.png")]
      
      private static const IMG_28:Class;
      
      [Embed(source="/assets/NuclearSprite_FRAME_RIGHT_BOTTOM.png")]
      
      private static const FRAME_RIGHT_BOTTOM:Class;
      
      protected static const bitmap17:Bitmap = new IMG_5();
      
      protected static const bitmap14:Bitmap = new IMG_26();
      
      protected static const frameRightBmp:Bitmap = new FRAME_RIGHT();
      
      protected static const bitmap25:Bitmap = new IMG_28();
      
      protected static const frameRightBottomBmp:Bitmap = new FRAME_RIGHT_BOTTOM();
      
      protected static const bitmap23:Bitmap = new Bitmap(Chat.getBitmapData1(bitmap25.bitmapData));
      
      protected static const frameLeftTopBmp:Bitmap = new FRAME_LEFT_TOP();
      
      protected static const bitmap39:Bitmap = new IMG_4();
      
      protected static const frameRightTopBmp:Bitmap = new FRAME_RIGHT_TOP();
      
      protected static const bitmap16:Bitmap = new IMG_10();
      
      protected static const ramDL:Bitmap = new LINE();
      
      protected static const ramDR:Bitmap = new RAM_DL();
      
      protected static const ramSide:Bitmap = new RAM_DR();
      
      protected static const ramTop:Bitmap = new RAM_SIDE();
      
      protected static const ramUL:Bitmap = new RAM_TOP();
      
      protected static const ramUR:Bitmap = new RAM_UL();
      
      protected static const ramBottom:Bitmap = new RAM_UR();
      
      public function NuclearSprite(menuType:int)
      {
         super(menuType);
      }
      
      public static function drawRamFrame(target:UIElement, posX:int, posY:int, frameWidth:int, frameHeight:int) : void
      {
         target.draw(ramUL,posX + 1,posY + 1);
         target.drawTile(ramTop,posX + ramUL.width + 1,posY,frameWidth - ramUL.width - ramUR.width - 2,ramTop.height);
         target.draw(ramUR,posX + frameWidth - ramUR.width - 1,posY + 1);
         target.drawTile(ramSide,posX,posY + ramUL.height + 1,ramSide.width,frameHeight - ramUL.height - ramDL.height - 2);
         target.drawTile(ramSide,posX + frameWidth - ramSide.width,posY + ramUR.height + 1,ramSide.width,frameHeight - ramUR.height - ramDR.height - 2);
         target.draw(ramDL,posX + 1,posY + frameHeight - ramDL.height - 1);
         target.drawTile(ramBottom,posX + ramDL.width + 1,posY + frameHeight - ramBottom.height,frameWidth - ramDL.width - ramDR.width - 2,ramBottom.height);
         target.draw(ramDR,posX + frameWidth - ramDR.width - 1,posY + frameHeight - ramDR.height - 1);
      }
      
      protected function drawTitleBar(posX:int, posY:int, barWidth:int, title:String = null, format:NTextFormat = null) : void
      {
         draw(frameLeftTopBmp,posX,posY);
         drawTile(bitmap39,posX + 3,posY,barWidth - 4,bitmap39.height);
         draw(frameRightTopBmp,posX + barWidth - frameRightTopBmp.width,posY);
         if(title)
         {
            addTextLabel(posX,posY + 11,title,format ? format : NTextFormat.titleFormat,barWidth);
         }
      }
      
      protected function drawHSeparator(posX:int, posY:int, lineWidth:int) : void
      {
         draw(bitmap17,posX,posY);
         drawTile(bitmap14,posX + 6,posY,lineWidth - 12,15);
         draw(frameRightBmp,posX + lineWidth - 6,posY);
      }
      
      protected function drawVSeparator(posX:int, posY:int, lineHeight:int) : void
      {
         draw(bitmap25,posX,posY);
         drawTile(frameRightBottomBmp,posX,posY + 9,14,lineHeight - 18);
         draw(bitmap23,posX,posY + lineHeight - 9);
      }
      
      public function drawRam(posX:int, posY:int, frameWidth:int, frameHeight:int) : void
      {
         drawRamFrame(this,posX,posY,frameWidth,frameHeight);
      }
      
      protected function addDefaultCloseButton(posX:int, posY:int) : NButton
      {
         var button:NButton = new NButton(this.onCloseClick,getBmp("CLOSE_ICON"),getBmp("CLOSE_ICON_OVER"),getBmp("CLOSE_ICON_PRESSED"));
         button.setPos(posX,posY);
         addUIChild(button);
         return button;
      }
      
      protected function onCloseClick(sender:Object) : void
      {
         closeMenu();
      }
      
      protected function drawWindowBg() : void
      {
         drawTile(getBmp("WINDOW_BG"),12,12,Math.min(116,width - 24),height - 24);
      }
   }
}

