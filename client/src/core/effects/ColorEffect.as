package core.effects
{
   import fl.motion.easing.Quadratic;
   import flash.geom.ColorTransform;
   
   public class ColorEffect extends TweenEffect
   {
      
      private var _startRedOffset:Number = 0;
      
      private var _endRedOffset:Number = 0;
      
      private var _startGreenOffset:Number = 0;
      
      private var _endGreenOffset:Number = 0;
      
      private var _startBlueOffset:Number = 0;
      
      private var _endBlueOffset:Number = 0;
      
      private var colorEffectTarget:Object;
      
      private var interpolatedColorTransform:ColorTransform;
      
      public function ColorEffect(displayTarget:Object = null)
      {
         super(displayTarget);
         this.colorEffectTarget = displayTarget;
         duration = 1.5;
         this.interpolatedColorTransform = new ColorTransform();
      }
      
      override protected function updateHandler() : void
      {
         var elapsed:Number = propValue156;
         this.interpolatedColorTransform.redOffset = this.startRedOffset + (this.endRedOffset - this.startRedOffset) * elapsed / duration;
         this.interpolatedColorTransform.greenOffset = this.startGreenOffset + (this.endGreenOffset - this.startGreenOffset) * elapsed / duration;
         this.interpolatedColorTransform.blueOffset = this.startBlueOffset + (this.endBlueOffset - this.startBlueOffset) * elapsed / duration;
         this.colorEffectTarget.transform.colorTransform = this.interpolatedColorTransform;
         callback14 = Quadratic.easeOut;
      }
      
      override protected function init() : void
      {
         this.colorEffectTarget.transform.colorTransform = new ColorTransform(1,1,1,this.startRedOffset,this.startGreenOffset,this.startBlueOffset);
         super.init();
      }
      
      override protected function getTweenedProps() : Array
      {
         return ["transform"];
      }
      
      public function get startRedOffset() : Number
      {
         return this._startRedOffset;
      }
      
      public function set startRedOffset(offset:Number) : void
      {
         _startRedOffset = offset;
      }
      
      public function get endRedOffset() : Number
      {
         return this._endRedOffset;
      }
      
      public function set endRedOffset(offset:Number) : void
      {
         _endRedOffset = offset;
      }
      
      public function get startGreenOffset() : Number
      {
         return this._startGreenOffset;
      }
      
      public function set startGreenOffset(offset:Number) : void
      {
         _startGreenOffset = offset;
      }
      
      public function get endGreenOffset() : Number
      {
         return this._endGreenOffset;
      }
      
      public function set endGreenOffset(offset:Number) : void
      {
         _endGreenOffset = offset;
      }
      
      public function get startBlueOffset() : Number
      {
         return this._startBlueOffset;
      }
      
      public function set startBlueOffset(offset:Number) : void
      {
         _startBlueOffset = offset;
      }
      
      public function get endBlueOffset() : Number
      {
         return this._endBlueOffset;
      }
      
      public function set endBlueOffset(offset:Number) : void
      {
         _endBlueOffset = offset;
      }
      
      override public function stop() : void
      {
         this.colorEffectTarget.transform.colorTransform = new ColorTransform();
         super.stop();
      }
   }
}

