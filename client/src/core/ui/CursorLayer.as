package core.ui
{
   import flash.display.Sprite;
   
   public class CursorLayer extends Sprite
   {
      
      protected var data:Object;
      
      public function CursorLayer()
      {
         super();
      }
      
      public function clearAll() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         graphics.clear();
      }
      
      public function setData(param1:Object, param2:Boolean) : void
      {
         this.data = param1;
         this.clearAll();
         this.draw(param2);
      }
      
      public function draw(param1:Boolean) : void
      {
      }
   }
}

