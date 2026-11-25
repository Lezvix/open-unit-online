package core.ui
{
   import flash.display.Sprite;
   
   public class SizedSprite extends Sprite
   {
      
      protected var numValue39:Number = 0;
      
      protected var _height:Number = 0;
      
      public function SizedSprite()
      {
         super();
      }
      
      public function setActualSize(param1:Number, param2:Number) : void
      {
         numValue39 = param1;
         _height = param2;
      }
      
      override public function get width() : Number
      {
         return this.numValue39 > 0 ? this.numValue39 : super.width;
      }
      
      override public function set width(param1:Number) : void
      {
         numValue39 = param1;
      }
      
      override public function get height() : Number
      {
         return this._height > 0 ? this._height : super.height;
      }
      
      override public function set height(param1:Number) : void
      {
         _height = param1;
      }
   }
}

