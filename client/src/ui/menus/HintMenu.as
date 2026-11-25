package ui.menus
{
   import ui.buttons.TextLinkButton;
   import flash.text.TextField;
   import game.Client;
   import ui.ScrollSprite;
   import ui.NTextFormat;
   
   public class HintMenu extends TitledMenu
   {
      
      private static const WIDTH:int = 300;
      
      private static const HEIGHT:int = 143;
      
      private const hintQueue:Array = [];
      
      private var closeButton:TextLinkButton;
      
      private var textScroll:ScrollSprite;
      
      private var hintText:TextField;
      
      public function HintMenu(title:String, str:String)
      {
         super(TYPE_HINT," ",WIDTH,HEIGHT,false);
         this.closeButton = new TextLinkButton(onCloseClick,"x",32);
         this.closeButton.y = 1;
         this.closeButton.x = w - 4 - this.closeButton.width;
         addUIChild(this.closeButton);
         this.hintText = createText(0,0,"",NTextFormat.plain.setSize(12),w - 30);
         this.textScroll = new ScrollSprite(w - 20,h - 41);
         this.textScroll.x = 10;
         this.textScroll.y = 35;
         this.textScroll.addLine(this.hintText);
         addUIChild(this.textScroll);
         titleText.y -= 4;
         this.loadAllPals(title,str);
      }
      
      override public function fillBg(posX:int, posY:int, rectWidth:int, rectHeight:int, bgAlpha:Number = 1) : void
      {
      }
      
      public function pendingQueue(title:String, str:String) : void
      {
         this.hintQueue.unshift({
            "title":title,
            "text":str
         });
      }
      
      override public function closeMenu() : void
      {
         var hint:Object = null;
         if(this.hintQueue.length > 0)
         {
            hint = this.hintQueue.pop();
            this.loadAllPals(hint.title,hint.text);
         }
         else
         {
            super.closeMenu();
         }
      }
      
      override public function drawFrame(posX:int, posY:int, frameWidth:int, frameHeight:int) : void
      {
         graphics.beginFill(1776411,8 / 10);
         graphics.lineStyle(1,16688932,2 / 3);
         graphics.drawRect(0,0,frameWidth,frameHeight);
         graphics.endFill();
      }
      
      private function loadAllPals(title:String, str:String) : void
      {
         this.title = title.replace("*НИК*",Client.currentCharacter.name);
         this.hintText.text = str.replace("*НИК*",Client.currentCharacter.name);
         this.hintText.height = this.hintText.textHeight + 4;
         if(this.hintText.height <= this.textScroll.height)
         {
            this.textScroll.visible = false;
            if(this.hintText.parent !== this)
            {
               this.textScroll.clear();
               this.hintText.x = this.textScroll.x;
               this.hintText.y = this.textScroll.y;
               addChild(this.hintText);
            }
         }
         else
         {
            if(this.hintText.parent === this)
            {
               removeChild(this.hintText);
               this.hintText.x = 0;
               this.hintText.y = 0;
               this.textScroll.addLine(this.hintText);
            }
            this.textScroll.init(this.hintText.height);
            this.textScroll.visible = true;
         }
      }
   }
}

