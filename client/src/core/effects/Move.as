package core.effects
{
   import fl.motion.easing.Linear;
   
   public class Move extends TweenEffect
   {
      
      private var _xBy:int = 0;
      
      private var _yBy:int = 0;
      
      private var _xFrom:Object = null;
      
      private var _yFrom:Object = null;
      
      private var _xTo:Object = null;
      
      private var _yTo:Object = null;
      
      public function Move(target:Object = null)
      {
         super(target);
         callback14 = Linear.easeNone;
      }
      
      override protected function getTweenedProps() : Array
      {
         return ["x","y"];
      }
      
      public function get xBy() : int
      {
         return this._xBy;
      }
      
      public function set xBy(value:int) : void
      {
         _xBy = value;
      }
      
      public function get yBy() : int
      {
         return this._yBy;
      }
      
      public function set yBy(value:int) : void
      {
         _yBy = value;
      }
      
      override protected function init() : void
      {
         super.init();
         if(this._xFrom != null || this._xTo != null || this._xBy != 0)
         {
            if(this._xFrom != null)
            {
               obj13.x = this._xFrom;
            }
            else
            {
               obj13.x = instance.x;
            }
            if(this._xTo != null)
            {
               to.x = this._xTo;
            }
            else
            {
               to.x = instance.x;
            }
         }
         if(this._yFrom != null || this._yTo != null || this._yBy != 0)
         {
            if(this._yFrom != null)
            {
               obj13.y = this._yFrom;
            }
            else
            {
               obj13.y = instance.y;
            }
            if(this._yTo != null)
            {
               to.y = this._yTo;
            }
            else
            {
               to.y = instance.y;
            }
         }
         if(this._xBy != 0)
         {
            to.x = instance.x + this._xBy;
         }
         if(this._yBy != 0)
         {
            to.y = instance.y + this._yBy;
         }
      }
      
      public function get xFrom() : Number
      {
         return this._xFrom as Number;
      }
      
      public function set xFrom(value:Number) : void
      {
         _xFrom = value;
      }
      
      public function get yFrom() : Number
      {
         return this._yFrom as Number;
      }
      
      public function set yFrom(value:Number) : void
      {
         _yFrom = value;
      }
      
      public function get xTo() : Number
      {
         return this._xTo as Number;
      }
      
      public function set xTo(value:Number) : void
      {
         _xTo = value;
      }
      
      public function get yTo() : Number
      {
         return this._yTo as Number;
      }
      
      public function set yTo(value:Number) : void
      {
         _yTo = value;
      }
   }
}

