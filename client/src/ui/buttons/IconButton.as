package ui.buttons
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class IconButton extends NButton
   {
      
      [Embed(source="/assets/CharacterInfo_HP_BAR.png")]
      
      private static const IMG_29:Class;
      
      [Embed(source="/assets/CharacterInfo_BAR_INF_01.png")]
      
      private static const IMG_24:Class;
      
      public static const ONLINE_ICON:Bitmap = new IMG_29();
      
      public static const OFFLINE_ICON:Bitmap = new IMG_24();
      
      public function IconButton(online:Boolean)
      {
         var icon:Bitmap = online ? ONLINE_ICON : OFFLINE_ICON;
         var sprite:Sprite = new Sprite();
         sprite.graphics.beginBitmapFill(icon.bitmapData);
         sprite.graphics.drawRect(0,0,icon.width,icon.height);
         sprite.graphics.endFill();
         super(null,sprite);
      }
   }
}

