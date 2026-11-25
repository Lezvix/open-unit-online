package ui.menus
{
   import flash.text.TextField;
   import ui.NTextFormat;
   
   public class TitledMenu extends NuclearSprite
   {
      
      protected var titleText:TextField;
      
      public function TitledMenu(menuType:int, title:String, menuWidth:int, menuHeight:int, hasCloseButton:Boolean = true)
      {
         super(menuType);
         w = menuWidth;
         h = menuHeight;
         fillBg(4,4,w - 8,h - 8);
         drawFrame(0,0,w,h);
         if(hasCloseButton)
         {
            addDefaultCloseButton(w - 41,15);
         }
         this.titleText = createLabel(16,16,title,NTextFormat.titleFormat,w - 32);
         addChild(this.titleText);
         this.width = w;
         this.height = h;
      }
      
      public function get title() : String
      {
         return this.titleText.text;
      }
      
      public function set title(value:String) : void
      {
         this.titleText.text = value;
      }
   }
}

