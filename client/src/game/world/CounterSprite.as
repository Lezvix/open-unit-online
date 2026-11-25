package game.world
{
   import core.display.NSprite;
   
   public class CounterSprite extends NSprite
   {
      
      private var _maxValueValue:int;
      
      private var intValue130:int = 0;
      
      public function CounterSprite(param1:int = 0)
      {
         super();
         this._maxValueValue = param1;
      }
      
      public function set maxValueValue(param1:int) : void
      {
         _maxValueValue = param1;
         this.update();
      }
      
      public function get maxValueValue() : int
      {
         return this._maxValueValue;
      }
      
      public function set propValue27(param1:int) : void
      {
         intValue130 = param1;
         this.update();
      }
      
      public function get propValue27() : int
      {
         return this.intValue130;
      }
      
      public function update() : void
      {
      }
   }
}

