package core.effects
{
   public class FadeEffect extends TweenEffect
   {
      
      private var _fadeStartAlpha:Object = null;
      
      private var _fadeEndAlpha:Object = null;
      
      public function FadeEffect(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         if(this._fadeStartAlpha != null)
         {
            obj13.alpha = this._fadeStartAlpha;
         }
         else
         {
            obj13.alpha = instance.alpha;
         }
         if(this._fadeEndAlpha != null)
         {
            to.alpha = this._fadeEndAlpha;
         }
         else
         {
            to.alpha = instance.alpha;
         }
      }
      
      override protected function getTweenedProps() : Array
      {
         return ["alpha"];
      }
      
      public function get propValue102() : Number
      {
         return this._fadeStartAlpha as Number;
      }
      
      public function set propValue102(param1:Number) : void
      {
         _fadeStartAlpha = param1;
      }
      
      public function get propValue171() : Number
      {
         return this._fadeEndAlpha as Number;
      }
      
      public function set propValue171(param1:Number) : void
      {
         _fadeEndAlpha = param1;
      }
   }
}

