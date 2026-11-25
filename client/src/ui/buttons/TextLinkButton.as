package ui.buttons
{
   import flash.text.TextField;
   import ui.NTextFormat;
   
   public class TextLinkButton extends NButton
   {
      
      protected var tf:TextField = new TextField();
      
      protected var maxWidth:int;
      
      public function TextLinkButton(param1:Function, param2:String, param3:int, param4:int = 10)
      {
         this.maxWidth = param3;
         this.tf.multiline = true;
         this.tf.wordWrap = true;
         this.tf.defaultTextFormat = NTextFormat.plain.derive({"size":param4});
         this.text = param2;
         mouseOverCallback = this.doAction897;
         mouseOutCallback2 = this.doAction133;
         super(param1,this.tf);
      }
      
      public function get text() : String
      {
         return this.tf.text;
      }
      
      public function set text(param1:String) : void
      {
         this.tf.width = this.maxWidth;
         this.tf.text = param1;
         this.tf.height = this.tf.textHeight + 5;
         this.tf.width = Math.min(this.maxWidth,this.tf.textWidth + 5);
      }
      
      protected function doAction897(param1:Object) : void
      {
         this.tf.textColor = uint(NTextFormat.normal.color);
      }
      
      protected function doAction133(param1:Object) : void
      {
         this.tf.textColor = uint(NTextFormat.plain.color);
      }
   }
}

