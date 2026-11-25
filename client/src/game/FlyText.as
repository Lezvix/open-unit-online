package game
{
   import core.display.InkText;
   import core.ui.TextStyle;
   import flash.display.Sprite;
   
   public class FlyText extends Sprite
   {
      
      public var waitTicks:int;
      
      public var tick:int;
      
      public var parentObject:Sprite;
      
      private var label:InkText;
      
      public var enabled:Boolean = false;
      
      public function FlyText(param1:Sprite, param2:uint, param3:uint, param4:int)
      {
         super();
         this.waitTicks = 0;
         this.parentObject = param1;
         this.label = new InkText(-1,-1,false,true);
         this.label.setTextFormat(new TextStyle("Verdana",param4,param2),param3);
         addChild(this.label);
      }
      
      public function init(param1:String, param2:int, param3:int = 0) : void
      {
         enabled = true;
         this.waitTicks = param3;
         tick = param2;
         this.label.text = param1;
         this.label.cacheAsBitmap = true;
         if(param3 > 0)
         {
            visible = false;
         }
         else
         {
            visible = true;
         }
         x -= int(this.label.textWidth / 2);
      }
      
      public function process() : void
      {
         if(this.waitTicks > 0)
         {
            --this.waitTicks;
            if(this.waitTicks == 0)
            {
               visible = true;
            }
         }
         else
         {
            --this.tick;
            y -= int(this.tick / 5 + 1);
            if(this.tick <= 0)
            {
               enabled = false;
               visible = false;
            }
         }
      }
   }
}

