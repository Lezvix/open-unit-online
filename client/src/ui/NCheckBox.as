package ui
{
   import ui.buttons.NButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class NCheckBox extends NButton
   {
      
      [Embed(source="/assets/NCheckBox_BACKGROUND.png")]
      
      public static var BACKGROUND:Class;
      
      [Embed(source="/assets/NCheckBox_BACKGROUND_DISABLED.png")]
      
      public static var BACKGROUND_DISABLED:Class;
      
      [Embed(source="/assets/NCheckBox_MARK.png")]
      
      public static var MARK:Class;
      
      [Embed(source="/assets/NCheckBox_RADIO_BACKGROUND.png")]
      
      public static var RADIO_BACKGROUND:Class;
      
      [Embed(source="/assets/NCheckBox_RADIO_MARK.png")]
      
      public static var RADIO_MARK:Class;
      
      public static var CHECK_WIDTH:int = 16;
      
      public static var CHECK_HEIGHT:int = 16;
      
      public static var TYPE_DEFAULT:int = 0;
      
      public static var TYPE_CIRCLE:int = 1;
      
      private var isChecked:Boolean;
      
      private var isHighlight:Boolean;
      
      private var checkSprite:Sprite;
      
      private var markBmp:Bitmap;
      
      private var bgBmp:Bitmap;
      
      private var bgDisabledBmp:Bitmap = null;
      
      private var type:int;
      
      private var _elabled:Boolean = true;
      
      public function NCheckBox(param1:Function, param2:Object = null, param3:int = 0)
      {
         this.type = param3;
         if(param3 == TYPE_DEFAULT)
         {
            this.bgDisabledBmp = new BACKGROUND_DISABLED();
            this.bgBmp = new BACKGROUND();
         }
         else
         {
            this.bgBmp = new RADIO_BACKGROUND();
         }
         this.checkSprite = new Sprite();
         this.checkSprite.addChild(this.bgBmp);
         super(param1,this.checkSprite,this.checkSprite,this.checkSprite);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(enabled)
         {
            this.checkSprite.removeChild(this.bgBmp);
         }
         else
         {
            this.checkSprite.removeChild(this.bgDisabledBmp);
         }
         super.enabled = param1;
         if(enabled)
         {
            this.checkSprite.addChildAt(this.bgBmp,0);
         }
         else
         {
            this.checkSprite.addChildAt(this.bgDisabledBmp,0);
         }
      }
      
      public function get highlight() : Boolean
      {
         return this.isHighlight;
      }
      
      public function set highlight(param1:Boolean) : void
      {
         isHighlight = param1;
      }
      
      public function get checked() : Boolean
      {
         return this.isChecked;
      }
      
      override public function dispose() : void
      {
         if(this.markBmp)
         {
            this.markBmp.bitmapData.dispose();
         }
         this.bgBmp.bitmapData.dispose();
         if(this.bgDisabledBmp != null)
         {
            this.bgDisabledBmp.bitmapData.dispose();
         }
         super.dispose();
      }
      
      public function set checked(param1:Boolean) : void
      {
         if(param1)
         {
            if(!this.markBmp)
            {
               if(this.type == TYPE_DEFAULT)
               {
                  markBmp = new MARK();
               }
               else
               {
                  markBmp = new RADIO_MARK();
                  this.markBmp.x = 4;
                  this.markBmp.y = 4;
               }
               this.checkSprite.addChild(this.markBmp);
            }
         }
         else if(this.markBmp)
         {
            this.checkSprite.removeChild(this.markBmp);
            this.markBmp.bitmapData.dispose();
            markBmp = null;
         }
         isChecked = param1;
      }
   }
}

